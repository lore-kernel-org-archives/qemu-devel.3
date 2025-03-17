Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38A95C282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 21:25:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuHx9-0001gd-IB; Mon, 17 Mar 2025 17:24:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nieklinnenbank@gmail.com>)
 id 1tuHx5-0001fj-UT
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 17:24:52 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nieklinnenbank@gmail.com>)
 id 1tuHx3-00078X-W2
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 17:24:51 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-ac28e66c0e1so770287166b.0
 for <qemu-devel@nongnu.org>; Mon, 17 Mar 2025 14:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742246688; x=1742851488; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=iDBmQQgA1S/ymjySivR/TmdQ7AayjW6X7BIWnXE7okE=;
 b=ms+gKJoYxhszS35xLeyiiuDtKuf1Ed1DbTpUKENfGCp+Vl1PteajI+syb+z8m+uBLi
 r0w5yCx2uhylJT1RvaGg8crEbmiAGU68koJWjHnqJ3dugvx2iDEye7KXC9fevgydOpqV
 EzXScpxaoOU81Kx1WIfxLc/Nn4dv8MPVZMkF5TVaG/QyxvNq6MqMjKKsoz5DfS30Rz0H
 qraWQOClpECIRxYRZpRQAFbJaqtANZvkRKbi9GplvzUfwszrbPrXMzJLRl6jhClfCQhY
 tXgYaiaHwUnfeoJWnyyMMpMWbV+VynPUSoqmu7CZsis3ohME91xCv9HsmCecLn1S6m4t
 cheA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742246688; x=1742851488;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iDBmQQgA1S/ymjySivR/TmdQ7AayjW6X7BIWnXE7okE=;
 b=jsMXDzlj+rcdFWk/96nSJmUAzbhHbq8bDdgSGf8c6aWTlpnB3qWshFnCfWFjNFLvdl
 T8ukQ9YriCaAMTEL6oLU670Itne/ba3dWSROyMjvnCtf+FQs4Vq0qxVh7J1LEqQWy/Zo
 HPugfvGxcVWPLEpQDNB2PUTg2xpwfiNLoffXr2BNyTVDtHY5YxPQHuc4y1i1/YH51LF5
 XHQrWtlp/Nd/c72bzdg4XU7t3B1Y9YDNu4Z1hBsUH88zpbPuNNyuLWBMqSNCpYpmLdiT
 sd9072nhHzTPUz2geTF7tBFu99xVWAb/rk25KmBL0lSC7IAec2eSUPBomyl0efWm8Dj2
 4A6Q==
X-Gm-Message-State: AOJu0YzKuP2PYA6cnHI4YH1nm0Yu/7gSBX7IF/r0q1gq2ybNxSugfR2M
 8bTXwJ2YD0kKlYvaum//IEdnRYCDXh/a9Cs5ZxJ+6KF5C5wnXHV+sNBpqQ==
X-Gm-Gg: ASbGncsW+gXmXTEiC3JMs5GWDVt0SiNsRXfh9V8etq+TSfxK2BeMc6d89i73W2HAKpW
 YvcnM2n7ZpzjG020CFJv8AdlZ2mhRH0qBZgeOnmG6ybho/9tJUN9WllQTZJhqhoA+Hyz26tYUNb
 iyoV5hYZT5MW4iZEhzP3PwC6A4IhpLxKUGDIAQuVCkL6fJL0XtWkelkFt5UF0cKnOAFLZ9/OJlw
 tcQL5X8Zb7fINp2sBW3r5vwENf0Gvo0NWRqAxjhWyvChw8SpkhXaHSw4sdUrpiSLQk0rE+leAIl
 AIKuBK8KcIFMglYrs1coSqcOltkcybfJKJihHgEmN3hR8gxSknhiHFq35eBQZX8PNnDoBQaBg/z
 Y3O4f9/dh3rTbzDm71ObbT9SdrLK/+ws=
X-Google-Smtp-Source: AGHT+IHxLAkzWiMGBCaJKg0fdgFRCWan1Zo+RQWQFNajFeT/pHCPpl6F6wbigQN4kwQdAZQZWBRdJg==
X-Received: by 2002:a17:907:7f0f:b0:abf:75d7:72a2 with SMTP id
 a640c23a62f3a-ac330444f85mr1338397066b.38.1742246688227; 
 Mon, 17 Mar 2025 14:24:48 -0700 (PDT)
Received: from tuf.home (2a02-a456-6be8-0-3062-de07-89b0-9cd1.fixed6.kpn.net.
 [2a02:a456:6be8:0:3062:de07:89b0:9cd1])
 by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-ac31484b0e5sm720694066b.76.2025.03.17.14.24.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Mar 2025 14:24:47 -0700 (PDT)
From: Niek Linnenbank <nieklinnenbank@gmail.com>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, berrange@redhat.com, stefanha@gmail.com,
 philmd@linaro.org, Niek Linnenbank <nieklinnenbank@gmail.com>
Subject: [PATCH v2] tests/functional/test_arm_orangepi: rename test class to
 'OrangePiMachine'
Date: Mon, 17 Mar 2025 22:24:39 +0100
Message-ID: <20250317212439.12278-1-nieklinnenbank@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=nieklinnenbank@gmail.com; helo=mail-ej1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The test class in this file contains all functional test cases
for testing the Orange Pi PC board. It should be given a name
matching the Qemu machine it covers.

This commit sets the test class name to 'OrangePiMachine'.

Fixes: 380f7268b7b ("tests/functional: Convert the OrangePi tests to the functional framework")
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Niek Linnenbank <nieklinnenbank@gmail.com>
---
 tests/functional/test_arm_orangepi.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/functional/test_arm_orangepi.py b/tests/functional/test_arm_orangepi.py
index 18ee50216b..28919391e5 100755
--- a/tests/functional/test_arm_orangepi.py
+++ b/tests/functional/test_arm_orangepi.py
@@ -14,7 +14,7 @@
 from qemu_test.utils import image_pow2ceil_expand
 
 
-class BananaPiMachine(LinuxKernelTest):
+class OrangePiMachine(LinuxKernelTest):
 
     ASSET_DEB = Asset(
         ('https://apt.armbian.com/pool/main/l/linux-6.6.16/'
-- 
2.43.0


