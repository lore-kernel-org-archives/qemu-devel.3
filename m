Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0508D59D99
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 07:50:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vV3LU-0000ZM-3T; Mon, 15 Dec 2025 02:50:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vV3LR-0000V0-7E
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 02:50:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vV3LP-0000ja-Mu
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 02:50:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765785011;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nDqBb+howVc6cd7uGoknJH0PjirYFJJey/1eAuvkVIA=;
 b=hsoGnuXgDR+52a4YYZIjYx67ffVY514RfWkTEjiJIuUzyQ68ec24u3kIuDlITjl3LcgPfI
 CoOv9GHUSw0n/76vZUZM0qYsc+hoBbh1QclgrIOKnHfEiXtXHu1gF/ppXxKOygq+C9dust
 j+Bam9B/wgKXFPci1aJTjLYutCmY4Ew=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-274-fA4p9q6ZNg-v7vhgScIbAA-1; Mon, 15 Dec 2025 02:50:08 -0500
X-MC-Unique: fA4p9q6ZNg-v7vhgScIbAA-1
X-Mimecast-MFC-AGG-ID: fA4p9q6ZNg-v7vhgScIbAA_1765785007
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-477964c22e0so21283025e9.0
 for <qemu-devel@nongnu.org>; Sun, 14 Dec 2025 23:50:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765785006; x=1766389806; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nDqBb+howVc6cd7uGoknJH0PjirYFJJey/1eAuvkVIA=;
 b=cX99Be70LGZqd7+hzAnRh42uhc9ZWkJYiR/Ea2KPbfmhYkrYdSuPWC3XpjxH2LvMql
 lhKimCuzMlI+FRM7Iec8CU76BtNZ2cy2HeGKP6QG1N+sW03WUtfyu8YpxAzWvRrZADIy
 LvHV8j32WHinN/EHp08HUUgsGwLY2KtoAMxvHgTeevJ2bWvYQWfY6RMwy+KEXFJJDoVs
 FnNmPuFCl6PIGnTXQjPj4nLA70r8AzOoyi+3WAzDZQAM98iwdx2ToEgM3gtd6Rs6Mth3
 II+D8Z2E4/Maz5Kedj8z+hk0fp7acWJQXdzlKLbeBuaDnsCQ6KKNTh7OA3mCcR1hbYxY
 1XXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765785006; x=1766389806;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nDqBb+howVc6cd7uGoknJH0PjirYFJJey/1eAuvkVIA=;
 b=Uu0JUtOvIUM7zkGuTx9i6gzimkrz3BSWVswr1+AJr0hAWUcdAgAQrOoiYvpg4KX3RL
 Ub8UrLz0307yPFBOLsRmzwF2sG0t5qAbsIkm30Vasz6neVJJn18G+MNcw9Gdw2XqZQ1T
 flH07TDLK+VpKzo7T7duP4Sj9tO9WQt6Tk5hbNurGm8+e0U6LyY6C3i105GimyexXFgt
 mRQuaruMt6CaDwHGgVYWUO6jYa22n+w7qnBu9jXYXalXZ39DDGHM80CiQg82U5XcOGrW
 enMWZjGNHguj2knmoQlv5ZGL47RdPxomYroRd9jbTAYGKjtlmEpo1v2PXfhQMWD3abRT
 9KNQ==
X-Gm-Message-State: AOJu0Yzn4mrYg+yRci647S4o9K9pwUlg6yiX4rNzkBSwuUk0N7UnPBso
 3sgcGgC4JxFsagVoqAopIfUueDcKrGm5mUxetHTRKJLw2i47dHmoFkva9RguECQsf+umqdvtfoq
 rE/b13m3mATmHTm9thGMPvva38xVd0MRyF4KEL/E6M9EaV/2ii3pv4JOvG0XL0Mjjy2vpArdVJq
 DjygtYjqCtniRFCk1tijeaq/slIVdl9ZYbSmGbH+Qm
X-Gm-Gg: AY/fxX7qZF5W3Gr/n4OR5NaSKc2460ImjqDEXkVJEFGZtvJwO0t1/ACCa5ES7hAFpNQ
 fP8SEKvAO1hdu0C/nFfd/TIXUM+L3d9rMkF8HM9TiLX2ZAsIcrjL6irL+IkCv/7skG2yN1RhE31
 zaVOTUxRofM9tK2XOWkVticel2OzHdAlR1kZTwPTnz2qeGO3xo3QLP2KHN+uTLP10xoI/XMcvIc
 vPvidOyNzRB/unzs9oAiTGiiMQ/gA3w31qgy+gt9jrRYY8MH7UJOKYeJnONn5yX8ipa1QDHekxn
 5y3xiNB4we7ZVquVPlFPlbaVsgzlg6115oSjbij/hofETSJh/+0Zt4BHK8iLgoK9vBpHL0dcgfC
 oqdBypw85Nmq8kYfEkT1R+hManHAc8xR819rW1JuD/jHULwRX/H01rxKdnZTNq8TLQkR+AqOkEn
 XEW7RK9kPHcX7qvgM=
X-Received: by 2002:a05:600c:64cf:b0:479:255f:8805 with SMTP id
 5b1f17b1804b1-47a8f094212mr102922215e9.4.1765785006303; 
 Sun, 14 Dec 2025 23:50:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGK5Tx7FwVTie0aYHr7X4g2Hd6jxuowd5CtqTlTxD975RhZae7JhLVuvENqmdxDLBd482PFmw==
X-Received: by 2002:a05:600c:64cf:b0:479:255f:8805 with SMTP id
 5b1f17b1804b1-47a8f094212mr102921985e9.4.1765785005828; 
 Sun, 14 Dec 2025 23:50:05 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47a8f6e58c1sm169877695e9.12.2025.12.14.23.50.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Dec 2025 23:50:05 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org,
	marcandre.lureau@redhat.com
Subject: [PATCH 02/11] tests/meson: do not reuse migration_files variable
Date: Mon, 15 Dec 2025 08:49:51 +0100
Message-ID: <20251215075000.335043-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251215075000.335043-1-pbonzini@redhat.com>
References: <20251215075000.335043-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


