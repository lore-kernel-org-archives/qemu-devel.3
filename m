Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C369CCD4F26
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 15:59:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wabad-0007Hm-9l; Fri, 19 Jun 2026 11:57:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wabaZ-0007EZ-Vq
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 11:57:03 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wabaY-0001Ft-2L
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 11:57:03 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-45eeba68948so1683657f8f.1
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 08:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781884620; x=1782489420; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iMMNTERO31F+8kCv4Mg7Yr6Pae5QtEx8Xzxb3fKzqfI=;
 b=ugfAdJsfssGD3cIyp2/DYeKtYI/eNhh+7u9qbvSEvyaT6x30w8xjG9KfK00AX5oN4x
 ZQOIAMGNG8XZBQJ+TOEVdOhM3VpTaNoP8gg4nC/u5X6pAVk3W9jZqgiEM8wA793xIyYX
 MY2MNL+P0gXusMFmB8RfJiQ2rnEWPBUrSfXXhrrAw8nzdRqwG4pp+rU26BqThEuAtOau
 Fyq7palbZcSh3Xk4xIhBQDxRamW0TDfdQbQIpagfuRxICRaNXTwWz6Lqi8eQCtwJxoUD
 wREMp+z53En0Msww4Fiq39YxFZ3sfIw/ItSwS+tlx2laVOpXJ0U2Ml0zLOfBDxcAcRX8
 RLGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781884620; x=1782489420;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iMMNTERO31F+8kCv4Mg7Yr6Pae5QtEx8Xzxb3fKzqfI=;
 b=pCKwNlG2N5zYbRgCWfEc60edsOD9TdvtDXoGFT34AcIxVZ0XhTk3He0fQWp061RO26
 vCl94oV63usXxMNL66/ScnfaQ0lYgSBjg2NielREdKD/+JHtni/c6PxWcKS0KHYXLUCM
 DjtC3iO9am/xd4hz0r8EBhTfCu0JLKL9IUVj/ebdqlB7U0ymnUG0fBDFVchSb6twXXWs
 126KDsvpOIGo5x6Etm5hZx6Xauajszmmdy1JgMP2Z8Hv5eNTN2VNQ4TC4x4VwkWc/tz0
 GvdiRwdc4XYcuyFTj8MPUvS/a07PWVUZZFCCiCNPOMPkc3g1DHbfdfboC1gaQFZpHGCZ
 3k1Q==
X-Gm-Message-State: AOJu0YzCjXYUUaGW4Y4j70hT+ZcDwYz+R1Dv5HJ4bvYV9mjGmrgi/9Ic
 ET+KFvYAJ5gimRuBaIROmiGKNpl32qEpj7gkMCKfmTBw12b7QPZkhsqeBKUwjX5MeqE=
X-Gm-Gg: AfdE7ckBEs90gv68QbVvEdXA5060wcow/ki52Qd/O5BVta6yr8EWTmeKj39/WSVEC+v
 E/YI1Bme/IgK9lKPMszou4JkpSVCANwUGwRUogLBI8PapVt79uQ/aiJHHSZ1ho6j2gOslLYwGBr
 jdYLuMXwcvavToxePwratphcJEP88ifQ/2A181Zs72tuRgAhzHszY3kGFXROpmbN/c47W7d/vh2
 0bHOf//cwb5ArPntFCGMqp3x8ZOc2Mv3F/SPRd5DIWJ+J+RwweyKG3KvckpI1OmuMuQm2gT07V+
 JlJ0om21s9wzmGOgWiw7zM6zBvv/c4hMDY8hl+jQAHRxp0fPWSgIYp16Tn97+c1TdHgX5YIWtIH
 qEZWw+rFoTp94kM0zuPiAHB2o27uJX+bI0fkZM0Veks3VcWC2cxDzv9mGMJJnopnbM1zeUKVm+r
 4xLMj4W3Okn0pxU6awGvoaRvE=
X-Received: by 2002:adf:e3c1:0:b0:460:18cc:dcfe with SMTP id
 ffacd0b85a97d-46508afa647mr6460257f8f.34.1781884620553; 
 Fri, 19 Jun 2026 08:57:00 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46666c57a0esm2723f8f.27.2026.06.19.08.56.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2026 08:56:58 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 819AF5F917;
 Fri, 19 Jun 2026 16:56:57 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 John Snow <jsnow@redhat.com>, Thomas Huth <th.huth+qemu@posteo.eu>,
 Cleber Rosa <crosa@redhat.com>, Kyle Evans <kevans@freebsd.org>,
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Warner Losh <imp@bsdimp.com>,
 Brad Smith <brad@comstyle.com>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH 2/7] python/qemu: split console from harness args
Date: Fri, 19 Jun 2026 16:56:51 +0100
Message-ID: <20260619155657.944220-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260619155657.944220-1-alex.bennee@linaro.org>
References: <20260619155657.944220-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42e.google.com
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

Before we mess with the console output lets create a new helper just
for that.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20260614100902.885698-3-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 python/qemu/machine/machine.py | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/python/qemu/machine/machine.py b/python/qemu/machine/machine.py
index e8973a87394..18ee5ec0147 100644
--- a/python/qemu/machine/machine.py
+++ b/python/qemu/machine/machine.py
@@ -306,7 +306,11 @@ def _harness_args(self) -> List[str]:
                 moncdev = f"socket,id=mon,path={self._monitor_address}"
             args.extend(['-chardev', moncdev, '-mon',
                          'chardev=mon,mode=control'])
+        return args
 
+    @property
+    def _console_args(self) -> List[str]:
+        args: List[str] = []
         for _ in range(self._console_index):
             args.extend(['-serial', 'null'])
         if self._console_set:
@@ -372,6 +376,7 @@ def _pre_launch(self) -> None:
             self._wrapper,
             [self._binary],
             self._harness_args,
+            self._console_args,
             self._base_args,
             self._args
         ))
-- 
2.47.3


