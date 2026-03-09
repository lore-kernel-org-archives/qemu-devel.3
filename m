Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44862F41807
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 15:11:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzcEQ-0000cg-FT; Mon, 09 Mar 2026 11:09:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vzcEO-0000ar-6t
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:09:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vzcEK-0008HL-Nv
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:09:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773068950;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=XBGlyNjS+p+0H4sHLi4cCOHB41xGO5S3ovF0V2Oo9sk=;
 b=Q06Vv6xyFXv97qSuNpqHgxkmFM9HaqjdXBsatiE5Btn8YWyW1zHzPUYqE9ZZM5a/0ppeT+
 s4u+yIAmKrTDpfv3iaX0zFjmAhCPBqyPvWvKy907VK0Cbwf68fzcw7ZcUyd2By/BrmwMk8
 uPJimo+5F/s/XCW+v+EAG2kZzEr9wK4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-mEzhA1y8OnemZvOAJr4Reg-1; Mon, 09 Mar 2026 11:09:09 -0400
X-MC-Unique: mEzhA1y8OnemZvOAJr4Reg-1
X-Mimecast-MFC-AGG-ID: mEzhA1y8OnemZvOAJr4Reg_1773068948
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4853f33b7dbso5962435e9.3
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 08:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773068948; x=1773673748; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=XBGlyNjS+p+0H4sHLi4cCOHB41xGO5S3ovF0V2Oo9sk=;
 b=GUaIUmhlSht02rTI9wFWiDHRah5/UqVCg3FVU5aQMzFmVJYmcEe9rMRspnToufApeB
 JE6MhWhsTlaY3P1bem36BzCXX+YYK8kDAAj60g+MnLodBlWFRx71Zz1xPt8AyJDapyYW
 FWF8PyipZGqq4QhcDwpBrarmOcIDkxgxmTtUgcV2eGeILgo3RwQWegAUlX13FsBXR5WS
 BwjdMf9U/ugaWQpK8w4rzXachKbSwfd7+1MlDCM9QX0mkNAXJyLrq5PloUJnPEfPXX9B
 UH6H3Ccn9w/az1pl2480ai3La3HjqIEOnxC/PCY7C8HkVpNJZzldSLk9Dvyy9rbPTTzU
 xElg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773068948; x=1773673748;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XBGlyNjS+p+0H4sHLi4cCOHB41xGO5S3ovF0V2Oo9sk=;
 b=YCdsQcRjc9fzQVfCyPx02CLWpskO4+M4xBwVhJqf0lEVgbLGOP4swDA/MTpaNs3ClY
 N64RDRQ3RoglpGi+KRB16tbDVqsfm8uGhorEMOBasC2uC0rxKxeJBN26UkP2lyB8qm/X
 TLq0GwLzFamiAcLzleG78EMNfRneXIq56cx5zEhY6R8QDD3UhnSWTltF44x3jcT8YJYc
 9s3MjvrMDskP1SwfAvZRWc+KZNgZVX03Wj0ncbos6tajp9gZq1TqqXq0inFKS12AQPUq
 5IlI12MuWdzAXIsWvjnjYadu1Q6S94+q1aN3ZaUklomCMv5aIvLW+hoeR58aqI7QX5Hn
 Qmww==
X-Gm-Message-State: AOJu0Yx4dzobDqX5EZ2mLqokAt+XZP7duHz5XQu1q/gyianhZj6AkVW9
 LmKlrFQWKNfWfV9mfSLN0W1MfJpmXnoVpQh7ui1BET86ccYCqA8IzZVYy9ydQ5rPoE/kB2jNeRe
 EQrHEQJbLtWzA7SHdGU2K1eNp4MxNXvzdS7Zr3GIm0k3i0QrFMtcD41cmYSY1AIWt
X-Gm-Gg: ATEYQzybwPUyI9/FrouKISCfSlxFm8eOK8t0lzz4Vv/LsiP1aVCsr+oYfQaDwTEdaRZ
 GdcAOaIPXDit+t8mxZfmMEMS6IZTcB60pLlfgyUjdkt5KVMpaFafd652/e9Mip5NAwO4KuUl30f
 hZ/RG9dhCcp7dKDo/qAxdrjzG9omcj8l6OUpHk8wwfPNO8OYWcY9hjk/i5onrFk/oN3s/NjH5Oh
 u2Nu81+1aPAXfNe1EROwdSsuXNGm6CWvdJ0pQlOgL72BwAhYrdfM4iomYaGglk8WOBk+3kbvHKL
 ZRT+g8YLBg1A2DiaSA806mQNkb8KUhsi1jzaP7T4ZaFr2vVbsL9mEO/unM/l5ygp/Y94toFCevB
 IIk4LoROR1jiHF7Fofyrq/vz/GrokyOlMTOdey8JgG5Yc5lKrr0vOqybEg7lEAdqOzBOJnbamCg
 2byIOK
X-Received: by 2002:a05:600c:46cb:b0:485:3dfc:57c with SMTP id
 5b1f17b1804b1-4853dfc073cmr38269885e9.21.1773068947745; 
 Mon, 09 Mar 2026 08:09:07 -0700 (PDT)
X-Received: by 2002:a05:600c:46cb:b0:485:3dfc:57c with SMTP id
 5b1f17b1804b1-4853dfc073cmr38269265e9.21.1773068947286; 
 Mon, 09 Mar 2026 08:09:07 -0700 (PDT)
Received: from localhost
 (p200300cfd737d0cf29d515fbd6051d53.dip0.t-ipconnect.de.
 [2003:cf:d737:d0cf:29d5:15fb:d605:1d53])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dae35cf7sm25873557f8f.26.2026.03.09.08.09.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 08:09:06 -0700 (PDT)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Brian Song <hibriansong@gmail.com>
