Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 596ECC982DA
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 14:26:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7ZWm-0006Qq-15; Fri, 18 Sep 2026 10:25:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x7ZWK-0005oS-OT
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 10:24:58 -0400
Received: from mail-wr2-x10.google.com ([2a00:1450:4864:30::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x7ZWJ-0007s3-26
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 10:24:56 -0400
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-485933b2522so561805f8f.0
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2026 07:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789741493; x=1790346293; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=XdDcSvYFLlowF6oq4e9Gb43a2+KrP1+9GG5FmheqJ8o=;
 b=fKIu0Tui2X1jBUXD5XI0Fj8LdoCejQ9I2yoKvY9e972wAzIjlEsyKzKPJbh9V8Jsao
 AfmnNCtJd7L5OWhLINOLh5r3DL6ocGxHXOHSSVQRROo+FNuhaY3PINihv0iXAQMw60KJ
 T9hHe0H6K4OxwCqtpYmOVPd8uSh+TCdWDtKn0ZfSJU46FxTKnph7Bll13e5AA8R4Kvre
 VfV/Z3guGxq1MdgpZCaFiLt04WUzUGvPD10JictWzeU0o2VPcBjAwGB0tBz9KfawSH4m
 16wJiqDuuG3i5ZvzKsL7Tcc9fdnwiqTIDLKn0c4UuoqhfcwFYzPt4uVlbsaL4r2k7vbR
 t49g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789741493; x=1790346293;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XdDcSvYFLlowF6oq4e9Gb43a2+KrP1+9GG5FmheqJ8o=;
 b=UVwfmXy5n2oJZ/09oiJkxKGr3DxRDzDPmrGcwTE/BQ+vztgoNy91kuLv7vtoiGCwST
 5LrufO57CYs6RqeOrOM6oODbpDgy3PPnZChx8cBX8BVnvH5/qY+oFb3HCnF4nJZ1Ew4e
 ufU/7Tw+MBSXUvNRqdo0/8Sz6osC5bdXg+796dNdXyzZBNRbmW9VMYfb61YU4Cec95P0
 TdRFjF5txuB3w/ZEtbCkZtOZotSrjKxEx0T32X1wFRyDn/kUM+LcPYUh+gnN/0Rg+uFC
 F/WAzXJ/oehjCF7p+xR7raWHxLjkRMHcIHu9F8h7aGy9LPPWegA6t1GXX+CkG+yQjIo1
 /QZg==
X-Gm-Message-State: AFuF++kvhN/lrh4r6RM/nA3ZODREUdhhV5uX1LqNYs/ioEcozv7k+WaD
 Wu8PqQr3QCivfhFnwUGSX9+BNsMxRivMGta7nNGuyW1BpGWum+lQuD40mxnhummagFM=
X-Gm-Gg: AYBFou1uBVkG1fZ0Gr0rnprqqZGP57cCUHxPhRcQKSdaJP5FTizHaqDuCn9yFT+ZbfZ
 pzCiA+jGe5dYN+U8a71tbzvsQFkJRuhurBILsldJ71SiauEUKzY4GwwxuUq4xl4rKBo0N5a0vWq
 IhmELA0Dwaxc0rfo5BlH6RZnwGyu4VZl/enV9DIGNKuBjafeqtFqPEPRx5zCL9C5bmqq/87MITe
 FJ7M5ON3XqVOKKXGcsVztCAUmpxpvSaogpNbdODlYJyL80BNlZPcUcAFIPXJkulGIam+RepYmcp
 4V52jK8k2gLTJlnWF+e8/JFqofChUk0uKFTDJW32mx2k4mzZ1Tcisqr8Dut3vJTFm+ZhWqVhrkh
 vQgIdyWjKS4bmIx+3hJDCb1FQo5g8ToGfr02JMiMvTDX7T1ESjj4koZMzsYVbfxdh2WGeLStM4F
 W+xTjEV0VsmvYtK9rw8U0OmFOwaCLHNWqXK+m0puByaWJfX8RTOCbHTV6T1IL9OOl/Be1Tk3o=
X-Received: by 2002:a05:6000:4283:b0:487:bef:31cb with SMTP id
 ffacd0b85a97d-4871e377669mr7967851f8f.22.1789741493626; 
 Fri, 18 Sep 2026 07:24:53 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4872008023dsm4350217f8f.29.2026.09.18.07.24.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 07:24:48 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 1192C5FCA8;
 Fri, 18 Sep 2026 15:24:31 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Amit Machhiwal <amachhiw@linux.ibm.com>
Subject: [PULL 14/17] gitlab: update the @user id mapping file
Date: Fri, 18 Sep 2026 15:24:25 +0100
Message-ID: <20260918142429.336497-15-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260918142429.336497-1-alex.bennee@linaro.org>
References: <20260918142429.336497-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:30::10;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr2-x10.google.com
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

I needed to fix a POSIX-ism in the script as well.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Tested-by: Richard Henderson <richard.henderson@linaro.org>
Acked-by: Amit Machhiwal <amachhiw@linux.ibm.com>
Message-ID: <20260917165602.3405537-15-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/.gitlab-map-auto b/.gitlab-map-auto
index 28ce448f1bf..3f717a15d4e 100644
--- a/.gitlab-map-auto
+++ b/.gitlab-map-auto
@@ -12,11 +12,12 @@ a1xndr	Alexander Bulekov
 adi-g15-ibm	Aditya Gupta
 agraf	Alexander Graf
 alex.williamson	Alex Williamson
-aliang1	Aihua Liang
 alistair23	Alistair Francis
+amachhiw	Amit Machhiwal
 anisinha	Ani Sinha
 anthony-linaro	Anthony Roberts
 anthonyper	Anthony PERARD
+aroxell	Anders Roxell
 berrange	Daniel P. Berrangé
 birkelund	Klaus Jensen
 bonzini	Paolo Bonzini
@@ -36,10 +37,10 @@ dwmw2	David Woodhouse
 eauger1	Eric Auger
 ebblake	Eric Blake
 edgar.iglesias	Edgar E. Iglesias
+efarman	Eric Farman
 ehabkost	Eduardo Habkost
 eldondev	Eldon
 epilys	Manos Pitsidianakis
-famzheng	Fam Zheng
 farosas	Fabiano Rosas
 gautammenghani	Gautam Menghani
 gkurz	Greg Kurz
@@ -51,7 +52,6 @@ imammedo	Igor Mammedov
 jasowang	Jason Wang
 jmacarthur	Jim MacArthur
 jsnow	John Snow
-juan.quintela	Juan Quintela
 kbastian-qemu	Bastian Koppelmann
 kmwolf	Kevin Wolf
 kostyanf14	Kostiantyn Kostiuk
@@ -67,6 +67,7 @@ mauromatteo.cascella	Mauro Matteo Cascella
 mcayland	Mark Cave-Ayland
 mdroth	Michael Roth
 mediouni-m	M. Mediouni
+mjrosato	Matthew Rosato
 mjt0k	Michael Tokarev
 mstredhat	MST
 npiggin	npiggin
@@ -79,6 +80,7 @@ pipo.sk	Peter Krempa
 pkrempa	Peter Krempa (work)
 pm215	Peter Maydell
 qemu-janitor	Qemu Janitor
+raphael.s.norwitz	Raphael Norwitz
 rathc	Chinmay Rath
 rth7680	Richard Henderson
 schoenebeck	Christian Schoenebeck
diff --git a/scripts/gitlab-map-update b/scripts/gitlab-map-update
index c134c226aa2..743ad11900d 100755
--- a/scripts/gitlab-map-update
+++ b/scripts/gitlab-map-update
@@ -33,7 +33,7 @@ glab api --paginate /projects/qemu-project%2fqemu/members | \
     .gitlab-map-auto.tmp
 test $? != 0 && fail=1
 
-if test $fail == 0
+if test $fail -eq 0
 then
   grep '^#' .gitlab-map-auto > .gitlab-map-auto.new
   LC_ALL=C sort .gitlab-map-auto.tmp | uniq >> .gitlab-map-auto.new
-- 
2.47.3


