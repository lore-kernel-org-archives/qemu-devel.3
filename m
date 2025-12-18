Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BF51D68BF6
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Dec 2025 08:49:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vW9hO-0001Dc-1S; Thu, 18 Dec 2025 03:49:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vW9hI-0001Cd-5X
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 03:49:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vW9hF-0003AK-4a
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 03:49:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766047756;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=E3Smmd8mt/DKblta/sNLoWME5GxV7PYjo3wfpy3lvls=;
 b=QGoC99ViSBBLposbcmSVrTmotfP7LmAdoWew95T0rb3tZuOKbtnYMjikNu4d8bIfSKjr0e
 cDnAHgUgcAEAFnfI+art5CBuEdC6Yv6TtkhcWq5SYRwVB/jIzTITc4N2Y9PKXrb/it5Jc1
 +M/PvUSOXkabuvS1s6Colq+/xx4tTgk=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-186-KVCW-FQqONOpkOjxwr2arQ-1; Thu, 18 Dec 2025 03:49:14 -0500
X-MC-Unique: KVCW-FQqONOpkOjxwr2arQ-1
X-Mimecast-MFC-AGG-ID: KVCW-FQqONOpkOjxwr2arQ_1766047753
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-7b89ee2c1a4so920976b3a.2
 for <qemu-devel@nongnu.org>; Thu, 18 Dec 2025 00:49:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766047753; x=1766652553; darn=nongnu.org;
 h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=E3Smmd8mt/DKblta/sNLoWME5GxV7PYjo3wfpy3lvls=;
 b=T/Gd75AoVm6bNckw/JFQNO5r/tpS4mO1u/gA8irNnf4kZTX730NVWsdaMtydyq2sqG
 U7zjjgcMQHgW950NVGRNECqWg28Cai/C5xOC97JZrNkpDcI7Tppzu/t9z4osd5Y5l5Zj
 W+I1v1Tx310zM5TzKqlqUjX/iyNto+L3bNUGMwFH9DbPsxZth7zwWGFwdhnAPF586O4x
 uBklj9DILq8V/mD72qRa5rA0CpwRtSmx92x3mF0Kn5649UMXX0kPqtr90eq2HqF0hNpj
 GOKRhKZD2kiIw+dlBtQ59jb5FO6HFxKGqR8qJmwuF6gfOIQSpwDI1DnjQSLd9exrEypa
 nNgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766047753; x=1766652553;
 h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=E3Smmd8mt/DKblta/sNLoWME5GxV7PYjo3wfpy3lvls=;
 b=rp7JDkuC+8fyBaEahQbbg/Ho03DMcUy1N53cEHyUXrmtGw7yIrGSIcq/K0S5HshMLo
 ZjuGyagQR7zaxiA5DDwfAz6s7r0OWvg2/o/o496FTl6RfGNh/e9wK1RcNfOVP8zHtRm/
 SA0NRUjJERgtgqndJGLgjn0qp6gbtcibRJfE+W525TW0ePOjCLUCwgU+fagmBkNbYGyx
 GFbFuFDJR5II0tvkhINlJ/mPwhRLpRmERjR0KI6UKibrJ6Fgcr8DwyiYRiV8GC7iMA70
 4Fx+6C1JeVDSTC7OMJGo10xgEDt18MqwliqlZviqXvAWFXIFYYDpMEZF+2la6/qA47Lx
 KQWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCULUepkpiwWpy2+t+Xp+Q29lPqpwUv2iC1aOd2Qo7yZjTbpFOzUz3j0UW6+0h3iugmvWcTK7RW48A6E@nongnu.org
X-Gm-Message-State: AOJu0YwVEW5MLnmFQ5iwzsRSrB7d/GguNlMWRottQgzTZEZa65l5Sof0
 bz1I9D7bAu+ljOVdcmFt+zRb9qV8fWrXilQ0E4SlRM2aevbfpHUjm9pOozpTOonGEVcZkMo3yQE
 v9osEZDAV6sUFcbOgrNeMZNuMP8b6yjhpNu7oSFERcpVcu0jKW6myPDAD
X-Gm-Gg: AY/fxX4Cmwd4pkMzSeUZhxyfK8McH1fkr1TQhUeeeAna26Knc5wQsFsZJzV1QMkSWL2
 bGN1Dfjs1S03wYcDt/qP+k0v2+JIO1wgyzMRN5DFKN7WX76Cz93Na+/Nu2kAqYm82r7c3XBQeCS
 SSBH3NTh2nSB/KMeXS1UG+JWKbA2B68Yll6hup6XrpEVNPwaOKgjXALOVtyvVN3R25IYUgyh81O
 jxBrdx6vw+q0KSyOUnOGM8G4OLIz/RgEf+aEnBTYKIp7GL0lsHh3dRgqAxRcW+DGQmhj8A4Kmgj
 NcaJgZsFqPWA/OPFhhO2DKHnuPfPdxqqp3Zv/AD4Dd7z2NBArCaLQQ2Mym3+QbzuvvNhH0VHtGl
 SxsCHqF1DGYVyyXTkRaGkvLRMm1xcoSsaTTkceQ==
