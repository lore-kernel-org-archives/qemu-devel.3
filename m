Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8551BCA5FEC
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 12:28:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDLJi-0006Rx-Or; Sun, 04 Oct 2026 08:27:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xDLJe-0006PX-I5
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 08:27:42 -0400
Received: from mail-wm2-x10.google.com ([2a00:1450:4864:31::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xDLJc-00076d-Sa
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 08:27:42 -0400
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49fff72474fso6634855e9.3
 for <qemu-devel@nongnu.org>; Sun, 04 Oct 2026 05:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791116859; x=1791721659; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=QZdFScQg3NGSD60DWAXoWDgIEl9U8i+CSKMs+i+Hrx0=;
 b=Kg+Q+CednN3+2IsEkif+unZhKwY9VaMrEElU3cfn8nWRbgXR+Q2sdjM/yH84wdgYOv
 dU1TuP+3/nV8afZjKp9FlCCNb+SEe23wreNXia+WGIdbGOtRdmUa/mQz0PykPHjXrNZs
 +gNO38gAnZgVwr+WscWp9/ACedC9tcXIWzlVb3ybXnwml4N3OTX2SDEnwR44VUm3pSWw
 GpzykPpD+xbVg2Vey42eD0YWMLtqRx0QS4hvxTuh6XRG3l7J+SPvsv4o9tmYXVeYyRDe
 hyorQFucLdfkD8IoXoFDLvLgjxjuJNmXjmeZAsV//SfCe8OWkj9jB+p0872oPg/B+ReR
 uKVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791116859; x=1791721659;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QZdFScQg3NGSD60DWAXoWDgIEl9U8i+CSKMs+i+Hrx0=;
 b=A+NpRvNKREw6Lr72dsX+p4MgC3eU6ubrDPvKF65XDdcNA3e7smv0uPNa57v+/ewhHN
 WWBJcMQdKxU1zEfpuvVjOQbMaf05DFGMGNr1bsFk2FfOX9lRSFFafKdYxJVNRPK+6cyI
 78S8f49o9f2ipNRmp7X80jGJpv7831fqfuxxHJegUbjyp+sZoywFxHRBJrkpePyamAP+
 r/0WL0B5U9Ax7X2vjCsajjLTHScXfPYsLmwzkIin3dsy6M5U5ceACyjqoL7CG8lT8qe6
 +gH9jiDd8bwH/yohbOmQM3v/3omqeEFDkCfdEfpFfHhyNIVuM3wvZIebH++KKVLOPBt1
 z6kQ==
X-Gm-Message-State: AFuF++letgDis4t4NHAHfBYL4wBaEv6BJf8GFE3eIPQLwyJNosaRoEG8
 QIyy4RRaYyuA4VUftyrbLWf3+zb5zDHQebcCu1D0EuyUpGBVId7i9n7g+itgdw==
X-Gm-Gg: AYBFou3VvbxtSc7x0PR2AoNJpi3odKhogSEBJbTSwPbGafhRZQKfV1wuCMpUqTRVdTj
 Q98AoF612be/nzkkxaZzTdCFzY+946MTCx3jLA1AKszrJrNdG58mTe3NZXUMuaECcqcMg6Ejn1Z
 aicTPp6GCa+xvLLPNcmhd7osUnRdyL4eEnPAEDZ+ZcJTtq8/TwgTE6HIV3G42J0ZYDtTgpMYfOR
 T3TKnAWTbqcEwpabVSuHvsh8ZvD/YCGATZ+H2sJlOMZuzdw+yogO0qV6tnpOOt5kAljEM/f5I5E
 5GDzo0b9f47LGZbfEtZ6rjPblK/Xyo952EqHikxDaSO2LAzanZuOQFLb7nwFpGmIL0cQvYn+j9t
 pbbt21z605RWb25X3YQJPn/z3GzKi6UeR7hsO7gPvy730ZhDg3wMASzSwAIUq8rctZIm2kEKc6a
 ngHUSxVGrVNv8cR5/asNZVxYXHHqR4euEdrXUcO+aajvZfSUf6B3ANMFIiiq4rtAnfOCHLQkumF
 TH83irzwuLQiDZbA0p1Ho0xF+2kWA4BdRfJjrvtzqPrlOfO
X-Received: by 2002:a05:600c:3b2a:b0:4a1:6af4:c6be with SMTP id
 5b1f17b1804b1-4a16af4c9damr57707825e9.34.1791116858981; 
 Sun, 04 Oct 2026 05:27:38 -0700 (PDT)
Received: from archlinux (pd95eda80.dip0.t-ipconnect.de. [217.94.218.128])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a027698f13sm242319975e9.1.2026.10.04.05.27.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Oct 2026 05:27:38 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>,
 Alistair Francis <alistair@alistair23.me>,
 Bernhard Beschow <shentey@gmail.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Jason Wang <jasowangio@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Bin Meng <bin.meng@processmission.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v2 05/30] docs,
 tests/functional: Drop redundant CLI arguments in imx8m*-evk
 invocations
Date: Sun,  4 Oct 2026 14:26:21 +0200
Message-ID: <20261004122647.3913-6-shentey@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261004122647.3913-1-shentey@gmail.com>
References: <20261004122647.3913-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::10;
 envelope-from=shentey@gmail.com; helo=mail-wm2-x10.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Both boards provide defaults matching real hardware. No need to ask
users to repeat these. Also, remove these redundant arguments from the
functional tests such that the defaults get tested.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 docs/system/arm/imx8m.rst                   | 2 +-
 tests/functional/aarch64/test_imx8mm_evk.py | 4 +---
 tests/functional/aarch64/test_imx8mp_evk.py | 4 +---
 3 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/docs/system/arm/imx8m.rst b/docs/system/arm/imx8m.rst
index 1bcb8255be..5348757089 100644
--- a/docs/system/arm/imx8m.rst
+++ b/docs/system/arm/imx8m.rst
@@ -79,7 +79,7 @@ For i.MX 8M Mini EVK:
 
 .. code-block:: bash
 
-  $ qemu-system-aarch64 -M imx8mm-evk -smp 4 -m 2G \
+  $ qemu-system-aarch64 -M imx8mm-evk \
       -display none -serial null -serial stdio \
       -kernel Image \
       -dtb imx8mm-evk.dtb \
diff --git a/tests/functional/aarch64/test_imx8mm_evk.py b/tests/functional/aarch64/test_imx8mm_evk.py
index 86725991f1..73d286167c 100755
--- a/tests/functional/aarch64/test_imx8mm_evk.py
+++ b/tests/functional/aarch64/test_imx8mm_evk.py
@@ -52,9 +52,7 @@ def test_aarch64_imx8mm_evk_usdhc(self):
         self.require_accelerator("tcg")
         self.set_machine('imx8mm-evk')
         self.vm.set_console(console_index=1)
-        self.vm.add_args('-m', '2G',
-                         '-smp', '4',
-                         '-kernel', self.kernel_path,
+        self.vm.add_args('-kernel', self.kernel_path,
                          '-initrd', self.initrd_path,
                          '-dtb', self.dtb_path,
                          '-append', 'root=/dev/mmcblk2p1',
diff --git a/tests/functional/aarch64/test_imx8mp_evk.py b/tests/functional/aarch64/test_imx8mp_evk.py
index 99ddcdef83..2ec421c326 100755
--- a/tests/functional/aarch64/test_imx8mp_evk.py
+++ b/tests/functional/aarch64/test_imx8mp_evk.py
@@ -52,9 +52,7 @@ def test_aarch64_imx8mp_evk_usdhc(self):
         self.require_accelerator("tcg")
         self.set_machine('imx8mp-evk')
         self.vm.set_console(console_index=1)
-        self.vm.add_args('-m', '2G',
-                         '-smp', '4',
-                         '-kernel', self.kernel_path,
+        self.vm.add_args('-kernel', self.kernel_path,
                          '-initrd', self.initrd_path,
                          '-dtb', self.dtb_path,
                          '-append', 'root=/dev/mmcblk2p1',
-- 
2.56.0


