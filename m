Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0C64C9830D
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 21:10:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9UEE-0004Em-9Q; Wed, 23 Sep 2026 17:10:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1x9UDs-00047z-Sk
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 17:09:50 -0400
Received: from mail-vs2-x10.google.com ([2a00:1450:4864:3a::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1x9UDq-0008QI-Sd
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 17:09:48 -0400
Received: by mail-vs2-x10.google.com with SMTP id
 71dfb90a1353d-5c67e5292faso666055e0c.1
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 14:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790197785; x=1790802585; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0HK/pzye7cm5UNEMVr3LbdqBrxj/0smXUGHcXB1oZ6w=;
 b=IQ5sS9fIbeno4UXAw+O9XzRRexgg1DurA/UtRCHM3/Hif0Crhv3jIQGZlEyCMDHhKO
 KJq+3KNgDuVVWeNqiv91qORtqjrqQeuPowXqfejSONsWfIuZ5DxN7+bHv+5QwVufNxeQ
 oSNnjSRyogW/1u9X54JQTFkhPP2iMNy9OD5YmGwJcKwqWINHXZ/Zy2Di/Wb2pZ8zWA77
 VQc9uJ4yGF78jxaLDprtnGLi4sXRnfbcgLYSsBk/nWv84GEhuoB7LZZqqkGyPBV33HsU
 qRJ71A5wBK9yynT0FshnoZRqH+tEdJ8s+QZ58UaXVokDmijAajYGkpG39XAnegv7aufB
 A4TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790197785; x=1790802585;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=0HK/pzye7cm5UNEMVr3LbdqBrxj/0smXUGHcXB1oZ6w=;
 b=UfYY49IfGmpsFniBbXBIhgmoW7ZZLci5uGcPuuq1jJkkG3zKo4ejEVtAOzLLNIszW1
 wnPr+8jCz32cL+lt+oHiTgKvkVbjimA9dvwqGJufvQCf6OzrPd5NxV26O4XXjUrXveMa
 TA+M6bQ4jRCrZjzL1EYQ8izS6oj7rKQuGHD99OWvlNw9XfPSXw1gmz25qRabn1xdXZ9Q
 utT2yMYIh8AJ3UHCmn9wluJjLNDty4FO+p6yJ8EjsqXD0p5FobdiTfZMzwmU/a/1txKb
 luTrsSvpBKPwpfh87Gf7r6w6nfgW8FFub1Dd1DS1LyQcpFRxZ3MDjaYKsCjGcRvo++ZY
 U+sQ==
X-Gm-Message-State: AFuF++n+kCEh+1d9gyFMaplZvzcX9qAZYMXVRxjBF4bzhWYsSmH7/xu+
 gcGqcFgeod3Rc0TWxiaHNNB2yyoY8iMFhVR4BqohcKcZqcWJumpTHLGydEOH1YGe/S0=
X-Gm-Gg: AYBFou2ajh1eE356yyjKvMGVDJGafC7vl34IXz4TUxQfoMfJApnBaCuuJHhNfWvLY9U
 YVMDj6rs9Fjj7DOIMofhXvbDRu17eKTcR8NyzjIlbns9kbIrBxNoJ9TB2n3IEUQTOlc9QL3Luvv
 0wOZG9hBK9ApM2Kb7o6wB4qRXtEDhnDgNOnC53Xw1y5lVAgo0JjVSMUsSxKGXi6NdNFrzMphrju
 bzmbeZRyxnQZ80/QxqrRFj7t/aVVKTb5PGCbNe/6Sr9ZjGfb/utITbeVvbsi2ZKPrmKx4hujsbt
 LOWuKpfEAMcSwHmZ2raEC9qnx7ZD0lTIqUXK348ccC06mhzRpdih/e697Z00fFNLW+gThuCRGKv
 K2ITyJoHKoPYXi49u98uxHLxprq1KcIy80Wteg0Ur0aUMSxg+lypG/290+k2D1gnykOVuhWWFMI
 Oyjn5deqZQcDEq2PpG8Dp4aoCkuUMV4RpEj2kj61nvzpltB4yFo4xo70iZ8uH4UErJO43+sC4O+
 T9TgSctCnG4EFTGVPVNWIyd0JDM2fX+qgJ6U/A=
X-Received: by 2002:a05:6102:358d:b0:7a1:f7d2:e830 with SMTP id
 ada2fe7eead31-7af1bf7e167mr429808137.16.1790197785116; 
 Wed, 23 Sep 2026 14:09:45 -0700 (PDT)
Received: from localhost.localdomain ([2606:6d00:159:2900:8d8d:5fed:813e:d8db])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5c9f04c05b3sm4859413e0c.6.2026.09.23.14.09.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 23 Sep 2026 14:09:44 -0700 (PDT)
From: Marcelo Manzo <marcelomanzo@gmail.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Jason Wang <jasowangio@gmail.com>
Subject: Re: [PATCH v2 00/19] hw/arm/raspi4b: working PCIe and GENET (real
 networking)
Date: Wed, 23 Sep 2026 17:09:43 -0400
Message-ID: <20260923210943.52812-1-marcelomanzo@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260811143557.7862-1-marcelomanzo@gmail.com>
References: <20260811143557.7862-1-marcelomanzo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:3a::10;
 envelope-from=marcelomanzo@gmail.com; helo=mail-vs2-x10.google.com
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

Hi Peter, Philippe, Jason,

Gentle ping on this series -- it's been about six weeks since v2 with
no review yet. As a reminder, this folds the two follow-up bugfixes
(PCI enumeration, GENET per-ring DMA status) directly into the
patches that introduce the affected code, per Peter's review of the
earlier standalone series.

Still green as of today: checkpatch clean, builds standalone from a
clean worktree, and the full functional test suite passes.

No rush if it's just queue depth -- just didn't want it to fall off
the radar. Happy to rebase if anything's gone stale in the meantime.

thanks,
Marcelo

