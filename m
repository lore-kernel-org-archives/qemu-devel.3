Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8EDDE77194
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2024 15:21:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tSe2P-0001Sh-N1; Tue, 31 Dec 2024 10:20:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tSe2N-0001Qf-Vv
 for qemu-devel@nongnu.org; Tue, 31 Dec 2024 10:20:04 -0500
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tSe2M-0004DH-FR
 for qemu-devel@nongnu.org; Tue, 31 Dec 2024 10:20:03 -0500
Received: by mail-pl1-x642.google.com with SMTP id
 d9443c01a7336-21683192bf9so134355845ad.3
 for <qemu-devel@nongnu.org>; Tue, 31 Dec 2024 07:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1735658400; x=1736263200; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=X9ZTWPdO1LHH7H0GwUXb6JYPpF+TRTjlK2VG/HTPgDA=;
 b=lGkcTzNURGriiFhkL6l45HM7BwgAv6TBo/2dMcd2MxUc+n/vNsMA2oik2Ao2QlK820
 FYybqGAJcz9YrSVHagBGEcK1iWtao38Ccalbe9Fnpyk1kIcZ1SQexyj4pAXREaBbZS8F
 b+2HCYKDWP24oX7clp7z6cIFmr1RITCZ3XNmFGsYkfNj0xeCwsHaN3Dcvy8Y5GQjHt4f
 hdLYfIocsJkTdPdzFOudCoXOO8neIUk0eWek6uhPqUEOOnCoku4qVbnaRZUigaf3bqSu
 Dq4ggBOhNU1Y3hnsFbX9ZIq0Itl6sUxilLPTcO29f+p2zfXC0wxDMWWupdctJCD38XGI
 B/rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735658400; x=1736263200;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=X9ZTWPdO1LHH7H0GwUXb6JYPpF+TRTjlK2VG/HTPgDA=;
 b=Xd6FB0w1+ch2FaDo4x7eN2rcXPnN/bQDIIhK/3aJf++NKWRCiGIz3lXg6TdylP0U+N
 XuO7guvMNzQdalPQEw3JewUSJlVelE6Y878PcsU/0s9dmTBrHyR5tZ7pOy8mQC0xTvcl
 brFM46/tP/8Qx6PLPC81Ecs8kw3rvQkefv8jNq0Sq2B86jDCvy5ywkNL8I+7lAMTzJwo
 0pm+bqG8L7wKd7CyICMD+elLdO6awfEe/496W5HgoYqAtRdY2t/hnZHvPJJiMcA1WOw5
 bhE2nfIb88/9RDjdmBTJ1tDz0ZmMON4iAp7yv1z5eukFUSSyKESLsYfXIPpcTvdZr4rf
 Bgtw==
X-Gm-Message-State: AOJu0Yztlr7wMGld6msDiPIS44pdSPWyuV+l8dLylqCpFg03nWNJsuKn
 QQObaoU/8Ow4t5F4wU81QpBak6cH/esja6ZzwLgDCwAwJWmNslw=
X-Gm-Gg: ASbGncvusoPy3LouECLTJ74RXpKjDZBz1idNypEChD37e4RYuUB61tJAUDI2r7Q+O1n
 LbvEij/fShksnyruD9EBZee39fWQm5RWXIpOEWiEq8Xp0QDdeTvFVHVYJFolrgP5Lzlr+3xp2HD
 xdTPdwt2SDEyaoOts+T28Qw8VzTI28OhoJbZfB2GHlCqc17oYnFCnvs+a+97DyJHoDX6eXXqkVv
 +MwdVC7GQG6YAh5nQsGt/4quw9iv96KH3wUNo4Bv10Kl9P8+ke+0kLVWgMSH4GlpbOFjQ==
X-Google-Smtp-Source: AGHT+IHMsQqTeMXDNTazCyeQJtuQEMlmRcMf1UT5jGQIJvwn8ucfQIsgu8fNObcLnLSDJow4OPw99g==
X-Received: by 2002:a05:6a21:999e:b0:1e0:ce71:48e0 with SMTP id
 adf61e73a8af0-1e5e081d7f5mr63026092637.39.1735658400511; 
 Tue, 31 Dec 2024 07:20:00 -0800 (PST)
Received: from localhost.localdomain ([58.38.120.107])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8309e8sm20933481b3a.43.2024.12.31.07.19.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Dec 2024 07:20:00 -0800 (PST)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Cc: qemu-devel@nongnu.org,
	Tomita Moeko <tomitamoeko@gmail.com>
Subject: [PATCH 0/3] vfio/igd: VFIOConfigMirrorQuirk for igd mirrored registers
Date: Tue, 31 Dec 2024 23:19:50 +0800
Message-ID: <20241231151953.59992-1-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=tomitamoeko@gmail.com; helo=mail-pl1-x642.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

In commit 1a2623b5c9e7 ("vfio/igd: add macro for declaring mirrored
registers"), I introduced a macro to handle mirrored registers in igd
bar0. However, using the existing VFIOConfigMirrorQuirk should be a
better approach I think after going through the vfio code.

This patch set introduces a new header file, pci-quirks.h, to hold
generic quirk declarations, and extends VFIOConfigMirrorQuirk to
support offsets in PCI config space. This eliminates the need for
the previously introduced macro.

Happy new year :)

Tomita Moeko (3):
  vfio/pci: declare generic quirks in a new header file
  vfio/pci: introduce config_offset field in VFIOConfigMirrorQuirk
  vfio/igd: use VFIOConfigMirrorQuirk for mirrored registers

 hw/vfio/igd.c        | 128 ++++++++++++-------------------------------
 hw/vfio/pci-quirks.c |  64 ++++------------------
 hw/vfio/pci-quirks.h |  72 ++++++++++++++++++++++++
 3 files changed, 119 insertions(+), 145 deletions(-)
 create mode 100644 hw/vfio/pci-quirks.h

-- 
2.45.2


