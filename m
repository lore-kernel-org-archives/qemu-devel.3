Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5265AC624D6
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 14:45:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x28fG-0002vs-NP; Thu, 03 Sep 2026 10:43:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x28fE-0002t8-2m
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 10:43:40 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x28fC-00047p-3E
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 10:43:39 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-47de0093c42so2436511f8f.3
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 07:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1788446617; x=1789051417; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0cFMp897/2LhAMY3XQX2UH5MPXIwRH5TBMsVmASGwDU=;
 b=TC88sOCsTcCsdPYf8QnwLerOYhHDu2YMaY5RF9dHp2A/yEWEGJzgnDzlkPZyJJ3Ja5
 kp+Br9bm9oInV9vKLCHxTtJAcE4aZo2ZFQxGjfno5kvcuY66JvAouv0JaIN2lBIe6G45
 pjco0hO5aJAIT44kRKYZrSvy0hJErSEu9zWqkPApFizc/+wjPtPsCRte2GxjXgnY6WSV
 5Vj2FadZ755FXLSvHai5zD7bN2Oj8kVESf8ERvmMbvH0AvaAHWTOzqzctetb84mXvHPk
 sY8i7YvdzohJCainluYJiNSyVME3iwejLNYUiGi7Q6qWENJIFDMeOdQ/5Q8p/beSOT44
 5UhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788446617; x=1789051417;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=0cFMp897/2LhAMY3XQX2UH5MPXIwRH5TBMsVmASGwDU=;
 b=e/gXpMJMaY/KefuXdOCRIQaNuTm0PE1LbBXVtCES3xyXxDPm7ltb5UnGRkmgM4nB7v
 2AMyETL2aXAHfKTQhOk0JEM4tElUtbZ5DNbiUKvFXp8l6DXGjUzkZB/JRQctu8OSLIoP
 UaFj8y0IjuxIAIGWAMBPDiQ2BeApLzDH3QNA5TFpjaJYL8IG3mjLAcANh2x4AMb5OsA9
 Cy+04ERdEpg7i7DvZmeXt311KF04y61O0AM/G4bLwe5BOOaxku++zJWw+v/kHwSq3D3b
 QWl2ZC+ARKDxoxT93udv55g4yxRvMHX0i3g0iY/j9jCtlRLa2Dm/2nA6CVxZEZnV1pb7
 +o8Q==
X-Gm-Message-State: AFuF++nAbAXJoBU9PDiqC+AjNWdfzOsKtI/wf2rQPKayr/MG0NuIwRrm
 ss3C542RDEVhiI613gD4HgLioLjuDtGc++HM2pbP6r4x32M73mOktJBJwFLYEfwqJGgy8P6IQn0
 aleiA
X-Gm-Gg: AYBFou16+uF+Hhscv2iyRX96FDuBq/g373VvoWjqv0u9Rbp2dCQCHIspg0m7aFqnjgr
 27DSPTKRooMJzLtc3wM1oc2K78mgD0KXQoqvBhvmZDnXHq1VX+R7jZcIVynB/ksnSIoNJaNAiZ6
 wbG0I7Y66em3vDpVSl5H2DZQmM0hJawq98XAG45kQ95aRvSxDPSiyUnJDvOxvxN1+jHZmws8cCi
 ax7ycskJmgxozDKIxxyPeAXwHlpiLWg4id37Ry1BMXzYWYetq3//fJVA42fdOvNcB2ni4Ff4mIe
 Pot5MvHaj9FQlnysvCrr/lEyqM11ybpGPw85JaNcuT6Gv3s4sLcWzZL/ETUks2R2KpsAkoRx9ou
 yUsYjsy7pcPX+v3gSy1tu0pfK/7bEjycKIbYZBLD9LfT7k1+vMEYCLzNWOtLOgKYTyYhh+w21Q6
 XXImlmvnXA7FF+7yP7fFdQtZ2iVYK8ryaKPKrQ1gsWHU8mXr1RJTXNMPcX
X-Received: by 2002:a5d:5f53:0:b0:482:de48:c445 with SMTP id
 ffacd0b85a97d-4858608849bmr1657791f8f.11.1788446616604; 
 Thu, 03 Sep 2026 07:43:36 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:83cc:ab98:cda9:7dc])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48448ee9cf7sm15165483f8f.25.2026.09.03.07.43.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 07:43:36 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH v7 22/25] iotests: cover the qemu-img bitmap operations on
 parallels
Date: Thu,  3 Sep 2026 16:41:40 +0200
Message-ID: <20260903144143.2328870-23-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903144143.2328870-1-den@openvz.org>
References: <20260903144143.2328870-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=den@openvz.org; helo=mail-wr1-x42c.google.com
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

From: Denis V. Lunev <den@openvz.org>

