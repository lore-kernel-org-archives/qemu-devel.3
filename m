Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 687C4F532ED
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 08:44:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4xMe-0004Zi-LO; Tue, 24 Mar 2026 04:43:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1w4xMc-0004ZD-TF
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 04:43:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1w4xMa-0005Ka-Ve
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 04:43:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774341827;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=i1UQZyGRL2zngaxArgi/9cfDlcapLbuGront1+ctlck=;
 b=U+qqUbQhbN/ZIC9NTQ0E67F/ls/nKUnYjGYc4A8f+oxmhiJelUqMmq52WW9qCUxXHn146K
 LAX7UtOnY6wCIPNnGS1w3Dvbt78JcfwBjRZeTiXVpAyXcuFgdLFqlb9em4Rt/2+34lFOGd
 pxbcAhzNXGaxcmsyYBZPC+HpyN6Z27k=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-504-D24lUGEMPcKBvOIoEBkjFg-1; Tue, 24 Mar 2026 04:43:45 -0400
X-MC-Unique: D24lUGEMPcKBvOIoEBkjFg-1
X-Mimecast-MFC-AGG-ID: D24lUGEMPcKBvOIoEBkjFg_1774341825
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-43b42eee946so4689114f8f.1
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2026 01:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774341824; x=1774946624; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=i1UQZyGRL2zngaxArgi/9cfDlcapLbuGront1+ctlck=;
 b=FLFFaAhWDvvAKTgEhV/amDaW92paJZ9Y8Qy/AuvS65Ggb0OgRpBFhb8dOx/iOjj2jI
 7ZHICPXsrRx/nBbO/E6UFpu1bFcqXHMFX3ZQBOQI0+/QkIHozaSiPaMOGHlFbyyvWcyE
 FTWC8NhCNXTTVYWjdfhM4y5oREIoybtULsyJgfhQ7wH7fXqd8bVscA+PO+kuOW8OshAi
 I9cLwprWrzMtrOpo+Izyz2DY7r3/b2IzIHcdP82/lOVFcFKEH5kGMj5lWmez9/hleVWD
 TseEFwPFnP+HdV4BJ5qK3Vd6irGykCtc/grKdh0ClgJiAfqveK84bxPdKvdKPCsPErAR
 LP2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774341824; x=1774946624;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i1UQZyGRL2zngaxArgi/9cfDlcapLbuGront1+ctlck=;
 b=FULnsfP+BoI3miAoTTJp4Kt6Pdo4pCVW7NcFezRVwY8LI2iA9O5kLaa/1USalfp/tg
 c8B63DV8RfDf2nyrJMzN6NSkIAN7NjE6L8VFnDdrA/1S/75fcKoIONe8T0vmAgCPMmEd
 nR/X+9uWueGCCNpAfYCWdGAJp9QPFmG6E41idzWVe4OukYgvpIFd0b4IMt4s8lA2Cl4f
 zzW/UXOTv0WuVGYd04kMEA9KTQpwuwEtIB0MB9+eO0uHcFDmg6dovnCFwk53wC26IzIf
 hLqU6p0CHMXdODl+cgbCoGEbwygePcgMDRkCttYojz2fjhivyt+eezmriC9IxxU8EdMw
 fV1A==
X-Gm-Message-State: AOJu0Yydl0P0MasU5yRKpv0nwsrRQRx60vsbLgc5qpCJrMJImjSowFfr
 ujiJeWKHR/KuDMt/sK5GWVl3ua875O2DaIvNhCVxbyKB6jDdvw5Szwd0OsXkf3mwfRNvFxqWJk7
 gIGANKvAlvvJCZFWXFtA58tXCeKp+2ovDHMfg6Edjgut4K99t8DyNWDNqpgrPC1OP
