Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79A38E8FDD5
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 09:49:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZQvM-0005Mq-L7; Sat, 27 Dec 2025 04:49:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQvK-00055r-KJ
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:49:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQvJ-00070x-8p
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:49:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766828960;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nDqBb+howVc6cd7uGoknJH0PjirYFJJey/1eAuvkVIA=;
 b=RUi+UXpVd3durU6vxncyeKlnlWj7qyA+5hDYexBPk1szBsxTVP5Ab+EmSXf3qEd1QYm8y3
 NeHr3KwYMb7cCLaalkMeVxAWvubtWe6eZ7hELWLVxKQyG82OBoGBGNU9d6y+VxDmiMsR/I
 DjwcF2REJLYsVigof61s4FL5b7szhj0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-150-wP5dkUQ7PM2eynb5VNmFYw-1; Sat, 27 Dec 2025 04:49:19 -0500
X-MC-Unique: wP5dkUQ7PM2eynb5VNmFYw-1
X-Mimecast-MFC-AGG-ID: wP5dkUQ7PM2eynb5VNmFYw_1766828958
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-430ffa9fccaso6154130f8f.1
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 01:49:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766828957; x=1767433757; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nDqBb+howVc6cd7uGoknJH0PjirYFJJey/1eAuvkVIA=;
 b=BaNoW8QZvdPBxdPV1q+0jWX99gTxBI3fgbj3ziGWmuPPP4rsQa/k1u2Az7um1Xyix7
 FlILtXX7s6wRqx+BiVMlRaL6Fi4yRPpduLdyEJhu9v6H9VT76yEHrRQWp0gQlb/nHEAQ
 xxKoISZq0ntK/50H6+RSBjA+tyHHJoi9Nvm68KLndAYCSdPSKbDB+/zsl+KVQtHqs0/v
 UgBvxPrVNWr0CQz3/1kOmifl4j3NCi1lscPGo81l8qoY9AKt7ASlc5QgOh1RPx+E7cYw
 1Iy+sCWpOWBHFyqr2nIYXIvmMvbDB0ZrgO1ANyCvKRqR8tq++Xbedr8Ep/zRYOqGxYxX
 hK1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766828957; x=1767433757;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nDqBb+howVc6cd7uGoknJH0PjirYFJJey/1eAuvkVIA=;
 b=Sek0v64OcbQ0br8bS5+kttwBB7OEqP1A8XJOoKyULkLOJpOdh4xJ6+O8fPEHQWNieM
 OFtnqw13ZJ7j/3ZJkXVmGZTN/GyYWVgPya3vZnR3cgUqqJBWvKUGKMlHqFVyzmDcAopg
 aQ9pqsDf5bT+BN9TqIuGbt9TGL30DnjMSkuZY9jfeYKbkD5/h4NNfobNBARsl5PSpSVx
 lG7lsGJC/uwIXj4j0rAgZHtgPGG5Re2xoDP9/VtzoZ+6CFlPTN++RjZrbf8Ms8vvbHjN
 JjIQ+j3dQB0jjO/ySE5/rlsDpVNqNMbHldIhRsNGHoFwRdWi9lwoy02A6807amn0n2fv
 hPXQ==
X-Gm-Message-State: AOJu0YzuQ8gAiF+mOVFv5elBrrNI7eGSYiqhtqL/Ys5M7cJ4j8R0cd2A
 MiRB956476ux0plelYgsnNTtSjQT+WWfAa4MhXVNxjWkJtrCIpIud1KpIerhjRk9BBTeq+mFzMn
 3wn4WOAEdiJaj+Au6iExmz3TGV7OgE8ZexIKcAvMBllRJ7DnBydYsRMFfMsaCAWdw0GGsSYXKhu
 GEs/BoF7HRiwb2Qo7EcJVPKwPBLf5X6PieWGiiQyAe
