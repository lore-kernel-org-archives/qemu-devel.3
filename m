Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C92EEC5AD5A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 12:15:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu7rU-0001eS-B2; Wed, 12 Aug 2026 08:15:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wu7rR-0001XI-JH
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 08:15:10 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wu7rN-000875-SG
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 08:15:08 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-4799b3f7c83so563850f8f.2
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 05:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1786536904; x=1787141704; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=h7xQgor42wkBCk7DgAcS6lg/t2CfiwWNdKSYURIqh5w=;
 b=Yn8+VNU17UNd862D8ufNbCeqlQaTWdADtGDrqeP30kTVlo4cIpxK5sJV5hKrv8JsK3
 CeYwUi+Ew7B+LeziTW6TlZoal/WSwEvvA2Z/nXpKNF1p4GCiVWYHeW01qJH2tOa+Kh2t
 UIy3drboDbeSVwhj2JYF1ao9jAz6aovCPsfU4jk9hwkqW8RlYbUpJ2VPDeAKHdT+p7Ya
 EobTN64hPYSa+y2okpPwqrcZBeGbNXuTxWHipbOQqSwoB2MWV5IWeDLhoqHedfVVX5si
 sZqFIt5Za5SfuVOrdafNycU8hQxnuwuRW5nY6ZikF2oW59tFf61TB/+Bq9CjYoAg4Ve2
 QqAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786536904; x=1787141704;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=h7xQgor42wkBCk7DgAcS6lg/t2CfiwWNdKSYURIqh5w=;
 b=JaPkBPSBdpS01Im/0ehqXrBumKNaYaeZb7UlvYHTZMY5K5Xn6CYy/YUyd/GFl1DYws
 Abc9zazy1hJbkpY/sQu0agqWgNaqPd8QSLwzRLyPgslkq7vqzv5dgjj/g3eKgwhT36yc
 /OEKgdeElemODV9IbzaDYQr9mFkFhG/hmR+Loa/63cBjhVtJADbla/atvHo9OVDJhlIL
 dZhMe69UtNkXdGcgIUqW5iAYaoSHRiXDwHcwpDL2d7TBHA+IFRLjSbMnsp/oqsWadHiX
 iZbXpq5ZWp23arLZtad6kfN9EIwsPjW4wf1UEt5vQZk1QXgObqndbSjZqsNVkhXGqoRL
 HFXA==
X-Gm-Message-State: AOJu0YxSjlZdpCM3Fz9Dn7mi7NlO6k6pUn2x07QsjepMjLO8WD2pJ35p
 FVOuCaif97uZu6ziuWA6vg0cij85Mvx8w83jUFzsbFsJiNArDeIPVvfqhLWfy1CUiwteLUezTDU
 AJFUO
X-Gm-Gg: AR+sD13mIOfS3jxFEeNdcW/AWRbWLxdaVRSelswa+6c5MuwELJ3owm8dg+iEMWDIgIG
 b2lcRZdtJ2wAVh3fp8RNtSyKuJv0Blt8a4nGUJUuy4yIrT1DITCd/DtVFxiK3/qS79TIXjYuC4y
 hQbHIGYEZMCd32D5fcblN8GOo36IhycOT/1oFKqTFjRm3grlcgaaPaVlCeE4QXq2I+h+ic6g6cs
 UskGb2cVZBUzAUyfCOIlb2tUNaNr7K7FUkjzc3rLK5/AsGnv8TjdbhRFzae6YVrh/Pgki/GTXHY
 x+pathK9CE4S+1CSEFaR3uHX5IrGywIJcuYPJiVzBeutUpTgHBdeXFroxpbgxQxpSGhvJBfrx1H
 ILs7z160cmQjoEei+aTGDS3CKkBhDNE64L9hj4lrr4BDPf5vgCy3j4hTA83KAebbiHbKxoyX1G+
 e7uXGiF8NpFMpYOBiytfAdn65hAqYRCxZCpv/utW/Fk4I5LQPr13bWG3qXiw==
X-Received: by 2002:a05:600c:6a84:b0:499:52dd:c1f0 with SMTP id
 5b1f17b1804b1-4997c0f0529mr42520275e9.1.1786536903645; 
 Wed, 12 Aug 2026 05:15:03 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:89f2:ad10:d9bb:681e])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4997ad267c2sm49069945e9.0.2026.08.12.05.15.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 05:15:03 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>
Subject: [PATCH 0/4] block,
 scsi-disk: honour a size change on child replacement
Date: Wed, 12 Aug 2026 14:14:56 +0200
Message-ID: <20260812121500.1034178-1-den@openvz.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=den@openvz.org; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

qom-set of the 'drive' property is allowed on a realized device and ends
up in bdrv_replace_child_bs(), which swaps the node a BdrvChild points to
without telling the parent anything about it. Every other way the size of
a node changes goes through bdrv_co_truncate(), which does notify, so a
device model caching the size of its child has no way to learn that it
changed.

scsi-disk is the one really hurt by this. check_lba_range() validates
every guest request against SCSIDevice.max_lba, filled in by
scsi_disk_reset() and updated only by the READ CAPACITY(10) and (16)
handlers. Point a scsi-hd at a larger node and every request past the end
of the old one is refused with ILLEGAL REQUEST / LOGICAL BLOCK ADDRESS
OUT OF RANGE for the whole life of the device, which Linux turns into
EREMOTEIO for reads as well as writes. It is silent on the host:
out-of-range requests are answered by scsi_check_condition() and never
reach scsi_handle_rw_error(), so there is no BLOCK_IO_ERROR event and
io-status stays 'ok'. virtio-blk and ide call blk_get_geometry() for
every request, so they end up with a stale idea of the size but never
refuse I/O the node underneath can serve.

Signed-off-by: Denis V. Lunev <den@openvz.org>
Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Hanna Reitz <hreitz@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Fam Zheng <fam@euphon.net>

Denis V. Lunev (4):
  block: notify the parent when a replaced child has a different size
  scsi-disk: refresh the cached capacity from the resize callback
  tests/qtest/virtio-scsi: cover a replacement that changes the size
  tests/qemu-iotests/qom-set-drive: replace with a differently sized
    node

 block.c                                    | 13 +++++
 hw/scsi/scsi-disk.c                        | 16 ++++--
 include/block/block_int-io.h               |  3 ++
 tests/qemu-iotests/tests/qom-set-drive     | 14 +++--
 tests/qemu-iotests/tests/qom-set-drive.out |  2 +
 tests/qtest/virtio-scsi-test.c             | 63 ++++++++++++++++++++++
 6 files changed, 104 insertions(+), 7 deletions(-)


base-commit: 3e3ccab106f879b1512f8e0d51a827dd4de30e22
-- 
2.53.0


