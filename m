Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41C00C9EC8B
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 13:26:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfHuJ-0003Zq-0B; Mon, 12 Jan 2026 08:24:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vfHu2-0003Au-UR
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 08:24:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vfHty-0003n6-0A
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 08:24:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768224247;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wfYJ54PW7pNrLwK/eJ6cKC4iLcc2du5UIuKp3Xkn/CI=;
 b=c2j8GsUQmM28DWUTCrkNcic942aNDPJ+zVGkthAD8H4skeYemeyLBGT35+PTpBOrR/7vEn
 potquRJQTw9I7+J9542XvC3jfDHGcjdz20nKHDaAC4j1X7zisCPF9JWr4vNxfJq2aDXed8
 i7JHUaKnt1jifcGSBe4zihY5EBOSGxo=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-BcCo06h6NpKcz6AJyhJvYA-1; Mon, 12 Jan 2026 08:24:06 -0500
X-MC-Unique: BcCo06h6NpKcz6AJyhJvYA-1
X-Mimecast-MFC-AGG-ID: BcCo06h6NpKcz6AJyhJvYA_1768224245
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c549aaa796dso4687993a12.1
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 05:24:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768224245; x=1768829045; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wfYJ54PW7pNrLwK/eJ6cKC4iLcc2du5UIuKp3Xkn/CI=;
 b=NBtBYCLvtdIc1/ObQARFckgKfNJ/IfMS2cU1s3asmky4HeVSEb5MNb6obEHXMDAhlz
 veew7OM6ElQ1hal4amYAVisUQMynfvLH0eyAsgOoZhs7Xnb3k5O7gAOXePfSBpyVJcP3
 o6LZ6yTi3Wm9EaogMnkvQYY59n78IOYi5COTwC4kso8ygfmFWjiNUYgWSxBGKRjDxeXv
 +/6bQ8OlxN0uf+vw8OpmkZR/p6EWhvvRG7DOnHH0TD1NZpY4Nm0V4jib5ljGIbf2hUge
 NQfK8gOAqTkoTZiAnV2wd1OeaPWxS5kM/Z9fhTuK7r/5kC4OtRK9VK3nZzjctJtE+okk
 toSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768224245; x=1768829045;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wfYJ54PW7pNrLwK/eJ6cKC4iLcc2du5UIuKp3Xkn/CI=;
 b=oewxyiOTGt3gfjkGTlX/fZ9cO9SeUPmqTCjorj4/HIKPiY51QhCRdNwv9PVV9gfXVn
 7YedZpGCOPmoSpiCPbmJTylnRA1eWECJADg37ppOfOZm7qyjtRkO4cOROB0g6yE/s+xj
 NImCxrUBqC3QLXH52+MXTYspWxdIVksCdAeETI33ofW5YCb7y7zCIJk7+n5lktmPDLQ2
 rX6hsYjsOkSuM65D/frQvkMalNe+sKz43xf4xkObzKUq2U93WLpeIJN4NgfO2gxBMlNP
 hTRgp7ORmTa6ObgmuKN0HbVCm8W/3VGf5Hzyd01HZnfrzt4UlTR1TUJhvAaC6pRmNUfj
 B/4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLnNc44VXMIRO48o15vhcbR3XsmP3MBxrzImEFaIh2HmEdupaJeeou3TygF1J65dLauLqomOhTnt3T@nongnu.org
X-Gm-Message-State: AOJu0YyEwB2HYOKBPeB2GhZiC9DSl/nqiR/g4rw3hHL2tnDaL62L3YMa
 DcA3jR9taak9wyaJlYFouopH+oFUqCwch68tXJR7uLE8lhp0ztz19z+pNxYHDQ6jGJ0PM6rkQ2k
 i9oE9fX6EynDK3Y8WnlcN0JPbm8rog4n5//w5nvShpnlLI1x4s/A/y+cH
