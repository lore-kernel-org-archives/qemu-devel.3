Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65D52C624A4
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 13:52:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x12Qx-00049p-Ru; Mon, 31 Aug 2026 09:52:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1x12Qw-00049L-O6
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 09:52:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1x12Qu-0003vX-TG
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 09:52:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788184339;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=NHlXEJdd81HJkcAo6wpL5JghZB+1aFl1Z2KSzwFCTSc=;
 b=TLRNAJBsM93xh5dj0jfCJloJDW7B7c3ymsSnKlp+oFN6Sgc5QDgDNQ6AQhKJbam0p5oUKs
 U2aMQq2Jx5jFAO4qURd4rvF+16hmu5YRdS7aGKf0uRJDvSEhe0ar+YuCaIkjwpi1rJUhEU
 069/uuH67EvPyoxHZuB3iUCeeLrDEjY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-UzqWv90VPl-pXK6rmBYVwg-1; Mon, 31 Aug 2026 09:52:18 -0400
X-MC-Unique: UzqWv90VPl-pXK6rmBYVwg-1
X-Mimecast-MFC-AGG-ID: UzqWv90VPl-pXK6rmBYVwg_1788184337
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4994aebe932so34930075e9.3
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 06:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788184337; x=1788789137; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=NHlXEJdd81HJkcAo6wpL5JghZB+1aFl1Z2KSzwFCTSc=;
 b=n0abQCGdSw9eknnbFytq2BZ1fCY+/eKVBEs2RPApZvO+f9lnVev4FH5VstLVYOk5pD
 vKvU6RAz8eWPW4FUhr5HwaRaLAp5IxJ41q2a6bIHf4X4glyIYpmbR+375HG+OUojj1Si
 /XoNLCetl00uxTerywWcIYOyZe7JcjBU42DySpMvPeD9nmIpscM3NeQ7MEcsIIPxqwEo
 J+jyY/rOfAtip0q54WX6o6zUqhNS2lquk4Ykzdc7p+rd7OohEGP5pIXithzUsI6/RqPo
 6O2TZiNJJABBAfFWDWdZp2czRdpD19SgotRD/yzCVH44Gl+Pm8p2IPsNXlnlrcqTN4yT
 Wl0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788184337; x=1788789137;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=NHlXEJdd81HJkcAo6wpL5JghZB+1aFl1Z2KSzwFCTSc=;
 b=nGs1EC3JSS3wc4ML5iowfrYnZRnj/+IutvEFWaAPuqnERZp+M20L2j+ZcSCk5SO3Ac
 8mR3vwZRHNDoZwrci9MAW39GF3ZX9I+xkJI+w0NIkMYxYYgnn2DoTZk+yA3eSeUOIXNv
 pr4bi5ZSBcILwxgDC5yFkO2lDDeGcEkR9b15ayb/FdSyBoHO2DanJH8Oy0RFk8zihV2X
 r3x6K+ADU2onR8pisEAPfPzyatN1mj/+ckjSkry3XkDNMUwaGyod+BdYH+YNeX9vaIHm
 lEUgnFXh8WHihjfa1xMv9t88FiBatPkAlKL5WMpXbRpEN7Va6bq5ZHQIVfx4XPqlhTQ8
 QvXA==
X-Gm-Message-State: AFuF++lZrVzm9CniCRo4TMHNqcrC6+HDO9mcGLPzCNZ135+148bwlE1s
 TPH8lt+SiZHL8Z3Uw1061LUE6/UaKofY7s+ooKS0xuzkf2GxR/K4aCZdju6FUowlQJahTDQJqwL
 DeRnIzlZUZyVEfcN7TGrms5yh9n7jM7Nt6b/ve/z9i3TdM6owUejhBdpb
X-Gm-Gg: AR+sD12MfIQ8GO3c6ZrJkhedupWEtJpRLtFs8TfKGgqTlNyKCqXtafWvnxoIi5UbtTS
 oXcUvN21oKgzKWEYIprOstQei0amSy3EsQD2pgXKSVy73JGmaqh6azZ2zc3KZo7t6E+g2RVdS/W
 jPUPDeLQ9Y51VmU+YIXwuPZK8MmhojK7ywCVNKTL6/nM/uCJAMbjq5YHhPNoAjITwoKRqQBFoc3
 24s3ceed5CRggCtFlca4pC7W7IavX0jjysj4+y6AxdN4svnDb9S4I19I8N0FSmhElGKGVzDUZR6
 so3We+ORX1Mj9aoME1lOMh4KDzMxq8BOP4rXC6B5G9bdUf/Gp6VAAMpjxOShIv/Od4Ri3yFJACR
 2YdNVrMrL9aKkLJtuyH8/ABZ4JAbsFNptAbUs1zXPijtOV9jKCREvNL1ROtY=
