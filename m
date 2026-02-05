Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AB3BE9129A
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 14:48:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo0eJ-0007jr-RF; Thu, 05 Feb 2026 09:48:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vo0eF-0007j2-7O
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 09:47:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vo0eD-0004Ac-8L
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 09:47:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770302874;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Fu5f1o6wjPypJD+lh+/BJ100QRzUucDZZqzgUI+QAjE=;
 b=XoCbCHaEmmo3QAYdXhMcOD2wpyyV2RbycPAUO5s81hNxLlINw4nyk4c94ComAMkC+M0Jco
 FIckj/ewEfyaDcbDzb0DPVSyYVLZ/Fpgi2YofDcYNMQv6YXFm7EQmcR6HVSdsoyaE7psKL
 u6ukptFIzgJ/tC958qiI73hQzajMDHM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-507-6lCt50iGP_eXsHXJ_Jh62g-1; Thu, 05 Feb 2026 09:47:52 -0500
X-MC-Unique: 6lCt50iGP_eXsHXJ_Jh62g-1
X-Mimecast-MFC-AGG-ID: 6lCt50iGP_eXsHXJ_Jh62g_1770302872
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-480686b3b4cso15419025e9.0
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 06:47:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770302872; x=1770907672; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Fu5f1o6wjPypJD+lh+/BJ100QRzUucDZZqzgUI+QAjE=;
 b=TKFQ5LyNyDtp7otAsrL8mZXIxToQonkqZQpfa3RPXFufFhT14VNbZxC7Zoqv+0OUEV
 cBd6WyBOvyPYtGf/98idYyJAt/wbGIEOQ9vMA6FzPINq3O8zxN5S25+nrA3UnAI/zt63
 vCUQwHiuL4KW6p+A+I/WKPeaqUyrWQLexBFoqIcklUj6RH4KD0f7t8YF7ziYF5ZsmaLg
 HEEVEBjcJNnFGesOO4BZiGKT3WwKtPiwE9DAfMO6jBzzoCt2ELoWhj39zQt+yDq8vsNV
 rkYpsMrfLz4E1Vn/1RJB04c8wXmQnfHxm3Ki52dDk40RG8ATQPswtKCpz+Cw+sqtK4UH
 Vaew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770302872; x=1770907672;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fu5f1o6wjPypJD+lh+/BJ100QRzUucDZZqzgUI+QAjE=;
 b=QG6TbFsQf2vV1Pg43t+1p0O832qTV9Biz3SshMIi4DBg/kXWQaiqJXqaGYI1WXYOBr
 wLHecEgyF/fgJEXTtBJuwxNZQ7EpuvLFVjXhmK6Pifadtbeupy5qdSSu1KGPODnKxnkO
 X36t5pDd7Mr6mdqYRo0NLCmblDlOvOs8WtzugnL/pXtrvx9WDufg2MvaNkBDVUDRimk3
 iSXWR7kZuhDd8CMnL6X90ZgpD2fKhin8ud8G1yFtmBqxJEEIXsSK/ET0xp6UPaTK1SH5
 h+1SRj2U35nOJUo+mXhmnJzwZkeMX9pM4o4249JBNNAAKiLcQcxD/pG71kDEgoHcSk2E
 s/Sw==
X-Gm-Message-State: AOJu0YxHj/M2LCyFjy5XnSUeKNKL45/3YrbYhTfs0tznD/o66slKQ2NG
 p/he0npd6m4ZRhr9VJgOHEVoRltLZmNUW6uI5lOvnWv0S2gexPKOO9ELm3jtl/TTC0X1S/FR1Da
 fW6scaR/q/La4NFfWG+0DyHpBNPcmvpwN0YIJLrEXKoBh6ZI+Oqg4OvdE
X-Gm-Gg: AZuq6aITWSailJBhEY6jCEOr4nKCx+xgaqogCSoB9HDkeF9DfJ48Bof80cH9kxsDZQa
 Xslfpl0XHG2fyDbNrVBex+FZmxMopeGUk+PvVSEAYMGayaWSyt11SDJy38MlwiF6m9HF6XNCmVJ
 tZaXSIjgn1r/xqTiO6JfK7wNIBECEY6UO8UrQahK+PPYieHrYs7I+JaDlZO8ek33GytQ/Ra0edT
 QgdmEhvYlDzLvxe/XyZPaahz88ARhBgvi6p3oviFZMbAOKwSi1+eN+jDrBldWRh7hsqGMKllzbo
 9WAwRTaabLHOHhdZxpXk2w5Lc6bhYE/4zRWnktdszofwa94DENGPTHx9WtWFvwyQ38faaHs/MGa
 T7Y8ibXnRBtXxt7jGwUSMT1eUjj0Qf3wDJn+qEs1bsHb4gBXk+gKgJ21aAekABZRc/SoR
