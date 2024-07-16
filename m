Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4D52C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 07:29:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTcbT-00042T-5K; Tue, 16 Jul 2024 03:28:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sTcbR-0003vT-Mr
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 03:28:01 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sTcbP-0006PI-K2
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 03:28:01 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1fb72eb3143so36643965ad.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 00:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1721114878; x=1721719678;
 darn=nongnu.org; 
 h=to:content-transfer-encoding:mime-version:message-id:date:subject
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=QenUDDovgfyqL7pJVg/Ddw0aCk09OSY6KUmOmBuFnuo=;
 b=pRTzivTmlnZg+NWo494ERCk29mWPTZRegBuBdJYt1ANEPfFYcpakOYiXmYqfrSoNdM
 uKnwczBFxxTjDvsTowxkBJ5nSyjZyMt3fkxARQL4bj5OTsaRT8JnYykeDbAuzsk3cQ+Q
 uPCToBAG7pH+bcUDR5mTaaS4d0XwrDjDZNlwnB5grV/SGNhNkiLgFaX25QjQ8anGTcZK
 Q3LeRMXqXJZd5AAhkYoMUObEgqXhL7xhCCtK/oBa+ZPncjMY+ZCdCD5RCJz0iPJ7ItcN
 bLmc9kVJfSFIGz2/8BJiF57jS5j1MJkzmLqJLVtNvCSoNtr2WlZIolR07Too4znHHIBy
 9Hxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721114878; x=1721719678;
 h=to:content-transfer-encoding:mime-version:message-id:date:subject
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QenUDDovgfyqL7pJVg/Ddw0aCk09OSY6KUmOmBuFnuo=;
 b=lQp345OSKgTKLXt/TyFVNQlaiAG7ouLirGbOnXs9XNTYBvvwgmta1Bb6+xQprml3HC
 yoYICFiv/cZHOogfmxRl7Y6C8t0yKt+Oh9MmqlCq6KTyJGgOia5cONguJxOwTlyeFFHp
 kKg0n8Fm3q78a5+xYNRNo09ArxvwrvucokRZ53DXepZsyIIXkoaOCyhvpD7QOipuO6E3
 tMD+mPcAVDKDTc6mSBy3kV9gq9bO5n2wag8nPJNqKRKY0OIaXVlxxQRF15QKYm4ZGhL8
 tGYIqfmWqKkHer99+bPHb+BmFgUojPzsaPBuD3Q/krWI/oQsmpjPgTIWNCbVHwUbZTK8
 W4pQ==
X-Gm-Message-State: AOJu0YyJFbdGy7Vs0+CU88NDeY49g6w5v7+WTy7+7MVY7uUAYiGTY0ss
 vVbaKfVy1Zx5SAwPZaBlygdEMalTEcUGgGlv/4lW5HBiMj7cDQdWJfZO8oaKbRYjMDwDD2gLxgx
 IopI=
X-Google-Smtp-Source: AGHT+IFi0QxVa4UmW79LhE2P1Xri6ppS4zMq/3OaqwL2T5QNYnYhkk4gq/XNqAmE048ewtGPtQ8Fyg==
X-Received: by 2002:a17:902:d486:b0:1f9:f6c5:b483 with SMTP id
 d9443c01a7336-1fc3e751639mr13674495ad.27.1721114878254; 
 Tue, 16 Jul 2024 00:27:58 -0700 (PDT)
Received: from localhost ([157.82.128.7]) by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-1fc0bc3a003sm51460675ad.184.2024.07.16.00.27.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jul 2024 00:27:57 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v4 0/7] util: Introduce qemu_get_runtime_dir()
Date: Tue, 16 Jul 2024 16:27:30 +0900
Message-Id: <20240716-run-v4-0-5f7a29631168@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOIglmYC/x2Myw6DIBREf8XcdSG8fNBV/6NxQQDrjSk00BqN4
 d+L7uZMZs4B2Sf0Ge7NAcmvmDGGCurWgJ1NeHmCrjIIJhQTfCDpF0g3Mae5t72SGuryk/yE22V
 5jpVnzN+Y9ku6yrM9/5JpwVnfKtFS3vVyIJyYBWdcIo2upocze8CN2viGsZTyB2i5QhydAAAA
To: qemu-devel@nongnu.org, qemu-block@nongnu.org, virtio-fs@redhat.com, 
 Yuval Shaia <yuval.shaia.ml@gmail.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Konstantin Kostiuk <kkostiuk@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Fam Zheng <fam@euphon.net>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 Stefan Weil <sw@weilnetz.de>, Yan Vugenfirer <yan@daynix.com>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::62e;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

qemu_get_runtime_dir() returns a dynamically allocated directory path
that is appropriate for storing runtime files. It corresponds to "run"
directory in Unix.

With a tree-wide search, it was found that there are several cases
where such a functionality is implemented so let's have one as a common
utlity function.

A notable feature of qemu_get_runtime_dir() is that it uses
$XDG_RUNTIME_DIR if available. While the function is often called by
executables which requires root privileges, it is still possible that
they are called from a user without privilege to write the system
runtime directory. In fact, I decided to write this patch when I ran
virtiofsd in a Linux namespace created by a normal user and realized
it tries to write the system runtime directory, not writable in this
case. $XDG_RUNTIME_DIR should provide a writable directory in such
cases.

This function does not use qemu_get_local_state_dir() or its logic
for Windows. Actually the implementation of qemu_get_local_state_dir()
for Windows seems not right as it calls g_get_system_data_dirs(),
which refers to $XDG_DATA_DIRS. In Unix terminology, it is basically
"/usr/share", not "/var", which qemu_get_local_state_dir() is intended
to provide. Instead, this function try to use the following in order:
- $XDG_RUNTIME_DIR
- LocalAppData folder
- get_relocated_path(CONFIG_QEMU_LOCALSTATEDIR "/run")

This function does not use g_get_user_runtime_dir() either as it
falls back to g_get_user_cache_dir() when $XDG_DATA_DIRS is not
available. In the case, we rather use:
get_relocated_path(CONFIG_QEMU_LOCALSTATEDIR "/run")

V2 -> V3:
  Rebase to the current master.
  Dropped patch "qga: Remove platform GUID definitions" since it is
  irrelevant.

V1 -> V2:
  Rebased to the current master since Patchew complains.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
Changes in v4:
- Rebased.
- Link to v3: https://lore.kernel.org/r/20230921075425.16738-1-akihiko.odaki@daynix.com

---
Akihiko Odaki (7):
      util: Introduce qemu_get_runtime_dir()
      ivshmem-server: Use qemu_get_runtime_dir()
      qga: Use qemu_get_runtime_dir()
      scsi: Use qemu_get_runtime_dir()
      module: Use qemu_get_runtime_dir()
      util: Remove qemu_get_local_state_dir()
      spice-app: Use qemu_get_runtime_dir()

 include/qemu/osdep.h          | 10 +++++++---
 contrib/ivshmem-server/main.c | 20 ++++++++++++++++----
 qga/main.c                    |  9 ++++-----
 scsi/qemu-pr-helper.c         |  6 +++---
 ui/spice-app.c                |  4 ++--
 util/module.c                 |  3 ++-
 util/oslib-posix.c            |  9 +++++++--
 util/oslib-win32.c            | 24 ++++++++++++++++++++----
 8 files changed, 61 insertions(+), 24 deletions(-)
---
base-commit: f2cb4026fccfe073f84a4b440e41d3ed0c3134f6
change-id: 20240218-run-6f0d91ec7439

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


