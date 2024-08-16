Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 310ABC3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 16:14:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sezaQ-0008Fq-EZ; Fri, 16 Aug 2024 12:13:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sezaO-00088v-Kq
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 12:13:56 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sezaL-0007dN-PU
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 12:13:56 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3718e416297so722120f8f.2
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2024 09:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723824832; x=1724429632; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=EI4M/gvSdt6iePTxzBiDbXKkI/BlDGQe8UMEpTZU8r8=;
 b=KV0C3aNajCMzQDRfbMfKHBD+tCNW7cyC8BdV0tpad85pw86DuqpbBOfJrq0+T9KtWO
 ZuY9H2I/3mzUwltd028cgBCRWGiQcWky2EhPkXVTbIJgmC2TIF9g/wAME6OJXRpSIlDS
 eHLeLAebc7QltobslS63db6sBh6AcgxwDV6L49NyQklsJMSm7fmXJ8LlkEi5/LsVxp4h
 MaxJY6oMVlWR3VYu32rfa/1bhY+VUZmzNrUb0yhVaU5nX+/1hTBX96TfJiuZaEAP7YFS
 a0014dN6P8PWMQLZD/T8sJtYwCOD8NYPKLolo3rXN57K2J3NdkvuenKNZanMlb3Xloz2
 EOLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723824832; x=1724429632;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EI4M/gvSdt6iePTxzBiDbXKkI/BlDGQe8UMEpTZU8r8=;
 b=qUDjrjJ3D6axlbeQbKDRNe0aey11hOi0CsgnVkAsypdc/UajJQwmuqrd9IJwGAT7h3
 xUX+2JaQ8qTF5/hKYDxL3Uk5JyUCDHjQV/RzAD7KSL7efA5IontcIanYvu6dU+Kxrr74
 asXZIlKSx3vtFXtC4IXgfe2nskW0BstuMLR1GtkO24ICbUdya3Q/wzFUfrLu1GsjlBKO
 aKCVvWNEF9RBYzUkimlH09gZzkOm2WSr7gbuZNqcoKPAYOzTP0VtxWC9+b0bZqHgirNe
 wP4yxXLVISGNVuBMObNGzAWV9hokY1zz0t9+rJi9p700fy+FXSHunq1aa+pYL4L1q2IS
 K6AA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCciAfgrN9wW/U/0wzUXjYUlnP9nEpgdSZpRpx0TZkLETOXcb4dSD+r2c7oHAEAjxmEqmZQRh4DHAwqkRIP06vZ9ts+bc=
X-Gm-Message-State: AOJu0YzpTkwFuCoaTxIClfNOeuKDN68obOLC5IVmZrfX6R4tiJCFBebp
 zancGqERYCckCBRVhE1r/SkWE5CUF/NqfYG2gRKjM2HZQnRmZUIsCVVBdgYIOm4=
X-Google-Smtp-Source: AGHT+IH9u1+GeWvU02N3Ya65aix7TLlcoNLWr4Kw4c6lRsDG9/TXclV5itV9T0s2KbUyE1JfkvlQHg==
X-Received: by 2002:a5d:44ce:0:b0:367:8a2e:b550 with SMTP id
 ffacd0b85a97d-371946ace2fmr1958411f8f.60.1723824831771; 
 Fri, 16 Aug 2024 09:13:51 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-371898bb588sm3912269f8f.115.2024.08.16.09.13.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Aug 2024 09:13:51 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Leif Lindholm <quic_llindhol@quicinc.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Eric Auger <eric.auger@redhat.com>, Radoslaw Biernacki <rad@semihalf.com>
Subject: [PATCH 0/4] hw/arm: Enable 'nested' SMMU in virt, sbsa-ref
Date: Fri, 16 Aug 2024 17:13:46 +0100
Message-Id: <20240816161350.3706332-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This patchset enables support for nested (two stage) translations
in the SMMU in the virt and sbsa-ref boards.

Patch 1 is Cornelia's compat-machine machinery patch, which we
need to make this change only happen for virt-9.2 and later;
patch 2 is a trivial "missing comment update" change; patches
3 and 4 are the board changes.

Enabling nested support should be transparent to guests, which
will only enable stage 2 if they actually want it.

thanks
-- PMM

Cornelia Huck (1):
  hw: add compat machines for 9.2

Peter Maydell (3):
  hw/arm/smmuv3: Update comment documenting "stage" property
  hw/arm/virt: Default to two-stage SMMU from virt-9.2
  hw/arm/sbsa-ref: Use two-stage SMMU

 include/hw/arm/virt.h      |  1 +
 include/hw/boards.h        |  3 +++
 include/hw/i386/pc.h       |  3 +++
 hw/arm/sbsa-ref.c          |  1 +
 hw/arm/smmuv3.c            |  1 +
 hw/arm/virt.c              | 19 +++++++++++++++++--
 hw/core/machine.c          |  3 +++
 hw/i386/pc.c               |  3 +++
 hw/i386/pc_piix.c          | 15 ++++++++++++---
 hw/i386/pc_q35.c           | 13 +++++++++++--
 hw/m68k/virt.c             | 11 +++++++++--
 hw/ppc/spapr.c             | 17 ++++++++++++++---
 hw/s390x/s390-virtio-ccw.c | 14 +++++++++++++-
 13 files changed, 91 insertions(+), 13 deletions(-)

-- 
2.34.1


