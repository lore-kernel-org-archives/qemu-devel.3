Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12F1BD0E3F7
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2024 19:44:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t43k3-0006OG-Tb; Thu, 24 Oct 2024 15:43:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1t43jq-0006ME-Fn
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 15:43:18 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1t43jo-00081D-Vl
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 15:43:18 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-539e6c754bdso1240596e87.2
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2024 12:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1729798995; x=1730403795;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DQg34qAwXV1dkoltfasHGRhCwLkvl9EuX77LcykV+9c=;
 b=PD/Uw0x75AOlCgvZmnAHgZSmESOZjZFwt8MOJqrmdurAsV2DDyzddnewexiEQQQhCA
 NA5t44gcb6bRZG3eEyZuPWATFekeZeJ0q5HkIUbXrBLK4kkHdkO+CR80H3MPCfJ1kB+Q
 GpYhOWkQvumHPdv6IfKTWY3nSmlvuargfQrnvNxkkHWv4/SW+xmRsuJ9qkpp2mRtws7t
 SssufmJxbNRkiXXJut34+PVGtOZhoRFcAQ2l8ebgjTW8IZvj8SVxqq0vc+KRx9lUpnz8
 3OUGHYls2c7OwbBpD1CIVV5AB7i+sLaPppbfKP9r/dtlUUlx6Pj3CpaWUR6DqVXfKZnR
 KoVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729798995; x=1730403795;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DQg34qAwXV1dkoltfasHGRhCwLkvl9EuX77LcykV+9c=;
 b=HltpY2SYrtFcCOBZX/a3dl8QiKtPlIFsda43rgbwNKAW48eXqtRFIjH5F2IOPPy+dJ
 JCM49xu0ChTk7LTd2xe+EaGyuQDU+kZHIWU1eg5fy814eQkfwM0jYTgE7wj23Dio+R+R
 kXjH6yo8r7gsuzXUNZB+Nl/wmFbCYjXXEI7V8p6xyUuKfMYLlo3Sl4tQK9WtUDTbwKBC
 gzOXZpVxWPGcobDUV7L+wq6HXf0nu4kM7N5rkO7fLNJ0tW3qpB798trECYyUyF/jMrix
 U8e3IyasxovW16+1rjM+CF2WYOvQNlCRDnUC8m41ae4S05dtHbjv6l73rQUmIUrlffFs
 8uxA==
X-Gm-Message-State: AOJu0Yw0UBMEOtY9nOBILOb6cY/YfAMHKtkhG49Io0VexhrEtDTxUcM8
 AtvT0+wmtlJZ0Ke1S3MSoJK5WmNOu8U4lPBjquKbcKP2nF23zCBzLmrfLd1Y8VWud7Z25l0kbwl
 ufg==
X-Google-Smtp-Source: AGHT+IFa/c5x5Y4RpZADd72eqSIkPb0kJta9ubAFoaeky0eYE0NG+YFmMmwui8HaOrH5lLLZpt8d5w==
X-Received: by 2002:a05:6512:3510:b0:53b:1fc6:3cf4 with SMTP id
 2adb3069b0e04-53b1fc64039mr2620513e87.41.1729798994732; 
 Thu, 24 Oct 2024 12:43:14 -0700 (PDT)
Received: from localhost.localdomain (h082218084190.host.wavenet.at.
 [82.218.84.190]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a912d6545sm652536866b.31.2024.10.24.12.43.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 24 Oct 2024 12:43:14 -0700 (PDT)
From: Phil Dennis-Jordan <phil@philjordan.eu>
To: qemu-devel@nongnu.org
Cc: dirty@apple.com, rbolshakov@ddn.com,
 Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH 3/4] i386/hvf: Raise exception on error setting APICBASE
Date: Thu, 24 Oct 2024 21:43:02 +0200
Message-Id: <20241024194303.32100-4-phil@philjordan.eu>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20241024194303.32100-1-phil@philjordan.eu>
References: <20241024194303.32100-1-phil@philjordan.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: neutral client-ip=2a00:1450:4864:20::133;
 envelope-from=phil@philjordan.eu; helo=mail-lf1-x133.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NEUTRAL=0.779 autolearn=no autolearn_force=no
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

When setting the APICBASE MSR to an illegal value, the APIC
implementation will return an error. This change forwards that report
to the guest as an exception rather than ignoring it when using the hvf
accelerator.

Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
---
 target/i386/hvf/x86_emu.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/target/i386/hvf/x86_emu.c b/target/i386/hvf/x86_emu.c
index be675bcfb71..015f760acb3 100644
--- a/target/i386/hvf/x86_emu.c
+++ b/target/i386/hvf/x86_emu.c
@@ -794,9 +794,16 @@ void simulate_wrmsr(CPUX86State *env)
     switch (msr) {
     case MSR_IA32_TSC:
         break;
-    case MSR_IA32_APICBASE:
-        cpu_set_apic_base(cpu->apic_state, data);
+    case MSR_IA32_APICBASE: {
+        int r;
+
+        r = cpu_set_apic_base(cpu->apic_state, data);
+        if (r < 0) {
+            raise_exception(env, EXCP0D_GPF, 0);
+        }
+
         break;
+    }
     case MSR_APIC_START ... MSR_APIC_END: {
         int ret;
         int index = (uint32_t)env->regs[R_ECX] - MSR_APIC_START;
-- 
2.39.3 (Apple Git-145)


