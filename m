Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 805A9CA0FFE
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 16:51:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utUDi-0008G0-Fw; Tue, 02 Sep 2025 12:50:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1utUDg-0008F2-M5
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 12:50:56 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1utUDd-0004Q1-Rj
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 12:50:55 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-6188b7550c0so6821999a12.2
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 09:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756831852; x=1757436652; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gjXCcr5SxY559gyNm3UTAVjtJgfAK9rwGGuds/G0kqg=;
 b=u2zdlewFuU7CfCt4Rj8lYbkfotr3IurGdYNmFUMVBH7OdVP7P4BeePIau+x6yJRWlC
 /G/qRYsUi+oXbZMUvxBHdG/UcnKeNeExk8ocOqd6t8yLtsYTyrZEK6F74UKifT094rrY
 FA4ntRqldjfAa+n5arZCKywY2HTZv7nIVhZUXag8w99MptPzPqnrduq8mobYA3g3Bd8+
 veUQyLJG7j5NmdT328SSc8YauhO2Ba9sfHBCiBkLm4KR0SXDyvG+wqThY2BH31VjSkzu
 dqrWTQKF0EIIXeDI6Tl2Ya1374+Ne5wsOZsaWg+qRIBBHr9KHOJHHyAabSR4RY1vLUWB
 9DdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756831852; x=1757436652;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gjXCcr5SxY559gyNm3UTAVjtJgfAK9rwGGuds/G0kqg=;
 b=YoDh4zvwfo9NY392ZrixMObSTOD5CecTfb+JVTwmJoKlEXJcOfCu6BaEc5uopqJsdn
 SBkBkEFYiZqh035corFmATHAwvGCKbwmGitsZCvVXTNpoJ6JpEmHVrwMOSihFXHBvSZi
 ZWpbXY3EqbqLwjwTHRjaeXQ1yKkefRs928Kj6lS2G1/DAeE8Du/FhJYV708RgRFFAIBu
 Ob2bWV+nL+xc7ax5m/cw7pQE7aQBG8Ho+/Ui/YTeZJYouEN3oM4lCTlhzC/vFHGq8xFk
 h7g5x5gMpoyLmHL7MJto1AHIin8/SOROTdACdQMzVXiMIJgiDkf5FbGZCvGgXg8y9pKG
 ZkHQ==
X-Gm-Message-State: AOJu0YxkfN5IHX4ZNMyPsl1VR4JaVNF900VsD2CEqrFpewI87qWpQY0I
 ltkHOjn4i0B/18Q5G1ViBT0rpRwRZCfifo3Gjqsb8CM4j6Ej98rEDYgleh4q1gJXVBo=
X-Gm-Gg: ASbGnctV3El1Hd+jdfCyMt6aDZDVbaM9GBpKwQ8O9x7mqOZCaCrLJOZHYtkZgrGOw4N
 hKze6c4roKFPY8JTR0gEBeN7rsjrIJ+HJNBckfeuTdd4MEXcm2S1KUJ2T8M8EV1O5/VU54J4etF
 5EsWx10vwnRdixhtuSRnAoCueEPQU/kYz/daNiSA2lfpJvhq8NZxd4swtLwyVK0PWZApU2JU/si
 mG421T6lqNwzBnFjcNm4O/IsHt23jwt8PaQxJSsA5EfwNYr7fYv6jw1WaB6PeaOfDhfoquwN23B
 7+57R5KIw+/OtieYeKdQXUteSfgFEfqS8UK7x7zw4JxCeU9bnbEUEA/KJlWZTJ0NhAWH1PKB+Mb
 Hfi/G2JAYnwepOHbOs/hTCQpIiYf41mrFXQ==
X-Google-Smtp-Source: AGHT+IGOWt+NRiEMdKqSQlZDyXZvX9DyYW6Kaunul6gvZvz4hzTLGgTUuOGkHtj4o9YgUkZukTY44g==
X-Received: by 2002:a05:6402:90c:b0:61c:61bb:e836 with SMTP id
 4fb4d7f45d1cf-61d26988ecdmr9711708a12.11.1756831852056; 
 Tue, 02 Sep 2025 09:50:52 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-61cfc1c7a27sm10059861a12.10.2025.09.02.09.50.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Sep 2025 09:50:49 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E618A5F8DC;
 Tue, 02 Sep 2025 17:50:48 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 John Levon <john.levon@nutanix.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 3/4] docs/system: drop vhost-user-rng docs
Date: Tue,  2 Sep 2025 17:50:47 +0100
Message-ID: <20250902165048.1653323-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250902165048.1653323-1-alex.bennee@linaro.org>
References: <20250902165048.1653323-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52e.google.com
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

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 docs/system/devices/virtio/index.rst          |  1 -
 docs/system/devices/virtio/vhost-user-rng.rst | 41 -------------------
 docs/system/devices/virtio/vhost-user.rst     |  2 +-
 3 files changed, 1 insertion(+), 43 deletions(-)
 delete mode 100644 docs/system/devices/virtio/vhost-user-rng.rst

diff --git a/docs/system/devices/virtio/index.rst b/docs/system/devices/virtio/index.rst
index bb44b14423e..7f931737cc1 100644
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
2.47.2


