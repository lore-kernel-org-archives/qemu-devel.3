Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAFC7E9A02C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 13:33:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vshfM-0003wU-3w; Wed, 18 Feb 2026 08:32:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vshfI-0003vG-9J
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 08:32:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vshf4-00053X-Po
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 08:32:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771421521;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=1kmaGr0mcvHIgHTxsf78XZVt9XWkGt61UUQPx8EQH1s=;
 b=KK5SS2okh2wc4QUPMqVN4/0dxWlj1cay5N9X1D5UcMuF18Ha9+SKbCx7J2+RZKk5rgcHny
 n2Rfgq/q6CzPGCBYIQVpToO6iaNt7risbuDRZKH0xzjvWmplv0hMQiO8CtSmo9oFKySC1P
 fl2Tian3eBQZZJ0clC4qXZvMSAcNlyc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-424-erO8PW0XMIqsjIkhbWA8dQ-1; Wed, 18 Feb 2026 08:26:43 -0500
X-MC-Unique: erO8PW0XMIqsjIkhbWA8dQ-1
X-Mimecast-MFC-AGG-ID: erO8PW0XMIqsjIkhbWA8dQ_1771421202
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4836e35292cso41345905e9.1
 for <qemu-devel@nongnu.org>; Wed, 18 Feb 2026 05:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771421202; x=1772026002; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1kmaGr0mcvHIgHTxsf78XZVt9XWkGt61UUQPx8EQH1s=;
 b=HYRJ5yIpv9pZXRRcYahkHWAzTJnpu5yPxAs2hxLRu8dCfB75HtYlW1TWfxgtTwAGN8
 NrSmDzn/kdtm83co4iJg9lDou6uglQ8M9/UQYTbXUmOkKZO09kvBa4Ct7Sji7gvaUQVa
 c0AUAyTHN7BGynIefAJyTAxVM3HyTqItnRblu/LnDCIc8gQHmVu7JfXVaRqZo4JaOLtV
 s2hVQveuxUQ4YNV+nuX17YsX5+K1YL0moOAu6FiIWJppBx2vJPk/CpX3M6cJUUXA5Rsw
 lZvvbQFPQc0hVkPsBDCUPK0oczlqsqBNWei2MO6lcctduhJnjQW5EzHq1wsF5Hfro1+y
 P4AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771421202; x=1772026002;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1kmaGr0mcvHIgHTxsf78XZVt9XWkGt61UUQPx8EQH1s=;
 b=kVJO6f7iC5+HfOZ7/66a7TSjM0h6FbQhVouwA+liIW/1xI9sG4V+FYPNpJfOQ2B7hG
 BW3ASlxU3RjwZIG5aMcg6XbSTG3S1YkwsH/uYgsKvggQc/1AGqWZccBEO3XHQWfwTdrl
 RdxbooSf6EK3TP8j8q9qH2n//MiGE+Y5nKilTCyf31PjHq/3jt4WEfuk6t6oHAJ1poRw
 qbBH4d0DinxTWa5Q209NRkxAphxl5yCeaCa+HPmnshLoS4bKepvZawvK6coJJXLvQRM4
 K59vqlEwBj6GiKa04sOWvvdVJUaHE6/fc+oWD+dNjJ84CQEHWFwKT0vukX2nGLEEW9wZ
 FSUQ==
X-Gm-Message-State: AOJu0YzbDthwMD24tcziNYAm2MWHkLeXiLvwsekY85K+juHM+y1tsfqt
 G3CX4drnquXf+zZ/IeAKzI5UQ40a1ucgCwg7XteKJYDgaz6ONvr5Eo0MGnmPY5DU0eqjESIidvp
 zEyh+OkNL+TvvkvLxmtpUboMXXnN9tUNUn8TtJIjRLg63Mhv95FUfUemo
X-Gm-Gg: AZuq6aJHxzQRksae755+bd1QBaHS4URG4Y99ZMt6KL7/MkhPKkyetn/m6EBapEN2xlw
 dZ9MBZkz1En/1FEEXEWizR0Y0hyPXcyo2Ogd+xC7uQK/4FWAteUaswjvP4I6KK29TyiyxjtxAzo
 CRLD860RF9wzaXvaDeep80xh0HMVeHVGc22QZXlCDhyF7aCtfTT1jEel4efqJ0xQ+CIPS9YFhS2
 +LSlsCwD0e5O4pcV0iG+FD00bbnJJD6aKEuPqwuwWgLL2tfbSErSO99gn8RzVx1op/KkEite1lb
 67ac0JhTp3GMTZnhR5BWweIV1iHkNvWoMxqH4iYoYFPTaf+HXjMptfpypEv4TSSFu+uXAiJ1k5/
 CXJPcIkasf/yneCktXfpe75i3h2m0l4QDTemm0aB4vXVu9IcheLDsWvVFVSLAGExUxLl8facGfl
 7/F4Vi
X-Received: by 2002:a05:600c:4e4d:b0:477:c478:46d7 with SMTP id
 5b1f17b1804b1-48373a3e749mr294261185e9.22.1771421201608; 
 Wed, 18 Feb 2026 05:26:41 -0800 (PST)
X-Received: by 2002:a05:600c:4e4d:b0:477:c478:46d7 with SMTP id
 5b1f17b1804b1-48373a3e749mr294260705e9.22.1771421201143; 
 Wed, 18 Feb 2026 05:26:41 -0800 (PST)
