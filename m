Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5442C3ABB2
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 10:45:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKEHF-0007jP-HU; Wed, 28 May 2025 06:44:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uKEHD-0007iF-0f
 for qemu-devel@nongnu.org; Wed, 28 May 2025 06:44:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uKEHA-00068s-78
 for qemu-devel@nongnu.org; Wed, 28 May 2025 06:44:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748429087;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L3M8RQ6pt554/5XiE3EJ8AM/i9Osw4wci+Lrks8oazM=;
 b=EWzswZ7HK3Z+Oim2pgyxs6JV7xr4aZ+KJrWhSXbMrvZ2pqE4FEFWEIaElNQ2YrsI4Wh9sz
 6cyxcANmo18U3SCIqr6SPKxCujm/OEeyr4XmMWJ/MXHiDJ+uNtIM+8dj3DVfeZCivG3v4H
 wjOOk4CLEYmy/IyfLJ8hnGHg9mxjbSk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-681-Hw-j0QqvNgiBj8nWtpvkkQ-1; Wed,
 28 May 2025 06:44:45 -0400
X-MC-Unique: Hw-j0QqvNgiBj8nWtpvkkQ-1
X-Mimecast-MFC-AGG-ID: Hw-j0QqvNgiBj8nWtpvkkQ_1748429085
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C47771955E79; Wed, 28 May 2025 10:44:44 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.2])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4F8D918001D8; Wed, 28 May 2025 10:44:44 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7C5E221E6757; Wed, 28 May 2025 12:44:41 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,  qemu-rust@nongnu.org
Subject: Re: [PATCH 05/12] util/error: allow non-NUL-terminated err->src
In-Reply-To: <feb8251e-715f-4de7-a390-eb5b053de0f6@redhat.com> (Paolo
 Bonzini's message of "Tue, 27 May 2025 16:34:11 +0200")
References: <20250526142254.1061009-1-pbonzini@redhat.com>
 <20250526142455.1061519-5-pbonzini@redhat.com>
 <87sekqmapy.fsf@pond.sub.org>
 <feb8251e-715f-4de7-a390-eb5b053de0f6@redhat.com>
Date: Wed, 28 May 2025 12:44:41 +0200
Message-ID: <87y0uhc8va.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.907,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 5/27/25 15:42, Markus Armbruster wrote:
>> Paolo Bonzini <pbonzini@redhat.com> writes:
>>=20
>>> Rust makes the current file available as a statically-allocated string,
>>> but without a NUL terminator.  Allow this by storing an optional maximum
>>> length in the Error.
>>>
>>> Note that for portability I am not relying on fprintf's precision
>>> specifier not accessing memory beyond what will be printed.
>> Can you elaborate on the portability problem?  I figure ...
>>=20
>>>   {
>>>       if (errp =3D=3D &error_abort) {
>>> +        const char *src =3D err->src;
>>> +        if (err->src_len >=3D 0) {
>>> +            /* No need to free it, the program will abort very soon...=
  */
>>> +            src =3D g_strndup(err->src, err->src_len);
>>> +        }
>>>           fprintf(stderr, "Unexpected error in %s() at %s:%d:\n",
>>> -                err->func, err->src, err->line);
>>> +                err->func, src, err->line);
>> ... you're avoiding the simpler
>>             fprintf(stderr, "Unexpected error in %s() at %.*s:%d:\n",
>>                     err->func, err->src_len, err->src, err->line);
>> because of it.
>
> I couldn't find anything that says %s is allowed to not be NUL-terminated=
 if a precision is given.  That is, whether something like this:
>
>    char foo[] =3D {'H', 'e', 'l', 'l', 'o'};
>    printf("%.5s\n", foo);
>
> is guaranteed to work.

From ISO/IEC 9899:1999 =C2=A77.19.6.1 "The fprintf function":

       [#8] The conversion specifiers and their meanings are:
       [...]
       s       If  no  l  length  modifier is present, the argument
               shall be a pointer to  the  initial  element  of  an
               array of character  type.237)  Characters  from  the
               array  are  written  up  to  (but not including) the
               terminating null character.   If  the  precision  is
               specified, no more than that many bytes are written.
-->            If the precision is not specified or is greater than
-->            the  size  of  the  array, the array shall contain a
-->            null character.

       ____________________

       237No  special provisions are made for multibyte characters.

This clearly implies that the string need not be null-terminated when a
suitable precision is specified.  Which it is here.

> This is opposed to:
>
> 1) strnlen (https://pubs.opengroup.org/onlinepubs/9699919799/functions/st=
rnlen.html), which is guaranteed to examine no more than the number of byte=
s given by the second character;
>
> 2) strndup, for which I found at least a clarification at https://www.aus=
tingroupbugs.net/view.php?id=3D1397.
>
> 3) g_strndup, which guarantees that the allocated block is of length n+1 =
and padded with NULs (though in the case above there will be just one NUL a=
nyway)
>
> And also, for strndup/g_strndup it would be quite asinine to implement it=
 using some kind of min(strlen(s), n) but for printf the complexity is grea=
ter so you never know.  I erred on the side of caution because avoiding an =
allocation before an abort() isn't particularly interesting.

Keeping the code simple is always interesting, though :)


