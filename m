Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 599B3E7719C
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 10:47:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWCXT-00028L-0W; Fri, 10 Jan 2025 05:46:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tWCXK-00027p-TT
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 05:46:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tWCXJ-0000w3-EA
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 05:46:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736506000;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=efcIt437UwXCTVGhCesuSaY7hUWcSIVhnaXXKf1V8x0=;
 b=KVKV2IvtriAdYWGUhjPtkqmectyVpsOPOk7q1M3YeNWcx0/qykLBuNJr6RlmvxCL0WafQ4
 R7UPOTzQOiFXHk7xk7ZoardgVm/dqOCs5uORjaBgsZL3oDeCvtzkZIMuH8GiuvXbZ1Fflx
 OP4EkQfY9zkuip1UM4Xae2QcMG4UglU=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-flaOzwEmOPOtsYQ9x-SCqA-1; Fri, 10 Jan 2025 05:46:38 -0500
X-MC-Unique: flaOzwEmOPOtsYQ9x-SCqA-1
X-Mimecast-MFC-AGG-ID: flaOzwEmOPOtsYQ9x-SCqA
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-216387ddda8so38892815ad.3
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 02:46:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736505998; x=1737110798;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=efcIt437UwXCTVGhCesuSaY7hUWcSIVhnaXXKf1V8x0=;
 b=RldWFJfBRU5hi6GT30ExSzcsMwQE4QMT7OSvVJPTlmtmoALZ3uizrf30EFzMvy2qa0
 +0cy6T2BE50dyuo3YchLp34rqhRVFnhR+SIK25dRKq0h6m41e5E0AuSkWawn/8t3dmz2
 nOR/IvYKwLQ/6aaKM8UznZdhSFqH3p+YXsrH0ovxLK/5ZGc4y7RDgzrgIvLRrqdpU7ND
 71t7fLBXApV4y8mPBFQAlDttMes4wu+DGfXQtBO7vp6K8wri0/b1JIsvOzf0r2sAWRip
 kJEPb1UShTDlYE53PICzACOx0FNEb3k8EAu628LPhUabhMnhpZP64dz7cSm9+vhs2Hvi
 MrGw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1CAvo1IPyCOUXsJqfITCEN/TJ4nq2cTuwtBXCvBciCKbQjQkWsPKwKdTFV0rhBBDUKSACBPXi6aBL@nongnu.org
X-Gm-Message-State: AOJu0YwK7cyARjk+K7QQm6AHDwNpqXmPRDyeGcuwvx03FyQzncYB4SXL
 /IEEVlTHQIMWQXS75+ifBTjx/GmUg3Za1fqwjAbbhs439rHta+aaceKNcvCWZ9t7ay1/je6sfxI
 xS9o8wlOL3VQhWz2wu1awhKZnAS4Tfzt+G+lvrrqTgHb/rsYcQxpy
X-Gm-Gg: ASbGnctKflMWZvoB/j8AmgIdZCI4jVesQVEC5hq9VdOkSc2qTyOa+6YhahGg99BD6QX
 bQ/HjJmcePHmeenjLX64dqOjE9yn4E6n1A/kHvuR5YzYKeLFGQwyt/PTTxdMMo03XAMR/pPK2En
 YBBL6JkcNJZLTD+gdFACGrjr/LEatIMhksVm2AJ0v9KRnLju7Uk4ePHLKFQ+xTIgt8ue7GqihtX
 +3JGw13sQlzvMyyWkCuxSjMcx+s60LvCMXVmhu8xUlV/UMCXbGaddqiWo3Rxa3D0lGFHAy0f2MD
 bRU=
X-Received: by 2002:a17:902:f706:b0:216:6c88:efd9 with SMTP id
 d9443c01a7336-21a83f4bbf8mr165570695ad.15.1736505997892; 
 Fri, 10 Jan 2025 02:46:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHEFF2rb/mj7jd1Zfx1uc0rNd/z1HRngway678dgCb6CyVhLpQTUE6G34f9nN76iYXEDx1A5g==
X-Received: by 2002:a17:902:f706:b0:216:6c88:efd9 with SMTP id
 d9443c01a7336-21a83f4bbf8mr165570335ad.15.1736505997507; 
 Fri, 10 Jan 2025 02:46:37 -0800 (PST)
Received: from localhost.localdomain ([115.96.31.209])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-21a9f10ddbesm11722255ad.2.2025.01.10.02.46.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2025 02:46:37 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: 
Cc: farosas@suse.de, armbru@redhat.com, Ani Sinha <anisinha@redhat.com>,
 kraxel@redhat.com, lvivier@redhat.com, pbonzini@redhat.com,
 philmd@linaro.org, berrange@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v5 0/3] tests/qtest/libqos: add DMA support for writing and
 reading fw_cfg files
Date: Fri, 10 Jan 2025 16:16:15 +0530
Message-ID: <20250110104619.267564-1-anisinha@redhat.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.436,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

This patchset enables DMA interface support for writing fw-cfg files in
libqtest. The first patch is just a code refactoring so that fw-cfg
directory parsing can be part of a separate helper function.
The second patch is the actual patch that introduces two new apis for
writing and reading fw-cfg files using DMA interface. The apis are
tested by writing a new basic qtest for vmcoreinfo device in patch 3.

$ MALLOC_PERTURB_=255  QTEST_QEMU_BINARY=./qemu-system-x86_64  /workspace/qemu-ani/build/tests/qtest/vmcoreinfo-test
TAP version 13
# random seed: R02S33ea0ae4568aae69a6191a97e6ea37fc
1..1
# Start of x86_64 tests
# Start of vmcoreinfo tests
# starting QEMU: exec ./qemu-system-x86_64 -qtest unix:/tmp/qtest-267380.sock -qtest-log /dev/null -chardev socket,path=/tmp/qtest-267380.qmp,id=char0 -mon chardev=char0,mode=control -display none -audio none -device vmcoreinfo -accel qtest
ok 1 /x86_64/vmcoreinfo/basic-write
# End of vmcoreinfo tests
# End of x86_64 tests

cc: kraxel@redhat.com
cc: farosas@suse.de
cc: lvivier@redhat.com
cc: pbonzini@redhat.com
cc: armbru@redhat.com
cc: philmd@linaro.org
cc: berrange@redhat.com
cc: qemu-devel@nongnu.org
cc: farosas@suse.de

changelog:
v3: first working version of the patch.
v4: refactoring without any new changes put into a new patch.
v5: a new qtest added to exercize the two new write and read apis.

all along, other review feedbacks has been taken into account.

Ani Sinha (3):
  libqos/fw_cfg: refactor file directory iteraton to make it more
    reusable
  tests/qtest/libqos: add DMA support for writing and reading fw_cfg
    files
  tests/qtest/vmcoreinfo: add a unit test to exercize basic vmcoreinfo
    function

 MAINTAINERS                   |   2 +
 tests/qtest/libqos/fw_cfg.c   | 204 ++++++++++++++++++++++++++++++----
 tests/qtest/libqos/fw_cfg.h   |   6 +-
 tests/qtest/meson.build       |   1 +
 tests/qtest/vmcoreinfo-test.c |  90 +++++++++++++++
 5 files changed, 280 insertions(+), 23 deletions(-)
 create mode 100644 tests/qtest/vmcoreinfo-test.c

-- 
2.45.2


