Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A355E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 10:47:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWCX5-000271-6j; Fri, 10 Jan 2025 05:46:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tWCX3-00026k-Ew
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 05:46:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tWCX2-0000vO-2Q
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 05:46:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736505982;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=efcIt437UwXCTVGhCesuSaY7hUWcSIVhnaXXKf1V8x0=;
 b=ROcPEZLp2uApYknXwqiMNnKi9fkEsI0enwtNSIPa2J8A07ZkzRbUIoJKWHL5P09pJKFc7C
 BwS9IhVU+4OTcHEY6WJzvGbC8yA7rrpYpNWxTwsW/jXoz9JoX269nvMmbe5BdcPPU3KwWA
 qDPUoFlxzJnhwJknCg7jk7yuzNWHjMY=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-132-ESWkewt_Nh2Aim6YKzX4vw-1; Fri, 10 Jan 2025 05:46:17 -0500
X-MC-Unique: ESWkewt_Nh2Aim6YKzX4vw-1
X-Mimecast-MFC-AGG-ID: ESWkewt_Nh2Aim6YKzX4vw
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2ef79403c5eso5630036a91.0
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 02:46:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736505977; x=1737110777;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=efcIt437UwXCTVGhCesuSaY7hUWcSIVhnaXXKf1V8x0=;
 b=T/CU0xochdIH/lN60XKkRZ7RowTJbp+NOzaOyMJ0x7xP9wY8DnVjMwInVeZ+phHmdA
 5kxgD4rCh2nSj/XEMAb2FcG5lUmeme35L8BorrcaGVkkqlFVex71dIt+vdtYZVMIS6IN
 jdVqaC13fdI27clzsM96NftEuOczcvr/sivnEUtXRjHiZFsymlacjdmD+xPCtp2+yftq
 WWXhYciJp4y4HO5BY9X7nC27qX7KK6Fi6e3dIZGHILZxG34LfbeHXIVXx2119xVFoCNp
 uIPac+Fz9G1ocIF6vwcczPhh3KDFPjq/D5NeOeTM3jvoeIRSO8fckCuKwIUGnlYKh+MS
 wmDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXbXBwdJVm3p3jyNHjpAQxq1J543cA/CUhWBnewIaZ49i/9TZ6iAvvyagrMoACyEvgtIkqXLP9vfp5a@nongnu.org
X-Gm-Message-State: AOJu0YzZMhIi8kYehjQcWe4sXnS+sQJ3xLvODml6VSAEVCF+coCbOfqE
 buXHMzg8KdB1/8wciOGiK/aexjmy+1MxoP5nj4EKvjFkklxt9gljSmKGBXoJh2tMQ1IZz+Mb9yL
 YVcjrZzkXzBu93Wg1bFws2ED+1k/IetXQNALdBSzPsChwRzWA3omg
X-Gm-Gg: ASbGncsdOdd4UztT/grlswP5BFQREOn8lwTBLFUVeFRpcCUC6WwCRu8M822sWSO6kml
 hc/i5TUxePDsf0lP/0KjD/YBAoSIGTLVwwCa1gyarUOFI4I3cMYsdtXPqPrUGEWW0X/6opCdbKF
 AYAXFphiORqQ8U8VhTMgav1Me6rFtl0PArGNvt3KVuE3yQuXA8E/F6hQTJk17Q7JnQjv4ARss+X
 bcn/fvPQnI7nsHx4k/StJ7zXsxm5LPhJCbYgtAGmDg6+iwtz4vTRARL37G9otq3+81bzkxrC5wK
 XCQ=
X-Received: by 2002:a17:90b:3cd0:b0:2ee:5bc9:75c3 with SMTP id
 98e67ed59e1d1-2f548f09e88mr14478995a91.5.1736505976879; 
 Fri, 10 Jan 2025 02:46:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGOpEB5Ywtowzg6G5go2elo9/A9sRz/v8Uo8HqldR/EPBcQ6nXmqCjw6KPf+8OqkjANLhFuNw==
X-Received: by 2002:a17:90b:3cd0:b0:2ee:5bc9:75c3 with SMTP id
 98e67ed59e1d1-2f548f09e88mr14478981a91.5.1736505976581; 
 Fri, 10 Jan 2025 02:46:16 -0800 (PST)
Received: from localhost.localdomain ([115.96.31.209])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-2f54a289118sm5651173a91.13.2025.01.10.02.46.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2025 02:46:15 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: 
Cc: farosas@suse.de, armbru@redhat.com, Ani Sinha <anisinha@redhat.com>,
 kraxel@redhat.com, lvivier@redhat.com, pbonzini@redhat.com,
 philmd@linaro.org, berrange@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v5 0/3] tests/qtest/libqos: add DMA support for writing and
 reading fw_cfg files
Date: Fri, 10 Jan 2025 16:13:29 +0530
Message-ID: <20250110104335.267518-1-anisinha@redhat.com>
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


