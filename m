Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 449ADC88E41
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 01:14:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4ppO-0007cX-GK; Thu, 10 Sep 2026 21:13:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x4oQD-0001ny-PS
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 19:43:30 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x4oQ7-0007It-7K
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 19:43:10 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-49b0d78a801so3505265e9.2
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 16:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1789083781; x=1789688581; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WH4NtQS27vnM9CBskaa8A4wfHHtgS6Dz+fFxVJqp21Q=;
 b=lVrmdp1LMxvSVaWL4msmkJ5uOa0oIgh89MiCTtGHZkhz8gh1kPtDRNnb3F3l3tNY6U
 hzGtjyO7k46+4F+epLRzP8+3LELcrsm4/3XlVUQ70dS2ezjn/iVBrYrIElgNRRSxPM3c
 TsyfNjp7XFLUJP4iDLQe61E0IiYVADwCc19SWtuqG2v+93jEBCQNbp3tP37o+4/babna
 Zy/Edc0QX6i+RG7DRP+5XCoePr/0DTAkpCGby+nvunolrlgcJU66ibYbHg8G1q/4okUR
 aQavHbugPY9USpCew5myGg/hZ8AE21o+b7j17e3P89n6hpPyMKvIGtUnhrySwv3K8HzT
 mj0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789083781; x=1789688581;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=WH4NtQS27vnM9CBskaa8A4wfHHtgS6Dz+fFxVJqp21Q=;
 b=JmCAUhnHHOv3PWRhCkoLzCG6/xMiPEbtjTPsA9bmR3KieoYCGwx7E9STQhOoRjHtmO
 u1H6P2uKHvtxDAALPRwek+SvLDdlTB6AH2FI/LR4M5KFEfhkrVdy1UCpdOt1aJ4+t2eI
 i2kSnph2cgg/4RtiY84nAHT7N3o1FWssiCtnpXUhAP6dfl6Z9it5Q4DYBWrdk/FjQkFo
 iLfD92RZBlv1CAZR01eyEMuMWkiRhYHeWXO1wownbX4aDyrnKBbKc3FUsbPqe0QTAiJ5
 dCY7vV9omxwVK1Z8D/yZnmD+SVB8vTaOCk8EAzzGc1pqSqLRa2pB/Ekwrr/zgfDLh+aJ
 hVlg==
X-Gm-Message-State: AFuF++npNmejEzzPdgfyyUQMWmunb6aWAoeLSubheyTTnv6JCTOFh7Pp
 f9zeUqKOUvFoCOmLpOKlKNxaxU65YtTH22GpTi3edQrUbrY/fBa3eduz4JwaNItgBIY=
X-Gm-Gg: AYBFou3xnYP9OpUQziLj4DhTW7SYS459IskDfJ62PPCDYK9MdTKFY3yTjyLDeU84HFK
 4dMTDNk6yu9kpMyeLovahE85p46EZDrQB9I2gleYkhIWib8pf3GxsWHG5XQ/h6A3YFZWFaK5f6L
 OhZIxX1scWCZQJ9GzGaX5GUCH4YI8PwjuvH8pWIJqq8Jmvt2DNEJrQx86OCdhaLwLN0QbBaFQVl
 E/QkPBWXttBMLSHPgHvquD71gXeoEUb+L8/7XD+5YS+ifVqvRNuFbB/76ajsP2mLg7xICMW17eH
 KBG1DZgTTcTI72MWdofoH7bqL46oNsMsBZlavs71uCnbDKrihm6SzUT8fDDjft2B/nnGz5ob11C
 wECuLg3cyrtqDeC2Po9Ya/9mmz+YwIcqzuRK8ouWMq6Gw+bm/048WpJn5aZ17Oshh+08dYH6Qhd
 DaNkGo55WyS4AYe5t8mPfOXKx3VZZcmvjegvTUFUHihkfB+O4/3hhEsEb87AplHY04IRx+
X-Received: by 2002:a05:600c:3b1f:b0:49c:cee2:1697 with SMTP id
 5b1f17b1804b1-49e619e0f85mr14174575e9.16.1789083781264; 
 Thu, 10 Sep 2026 16:43:01 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:54f3:cc87:964b:3604])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e62231360sm7726775e9.4.2026.09.10.16.42.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 16:43:00 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Alexander Ivanov <alexander.ivanov@virtuozzo.com>
Subject: [PULL 28/29] tests: Turned on 256, 299,
 304 and block-status-cache for parallels format
Date: Fri, 11 Sep 2026 01:42:21 +0200
Message-ID: <20260910234222.3039975-29-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910234222.3039975-1-den@openvz.org>
References: <20260910234222.3039975-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=den@openvz.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>

These tests pass with parallels format. Add parallels to supporting
formats for these tests.

Cc: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 tests/qemu-iotests/256                      | 2 +-
 tests/qemu-iotests/299                      | 2 +-
 tests/qemu-iotests/304                      | 2 +-
 tests/qemu-iotests/tests/block-status-cache | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/qemu-iotests/256 b/tests/qemu-iotests/256
index f34af6cef7..1a4c9c6885 100755
--- a/tests/qemu-iotests/256
+++ b/tests/qemu-iotests/256
@@ -26,7 +26,7 @@ from iotests import log
 
 iotests.verify_virtio_scsi_pci_or_ccw()
 
-iotests.script_initialize(supported_fmts=['qcow2'])
+iotests.script_initialize(supported_fmts=['qcow2', 'parallels'])
 size = 64 * 1024 * 1024
 
 with iotests.FilePath('img0') as img0_path, \
diff --git a/tests/qemu-iotests/299 b/tests/qemu-iotests/299
index a7122941fd..d8c4399446 100755
--- a/tests/qemu-iotests/299
+++ b/tests/qemu-iotests/299
@@ -23,7 +23,7 @@ import iotests
 
 # The test is unrelated to formats, restrict it to qcow2 to avoid extra runs
 iotests.script_initialize(
-    supported_fmts=['qcow2'],
+    supported_fmts=['qcow2', 'parallels'],
 )
 
 nbd_sock = iotests.file_path('nbd.sock', base_dir=iotests.sock_dir)
diff --git a/tests/qemu-iotests/304 b/tests/qemu-iotests/304
index d465a519a9..03c7c1cbe3 100755
--- a/tests/qemu-iotests/304
+++ b/tests/qemu-iotests/304
@@ -23,7 +23,7 @@
 import iotests
 from iotests import qemu_img_create, qemu_img_log, file_path
 
-iotests.script_initialize(supported_fmts=['qcow2'],
+iotests.script_initialize(supported_fmts=['qcow2', 'parallels'],
                           supported_protocols=['file'],
                           require_hmp=True)
 
diff --git a/tests/qemu-iotests/tests/block-status-cache b/tests/qemu-iotests/tests/block-status-cache
index 5a7bc2c149..ade3d5b169 100755
--- a/tests/qemu-iotests/tests/block-status-cache
+++ b/tests/qemu-iotests/tests/block-status-cache
@@ -131,5 +131,5 @@ class TestBscWithNbd(iotests.QMPTestCase):
 if __name__ == '__main__':
     # The block-status cache only works on the protocol layer, so to test it,
     # we can only use the raw format
-    iotests.main(supported_fmts=['raw'],
+    iotests.main(supported_fmts=['raw', 'parallels'],
                  supported_protocols=['file'])
-- 
2.53.0


