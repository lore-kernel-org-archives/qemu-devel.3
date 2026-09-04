Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B57FC61DD6
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 13:23:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2TtI-0005WM-LN; Fri, 04 Sep 2026 09:23:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2TtH-0005Ux-Ab
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 09:23:35 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2TtF-0008Ip-II
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 09:23:35 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-47de0093c42so859368f8f.3
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 06:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788528212; x=1789133012; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=LnaNcBsuPzzVC+J4u2ifvjPYqL0A46gG+rLPxX/9Xzw=;
 b=Y2+VusiOX+rzj474tv+F/7fsBfi5y8Ofp/nq8YZAnpCo2Uj5mS+B8OHstqB+4FNLRH
 Mp/YsWJRIctiM8p9lU4gYTx8dzWdYZSCFVsHwDrVqpXq45ce917WSOwb7P2/gKgT3qzx
 mYesSbiu3bHeA59UAo08lipFVQBCSV+hYS+yBK3wAJzkVdYeoKrOBqXDdhcdQsJ7TE6S
 bpOr8m5gB26aW2mdwJuP2GwnOyJDgyL/ltUdq2vAqGZ2AqtuEwAQQs+1KxCW6HdhXMRD
 a5VKaMtQVGbmAQgdQv63D0fegUXn+QMDbl8+4Ktn02TUQvlP6y9SUxz9EAhMQmChUrdh
 Srbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788528212; x=1789133012;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LnaNcBsuPzzVC+J4u2ifvjPYqL0A46gG+rLPxX/9Xzw=;
 b=UdsC2n5S71G0bzCnc4axDPrCbQwujIOgEkqDNZqt3yc92lSCtbHfgIipOZjG4OyfYK
 JxgTSgg9g8+2gdajPBd4UvZEVdnY2UEyxdPX8P0kJ6x1LvU9xj9N2DqpYjgMK09qoHyS
 qCP//msRGiuebClJBm2QJ49+EQDnX//ob3HbL21qSdjT+/NQ1p5YSOSIOOIF5pMUzwx6
 3jB3/2rGEmkGgnP87KC/kR4aLQQYTuhu95SjVZYSneAOLZdYHftI25bYVIDKQmwy6fsC
 qWu2Yhabl/+iwe9qVpRylwxPi+DFBwESDr6R2aWOqT9UMeGFF03FPu0udQ3jiZ9bXiYu
 Ttkg==
X-Gm-Message-State: AFuF++mMyDXqUP1pyPB7MCCTUwHaeI8H2PzwNNIf2pzKJRIyLiT1v6/N
 rwgpblKjfQqzSrGq3yS7iayvFa+vMZZSgk9h864MET23KIDdjMNXAB4AGSGEmhtIi4dxh4vttiL
 kEBjJyYU=
X-Gm-Gg: AYBFou26ZbpD3984zBE4+EQiCgyuClkiPe1Suiu9nYboABU5GsgSG/YWxpdubciNe63
 az51tlE7ItCecZ6f7tykBayFz59SCMEd/DKWpOwIAxsL6zFMHHFbb/A/LD+OSuZuIgWusZxyjFD
 O+IHb+P9pT056DUhuzJZuINjtWLHVNP5CtQhbxBU2uiEGKQYDuW9KjlBFCMlQZE5G9Cw1vCMaM0
 A/isvUWqSp/zyo+5c2LDh1D21gip114r8X7B+sqaZKCBUsXUa3mQCZVVdwY+z8YVMuTgncfnbPc
 XwdpU2njOAkF6ObXqXQAmXoiU06FWQ0JpArAjRnOiliH10xgmPKGUEbsZpYp4dOOXBwUVoVwzRw
 P6yglY4LQdCoM5rIdNBw44M9YcutVvRNBuwBapprCkJE7Ns2UsUpjUSSthgTvM8GiDULasBx9/n
 6cNP5ZmwF0IeBKY9fQq9EpyK7m8SMnKAuMwsO956O17KKFCz8uyvp173EnJya6
X-Received: by 2002:a05:6000:29d1:b0:47f:8b24:ef01 with SMTP id
 ffacd0b85a97d-48587091569mr6822633f8f.1.1788528211612; 
 Fri, 04 Sep 2026 06:23:31 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485885b1320sm6412891f8f.27.2026.09.04.06.23.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 06:23:27 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C7D3D61D17;
 Fri, 04 Sep 2026 13:46:11 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aniket Sahu <asahu1x@linux.ibm.com>, Stafford Horne <shorne@gmail.com>
Subject: [PULL 070/105] tests/tcg/or1k/test_muli.c: remove set but unused
 variable
Date: Fri,  4 Sep 2026 13:45:24 +0100
Message-ID: <20260904124604.2207440-71-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260904124604.2207440-1-alex.bennee@linaro.org>
References: <20260904124604.2207440-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42a.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20260827221506.91574-71-pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/tcg/or1k/test_muli.c b/tests/tcg/or1k/test_muli.c
index f1042e98dec..cfb6b3df251 100644
--- a/tests/tcg/or1k/test_muli.c
+++ b/tests/tcg/or1k/test_muli.c
@@ -2,11 +2,10 @@
 
 int main(void)
 {
-    int a, b, c;
+    int a, b;
     int result;
 
     b = 0x4;
-    c = 0x1;
     result = 0x4;
     __asm
     ("l.muli    %0, %1, 0x1\n\t"
@@ -19,7 +18,6 @@ int main(void)
     }
 
     b = 0x1;
-    c = 0x0;
     result = 0x0;
     __asm
     ("l.muli    %0, %1, 0x0\n\t"
@@ -32,7 +30,6 @@ int main(void)
     }
 
     b = 0x1;
-    c = 0xff;
     result = 0xff;
     __asm
     ("l.muli    %0, %1, 0xff\n\t"
-- 
2.47.3


