Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6079EC83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 13:04:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubIqT-0008NS-Tz; Mon, 14 Jul 2025 09:03:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ubHtZ-0007OG-Et
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 08:02:57 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ubHtN-0003sJ-6y
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 08:02:55 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-60c6fea6742so8252251a12.1
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 05:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752494562; x=1753099362; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=06ZP4ZDu9vIhxk8EIV8KfupaXCncTXZydCAzmathYzw=;
 b=PWMZGXdF+yO/fBZaZjoY9ZkqX000Xa6W3MDUlhJhUylldI1DrO8N+9Oec7wQmwUqzQ
 I8GnkS6hxBkzdNi/5omFbhtIqLcpS76Tm/7WqlVMsmNRM1zG1VmB3HcXSErgey5n6oOB
 D5ibs75yiggPhQVcA/Gipf+GBvCX5SrjcXMo8XVPwoFQgmS/h6KWNwwXqYdohglSQBx2
 eYFgsZ04w/0qgql7vsKrGn9H5ZMuOQ4EU7vGecUOrqxZ/i5EBDnJDWoOH2r0PBF2nFYg
 zRYinDeLFBZLrsh6TllzESx8jdSfI8DUPiQFdc3UhI5ONijFnTEaNEbfwgA/BRiR2HNU
 vzAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752494562; x=1753099362;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=06ZP4ZDu9vIhxk8EIV8KfupaXCncTXZydCAzmathYzw=;
 b=bPrIn4LNUHZPVHIuEr+BlP5aOqsej0gqwr11souuXRuFt9EUFd70/ct0xQAdPqYEpn
 G2w2QCCwyb3ZIrNQgwhZfzzOhujTt9lnodZXrbUi332fArVLBsdnk0cjojRS64jqeN6P
 PIyRTqACOBzD3oo+ekdigVkDnw6LoipQfOo80mK8us2+uXJcC8CilAx4RX1VyEqCGL8q
 s1abf2776WAScGIfaeGkeDxpl6V6yAcUrvhj8vEiDQZ/qt64f8iucBX2RJA7cE6+bGD5
 LbA3e40oerPWZdqzd1P57NtR21To/1wdJQNvMzjrV2Hd48N7qBNDco2xRSmkTALD1EOC
 XRrw==
X-Gm-Message-State: AOJu0Ywz6PURq1HXqf81bEcYK8VyvnGfikJNLyLUjkgpzLIWfzl3Jy/s
 14saV9PuHjw/9rwjG/lCV7s1SEhAirk8F7SsAF18csULUwG/swG5FV4SDjDR66OxARlyguOLnMv
 +VVyry8g=
X-Gm-Gg: ASbGnctDKcF3G/Z/MMxGhiXK6r5HorDofdZjojiWBWlXFOmAuO6CzdclmkpkVJrecod
 +LhRXRBoTTt0DLAop9cfxwn+q86cSSsvnt0hxkk6fTSjq/l41JtbACBSb4KY2F50JEHn43605D/
 12QWfWxvZMCzK38/luScylZyBeKrmapo/VyaqjrbmVd4w0571IhHborGpO+GiXageV6iJjEwLvX
 mR5U19nM7xcp/uBlZpa4+T9dFkSPsbAZShORAxdE0bpyF56KYdmDCWQkOFbaRTzx5sowbrxru0p
 VqIhmti1bvspLM3NpmzgcEyDQ5yb+5Xpe0qCcEbePRWpTVjb7E/Lq61FhM8XOXHUjY108AUMjcN
 U2oIwVXWbpNQaTaApDxPO12o=
X-Google-Smtp-Source: AGHT+IHsRsfe1hRpWYACwhaOKi9b6p/FD13o6YtytvZjhpET5hpEaJNMVnb4XMAYeFnpI9UEpEuDWg==
X-Received: by 2002:a17:907:3c84:b0:ae3:5887:4219 with SMTP id
 a640c23a62f3a-ae6fc136150mr1291403566b.45.1752494561600; 
 Mon, 14 Jul 2025 05:02:41 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae6e7ee4547sm819767366b.61.2025.07.14.05.02.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 05:02:39 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 628765F8D5;
 Mon, 14 Jul 2025 13:02:35 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Jason Wang <jasowang@redhat.com>
