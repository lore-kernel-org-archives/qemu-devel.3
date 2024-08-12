Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C7ABC52D7C
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2024 14:44:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdWGl-0004gN-Rb; Mon, 12 Aug 2024 10:43:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sdWGj-0004az-L1; Mon, 12 Aug 2024 10:43:33 -0400
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sdWGi-0001O4-0U; Mon, 12 Aug 2024 10:43:33 -0400
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-52f024f468bso5171889e87.1; 
 Mon, 12 Aug 2024 07:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723473808; x=1724078608; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aE4+bm/WlAJwN7K37bybt8OEBMbcZEQbXCjQ/C6PfO0=;
 b=BMJveVTqpZFMc7tFghYHam8BGs1ELKrTOn5XDrWx+Zqy5k1hw+TaQkEHcpmzVMrFlc
 CiAY3YyZdRt4m56BT8a2O+oxI6M6/nKsLndQ+S0bJiLoKlWBxQ1QE81ASSfvrsAVercF
 Wr3KaoXzkjtkESsxssJZBx8pbiDQIcc6nPEhWJhXH47wSpMd7QM5AEDoqVldTOkE8G0l
 GnR2YZlyLCyARr+fKq5l1YnKkRkYnQ5I960nzb3BT7cxkAS5YP/OnxqJjSjuvgmaMRd4
 BJHvkyy6BqYh9UKNegHkNswVEmRQyHhRvgpY1UuqscPFBLPdVJQc745hVvy9OFyiJXps
 oO5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723473808; x=1724078608;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aE4+bm/WlAJwN7K37bybt8OEBMbcZEQbXCjQ/C6PfO0=;
 b=aa51mtEdEJfemyn6ZtTrBlHzkK8iDm1fqSXUczEZHepvlTQqi1geKCMk757msvpwYz
 XO884/X/RBKCh2ijRut0tGFNRXfoR2Ofrg2WAFSCwctH8YIpwtAUhS6ZJ2vhhgE/5hyQ
 ovIWqQVkWjUEuATIlRU90w3FOZw71/gLDX1uQh7okGD5YkOM0dEaK9fhAbROJmdNj3Id
 bMlktfrPDfVojaZ9gTsjoQzsfSijBjHr7rWsOjZ0FZHT6wdFWVwgug3oWY2sv1vuGIth
 CnV6Pfh/qBpcir2KNytNlRcHmCymAoJ3AmtNDMo6DhnkF3DePsmWUOI5X8QwzJ8MYU0E
 0Leg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX7Nj2pO304fySKK12MzD39lMqr5KpOz1h9a0xvcfTz0ymteHjG+RY/8ZVf2ck77XDlLFJcQsDawkyYXZf33+mxtPZQznU=
X-Gm-Message-State: AOJu0YxhW7HkvABl/jSaCnqEZdeVJZtayMGL+ZP0O0WrgBxyls7UfD9F
 6ga+tyhoTPOOY+EOhYamQLwJ3uAwYyWJt8z/9xK1+NyTZgpA5Kp1nQz3o0QH
X-Google-Smtp-Source: AGHT+IFBVXPG5a3J8X9bFIba0ol4U7iEe+ReKmQ8hWkrIlU48DzNPL4um1hq5nWbnv27hylKhDab3A==
X-Received: by 2002:a05:6512:3e1e:b0:530:aa82:a4fc with SMTP id
 2adb3069b0e04-53213692694mr281510e87.37.1723473807986; 
 Mon, 12 Aug 2024 07:43:27 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-53200f1b2c0sm754299e87.212.2024.08.12.07.43.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Aug 2024 07:43:27 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, edgar.iglesias@amd.com,
 qemu-block@nongnu.org
Subject: [PATCH v1 1/1] block/file-posix: Avoid maybe-uninitialized warning
Date: Mon, 12 Aug 2024 16:43:23 +0200
Message-ID: <20240812144324.116343-2-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240812144324.116343-1-edgar.iglesias@gmail.com>
References: <20240812144324.116343-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x130.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Avoid a maybe-uninitialized warning in raw_refresh_zoned_limits()
by initializing zoned.

With GCC 14.1.0:
In function ‘raw_refresh_zoned_limits’,
    inlined from ‘raw_refresh_limits’ at ../qemu/block/file-posix.c:1522:5:
../qemu/block/file-posix.c:1405:17: error: ‘zoned’ may be used uninitialized [-Werror=maybe-uninitialized]
 1405 |     if (ret < 0 || zoned == BLK_Z_NONE) {
      |         ~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~
../qemu/block/file-posix.c:1401:20: note: ‘zoned’ was declared here
 1401 |     BlockZoneModel zoned;
      |                    ^~~~~
cc1: all warnings being treated as errors

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
---
 block/file-posix.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index ff928b5e85..90fa54352c 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -1398,7 +1398,7 @@ static void raw_refresh_zoned_limits(BlockDriverState *bs, struct stat *st,
                                      Error **errp)
 {
     BDRVRawState *s = bs->opaque;
-    BlockZoneModel zoned;
+    BlockZoneModel zoned = BLK_Z_NONE;
     int ret;
 
     ret = get_sysfs_zoned_model(st, &zoned);
-- 
2.43.0


