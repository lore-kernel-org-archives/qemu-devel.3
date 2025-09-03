Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA044CA1009
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 07:58:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utiNM-0006hB-R4; Wed, 03 Sep 2025 03:57:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1utiNE-0006f5-NL
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 03:57:45 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1utiNC-0005MG-TB
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 03:57:44 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3d3ff4a4d6fso2343047f8f.0
 for <qemu-devel@nongnu.org>; Wed, 03 Sep 2025 00:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1756886259; x=1757491059; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xoqiRCIeftqYRC3cyuGguhcU16uTZEpaLr0NStN9JC0=;
 b=Ak39iWYTQsvWXasSqU4yAP1IPehkpB1fpp7PgrUzwNYQzAOor+7io8tI/tCzyc6/it
 fcDsNX+Tanr0kwTrDnoZ49ETPTnlJvMnLKfYHijyzizsGVil5S03d2fLUqRDmQL1uwgc
 6gLxrF3LnCY5b0uxHuxqRAXUhRc5zy66BdZ43DWsyAxz5JX00lVldpi4+p5A64KwkHuC
 HXK8Mh2ztmNqT+lNx2HTKk17y7JNaHP4RmHcYjNjukMi3n33G7aRgV3mxr5EGfO3T9pL
 C/V4XX0hdrrMDFyAFbOVsLyqx/ehQ8XSSsEvnl+UM9gDNnwvVnOXlNcnAJJHkV7AAZ1X
 pXiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756886259; x=1757491059;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xoqiRCIeftqYRC3cyuGguhcU16uTZEpaLr0NStN9JC0=;
 b=SiFpL7g3Nu8w5SvxeEUtR1iv1gmKVdgJRc2NtAx6H6UAKbna2TVBzlbZ0kwlsE7U4n
 nfddKqGyuT6m0kWNmQ7POLJZlaYjFDdeyHV4dISrX+gOsaU0y27nQxL0DggWxrfSgxXL
 VuX12GC/aAkPLO0vDTNfEKarXwoj0eTxzf71Mqrkew/yH0iSg+YggzyMr+HUUOYm9fRv
 PpvOR9ufU96b5IvnWKbDyn4m/XD6ZXevrLcBcfLOlAdxbxtJQ70RAQcVLShKle09T2g1
 MyohG0k62FRTg3DdRyh91l4hzHdhYpuFP0i5VkjdX8dbIQDHV84lM9y45wUBKRDy/qgl
 8BTw==
X-Gm-Message-State: AOJu0YzMO1BzWXMz+yt+52b+gGSyvPVPw0tzRbRAZfoyxmPNrqDjjcB2
 f9hjy+OuvOYd39wwNFn+fgrc9iUmr/2dzTIvo3kehK3hhxtc6924Jw2C5bvTSffd/XAGu8lNHq7
 Da88=
X-Gm-Gg: ASbGncvmgEMzh6ibuzEV0PzwzCHa/ZfX35l8mzT6+mIMd/ez2P8D0PQAHPkG0CBz0PJ
 Lc7m7nkKfIqRMui9Z4+V5CvvZqckdTDMZORuxMw+fcCJvyAhaXZfLWczeAch2R6rSqIW7fkaY2Y
 pQoVjDjbi8P1MTjwUFnnwhnYk2dRvyHLjcY1VfO493LjcFp3Jtt65Ogb2wejHW4dRV8uh3NohkC
 9LVb77IbTm4hwud53l9z64F34CK2oAXqk4RoFS0QTZtVNPxEcoMH1h46DZT6csXSu0h8ivCU5rn
 5hFWllkCHhBiT04yW6zZHt2Hp0ElTqBs4hYfao5Di0LOOivpYaZZ1VzoOsOWNzusOC8Jm9gtvwc
 EO9DPnp/epitRKnlrOK4gFBsfSD98Zgo2TqlnICAw6g==
X-Google-Smtp-Source: AGHT+IE4FDHFOKmrUgpMAO89HbxbExKy2f4D/xkHu7a+9vfHB1ihm0dAZfigSiuRUZ3QXMbOtDfk0w==
X-Received: by 2002:a05:6000:230f:b0:3dc:eb5:501e with SMTP id
 ffacd0b85a97d-3dc0eb5534cmr1650296f8f.18.1756886259569; 
 Wed, 03 Sep 2025 00:57:39 -0700 (PDT)
Received: from chigot-Dell.home ([2a01:cb15:80db:7c00:8880:8b9d:ac82:8ac6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b7e7d2393sm227923335e9.3.2025.09.03.00.57.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Sep 2025 00:57:39 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, qemu-block@nongnu.org,
 =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>
Subject: [PATCH 0/5] block/vvfat: introduce "size" option
Date: Wed,  3 Sep 2025 09:57:16 +0200
Message-Id: <20250903075721.77623-1-chigot@adacore.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=chigot@adacore.com; helo=mail-wr1-x42b.google.com
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

The main goal of this series is to introduce a new option "size" within
the vvfat backend (patch 5). It allows more control over SD cards' size.
The value for "Number of Heads" and "Sectors per track" are based on SD
specifications Part 2.

This series also includes minor patches:
 - patch 1 introduces another option to remove the Master Boot Record
   (this is mandatory for QNX)
 - patch 2-4 are minor improvements easing the introducing of "size"
   option

This was tested on with a aarch64-linux kernel taken from
functional/aarch64/test-virt and on aarch64-qnx over raspi4b with a
workaround, not included here (the SD bus must be associated to the EMMC2
port instead of through GPIOs).

Clément Chigot (5):
  vvfat: introduce no-mbr option
  vvfat: move fat_type check prior to size setup
  vvfat: add a define for SECTOR_SIZE
  vvfat: move size parameters within driver structure
  vvfat: add support for "size" options

 block/vvfat.c | 279 ++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 213 insertions(+), 66 deletions(-)

-- 
2.34.1