Subject: [PULL 7/8] docs/system: clean-up formatting of virtio-net-failover
Date: Mon, 14 Jul 2025 13:02:33 +0100
Message-ID: <20250714120234.1524401-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250714120234.1524401-1-alex.bennee@linaro.org>
References: <20250714120234.1524401-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52f.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

We didn't clean-up the rst formatting when we moved this into the
docs so lets do that now:

 - un-indent the usage/hotplug/migration paragraphs
 - properly wrap the command line fragments in code-block
 - highlight parameters in text with ``double quotes``

No changes to the actual text.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-ID: <20250710104531.3099313-8-alex.bennee@linaro.org>

diff --git a/docs/system/virtio-net-failover.rst b/docs/system/virtio-net-failover.rst
index 6002dc5d96..0cc465454c 100644
--- a/docs/system/virtio-net-failover.rst
+++ b/docs/system/virtio-net-failover.rst
@@ -26,43 +26,48 @@ and standby devices are not plugged into the same PCIe slot.
 Usecase
 -------
 
-  Virtio-net standby allows easy migration while using a passed-through fast
-  networking device by falling back to a virtio-net device for the duration of
-  the migration. It is like a simple version of a bond, the difference is that it
-  requires no configuration in the guest. When a guest is live-migrated to
-  another host QEMU will unplug the primary device via the PCIe based hotplug
-  handler and traffic will go through the virtio-net device.  On the target
-  system the primary device will be automatically plugged back and the
-  net_failover module registers it again as the primary device.
+Virtio-net standby allows easy migration while using a passed-through
+fast networking device by falling back to a virtio-net device for the
+duration of the migration. It is like a simple version of a bond, the
+difference is that it requires no configuration in the guest. When a
+guest is live-migrated to another host QEMU will unplug the primary
+device via the PCIe based hotplug handler and traffic will go through
+the virtio-net device. On the target system the primary device will be
+automatically plugged back and the net_failover module registers it
+again as the primary device.
 
 Usage
 -----
 
-  The primary device can be hotplugged or be part of the startup configuration
+The primary device can be hotplugged or be part of the startup configuration
 
-  -device virtio-net-pci,netdev=hostnet1,id=net1,mac=52:54:00:6f:55:cc, \
-    bus=root2,failover=on
+.. code-block:: shell
 
-  With the parameter failover=on the VIRTIO_NET_F_STANDBY feature will be enabled.
+  -device virtio-net-pci,netdev=hostnet1,id=net1,mac=52:54:00:6f:55:cc,bus=root2,failover=on
+
+With the parameter ``failover=on`` the VIRTIO_NET_F_STANDBY feature will be enabled.
+
+.. code-block:: shell
 
   -device vfio-pci,host=5e:00.2,id=hostdev0,bus=root1,failover_pair_id=net1
 
-  failover_pair_id references the id of the virtio-net standby device. This
-  is only for pairing the devices within QEMU. The guest kernel module
-  net_failover will match devices with identical MAC addresses.
+``failover_pair_id`` references the id of the virtio-net standby device.
+This is only for pairing the devices within QEMU. The guest kernel
+module net_failover will match devices with identical MAC addresses.
 
 Hotplug
 -------
 
-  Both primary and standby device can be hotplugged via the QEMU monitor.  Note
-  that if the virtio-net device is plugged first a warning will be issued that it
-  couldn't find the primary device.
+Both primary and standby device can be hotplugged via the QEMU
+monitor. Note that if the virtio-net device is plugged first a warning
+will be issued that it couldn't find the primary device.
 
 Migration
 ---------
 
-  A new migration state wait-unplug was added for this feature. If failover primary
-  devices are present in the configuration, migration will go into this state.
-  It will wait until the device unplug is completed in the guest and then move into
-  active state. On the target system the primary devices will be automatically hotplugged
-  when the feature bit was negotiated for the virtio-net standby device.
+A new migration state wait-unplug was added for this feature. If
+failover primary devices are present in the configuration, migration
+will go into this state. It will wait until the device unplug is
+completed in the guest and then move into active state. On the target
+system the primary devices will be automatically hotplugged when the
+feature bit was negotiated for the virtio-net standby device.
-- 
2.47.2


