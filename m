Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D748C54E49
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 11:58:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfIZA-0006Ap-Gk; Wed, 28 Feb 2024 06:57:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rfIZ6-00069o-C5
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 06:57:36 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rfIYr-0005oJ-Hz
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 06:57:36 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-33aeb088324so3402905f8f.2
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 03:57:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709121440; x=1709726240; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Onyf0n7PQDnbuNd7HujOMaHnjKe5rcDTFcPdFWfXURM=;
 b=pG4BuZ/Bj1149mqlfTGDl2fS7v6f+3RtH3bKu/cB6TEiyz6enByafnkIz1Sfgy/IPj
 /d0j42l3v9FwN3om+ZBydejv19kn9T42G7EGF2rQOf7VvOprBjWOeJOniYbVLNhErIVl
 DJO60CyDiumWxO2ojFq0clP4yeAWT6uRi5tOXer2E7gL80b6VdWEcEWALG8QrC/Da3YP
 zVW64mDBK6vlsE32Yk9DVtWuuHw1KWsRzZM3wWgfAcjcy12SrZsOXzycHHzXCtP3aJL6
 T/YTUtoygoCQDBRxKaXoHV3lXfqO8b6OmepPefrGU/MRlgH2RtpjEoLH/AWKzv6h/eAn
 WkcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709121440; x=1709726240;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Onyf0n7PQDnbuNd7HujOMaHnjKe5rcDTFcPdFWfXURM=;
 b=iX3r+DKgSYgDyx9s6NP4P/TRcdV36zQoDSdzKj42LycfTNaw7QtApD7zO6nKLzVp3K
 VRk89ziDqF0dhHzIJrnrmmIPfytpPCNrmtdryCJPKkGrhLxodvg/lmA+mgg6cVZ3Bu3k
 bhQJMrYFcZfjkM6vECxrbiOFx1y3mitHKZqCqBjyuVnr+FE8dyfGu6giuMPCoiv+9+yG
 Bw3uq4t6rO0h0cmVE70lqFqZhblk7Hkp1V5JK6IuOLsSVSLd7lhOJvFfpk3zc9THzXyL
 sdbARr2nVkybNHViBUuyeU295DRL9Kj8toK6IF/eiayCaFARX9Zc+2qW+76XgfUqItSm
 KRTQ==
X-Gm-Message-State: AOJu0YxddWMe2m6aQgREiGXD/cJNarVDUWirIAYQ7oh1lkCnS8xcLO+W
 8QS8PVm7tpT24RmfyKSRyv9KeVIHDfdElmt6AmZ83l0CKU1wVPelte5rAJVHGqQ=
X-Google-Smtp-Source: AGHT+IGqQwyo39CO/xsxgDd9/ny7RY8YUGxFJUavJ7ojzTVqrVTU0MmiDYdxOqWP6s3pnLthV/golg==
X-Received: by 2002:a5d:4392:0:b0:33b:8050:291f with SMTP id
 i18-20020a5d4392000000b0033b8050291fmr8383359wrq.32.1709121439915; 
 Wed, 28 Feb 2024 03:57:19 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 b3-20020a5d4b83000000b0033df1f1dabcsm4516862wrt.90.2024.02.28.03.57.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Feb 2024 03:57:16 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 4FD285F92C;
 Wed, 28 Feb 2024 11:57:04 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 25/29] contrib/plugins: fix imatch
Date: Wed, 28 Feb 2024 11:56:57 +0000
Message-Id: <20240228115701.1416107-26-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240228115701.1416107-1-alex.bennee@linaro.org>
References: <20240228115701.1416107-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

We can't directly save the ephemeral imatch from argv as that memory
will get recycled.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240227144335.1196131-26-alex.bennee@linaro.org>

diff --git a/contrib/plugins/execlog.c b/contrib/plugins/execlog.c
index 82dc2f584e2..f262e5555eb 100644
--- a/contrib/plugins/execlog.c
+++ b/contrib/plugins/execlog.c
@@ -199,7 +199,7 @@ static void parse_insn_match(char *match)
     if (!imatches) {
         imatches = g_ptr_array_new();
     }
-    g_ptr_array_add(imatches, match);
+    g_ptr_array_add(imatches, g_strdup(match));
 }
 
 static void parse_vaddr_match(char *match)
-- 
2.39.2


