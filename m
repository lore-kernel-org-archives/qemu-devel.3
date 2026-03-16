Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 734FCF4644A
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 10:42:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w25PP-0001i6-Q7; Mon, 16 Mar 2026 06:42:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w25PN-0001Yd-H7
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 06:42:49 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w25PL-0003gH-Tb
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 06:42:49 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4852f8ac7e9so52509535e9.1
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2026 03:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773657766; x=1774262566; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FtDXSN5JOj7mH7U5ZM2aKU3Da2Ltje+ixVgvhsVRn1c=;
 b=rzRgD0KNNDi85UNH44BEYZEESX5U5w8dZ8aPw0ie//AmBjY/Lt3CBXTsk6sr9yQVuv
 26HYW4CAEUUjmWLcXypFxyN9zAsGJs2Y8JJsQstsWWES3N/mFaps3vqw533eqlBgcIET
 d8Hf4V9FGZEuk9X7WQ+wyDEIxiVmrhG7ZD/eJINQILgD6FCCZB0Ce5Sw4JS5/IwxcJp+
 gWpzYZUS/pa/LdCkmRwTuP7QN8VlfOkUjx/SrZBI5sujl32VluAlKTJwSQ6uSJKZmREc
 Bacv8WVQyTcdUFVuz6KBqSS0NbvyP2ifyReFIy3mkuXH+dMmvHjo83hNUbcaGBdLB2jU
 Jq0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773657766; x=1774262566;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=FtDXSN5JOj7mH7U5ZM2aKU3Da2Ltje+ixVgvhsVRn1c=;
 b=Uu4vmApk561uRrnDZwEwlf4HLlWz4RJ7csWJjyRn4kI9pdrpq3XVbICOGnTit0NcQz
 pk+Py2JNDmBBcME8oj5fEIZYNAUN0NdlJBJhbgxNT5uP0ZHP1mFnXYIA6BquDnGNfje5
 T+XAQglLbzQh23MSPG1pYslcUMul9tQzfiJgs9DKFkN4RkSUqUQ908PhoGpsG16SK+3A
 AySvxVnIcEaXV76s6loPTF/5cpI8TZO+j55RObzmHMjPZO2CMj503JW/1MBdqHVH2u9I
 hjiS6jKPiz3D/MF4GwkUXEESF2xjWRIs9VGpcOmhaB7RlN2Ke6JZkNznM/x9lykvkp3B
 ZKJA==
X-Gm-Message-State: AOJu0YwsCylC3eDa8MpCgojKUaeoQs04mN9yXoh/0v7MngCjLEPtnVSM
 aYLA0ThwSczc9uWr/COsJjIPIWaI4ndKeMMdY4fOXdmD/pF5d2nCDKJhTrn6+K1EbqCKHJ4e5TW
 n/Lp5
X-Gm-Gg: ATEYQzy2c/mZJGxUzcMVYkLrhqttKzxJ0ocFttaiCDzrMTIiq5qjcqO43kozSElxWC3
 HTdLT+urko4Q1a8bkDwsmX3q0cQJLIIi1xW8rb44dbyrxuA11i9wC/tbXvENoD64UU5sPl7lfx1
 Z1yJ4GBhRtn+FXqhSMkX+fkctJlUU+V81bdb1aWce/ttECcyPa9QHV8z2a+Xe7xRy3x3BTF80OZ
 2yvZ+1ZV/8/9Go95i9/MNPVCePetXhmzHamNfw6lMzDApAytiP5FygFHQecm1vAuiU6TExabYad
 l565e4x63OfWCy8lbyiSafUMw5+aIMM/GqHsWClfDgrGGT4hMgx1z6zzmcZ4My3oepnY78mrToV
 JJkG1Af57hCnLS6LASQsEJKU0IbbyAWAo2ptfR4bKUsMi4EtpsFXL9E/o/lyljE0gB8pwr+k+Ys
 jNmbvoVbl1wgfE/5s3Neec5eFVSQr8pFoWKUoa8kt3Mmn7A9J31CdkQeZ2oJsGTxBuehxKmEmiH
 eExVR6KQLA=
X-Received: by 2002:a05:600c:354b:b0:483:2c98:4368 with SMTP id
 5b1f17b1804b1-48556703401mr208811975e9.18.1773657766449; 
 Mon, 16 Mar 2026 03:42:46 -0700 (PDT)
Received: from lanath.. ([81.2.115.145]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48557a74266sm85519135e9.17.2026.03.16.03.42.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2026 03:42:45 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/17] MAINTAINERS: Remove Andrey Smirnov
Date: Mon, 16 Mar 2026 10:42:25 +0000
Message-ID: <20260316104230.836962-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260316104230.836962-1-peter.maydell@linaro.org>
References: <20260316104230.836962-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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

Andrey Smirnov doesn't wish to be listed in MAINTAINERS any more;
remove his email from the relevant sections.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20260306120555.2035421-6-peter.maydell@linaro.org
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9706003812..06a0bd0383 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -903,7 +903,6 @@ F: docs/system/arm/mcimx6ul-evk.rst
 
 MCIMX7D SABRE / i.MX7
 M: Peter Maydell <peter.maydell@linaro.org>
-R: Andrey Smirnov <andrew.smirnov@gmail.com>
 L: qemu-arm@nongnu.org
 S: Odd Fixes
 F: hw/arm/mcimx7d-sabre.c
-- 
2.43.0


