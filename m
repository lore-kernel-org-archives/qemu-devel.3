Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CFBDCD4F25
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 10:51:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNq7W-0000mL-40; Fri, 15 May 2026 06:50:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wNq7T-0000ld-RR
 for qemu-devel@nongnu.org; Fri, 15 May 2026 06:50:15 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wNq7R-0001md-VA
 for qemu-devel@nongnu.org; Fri, 15 May 2026 06:50:15 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-488a8ca4aadso79900965e9.3
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 03:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778842212; x=1779447012; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=C30Lsosj0P4uFdNJOQFWFt5BVMseTiXExw/kFxdzvL8=;
 b=kBz5muptu8n1U00xKnxj7onIabngZ9Q5iyHoTWLDUt3RK0wnw3WdtSgUf8Uo8qQgQ6
 M3fyciL04OTDvxK0/VNuPwkBtHQCO5HgqoISjsbNIZR6b67WxRlrp5EVT3ARRvWQJr3G
 W99BLa6pC9UG4hCgrLpldntOjQBhx4LWBzFU+9J152Op1WJgS9bhHlLYstBWHMd/VCyW
 JYsnfRjPIVM72BJ1L2dnu635I2eFqCCvGmQuDauTdE+QXSNUDYolA8T/f9pehg8OJyxG
 hOArLF+JbrUTGuMk17xEACiI1KEvQ0j9x924lnz7gbHsN1nNeyd7M+0SUHuDKwMJYsfP
 w5tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778842212; x=1779447012;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=C30Lsosj0P4uFdNJOQFWFt5BVMseTiXExw/kFxdzvL8=;
 b=V3G16DhSS1IJUF5rvSCPXL0ku2fZPtnSf1VWogZneKAH7Rrt+xonfB6Q+56FYhtZVW
 w4gjwCNSSPEznmnQGWTHEQ37bLPIMiLSyG4csk3LzjCxzAfdiLLf2btPc/m44GRL63pz
 nHeBNJbkk3pCGpc9INR75P3q9gX0Az1RXKz7Ug15TbJYVfN5QxQtgt7wwqcbIQITY5c5
 IjhopqNblEt2h5wm9v9JRJRZ1/DBWxLpY32QvbIxkwRwJVVLCzuAUPxTRpbj2NIo5wp9
 m6ygDKFQnOMa6IgeLtamgnkX784dfYUE3dAYo4R0boVoT2pZ++dFThDrA7IJJNkPUH/q
 7EKw==
X-Gm-Message-State: AOJu0YyFy+lxq6b7gtJAAw01ENZzNxRVTDSRyn+l0PWtY360M35HgKoz
 7nUqhK+uQQvGu+a8kvPa4/UAGOAA7+n/ylfXeRw8jjCo1k5RSvIYe+dx4bCQ3SUN/M5xPk/FG2Y
 vZlAI
X-Gm-Gg: Acq92OHzMUPFpXa3NNsjWQSORjCxI7SOBs7eQaHtJxImYpUQSYDmVuZuPdOHvJjhQsi
 iexFk/KsQSNNjCgx3WQvvWJYonuzrNwV1jD/Ogow51fEQeKaVvgFAo3y2TcDE9EpKppeS5Tqpgh
 iVK0Ayd6UjQLtWw/jiowwyTD5rN5r45SLODcaiMQFQWtcJ326qooR9AZQ25ZaVCKngG3SHuOYft
 IIJ7GgY92+MJ4GLqNpmSqYgvuXSD9pJxjwHb7biWfMLoJewe8s+CH7FaqN1NfE8tAS6tcKaCAuS
 PZrbkjGQtHgjYA9iHjzz2snsRLDdcmlPB8lYW6+2EgFc1au+R3GHTBQ1b07sKTWZlOjCtBcnnGA
 5NXqj7TTi13Iw7JxRlJJiBLYftGCpLnzOt/9tU5ttgIRrImmGlJDoXQ4kn2Xl3zvfG2UQDS2UPE
 KxBKQkCrp1Ye1LgNq28mjC/qCDIn4lh8/IC/Qirzr7Dj8S7aUuEV8W5Q11rOZJ1wd9TXG2+2Ctb
 la6TVF8rMXX+DnhQCNndjLbhsKt/5o=
X-Received: by 2002:a05:600c:c10e:b0:48a:65a5:750f with SMTP id
 5b1f17b1804b1-48fe63265ddmr38494635e9.21.1778842212154; 
 Fri, 15 May 2026 03:50:12 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48feaa2949asm18194355e9.1.2026.05.15.03.50.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 03:50:11 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 22/23] tests/functional/qemu_test/asset.py: Don't use setxattr
 when it doesn't exist
Date: Fri, 15 May 2026 11:49:44 +0100
Message-ID: <20260515104945.4145203-23-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260515104945.4145203-1-peter.maydell@linaro.org>
References: <20260515104945.4145203-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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

The Python os.setxattr() API is Linux-specific, so trying to use
it on other OSes triggers a failure:

  File "/Users/pm215/src/qemu/tests/functional/qemu_test/asset.py",
line 227, in fetch
    os.setxattr(str(tmp_cache_file), "user.qemu-asset-url",
    ^^^^^^^^^^^
AttributeError: module 'os' has no attribute 'setxattr'

Since we only set the attributes here for informational
purposes, skip them when os.setxattr() isn't available.

Cc: qemu-stable@nongnu.org
Fixes: 9903217a4ed013 ("tests/functional: add a module for handling asset download & caching")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Thomas Huth <th.huth+qemu@posteo.eu>
Message-id: 20260501115506.3792110-1-peter.maydell@linaro.org
---
 tests/functional/qemu_test/asset.py | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/tests/functional/qemu_test/asset.py b/tests/functional/qemu_test/asset.py
index 51a434b2b7..0abd89e0a3 100644
--- a/tests/functional/qemu_test/asset.py
+++ b/tests/functional/qemu_test/asset.py
@@ -223,11 +223,14 @@ def fetch(self):
             raise AssetError(self, "Download retries exceeded", transient=True)
 
         try:
-            # Set these just for informational purposes
-            os.setxattr(str(tmp_cache_file), "user.qemu-asset-url",
-                        self.url.encode('utf8'))
-            os.setxattr(str(tmp_cache_file), "user.qemu-asset-hash",
-                        self.hash.encode('utf8'))
+            # Set these just for informational purposes. Note that
+            # setxattr is Linux-only; as this is only informational
+            # we can simply skip it on other platforms.
+            if hasattr(os, "setxattr"):
+                os.setxattr(str(tmp_cache_file), "user.qemu-asset-url",
+                            self.url.encode('utf8'))
+                os.setxattr(str(tmp_cache_file), "user.qemu-asset-hash",
+                            self.hash.encode('utf8'))
         except OSError as e:
             self.log.debug("Unable to set xattr on %s: %s", tmp_cache_file, e)
 
-- 
2.43.0


