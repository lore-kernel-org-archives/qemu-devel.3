Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C1D5E9DE60
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 08:20:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAkbm-0006N7-JP; Thu, 09 Apr 2026 04:19:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matthieu@minio.io>) id 1wAjOJ-00053v-3a
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 03:01:29 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <matthieu@minio.io>) id 1wAjOG-00076F-LS
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 03:01:26 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-43b8e8e7432so424460f8f.1
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2026 00:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=minio.io; s=minio; t=1775718074; x=1776322874; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=BQIDX/WNV5Pzl0aC//tD4ssejDFf4jBgsYoG1vBrsEc=;
 b=c6M4BomlwXWzE7NIrvduNvP7bCe4GMtXEuVLE/+ml3JV6pkVKKzDrTezWR5P+cUe5T
 IJWOuiaCJx5pCJQ2o/fPlaSoSonaDw3+Kl0cBy6QD1fGZ4gaYtMgT1A7hS1myDuyztQF
 zOCbZy81aXIiA6LQCg7xJDobGB+RzhtH958tr0tDBWY7OQjHdfnwf8x6zpD/BP60TXBV
 0uG9teVOy1UC+N1kCGc2TLEH2JrCPn8MxIITM2zX0u+m4EgtlwXrbsbk2CYB4jdyMUIa
 h/wjfQIzmSISU4zocNy0vQw3QV7Xs0PH3Fs0ic92Q00loVn49fEtlgi22HnxPuEC2fOF
 C9lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775718074; x=1776322874;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BQIDX/WNV5Pzl0aC//tD4ssejDFf4jBgsYoG1vBrsEc=;
 b=Drllbcgw3uG1R9YpqM5VGRTlw0Qg4YwdS5H/NxCUMpu9FvPvDviG26YupnutY1K7C3
 n0hPWi+tsEq5i784EMJ4Ro59Xn5Uuniv9i1RfRlbaCwbepQuMAlhyQCXGw0pZmoxsebJ
 /y6SHc57YbPhftSeIFGI8cohfWpnUnJfOmf0ApcNCoBVhVbca0jYTc47shw3ucFQntnA
 PNFNOjkOiwtybuB/z/ptvuUemx6xO/NGxcuqLqp0vQmNRj5AiBJkfyZzF11umxy9NmvB
 HVUXslAtdBBGoomIi3pARZImEbSgrgBb6ZvYOwWPS6W6a7sxJe9QVnQ4VUTcsGwLfDeu
 /HnQ==
X-Gm-Message-State: AOJu0YzxlJxcgjVsML/oTMkbHNpAeuxbBqdXFvC8Pkp9capK40BqfZcJ
 fBBfWmMoAfcLdpWkkLveIonBIsOTrZGFQyIf0zLvBzNs24GcymCvi7NizwdNuL/wCGXOiYBH5M6
 cF2rEdQ/GBObPKDEGKWFNL4FGYOpd9dCMIuJ426xqOzqohbPM+ME49qzpQOACON4r/9gi6XVubg
 JulXbayo8SF+FL3xqeDqZUG2i/TMJZeM3hXX1thFY=
X-Gm-Gg: AeBDieus+PCEmNJDR1tlR7MpOWhpZR8+S9DYPmRCe3SzQSbn4l8av0TEt2hpYO/mprn
 kCaIuac9hdNBZqFOOIPYptPBejeI5PlSrqy0JTI9/Hnrqw20tDDfgLZqhV8Ti3VylCkRurmjfy9
 J32hCGr8kpVghkVZfjO04avHaqgngZ84C5uhfbGcqhXYq1i3RvvrlZKKzHQ22p1VtD/F9/6zCUr
 xTR8x/9nDQmrV2KROlMlveo+y5WuKyp41fqFRbdWx1feOJ4pJWakdCWbimwsEJl5ibOgNGocNwP
 9kQ/lx7Hx7JRXbP0Yb5Hyd6H7zgHLX55OSgyuF/C3L8YYCLBSP+55mGUFQBivZ3UIpO9QzEtxzX
 Yc1JnR48gg6F9k2cWCNYliCMsJ81uQreSKgmzjKVa8OL6o5mC+aMUql0iKme3chfApqt5m4BgiN
 hop1DOL0e+EEXCuKv/eHVPpA8bnzeyCRCts410pBEEVDP1FZV47T6W/JnN3aeHgKMSo+C9k1C1/
 KSBdtF4vZxPeiABuE+kh4Sdyn6P4XiumRwfX383TYwy9sWpAQGvex3tVrvLYA==
