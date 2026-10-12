Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6520DCA9ED0
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 17:05:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGJSH-0005Xn-In; Mon, 12 Oct 2026 13:04:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xGJRZ-0005GY-Ng
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 13:04:11 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xGJRV-000782-Dm
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 13:04:09 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4a021c809e3so20716805e9.0
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 10:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791824636; x=1792429436; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=iXTLXKXswaoS8fK2iy7Al3ZjuS4aIMD3U9wC6kd44r8=;
 b=cn23Fca9PGEbWObYbTPOPn7/XUhNPgxvSvY90DdvI0PL7sTJ+i1Kd/eJ465buSufT1
 ik9JodOPTHRgB8DCIwfWXZIAZWLkhZJ0vacuPdq959gJaKux9gsh2aEiu2TQWz+8wj/4
 vRjX4et2W4CgzS4zLxMD6yIpT+ID7bJlYG9OjaetFveTnnir3s8aj96go35J/cEHawzm
 khNlmwWvdKo/PgCaJMJNyECb72rAY3eaY37DfyECg/eHJtmAe93CHQgz0Cgt1mPnvObq
 2UNGLWAWca9Wx7+XHKHNRVxd/b094+pE0CoilVb6YYmTO/OUPGFIjwqpOJT8N/uxm0xY
 dZ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791824636; x=1792429436;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=iXTLXKXswaoS8fK2iy7Al3ZjuS4aIMD3U9wC6kd44r8=;
 b=RCmKZHBZwHJ1fzxzCUDotIUiglIYKZic7VEVhetQ8uAcimMwvAgDhQrsZ+Oo/d0BQX
 1VMY7MB6I11hcGulBs4aJ9RkbCF0EIaZ4M7Ngms7ouJjhB4wp9zm248IZAbgZjxakZ2w
 W3z1Z3w7JsBapWGY/F/zKt1jdyu7pmfa+rtbgbDsm3GXd/2QJVc/fK+v05sZ2Y7pPrQS
 YmFT7g9fRRmvFrYUz2++slXEvM7nv4Zug08mby3oZzPxSfaw485p0+tzc04MVwdkjTZW
 8J2SgWZLxLi0/zpP4JwaPDIL6M7AI5pbuNujaOZNzx94nhPDheO7wcgWZe+w72HdrEHT
 XI8w==
X-Gm-Message-State: AFq9FYKGdQtbVyMIDv7dorPKc0vlQLzs2/cO80d6aXirDznfel218Fu6
 Hylfko6lVBXrrDZMIB6g61QJcePpcynO9dDrktnEtc6d36LlzRBeqLUxFEv4lEFpIXo=
X-Gm-Gg: AYBFou3/yql6+XtdoAu673esFk3gFhZ48BtitTYhFltNe6OkHWXEBtPX2gW+QUZJp5p
 7l0zaCk4GZN/QxcrUFxNQ/+wE9PmRjpDqn3YMXlEIgjZgoY5MvEZl7a2kWDoxhDZ2bsKtgcewCS
 B67rDefIYp+AA/Wa9OtYC9UUprKs41H0PF57Sl2BCwZ5xfGpX1656YIUD4ptWLKpHfSMsJ5xVWz
 y+u1syTpEg7NNep9o7t2S//pejhpeAMbRBV+GEw8xqL80NxDzSsoVZJxSybRvogJEClsJRWUDyO
 1d9dmKaqlMk9lpXwUrmYyfF5s0HwONmheYCUl3Y1pWFTYII30Fc1/Z/SlMRxv4o7iGjh35rmgSm
 357hZPuwLkHna35ZmFWwFogLQ0ymnBXGKkJdmawSa61/vVBBlLqeXf7LWvh730VJQIY8VQwOiHR
 bdYjDqIG30uG3Q1R64BZcbLZpkEjySDacYxmj8/krkk+RWHs74V9QjwA6yljFktyLqKf/qZA==
X-Received: by 2002:a05:600c:524a:b0:4a0:251f:a726 with SMTP id
 5b1f17b1804b1-4a18e4a54f2mr203339365e9.24.1791824635485; 
 Mon, 12 Oct 2026 10:03:55 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18be8c5e7sm377433855e9.4.2026.10.12.10.03.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 10:03:50 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A04125FA43;
 Mon, 12 Oct 2026 18:03:31 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Zhao Liu <zhao1.liu@intel.com>, Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Brad Smith <brad@comstyle.com>, Ani Sinha <anisinha@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Thomas Huth <th.huth+qemu@posteo.eu>, Keith Busch <kbusch@kernel.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 John Snow <jsnow@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Anders Roxell <anders.roxell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Warner Losh <imp@bsdimp.com>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Yoshinori Sato <yoshinori.sato@nifty.com>, Peter Xu <peterx@redhat.com>,
 Klaus Jensen <its@irrelevant.dk>, Song Gao <gaosong@loongson.cn>,
 qemu-s390x@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v2 06/16] tests/functional: update x86_64 tuxrun images
Date: Mon, 12 Oct 2026 18:03:20 +0100
Message-ID: <20261012170330.1144446-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261012170330.1144446-1-alex.bennee@linaro.org>
References: <20261012170330.1144446-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x335.google.com
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

We now split the fetching of the buildroot image from the kernel
itself. This is because we will want to access additional metadata in
future tests.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260930164649.433573-10-alex.bennee@linaro.org>
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


