Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7D00CD4F26
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 10:06:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd3R6-0001KD-H4; Fri, 26 Jun 2026 06:05:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1wd3R4-0001K5-K3
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 06:05:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1wd3Qs-0001wv-FI
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 06:05:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782468308;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=RLbVtQGiG4ru3uqhqJzzg4EnwN7QmmNrLJjw8MvZ544=;
 b=IrS5ZCgPH+78MzLPKT56+TxtXRPSHqQVKk8BVUladhceEgGA49JOzDF2mDeZrfI7LEtRN/
 UBulbEcCad7l2USol+zcnIY3iUB9JXhHcaYALS6v6jDep3ku1P/ZTVMnatyF0Mzn8RK2qX
 h9Z/nnTYO4ATy6caJvubFsKO2QWOhew=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-324-SfUBlDUtMj6-abVzD6jK1w-1; Fri, 26 Jun 2026 06:05:06 -0400
X-MC-Unique: SfUBlDUtMj6-abVzD6jK1w-1
X-Mimecast-MFC-AGG-ID: SfUBlDUtMj6-abVzD6jK1w_1782468306
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-915f6ff639aso198432285a.1
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 03:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782468306; x=1783073106; darn=nongnu.org;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=RLbVtQGiG4ru3uqhqJzzg4EnwN7QmmNrLJjw8MvZ544=;
 b=WoL3a44Uqj/CPpzHjECfx53ntbSl2L4M4DhjOD54kDVJ71WHCEkU00ad7F8ZYOiYv4
 h4coEflrDd8qaZqig9gjL9dXESqcW+j6aaDdJ6phllthrkXrxHxC3iEbIXoO4VC4btcT
 xxGUGMgrwzXayAyqCoZe6/Bucn74atarPwkpLJvp0tNm8bgcY/iiWeqwGHriJbtgilS8
 sgh1tYeP6Du8Ang8FxTaID48UqSFtgmUz+fsoXvXegzpn/m55sriSMm+soDyD33F5oMn
 0x5agoph3CQ2X/rEyBrkwDcSIvYQrN+r9xsRvtIs2+fYc8NpgNBhUhlJnhAaNfLNTgTp
 7oTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782468306; x=1783073106;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RLbVtQGiG4ru3uqhqJzzg4EnwN7QmmNrLJjw8MvZ544=;
 b=JW+NKJZ23Whz0QPLAxobtw71764c4xQneQV/FFfUhpjdBRT2yE8FsaO5LXz/3NcxYG
 MCqzqlZ82D/uNHDLoAFb/6uK8UWzihpou30k9ttztQJTkHFnXjRKR5xECIK5xcXfwGeQ
 Fz0GMa/Zr36TKxhW3j+d7VuHuSwRXZDc4LNACxwefGxRa6X1PkWOdCb13xVluI8XbDy5
 UyqT+gyqYRx8PG6aWRWwvI32zSZ4VQdhWrxD8UU/ingXeTDMlS6DBcjy58SVacKbag0G
 Hv81cVIEvd4JisDXEB/O3EaboRrfsv0h1c1EymhbduXESMnd2pVx1JCxyjH6xDD4CZ2s
 xFIw==
X-Gm-Message-State: AOJu0YyFFUm/hkTcJYQV1iGiV/O8KgIyZWu7wVSZWQ61JrSj3X61skfI
 vgXLhgRpAwJuvVR8HP7RD3G7lsyXma6OoBd8nx+YBiYyzeFgJVjc6FX1C++QidaTh0RxXLSR8R8
 /MHUjoTRDcZN1OZd5qVjulKteplaSczD8H70Z6LQMl7tKvn+r55+N80HY
X-Gm-Gg: AfdE7ckvxTJoxlNbQLCh5SMA5DDtGnFfhs7naBUWnSfyXBMiki9/Ch0YwY8g9erBzoP
 mHnwA9sIy3roPGzY+fEkUGvi1k0jZyk0d6eT0QSbo9TP6uzHGVzwi6TRm1qCxdsNDPw1mTN5Kd0
 3Yov3E84l8QsACJIFwKbHigAVdpUUZHrisBIoirohXOEb6WNLoci3adygL7Hp/uOVs+2+U29UG1
 Dpij43z5Wmp23eGXSAOB1WPNhpNoK5LndTuARw5zb/q4cH8m08y7v9AEJo4QtaBfROw2xgefgt7
 Gpw18yDf1m+9397W5xOHipyVeqd6Aa+UlnhFTfI5m2MkQx99+xqssHa7DSRQ3KzIg4/6631Nsp1
 jIMjDxXF/l4hp4B+IKu00V8GVWsnUUQBPokX9BErkcWke7rzx8ElWPaTarNdvSCvm/kJIUK+vm7
 NjXylu