X-Gm-Gg: AY/fxX5DbaSgbqm2Q+Jx4GZpEI4siuv3/AYLdQe9VEtVjmmQEf0C59HOH2FPcTtQVT2
 LlqPFFAfZylSxSOKkcMnrgsb1Gzbk2x3G+nyFrBM8BSIPB2F4Wd9g2wYv+blH/F074ffqKxwp/A
 RDytanjfo9ErZ3e3E6o4sxpL5KA47kSYaKYZEu43Y6Ba9C5mMvbIF3vMkVwuQWYdZDo4VgF+KpR
 XOVloLrOf3/u0cyBAssrQcpbafuqlDN7vnMjsVo2xKzMAeEYZwZj3y3wXXocgiDo8ZntVug9yqx
 HgciEoP38aRoIM+3B8DaKOMeWAwDJ0VHVF5JfwEGBjPauLaI0QO1uj8iBIh66q+BYH/3lrpCWZP
 XblgVvsLmCoKRQZSPXBsSpdFSsb+UR0hJmwtfwX7eOBw=
X-Received: by 2002:a05:6a21:999c:b0:389:8e40:a13a with SMTP id
 adf61e73a8af0-3898f997771mr17078806637.52.1768224245216; 
 Mon, 12 Jan 2026 05:24:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH0M9fBY78q5fVf662RSaHGPAIXPHYNm4v5HjXRd4PiEkcc2Xs4274yy5o7YPnuQ5jB86LeyQ==
X-Received: by 2002:a05:6a21:999c:b0:389:8e40:a13a with SMTP id
 adf61e73a8af0-3898f997771mr17078790637.52.1768224244802; 
 Mon, 12 Jan 2026 05:24:04 -0800 (PST)
Received: from rhel9-box.lan ([110.227.88.119])
 by smtp.googlemail.com with ESMTPSA id
 41be03b00d2f7-c4cc05cd87asm17544771a12.15.2026.01.12.05.24.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Jan 2026 05:24:04 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>, kvm@vger.kernel.org, qemu-devel@nongnu.org
Subject: [PATCH v2 15/32] i386/tdx: add a pre-vmfd change notifier to reset
 tdx state
Date: Mon, 12 Jan 2026 18:52:28 +0530
Message-ID: <20260112132259.76855-16-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260112132259.76855-1-anisinha@redhat.com>
References: <20260112132259.76855-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

During reset, when the VM file descriptor is changed, the TDX state needs to be
re-initialized. A pre-VMFD notifier callback is implemented to reset the old
state and free memory before the new state is initialized post VM-fd change.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 target/i386/kvm/tdx.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index cba07785f7..314d316b7c 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -405,6 +405,32 @@ static void tdx_handle_reset(Object *obj, ResetType type)
     trace_tdx_handle_reset();
 }
 
+/* TDX guest reset will require us to reinitialize some of tdx guest state. */
+static int set_tdx_vm_uninitialized(NotifierWithReturn *notifier,
+                                    void *data, Error** errp)
+{
+    TdxFirmware *fw = &tdx_guest->tdvf;
+
+    if (tdx_guest->initialized) {
+        tdx_guest->initialized = false;
+    }
+
+    g_free(tdx_guest->ram_entries);
+
+    /*
+     * the firmware entries will be parsed again, see
+     * x86_firmware_configure() -> tdx_parse_tdvf()
+     */
+    fw->entries = 0;
+    g_free(fw->entries);
+
+    return 0;
+}
+
+static NotifierWithReturn tdx_vmfd_pre_change_notifier = {
+    .notify = set_tdx_vm_uninitialized,
+};
+
 /*
  * Some CPUID bits change from fixed1 to configurable bits when TDX module
  * supports TDX_FEATURES0.VE_REDUCTION. e.g., MCA/MCE/MTRR/CORE_CAPABILITY.
@@ -1549,6 +1575,7 @@ static void tdx_guest_init(Object *obj)
 
     tdx->event_notify_vector = -1;
     tdx->event_notify_apicid = -1;
+    kvm_vmfd_add_pre_change_notifier(&tdx_vmfd_pre_change_notifier);
     qemu_register_resettable(obj);
 }
 
-- 
2.42.0


