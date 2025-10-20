Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC17BCCD193
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 10:42:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAnL7-0007dF-VD; Mon, 20 Oct 2025 06:42:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vAnL3-0007ah-71
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 06:42:05 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vAnL0-0000i5-Ii
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 06:42:04 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-63c489f1e6cso3671697a12.1
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 03:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760956921; x=1761561721; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ydvpStcClyPSWRWFnDHV/azJ9U5xbq4jo7q2l9XHJfs=;
 b=YXgFx1a3WHzuV8T1wb1cRmZ/0U40sQatWx/dkWcugl4qguI/MooR1yWWwgdTellDFg
 k8YV+AQbr/XoXCJVdRIBRbWerFnrjtxvrsXus5PSpREQXYxV4aa1MnGtgT5mOwKprgrT
 ZWpNuUkD0XVuBzLLFoCFaMv+jsIrwzSGpIRSApKIaeYCTNmtbob/Wor/rY345ZSrIhc2
 nHoCIiaZXfEI91HIBl5fo4qMBrQWd6QYF+OxGi9Heh5/Uj9nAfD9T10xiVG0UlNLaJVM
 pLWDnmV2NUYeEtGcFysJaAdr7YaB+4swxZnT9B4YtpWT0I3FbL1ydRfFLr0mPODHV05S
 yINw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760956921; x=1761561721;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ydvpStcClyPSWRWFnDHV/azJ9U5xbq4jo7q2l9XHJfs=;
 b=Qf4Wl4Gqohb0vuhWYoWVAWLbuyaB6ESlBBT/OqFoipHl8N889oeILH9Jq429cx+LN5
 E2tQtGNsoodzwsSLU2MJCGM+ZIvj2cFcVK1fQUGcUeMca+hmgTWaNNzkvdxAtJ3DZRBU
 amrUa4Ht+mx2iVrkHyGTSfJpmmFCpXJcguPIl7OLKG2G1Ms3xvFM3qOxoup6clm5liKt
 AQdRBgVbI8dBckVFYTm35b2Rw7oIg5W4ym8F8Gtkrm29hawVbDOYqKum1nLT40szun+7
 4F/9U5A/jp4rcrLThH4xHVex8QWHxCbyNoEZ4uxxSzii/BfLAuyRvF0Pqzkl4hlQya/M
 iJGQ==
X-Gm-Message-State: AOJu0YxBWFdnIQo7s5h4qu5cnlGkXpSJSl6tZuGkbh40EGr2roU5+fm9
 Rli0AQfTS13/9L7DGLbMiVUK2PxLhPr5UwwCCED8CKhl0JnveMbOAgo3oYXklqGAsgk=
X-Gm-Gg: ASbGncvOEsMmmXmmMrH7jCQ8xahuYJ68qSv4AGvJcaOYNRhX947JEv9x71GSPNw2fY+
 fDKiGrP7maWNmnk8c9+h8ozcsoNNm4EBUUoHOQLoYn+GX07346gflGnqkjEMNRU0DF3f77I9LAS
 0w5qNoZ9zTKweiTnCytyBu8RfynQ82iP/eJ0Xn2ws6gOVrkbUYYonXXSltOVOCWmvN6AGzBKLsj
 IQLWuxD8MpPbHNPksyQ+GooeqXqRe1itevOT7vPBgx7Yh0Xbu1P6J0oYF1PCWyvLBomUHv0oJQL
 DmSTWgluqVynM3yuWqb/nNNShXRJuhl/AWrFr2Az7mzlANb4fMuxUdndCpefK5kSPkR8jl2cWBl
 U8YL0ZVBsnnnNmEzpgsh8A3bV0OmqGPua/f7X/t/JmOyvVTwu8Utv0mZshqaSVP8AcXUG4sgDzz
 WL
