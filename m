Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27C05CA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 09:14:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xENL1-0002tI-EJ; Wed, 07 Oct 2026 04:49:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <narimansayed28@gmail.com>)
 id 1xEJsp-0001cF-Gq
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 01:08:32 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <narimansayed28@gmail.com>)
 id 1xEJsj-0005Iq-Qp
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 01:08:02 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4a180fbeef5so1670325e9.1
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2026 22:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791349672; x=1791954472; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7JL+4Zj49P9nveo4st+u2ctd/d1goJVIhpcV0zWCWus=;
 b=mRWQBL3S9DrXJcS/mlY7/c2q2Vkz9OukBoWCc6esmIveGvFpSa2lZ8jOJnQnQM8rvL
 4agnsZVWhZDdX2fILupi/jj6vTRTx1fTBqOnsv5YVj5KJF7O4VMDUwEWQSp2SQ9eXAOb
 oXcn/3NBlO1PTceQ3urFmSGxCPadu0y0lfqdUDdWvRJarfKmXJRsZTqJMW/uoaWSUYud
 EtwrmOjofZqSX/qHPwyPmH61xtoPa2D8PrQ5z62MfKgJEEwJ5RvdSkVpzPSeLrFKw3Om
 uKuJmDIloUZlPYDdUnHqqbRzkKBAAfFhItGVtjFAGD9ZMuo3bGS9PuQbn2rJMZN40Syd
 /J0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791349672; x=1791954472;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=7JL+4Zj49P9nveo4st+u2ctd/d1goJVIhpcV0zWCWus=;
 b=C9QPfQCh/fWvtb0mRg3KoV5o1VtsamiZWlpIIhiTT7/iYSQhQwhZZ4rQMWGhWFSkyh
 tbjsVSFauE2y7bJfTzM2EWsb56FntLzichTvQIo/b5/P5AU8BLwbKipf41IVFnkw01u+
 QTlg11otUq/f/xqz8cK1mvKnGXzAqQN29qXQTUZceGYUf5Z0QRIMwqL4ewtcRpQfEfuu
 GJu3DxpAZw9lOvXhtCqHfI0kiz8NET10QAn25HBHfCJdJJOy1wv2i2rztsgyC1ObnS//
 naZ9/kc6oIFFEad/4oDMpUmY7kzreHCsAaAHBpUpBCv2X4X0SCoyauAHsM7QjEWFbgDq
 mlOw==
X-Gm-Message-State: AFuF++l+Yex+1Xv0IRZeMye7HjsXn/xSRb7lGbQkt+6gywEzVP06GjKy
 026DFy9Uv9qWYZ8Y/BmGnIviz52p2wLJjtQYV9Y9ip2SwjFMM06w0lc11c3UfLCEOh4=
X-Gm-Gg: AYBFou0hYBP348Jq4FHETRY1GRYs8w7d6t9876E/YDGzqklXoErlFyeD0piily1IrdK
 plbDwh3EPl72G0EwHo13IOfrPBJfPPvKqQuBsfy0dy5Ltx+tSfou1pbbCKqEDxyujRO+GSHnRSd
 zzjKctfARMKmr+onS54OjFWPEt/WchUNbm0MJil04KKNF1q4mx/SrUsxvd47GvfqPNSOGBQAD2B
 xBKNporTjOMCZIjpVU7yz2UwOgA1JREKYHeKNhf0mPy2p9+Z6Ac6yJBlcZTCRSN/vbzRIvPZn0m
 MmYRj3Dm+LU95ejNuoP1P4UjOYvi2f+K4mhuHBbFRqZ7wBUAQwejooS+fmC9zCpuDjxOtpp6uVc
 KvqQG6HpSsgCvsLm2XHQQZsTZoooA+7fYoVnLCDDR83ZrzxtYhNyvEt3zHzUHR4J9eHcihNW9/4
 +pKaP62fiq22gvTDRHJXHv32GD+wD+obwG9bmsfpo6+0BMxp8AHXAW3NCRhejWvLRnG7CLFF68s
 EA1p5M2cq15ScJ5n6zPJPCH
X-Received: by 2002:a05:600c:3b0a:b0:4a1:70da:3350 with SMTP id
 5b1f17b1804b1-4a180679e58mr10765145e9.32.1791349671857; 
 Tue, 06 Oct 2026 22:07:51 -0700 (PDT)
Received: from DESKTOP-2SK3BJA.localdomain ([197.49.190.197])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a17f795f29sm33359315e9.11.2026.10.06.22.07.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 22:07:50 -0700 (PDT)
From: Nariman Sayed <narimansayed28@gmail.com>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowangio@gmail.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Nariman Sayed <narimansayed28@gmail.com>
Subject: [PATCH v2 0/3] net/tap,
 virtio-net: auto-detect MTU from host tap device
Date: Wed,  7 Oct 2026 08:07:15 +0300
Message-Id: <20261007050718.926-1-narimansayed28@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260816043451.2547-1-narimansayed28@gmail.com>
References: <20260816043451.2547-1-narimansayed28@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=narimansayed28@gmail.com; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This series adds automatic detection of the host tap device's MTU
and exposes it to the guest via VIRTIO_NET_F_MTU, addressing
gitlab.com/qemu-project/qemu/-/issues/3155.

Currently, host_mtu= must be set manually on the virtio-net-pci
device, duplicating the MTU already configured on the host's tap
interface. This series adds a new mtu-from-tap boolean property
(default off) that, when enabled, automatically reads the backend's
MTU and uses it for the guest, avoiding the need to specify the
value twice.

v2:
 - Addressed feedback from Eugenio Perez Martin: rather than
   checking for NET_CLIENT_DRIVER_TAP and calling tap_get_mtu()
   directly, added a generic get_mtu callback to NetClientInfo and
   a qemu_get_mtu() wrapper, following the existing qemu_has_ufo()
   pattern. virtio-net.c now calls qemu_get_mtu() without any
   backend-type check, so other backends (e.g. vhost-user,
   vhost-vdpa) can implement get_mtu in the future without
   requiring any change to virtio-net.c. (patch 2 is new as a
   result; patch 3 updated accordingly)

The series is split into three patches:
 - patch 1 adds a helper to query a tap fd's host MTU (Linux only,
   with build-safe stubs for BSD/Solaris/stub backends)
 - patch 2 adds a generic get_mtu NetClientInfo callback and wires
   it up for the tap backend
 - patch 3 adds the new virtio-net property and wires it up,
   including a note on a config-space sizing timing issue
   discovered during testing

Tested manually with a tap device configured for MTU 9000 and an
Alpine Linux guest, confirming the guest correctly negotiates
VIRTIO_NET_F_MTU and reports the expected MTU. Also tested by
Aniket Sahu on ppc64le/POWER10 with a SLES guest.

Nariman Sayed (3):
  net/tap: add tap_fd_get_mtu() to query host tap MTU
  net: add generic get_mtu NetClientInfo callback
  virtio-net: add mtu-from-tap property for automatic MTU detection

 hw/net/virtio-net.c            | 10 ++++++++++
 include/hw/virtio/virtio-net.h |  1 +
 include/net/net.h              |  3 +++
 net/net.c                      |  9 +++++++++
 net/tap-bsd.c                  |  5 +++++
 net/tap-linux.c                | 30 ++++++++++++++++++++++++++++++
 net/tap-solaris.c              |  5 +++++
 net/tap-stub.c                 |  5 +++++
 net/tap.c                      |  8 ++++++++
 net/tap_int.h                  |  1 +
 10 files changed, 77 insertions(+)

-- 
2.34.1


