Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8FD4C531C9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 15:25:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnHlQ-0004O9-DC; Fri, 24 Jul 2026 11:24:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1wnHlO-0004Md-EH
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 11:24:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1wnHlL-0008Qs-Vf
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 11:24:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784906675;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=5NXNnsIG2gq52rsrrp0dcRBeVvuimPFx5J1kr5wIzwI=;
 b=ASy9PdAdOSyHjy3tJZM7oldbUz/lMDlO779hbVAsJtDOW6qBsqdlW4ODLZdNnx3P/5xQwG
 nh7gl+nS658pk00I1EMLaZYk6QGcn7yjbEDNByq4kx67c6Yf4PAOYqcIqVFv64l0i98UYr
 8gfY5BrYM355BNhOZAVzGgSZSofwrcI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-208-rVM--h8JOBWqaZXKqXtfDQ-1; Fri, 24 Jul 2026 11:23:22 -0400
X-MC-Unique: rVM--h8JOBWqaZXKqXtfDQ-1
X-Mimecast-MFC-AGG-ID: rVM--h8JOBWqaZXKqXtfDQ_1784906602
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-49560dddaa4so3711015e9.3
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 08:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784906602; x=1785511402; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=5NXNnsIG2gq52rsrrp0dcRBeVvuimPFx5J1kr5wIzwI=;
 b=Wu+r1DHeTFwy+MIRZnEGve5NyyVlKjJEzpGq0uZrWaCx3EOa9Xsds0qBkRNujNWOqb
 V6hN9yxeWqWttNIK68FrhfApa6OlDl5x3dez18D1qCudbpH3gW3E/CHwdm83F0HAmWy2
 U9Bdb/IGc+ObhzmaGIk1zDLIEVmFb2FvFXpiPLb9EZOh/Eey++vNdfSUF90g7Zc/7/cz
 xL36JeQLflSuz2sg07Z8gKokebUelqxLCgmbVubDtVBMSafjQNdsZ/Rg7femQUhN5xRv
 RPI9LCVTXlXKb7pKVaoo6A5uXc4goH0+yChOktYiTE7BufdTZptCdpjDqdGpALfWFv8x
 ThCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784906602; x=1785511402;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5NXNnsIG2gq52rsrrp0dcRBeVvuimPFx5J1kr5wIzwI=;
 b=Zwse4yqNE3Q7R9O/nJzP0uUOhyyElnpkZqIT1htat+eMfBe0O6TZHeZqAUeV/swvYi
 GYSaUCGjM20dzTr0W0TELw2lbbkZaTJvqFzxO1DyWTtkrXWmC8CLTxDoim/ApgJ1M8Rm
 R7Rty0iAuHO3oO30ByOiq18NGCE1ycWVq2MJ53TdiNcSE3MsJcET1cI/1/rWIL+wCvkb
 H+QRgWw+W6QD0R2+WzS4UDQ6xapD/kXfCwp/rfkfvPNQzV4dggt3K3iI5qiMyn9qal7f
 QNimncDcA6RCN7Az9wVURWSqORJuNuzXP8qERHa0FeYwBAQobDkTPxuku9Q0iolAcHzL
 +7hg==
X-Gm-Message-State: AOJu0Yw5h3xo4zQV4V5OauODKXL8ig2rtVU7JE/CwjZhB0L3QTlq39uJ
 h5El5nqV4lGCPCCn5nRzwspUvODGpWmiCjycfywY1yvNDiEHAm8tDDq6cq0d6KTEebtGLUaLrNA
 RvbsAV2L9YSZaVm33knAJ8syq5hcMIfxZy4XTfxph9krii400HLovq3JB
X-Gm-Gg: AR+sD13gAvlwCTF6NQmPp0ctE4TONu7/gZvWFtAkyueUFwGRlvPACZOHcxxqaL3JU2s
 Z8X/zoiA2cO9MUmkUp9wI7giOTwYlF8pWFpyxds5tLoswmNDq1B1rjbhTeNDkrbWw7nLYjRlp2T
 FumcuRoSsc0qVfryLcdDvkecexjfR/16DnKndzTHYIuDptN3dshlQmuCZRCs+PL1ubgSce4fXJn
 0eHPYigSb46dhYuGalPGIM0ppmQgD9uxtF2zCz7NOjnAYItE0JOGmS3MDnKEOklgEbRCDdnjaDk
 gO7TslELCA+/knEEWAjN8C6Wc71rhC21vcJx+QiwWP/HDPxhN2vXfVxDHqN3nYVKKXmiF1aoD0A
 WH5KOAe0NWvSljKGqxG44IuN9O/hqHKlEBCfG7dWn3u7jgtby/W4tx+QDyZs=
X-Received: by 2002:a05:600c:1393:b0:495:6a50:3fb8 with SMTP id
 5b1f17b1804b1-49573c8c2b2mr84926015e9.1.1784906601718; 
 Fri, 24 Jul 2026 08:23:21 -0700 (PDT)
X-Received: by 2002:a05:600c:1393:b0:495:6a50:3fb8 with SMTP id
 5b1f17b1804b1-49573c8c2b2mr84925405e9.1.1784906601259; 
 Fri, 24 Jul 2026 08:23:21 -0700 (PDT)
Received: from localhost
 (p200300cfd7075d8bc03b74903e90fa9c.dip0.t-ipconnect.de.
 [2003:cf:d707:5d8b:c03b:7490:3e90:fa9c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4957bd9e980sm52493255e9.0.2026.07.24.08.23.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 08:23:19 -0700 (PDT)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>,
 John Snow <jsnow@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>
Subject: [PATCH 0/6] hw/[block]: Fix missing accounting
Date: Fri, 24 Jul 2026 17:23:09 +0200
Message-ID: <20260724152315.234183-1-hreitz@redhat.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.419,
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

Hi,

There are some places where block accounting should be happening, but is
not; either because the whole operation is not accounted (like discard
operations in virtio-blk) or because certain code paths forget to
finalize existing cookies.


Hanna Czenczek (6):
  hw/virtio-blk: Account discard operations
  hw/virtio-blk: Complete zone-append cookies
  hw/nvme: Fix block accounting in nvme_copy()
  hw/nvme: Fix block accounting for compare
  hw/ide: Have ide_dma_cb() complete accounting
  hw/scsi-disk: Fix accounting for IGNORE, ret > 0

 hw/block/virtio-blk.c | 34 +++++++++++----------
 hw/ide/core.c         |  3 +-
 hw/nvme/ctrl.c        | 70 +++++++++++++++++++++++++++----------------
 hw/scsi/scsi-disk.c   |  7 +++++
 4 files changed, 72 insertions(+), 42 deletions(-)

-- 
2.55.0