X-Received: by 2002:a05:6a20:9147:b0:366:14ac:8c6b with SMTP id
 adf61e73a8af0-369b04c6afbmr22270424637.65.1766047753151; 
 Thu, 18 Dec 2025 00:49:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGl6QZqKLbeG+27cLeEMo1auqdiS2FC+o/5/xhV6DvEZN7/DFBfxJmABO1JpZAZHnrteg65Qw==
X-Received: by 2002:a05:6a20:9147:b0:366:14ac:8c6b with SMTP id
 adf61e73a8af0-369b04c6afbmr22270409637.65.1766047752772; 
 Thu, 18 Dec 2025 00:49:12 -0800 (PST)
Received: from fc40 ([27.58.53.10]) by smtp.googlemail.com with ESMTPSA id
 41be03b00d2f7-c1d2fa22a1bsm1679655a12.21.2025.12.18.00.49.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Dec 2025 00:49:12 -0800 (PST)
Date: Thu, 18 Dec 2025 14:19:07 +0530 (IST)
From: Ani Sinha <anisinha@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
cc: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 vkuznets@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org
Subject: Re: [PATCH v1 13/28] i386/tdx: finalize TDX guest state upon reset
In-Reply-To: <ubmc2igckwxxpgw3zq7lmrhztygazibobjq3ruuhr3kbuzhfpr@odnoz7izs4hn>
Message-ID: <b18a18b8-0bc7-926e-d5ba-52f304db63da@redhat.com>
References: <20251212150359.548787-1-anisinha@redhat.com>
 <20251212150359.548787-14-anisinha@redhat.com>
 <ubmc2igckwxxpgw3zq7lmrhztygazibobjq3ruuhr3kbuzhfpr@odnoz7izs4hn>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



On Wed, 17 Dec 2025, Gerd Hoffmann wrote:

> On Fri, Dec 12, 2025 at 08:33:41PM +0530, Ani Sinha wrote:
> > When the confidential virtual machine KVM file descriptor changes due to the
> > guest reset, some TDX specific setup steps needs to be done again. This
> > includes finalizing the inital guest launch state again. This change
> > re-executes some parts of the TDX setup during the device reset phaze using a
> > resettable interface. This finalizes the guest launch state again and locks
> > it in. Also care has been taken so that notifiers are installed only once.
>
> > +    if (!notifier_added) {
> > +        qemu_add_machine_init_done_notifier(&tdx_machine_done_notify);
> > +        notifier_added = true;
> > +    }
>
> Is this notifier needed still if you finalize the initial guest state in
> the reset handler?
>

Yes good point. Following small change will be needed.

From 59e1df5f3c64a75a14139c498106a225bf3b42b2 Mon Sep 17 00:00:00 2001
From: Ani Sinha <anisinha@redhat.com>
Date: Thu, 18 Dec 2025 14:11:40 +0530
Subject: [PATCH] i386/tdx: remove notifier that is not needed

Take Gerd's suggestion.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 target/i386/kvm/tdx.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index 20f9d63eff..144020e378 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -392,7 +392,7 @@ static void tdx_finalize_vm(Notifier *notifier, void *unused)

 static void tdx_handle_reset(Object *obj, ResetType type)
 {
-    if (!runstate_is_running()) {
+    if (!runstate_is_running() && !phase_check(PHASE_MACHINE_READY)) {
         return;
     }

@@ -429,9 +429,6 @@ static NotifierWithReturn tdx_vmfd_pre_change_notifier = {
     .notify = set_tdx_vm_uninitialized,
 };

-static Notifier tdx_machine_done_notify = {
-    .notify = tdx_finalize_vm,
-};

 /*
  * Some CPUID bits change from fixed1 to configurable bits when TDX module
@@ -778,7 +775,6 @@ static int tdx_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
     kvm_readonly_mem_allowed = false;

     if (!notifier_added) {
-        qemu_add_machine_init_done_notifier(&tdx_machine_done_notify);
         kvm_vmfd_add_pre_change_notifier(&tdx_vmfd_pre_change_notifier);
         notifier_added = true;
     }
-- 
2.42.0


