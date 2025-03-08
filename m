Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64460C28B2F
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 21:58:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tr26x-0003E6-5I; Sat, 08 Mar 2025 16:53:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tr26u-0003DG-Gu
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 16:53:32 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tr26t-0000tw-08
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 16:53:32 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43bccfa7b89so25381925e9.2
 for <qemu-devel@nongnu.org>; Sat, 08 Mar 2025 13:53:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741470808; x=1742075608; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9L7HiJswE8TAfNvAWw1znjTjbMsjJ3crdXjMtFLIetE=;
 b=mT2Eh6ftJ1wuCQsYwAIb8dRoXLwOIstoPjBQhivzVSmBy/6pFlxSnvAZYHVjrVBX/y
 QO1Jgbr6H7VA5Up0JvpArrPHFJCDJK56K5kthQoH/IwYSmll7jazkx2HsdpYG8iveQOL
 QBIt+SQArp0dSQKfbzqvDIvX8vKS4D1GXcwvvLvWueveBffTAAX2z3BLzGnA5xYtHiCK
 ezcC2XefBWYZ8R+eIDpU2iBnb5ksVIfRgOkVpHxVoowjpQdDxuEUfnGdf7Bj1l70s6VL
 VNUKWJZJsRw/NUqQbGYteCDsFdpGacWkhZZD+pSJoV8unWn68doPtpqNNTYb0+tTvPVo
 5eHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741470808; x=1742075608;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9L7HiJswE8TAfNvAWw1znjTjbMsjJ3crdXjMtFLIetE=;
 b=pyy3H/Fpche4mvpPHnuvM/UnoqdccifKmTz+Ti8bDjPCK71Rd9uKnTGuZWgBNPYsH7
 EOt/dU43fWcJNdbId5OV9p32RSF7nGZPWrmphRirapT6BwAfUaibY/Fb+Ynr4yvYz1El
 iFg76arLELvXsVDvPyrsjVcFrr3Ye3Oe7Pk4xswokUQ55YHEOPdvjGKJctU362RjENXh
 IBNT1MrK7PvtawNhKzcfCHnQcwWH7SypOdUK0eutTHEXvhNi/wcVfSRLfVvxK3EBv/MJ
 xEbyq6aloKNamBvdw6GppisRKittQy/QqVK7mfacVaQWLGgw3GyYaBqTfjB6RPPK6xI7
 boTA==
X-Gm-Message-State: AOJu0YwgAP2I4Pnm2zd86wrmpOCBk/EoGwNyRixAbYG3+P80vnF2voBu
 EGr7gfM7mJTVxYyrqblN2AcU7p5xG/ls0bEyAi6eNl1EXj2pwKrP317L70z3Dnw=
X-Gm-Gg: ASbGncucgFBZ+G8vRIf//NTbEkCixdyWFvqODSHHtwEnD+eLbjItG0RJDOQ665k/3vY
 chKsrbliaq9X+TmkW8bUSXkVydtDnmG/Z4NNELiQcdcgYwP+n5+3ymrYE4TNKPoBEnEUl1n5+a2
 aqB9G6PZsimEPauOR/AuMOimpN1s5RnurmaQW92NxBwm+77eBzaur7/xdGNwq25GM8N8nPRWok/
 ufjzpO479Z+8SIIHU4v6g262DdA0vouyOnpkht001v65rdN1S34lOZgVs+abEmYSyuhC0zeGywA
 CFgriJGfEqeiJrM/pAtYPcQjqaRLDsQiyD/EnUkAq3pnZ6U=
X-Google-Smtp-Source: AGHT+IEmiHvZWd+YCHvAf8vbmU2Gwe+dGVThJkNWTDPl8MP6ROEhvb8Akjabv82quX/LeIDPcyfc5A==
X-Received: by 2002:a05:600c:5857:b0:439:9e13:2dd7 with SMTP id
 5b1f17b1804b1-43c6de39734mr53164185e9.2.1741470808273; 
 Sat, 08 Mar 2025 13:53:28 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912bfbab43sm10077298f8f.15.2025.03.08.13.53.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Mar 2025 13:53:27 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id CF9325FA87;
 Sat,  8 Mar 2025 21:53:26 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PULL 03/31] tests/functional: ensure we have a GPU device for tests
Date: Sat,  8 Mar 2025 21:52:58 +0000
Message-Id: <20250308215326.2907828-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250308215326.2907828-1-alex.bennee@linaro.org>
References: <20250308215326.2907828-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

It's possible to build QEMU without support for the GL enabled GPU
devices and we can catch that earlier with an explicit check.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20250304222439.2035603-4-alex.bennee@linaro.org>

diff --git a/tests/functional/test_aarch64_virt_gpu.py b/tests/functional/test_aarch64_virt_gpu.py
index b4679c0460..9a1ee2befc 100755
--- a/tests/functional/test_aarch64_virt_gpu.py
+++ b/tests/functional/test_aarch64_virt_gpu.py
@@ -91,6 +91,9 @@ def _run_virt_weston_test(self, cmd):
 
     @skipIfMissingCommands('zstd')
     def test_aarch64_virt_with_vulkan_gpu(self):
+
+        self.require_device('virtio-gpu-gl-pci')
+
         self._launch_virt_gpu("virtio-gpu-gl-pci,hostmem=4G,blob=on,venus=on")
         self._run_virt_weston_test("vkmark -b:duration=1.0")
 
-- 
2.39.5


