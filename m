Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FD7AC5B572
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 11:50:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvZMo-0001j1-1k; Sun, 16 Aug 2026 07:49:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <narimansayed28@gmail.com>)
 id 1wvSak-0000kB-Iu
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 00:35:26 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <narimansayed28@gmail.com>)
 id 1wvSaj-0003Eg-3N
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 00:35:26 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-47fe377a217so1479661f8f.1
 for <qemu-devel@nongnu.org>; Sat, 15 Aug 2026 21:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786854923; x=1787459723; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=JcjHhoNvfa5D0F/IP+RYn1izPXZ1OBhHa2TtH7vpCfc=;
 b=RvQ41ic6qZcHUjIzVedIXNzBWLcbVNYiXLdHVRL7XkRcsOJk2mYsWG3JBys9PC9OqZ
 +01tfEqMNJcfB/ziDU2wc2dqXYNeA25ZVt5avpaZSJg77cN3MC1cgWR79BU2RxT+V6U9
 zHK6YP9uHvur/d5zr7DHMLpo0lBwiVTTQJRs/Lb5j82jNSty9bmnjQECPRljuLdH+3y/
 v+OMwR1gfMo2fi3MK+LTZURNElLTUCrhpnzCc/gW2c/4vkjtN07cXgZ5LByGheAZQcAa
 uK76j6knXRXSeaiMTBwzAc/YotxJWLniADrd5CzF/7a0e3XP1g76/hGUBwr0BGpp4oVF
 94yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786854923; x=1787459723;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JcjHhoNvfa5D0F/IP+RYn1izPXZ1OBhHa2TtH7vpCfc=;
 b=oYk8+qeBchqw38ECrpoLyekWDiKd3SVoUUY6D884frlsT/1ABN89U0O46+2orj4V5s
 xc4jzqemImKQ1u6BGJMRd5mgVJ4gu7fXwKW9+H19NcwWA9s7XOhmiO/iHv49OjGiLiJj
 QziuV2eDEirO1/TAPSdQZISPHhtDYBTwHCMgZJRyEKllCShK+qA6HH2FAVMJ4OVSJpnL
 QrxyMyuelwnm4M4fMOijIkrWzW1PuNiaEloLvclHJ2mDof3Pd0msL32JYsZ0B57xIcJg
 2C/3yev4nzPsfgIqUSEWelRSJtDmW1f+kLVUFdqRXWgQpcZ3tE/r6oPwld98xyM1Ce5M
 pIqA==
X-Gm-Message-State: AOJu0YyVjolj3OLWxq+VMrwl528c82a4TscqAG5X5HVFrDlgNNB70Nfp
 4rCwpFasLdYa88dZljynogIodGYfR2JeVhgMqtk3+yg21HCzi4WeukCzOS3sQyos
X-Gm-Gg: AR+sD13Q3KgyOLjBVzejLXQUettuyTXZ5kDnwp1bB90UoNquOklxd4c5d1HRdDEBLCW
 IwCeGJcduj9imravFphh7qtgVXRxZNP3DChvpTnX+VZByII5foQSLo0I44iva8Ll2g7AFEKLLK6
 zf3zoQc/ai9XSIxBMu3AWE/h8nv1KgzGJYHkzTw+snFyXp7vXAeWLtSUgzLQ018Kwkr1XtevB9F
 pAbLM+DODKGvNbYepMLNKzS6EquIgIAqejRX9YfsBb0XUkZczzF8TL66pfC15HkVAOBqkWnPyc4
 bkyaYxfOPQziThL6kuZEAfjddZKfnuZqbgfBt2fNt00wKoTn64YplmBPc8fliedxr9Hn4WksWQK
 z0aCNrvQlFv3SJEKQP0hMpvGtFlKK/Frt5flPo6S6+GfYc9YvfZwUhNusjYQqLKqjvFIBaM64la
 NN60RqH+NMQ90ulZw3g5Ce5EJHTMYmWxw0G9eu+x0yPULOCBErbig/USSy+beOroCLaf+alp5Vx
 gbF/vAgyh/JSRjeE4fT9p0f
X-Received: by 2002:a05:6000:1844:b0:481:5ba5:994c with SMTP id
 ffacd0b85a97d-4816077aab7mr24671832f8f.20.1786854922858; 
 Sat, 15 Aug 2026 21:35:22 -0700 (PDT)
Received: from DESKTOP-2SK3BJA.localdomain ([197.49.67.128])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4815f2b27bfsm22971471f8f.23.2026.08.15.21.35.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Aug 2026 21:35:22 -0700 (PDT)
From: Nariman Sayed <narimansayed28@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nariman Sayed <narimansayed28@gmail.com>
Subject: [PATCH 0/3] net/tap, virtio-net: auto-detect MTU from host tap device
Date: Sun, 16 Aug 2026 07:34:48 +0300
Message-Id: <20260816043451.2547-1-narimansayed28@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=narimansayed28@gmail.com; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 16 Aug 2026 07:49:20 -0400
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

This series adds automatic detection of the host tap device's MTU
and exposes it to the guest via VIRTIO_NET_F_MTU, addressing
gitlab.com/qemu-project/qemu/-/issues/3155.

Currently, host_mtu= must be set manually on the virtio-net-pci
device, duplicating the MTU already configured on the host's tap
interface. This series adds a new mtu-from-tap boolean property
(default off) that, when enabled, automatically reads the tap
device's MTU via SIOCGIFMTU and uses it for the guest, avoiding
the need to specify the value twice.

The series is split into three patches:
 - patch 1 adds a helper to query a tap fd's host MTU (Linux only,
   with build-safe stubs for BSD/Solaris/stub backends)
 - patch 2 exposes this via NetClientState for use by device models
 - patch 3 adds the new virtio-net property and wires it up,
   including a note on a config-space sizing timing issue
   discovered during testing

Tested manually with a tap device configured for MTU 9000 and an
Alpine Linux guest, confirming the guest correctly negotiates
VIRTIO_NET_F_MTU and reports the expected MTU.

This patch series is part of my effort to get more familiar with
QEMU's networking stack ahead of GSoC 2027.

Nariman Sayed (3):
  net/tap: add tap_fd_get_mtu() to query host tap MTU
  net/tap: expose tap_get_mtu() via NetClientState
  virtio-net: add mtu-from-tap property for automatic MTU detection

 hw/net/virtio-net.c            | 12 ++++++++++++
 include/hw/virtio/virtio-net.h |  1 +
 include/net/tap.h              |  1 +
 net/tap-bsd.c                  |  5 +++++
 net/tap-linux.c                | 30 ++++++++++++++++++++++++++++++
 net/tap-solaris.c              |  5 +++++
 net/tap-stub.c                 |  5 +++++
 net/tap.c                      |  7 +++++++
 net/tap_int.h                  |  1 +
 9 files changed, 67 insertions(+)

-- 
2.34.1


