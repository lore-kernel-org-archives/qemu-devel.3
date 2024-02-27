Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82A93C54798
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 13:35:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rexaj-0000rn-1m; Tue, 27 Feb 2024 08:33:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rexaU-0000mJ-O7
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 08:33:39 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rexaK-0002t6-T0
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 08:33:36 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-412a14299a4so21619595e9.1
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 05:33:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709040806; x=1709645606; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3VIFnDGKGpENbZj1Zia/ChGLWB8xWLzUdNndb0QJxO4=;
 b=IFGCbVLk00rMQQuJ1Zs404pbIJPnhSqUHuM2ri6FN0jejX8UyYYAvnBe/21nfPtz28
 I3+AElqqJXM7MjnM8IQwBAoBuCa/XexK2fCdtEcKWVE4e9mAMZANtTO8J+i0OGnOszRW
 myzDyH6tDic0icNGEi+bH9vsIeY16ArOxGiWbkwHLoQnSKujYD3rjqiJhsKDjiYU6nsv
 wKGybBvjFlPpYxOUiMqPEcBILnM2Gpystzx0rfhjlwTQvXbgVUzFPWF9YtKTRzKMRiW5
 giKJYn775zWsLVNjalNPGCgaMa3M0fNINdkM/zJaV+9kkHPfspQiWXwfn6Yf1luvfhUb
 4smA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709040806; x=1709645606;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3VIFnDGKGpENbZj1Zia/ChGLWB8xWLzUdNndb0QJxO4=;
 b=h2IiZxC5MsXddv/PFlB3yE4JuXBBmQWZ2g54c9DY3gql5bd+yNXQXamvIeP+0icas0
 zWO6a0tGOKyKYbQGu09cBEmzY3FkippzGRSo3Ro2HUOgu6IebHj0kcalbzYI/qd0Sidw
 8mp3ennH1/2fLl5NfAdVTftu/G0VQDkGP0NR5rGfFsR9k8YZSWNviclmQwbGKdpEUD7a
 ydQNkFu5NHQHT25COaMLyFNtG8hhT2sUJZVPYsmpmGz2wiF3EYuzI6CbN0v+joLEJs84
 toQaISotqClwVWt0zNOcxxXm9Rsj5/uj33N9LDJ4IAtPankx5Y9qETei2I5DdXmwmeEU
 84OQ==
X-Gm-Message-State: AOJu0Yy6DODepD/J4NagwitJ+CApz1e1x3BRPFpHCIaFO4HCcE5oQHag
 EIz6CkJ2mLknkNfJD0QdBmO3XFR3rv+SW1v99TEBTfkxWkHx3qB7qA4k4TbJ19xv9QNk44jr/mS
 j
X-Google-Smtp-Source: AGHT+IESZmbE8UJNeBFro4j02+/TdT8AMxLO7mwlUxLBilfLwib8AlguGjrex/1CokoUNhK5ueFvFw==
X-Received: by 2002:a05:6000:229:b0:33d:2f2f:b135 with SMTP id
 l9-20020a056000022900b0033d2f2fb135mr5913823wrz.46.1709040806651; 
 Tue, 27 Feb 2024 05:33:26 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 i13-20020adfe48d000000b0033ae7d768b2sm11319552wrm.117.2024.02.27.05.33.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Feb 2024 05:33:26 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 20/45] docs/devel/reset: Update to discuss system reset
Date: Tue, 27 Feb 2024 13:32:49 +0000
Message-Id: <20240227133314.1721857-21-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240227133314.1721857-1-peter.maydell@linaro.org>
References: <20240227133314.1721857-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Now that system reset uses a three-phase-reset, update the reset
documentation to include a section describing how this works.
Include documentation of the current major beartrap in reset, which
is that only devices on the qbus tree will get automatically reset.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-id: 20240220160622.114437-11-peter.maydell@linaro.org
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
---
 docs/devel/reset.rst | 44 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 42 insertions(+), 2 deletions(-)

diff --git a/docs/devel/reset.rst b/docs/devel/reset.rst
index d4e79718bac..2ea85e7779b 100644
--- a/docs/devel/reset.rst
+++ b/docs/devel/reset.rst
@@ -11,8 +11,8 @@ whole group can be reset consistently. Each individual member object does not
 have to care about others; in particular, problems of order (which object is
 reset first) are addressed.
 
-As of now DeviceClass and BusClass implement this interface.
-
+The main object types which implement this interface are DeviceClass
+and BusClass.
 
 Triggering reset
 ----------------
@@ -288,3 +288,43 @@ There is currently 2 cases where this function is used:
 2. *hot bus change*; it means an existing live device is added, moved or
    removed in the bus hierarchy. At the moment, it occurs only in the raspi
    machines for changing the sdbus used by sd card.
+
+Reset of the complete system
+----------------------------
+
+Reset of the complete system is a little complicated. The typical
+flow is:
+
+1. Code which wishes to reset the entire system does so by calling
+   ``qemu_system_reset_request()``. This schedules a reset, but the
+   reset will happen asynchronously after the function returns.
+   That makes this safe to call from, for example, device models.
+
+2. The function which is called to make the reset happen is
+   ``qemu_system_reset()``. Generally only core system code should
+   call this directly.
+
+3. ``qemu_system_reset()`` calls the ``MachineClass::reset`` method of
+   the current machine, if it has one. That method must call
+   ``qemu_devices_reset()``. If the machine has no reset method,
+   ``qemu_system_reset()`` calls ``qemu_devices_reset()`` directly.
+
+4. ``qemu_devices_reset()`` performs a reset of the system, using
+   the three-phase mechanism listed above. It resets all objects
+   that were registered with it using ``qemu_register_resettable()``.
+   It also calls all the functions registered with it using
+   ``qemu_register_reset()``. Those functions are called during the
+   "hold" phase of this reset.
+
+5. The most important object that this reset resets is the
+   'sysbus' bus. The sysbus bus is the root of the qbus tree. This
+   means that all devices on the sysbus are reset, and all their
+   child buses, and all the devices on those child buses.
+
+6. Devices which are not on the qbus tree are *not* automatically
+   reset! (The most obvious example of this is CPU objects, but
+   anything that directly inherits from ``TYPE_OBJECT`` or ``TYPE_DEVICE``
+   rather than from ``TYPE_SYS_BUS_DEVICE`` or some other plugs-into-a-bus
+   type will be in this category.) You need to therefore arrange for these
+   to be reset in some other way (e.g. using ``qemu_register_resettable()``
+   or ``qemu_register_reset()``).
-- 
2.34.1


