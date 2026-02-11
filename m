Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49B52EB596B
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 07:18:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vq4UZ-0002t6-2S; Wed, 11 Feb 2026 02:18:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vq4UY-0002se-CR
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 02:18:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vq4UW-0003ox-V6
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 02:18:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770794308;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=i4aeXpQfh5J8RsHhlPAbJJTzYCf1RoIBW0ly5yk177A=;
 b=SwQpjWcSaeg2eJm++mSrcOzRluYl4FvCNzTCDyN7+UJx2osfaOxEMFcF18UNImARsb9Z8A
 HL8nXVSmFqvPs0JUbOhEGopCTumgBKhwdEOrvBLtN5rdf2ZS5zIkRso4ue1r33KUsmCpxS
 7qmKjwDBPksd7SQ2fdEW503luINAqiI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-221-c4oheyi7PM6RQe4CmT6RjQ-1; Wed,
 11 Feb 2026 02:18:26 -0500
X-MC-Unique: c4oheyi7PM6RQe4CmT6RjQ-1
X-Mimecast-MFC-AGG-ID: c4oheyi7PM6RQe4CmT6RjQ_1770794305
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 973651800259
 for <qemu-devel@nongnu.org>; Wed, 11 Feb 2026 07:18:25 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.15])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 577BE180066D
 for <qemu-devel@nongnu.org>; Wed, 11 Feb 2026 07:18:25 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B8E9721E692D; Wed, 11 Feb 2026 08:18:22 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 5/5] json-parser: add location to JSON parsing errors
In-Reply-To: <f5cfed0d-3425-4bdc-90f7-1dd2fa33b448@redhat.com> (Paolo
 Bonzini's message of "Tue, 10 Feb 2026 10:44:31 +0100")
References: <20260107084840.150843-1-pbonzini@redhat.com>
 <20260107084840.150843-6-pbonzini@redhat.com>
 <87cy2d7y3y.fsf@pond.sub.org>
 <f5cfed0d-3425-4bdc-90f7-1dd2fa33b448@redhat.com>
Date: Wed, 11 Feb 2026 08:18:22 +0100
Message-ID: <87seb73g01.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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

> On 2/10/26 10:21, Markus Armbruster wrote:
>>> - *
>>> - * 0) make errors meaningful again
>> 
>> The errors weren't meaningless, just bad.  The "again" is kind of funny,
>> considering it's the initial commit.
>> 
>> I agree with removing the line, but i wonder what exactly improved
>> beyond line and column ("geometry information").
>
> I think it's more of a reference to the error recovery.  There's only so 
> many ways to report errors for a grammar as simple as JSON.

Point!

> But just for kicks I looked at the very first implementation and the 
> current state, and diff-ed the errors.  These are the differences:
>
> renamed:
> "expected separator in dict" -> "expected ',' or '}'"
> "expected separator in list" -> "expected ',' or ']'"
> "missing : in object pair" -> "expected ':'"
>
> removed (merged with "expecting value" or "premature end of input"):
> "Missing value in dict"
>
> split (out of just "expecting value"):
> "invalid interpolation '%s'"

Improvements.

> new errors:
> "can't interpolate into string"
> "%.*s is not a valid Unicode character"
> "duplicate key"
> "invalid UTF-8 sequence in string"
> "premature end of input"

Bug fixes :)

Thanks!

> So I don't know if they're "meaningful again", but there were some 
> changes over the years and the current set seems good enough to me!

Yes.  And further improvement, if desired, wouldn't be this series' job
anyway.


