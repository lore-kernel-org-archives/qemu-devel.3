Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2A47CA9ED0
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 17:11:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGJYQ-0005fO-FO; Mon, 12 Oct 2026 13:11:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xGJYO-0005f1-H7
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 13:11:12 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xGJYM-0000DU-Mi
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 13:11:12 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-49d0da752ffso20168605e9.3
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 10:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791825069; x=1792429869; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=wzTxgcJt5LOfEvgdp0Bdy8cA6LUtFfiG4X3ZmZDEEX0=;
 b=uu/oJZJEeUSAyw0eSYlJsSWIAKAZIaQrsoyaMjFysN+Fy+Jjr5nfQNrj3qn05uNNu5
 1EQSwnJFPDc9qjVhr4NHukL3KQuzq0Qz8YR/J4+WTIml2k0YJkTau2e4zNqkpeu2sFGh
 8kzK30q9PsrKDHDno1L3mLkK8Ca0wuBB62dB58oCk0fTwylEtX2ln7c8/xC7EK3PLi0T
 Sl6xIkfPvqv6vSl38KqeL4g1o7Tpbm5m9qu27eLKPqcl1Clqx9QnnsgJ7xyNXvU/dPqH
 jfdmZSa+k6vlYK2E8GyijnPiwq2bsHCgobBlfFaSyeBdXGGfqkhuEb4ueagxwZOOBAOg
 1a5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791825069; x=1792429869;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wzTxgcJt5LOfEvgdp0Bdy8cA6LUtFfiG4X3ZmZDEEX0=;
 b=yUF+hCS40fK9gVztYGVFS7rYynvVrKEQMu1+JlEkp7+6bBAKrONul3awncV8Y4wh5i
 4LDtfNMcVRvSQtdo4M6WwWCBXo35Tzs68QCli0AFggXjMtQsQknInKj/cfOyhXR5W3+D
 +64AiL5dvD3qX4YjDiPX0/LvKqIJBBtYYs3llAxgbEuug9gIrh7RJPoHtG2hiwVfP9eg
 36qJr3Db+Sf19oIvUPM1dINN2Hp99mpF7iMi68H9Gs3zEt6OdJXzd80Wquoh8YMnoldc
 M6mR+I2/P6ulffufN11qcth1yIPnwF+VLZ16R7XcwtYcipItKnpbcj1IfiuK31nxd3Hg
 hytQ==
X-Gm-Message-State: AFq9FYIVUtRbG+RPgcA+/DrGj7oe9HGXYwchb2EGsTV/XgNGmg5qXT+7
 Gi/F7ZZAMGDFMcS+l1y7zn9zynlws2RFCpL0xdrR+nwNKvZf/E9KA9JLcJkVquyjcI8=
X-Gm-Gg: AYBFou1nVIqbVVMSqZoHpOIZ/V6WaS9hj9Ix3RaIpXKb4nXrV4cs38i9lpplzodMyEq
 +g1RdFbHdH7Cs0DoBg/dnQG1UMzlLlVXdmOqQjZA83t2BqvqWQccD1crRE8Hm0YmDGx81530WKU
 6YUQmqdA5TYx3WueMZB4ZTqSbWSdNGIopixuIHO0AyrvCPpC0HZbXmOF8O1ws3ftbFkqSkVN5F8
 yxX8WXCfwFa8uWoIjgZ/TNRxLYJIf4HknbV7qM+PsJ14ZEs3Pev/BWLpb6WNws6XqHBtS2d3qQr
 4t9RyTTritCJodxz0SUDrzL3diS8SYe482NmD3+YlT/cslcVCfxfK4h1gqHjo4223KZzOe4gyy6
 Cr9vtfbjtjlMN+5xCpBLMWkheKWtlmRXQ3ZTSVlSRc8/u3WcAw1TzxiJRqvYcVzZ4qd1/AGhx+l
 7tuFqQYOY/dI9ie7Y8mdgw+H4bOQqkD2uacKf8joxXV/CdrQE6E2QYJEFKiWVAc/c0FeUJmw==
X-Received: by 2002:a05:600c:c049:b0:4a1:9a97:c88 with SMTP id
 5b1f17b1804b1-4a19a971118mr69032095e9.5.1791825069052; 
 Mon, 12 Oct 2026 10:11:09 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18bf214a1sm346018185e9.7.2026.10.12.10.11.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 10:11:08 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 83B0462117;
 Mon, 12 Oct 2026 18:03:32 +0100 (BST)
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
Subject: [PATCH v2 15/16] tests/functional: update s390x tuxrun images
Date: Mon, 12 Oct 2026 18:03:29 +0100
Message-ID: <20261012170330.1144446-16-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261012170330.1144446-1-alex.bennee@linaro.org>
References: <20261012170330.1144446-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x334.google.com
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
 tests/functional/s390x/test_tuxrun.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/functional/s390x/test_tuxrun.py b/tests/functional/s390x/test_tuxrun.py
index 086466af81f..8e0261e2b7f 100755
--- a/tests/functional/s390x/test_tuxrun.py
+++ b/tests/functional/s390x/test_tuxrun.py
@@ -17,11 +17,11 @@
 class TuxRunS390xTest(TuxRunBaselineTest):
 
     ASSET_S390X_KERNEL = Asset(
-        'https://storage.tuxboot.com/buildroot/20241119/s390/bzImage',
-        'ee67e91db52a2aed104a7c72b2a08987c678f8179c029626789c35d6dd0fedf1')
+        'https://storage.tuxboot.com/kernels/6.18.54/s390/bzImage',
+        '5efeb31754b211440e1595ab11355bb006fe78a2c0604ed0a8c55c4598b71aec')
     ASSET_S390X_ROOTFS = Asset(
-        'https://storage.tuxboot.com/buildroot/20241119/s390/rootfs.ext4.zst',
-        'bff7971fc2fef56372d98afe4557b82fd0a785a241e44c29b058e577ad1bbb44')
+        'https://storage.tuxboot.com/buildroot/20260924/s390/rootfs.ext4.zst',
+        '5ba18c4d18831c50a0c743990f7bdee1d3b520629d423c55b668d8fbbac9c6f5')
 
     def test_s390(self):
         self.set_machine('s390-ccw-virtio')
-- 
2.47.3


