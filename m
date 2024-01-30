Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01607C46CD2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 05:41:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUgqV-0002rO-Gr; Tue, 30 Jan 2024 00:39:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rUgqQ-0002qz-Ka
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 00:39:38 -0500
Received: from mail-ua1-x930.google.com ([2607:f8b0:4864:20::930])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rUgqN-0001Lw-P9
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 00:39:38 -0500
Received: by mail-ua1-x930.google.com with SMTP id
 a1e0cc1a2514c-7d2a67daa25so1648543241.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 21:37:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1706593051; x=1707197851;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=r0JbnGU2PJ9V5/UZ/7dTe2x30XpQGh60JsZEGfdgl8M=;
 b=Y+bIn0ZR8ERG4Dwm3R2RqYQruPhNTOEmq+r6BrnHjz3cVFyJgVUQj0quakKJnHB5kB
 NV0O/ZtEPSLZ2yyffkrGnkthhOnrVNi/Tlq0+xkMFheFdQZtVihgXlD/3xf3i5dP2rlP
 0BT41UF/9RkCihXW8jD0xCYytimRln2dFWABU+Oaj0LVLP+NrY4JE+wVfog4Ip9qV7qN
 xP9txeOZ61FM04FA3aF7//qEfhVErAV70jLvxMSo/DrILwwo28S2rDDnVgFgqGKDEzIw
 bQM8txkNe1jt4UdCV/s3U1MG656Ip9q1/ANQ+3ILOsI1mFvEFuekADPLcPs8KPZ1Au8m
 2Hng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706593051; x=1707197851;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=r0JbnGU2PJ9V5/UZ/7dTe2x30XpQGh60JsZEGfdgl8M=;
 b=cz3Dc64JlVNPYEjtZuEBJ+/aFh494Y/AoedeQjHDXlyIbnpfZMaNtvVT0CEmovuF59
 KtFMnjtfVf29goaxy18CWfA2+5jx+bz3CMXCGdVHU5e0vKE8lbJmP8Vq0MQ2NkW5gnjJ
 s2arrZPFv9XH98gWkhm2AMRU4gOTPE2wfGfjre4+De4MFkJWllN4KjAP9bQ1sWvaq9Vc
 c3nRQ831MaHozLjplV/sg7bWCd01iJd88nh1x4M4Ip8BjU9mV9oxIrewD7BHcEGrumV8
 qKizwv+1fpfw27/wK4FVZUuC0ocYB4K35AbGJkYzKiIGVXI3+/Tvi4OnaEa9+AoDWJrO
 OhEg==
X-Gm-Message-State: AOJu0YyogH/JJho14bSUPrSLDhZGfMrlhe/BJlL/n38qOR+i/ckJASQ+
 321TE1Plw9nGZ4hSVePEU2O0FMEpO0u1eOytCyMOJvqKy5w9N2fgGjQOVXeaZgGSz4V4VNmFx3q
 RVcE=
X-Google-Smtp-Source: AGHT+IHAoHVhnc8TFHC45xIfSZifAqAOZg3lb7TQrwaqbQLhtgAPS2jAJE3VsbwYoAfDZsTVueBifA==
X-Received: by 2002:a05:6102:3c98:b0:46b:62af:d724 with SMTP id
 c24-20020a0561023c9800b0046b62afd724mr3572132vsv.39.1706593050731; 
 Mon, 29 Jan 2024 21:37:30 -0800 (PST)
Received: from anolis-dev.zelin.local ([221.122.98.162])
 by smtp.gmail.com with ESMTPSA id
 bv123-20020a632e81000000b005c1ce3c960bsm7343532pgb.50.2024.01.29.21.37.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jan 2024 21:37:30 -0800 (PST)
From: yong.huang@smartx.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 yong.huang@smartx.com
Subject: [PATCH v4 0/7] Support generic Luks encryption 
Date: Tue, 30 Jan 2024 13:37:18 +0800
Message-Id: <cover.1706586786.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::930;
 envelope-from=yong.huang@smartx.com; helo=mail-ua1-x930.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Hyman Huang <yong.huang@smartx.com>

Sorry for the late post of version 4. The modifications are as follows:

v4:
- Rebase on master

- squash [PATCH v3 02/10] to [PATCH v3 01/10]

- refactor the logic of block_crypto_open_generic in [PATCH v3 02/10]
  as Daniel suggestted:
  a. drop the invalid parameter check for "header" option and use the
     ERRP_GUARD to probe the error of bdrv_open_child instead.
  b. add a new emum entry to QCryptoBlockOpenFlags to instruct the  
     process of LUKS volume open skip the payload overlap check instead
     of using the macro INVALID_SECTOR_OFFSET.

- drop the detached_header_size field and use local variable instead in
  [PATCH v3 04/10] 

- drop the detached-header option in [PATCH v3 04/10]

- drop the commit [PATCH v3 05/10]:
  crypto: Mark the payload_offset_sector invalid for detached LUKS header 

- introduce QCryptoBlockCreateFlags to instruct the creation process to
  set the payload_offset_sector to 0 in [PATCH v4 03/7]

- refactor the logic of block_crypto_co_create_luks in [PATCH v3 06/10]: 
  a. fix the compile failure
  b. use the existing 'fail:' label to handle the error logic

- refine the comment in qapi suggested by Markus.

- modify the test case to accommodate the new implementation. 

Thanks for commenting on this series, please review.

Best regared,

Yong

