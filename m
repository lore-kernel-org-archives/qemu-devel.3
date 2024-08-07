Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1CF3C52D6F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 23:07:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbpju-00012D-IW; Wed, 07 Aug 2024 19:06:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sbpjs-00011f-Vs
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 19:06:41 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sbpjq-0002Wq-WA
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 19:06:40 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-7a264a24ea7so266872a12.3
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2024 16:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723071997; x=1723676797; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=PPmca8GZOh2DRlKRsEt2B1Y76Ks/t/nrpX+Hn8Stafk=;
 b=fUl1u3Nj5qqfPgI6z8LhyH1IZVxydcwSAuaIoJ8Jyhq/TEOgt9LDGPKOkOzLyjoXur
 OZGGB9hDIbYrdfJNHifsK1sJZz1ZSNBAtpKvkizoCvvG6gkB8VTbAUag/0pg0pTKrWq6
 1PadNgJed/A/ORf+/71ldyYESikgXQ7NIFkOdNqgnDCuIjjRZNcP24BKq8/Q4wKTtwPk
 Amu4WNW7gbBuJO6sB7YZbxbZ7WQMq6RlfuGFrwRXeTHTGxG7WmbPpHBQ2/aO+B/oAo4M
 bRT5yResXaXtY/SRmX8qeLRLTT+4nM/nV8H+1526jYPHdZLAheb7sUS4FhniMna05GKo
 pVJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723071997; x=1723676797;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PPmca8GZOh2DRlKRsEt2B1Y76Ks/t/nrpX+Hn8Stafk=;
 b=agXBtbumOx1t5Rnj07wOvGAXLvdlkzwZMRm9KesddB9XKMU6INBaAS+Aq3Mm41kwtc
 RImh0XzXN0oy76wjMPtojNzV/D1JTAvKqgdGjxUy0f+qcrYqHqVnA8OuFxuiaHal8ukk
 vXtOLBJlFS7ub+bO0Q7ZUVUpI6vWd/S2tRoadIbmQBEdFp1yO2TMOKa6F95gJocO95Dc
 Rh4dh/wMtZk4nlI186aSGVPkwphp3F3oHaI7ADFIdZj0yyVm3boGcBTDCdGfK0iCDu0P
 5opnI8Qq5zDw+o6yNRgCeCArDF17Ghqt98vaThJhuEckI8WjYJA2DJ7BEnCfrSDiiLtJ
 +b2Q==
X-Gm-Message-State: AOJu0YywXcQVYVe9GdIjIrvScHKvTGhw6OWGRue5a83CpUrvAtFMXkKo
 pJmc2ndxsyGBpF2CUJISkz4SDlDZWRy3UOQJAKOMcXUllkjKV7aHif97BiTvtOc56qaq15KdzAg
 uEy8=
X-Google-Smtp-Source: AGHT+IEoqo1AQMFwCmcNys2HuElSQzoidfJexCzgvBV4CedZKPKin+NPV5SAwH5EXSZDFwknhdbQWQ==
X-Received: by 2002:a17:90b:1c03:b0:2c9:8650:404 with SMTP id
 98e67ed59e1d1-2d1c347b7e4mr105274a91.30.1723071997173; 
 Wed, 07 Aug 2024 16:06:37 -0700 (PDT)
Received: from stoup.. ([203.30.4.111]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d1b3b35f4esm2123187a91.40.2024.08.07.16.06.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 16:06:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 0/1] tcg patch queue
Date: Thu,  8 Aug 2024 09:06:28 +1000
Message-ID: <20240807230629.31520-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x531.google.com
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

The following changes since commit 6d00c6f982562222adbd0613966285792125abe5:

  Merge tag 'for-upstream' of https://repo.or.cz/qemu/kevin into staging (2024-08-07 07:09:37 +1000)

are available in the Git repository at:

  https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20240808

for you to fetch changes up to 682a05280504d2fab32e16096b58d7ea068435c2:

  tcg/ppc: Sync tcg_out_test and constraints (2024-08-08 09:03:35 +1000)

----------------------------------------------------------------
tcg/ppc: Sync tcg_out_test and constraints

----------------------------------------------------------------
Richard Henderson (1):
      tcg/ppc: Sync tcg_out_test and constraints

 tcg/ppc/tcg-target.c.inc | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

