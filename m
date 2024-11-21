Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DEC8E64007
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 19:22:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tECkq-0006KG-Cr; Thu, 21 Nov 2024 14:22:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tECkl-0006JX-22
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 14:22:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tECki-0002VZ-D5
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 14:22:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732216926;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=1Yc29PpfVCMMuzFkDxnHpDhTvQeVXzgaBGslBqG/iak=;
 b=KMosyc9D0MyZGHiNsL8UqRog/sGZEPCpnRqejCFWfOm+/bp7v1n5UvVO79KOJrTRCp0pB+
 Z4qn02+h+RC8McFWSkIuYz5CPkrJsHHdN377GVTDqq3uql/60blcGfrvm9MbpTsAybFr0L
 Gh3SQn9pyv7OF9qA4EbVXFreGUYsn60=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-VVp9iIR-PkCoBDr0RvM18w-1; Thu, 21 Nov 2024 14:22:05 -0500
X-MC-Unique: VVp9iIR-PkCoBDr0RvM18w-1
X-Mimecast-MFC-AGG-ID: VVp9iIR-PkCoBDr0RvM18w
Received: by mail-io1-f70.google.com with SMTP id
 ca18e2360f4ac-83dff8bc954so128141739f.1
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2024 11:22:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732216925; x=1732821725;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1Yc29PpfVCMMuzFkDxnHpDhTvQeVXzgaBGslBqG/iak=;
 b=XZuLpa/4ZquuXcxsqOpy+a6IWsxzuR56PKCG3QYmhm7TvSdqRoCBJYiczfQDmpi2fB
 smtHX4vQJIDc2X/jK4GM25G2taSw0mjd6zIsiEvT8q/R9ZKWuQtMQ+3NBJuERkPJUlvs
 NuLmL8pnQlKXKC0JRT2mJN9LRzeounvbmRW07eZJ6JDGYSNTRX9wwM0ADwfGH7DppGqe
 H4sc2DQpcAukD+ntEW6Io12bo9PxcaUeHgAPTKxPlVFbXCaNXDShIFtxdEPhUArXW/f3
 5r7hjHmZXc/0a/QOXzqhITcAYc/xCRJkuqT2NNhjS27MhKeRAM6EOh8hIlC5ZZBOPH8n
 NIKA==
X-Gm-Message-State: AOJu0YypoOe1F01/w87EYUbevdIV2DwqrTBwYOk6Gx9RIDSQ6csIQFCj
 NMsfgAv8210cl1ivhysAn5hwYXH8J2/+Vj2uMXah0MuP7ZbMZLEEGckIlW1SaLHxna/W3p61xpf
 LXuYg8wTesqo94psHGjyDIAUC0+fzQUpJyrLjocm6E8vcgm0Fv4AsO9KI03iK2STpPKVwv2ybRv
 Am+WU8JxOP4Keh3a6ObGIj+fLgdppztVZlyg==
X-Gm-Gg: ASbGncvtgMtSvo6PO8Y/DhlMzbODefAiRQKRxsRbvxjvUgu6zDRo7almZYO21Q7LjL2
 djC7Qn+uYjY8kVKht1EQaIBYhtrNQ/m0BL2YbD6pKM7HyfEaV/YRQy0Rh1PYM+pFSrmEjqIaCLK
 xMvzxE8v55iN9ETv5Sa+F2oViyUqyUZPGT9HgLBgsNF3NhPw4pqXTmW+Z2bUzuQJGmoZtxfRlJy
 ucTcAlX+bz4aizaCCNcnSl1zmxG2Wx2CK6JPRGKiOO/iTfon/1MQBdHM2TEwaGc3JhHUkjKqEx6
 bTwWBtPEVb0fCdjzZ3she8GyMQ==
X-Received: by 2002:a05:6602:490:b0:82a:3552:6b26 with SMTP id
 ca18e2360f4ac-83ecdd3a01bmr4627739f.15.1732216924759; 
 Thu, 21 Nov 2024 11:22:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFUooRQgvhhsZT9xIXlVmRGSh5BZlun0xdyODiAmWGR6DiDeGbejujvRu4f+EGQi3OmWEM9Pw==
