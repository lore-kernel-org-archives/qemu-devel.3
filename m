Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5126C4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 14:21:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1racbu-0005gS-RS; Thu, 15 Feb 2024 09:21:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1racbs-0005dL-EQ
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 09:21:08 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1racbh-0000En-BZ
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 09:21:08 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4121954d4c0so3556245e9.0
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 06:20:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708006855; x=1708611655; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V9a2tbqcFhv7866Po+eazVne7c9fJyb++6ZKJPt9MeE=;
 b=jQ5qJT7TFC22SWPzleXZ0K8hWMveJGkAQ6eXr4/RMaXQv6sE0mmFX7JPKTE/2msJE8
 krjuisnwpOUV2WelnoK0fde9HgHt5Ms/LhyyIFUovlCrnyM0EDHC1LTmEfyC8G7L6btL
 Pi5uR/VUPa/Lb2ZBhC21z7lOE/uZk40o9IXPAvAEfPVjPvMHG0JVerHkpSqpprjnk4+T
 zj8TvmvWTScBREGd9TAlQPZqjqBNpCmyAmtrnCuJ0nBpMYRkAjTweEVzftWufzNxuHVZ
 GzLGyHDtO2/+nbXykpr2XV59qmrvpgnarB2zD6o4lBf5zlBjmggxhDuI+t0Q7VT2Q7GQ
 6BGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708006855; x=1708611655;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V9a2tbqcFhv7866Po+eazVne7c9fJyb++6ZKJPt9MeE=;
 b=HyVa1gfE7elpqrKr9A8UP6bI2g6iTal3W6ee7cBGywUZrg+DYnWaSnDXg28g8Hnn4k
 i4o2Qhu2hTCOdJKEQxd02EtTsLVs/8P1TzCTcH5RxVQdIKR8XL5gDDyTgdg92fzfLmfg
 FmY3PRiBtIrLXOP7o5TiugoztrMxZBX2HuKQT6FnMmWUdjhUIoXJu1jiZGaYPiX4HITI
 ALKoaD8rKB7lexpN+iQHxje02eDR+VzPc70J6Qvt7AGCezEJ8fcSOscnI5JRZBLyaU7W
 5TwsvKx2k5QJk2efPiRmeLS6Jfhbpos+xqcJ0EPB99TBDNHVClgsHdeLi8HSdOF3dIYf
 sgtg==
X-Gm-Message-State: AOJu0Yz6d0CaVhoHAmMTRyErKDPOar3veglUF0/XThg28FO62pPKIr+u
 u79pTPYEV7GB8V2XKycPTaUqE983maeSdYff/WuW7UC+M1nsGLyoQ6ud4gZYIwenTsda59f2Ik7
 7/Dg=
X-Google-Smtp-Source: AGHT+IHZtXtX6MfTefPcXDCoXO9cBpuaZm8C6bzeO6EAUHK2OKEi7VgqOojokGFFWz2RMHHac1bnig==
X-Received: by 2002:a05:600c:1c0a:b0:411:dd82:a23c with SMTP id
 j10-20020a05600c1c0a00b00411dd82a23cmr1813787wms.0.1708006855024; 
 Thu, 15 Feb 2024 06:20:55 -0800 (PST)
Received: from m1x-phil.lan ([176.187.193.50])
 by smtp.gmail.com with ESMTPSA id
 bi20-20020a05600c3d9400b004103e15441dsm2147381wmb.6.2024.02.15.06.20.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 15 Feb 2024 06:20:54 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH v2 3/3] hw/i386/sgx: Use QDev API
Date: Thu, 15 Feb 2024 15:20:35 +0100
Message-ID: <20240215142035.73331-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240215142035.73331-1-philmd@linaro.org>
References: <20240215142035.73331-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Prefer the QDev API over the low level QOM one.
No logical change intended.

Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
Only build-tested.
---
 hw/i386/kvm/sgx.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/hw/i386/kvm/sgx.c b/hw/i386/kvm/sgx.c
index 70305547d4..de76397bcf 100644
--- a/hw/i386/kvm/sgx.c
+++ b/hw/i386/kvm/sgx.c
@@ -286,7 +286,6 @@ void pc_machine_init_sgx_epc(PCMachineState *pcms)
     SGXEPCState *sgx_epc = &pcms->sgx_epc;
     X86MachineState *x86ms = X86_MACHINE(pcms);
     SgxEPCList *list = NULL;
-    Object *obj;
 
     memset(sgx_epc, 0, sizeof(SGXEPCState));
     if (!x86ms->sgx_epc_list) {
@@ -300,16 +299,15 @@ void pc_machine_init_sgx_epc(PCMachineState *pcms)
                                 &sgx_epc->mr);
 
     for (list = x86ms->sgx_epc_list; list; list = list->next) {
-        obj = object_new("sgx-epc");
+        DeviceState *dev = qdev_new(TYPE_SGX_EPC);
 
         /* set the memdev link with memory backend */
-        object_property_parse(obj, SGX_EPC_MEMDEV_PROP, list->value->memdev,
-                              &error_fatal);
+        object_property_parse(OBJECT(dev), SGX_EPC_MEMDEV_PROP,
+                              list->value->memdev, &error_fatal);
         /* set the numa node property for sgx epc object */
-        object_property_set_uint(obj, SGX_EPC_NUMA_NODE_PROP, list->value->node,
-                             &error_fatal);
-        object_property_set_bool(obj, "realized", true, &error_fatal);
-        object_unref(obj);
+        object_property_set_uint(OBJECT(dev), SGX_EPC_NUMA_NODE_PROP,
+                                 list->value->node, &error_fatal);
+        qdev_realize_and_unref(dev, NULL, &error_fatal);
     }
 
     if ((sgx_epc->base + sgx_epc->size) < sgx_epc->base) {
-- 
2.41.0


