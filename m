Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97B7CCCD1A1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 15:06:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9PWm-0002GK-R3; Thu, 16 Oct 2025 11:04:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v9PWj-0002F7-2f
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 11:04:26 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v9PWT-0001Au-HM
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 11:04:24 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-46e3a50bc0fso6871025e9.3
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 08:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760627046; x=1761231846; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kaE703fUvjn7HVdw0ZGbrHh7JOU9e0/crufJzCxKJ6k=;
 b=xErF1s27KwYYKa2rRgWe5j8UVwurzhHp8sQskYoLPo5vPM3s2blGKUda21rcstM9ZP
 1KvbOMbtrrahVwdTok5vs33zYDRl65W0N5F2BwXZpp6rvSDJ6LBTZ77nmNBmshdSzIaO
 JShycyZWLSfiR3Xr0nK2Av1S8mWa1VPinR2Xy0w8abuJDIcgpj49I8hDjh6jQGMfOPND
 SNgXGLCXWOTiiL6SkMaNp/zjI3RgYLiq8M2wq4u4B624jSXHtzWHSHbXGtAugVWAlg82
 F20XbxFV8gte4T2AGsK/yg6oRNXzO99iwXLBkrYA6OqSD4qA8Ri9WbOKcuNsDoOlJejE
 X+zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760627046; x=1761231846;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kaE703fUvjn7HVdw0ZGbrHh7JOU9e0/crufJzCxKJ6k=;
 b=GSGzny+yQaSYctMClyn2ZLPISHHoN3cnLupXDzxHKpitTeQkB3H27/WeKz2wMScznn
 0j8TD6r0lvOhn63kTvGKpLidz2lNiFeWHZ3ESNQShqg0OwtooIzs8G5uQ3kcDJ19WZmo
 wlRIiq1YFEmZ84EUDz/y6J6iXQ73ZgBRsvmKtAO+oPZ6mtf8jUTHXDVPyjtsfT33Kpn6
 VZV/T5mFC6z0LG6f7rUac2dlw2Bb8+sbakTsw+zR6n9HhsnK04LHZ2p35cuM90J+t/PC
 fcXW2nO+0rEpErB3/WTxt+3dsLyOhkQk0p4tcIS6JyPK2DaAinqRQ8Oi1OCVciSt07hX
 G7Xw==
X-Gm-Message-State: AOJu0Yz51Vde5L+pFhQYqe0zkrfGYKdj5NmkgQN/YJnZxgy8N+42twuQ
 0BXBhdgSv3FDOSmaum+9nrpZ6cPqIYmR2ZmESCP3G+uZyUi9U2zvLdOxisTZi1wiBEo=
X-Gm-Gg: ASbGnctE579u4AIuUSepFB3CWDAy9ywmP4DHhCYFv2DlSFObYusw9lW4Brmq9LvU43+
 OtBqleDsb0SxNLl12YlIgRO7H5baLLJNVyHep0ThmsPMBghlixnTRZbGFY8/pO/KHguvjgjXhdi
 iW0WM+on1nqdOI2XgSPLyHqtj4bKhkCUCzxZd5XOHnhscFikF0ePf5YZEhnzViVmFle/oH/Dp8y
 eslUOG+tGI1/anDq4o3OF/p5DIsq8VzucDDGIV0RNwJT3vXb8HqJTCnx6lohJ+Wnkc5c4J/oRBz
 DLyqWDB3kfC3gmJAhTDcH4rGrMd0gqo1Qv3pNSdKTyY+CnyTxrpfauWBkRrXxJ4x87Y1ApZALSZ
 srzgmYmfqPX8mA137JGbVYQ4sjomMCQnO4QuXbYUTWf1Mp0DZ5dY43wBI/krSWEnKq9934MI2dA
 1h
X-Google-Smtp-Source: AGHT+IFJ5r/Hu+7t5E1sXNqbodahqg19RIm6MrpXLCPuUOKUkMQ/TAzcvMViywm3SE2TTAbHHSTFnQ==
X-Received: by 2002:a05:600c:1e1f:b0:471:1716:11c4 with SMTP id
 5b1f17b1804b1-4711792a510mr2710505e9.34.1760627045903; 
 Thu, 16 Oct 2025 08:04:05 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce5e8141sm34817314f8f.48.2025.10.16.08.04.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Oct 2025 08:04:03 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 5CB435FAE6;
 Thu, 16 Oct 2025 16:03:58 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Levon <john.levon@nutanix.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Thomas Huth <thuth@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PATCH 09/11] docs/system: unify the naming style for VirtIO devices
Date: Thu, 16 Oct 2025 16:03:54 +0100
Message-ID: <20251016150357.876415-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251016150357.876415-1-alex.bennee@linaro.org>
References: <20251016150357.876415-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

This makes the index look a little neater.

Reviewed-by: John Levon <john.levon@nutanix.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 docs/system/devices/virtio/virtio-gpu.rst  | 2 +-
 docs/system/devices/virtio/virtio-pmem.rst | 6 ++----
 docs/system/devices/virtio/virtio-snd.rst  | 2 +-
 3 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/docs/system/devices/virtio/virtio-gpu.rst b/docs/system/devices/virtio/virtio-gpu.rst
index b7eb0fc0e72..39d2fd2d21c 100644
--- a/docs/system/devices/virtio/virtio-gpu.rst
+++ b/docs/system/devices/virtio/virtio-gpu.rst
@@ -1,7 +1,7 @@
 ..
    SPDX-License-Identifier: GPL-2.0-or-later
 
-virtio-gpu
+VirtIO GPU
 ==========
 
 This document explains the setup and usage of the virtio-gpu device.
diff --git a/docs/system/devices/virtio/virtio-pmem.rst b/docs/system/devices/virtio/virtio-pmem.rst
index c82ac067315..0c24de83ec7 100644
--- a/docs/system/devices/virtio/virtio-pmem.rst
+++ b/docs/system/devices/virtio/virtio-pmem.rst
@@ -1,7 +1,5 @@
-
-===========
-virtio pmem
-===========
+VirtIO Persistent Memory
+========================
 
 This document explains the setup and usage of the virtio pmem device.
 The virtio pmem device is a paravirtualized persistent memory device
diff --git a/docs/system/devices/virtio/virtio-snd.rst b/docs/system/devices/virtio/virtio-snd.rst
index 2a9187fd701..3c797f66e03 100644
--- a/docs/system/devices/virtio/virtio-snd.rst
+++ b/docs/system/devices/virtio/virtio-snd.rst
@@ -1,4 +1,4 @@
-virtio sound
+VirtIO Sound
 ============
 
 This document explains the setup and usage of the Virtio sound device.
-- 
2.47.3