Subject: [PATCH v5 00/25] export/fuse: Use coroutines and multi-threading
Date: Mon,  9 Mar 2026 16:08:31 +0100
Message-ID: <20260309150856.26800-1-hreitz@redhat.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi,

This series:
- Fixes some bugs/minor inconveniences,
- Removes libfuse from the request processing path,
- Make the FUSE export use coroutines for request handling,

More detail on the v1 cover letter:
https://lists.nongnu.org/archive/html/qemu-block/2025-03/msg00359.html

v2 cover letter:
https://lists.nongnu.org/archive/html/qemu-block/2025-06/msg00040.html

v3 cover letter:
https://lists.nongnu.org/archive/html/qemu-block/2025-07/msg00005.html

v4 cover letter:
https://lists.nongnu.org/archive/html/qemu-block/2026-02/msg00324.html


v4 fixes the problems Kevin has pointed out on list:
- Fix fuse-allow-other test by making the export writable,
- Drop outdated comment,
- Add comment explaining why bufptr should be explicitly set to NULL in
  the empty-read branch of fuse_read().

And the TSA warnings indicated off-list, by making all FUSE handling
functions (which run in a coroutine) GRAPH_RDLOCK, having
fuse_co_process_request() take the lock.  For this, we need to drop the
permission manipulation functions in the I/O path, but that is easy (new
patch 16).


git-backport-diff from v4:

Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream patch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respectively

001/25:[----] [--] 'fuse: Copy write buffer content before polling'
002/25:[----] [--] 'fuse: Ensure init clean-up even with error_fatal'
003/25:[----] [--] 'fuse: Remove superfluous empty line'
004/25:[----] [--] 'fuse: Explicitly set inode ID to 1'
005/25:[----] [--] 'fuse: Change setup_... to mount_fuse_export()'
006/25:[----] [--] 'fuse: Destroy session on mount_fuse_export() fail'
007/25:[0012] [FC] 'fuse: Fix mount options'
008/25:[----] [--] 'fuse: Set direct_io and parallel_direct_writes'
009/25:[----] [--] 'fuse: Introduce fuse_{at,de}tach_handlers()'
010/25:[----] [--] 'fuse: Introduce fuse_{inc,dec}_in_flight()'
011/25:[----] [--] 'fuse: Add halted flag'
012/25:[----] [--] 'fuse: fuse_{read,write}: Rename length to blk_len'
013/25:[----] [--] 'iotests/308: Use conv=notrunc to test growability'
014/25:[----] [--] 'fuse: Explicitly handle non-grow post-EOF accesses'
015/25:[----] [--] 'block: Move qemu_fcntl_addfl() into osdep.c'
016/25:[down] 'fuse: Drop permission changes in fuse_do_truncate'
017/25:[0003] [FC] 'fuse: Manually process requests (without libfuse)'
018/25:[----] [-C] 'fuse: Reduce max read size'
019/25:[0034] [FC] 'fuse: Process requests in coroutines'
020/25:[----] [--] 'block/export: Add multi-threading interface'
021/25:[----] [--] 'iotests/307: Test multi-thread export interface'
022/25:[----] [--] 'fuse: Make shared export state atomic'
023/25:[----] [--] 'fuse: Implement multi-threading'
024/25:[----] [--] 'qapi/block-export: Document FUSE's multi-threading'
025/25:[----] [--] 'iotests/308: Add multi-threading sanity test'


Hanna Czenczek (25):
  fuse: Copy write buffer content before polling
  fuse: Ensure init clean-up even with error_fatal
  fuse: Remove superfluous empty line
  fuse: Explicitly set inode ID to 1
  fuse: Change setup_... to mount_fuse_export()
  fuse: Destroy session on mount_fuse_export() fail
  fuse: Fix mount options
  fuse: Set direct_io and parallel_direct_writes
  fuse: Introduce fuse_{at,de}tach_handlers()
  fuse: Introduce fuse_{inc,dec}_in_flight()
  fuse: Add halted flag
  fuse: fuse_{read,write}: Rename length to blk_len
  iotests/308: Use conv=notrunc to test growability
  fuse: Explicitly handle non-grow post-EOF accesses
  block: Move qemu_fcntl_addfl() into osdep.c
  fuse: Drop permission changes in fuse_do_truncate
  fuse: Manually process requests (without libfuse)
  fuse: Reduce max read size
  fuse: Process requests in coroutines
  block/export: Add multi-threading interface
  iotests/307: Test multi-thread export interface
  fuse: Make shared export state atomic
  fuse: Implement multi-threading
  qapi/block-export: Document FUSE's multi-threading
  iotests/308: Add multi-threading sanity test

 qapi/block-export.json                        |   41 +-
 include/block/export.h                        |   12 +-
 include/qemu/osdep.h                          |    1 +
 block/export/export.c                         |   48 +-
 block/export/fuse.c                           | 1311 +++++++++++++----
 block/export/vduse-blk.c                      |    7 +
 block/export/vhost-user-blk-server.c          |    8 +
 block/file-posix.c                            |   17 +-
 nbd/server.c                                  |    6 +
 util/osdep.c                                  |   18 +
 tests/qemu-iotests/307                        |   47 +
 tests/qemu-iotests/307.out                    |   18 +
 tests/qemu-iotests/308                        |   95 +-
 tests/qemu-iotests/308.out                    |   71 +-
 tests/qemu-iotests/tests/fuse-allow-other     |    3 +-
 tests/qemu-iotests/tests/fuse-allow-other.out |    9 +-
 16 files changed, 1369 insertions(+), 343 deletions(-)

-- 
2.53.0


