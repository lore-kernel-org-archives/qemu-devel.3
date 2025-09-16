Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB73ECAC592
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 17:10:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyZBA-00060P-Sb; Tue, 16 Sep 2025 13:09:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uyZB9-0005zT-4Y
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 13:09:19 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uyZB6-0001P1-4w
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 13:09:18 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-327f87275d4so5542705a91.1
 for <qemu-devel@nongnu.org>; Tue, 16 Sep 2025 10:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758042554; x=1758647354; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dLjGnmnS9JGJHlU1Cr0NfWpsMknq12Ga80dA9n4yufQ=;
 b=WOsY0rHFYxLTn+qgpTF77mNIJwWnaHg7DePxazcbLnGI24FAfaV4QR93DngrBwQnrS
 9ZLMXPX38bNyoxJXA+WLBXz14ImK9q7pRnj7wenQ9sUg+Jojia/iB0bYuhoA4FouxnKk
 3stW4uGBiryp0UbzwYg7oueqWXo+9NZMKJU/8/FIxzIh5nCpPSZ27BdWZIDQvhqze2VM
 WBudnVop43uCVoAmNvD4WUmDS+26xLKu78gDRwOG8EGjOyT/Adm4jd+bF9eNUPQ59pJ9
 DPBO079HhbfMw+Uq+fcXwmXeeLiiYVZtAiiCdvGj/6SMsLgBzlL/W6N0n67/ISdBBRTE
 XCPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758042554; x=1758647354;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dLjGnmnS9JGJHlU1Cr0NfWpsMknq12Ga80dA9n4yufQ=;
 b=hfDC6Kvl/AvXvgA1/6mrbtnz0KiDGb+mv8G8PzRCCnyfNEi0rLZ55ehbGbOHlYiN/F
 t8bwZS/eoAU+a/leo9MsZ1JzBMSdl98BRcwCxw5pdJ93zTybO8fSeANUKv4yqP7rfnfw
 6gbFpmvMeiAHe4+kcFozn8+3+1f3s8hgA2Bi2ygpEqIoEWfMRiwtS/Gvm/1rAScVhDfu
 ez8mZUPd1bjbXkrxqnlB2abYX+Kww2F2mFaCI2FWG77r6MOn0O7PXldEjmtXvz6F7mLc
 QXdOuB343CohEXQk5P+jjwXeytKP6ANg4tTT58F0FfVxEF4qTJvdU927cLfKZyK+CJYy
 LlIQ==
X-Gm-Message-State: AOJu0YzzgqmKBw7yQnFjPXeeTsqwj/9EZCq7yS7cq6NZkfwkwSNT6KMk
 IZeuQqHMjj2IbyECuST70/7fQB/jBL5nPLbD8KFhcvJ0pR5YrkORkgeEEuA8vUjkNpAQdT31I6P
 cxnOL
X-Gm-Gg: ASbGncuLnB6K5gJsK4P3f6wlkRi0wmfinsZCcnMn+ZBydmfpJfoq24kUvCSnaUhcHSF
 Sj5hN2mjU/p6d0dqI1S57D7Ry9HUAonqrkQ+AkelAbYDBobbAooZQtM8MaPjDLE6TbrL6Grnmsf
 7xczVED0z+MFDljDpcUru7xc0l471Ces5moiVOGJ+JMnyxThu8utHSpSrTCk7iQ7cfhiWK+GIIB
 GqPgNnY+SJiNbCzrWhds0QXMF98Xg02UBgR1d1pAPJBIBAzTo8pUpv26INnU7oNB8PY5LsV9xst
 HFVrYw4RY4J55MQEKtLfIuV30NfCy8rsZA/zEmkMsKWDSuhH2ozpYg/vTYEg+akHwUIizPIeDWj
 H161ob1Mkcx1teUhb0Z9e8XZf+gBH
X-Google-Smtp-Source: AGHT+IGOyop/jQvvpamYmlpabdYEu5lWD8X3gi5wpaXeqCcNwCMZQfqVa1NfzmBLok3d31QqFw384g==
X-Received: by 2002:a17:90b:3d92:b0:32e:749d:fcb6 with SMTP id
 98e67ed59e1d1-32e749e0054mr8972859a91.12.1758042554401; 
 Tue, 16 Sep 2025 10:09:14 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-32ed275e795sm95531a91.19.2025.09.16.10.09.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Sep 2025 10:09:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-stable@nongnu.org
Subject: [PULL 2/2] .gitmodules: move u-boot mirrors to qemu-project-mirrors
Date: Tue, 16 Sep 2025 10:09:12 -0700
Message-ID: <20250916170912.706610-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250916170912.706610-1-richard.henderson@linaro.org>
References: <20250916170912.706610-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102f.google.com
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

From: Alex Bennée <alex.bennee@linaro.org>

To continue our GitLab Open Source Program license we need to pass an
automated license check for all repos under qemu-project. While U-Boot
is clearly GPLv2 rather than fight with the automated validation
script just move the mirror across to a separate project.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
Cc: qemu-stable@nongnu.org
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250908141911.2546063-1-alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 .gitmodules | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/.gitmodules b/.gitmodules
index 73cae4cd4d..e27dfe8c2c 100644
--- a/.gitmodules
+++ b/.gitmodules
@@ -15,7 +15,7 @@
 	url = https://gitlab.com/qemu-project/qemu-palcode.git
 [submodule "roms/u-boot"]
 	path = roms/u-boot
-	url = https://gitlab.com/qemu-project/u-boot.git
+	url = https://gitlab.com/qemu-project-mirrors/u-boot.git
 [submodule "roms/skiboot"]
 	path = roms/skiboot
 	url = https://gitlab.com/qemu-project/skiboot.git
@@ -27,7 +27,7 @@
 	url = https://gitlab.com/qemu-project/seabios-hppa.git
 [submodule "roms/u-boot-sam460ex"]
 	path = roms/u-boot-sam460ex
-	url = https://gitlab.com/qemu-project/u-boot-sam460ex.git
+	url = https://gitlab.com/qemu-project-mirrors/u-boot-sam460ex.git
 [submodule "roms/edk2"]
 	path = roms/edk2
 	url = https://gitlab.com/qemu-project/edk2.git
-- 
2.43.0