X-Received: by 2002:a05:600c:8011:b0:496:bbce:fc with SMTP id
 5b1f17b1804b1-49cdc5660bamr13786195e9.12.1788184337134; 
 Mon, 31 Aug 2026 06:52:17 -0700 (PDT)
X-Received: by 2002:a05:600c:8011:b0:496:bbce:fc with SMTP id
 5b1f17b1804b1-49cdc5660bamr13785375e9.12.1788184336755; 
 Mon, 31 Aug 2026 06:52:16 -0700 (PDT)
Received: from localhost
 (p200300cfd72080187472d8ceb75e67b1.dip0.t-ipconnect.de.
 [2003:cf:d720:8018:7472:d8ce:b75e:67b1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cd2922ebdsm168317295e9.3.2026.08.31.06.52.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 06:52:15 -0700 (PDT)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 "Denis V . Lunev" <den@openvz.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH 0/9] block: BLOCK_IO_DELAY event
Date: Mon, 31 Aug 2026 15:51:56 +0200
Message-ID: <20260831135206.126184-1-hreitz@redhat.com>
X-Mailer: git-send-email 2.55.0
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Based-on: <20260724152315.234183-1-hreitz@redhat.com>
          [PATCH 0/6] hw/[block]: Fix missing accounting
          Fri, 24 Jul 2026 17:23:09 +0200

Hi,

I’m told there are installations where storage is very slow, and some
would like the VM stack to report this proactively.  To do so, we should
(via QAPI events) report on extremely slow I/O requests.

We already have the latency histogram, but this is not deemed sufficient
because it is not proactively reporting and would require repeated
querying.  Therefore, this series introduces the event still.

Now, from a user's perspective, it would be nice if this event could be
raised exactly when an I/O request crosses the user-defined threshold,
but this would require keeping all active requests in a list and
checking it periodically.  Now, if we used latency cookies for this
(which makes sense), then that would require that every cookie set up is
also finalized when the request is done, because if we don't, results
could well be catastrophic:
- Either we use cookies as-is, which are often allocated on the stack or
  in some other structure managed by the device; then this would result
  in use-after-free,
- Or we allocate something specifically for this checking, so lingering
  requests would at most create spurious latency events and memory
  leaks, but this would require an additional heap allocation per
  request that we would probably want to avoid.

So ideally we could use latency cookies and could statically verify that
they are always finalized when the request is done, but doing this in C
may well be impossible.


So, because it is basically impossible (or at least it would be very
hard, and presumably require a large refactoring) to guarantee, without
additional heap allocations, that a list of active requests won’t run
into catastrophic use-after-frees, this series does the much simpler
version first, which is to just raise an event when a request *finishes*
and took more than a user-defined latency threshold.


(PS: The nice thing about throwing an alert while the request is still
going on would be that it could allow us to also stop the VM in case of
excessive latency, before the request completes, so the guest would be
shielded from such excessive latency.  This might be useful for Windows
guests that just have a maximum request lantency before throwing a
BSOD.)


Hanna Czenczek (9):
  block/accounting: Add offset to BlockAcctCookie
  qapi/block: Add IoAccountingOperation enum
  qapi/block: Add BLOCK_IO_DELAY event
  block-backend: Public blk_get_attached_dev_path()
  block/accounting: Add BB field to latency checker
  block/accounting: Emit BLOCK_IO_DELAY event
  block: Add delay-alert-ms property
  block/accounting: Move latency_ns override down
  iotests: Add delay-alert test

 qapi/block.json                          |  52 +++++++++
 include/block/accounting.h               |  20 +++-
 include/hw/block/block.h                 |   5 +-
 include/system/block-backend-io.h        |   9 ++
 include/system/dma.h                     |   2 +-
 block/accounting.c                       |  60 ++++++++--
 block/block-backend.c                    |   8 +-
 blockdev.c                               |  16 ++-
 hw/block/block.c                         |   4 +-
 hw/block/dataplane/xen-block.c           |   4 +-
 hw/block/virtio-blk.c                    |  15 +--
 hw/ide/ahci.c                            |   6 +-
 hw/ide/atapi.c                           |   9 +-
 hw/ide/core.c                            |   9 +-
 hw/ide/macio.c                           |  15 ++-
 hw/nvme/ctrl.c                           |  43 ++++---
 hw/nvme/dif.c                            |   8 +-
 hw/scsi/scsi-disk.c                      |  28 +++--
 qemu-io-cmds.c                           |  14 +--
 system/dma-helpers.c                     |   4 +-
 tests/unit/test-block-accounting.c       |   2 +-
 tests/qemu-iotests/172.out               |  38 +++++++
 tests/qemu-iotests/tests/delay-alert     | 136 +++++++++++++++++++++++
 tests/qemu-iotests/tests/delay-alert.out |  46 ++++++++
 24 files changed, 472 insertions(+), 81 deletions(-)
 create mode 100755 tests/qemu-iotests/tests/delay-alert
 create mode 100644 tests/qemu-iotests/tests/delay-alert.out

-- 
2.55.0