X-Received: by 2002:a05:6000:1acf:b0:43d:20e9:b0e1 with SMTP id
 ffacd0b85a97d-43d29280e6dmr33088200f8f.7.1775718074190; 
 Thu, 09 Apr 2026 00:01:14 -0700 (PDT)
Received: from localhost (2a01cb00141148004df9ec80d3fa1cac.ipv6.abo.wanadoo.fr.
 [2a01:cb00:1411:4800:4df9:ec80:d3fa:1cac])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-43d1e4f1a99sm68622732f8f.32.2026.04.09.00.01.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Apr 2026 00:01:13 -0700 (PDT)
From: mr-083 <matthieu@minio.io>
X-Google-Original-From: mr-083 <matthieu@min.io>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Cc: its@irrelevant.dk, kbusch@kernel.org, stefanha@redhat.com,
 mr-083 <matthieu@min.io>
Subject: [PATCH 0/2] NVMe namespace hotplug and drive reconnection support
Date: Thu,  9 Apr 2026 09:01:09 +0200
Message-ID: <20260409070114.11313-1-matthieu@min.io>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=matthieu@minio.io; helo=mail-wr1-x435.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HK_NAME_MR_MRS=0.998,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 09 Apr 2026 04:19:20 -0400
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

This series adds two features that together enable transparent NVMe disk
hot-swap simulation in QEMU, matching the behavior of physical NVMe
drives being pulled and reinserted in the same PCIe slot.

Problem:
Currently, hot-swapping an NVMe disk in QEMU requires removing the
entire NVMe controller via device_del, which causes the Linux guest to
assign a new controller number on re-add (e.g. nvme2 becomes nvme4).
This breaks storage software that tracks drives by device name.

Solution:
Patch 1 adds hotplug support for nvme-ns devices on the NvmeBus, with
proper Asynchronous Event Notification (AEN) so the guest kernel detects
namespace changes. This allows namespace-level hot-swap without removing
the NVMe controller.

Patch 2 adds a drive_insert HMP command that reconnects a host block
device file to an existing guest device after drive_del. This is the
counterpart to drive_del for non-removable devices where
blockdev-change-medium cannot be used.

The recommended hot-swap sequence is:
  1. drive_del <drive-id>          # disconnect backing store
  2. drive_insert <device> <file>  # reconnect backing store
  3. pcie_aer_inject_error <port> SDN  # trigger controller reset

After this sequence, the guest sees the same controller and namespace
names (e.g. /dev/nvme2n1 remains /dev/nvme2n1), and the NVMe driver
recovers transparently via the standard AER recovery path.

Tested with:
- Linux 6.1 guest on QEMU aarch64 with HVF (macOS)
- NVMe subsystem model with multipath disabled
- DirectPV and MinIO AIStor storage stack

mr-083 (2):
  hw/nvme: add namespace hotplug support
  block/monitor: add drive_insert HMP command

 block/monitor/block-hmp-cmds.c | 59 +++++++++++++++++++++++
 hmp-commands.hx                | 18 +++++++
 hw/nvme/ctrl.c                 | 85 ++++++++++++++++++++++++++++++++++
 hw/nvme/ns.c                   |  1 +
 hw/nvme/subsys.c               |  2 +
 include/block/block-hmp-cmds.h |  1 +
 6 files changed, 166 insertions(+)

--
2.50.1 (Apple Git-155)

