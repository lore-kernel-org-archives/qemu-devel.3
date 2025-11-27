Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B5E1D116F5
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Nov 2025 14:25:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOcv6-0005bT-Fs; Thu, 27 Nov 2025 09:24:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1vOcv4-0005ZJ-Rs
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 09:24:26 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1vOcv3-0006ly-D8
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 09:24:26 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4779a4fc95aso13784545e9.1
 for <qemu-devel@nongnu.org>; Thu, 27 Nov 2025 06:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1764253463; x=1764858263; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=DvvytfEhudAV67aX0S4oDIYVrm/T0d5LajRcCPINimk=;
 b=Ur+Y5L5nEMDXEq9FGXb11DB+i9NKzaOVowUoPJ3pawgDct3ggBhepB1L+3nRJo7niK
 dp/ZamY5WejWohacGFYntHrzm8AvZhqqnoD88Xuo9JJNOBWYCrKod8TXxEQw8uZKhHXa
 zP6c/wL+X0ZVsE6MGpdXqvJM4a6nrCh3VfUouHX4chYAtqAwOErk80qIXkXcFPX3c9Aa
 LKtVPLT6Vh13chR37psguMH194Ra2hLw5tmdCHnl+9eY+/idmZQexjLbf00yAHftOiYG
 iE0PH+1mIOffW0BUJytKL0r90bvX/UtIhW+E38ArJd+bB+qnuE87/lAlqTqAEzFTHiF/
 7uEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764253463; x=1764858263;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DvvytfEhudAV67aX0S4oDIYVrm/T0d5LajRcCPINimk=;
 b=eXcsHv6pBeJDTyEFlNA2jsnSNDjK6eFWTumAAMMEgwQKDtpRFu9zTVN5TLsmbqXs8d
 lCz+eCZPBb0t2VvJxaJMUrn94vH5TdB328Je1zm9sTo6Lbp1j9D7AZNoILTo2dFyWZ8Z
 4G8oJD7LUp1y1Z/mLi0/b+MyCh+N1T3xdXzDq4Mj3XgSG3iadyct7yIzHX4TYeW15a3l
 izDwgVt3wJiX/2NZtn+ExWdoAsvVhUp/1oUTa9pI99EvEHij1WThrUlGq9TKOEqX2kFq
 LEBmp7pqGQK8Bj+HSRZAXIrE8ZlBWlEV9jNMoG9wM4e386b7fj5w0sjTA3F0725rTG/G
 Au1Q==
X-Gm-Message-State: AOJu0Yyh15RM+u/gSp89Lq7kHolK8JkvW7n1wNDnIMyk/Mw0JTn8cbD6
 Xb0FxSyHtxMoLr/CufPoiijImRsWigb8xiIwQ0TxaZ5rU3FeYwPdFMfrR7TpUmfxLg==
X-Gm-Gg: ASbGncs6ShbCcIficEH/ncsPGtbTnnM5QveayJkXeuodUXy7SiSvWlsTSAuOREmvsk3
 28chOEWy630GLWOvYI/BcpO5dRZFHq1Kw0Ki9LqFkDXCP439JXS/MSDAoSrduEciWYq0lxaFszt
 sdv11tHolAOYcZW98DjQrIOeGYWQN2dngNhRe11tnYZqFGv2GjyQxAuVMcWTwAjrQbI6/F6HmRO
 y2vz+pKHkUOtpu+v8bvQh7mVlvLrXzbCpZcucVJpmAJGYM9PwzwJtzy6P3gPgl/J6FxYKJ/FaYG
 s4MReV0W81wTJHt90phZwQ1UG1F8yIUQjUGF02/dr9/99jIiYSgB3dDvwMqE3jf55IuHf9KrTML
 qbGTdUxzg6VLLuaZ3Q7cJKdbCpCiNojcEpkNkc0NJjkpExj+rozFsFUXbwpDN8QXvWfOjREVBXl
 Ij7GkrJ0YYY+Kw
X-Google-Smtp-Source: AGHT+IFRYkUoDPZOQl5n+wurWLNrfjtHdJaFIB+W/Iav6NVuvlkvMeb3qNfZrq0G6LROOflSE5mwMw==
X-Received: by 2002:a05:6000:4210:b0:429:eb05:1c69 with SMTP id
 ffacd0b85a97d-42cba63b646mr32897597f8f.2.1764253462971; 
 Thu, 27 Nov 2025 06:24:22 -0800 (PST)
Received: from chigot-Dell.. ([2a01:e0a:ca1:4970:e598:a2f0:7cc0:4392])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42e1ca1a2easm4148996f8f.23.2025.11.27.06.24.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Nov 2025 06:24:22 -0800 (PST)
From: =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, hreitz@redhat.com,
 eblake@redhat.com, armbru@redhat.com,
 =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>
Subject: [PATCH v3 0/5] block/vvfat: introduce "fat-size" option
Date: Thu, 27 Nov 2025 15:24:12 +0100
Message-ID: <20251127142417.710094-1-chigot@adacore.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=chigot@adacore.com; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

The main goal of this series is to introduce a new option "fat-size"
within the vvfat backend (patch 5).

This series also includes minor patches:
 - patch 1 introduces another option to create unpartitionned disks.
 - patch 2-4 are minor improvements easing the introducing of
   "fat-size" option

This was tested on with a aarch64-linux kernel taken from
functional/aarch64/test-virt and on aarch64-qnx over raspi4b with a
workaround, not included here (the SD bus must be associated to the EMMC2
port instead of through GPIOs).

Changes since v2:
 - patch 1:
   - change default: true for hard disk, false for false.
   - remove "unpartitioned" keyword within filename
 - patch 5
   - rename option "fs-size"

Clément Chigot (5):
  vvfat: introduce partitioned option
  vvfat: move fat_type check prior to size setup
  vvfat: add a define for VVFAT_SECTOR_BITS and VVFAT_SECTOR_SIZE
  vvfat: move size parameters within driver structure
  vvfat: add support for "fs-size" option

 block/vvfat.c        | 350 +++++++++++++++++++++++++++++++------------
 qapi/block-core.json |  16 +-
 2 files changed, 270 insertions(+), 96 deletions(-)

-- 
2.43.0


