Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A110C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2024 07:57:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sby1O-0006xN-Uw; Thu, 08 Aug 2024 03:57:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sby1K-0006sw-TM
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 03:57:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sby1J-0008Ia-CV
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 03:57:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723103832;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IGVQaPpa4MM416kbevD3IjdsqVCxTJKzpbhOlw6/CHo=;
 b=hfCDWFEKH8213Ezm9ns06/FLAYFNdbLTpF8uvkfEVJlOWxQGJNq6e8d2dqCqqEgll6klPK
 2eo45PrYmQn2BN2GCQRys5B4+2g8xZrjuxA9p6T2asvlQKDyzylzp1pvXcWQs5WyJ1vyO6
 yyhbD1j0/PygjsgWfuDwWHHyjIU1ylc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-624-yCB0IX6xNwesfwhMC90u-Q-1; Thu,
 08 Aug 2024 03:57:08 -0400
X-MC-Unique: yCB0IX6xNwesfwhMC90u-Q-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DDE431935D11; Thu,  8 Aug 2024 07:57:07 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.245])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 850E41955F2E; Thu,  8 Aug 2024 07:57:06 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0447221E6692; Thu,  8 Aug 2024 09:57:04 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: Eric Blake <eblake@redhat.com>,  qemu-devel@nongnu.org,
 qemu-block@nongnu.org,  rjones@redhat.com
Subject: Re: [PATCH 1/2] util: Refactor json-writer's string sanitizer to be
 public
In-Reply-To: <ZrPBvOSrLjgTNlV3@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Wed, 7 Aug 2024 19:49:32 +0100")
References: <20240802194156.2131519-4-eblake@redhat.com>
 <20240802194156.2131519-5-eblake@redhat.com>
 <ZrPBvOSrLjgTNlV3@redhat.com>
Date: Thu, 08 Aug 2024 09:57:03 +0200
Message-ID: <87a5hn4fcg.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Fri, Aug 02, 2024 at 02:26:05PM -0500, Eric Blake wrote:
>> My next patch needs to convert text from an untrusted input into an
>> output representation that is suitable for display on a terminal is
>> useful to more than just the json-writer; the text should normally be
>> UTF-8, but blindly allowing all Unicode code points (including ASCII
>> ESC) through to a terminal risks remote-code-execution attacks on some
>> terminals.  Extract the existing body of json-writer's quoted_strinto
>> a new helper routine mod_utf8_sanitize, and generalize it to also work
>> on data that is length-limited rather than NUL-terminated.  [I was
>> actually surprised that glib does not have such a sanitizer already -
>> Google turns up lots of examples of rolling your own string
>> sanitizer.]
>>=20
>> If desired in the future, we may want to tweak whether the output is
>> guaranteed to be ASCII (using lots of \u escape sequences, including
>> surrogate pairs for code points outside the BMP) or if we are okay
>> passing printable Unicode through (we still need to escape control
>> characters).  But for now, I went for minimal code churn, including
>> the fact that the resulting function allows a non-UTF-8 2-byte synonym
>> for U+0000.
>>=20
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> ---
>>  include/qemu/unicode.h |  3 ++
>>  qobject/json-writer.c  | 47 +----------------------
>>  util/unicode.c         | 84 ++++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 88 insertions(+), 46 deletions(-)
>
> I was going to ask for a unit test, but "escaped_string" in
> test-qjson.c  looks like it will be covering this sufficiently

check-qjson.c, and other test cases torture it some more.

> well already, that we don't need to test it in isolation.
>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>
>
> With regards,
> Daniel


