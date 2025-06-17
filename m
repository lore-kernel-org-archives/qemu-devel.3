Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1860C71157
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Jun 2025 16:36:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRZHE-0001Lo-Gj; Tue, 17 Jun 2025 12:35:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uRZGC-0000m3-78
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 12:34:10 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uRZG1-0000dB-5k
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 12:34:00 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-450ce671a08so37702105e9.3
 for <qemu-devel@nongnu.org>; Tue, 17 Jun 2025 09:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750178035; x=1750782835; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t40bt1183UrSentyz3550cC0V6NSp0ZoskbuhIRXheY=;
 b=iYZzXrooLEVABswjRyJcpawNukewtvdMUDWzFL8TEBSdYHqNbmU7R5p4fD0u6JxUAt
 F5ycupFpXVopyi6nvRZDnY7LpjmqK5lqg5P+gEraJhS4W9HcwsKlO/+VT/RNSIRWdROr
 iRirD3v+uRkFPsDO6IX5zNYzmgNWvv33pGpHBFRHT0JqEJ3/AQrv4jZokhPx93dujNu7
 mmT+3SJgONekc6ZH47zjoCS6FNjJ0guXBBWAsPjWXbMpUmi+M3gTN3KS5C6IlWQdMI44
 W7Mkuiz72bkpeWDjHxYxxxrjVwfhOT/JuMshPiPZzee62NJvUu/fWb9yHedh95t41Pfx
 apzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750178035; x=1750782835;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t40bt1183UrSentyz3550cC0V6NSp0ZoskbuhIRXheY=;
 b=hMegHgrL6sYqxm06KLY3gY1SHO+n/ffTlChTLHBwCdke3pnEHrTYou8z4HM5CmC5Q2
 2SIwRXpW2JhjIPuHBSaFd7JYZIxRr3gW2qG+bIYD2Hdr8pBArojEnuTc6PCNChlN7YS6
 2qQLfCkBYScheBx2i84BF1V/29T5/N3wk+G4Yvn7mi6hT3FVD0Jy7Gt+VDCta7bDK+tQ
 uajabfzXGkbPAF72O/kdYhP/SwA32SluQb7jGJbduCB8boEhmGl5fd6BcXhcg97RNJW5
 eZ57RUMzmAV5P4cnl4S70wfbVXtMVHV2qBAeDYu3YxuKxtUzTasBZbzoYIEgWK8dgajG
 g+cg==
X-Gm-Message-State: AOJu0Yy6+ucJWtc7KnNREhH9LNHamKIH1xnDAgeyUt4WDTbYPUkm3Mv8
 FtiJAUOwJtI1A25VxefWdqZ8aYBiryE6TVoYmU2XEa7Yk5YNnV53ul/VUDbDH77C9Bg=
X-Gm-Gg: ASbGncsjTI2tReuGKVBCO2LFtbxGtnCtyWmb4HRToX0POt5TN+08qaBRMMOa7zyHEr+
 Cchs4xmqMa1Vh8zsfR7A8RU6ujgbjQsXyQKVsZAqysO5cp4iaf/a9Ct0nV7Hv/kfIn91Cm0JEHi
 AXAkZ2s+SkFis/x7DdLFDQBENCLZhemBfkR368X2sC/i++GZuOi1p3CKwWV/9j7QsHEZ6Un/NBq
 68X0ni22MwbelwcJBsAXD8rk7OXYMmIHIK/JYzJWpKPm1KHvEG7rCerD/Hcv1spUqlfeCgHboaa
 lDBMNEp/kKowwAEYUmnb3M8dy2cC8x3f3APfH4crTXUedQNl8Q6ZO/WtyB2zCr0=
X-Google-Smtp-Source: AGHT+IG4cv90M94Tfw7iEiYjMpdDPcWxYkGMa/ll8ppjhP2edxc6v82sBNSLJWREvyzO/nD4jEsnAg==
X-Received: by 2002:a05:6000:2913:b0:3a4:d4e5:498a with SMTP id
 ffacd0b85a97d-3a5723af2e8mr12220518f8f.42.1750178035305; 
 Tue, 17 Jun 2025 09:33:55 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a568b48564sm14222655f8f.82.2025.06.17.09.33.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Jun 2025 09:33:53 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 434E85F8A6;
 Tue, 17 Jun 2025 17:33:52 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-arm@nongnu.org,
 Mark Burton <mburton@qti.qualcomm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Alexander Graf <graf@amazon.com>,
 kvm@vger.kernel.org, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [RFC PATCH 04/11] kvm: expose a trap-harder option to the command line
Date: Tue, 17 Jun 2025 17:33:44 +0100
Message-ID: <20250617163351.2640572-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250617163351.2640572-1-alex.bennee@linaro.org>
References: <20250617163351.2640572-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

It would be nice to only have the variable for this is a KVM_ARM_STATE
but currently everything is just held together in the common KVMState.
Only KVM ARM can set the flag though.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/system/kvm_int.h |  4 ++++
 target/arm/kvm.c         | 19 +++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/include/system/kvm_int.h b/include/system/kvm_int.h
index 756a3c0a25..a1e306b7b7 100644
--- a/include/system/kvm_int.h
+++ b/include/system/kvm_int.h
@@ -122,6 +122,10 @@ struct KVMState
     OnOffAuto kernel_irqchip_split;
     bool sync_mmu;
     bool guest_state_protected;
+
+    /* currently Arm only, but we have no KVMArmState */
+    bool trap_harder;
+
     uint64_t manual_dirty_log_protect;
     /*
      * Older POSIX says that ioctl numbers are signed int, but in
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 74fda8b809..8b1719bfc1 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -1615,6 +1615,18 @@ static void kvm_arch_set_eager_split_size(Object *obj, Visitor *v,
     s->kvm_eager_split_size = value;
 }
 
+static bool kvm_arch_get_trap_harder(Object *obj, Error **errp)
+{
+    KVMState *s = KVM_STATE(obj);
+    return s->trap_harder;
+}
+
+static void kvm_arch_set_trap_harder(Object *obj, bool value, Error **errp)
+{
+    KVMState *s = KVM_STATE(obj);
+    s->trap_harder = value;
+}
+
 void kvm_arch_accel_class_init(ObjectClass *oc)
 {
     object_class_property_add(oc, "eager-split-size", "size",
@@ -1623,6 +1635,13 @@ void kvm_arch_accel_class_init(ObjectClass *oc)
 
     object_class_property_set_description(oc, "eager-split-size",
         "Eager Page Split chunk size for hugepages. (default: 0, disabled)");
+
+    object_class_property_add_bool(oc, "trap-harder",
+                                   kvm_arch_get_trap_harder,
+                                   kvm_arch_set_trap_harder);
+
+    object_class_property_set_description(oc, "trap-harder",
+        "Trap harder mode traps almost everything to QEMU (default: off)");
 }
 
 int kvm_arch_insert_hw_breakpoint(vaddr addr, vaddr len, int type)
-- 
2.47.2