X-Gm-Gg: AY/fxX5gmm298xbkcBqiR42OYJ/xVVMS/YQGkRitI9RquAbDfn1lUYF6Ye4zLs0707y
 A2dCUvGDA5LqPHerGBDn3UrAhnCJfpkGWvfFkD2yK+BUuhse3mDTZ1JgEfK6XJqZdsUnWRhTdOd
 vhCSUmB4pbc+1cepJ1eEeFlfkZyxa5wXSG8Ir8oLeCY0ghlDMLDf12q0zLjv4KUSGg8532erIFo
 DgmHWoWp7ltlOKHwtJF0i0IQjv7v4voHyj2ZdjCxCTEUB8mudW3KmP/kQT+GjSPWzlk8NHJ291w
 JUxVM2e2j3VHtK4umVeDMTlUmj3z9WENs0foln17lFXGwlP7C6tKNHTQMHKef4+2KhX9y/Wiutt
 ogbPInsT1WXofcvi+d/rNixJxOHeMQX0Wd+2O+0KZd7WlTCQEcj+dGhu/H686j1ogaCBmDWtc4y
 eVdq899DTeZbhV2oA=
X-Received: by 2002:a05:6000:2890:b0:431:266:d135 with SMTP id
 ffacd0b85a97d-4324e50afd0mr29948186f8f.52.1766828957159; 
 Sat, 27 Dec 2025 01:49:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHbYOGmbQtRYsxxsXtTtPpHAvQE4yWvODrLkYtKxxT6OKeQ1Wehqn/P29YaeXTCda+qv9jQUQ==
X-Received: by 2002:a05:6000:2890:b0:431:266:d135 with SMTP id
 ffacd0b85a97d-4324e50afd0mr29948159f8f.52.1766828956646; 
 Sat, 27 Dec 2025 01:49:16 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324eaa2beasm49024115f8f.33.2025.12.27.01.49.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 01:49:15 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Farrah Chen <farrah.chen@intel.com>,
 Zide Chen <zide.chen@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PULL 105/153] tests/meson: do not reuse migration_files variable
Date: Sat, 27 Dec 2025 10:47:10 +0100
Message-ID: <20251227094759.35658-31-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251227091622.20725-1-pbonzini@redhat.com>
References: <20251227091622.20725-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The variable is defined in migration/meson.build, reusing it is confusing.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/qtest/meson.build | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 669d07c06bd..08fba9695b9 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -343,7 +343,7 @@ endif
 
 tpmemu_files = ['tpm-emu.c', 'tpm-util.c', 'tpm-tests.c']
 
-migration_files = [files(
+test_migration_files = [files(
   'migration/bootfile.c',
   'migration/framework.c',
   'migration/migration-qmp.c',
@@ -377,7 +377,7 @@ qtests = {
                              'migration/migration-util.c') + dbus_vmstate1,
   'erst-test': files('erst-test.c'),
   'ivshmem-test': [rt, '../../contrib/ivshmem-server/ivshmem-server.c'],
-  'migration-test': migration_files + migration_tls_files,
+  'migration-test': test_migration_files + migration_tls_files,
   'pxe-test': files('boot-sector.c'),
   'pnv-xive2-test': files('pnv-xive2-common.c', 'pnv-xive2-flush-sync.c',
                           'pnv-xive2-nvpg_bar.c'),
@@ -389,7 +389,7 @@ qtests = {
   'tpm-tis-i2c-test': [io, tpmemu_files, 'qtest_aspeed.c'],
   'tpm-tis-device-swtpm-test': [io, tpmemu_files, 'tpm-tis-util.c'],
   'tpm-tis-device-test': [io, tpmemu_files, 'tpm-tis-util.c'],
-  'virtio-net-failover': migration_files,
+  'virtio-net-failover': test_migration_files,
   'vmgenid-test': files('boot-sector.c', 'acpi-utils.c'),
   'netdev-socket': files('netdev-socket.c', '../unit/socket-helpers.c'),
 }
-- 
2.52.0


