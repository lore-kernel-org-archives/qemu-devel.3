Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFAF1E909C7
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 15:52:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsNM9-0002Je-NM; Tue, 17 Feb 2026 10:51:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1vsMx4-0003b2-Di
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 10:25:26 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1vsMx1-0005f8-Gr
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 10:25:26 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-48378136adcso23117235e9.1
 for <qemu-devel@nongnu.org>; Tue, 17 Feb 2026 07:25:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1771341920; x=1771946720; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Brb3KYbswM8WiwWkhozk8T5T5lyvsjBrf/InVBnPESw=;
 b=N4hhvyt8cpXtqwaNDh9HdE5LmUdSGad3CEReNfRolPi9dnKrCrWihaHLAe89wivTWb
 B+5ujxsEdb01Kp57D8z0hy0liQ+ReJtk42Q2f6Q0WsxR8Nvhp4flVl657qAPqh87tQYR
 H44h1ptXYM4AMkxuT7rUdd+gAWx1fU8p00iY8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771341920; x=1771946720;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Brb3KYbswM8WiwWkhozk8T5T5lyvsjBrf/InVBnPESw=;
 b=ZXdikUDDihPYuRDPB6zloAIHMhcZbdosMvQBnyqjHVVzPhfvgRc1aLYn2bzrz0eMel
 HXJW3EBKYgRW0ylhIfV/tKW8qcTS9dCcE2Mgwd5vDmlFzMvcgCH0sJpH84tLe1U2yOi9
 ZgWiatbpxdoWdtw16kogl/QsM9WWS5j1gOnfABz6HbiXHoM9x8Vo8nzjmesxW9AXlvmQ
 NJWwTO7A1o48Z2alvk5aLVnHYc4MRajNGuVnySvcrI7P8/EAgy85slOGpcuVPkh0KctP
 VtWLJ6EW1KbHai8CURIh9d9/cFbYHdljKm7zLfCmqLp8k7D4IpG+I8fIehsAAkgcnPOt
 p9sA==
X-Gm-Message-State: AOJu0YzKdocD+RHWpdi8SWewJWYctSFJPsDQu9n3W3wefR774CjYIZIo
 2NLloOS5jtlLkmzvuNymMBNgvwQS6qXDUHctIuwHTWz5qe8DLEbxmVhUm7n2P0tut+vrJQZ01de
 28n2y
X-Gm-Gg: AZuq6aIT0aEtF/6srXYVtqTjnWupAJ/qCmqjOan5LIn0EQXuPCNbKOttbJwkD5lrpst
 Xj49Fu+f639DsvmaYuOm+sns6IrbQnDGaB2fJm/5zEx05Nd2am6qitGKOZr4zPtdFqTlq95KLqw
 1VT4pQaZyGqMqFYRstPg32XT5QaXO9c2+nGQN4+WohYo8KrBN60vZRpD48U8garuYv++BhRGezN
 2yZEs++A4a95I/yB+ZUhMubqLco4xdVwVRwIsS5mkQmF70eS6wcdRnlHP+vuhGS6+M8BsXTX1V+
 BYWlshYmBckKm+J9B6lJZI2ly4lSQ6Dwrt96ISN+299FUoiefd1uHFBORxAwYZffGTn2z6ernm/
 TeXnWtpu64ztUv3RT3xSwC9JIISooKtBlYfFMOokJqkNnuBJFuVtsyprp2xJZhoc+VR2qfe9eeK
 GsNIj74/NnXFjDr4jG3jB8wfkzHCwnBBnpPb+JKH5sFtGI/aUOmF0jHrHXs23MmpqlgIo+nbyii
 GYcsG56grkF/Sh9wHWbimU=
X-Received: by 2002:a05:600c:4750:b0:483:7783:5373 with SMTP id
 5b1f17b1804b1-48379bfd6b6mr181116315e9.23.1771341919641; 
 Tue, 17 Feb 2026 07:25:19 -0800 (PST)
Received: from alex-laptop.lan
 (p200300cf574bcf00ffb15ba913f79a3b.dip0.t-ipconnect.de.
 [2003:cf:574b:cf00:ffb1:5ba9:13f7:9a3b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4835dd0e327sm519169015e9.14.2026.02.17.07.25.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Feb 2026 07:25:18 -0800 (PST)
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
To: qemu-devel@nongnu.org
Cc: Jesper Devantier <foss@defmacro.it>, Peter Xu <peterx@redhat.com>,
 Klaus Jensen <its@irrelevant.dk>, Fabiano Rosas <farosas@suse.de>,
 qemu-block@nongnu.org, Keith Busch <kbusch@kernel.org>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Subject: [PATCH 0/4] [RFC] hw/nvme: add basic live migration support
Date: Tue, 17 Feb 2026 16:25:13 +0100
Message-ID: <20260217152517.271422-1-alexander@mihalicyn.com>
X-Mailer: git-send-email 2.47.3
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alexander@mihalicyn.com; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 17 Feb 2026 10:51:21 -0500
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

From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>

Dear friends,

This patchset adds basic live migration support for
QEMU emulated NVMe device.

Implementation has some limitations:
- only one NVMe namespace is supported
- SMART counters are not preserved
- CMB is not supported
- PMR is not supported
- SPDM is not supported
- SR-IOV is not supported
- AERs are not fully supported

I believe this is something I can support in next patchset versions or
separately on-demand (when usecase appears). But I wanted to share this
first version as RFC to get some feedback on this in case if I'm approaching
it wrong.

Kind regards,
Alex

Alexander Mikhalitsyn (4):
  hw/nvme: add migration blockers for non-supported cases
  hw/nvme: split nvme_init_sq/nvme_init_cq into helpers
  migration: add VMSTATE_VARRAY_OF_POINTER_TO_STRUCT_ALLOC
  hw/nvme: add basic live migration support

 hw/nvme/ctrl.c              | 505 +++++++++++++++++++++++++++++++++---
 hw/nvme/nvme.h              |   5 +
 hw/nvme/trace-events        |   9 +
 include/migration/vmstate.h |  21 ++
 migration/vmstate-types.c   |  88 +++++++
 5 files changed, 598 insertions(+), 30 deletions(-)

-- 
2.47.3