X-Google-Smtp-Source: AGHT+IHBjoqH/oMIeP15C4mp2VcbRcUOt4S6gHFA0taYgTTIfT3CJtZnLOaBv8bLJPQuWhnNQlLHYw==
X-Received: by 2002:a05:6402:34d3:b0:63c:5892:3c3a with SMTP id
 4fb4d7f45d1cf-63c5892407bmr6423318a12.13.1760956920776; 
 Mon, 20 Oct 2025 03:42:00 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-63c4943027fsm6453551a12.26.2025.10.20.03.41.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Oct 2025 03:41:56 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8F8E560F0D;
 Mon, 20 Oct 2025 11:41:50 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 John Levon <john.levon@nutanix.com>
Subject: [PULL 10/11] docs/system: drop vhost-user-rng docs
Date: Mon, 20 Oct 2025 11:41:48 +0100
Message-ID: <20251020104149.4034124-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251020104149.4034124-1-alex.bennee@linaro.org>
References: <20251020104149.4034124-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52d.google.com
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

This is a fairly lightweight document which doesn't add much to the
general advice in vhost-user. Update the vhost-user docs to point
directly at the rust-vmm repo.

Reviewed-by: John Levon <john.levon@nutanix.com>
Message-ID: <20251016150357.876415-11-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/docs/system/devices/virtio/index.rst b/docs/system/devices/virtio/index.rst
index fc457ca74c7..e3839e61824 100644
--- a/docs/system/devices/virtio/index.rst
+++ b/docs/system/devices/virtio/index.rst
@@ -25,6 +25,5 @@ can also be off-loaded to an external process via :ref:`vhost user
    virtio-snd.rst
    vhost-user.rst
    vhost-user-input.rst
-   vhost-user-rng.rst
 
 .. _VirtIO specification: https://docs.oasis-open.org/virtio/virtio/v1.3/virtio-v1.3.html
diff --git a/docs/system/devices/virtio/vhost-user-rng.rst b/docs/system/devices/virtio/vhost-user-rng.rst
deleted file mode 100644
index ead14053264..00000000000
--- a/docs/system/devices/virtio/vhost-user-rng.rst
+++ /dev/null
@@ -1,41 +0,0 @@
-.. _vhost_user_rng:
-
-QEMU vhost-user-rng - RNG emulation
-===================================
-
-Background
-----------
-
-What follows builds on the material presented in vhost-user.rst - it should
-be reviewed before moving forward with the content in this file.
-
-Description
------------
-
-The vhost-user-rng device implementation was designed to work with a random
-number generator daemon such as the one found in the vhost-device crate of
-the rust-vmm project available on github [1].
-
-[1]. https://github.com/rust-vmm/vhost-device
-
-Examples
---------
-
-The daemon should be started first:
-
-::
-
-  host# vhost-device-rng --socket-path=rng.sock -c 1 -m 512 -p 1000
-
-The QEMU invocation needs to create a chardev socket the device can
-use to communicate as well as share the guests memory over a memfd.
-
-::
-
-  host# qemu-system								\
-      -chardev socket,path=$(PATH)/rng.sock,id=rng0				\
-      -device vhost-user-rng-pci,chardev=rng0					\
-      -m 4096 									\
-      -object memory-backend-file,id=mem,size=4G,mem-path=/dev/shm,share=on	\
-      -numa node,memdev=mem							\
-      ...
diff --git a/docs/system/devices/virtio/vhost-user.rst b/docs/system/devices/virtio/vhost-user.rst
index bddf8df5ed5..9c9a28df380 100644
--- a/docs/system/devices/virtio/vhost-user.rst
+++ b/docs/system/devices/virtio/vhost-user.rst
@@ -45,7 +45,7 @@ platform details for what sort of virtio bus to use.
     - :ref:`vhost_user_input`
   * - vhost-user-rng
     - Entropy driver
-    - :ref:`vhost_user_rng`
+    - See https://github.com/rust-vmm/vhost-device
   * - vhost-user-scmi
     - System Control and Management Interface
     - See https://github.com/rust-vmm/vhost-device
-- 
2.47.3


