Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63370CDB478
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 13:57:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbf8m-0002Ml-KW; Mon, 22 Jun 2026 09:56:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1wbf8j-0002MQ-CU
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 09:56:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1wbf8h-0007uH-QC
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 09:56:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782136597;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=fZZHLqew+L0sNIC1rOgityrBeK37dEjwB9uEKt+gf6E=;
 b=J4njfFD1X6T3xu/hMDjE/WjqoxnDlgVcfZ7gzaUfBtnH3sP5geAvJE05nQo3HQ66WWrt/8
 q2eqHFlfu+lWiTJh8GmzWEes+bgUgVk8RQz1jk2o4FjNTfoQfV3gqxcShtzrDvcREmh7/P
 xhnO/pEVfHtwcTevUwFvU5IneyzIWx4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-477-CMhhHvx4O-WepkGrSW44Gg-1; Mon, 22 Jun 2026 09:56:35 -0400
X-MC-Unique: CMhhHvx4O-WepkGrSW44Gg-1
X-Mimecast-MFC-AGG-ID: CMhhHvx4O-WepkGrSW44Gg_1782136594
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-4639f122c38so3172299f8f.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 06:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782136594; x=1782741394; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=fZZHLqew+L0sNIC1rOgityrBeK37dEjwB9uEKt+gf6E=;
 b=UuVRgse0J71lI90fTxWhUnwSfxwJ69ESul452Y4g9NkfbYkqPlU4YYjtT51z6774Rg
 ioR7EktnKqaA4e9WSLVeUoQspmuXrivUDxHAdjOEFtzvRhxm9q6+koYZTFmzA8+6zCBc
 xj+CHk3/ZUXsqCZdUsMrz28iHrqqLnmUh0+qEDCMH8vdBO64c/8mnxm1FA1iQnALApWp
 HB4oJ4++7DnqSustYLOWHYT3HTm5cxZIJTeTVrfJTdQtXxNUe4RYljhTtNo01zDOA1tX
 sQ+cahJB9dg47kWK3fHzd9zyu2fET7V3Z3sDcQqLDIZ7uMgzbhLslg97t2UIWmMLH6S5
 fhyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782136594; x=1782741394;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fZZHLqew+L0sNIC1rOgityrBeK37dEjwB9uEKt+gf6E=;
 b=nKHG5RHnERtlAwhl4BfuKBGn0pTptdIKU5ZEjRLOpsc8De7c8SDnA3CEgYCVoFJPVN
 u6nYFzTVKeMNifb3TeZujdwV8Iq5U0JTBIFMF1Y6jDWPnlO9rA/0tB1MvdwI8VVDkA+3
 uZcDtOhHtRuhFim7iAAznu1JXJ3fgMkjERiFCyEx97flwax8z8iD9gFd57Tw1P8KJnfQ
 L2MjyYwzRh/N/pmcljKza7hEI2LWrdlHb3LjoXStUPd0EiFwEVhxk9sv16pWxXE9poqr
 wMSmGLoCKr0+m3BaExg8LFQszsvflxLtDojFnmK9Jg4nwB6uooE2Ou2LBcONur2cDBJZ
 bd2w==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr7+kkyWKfHqMxpBJoFbJw3JofcODpQSjC63AspICuGnH0g+xOTbihVQZe9dbcuR1NXOgtn4C/JuyEu@nongnu.org
X-Gm-Message-State: AOJu0YxZhN7KhBRig4moN9O2qhMsuRnDSWMBUe61JAR+8Bo3g5F3bKel
 bd3OIteECzpzn5OzV8ykDDIHD7oBNIAjQd/MFiPBCWmD/75GS0/wNXGzMR5doqxJ+SmIGYpmCn4
 hNeOFtPQ6BVK+XaAhYKw2TP1YypRPNYTfCpphKfPtYMQNOO1apYa00uiF
