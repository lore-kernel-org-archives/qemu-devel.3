Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1317C83F09
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 16:35:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXjEK-0000L9-Fq; Fri, 04 Jul 2025 12:25:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjEJ-0000IT-GE
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:25:39 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjEH-0006E6-SK
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:25:39 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3a54690d369so1116182f8f.3
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 09:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751646336; x=1752251136; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=TwjynpGV/1pTWOQilt3QgTNlLQPjzgarmUwDRRKoh/I=;
 b=beUvr+RSFwO7ofLPXyzecGTW9+w/rO6mosHCN6hXJKotUXYzvAWA3PQYPpnHQ0V+cK
 wBdReatGVlC5kqd7wcHckKw8UJNrQ0MYy5zNW1Uv8tn4hgQAczo9t+D8XHfkrI2m6Yfg
 egHNzZ6DjOXsjnVlIszqN4wJetX2pVSTXthzwP36Fj7nW7aFCh7IpPqEjF+WjE+a/DZf
 myRwyG/CIxPShXi4w8llIRrL1kH5eF1Aa39oo79DyCxvvF/TfRFmwNVOrI2c7YxUO/iN
 qM5B30MTsj/0vzpi/eLCTlZ5dvf5fnAgLJJU1byhjsQZJxkIXqi9WT9Sn+N7QrRMCI22
 FBmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751646336; x=1752251136;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TwjynpGV/1pTWOQilt3QgTNlLQPjzgarmUwDRRKoh/I=;
 b=hea4Mq7/RORX1FrkxG98+WwMjkewlMWfo9lHNeV4nLKoxFbW6jFkmHRU0OAHlnEFgs
 yOg0Ng1TeJJdc9PKbcP4eZ7rkZGcBKnwRz+o2l7r79mIpJV2zGdNQxfxI/gfTCNCJFfs
 8F/vNRyVCCmvsORGJEjcorcf4xqJugOBhYtSe5rQXhGaqiPHsymrfSq+E4mO01ptrzcl
 AAwP1xzL4+jfP4sHXgDFRf90kMwI2/+tqj4G9L4EGX3KxoYq3A7IGUMSrayasDJqV6VP
 tXJVH0bR6gB4W5kDmD0J3Mtoo4js8VSsljVH/VOtApkVE159PKI2wNOR8lqqWCJbMXUi
 iZ/g==
X-Gm-Message-State: AOJu0Ywj1P2v7QYhEbBh3/Ned+oNXJuZBDj8uqKXsM6PfQbUo01GTXKj
 fsL7npZy4gqRVdDCU2+KQqy3nJi1q82AACFxNNcX4r+7/HmW+stmKJYmaDlb5v5XY0XqaHrHQ/W
 qUcT0
X-Gm-Gg: ASbGncvoxDQeckWwKAe5tV+cfvHyVPs6nLn2Px3uW4ZrLtS+lI10iRMhVbMxQ4r/muD
 X/0Ib6JgUCZFm1VKpEMUaHre+Q9YKwPnN7C7lxMYKEB5pNZGUXkVjOsHkCRvIYC+NYE72LBUHtU
 GVd/XP7u52JPEYRhBRwd/4XdIA+IjDbh7pDEvpecgTekwXhgcR1golDNI/T14AhSsHjU4IsEjzZ
 Vzc+XcfJ10hNipf3Qxvd1cd5S8CAtg5wpm0T9Ttl+MAATfh03i4c9x390fG6G2ThQsbaMGxc+Dt
 RFwxcGv1Gk48EoK4ztDLKxAp09FNzQbT8BKekdtZ13ELIxBm086dWDabf0pZHvdtkNUF
X-Google-Smtp-Source: AGHT+IGSEg9YO29PiRnAmJ1RGi/rWZIwZNdQ9lxd86TlfDC2Q6beUfnY+tTXoUlIILgjPoS3esuRxA==
X-Received: by 2002:a05:6000:41fb:b0:3a4:d6ed:8e2e with SMTP id
 ffacd0b85a97d-3b49702e6camr2393803f8f.41.1751646336105; 
 Fri, 04 Jul 2025 09:25:36 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b471b96534sm2816857f8f.48.2025.07.04.09.25.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 09:25:35 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 036/119] target/arm: Introduce ARMCPU.sme_max_vq
Date: Fri,  4 Jul 2025 17:23:36 +0100
Message-ID: <20250704162501.249138-37-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704162501.249138-1-peter.maydell@linaro.org>
References: <20250704162501.249138-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x433.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250704142112.1018902-25-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h   | 1 +
 target/arm/cpu64.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 39a9234ff28..c8cf0ab417b 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1136,6 +1136,7 @@ struct ArchCPU {
 
     /* Used to set the maximum vector length the cpu will support.  */
     uint32_t sve_max_vq;
+    uint32_t sme_max_vq;
 
 #ifdef CONFIG_USER_ONLY
     /* Used to set the default vector length at process start. */
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 77e7c4a6a52..bd33d6cc6ea 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -363,6 +363,7 @@ void arm_cpu_sme_finalize(ARMCPU *cpu, Error **errp)
     }
 
     cpu->sme_vq.map = vq_map;
+    cpu->sme_max_vq = 32 - clz32(vq_map);
 }
 
 static bool cpu_arm_get_sme(Object *obj, Error **errp)
-- 
2.43.0