qemu-img-bitmaps drives convert --bitmaps and every qemu-img bitmap
sub-command, but for qcow2 alone. It is built on a backing chain and a
rebase, which parallels has neither of, so half of it could not run
there and the format is left with no coverage of any of this.

Cover what applies in the parallels test instead. A copy made with
--bitmaps has to carry them, and raw has to refuse them. --merge and
--clear leave the bitmap count alone, --remove-all sweeps it to zero,
and --remove-all --add in one invocation leaves only the bitmap which
was just added.

An image which was not closed correctly is left out. parallels-checks
covers that already, next to the code which drops the bitmaps.

Cc: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 tests/qemu-iotests/tests/parallels-bitmap     | 39 +++++++++++++++++++
 tests/qemu-iotests/tests/parallels-bitmap.out | 12 ++++++
 2 files changed, 51 insertions(+)

diff --git a/tests/qemu-iotests/tests/parallels-bitmap b/tests/qemu-iotests/tests/parallels-bitmap
index be0ba8185d..8ae9314114 100755
--- a/tests/qemu-iotests/tests/parallels-bitmap
+++ b/tests/qemu-iotests/tests/parallels-bitmap
@@ -273,6 +273,7 @@ stored = file_path('stored')
 copy = file_path('copy')
 STORED = '9b7b8b2e-1c4a-4d3f-8e6a-1f2d3c4b5a69'
 OTHER = '11111111-2222-3333-4444-555555555555'
+MERGED = '22222222-3333-4444-5555-666666666666'
 
 
 def read_header(off, fmt):
@@ -434,3 +435,41 @@ log('--- and the image is still readable')
 info_out = qemu_img('info', '-f', iotests.imgfmt, stored, check=False)
 log('image opened' if info_out.returncode == 0
     else iotests.filter_testfiles(info_out.stdout).strip())
+
+
+# qemu-img-bitmaps drives these for qcow2 alone, as it is built on a
+# backing chain and a rebase, which parallels has neither of.
+
+log('--- bitmaps can not be preserved into raw')
+make_image(STORED)
+raw_out = qemu_img('convert', '--bitmaps', '-f', iotests.imgfmt, '-O',
+                   'raw', stored, copy, check=False)
+log('    ' + iotests.filter_testfiles(raw_out.stdout).strip())
+
+log('--- convert --bitmaps carries the bitmaps into the copy')
+make_image(STORED, OTHER)
+qemu_io('-f', iotests.imgfmt, '-c', 'write -P 0x11 1M 64k', stored)
+qemu_img('convert', '--bitmaps', '-f', iotests.imgfmt, '-O', iotests.imgfmt,
+         stored, copy)
+copy_info = iotests.qemu_img_info('-f', iotests.imgfmt, copy)
+copy_data = copy_info.get('format-specific', {}).get('data', {})
+log('    %d bitmaps in the copy' % len(copy_data.get('bitmaps', [])))
+
+log('--- merging one bitmap into a new one')
+qemu_img('bitmap', '--add', '--merge', STORED, '-f', iotests.imgfmt,
+         stored, MERGED)
+log('    %d bitmaps stored' % len(bitmaps_reported()))
+
+log('--- clearing a bitmap keeps it in the image')
+qemu_img('bitmap', '--clear', '-f', iotests.imgfmt, stored, STORED)
+log('    %d bitmaps stored' % len(bitmaps_reported()))
+
+log('--- remove-all sweeps every bitmap of the image')
+qemu_img('bitmap', '--remove-all', '-f', iotests.imgfmt, stored)
+log('    %d bitmaps after remove-all' % len(bitmaps_reported()))
+
+log('--- remove-all with --add leaves only the new bitmap')
+make_image(STORED, OTHER)
+qemu_img('bitmap', '--remove-all', '--add', '-f', iotests.imgfmt,
+         stored, MERGED)
+log('    ' + ' '.join(bitmaps_reported()))
diff --git a/tests/qemu-iotests/tests/parallels-bitmap.out b/tests/qemu-iotests/tests/parallels-bitmap.out
index 994c67390e..df6f676106 100644
--- a/tests/qemu-iotests/tests/parallels-bitmap.out
+++ b/tests/qemu-iotests/tests/parallels-bitmap.out
@@ -92,3 +92,15 @@ read 65536/65536 bytes at offset 0
     0 bitmaps stored
 --- and the image is still readable
 image opened
+--- bitmaps can not be preserved into raw
+    qemu-img: Format driver 'raw' does not support bitmaps
+--- convert --bitmaps carries the bitmaps into the copy
+    2 bitmaps in the copy
+--- merging one bitmap into a new one
+    3 bitmaps stored
+--- clearing a bitmap keeps it in the image
+    3 bitmaps stored
+--- remove-all sweeps every bitmap of the image
+    0 bitmaps after remove-all
+--- remove-all with --add leaves only the new bitmap
+    22222222-3333-4444-5555-666666666666
-- 
2.53.0