Received: from localhost
 (p200300cfd737d029edef7b8da7441ac2.dip0.t-ipconnect.de.
 [2003:cf:d737:d029:edef:7b8d:a744:1ac2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4834d8334a8sm618595665e9.12.2026.02.18.05.26.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Feb 2026 05:26:39 -0800 (PST)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Brian Song <hibriansong@gmail.com>
Subject: [PATCH v4 00/24] export/fuse: Use coroutines and multi-threading
Date: Wed, 18 Feb 2026 14:26:09 +0100
Message-ID: <20260218132633.29748-1-hreitz@redhat.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


I noticed some performance differences vs. my previous benchmarks;
notably, performance didn’t improve with the introduction of coroutines
much (except for random read performance).  However, when I run the same
benchmarks on the old branch again, I see no performance improvement
either.  Something about my host system must have changed.


Changes from v3:
- Patch 1: Use QEMU_AUTO_VFREE
- Patch 6: Added (fix for pre-existing bug)
- Patch 11: Make flag atomic, better this way for multithreading later
- Patch 12: Rename not only in fuse_write(), but fuse_read() as well
- Patch 13: Added (don’t truncate if we don’t want to test that)
- Patch 14: Added (fix for pre-existing bugs)
- Patch 16: Rewrote core parts:
  - Remove the macros to handle different FUSE requests in the same
    buffer, instead use unions
  - Restructure how we read data from FUSE:
    No longer one request_buf per queue, but instead a non-WRITE buffer
    on the stack, and a WRITE data buffer on the heap. We pass this via
    readv(), but it means that for non-WRITE requests, data that we want
    on the stack may spill into the heap buffer, so we need to copy it
    back. We cache the data buffer between non-WRITE requests so we at
    least don’t have to reallocate it all the time.
  - Actually take care of older FUSE versions down to 7.9 (2007)
  - Handle some more requests that should be handled: STATFS, DESTROY,
    FORGET, BATCH_FORGET
  - Don’t handle short writes on /dev/fuse
  - Move initializing fuse_out_header into the callers of
    fuse_write_response() and fuse_write_buf_response()
- Patch 18: Rebase conflicts because of patch 16, and removed the unused
  FuseRequestCoParam
- Patch 19: Adhere to QAPI max line length
- Patch 21: Added, not sure if absolutely necessary, but won’t hurt
  either
- Patch 22: Rebase conflicts because of patch 16


git-backport-diff from v3:

Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream patch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respectively

001/24:[0009] [FC] 'fuse: Copy write buffer content before polling'
002/24:[----] [--] 'fuse: Ensure init clean-up even with error_fatal'
003/24:[----] [--] 'fuse: Remove superfluous empty line'
004/24:[----] [--] 'fuse: Explicitly set inode ID to 1'
005/24:[----] [--] 'fuse: Change setup_... to mount_fuse_export()'
006/24:[down] 'fuse: Destroy session on mount_fuse_export() fail'
007/24:[----] [--] 'fuse: Fix mount options'
008/24:[----] [--] 'fuse: Set direct_io and parallel_direct_writes'
009/24:[----] [--] 'fuse: Introduce fuse_{at,de}tach_handlers()'
010/24:[----] [--] 'fuse: Introduce fuse_{inc,dec}_in_flight()'
011/24:[0008] [FC] 'fuse: Add halted flag'
012/24:[0012] [FC] 'fuse: fuse_{read,write}: Rename length to blk_len'
013/24:[down] 'iotests/308: Use conv=notrunc to test growability'
014/24:[down] 'fuse: Explicitly handle non-grow post-EOF accesses'
015/24:[----] [--] 'block: Move qemu_fcntl_addfl() into osdep.c'
016/24:[0718] [FC] 'fuse: Manually process requests (without libfuse)'
017/24:[----] [-C] 'fuse: Reduce max read size'
018/24:[0102] [FC] 'fuse: Process requests in coroutines'
019/24:[0018] [FC] 'block/export: Add multi-threading interface'
020/24:[----] [--] 'iotests/307: Test multi-thread export interface'
021/24:[down] 'fuse: Make shared export state atomic'
022/24:[0084] [FC] 'fuse: Implement multi-threading'
023/24:[----] [--] 'qapi/block-export: Document FUSE's multi-threading'
024/24:[----] [--] 'iotests/308: Add multi-threading sanity test'


Hanna Czenczek (24):
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
  fuse: Manually process requests (without libfuse)
  fuse: Reduce max read size
  fuse: Process requests in coroutines
  block/export: Add multi-threading interface
  iotests/307: Test multi-thread export interface
  fuse: Make shared export state atomic
  fuse: Implement multi-threading
  qapi/block-export: Document FUSE's multi-threading
  iotests/308: Add multi-threading sanity test

 qapi/block-export.json               |   41 +-
 include/block/export.h               |   12 +-
 include/qemu/osdep.h                 |    1 +
 block/export/export.c                |   48 +-
 block/export/fuse.c                  | 1278 ++++++++++++++++++++------
 block/export/vduse-blk.c             |    7 +
 block/export/vhost-user-blk-server.c |    8 +
 block/file-posix.c                   |   17 +-
 nbd/server.c                         |    6 +
 util/osdep.c                         |   18 +
 tests/qemu-iotests/307               |   47 +
 tests/qemu-iotests/307.out           |   18 +
 tests/qemu-iotests/308               |   95 +-
 tests/qemu-iotests/308.out           |   71 +-
 14 files changed, 1358 insertions(+), 309 deletions(-)

-- 
2.53.0


