Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C28EFCA5FC4
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 16:48:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBxSd-0001I8-BV; Wed, 30 Sep 2026 12:47:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xBxSS-0001Bn-NU
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 12:47:06 -0400
Received: from mail-wm2-x10.google.com ([2a00:1450:4864:31::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xBxSP-00033C-AQ
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 12:47:04 -0400
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49b912df756so43350245e9.3
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 09:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790786820; x=1791391620; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=e3zw8Ahu2F9Hn+gtIaxZUH224o4pxqjOrd9D4/hl8OI=;
 b=pdk7r2KoHEKCkSIHoLzj9nbR7oQ3JjOrdenGCkDDmno/7S/Lluc+OABbIvp5kPjiUX
 q+I0aChQrcCoWJL60kBbP4c9MGjOmaCDLcYvwAAHJEQRzsHhqL8XMAhjCMMWN+fR0pbU
 vUi7tzM7nFfkBq335EUVSpO+EJWavn3fz+t5ojA/89S2ebmxCy7iogkfWpxm+hQ7aOUp
 Vs4C5r4353IVwd0dU0x3O/zUFSUNOCWEYpsYk2/3B8rWMbSAQi165LXXK4MygzC+b4r9
 ni6rVz97GK5kkaSEe98a7db7Hx9iaXVBTqzNxLugrRz1AaVtczMr5XEOjTpdnWieb+fp
 1B8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790786820; x=1791391620;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=e3zw8Ahu2F9Hn+gtIaxZUH224o4pxqjOrd9D4/hl8OI=;
 b=ey5/psTgVZ53+92/9VPWO8NfdSGA8j9D81jToAylRcilFDitGxAjDfw5davmrLrtv0
 1SEPFtOxtxB3I00CF17LV9aHqfwA95MWtIutl5wlcZ+PoUxVHp6ruIjj/BK210tLCHNW
 7x19y0ZDBThZSLFuFLPR78cxAPG/7unVkdBDpKKyUufVcEA8QiQGAhtrcO8SIgOLXlpz
 +DGAaP8zAehS9gt4K4owEaywLXtOYzB6ykTXcHaX1DR67XI+OunAnhNyAN41Y7DCoB7u
 LyONw+xFn1nAHv+ZDLFJcAZBlYcZXBeYpM4MWSCVLRK8POVGzp33ElfJKuPHRUL/BL/S
 MxhA==
X-Gm-Message-State: AFuF++nPMT4DLIZflJ4lDGLjxxeabGovP5gRrtW8ruRoZKXH3cO3AhvA
 UkSVrMxZCfyMhoYFSorwfYvoD1WnSO3z6W7FykVq7ya93KsN1ywB6kX0ERVXkTABp0E=
X-Gm-Gg: AYBFou0dQVuLeqrU7l+xixA2O7+XQKq9z55ED4gaWTsKMI2GX9lQvI1U5iFy+656FSA
 yp9S+uMmrp57LM56Jz9ExJF9B7J9R2g6/HcdDywl26+d3N/fWW0kQpLoYpzYbTarW6LB/tfzhzm
 kcxDC4OTXAqE5BW1v/70zyIhLW5uiR8SO4QFtiESt0r0wwhSSimbYfllzTUvihLr1MVq+5vXEVp
 gLK6W0Qr1MZlB6xfVO4UUEGKLLLxJfxtzpoLqHcMYtpqoT7jokvR7pNUAeovY2FDP8+/BtiAVrW
 /5TT7ORrW8dELrS+8C/ANqU7szqlvGM27BFuHwQxOVE9wfCGSMSHMh2FdoHNQO0QDSdIvLM5Kud
 XDIp0pS5SCSs8vqhDDZS7fwkqvXe4aJoB0xvq/F6ujWWJW6583dWJFJbewkJI4Ie863e7czXfsv
 J0qB/sG5R3EVtJXwAW8X8vYuz1Grw3M/qi9VN4p+zoFKOIlWL8QcKsodWGyn2cT3j2ATBjvA==
X-Received: by 2002:a05:600c:45d3:b0:4a0:4f6:3dc5 with SMTP id
 5b1f17b1804b1-4a01affe4camr30782715e9.7.1790786819689; 
 Wed, 30 Sep 2026 09:46:59 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b068ff95esm289774f8f.12.2026.09.30.09.46.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 09:46:56 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A1A5F5FBB5;
 Wed, 30 Sep 2026 17:46:50 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Song Gao <gaosong@loongson.cn>,
 Ani Sinha <anisinha@redhat.com>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 John Snow <jsnow@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Cornelia Huck <cohuck@redhat.com>, Thomas Huth <th.huth+qemu@posteo.eu>,
 Zhao Liu <zhao1.liu@intel.com>, Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Brad Smith <brad@comstyle.com>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Anders Roxell <anders.roxell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Klaus Jensen <its@irrelevant.dk>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 09/13] tests/functional: update x86_64 tuxrun images
Date: Wed, 30 Sep 2026 17:46:45 +0100
Message-ID: <20260930164649.433573-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260930164649.433573-1-alex.bennee@linaro.org>
References: <20260930164649.433573-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::10;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm2-x10.google.com
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

We now split the fetching of the buildroot image from the kernel
itself. This is because we will want to access additional metadata in
future tests.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/functional/x86_64/test_tuxrun.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/functional/x86_64/test_tuxrun.py b/tests/functional/x86_64/test_tuxrun.py
index 729f6447d05..026b373accb 100755
--- a/tests/functional/x86_64/test_tuxrun.py
+++ b/tests/functional/x86_64/test_tuxrun.py
@@ -17,11 +17,11 @@
 class TuxRunX86Test(TuxRunBaselineTest):
 
     ASSET_X86_64_KERNEL = Asset(
-        'https://storage.tuxboot.com/buildroot/20241119/x86_64/bzImage',
-        'f57bfc6553bcd6e0a54aab86095bf642b33b5571d14e3af1731b18c87ed5aef8')
+        'https://storage.tuxboot.com/kernels/6.18.54/x86_64/bzImage',
+        '24a3ade610c2cc426ff821050de8a35930b0371357d94cc2c334abac6658552b')
     ASSET_X86_64_ROOTFS = Asset(
-        'https://storage.tuxboot.com/buildroot/20241119/x86_64/rootfs.ext4.zst',
-        '4b8b2a99117519c5290e1202cb36eb6c7aaba92b357b5160f5970cf5fb78a751')
+        'https://storage.tuxboot.com/buildroot/20260924/x86_64/rootfs.ext4.zst',
+        '8e310455b0244414ccff29c507f7ccfd4032e3587cc405e49ab0322738e3e27c')
 
     def test_x86_64(self):
         self.require_accelerator("tcg")
-- 
2.47.3