X-Gm-Gg: ATEYQzxBz/Ud7V9/7l2kD2GjPLgPI4Bjx4FSwLPR7a+77tALUt45/1h7ldPewN8CJaU
 PgKSh3qIMZioQuZtrFNoc7kbjdUgHLjNh6WI/sopj6bj44XfFwf+TR0GEkgFjpVuDAyWJbsU4tQ
 WaKE8+M9lKTCbKlAKPb7/uH0si9WWUcQ3Ih5fO3QABftvU9cYPvO+KT+Ty9DOMIx7PsIR4zh6zU
 iNRhAJPdjS9MrNm+jhdxwZxPCy0mLZnAUE4KKoFcHBBfMQZGPfYfrE2CAMv8UfOyrwaDXKVA2F6
 zvvvT5MuFsyH2Zz6B7IvAov+F6FRUKzz/kcAwIpigcMPeuil0EzEMSi8KqU8z+Y3XLS8aYvtwa5
 atdodMvuUqhjCGueBdtImERmVDAElWTrDhbduAv7nHCa7XPJLpygT5NF/kdR7/lq2iJYiBK9Sm9
 RXHqki
X-Received: by 2002:a05:600c:4f0b:b0:46e:59bd:f7e2 with SMTP id
 5b1f17b1804b1-4870f202653mr30304075e9.11.1774341824188; 
 Tue, 24 Mar 2026 01:43:44 -0700 (PDT)
X-Received: by 2002:a05:600c:4f0b:b0:46e:59bd:f7e2 with SMTP id
 5b1f17b1804b1-4870f202653mr30303705e9.11.1774341823746; 
 Tue, 24 Mar 2026 01:43:43 -0700 (PDT)
Received: from localhost
 (p200300cfd737d03cdf99cbc9b4448cfa.dip0.t-ipconnect.de.
 [2003:cf:d737:d03c:df99:cbc9:b444:8cfa])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48711702191sm33366955e9.5.2026.03.24.01.43.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2026 01:43:43 -0700 (PDT)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Julia Suvorova <jusual@redhat.com>,
 Aarushi Mehta <mehta.aaru20@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH for-11.0 v2 0/3] linux-aio/io-uring: Resubmit tails of short
 requests
Date: Tue, 24 Mar 2026 09:43:33 +0100
Message-ID: <20260324084338.37453-1-hreitz@redhat.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Hi,

v1 is here:

https://lists.nongnu.org/archive/html/qemu-block/2026-03/msg00307.html

Short reads and writes can happen.  One way to reproduce them is via
FUSE export, if you force it to limit the request length in the
read/write path (patch in the commit messages of patches 2 and 3), but
specifically short writes apparently can also happen with NFS.

For the file-posix block driver, aio=threads already takes care of them.
aio=native does not, at all, and aio=io_uring only handles short reads,
but not writes.  This series has both aio=native and aio=io_uring handle
both short reads and writes.  zone-append is not touched, as I don’t
believe resubmitting the tail (if a short append can even happen) is
safe.

v2:
- Patch 1 (kept R-b):
  - Put all 32-bit fields together
  - Removed unnecessary parentheses
- Patch 2 (kept R-b):
  - make qemu_iovec_destroy() call contingent on qiov.iov being non-NULL
  - include total_done in offset in laio_do_submit()
- Patch 3 (kept R-b):
  - make qemu_iovec_destroy() call contingent on qiov.iov being non-NULL
  - include total_done in offset in luring_prep_sqe()

git-backport-diff against v1:

Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream patch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences, respectively

001/3:[0007] [FC] 'linux-aio: Put all parameters into qemu_laiocb'
002/3:[0017] [FC] 'linux-aio: Resubmit tails of short reads/writes'
003/3:[0023] [FC] 'io-uring: Resubmit tails of short writes'

Hanna Czenczek (3):
  linux-aio: Put all parameters into qemu_laiocb
  linux-aio: Resubmit tails of short reads/writes
  io-uring: Resubmit tails of short writes

 block/io_uring.c   | 82 +++++++++++++++++++++++-------------------
 block/linux-aio.c  | 88 +++++++++++++++++++++++++++++++++++++---------
 block/trace-events |  2 +-
 3 files changed, 117 insertions(+), 55 deletions(-)

-- 
2.53.0


