Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3145EEDF04B
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 06:27:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqQ9g-0007pK-6R; Thu, 12 Feb 2026 01:26:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vqQ9c-0007mS-AU
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 01:26:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vqQ9a-0005Fs-Vl
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 01:26:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770877578;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3B3ktj7wTRZtGaUxqIgngJ0a4ysK1is7v0SePu1Te4o=;
 b=bt75U2CwOV9ih5WAGbX2YEHDxZnauE0fMMdtiSxX8MxhrNOmHj9G9J/1oz0rrqPl2vPBe6
 BgbFpVGCGraqSdKeqelvSHY6SiftZICC9Rfn0Ty2oCs1WCWKenFV4MRxG9PG9tumyPacg7
 PZxQXoY32u31y+LfIW9iCsshgSNjuHU=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-6-kAIUa2EiMAmMbYyDrXAF3A-1; Thu, 12 Feb 2026 01:26:14 -0500
X-MC-Unique: kAIUa2EiMAmMbYyDrXAF3A-1
X-Mimecast-MFC-AGG-ID: kAIUa2EiMAmMbYyDrXAF3A_1770877574
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-35449510446so2831354a91.0
 for <qemu-devel@nongnu.org>; Wed, 11 Feb 2026 22:26:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770877574; x=1771482374; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3B3ktj7wTRZtGaUxqIgngJ0a4ysK1is7v0SePu1Te4o=;
 b=V7n82+V4nqq+mVamQJf5N3zrAyiV7dPc/yBpQtonst1gjnf/K0C8z6GEqUgu2nK2Dr
 Vh1PaTB6AtxEC+PpoKfFxGZb/uQ8WE5ro5DHe+AZ9SO1W5ai5X2rLdo2txe5mc9Hm6Yp
 KLSZ7P67onU1/Mk/b2sedRuoqiGh3eU1w2AYVOM6g5n7HERGH5X+8tZqKwT1asGWDmJ2
 alRtNx00E9/UTlDDKpNiDuFmkMDPkIGN8BZmTmWBO4FU1H/1QPUxMqi6tYCOeP1Z/yBY
 IBWAjtOfLjledFA1CtI9I6Di+YQROgXj47v3rMrI5SGQBtzG6qlesKp6ojD0Mi0lUFFf
 Fc5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770877574; x=1771482374;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3B3ktj7wTRZtGaUxqIgngJ0a4ysK1is7v0SePu1Te4o=;
 b=A+669BJIGARS1sr9vXeZ6nqEA2CjK5iA3H9KtbE6EMxoX/y/Pe0l43NX60wPaYxSZ9
 sjYYxIMNbpoLxlX408gqVXOLW9LZVURKSP3Y8MVrDDfcSHMgdOmkHK+AS5hjo5To0DMk
 1gRTM8f/4FpGwkZYPhRQhCERGkbulRZfM7v237jRg5DJnvsKkWIZVqh2PGt4El89PweE
 q8Q0X5tSv1SQjLRnm8Ph1TO5q/Bx9ra/oXWjGp9mddydG1gxGsQyQxDzAI+hGJzU02Wd
 7kSuFFCiVphhjYCWVjTiDMs5sgW7YeNiiiCy/kWLsDbF+tzhWrTVuMiCBX5EEkPox0mh
 4ttg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMvD+zRUbtC6lxivXbtyDybTRq5dyLCOfAgGG9GnoB5MhOz8K1F6uX8cxn+k18+S9rnFRxRQuYpm3F@nongnu.org
X-Gm-Message-State: AOJu0Yz8cCZXuEyMtUm0O9vZVAtQICYP/PUmRkYRkol/qXc6JDUWPhi0
 a7r4dzje1Mk4gG1i5RMbhsU3fuZwgj6hEStv+4VdXPfWL2TIizEoStUUFGSYRZCXTsiTA1ogKd4
 FFCWpWNHVPKkjGcqLBBZW8vDcOQl99wtjkdxO2y3nON/6rYsvcNKdjx30
X-Gm-Gg: AZuq6aKRqYoLFX1QndNtlirFAmMxShrztW5eoChJhKKjmbIuwjc7okQantkrEbrJdRL
 uvcK6pfUbT8314tU02fT1gEBukcNT+JIepjSSJTBlBFLl5vYdpGfHTv/0LIyhWlkX4zLm8BUSDS
 wprDvdnF/Rnq4nIoHVfHAxsptXo7UV9l7STlywBAmpvE2YVb87e1skxU2rB0PKTP2R99AyA6p/G
 rjWlvxXKTnqw2KULnliJZYV9vNz2W/xSaZybC6O6WRWV1nM+Pd8q8MIdFFPFGeLG2bpOauPdFIC
 YyWtqitzkhxGvplbWaRtolhpDcYxZVS4aAxBSek1l9tK2jEu4VozDfC60Aczb9CkgXjz7nhX1WF
 FbVtxEKbYm9F92sONFLkorvNNQGG3j10RjY975amP+FJs6FL2loHfAX4=
X-Received: by 2002:a17:90b:5287:b0:356:22ef:57ba with SMTP id
 98e67ed59e1d1-35693cbd17bmr1186775a91.7.1770877573702; 
 Wed, 11 Feb 2026 22:26:13 -0800 (PST)
X-Received: by 2002:a17:90b:5287:b0:356:22ef:57ba with SMTP id
 98e67ed59e1d1-35693cbd17bmr1186763a91.7.1770877573345; 
 Wed, 11 Feb 2026 22:26:13 -0800 (PST)
Received: from rhel9-box.lan ([122.164.27.113])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-3567e7d95d8sm4894122a91.2.2026.02.11.22.26.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Feb 2026 22:26:13 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: kraxel@redhat.com, Ani Sinha <anisinha@redhat.com>, kvm@vger.kernel.org,
 qemu-devel@nongnu.org
Subject: [PATCH v4 12/31] kvm/i386: reload firmware for confidential guest
 reset
Date: Thu, 12 Feb 2026 11:54:56 +0530
Message-ID: <20260212062522.99565-13-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260212062522.99565-1-anisinha@redhat.com>
References: <20260212062522.99565-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

When IGVM is not being used by the confidential guest, the guest firmware has
to be reloaded explicitly again into memory. This is because, the memory into
which the firmware was loaded before reset was encrypted and is thus lost
upon reset. When IGVM is used, it is expected that the IGVM will contain the
guest firmware and the execution of the IGVM directives will set up the guest
firmware memory.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 target/i386/kvm/kvm.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index e82a6e9eda..eec2f27a0f 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -3281,7 +3281,14 @@ int kvm_arch_on_vmfd_change(MachineState *ms, KVMState *s)
 
     if (object_dynamic_cast(OBJECT(ms), TYPE_X86_MACHINE)) {
         X86MachineState *x86ms = X86_MACHINE(ms);
-
+        /*
+         * For confidential guests, reload bios ROM if IGVM is not specified.
+         * If an IGVM file is specified then the firmware must be provided
+         * in the IGVM file.
+         */
+        if (ms->cgs && !x86ms->igvm) {
+                x86_bios_rom_reload(x86ms);
+        }
         if (x86_machine_is_smm_enabled(x86ms)) {
             memory_listener_register(&smram_listener.listener,
                                      &smram_address_space);
-- 
2.42.0


