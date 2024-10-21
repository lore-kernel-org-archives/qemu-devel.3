Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3A60D0E6C2
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 07:40:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2n1T-0005Vt-2h; Mon, 21 Oct 2024 03:40:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1t2n1P-0005Vh-Hz
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 03:40:12 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1t2n1M-00078J-Il
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 03:40:11 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-539d9fffea1so3935161e87.2
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 00:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729496400; x=1730101200; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=GnVZgiNfswIw7OgFquKKUJodllKwremLFomd7GhQzKY=;
 b=dUjvgpPyR43qx6rPn1aPbN8sCmwLqDYo4ibIIbFt9kJ2ycEjS8Who/D5deqruMFFf8
 TmYsbrsxFO3W/pvgYbLmEz37C1GyS5F+JWgGpn1MSfNvPbkKaauEXSH46PncNX2qOqdG
 vhE8ClnVf4HFI379XKQrDLt/iV+kzO+UyvnS1iemqFb+XL3e/TQfwpkpP622JbEl0d7P
 S6TXQcc/dNLgQ0N0xr/WmjWNcYqQHvQT2S5H6sz4e6pdh2tWNWq8PBV6t2MeLRbdt7qp
 4VS6UvF4Fq0rImuiqelOGK7GRlocuT5N163K0/A59LQT6jZ3jc7KnGwUxKLmyRbQ7p/x
 nrSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729496400; x=1730101200;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GnVZgiNfswIw7OgFquKKUJodllKwremLFomd7GhQzKY=;
 b=tA+s/0prVjoj+rzot0wvsGGa9L8CMvFbHd7Hav7QHijBbN03P/HW61bGtffS3XGp3y
 z0Z2ZStzGufuTzfvIC70NbNhjChdp4nMn6h4jpynPz50iaHe1grp35441ZYzOfJHi53f
 8gI6FizYn6JBBD3UfvZluGKQOABxCk9rnF4lj7mtFZHbOspK0UtyrjMUicFYBHhfwYqg
 701Bn1riVbwg6ZMcohJXs2MqvSdQC+wwEDVQxyauKnbe+QFGDqzUIlMExINEOGxc8RLh
 4+268CCi1VYIH2sYfkv+mFJV+k5FuE6VF4vf2WzCbAKLFqdpPT4Z9KAHtGTs7+Qvr5YT
 nzDA==
X-Gm-Message-State: AOJu0YwCwJrI512EY8P22wTueCUmKxkzrGKjPDG9Dqd07UqeTJ0u0HTk
 J37nL3ezdxOyPvK36tfw+g69L/V88hyN1VStxyZBDCZPddYcbJ+W8j32zcY9
X-Google-Smtp-Source: AGHT+IFaCtOXhq99BOX5U08lfOxTiedEUSHJvwsz8f8iv4Hr3cpYh8DzUX4+obfzdliyy3EL8K9qlQ==
X-Received: by 2002:a05:6512:b08:b0:535:3ca5:daa with SMTP id
 2adb3069b0e04-53a1520bd21mr4456242e87.7.1729496399802; 
 Mon, 21 Oct 2024 00:39:59 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-53a224313fbsm411183e87.219.2024.10.21.00.39.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Oct 2024 00:39:59 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Cc: sstabellini@kernel.org, anthony@xenproject.org, paul@xen.org,
 peter.maydell@linaro.org, edgar.iglesias@amd.com,
 xen-devel@lists.xenproject.org
Subject: [PULL v1 0/1] Xen Queue
Date: Mon, 21 Oct 2024 09:39:56 +0200
Message-ID: <20241021073957.1851500-1-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x134.google.com
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

From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>

The following changes since commit f1dd640896ee2b50cb34328f2568aad324702954:

  Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2024-10-18 10:42:56 +0100)

are available in the Git repository at:

  https://gitlab.com/edgar.iglesias/qemu.git tags/edgar/xen-queue-2024-10-21.for-upstream

for you to fetch changes up to 676a68fd4850924db73548c9cb20ea484709708c:

  hw/xen: Avoid use of uninitialized bufioreq_evtchn (2024-10-21 07:53:21 +0200)

----------------------------------------------------------------
Edgars Xen queue.

----------------------------------------------------------------
Edgar E. Iglesias (1):
      hw/xen: Avoid use of uninitialized bufioreq_evtchn

 hw/xen/xen-hvm-common.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

-- 
2.43.0