X-Received: by 2002:a05:620a:470c:b0:916:1970:5e66 with SMTP id
 af79cd13be357-9293c9e81f2mr920650585a.44.1782468305922; 
 Fri, 26 Jun 2026 03:05:05 -0700 (PDT)
X-Received: by 2002:a05:620a:470c:b0:916:1970:5e66 with SMTP id
 af79cd13be357-9293c9e81f2mr920643485a.44.1782468305321; 
 Fri, 26 Jun 2026 03:05:05 -0700 (PDT)
Received: from lleonard-thinkpadx1carbongen13.rmtit.csb ([151.29.41.106])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-925fd390e76sm1122716485a.3.2026.06.26.03.05.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 03:05:04 -0700 (PDT)
From: Luigi Leonardi <leonardi@redhat.com>
Subject: [PATCH v6 0/3] igvm: misc changes and device tree support
Date: Fri, 26 Jun 2026 12:04:00 +0200
Message-Id: <20260626-microvm_device_tree-v6-0-9cd13cf057e2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33PzW7DIAwH8FepOI/JfISQnfYe01QFsBcOaSYSo
 VZV3n1uT5mS7fg39s/mLmYsGWfxdrqLgjXPebpwcC8nEYf+8oUyJ85Cg3bgwMsxxzLV8Zy4OeJ
 5KYiS30w0QQX0TvDkd0HK16f68cl5yPMyldtzSVWP6v9eVRJka8C3tk8A4N8LpqFfXuM0igdY9
 QZRcIxoRiwFa1mKtqMdYraIOkaMVDJR6CLxHRD2l9gt0hwjlhGlfd90lDS1e6TZIPoPpOHvhEi
 kFCWXVPyFrOv6A3GQcLjLAQAA
X-Change-ID: 20260608-microvm_device_tree-0263c3b1be86
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
 Oliver Steffen <osteffen@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Luigi Leonardi <leonardi@redhat.com>
X-Mailer: b4 0.14.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=leonardi@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This device tree will be consumed by Coconut SVSM with the upcoming device
tree support [1]. This will allow SVSM to run on a normal CPU
(not AMD SEV-SNP) and execute all its tests using upstream QEMU.

Eventually edk2 will also be able to consume DT via IGVM, but the work
has not started yet.

This series contains one patch that simplifies meson logic and another one
that changes the return behaviour of `qigvm_find_param_entry`.

This is to avoid conflicts with the device tree patch itself, that needs
to modify the same lines.

[1] https://github.com/coconut-svsm/svsm/pull/1006

Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
---
Changes in v6:
- Picked up https://lore.kernel.org/qemu-devel/20260618-igvm_error-v2-1-2b03f4790e4f@redhat.com/
and fixed conflicts
- Link to v5: https://lore.kernel.org/qemu-devel/20260625-microvm_device_tree-v5-0-bcff11fd6d1c@redhat.com

Changes in v5:
- Added a patch, suggested by Paolo, to simplify current igvm meson config
- Added missing fdt dependency for igvm in meson.
- Link to v4: https://lore.kernel.org/qemu-devel/20260615-microvm_device_tree-v4-1-128a59fd2f78@redhat.com

Changes in v4:
- Using g_memdup2 [Stefano]
- madt directive is now protected by CONFIG_FDT [Stefano]
- Link to v3: https://lore.kernel.org/qemu-devel/20260611-microvm_device_tree-v3-1-dfb9cf0000b8@redhat.com

Changes in v3:
- Device tree is packed in igvm core code. [Gerd]
- Dropped microvm patch.
- Link to v2: https://lore.kernel.org/qemu-devel/20260610-microvm_device_tree-v2-0-4fb44730c49f@redhat.com

Changes in v2:
- First patch introduced a shadowed variable, fixed.
- When parameter area is not found return -1.
- Moved `qigvm_directive_device_tree` to backends/igvm.c
- Link to v1: https://lore.kernel.org/qemu-devel/20260608-microvm_device_tree-v1-0-730874ad0008@redhat.com

---
Luigi Leonardi (3):
      igvm: Report error on missing parameter area in directive handlers
      igvm: use idiomatic meson conditional for IGVM build files
      igvm: add device tree parameter support

 backends/igvm.c                | 80 ++++++++++++++++++++++++++++++++++++------
 backends/meson.build           |  7 ++--
 include/system/igvm-internal.h |  3 +-
 target/i386/igvm.c             |  5 +--
 4 files changed, 77 insertions(+), 18 deletions(-)
---
base-commit: 60533c6193ede6ce403e82d09d82ae2bc8fb423a
change-id: 20260608-microvm_device_tree-0263c3b1be86

Best regards,
-- 
Luigi Leonardi <leonardi@redhat.com>


