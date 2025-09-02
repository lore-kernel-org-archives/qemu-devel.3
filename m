Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F7A4CA1005
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 13:11:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utQmj-0000LU-Fb; Tue, 02 Sep 2025 09:10:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utQmY-0000JQ-U4
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 09:10:43 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utQmS-0004Pt-IF
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 09:10:42 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3cf991e8bb8so2506292f8f.2
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 06:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756818632; x=1757423432; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Tb2/5+LCxvBqSP63ES6u+Ggj4lN9YY4GICOEbEI+b+k=;
 b=lTz1E7G0dBCapB3GqCwdL2PoKlAYbrOIAYw21mhINVwQIyPgVp4PTEAlk7UPWyTCgA
 1K13elI4QwoSKD3ESUWIaE0k91hV3UalMdFxGwAYJxYyWgb0Eke9/aEATw8RBVd3fSxf
 PHARqxo2HIbz9m59F3C5YNxbrB3GJHQeYsxS5xe0b7S8rS2J71gZPDqO4oKaG+x5sd2f
 bPVDt5UbsjLstNbj9QgXb0YOtdvYypzILGBUwI4VqWFCQpWldrzGCE2ltTUimmfHNsVS
 c5We8KCar4PSrde7JpoXL3SkHTG/SgXyShFeq35Ds4aAQaVs70mRVZsOKiMfTz1Wxf1Y
 STRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756818632; x=1757423432;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Tb2/5+LCxvBqSP63ES6u+Ggj4lN9YY4GICOEbEI+b+k=;
 b=s53Hk7YG3UBqGAZnsyWzBPa0pqZ4r13OExuayQ5pzPpGQNDsT+XJwjIuK4TO8gDF66
 E0OvWG7D8DIPzaLGOVvbenaoqRFfmAiXjPLPxZ7vEIhQHkeGWKALAhStGr1s2luaaAaK
 QdC9cw0hloabnDlIKJI4+wqXez2up2u/MQNmUtNWnCwO9BIlDQTU/2t5rjRisLSssrU3
 U6Ued2HJyNsDXxSycRPc6hhFzXb4xKkM4PE4aJWjOTM6+egdKcY2FbHpBmDyY9mmvQ2q
 198xSvwwrUSZqBb9iyFSKyHnvup7zD3nhke7wec42fpub+akx3ezYhP4KfW3z2RD2kUo
 OgSA==
X-Gm-Message-State: AOJu0YyfSBZ1tfTeemU29M4w1nx9TbVAmXjSvSAj8yenPg3m8Gp7GuU4
 9MN5Pg7CgzKZlmAb89/HQHYepIU20Gsnca0uX93rFXRqU02BQcyrYHxb88iN9YEd3ep20CmP04T
 hPphW
X-Gm-Gg: ASbGncufkcF2k+Vawz2Py4waUqjsAgQGoCIbN4fa37cWlxbY0uENh5pnUVZIS76w46i
 xLrGIVFVZE3dTmZX/YMI5lbUf5Mr/yl3EW+dfiejmRYkhY7I4fUazRWNEUVDlcg5qFyPkMR5Zas
 kBsuuNwqu/2mSf9oFKW6bpnZchggL1+rWAsgzsDq0NVVCwnJYk1lE5vTsgSQUE4NP/AaD1FBbWE
 BFgMJKCNK5UkroTnECiXNNgDfpnFlTcLEavWmqyJy4iOG+v70/31h77EDP3QA0kY/lPdsYJ7Ddn
 LW3FZM2jwkMbxIcf4aEnmpHR5StMmL0KFhhyP2ju7yTYRU6Yh3WDR4U1VK4tiIRqb4haq+uzM7E
 riOKP1prcuVuy7DsJSOIbLiBz012uBDMbG21chLjMTNAl6UMUh3FWOiJq8m4qFXgCrMPBVvId95
 KxwIdDyjiG3dxslKTInA==
X-Google-Smtp-Source: AGHT+IHzmLKJHkB4T6O31BUkE6jfAJJRjC1RwVf7YDW4MHQinrUy4d4icK7S3gTdLbTuSSMjKHQcfQ==
X-Received: by 2002:a05:6000:4305:b0:3d8:9bf9:7c0e with SMTP id
 ffacd0b85a97d-3d89bf9819fmr3243358f8f.37.1756818631889; 
 Tue, 02 Sep 2025 06:10:31 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3cf33fba9fbsm19714372f8f.50.2025.09.02.06.10.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Sep 2025 06:10:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/39] docs/devel/style: Mention alloca() family API is
 forbidden
Date: Tue,  2 Sep 2025 15:09:40 +0200
Message-ID: <20250902131016.84968-4-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250902131016.84968-1-philmd@linaro.org>
References: <20250902131016.84968-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

Suggested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Message-Id: <20250901132626.28639-4-philmd@linaro.org>
---
 docs/devel/style.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/docs/devel/style.rst b/docs/devel/style.rst
index d025933808e..941fe14bfd4 100644
--- a/docs/devel/style.rst
+++ b/docs/devel/style.rst
@@ -446,8 +446,8 @@ Low level memory management
 ===========================
 
 Use of the ``malloc/free/realloc/calloc/valloc/memalign/posix_memalign``
-APIs is not allowed in the QEMU codebase. Instead of these routines,
-use the GLib memory allocation routines
+or ``alloca/g_alloca/g_newa/g_newa0`` APIs is not allowed in the QEMU codebase.
+Instead of these routines, use the GLib memory allocation routines
 ``g_malloc/g_malloc0/g_new/g_new0/g_realloc/g_free``
 or QEMU's ``qemu_memalign/qemu_blockalign/qemu_vfree`` APIs.
 
-- 
2.51.0


