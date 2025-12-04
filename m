Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD6F5D24469
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Dec 2025 18:12:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRDoA-0001YF-3i; Thu, 04 Dec 2025 13:12:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vRDo8-0001XP-9Z
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 13:12:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vRDo6-0007pr-TB
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 13:12:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764871918;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=nDqBb+howVc6cd7uGoknJH0PjirYFJJey/1eAuvkVIA=;
 b=TpLNufdDcbDV36o16d/ePwPX5R0H09BB6n+U+AY3Xu3yqZcB/xAxLDLys6qJuJsga2LKZX
 ni+sZQjE08S45mVY9oCU+xVn4nFKNild5gg/pko+/oRE4a0zy4DVmfrkbivtKUU6JtEP3/
 bTPCmK7Vy/gg+CARLY9V2YEyQZ32/oM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-bEvIMCb0OCyS72ygvay_cQ-1; Thu, 04 Dec 2025 13:11:56 -0500
X-MC-Unique: bEvIMCb0OCyS72ygvay_cQ-1
X-Mimecast-MFC-AGG-ID: bEvIMCb0OCyS72ygvay_cQ_1764871915
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-42b570776a3so670182f8f.3
 for <qemu-devel@nongnu.org>; Thu, 04 Dec 2025 10:11:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764871915; x=1765476715; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=nDqBb+howVc6cd7uGoknJH0PjirYFJJey/1eAuvkVIA=;
 b=hIIuHW3+eVcFup4XyA+VZR8/9ohWjli6nkn7MR6TY9m3BNwCMlwXK+SXpt2tD1+2Sz
 NVLQ8TuQAQT10RkxQhg1d3+14hDvh25xK+F5j2WKulv81OecRJJT7Kz+TzD/iJIYW9WR
 shW3drc4Ujy5BHogPUKdbAFeQQtI5GcFjWiBiIQk5bQA7ErDeLPPrcbzXM5I/cISngnN
 LrV1W1wFFohtFybWIqFeuFVw0uvW6rdrfVlhYPChtlwotKMuQFhEUk1mVKg93i3GP4hu
 m+4GWQhRTZRS1h9hgZLd2owXPpIa2aKvBmYGVe61khvisQ4KpkPu55iEYf4ot7LgpeAw
 p3FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764871915; x=1765476715;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nDqBb+howVc6cd7uGoknJH0PjirYFJJey/1eAuvkVIA=;
 b=itjCp97OfEfXV1vnSumgxjZUgDpCAFIxm2KfxOLROCfALlDw3p3D/gtDjEklMD4YYN
 opPo/vymJSzgc5EwTvQ33EjS6w0IXl9rXEcvXWH3Oukhv42GrdoYuVRbrCacpeEVkFyM
 j+p0o0IjG29TFYW0kvGX3LYgnbVBhdiLIBR+ySdwXJjloy8blBcwfJDthmByJPj/rM6Y
 aj8MYGBlfH/pMxNg9fctUJF7iAG3i3HrYDr131KjSF+NsrNSiFI5yWn3Bd/OjGWOgaMA
 HcuKEH09NHxf8DlxdsUxC3rNfDa/9JgHLvvg1M4dKa8NcAl7Gea0w8MKPvjHqR5b8WO4
 kipg==
X-Gm-Message-State: AOJu0YwKzOyCOWAQWX5erY0IFpkZCNcEs7VJ5MF2Bl3w39co8dm/4Ilm
 ScpyTjhntWsg2OIrIug+kwz3LLNmMSdty9s+k9eOPY5nWhuydeE4rNYCJIIdQkRRjPGw43Bdwqg
 +zerQfepuwSWQmYyUiohPw1mK3Z9kXECflo7Ty24Tas9aqYBPubhbCWqKzpG5MhoEaem9gPBvg9
 d5GNodNRtiZpCyl5Biu9tRIRjo1UqZwGdn+WrV460N
X-Gm-Gg: ASbGncvHdNBfx6HrZSSjFt2g80Kidys3YLOVWfiR5TH59f6cmnbyGvi5/EvkeFEVwtp
 d2LQvn8Yq/EuBhRWLhHUk4StLdxzCz86+yuPELNNARj8RT/KWvHqGgcTX4+4k3wa61jikILTEW3
 osBttRlYDJEu9Y47xboHS6Gcd7VxhE8YLRqUTWZSvUzJBnNf+x/JyQlzwFJ4k0L8es/1y0HfN3k
 HDaOy3IvmSiPb2TAiSL6R58hvOkXGV9iWqGfki7WkxKuEd7J+0jgeJadfU4SMcVdzw+Tqydqy16
 SmFKNYSd4XIUPM8nJiL+Hw9gyuOpwHyUhHYQhw8smR2bwamfDnzhGzIdwNyE0rTyvIWXTg1hWx5
 d/6hFg2Su8CuL3WDuz8KidfzxCHdBn02aErouWsn/mvSvdGXUqQ3sdOnY/FGPDn52Pa7yBg1hg6
 r53Vpsk1+/Rzg=
X-Received: by 2002:a05:6000:184a:b0:42b:4185:e590 with SMTP id
 ffacd0b85a97d-42f731d18f4mr8004970f8f.58.1764871914878; 
 Thu, 04 Dec 2025 10:11:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEXnR/r2mLAch4hpfGhA3653CP92n1B0XfpNo8U4qMOpTPbtXHJGot+C1Ry5mtPZqrfkW1vvQ==
X-Received: by 2002:a05:6000:184a:b0:42b:4185:e590 with SMTP id
 ffacd0b85a97d-42f731d18f4mr8004939f8f.58.1764871914357; 
 Thu, 04 Dec 2025 10:11:54 -0800 (PST)
Received: from [192.168.1.84] ([93.56.161.42])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42f7d353be1sm4156724f8f.39.2025.12.04.10.11.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Dec 2025 10:11:53 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] tests/meson: do not reuse migration_files variable
Date: Thu,  4 Dec 2025 19:11:53 +0100
Message-ID: <20251204181153.37670-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
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