X-Received: by 2002:a05:600c:3145:b0:480:19ed:7efa with SMTP id
 5b1f17b1804b1-4830e97af61mr83873445e9.36.1770302871637; 
 Thu, 05 Feb 2026 06:47:51 -0800 (PST)
X-Received: by 2002:a05:600c:3145:b0:480:19ed:7efa with SMTP id
 5b1f17b1804b1-4830e97af61mr83873145e9.36.1770302871066; 
 Thu, 05 Feb 2026 06:47:51 -0800 (PST)
Received: from localhost
 (p200300cfd737d06375fda007e5d3c5c8.dip0.t-ipconnect.de.
 [2003:cf:d737:d063:75fd:a007:e5d3:c5c8])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48317d4d030sm90763505e9.13.2026.02.05.06.47.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 06:47:50 -0800 (PST)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Subject: [PATCH 0/5] qcow2: Suppress data-file WRITE during creation
Date: Thu,  5 Feb 2026 15:47:30 +0100
Message-ID: <20260205144737.31131-1-hreitz@redhat.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

Some people want to create a qcow2 image for an existing raw image while
that raw image is in use by a VM.  That is, the raw image is attached to
a guest device, and the new qcow2 image is supposed to use it as its raw
external data file.

(See https://issues.redhat.com/browse/RHEL-128573 -- specifically, the
idea is to allow incremental backups on a previously raw image.)

One reason why that currently does not work is that formatting the qcow2
image requires write access, which will automatically result in taking
the WRITE permission on the data-file child, i.e. the raw image.  If
that image is currently in use and thus the WRITE permission is not
shared, the qcow2 image cannot be created.  However, without data
preallocation, we don't really need to write to the data file, so this
series allows qcow2 to relax that requirement to make formatting work
while the data-file child is in use.

NOTE: One exception for needing the WRITE permission without data
preallocation is when creating a qcow2 image with a guest disk size that
is not aligned to the cluster size.  Then, we will implicitly COW the
cluster tail past the end of the guest disk.  I think that is
unnecessary, so commit 3 removes it.  This will cause images whose guest
disk size is not aligned to full clusters have a partial data cluster at
the end, after creation.  I think that’s fine, but maybe not...?

---

Side note: Another reason why it's difficult to replace a raw image with
a qcow2 image using that raw image as a raw data file is because we
don't have a comprehensive QMP command to fully replace one node by
another (there is no QMP command for bdrv_replace_node()).  You can kind
of get around that via qom-set for guest devices and blockdev-reopen for
in-graph changes, but (1) there is no command for changing a block
export's node yet, (2) this is not fully transactionable, and (3) it's
cumbersome.  blockdev-replace is supposed to solve (1) and can probably
also be made transactionable later to solve (2), but maybe we still want
a simple command that just calls bdrv_replace_node() for the case where
a user just wants to fully replace one node by another.

But this series does not concern itself with that problem.


Hanna Czenczek (5):
  qcow2: Skip data-file resize if possible
  block: Introduce BDRV_O_NO_DATA_{WRITE,RESIZE}
  qcow2: Preallocation: Do not COW after disk end
  qcow2: Suppress data-file WRITE/RESIZE if possible
  iotests: Add qcow2-live-data-file test

 include/block/block-common.h                  |   11 +
 block.c                                       |   15 +
 block/qcow2.c                                 |   96 +-
 tests/qemu-iotests/125                        |   17 +-
 tests/qemu-iotests/tests/qcow2-live-data-file |  274 ++
 .../tests/qcow2-live-data-file.out            | 2904 +++++++++++++++++
 6 files changed, 3302 insertions(+), 15 deletions(-)
 create mode 100755 tests/qemu-iotests/tests/qcow2-live-data-file
 create mode 100644 tests/qemu-iotests/tests/qcow2-live-data-file.out

-- 
2.52.0


