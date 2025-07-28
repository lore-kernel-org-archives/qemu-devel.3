Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D03DC83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Jul 2025 11:55:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugLz0-0002dg-T5; Mon, 28 Jul 2025 07:25:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ugLmu-0005j5-SF
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 07:13:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ugLmr-0003oz-T2
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 07:13:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753701175;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lCBkbt9Bt5a8/WEwDE6+o6sBDNtWzq2jPvybl068pRs=;
 b=VGbLPORVRU2BHmS/hlQqMPz1RPJcXBjUdtcp4y/MluHoxR9yAtBefCiocacjJypq3jRQL2
 vi4Q7m70CMOFjG16N4/XFgEaBp4HofY1ZY4gJQ+7haHD0jx5TDPTHpPu/InU0chL1s0hAo
 oLk3eMdJqDanjjx6fZ4N1MZCRl4mH/8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-148-I5bhsrZQMgahyIfJb8D3Ng-1; Mon,
 28 Jul 2025 07:12:52 -0400
X-MC-Unique: I5bhsrZQMgahyIfJb8D3Ng-1
X-Mimecast-MFC-AGG-ID: I5bhsrZQMgahyIfJb8D3Ng_1753701171
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 184F8195608B; Mon, 28 Jul 2025 11:12:51 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.14])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A967419560A2; Mon, 28 Jul 2025 11:12:50 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0144F21E6A27; Mon, 28 Jul 2025 13:12:47 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org,  Yan
 Vugenfirer <yvugenfi@redhat.com>,  Daniel =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>
Subject: Re: [PATCH] util: win32: Write hex value when can't get error message
In-Reply-To: <CAPMcbCp5BuLADQoDijw811G4-u-ssBJ+eFrzyiU8_G9Tr7uLHA@mail.gmail.com>
 (Kostiantyn Kostiuk's message of "Fri, 25 Jul 2025 12:59:00 +0300")
References: <20250717145948.77870-1-kkostiuk@redhat.com>
 <87pldwbspt.fsf@pond.sub.org>
 <CAPMcbCp=PBMSxtTxCMkxigdovaY=MTNLRo6f3BBXNRT6vu4wmw@mail.gmail.com>
 <87seipkif5.fsf@pond.sub.org>
 <CAPMcbCrTTkr5sX11wn1WaXOLgqQTAD-1oxUuqOc+oEmUxcotkw@mail.gmail.com>
 <c3afe3f5-962d-40ba-a778-716ef9929053@linaro.org>
 <CAPMcbCp5BuLADQoDijw811G4-u-ssBJ+eFrzyiU8_G9Tr7uLHA@mail.gmail.com>
Date: Mon, 28 Jul 2025 13:12:47 +0200
Message-ID: <87ecu0r2kw.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Kostiantyn Kostiuk <kkostiuk@redhat.com> writes:

> Issue reported to GLib https://gitlab.gnome.org/GNOME/glib/-/issues/3740
> PR with fix https://gitlab.gnome.org/GNOME/glib/-/merge_requests/4716
>
> @Markus Armbruster <armbru@redhat.com>
> Based on the documentation from this PR, do you have any other objections
> to this patch?

I can't see that the commit invalidates my objection.

The revised contract still specifies the error code comes from
GetLastError() or WSAGetLastError().  Passing anything else still
violates it.

What can go wrong when we pass some other integer?

Say we pass EINVAL.  It's 22 on Linux.  Interpreted as Windows system
error code (the thing GetLastError() returns), that's ERROR_BAD_COMMAND,
documented as "The device does not recognize the command."[*].
g_win32_error_message() and thus error_setg_win32() will report
confusing nonsense.

Another common integer error code is -1.  This isn't a valid Windows
system error code, so we can expect to hit the "unknown Windows error"
branch.

Perhaps the code is so confused about error codes that passing them to
an appropriate function is impractical, and taking our chances with
g_win32_error_message() is the best we can do.  Wouldn't exactly inspire
confidence in the soundness of QEMU's Windows code.




[*] https://learn.microsoft.com/en-us/windows/win32/debug/system-error-codes--0-499-


