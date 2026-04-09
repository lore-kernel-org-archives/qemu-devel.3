Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08B46EA3C39
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 10:34:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAmhP-00019E-Hh; Thu, 09 Apr 2026 06:33:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wAmhN-00018m-Uk
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 06:33:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wAmhL-00009A-0H
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 06:33:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775730796;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=CSRcL2GRcmenejSMO+/fuEMqXOpbRRaRBtRFiP72YoQ=;
 b=f++j1zswvOdRR4DhQxgZA9KTsVFY7G+mp6IVWHhXQyrq8Yctf2hC5pd8e/yzT/rAUqXW0X
 wLh6BVdN8zEucHgSgcLAO40fNJKDuI7XDQH82nPhfWtArVsI8jJvUgU3NxR1phd5mxjR0W
 iy5lePIbEvAeyjHjfIOC9gqOKr+8WAE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-172-3sWXBWlxOYuwoZHrvwRqdw-1; Thu, 09 Apr 2026 06:33:15 -0400
X-MC-Unique: 3sWXBWlxOYuwoZHrvwRqdw-1
X-Mimecast-MFC-AGG-ID: 3sWXBWlxOYuwoZHrvwRqdw_1775730794
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-488af976487so4547755e9.1
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2026 03:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775730793; x=1776335593; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=CSRcL2GRcmenejSMO+/fuEMqXOpbRRaRBtRFiP72YoQ=;
 b=VIqxhQoMKgUlYwMSduHBfdWeVju6LLWOWHvETaSktMQYsSjJ2BkOJLVAzIVnMT2OtX
 sSrhxUtlP+tGAwFLDy5w1ILYH7Oy45WMgMnybHyTbXC/ifyaJBnbk2za4zN2pwvZByWd
 y/hHF1MZ5Pe9OdvwVWoOKUcBqk8f2D0L82dvUpKb0AwiLaxo4rqcI7ulWgSSMH3JbMIz
 VYSrh6rOk29Bd67PiyimsVZaV1yRHPvtcfFj2WIp4PZR1nq1Yi65ldSsptJG5eJeVuic
 F+gxsmg+meUoi5fq2Lr/r5iASTkmbhiKaxEFQysYbf33gAhlHSNPRlYz+zhYLEJZWaac
 2BMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775730793; x=1776335593;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CSRcL2GRcmenejSMO+/fuEMqXOpbRRaRBtRFiP72YoQ=;
 b=kb2jREra/8wtMbxrQTZrTwawvRoVM6nRghBmYnWW6eLKKBN7xb6i2WbMsKpKQ+LaLp
 Ou7I9wgVxwI/BRqlRweI4dQp9N0McaT+LQRRpV8wUf33o6Onhw4T/XytIwlAQ+XILmh9
 QbFemvnUqWsQY0p3NiZqeptqpgMra6zetM1KeWcW1XzR0LhwvZNyb4nEM4LhQq0TD+jF
 5FS83c4exiU/7REZkxSuiocMpb9+ptctYg85gTlmN1aO7007iCXYwbyHO6QybYcmtV7g
 B5m/hL9OHjWSqR1hr+BNpDpjVO9qD2kHMqkRbeVnvoyK5LtKJZXRXDA1p5a5qd7sHbOs
 hMdA==
X-Gm-Message-State: AOJu0YzUT49O6gJg4igaPYxD2Uib/Q634IbfzUAMsHDJMRA+W8e8Idfs
 8xas30aney9QgvRuULOg3SanTJGjyfbrTJ9Q7dw+gliZ1v3CDlglx7A6BH8yRETSF5Zpxojz1iZ
 y+qhpaTfc/hUeCPug6hBQcvjhsdojNoZy+wSgZCtAEV7hDUb/0X48CpRECMpunsDYk7MD0MtgVw
 nf3UVmtZak+LqqSYpP95KBL+RGCQxMRGEIv0DoBquD
X-Gm-Gg: AeBDiesVW93qiBJCvaFI+G0UoxJQI9+7cELDswhlAVbQlf7LT0zszf4ilI0Kam7n3Xy
 0xRSAnBXsGOebRjoow7z8p6QGIQdjAamET58yNxb+w1NM1t7zJaG46cDZBb6V5pcH5Iw7fpfl9h
 RSG7bcFyZEXj87ee7zgymrWkxj5Ll5zXRDZRqeD2rFTBg6eBS8kaObI0w5recdj6Ma/S8u2glhV
 2kniQ6iMTA5AGHGk7o0RaNqYIoP7ubkF/kKsE43fEMlbIgoLbK/1ua1wVdLtA/Gy679ePPEZzDz
 HXVpbaJ0N30K68/noLjuhAHGj9IrWQRxApk9esJRTkLx5RpzjMDpxY8OIXGbS8WfM+kOGFfFJL1
 Yo/va2L6h3qmZ5BLhBEabhM3lCX1Wx6AmVMF/om3fxJ4lVyTKnDhTclJBnPNdX2QAgQXopZqr3k
 P1bDNymZOjcdwE49AeYAaX3gCD
X-Received: by 2002:a05:600c:6085:b0:488:b239:77ec with SMTP id
 5b1f17b1804b1-488b2397962mr195771785e9.17.1775730793141; 
 Thu, 09 Apr 2026 03:33:13 -0700 (PDT)
X-Received: by 2002:a05:600c:6085:b0:488:b239:77ec with SMTP id
 5b1f17b1804b1-488b2397962mr195770495e9.17.1775730791299; 
 Thu, 09 Apr 2026 03:33:11 -0700 (PDT)
Received: from [192.168.122.1] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d5e969be7sm3292604f8f.6.2026.04.09.03.33.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2026 03:33:10 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/1] virtio-scsi patch for QEMU 1.10-rc3
Date: Thu,  9 Apr 2026 12:33:08 +0200
Message-ID: <20260409103310.1884968-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

The following changes since commit b6a7d06213e5d2f7d124d16418bc289c4a8a4b82:

  Update version for v11.0.0-rc2 release (2026-04-01 20:48:02 +0100)

are available in the Git repository at:

  https://gitlab.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to 6c0f11de6118a870e6dd5e1928586885e4363ae7:

  virtio-scsi: pass the same cdb_size to virtio_scsi_pop_req and virtio_scsi_handle_cmd_req_prepare (2026-04-09 12:29:49 +0200)

----------------------------------------------------------------
* virtio-scsi: fix cdb_size issue

----------------------------------------------------------------
Paolo Bonzini (1):
      virtio-scsi: pass the same cdb_size to virtio_scsi_pop_req and virtio_scsi_handle_cmd_req_prepare

 hw/scsi/virtio-scsi.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)
-- 
2.53.0


