Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87AC9E7FDD8
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 21:23:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vn1Ni-0005eT-Mg; Mon, 02 Feb 2026 16:22:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vn1Mp-00055f-20
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 16:21:56 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vn1Mn-0007Zj-Fz
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 16:21:54 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-47d6a1f08bbso23531315e9.2
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 13:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770067312; x=1770672112; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/yVA3QElwpb8w5P7zafXnevtaEDG4kPe47I4rDtxzQs=;
 b=rZ3esbDHRZelSmNCmTd5D9gpAXErac/FLrXhibl7fdms3cJxcntSlWgJLjQ9KWhPEC
 j7+gS8FIHZUnErCLGOR8O6ReFj/GkS/HBbY7WrFbOzyvXM9/7y2KmS2EjbM6JpeBvpsc
 7ZuMNw5sG8S6bL1DxSoi19ciPk38UtYLcp65Ez4qNcMGPWv5pS5+3v1uOycTAT9AxDIt
 3KZ8jUjZMIvrmOXRoql5SymTRS35GJIM4NewYY4P4/8MGSrjlL9lluiz4N7rWFogWpn3
 Db9ZVRbYrYzbXvdblRR7ccgSMwo3X+JHwLLBgy76/TbdM45W2KPc+7NRGOsTlqXRp2ex
 b54w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770067312; x=1770672112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=/yVA3QElwpb8w5P7zafXnevtaEDG4kPe47I4rDtxzQs=;
 b=nMpmZzoVStdNB/yejcgWLX7IV+0lp9FEP99aFLed2R6N0b8IugQXjopbggoBbu3WKR
 7WeBWUKH6Ao0a7oPKBvs1akwFryYCA7FQ9vejxweuKJvEp0u+pu7kury8beENls6kUf8
 yxZUqv9z06nV98Q+lpfV+k2+IpEkvVbofQg9BnELPeYdOKkFFrSmC1+mJN4xZxT3zN1T
 5lyFF8kuYQI04JgQxdPWS9h00f51Jcx6KBFpaGby5tVLJyCbFHE+1RVKBrTnmQFglZW6
 KeWcsCCWv00l9wcX5Urgt1vbpgGjIFMGEmA8hx31hWCv0pfSOP5yHw/NBD5HyEQZQBxT
 bwbA==
X-Gm-Message-State: AOJu0YxSGwHp/QwuCPoAUdYXsKFik5PZifywRkCKXRAdhy8PZcpjHB5b
 SN/Gz4iqid7tfZj6HBnhW33veKtZ3ANlUgrwsJpeJ0aqgGAMc4dTAHBwdEDGAMbK/9ZnFD2IO6C
 T6rgxxtY=
X-Gm-Gg: AZuq6aJcOyxeFkN7EjtXckmaX5DWoUK1sgt7tFE+OY73tqFqros1GxOpU9VjmBNdw9z
 JbWOC45MN/Q3rSEIBSakiZwF+Ih8R22Qyu4CoAOhXY36UTvmVh+2/XVOXd2Gwg9QqGLL/2uLogf
 Q07bgI8imVQHe4bxH97iucH3bvAMQ9rwJM/EEhfLsmm8Uib2L4SpcALj6ez5J91EUEUu/pEGFPH
 PzLSmpgEQSRSvcOzzPOlB5XE8hRGqROrK47O9XtMFRdt9WlyKyC6NcZ/T/cFYi+5Vx9hldzGdGs
 7RVE3mP2ES9BSLbFHcY91aKDPQb6tfLwq6QgppQ8n7IZ+b6lffbpYjWlekpzj44KgZG8Cvg/VRd
 Vud92QXy5pr0e/slgrnqgQnWPl4ckT+XkgPoNw+qxkkzvE/dn/6Shy9Lb/5IonouVLOST2U72eM
 CX0PxePmsyGXdaDKVEttjuH4gANKoKkKTT+35/Z1ZyqOAolWtb3jsa4wA2u/Mt
X-Received: by 2002:a05:600c:c4a3:b0:45d:dc85:c009 with SMTP id
 5b1f17b1804b1-482db49b168mr180904405e9.10.1770067311653; 
 Mon, 02 Feb 2026 13:21:51 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10e48a6sm45266091f8f.8.2026.02.02.13.21.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 02 Feb 2026 13:21:51 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/16] target/i386: Include missing 'svm.h' header in 'sev.h'
Date: Mon,  2 Feb 2026 22:20:16 +0100
Message-ID: <20260202212019.94205-14-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260202212019.94205-1-philmd@linaro.org>
References: <20260202212019.94205-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

"target/i386/sev.h" uses the vmcb_seg structure type, which
is defined in "target/i386/svm.h". Current builds succeed
because the files including "target/i386/sev.h" also include
"monitor/hmp-target.h", itself including "cpu.h" and finally
"target/i386/svm.h".

Include the latter, otherwise removing "cpu.h" from
"monitor/hmp-target.h" triggers:

  ../target/i386/sev.h:62:21: error: field has incomplete type 'struct vmcb_seg'
     62 |     struct vmcb_seg es;
        |                     ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Message-Id: <20260129164039.58472-2-philmd@linaro.org>
---
 target/i386/sev.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/i386/sev.h b/target/i386/sev.h
index 9db1a802f6b..4358df40e48 100644
--- a/target/i386/sev.h
+++ b/target/i386/sev.h
@@ -14,6 +14,8 @@
 #ifndef I386_SEV_H
 #define I386_SEV_H
 
+#include "target/i386/svm.h"
+
 #ifndef CONFIG_USER_ONLY
 #include CONFIG_DEVICES /* CONFIG_SEV */
 #endif
-- 
2.52.0