X-Received: by 2002:a05:6602:490:b0:82a:3552:6b26 with SMTP id
 ca18e2360f4ac-83ecdd3a01bmr4623639f.15.1732216924253; 
 Thu, 21 Nov 2024 11:22:04 -0800 (PST)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e1cfe345f0sm102939173.45.2024.11.21.11.22.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Nov 2024 11:22:03 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Juraj Marcin <jmarcin@redhat.com>, peterx@redhat.com,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH v2 00/13] QOM: container_get() removal
Date: Thu, 21 Nov 2024 14:21:49 -0500
Message-ID: <20241121192202.4155849-1-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.14,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This series is not for 9.2, but for 10.0.

v1: https://lore.kernel.org/r/20241120215703.3918445-1-peterx@redhat.com

v2 changelog:
- Rename container_create() to object_property_add_new_container() [Markus]
- Drop "ui/console: Explicitly create "/backend" container", instead create
  "/backend" container along with the rest root containers [Dan]
- Assert in qdev_get_machine() instead of allowing return NULL [Dan]
- machine_get_container(), remove assert, and tiny doc fix [Dan, Markus]
- Make machine_containers[] "const char *const" [Phil]
- Create ppc drc container in drc device class_init [Phil]
- Split the last patch into three [Phil, Dan]

In general, container_get() is a flaky interface in a few things.  Firstly,
some of the users use it without getting a container object.  Secondly, it
can implicitly create containers on the fly.

The series is about container_get() and its removal.  After the whole
series applied, all the system containers will be created explicitly.
Meanwhile no lookup code will implicitly create container anymore.

As Dan (mostly) pointed out, we don't have a super complicated container
layout.  It looks like this:

  /objects
  /chardevs
  /backend
  /dr-connector    (ppc only)
  /machine
    /peripheral
    /peripheral-anon
    /unattached

This series create these containers explicitly.

There's a side benefit of dropping container_get(), which is to avoid
complicated string operations, as container_get() is never used in more
than one depth.  It means switching to object_resolve_path_component()
should make existing code even tiny little faster.

To achieve this, some test needs to be fixed first.  For that, see "tests:
Fix test-qdev-global-props on anonymous qdev realize()".

Comments welcomed, thanks.

Peter Xu (13):
  qom: Add TYPE_CONTAINER macro
  qom: New object_property_add_new_container()
  tests: Fix test-qdev-global-props on anonymous qdev realize()
  tests: Explicitly create containers in test_qom_partial_path()
  ppc/e500: Avoid abuse of container_get()
  hw/ppc: Explicitly create the drc container
  qom: Create system containers explicitly
  qdev: Make qdev_get_machine() not use container_get()
  qdev: Add machine_get_container()
  qom: Use machine_get_container()
  qom: Add object_get_container()
  qom: Use object_get_container()
  qom: Remove container_get()

 include/hw/qdev-core.h              | 10 ++++++++
 include/qom/object.h                | 26 ++++++++++++++------
 backends/cryptodev.c                |  4 +--
 chardev/char.c                      |  2 +-
 hw/arm/stellaris.c                  |  2 +-
 hw/core/gpio.c                      |  3 +--
 hw/core/machine.c                   |  3 ---
 hw/core/qdev.c                      | 21 +++++++++++++---
 hw/core/sysbus.c                    |  4 +--
 hw/i386/pc.c                        |  4 +--
 hw/pci-host/ppce500.c               |  4 +--
 hw/ppc/spapr_drc.c                  | 29 ++++++++++++++--------
 qom/container.c                     | 27 +++++---------------
 qom/object.c                        | 38 ++++++++++++++++++++++++++---
 scsi/pr-manager.c                   |  4 +--
 system/ioport.c                     |  2 +-
 system/memory.c                     |  2 +-
 system/qdev-monitor.c               |  6 ++---
 system/vl.c                         | 19 +++++++++++++--
 tests/unit/check-qom-proplist.c     |  2 +-
 tests/unit/test-qdev-global-props.c | 22 +++++++++++++++++
 ui/console.c                        |  2 +-
 ui/dbus-chardev.c                   |  2 +-
 23 files changed, 167 insertions(+), 71 deletions(-)

-- 
2.45.0