v3:
- Rebase on master
- Add a test case for detached LUKS header
- Adjust the design to honour preallocation of the payload device
- Adjust the design to honour the payload offset from the header,
  even when detached
- Support detached LUKS header creation using qemu-img
- Support detached LUKS header querying
- Do some code clean

v2:
- Simplify the design by reusing the LUKS driver to implement
  the generic Luks encryption, thank Daniel for the insightful 
  advice.
- rebase on master. 

This functionality was motivated by the following to-do list seen
in crypto documents:
https://wiki.qemu.org/Features/Block/Crypto 

The last chapter says we should "separate header volume": 

The LUKS format has ability to store the header in a separate volume
from the payload. We should extend the LUKS driver in QEMU to support
this use case.

By enhancing the LUKS driver, it is possible to implement
the LUKS volume with a detached header.

Normally a LUKS volume has a layout:
  disk:  | header | key material | disk payload data |

With a detached LUKS header, you need 2 disks so getting:
  disk1:  | header | key material |
  disk2:  | disk payload data |

There are a variety of benefits to doing this:
 * Secrecy - the disk2 cannot be identified as containing LUKS
             volume since there's no header
 * Control - if access to the disk1 is restricted, then even
             if someone has access to disk2 they can't unlock
             it. Might be useful if you have disks on NFS but
             want to restrict which host can launch a VM
             instance from it, by dynamically providing access
             to the header to a designated host
 * Flexibility - your application data volume may be a given
                 size and it is inconvenient to resize it to
                 add encryption.You can store the LUKS header
                 separately and use the existing storage
                 volume for payload
 * Recovery - corruption of a bit in the header may make the
              entire payload inaccessible. It might be
              convenient to take backups of the header. If
              your primary disk header becomes corrupt, you
              can unlock the data still by pointing to the
              backup detached header

Take the raw-format image as an example to introduce the usage
of the LUKS volume with a detached header:

1. prepare detached LUKS header images
$ dd if=/dev/zero of=test-header.img bs=1M count=32
$ dd if=/dev/zero of=test-payload.img bs=1M count=1000
$ cryptsetup luksFormat --header test-header.img test-payload.img
> --force-password --type luks1

2. block-add a protocol blockdev node of payload image
$ virsh qemu-monitor-command vm '{"execute":"blockdev-add",
> "arguments":{"node-name":"libvirt-1-storage", "driver":"file",
> "filename":"test-payload.img"}}'

3. block-add a protocol blockdev node of LUKS header as above.
$ virsh qemu-monitor-command vm '{"execute":"blockdev-add",
> "arguments":{"node-name":"libvirt-2-storage", "driver":"file",
> "filename": "test-header.img" }}'

4. object-add the secret for decrypting the cipher stored in
   LUKS header above
$ virsh qemu-monitor-command vm '{"execute":"object-add",
> "arguments":{"qom-type":"secret", "id":
> "libvirt-2-storage-secret0", "data":"abc123"}}'

5. block-add the raw-drived blockdev format node
$ virsh qemu-monitor-command vm '{"execute":"blockdev-add",
> "arguments":{"node-name":"libvirt-1-format", "driver":"raw",
> "file":"libvirt-1-storage"}}'

6. block-add the luks-drived blockdev to link the raw disk
   with the LUKS header by specifying the field "header"
$ virsh qemu-monitor-command vm '{"execute":"blockdev-add",
> "arguments":{"node-name":"libvirt-2-format", "driver":"luks",
> "file":"libvirt-1-format", "header":"libvirt-2-storage",
> "key-secret":"libvirt-2-format-secret0"}}'

7. hot-plug the virtio-blk device finally
$ virsh qemu-monitor-command vm '{"execute":"device_add",
> "arguments": {"num-queues":"1", "driver":"virtio-blk-pci",
> "drive": "libvirt-2-format", "id":"virtio-disk2"}}'

Starting a VM with a LUKS volume with detached header is
somewhat similar to hot-plug in that both maintaining the
same json command while the starting VM changes the
"blockdev-add/device_add" parameters to "blockdev/device".

Hyman Huang (7):
  crypto: Support LUKS volume with detached header
  qapi: Make parameter 'file' optional for BlockdevCreateOptionsLUKS
  crypto: Modify the qcrypto_block_create to support creation flags
  block: Support detached LUKS header creation using blockdev-create
  block: Support detached LUKS header creation using qemu-img
  crypto: Introduce 'detached-header' field in QCryptoBlockInfoLUKS
  tests: Add case for LUKS volume with detached header

 MAINTAINERS                                   |   5 +
 block.c                                       |   5 +-
 block/crypto.c                                | 144 ++++++++++--
 block/crypto.h                                |   8 +
 block/qcow.c                                  |   2 +-
 block/qcow2.c                                 |   2 +-
 crypto/block-luks.c                           |  41 +++-
 crypto/block.c                                |   4 +-
 crypto/blockpriv.h                            |   2 +
 include/crypto/block.h                        |  16 ++
 qapi/block-core.json                          |  13 +-
 qapi/crypto.json                              |   8 +-
 tests/qemu-iotests/210.out                    |   4 +
 tests/qemu-iotests/tests/luks-detached-header | 218 ++++++++++++++++++
 .../tests/luks-detached-header.out            |   5 +
 tests/unit/test-crypto-block.c                |   2 +
 16 files changed, 447 insertions(+), 32 deletions(-)
 create mode 100755 tests/qemu-iotests/tests/luks-detached-header
 create mode 100644 tests/qemu-iotests/tests/luks-detached-header.out

-- 
2.31.1