X-Gm-Gg: AfdE7cmLVP3q17UQdUYGY+MsDW+/O62nIy8h6bRJAaZya23C2JYRBuouHZOZU5fVGKd
 bVwossISvKRfkgZ+YWtronnT13FPSCS/UMr9+5oZBa8yfQmyJvflge6C7ID4Iz8YTA7+cJxfqab
 HJKyj0+GcAHcrz3VYg2F3U/MW5HJdRe4lTU+zZBmV17S5a/eA4sW1lSfOTjp+hhuwoaOVnBeMNP
 ogYDnIktcCIJjR4OQlXFcAZlnxYmAPv1vRTDMW6/NmgeTIeuRNTUYEHuX8xryAQds//gvleQfGQ
 LZn8ifsmVcUgOq2TrxNQ44rbvp2AVVHnIZfQ7Rdu4POT2hNCGmd7yc4a9IOw92AvWphB9UGUYuq
 J7Ppxdlz+a7C+vlPdwYTedam2zlrVlUMxTzGzMq7KCrw9MyESyS+0X6cmkGj2xWgJoKmnFNK0IH
 Q=
X-Received: by 2002:a05:6000:1885:b0:460:70d1:c77 with SMTP id
 ffacd0b85a97d-46660d0617amr16297940f8f.13.1782136594143; 
 Mon, 22 Jun 2026 06:56:34 -0700 (PDT)
X-Received: by 2002:a05:6000:1885:b0:460:70d1:c77 with SMTP id
 ffacd0b85a97d-46660d0617amr16297901f8f.13.1782136593778; 
 Mon, 22 Jun 2026 06:56:33 -0700 (PDT)
Received: from rh.redhat.com
 (p200300f6af2a6100f239e076bbd76784.dip0.t-ipconnect.de.
 [2003:f6:af2a:6100:f239:e076:bbd7:6784])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-466643f4e9esm25162303f8f.1.2026.06.22.06.56.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 06:56:33 -0700 (PDT)
From: Sebastian Ott <sebott@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>, Eric Auger <eauger@redhat.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Alireza Sanaee <alireza.sanaee@huawei.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Sebastian Ott <sebott@redhat.com>
Subject: [PATCH v3 0/3] arm: demuxed ID registers (CCSIDR_EL1)
Date: Mon, 22 Jun 2026 15:56:24 +0200
Message-ID: <20260622135627.40573-1-sebott@redhat.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sebott@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

Handle the demuxed ID register CCSIDR_EL1 as part of the
idregs array. V2 of this series was posted here:
https://lore.kernel.org/qemu-devel/20260204133229.297061-1-cohuck@redhat.com/

Connie asked me to carry these forward.
Changes V2->V3:
* removed extra idregs_demux[] array based on suggestion from Richard
* removed COPY_IDREG_DEMUX suggested from Eric
* add CSSELR_MAX define
* rebased to current master
* removed my R-Bs

We still manually add the register definition to target/arm/cpu-sysregs.h.inc
- can we add special handling for that in the script that generates this?

Cornelia Huck (3):
  arm: handle demuxed ID registers
  arm: handle CCSIDR_EL1 as a demuxed register
  arm/kvm: get demuxed ID registers from kvm

 hw/arm/virt.c                 | 23 ++++++------
 hw/intc/armv7m_nvic.c         |  2 +-
 target/arm/cpu-max.c          |  6 ++--
 target/arm/cpu-sysregs.h      |  9 +++++
 target/arm/cpu-sysregs.h.inc  |  1 +
 target/arm/cpu.h              | 18 ++++++----
 target/arm/cpu64.c            | 14 ++++++--
 target/arm/helper.c           |  2 +-
 target/arm/kvm.c              | 32 +++++++++++++++++
 target/arm/tcg/cpu32-system.c | 26 +++++++-------
 target/arm/tcg/cpu64.c        | 68 +++++++++++++++++------------------
 11 files changed, 129 insertions(+), 72 deletions(-)

-- 
2.54.0


