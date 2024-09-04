Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1411DCD4853
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 16:16:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slsfp-0001Ek-43; Wed, 04 Sep 2024 12:16:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1slsfb-0001C4-Lh
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 12:15:50 -0400
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1slsfY-0002G8-Kc
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 12:15:47 -0400
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-53560b2b444so885831e87.1
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2024 09:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725466542; x=1726071342; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0FTAVDz3Cw1uxIbhjmeqEYJqdjw34VbylOmDWLTwvx4=;
 b=NXweBCCdnFU7LLdDAQGUfdqd2uTv52ZlVtS3uh+OudzTtYh+7XCCyyMHY77Zy6+DNO
 AjTcOC9x/Yb0k8P0dkLEvhI84YY+8xjX8bLUM3ZCp7xbQqXKIMWgmyzxilY8TQwH/0PX
 +2ZpqqdpgfspqCHoUzBuNuC9Dhqgl70HpNJfpRvIXSmeRZUR4Z5fyqELMK6JhU1yv+6g
 lwmZHubkW0NykN6lcNt7/VET4h27CG4uB1ZY/tEuVYUT0Q0allqPNSQr+kTu45vRqL+w
 qnvGEVCRYfaiNgvtkP6cjKjjp0urPNhc+DDi/elypbSvqQxiq1o/6n1CAIFrw3K0llmP
 5dvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725466542; x=1726071342;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0FTAVDz3Cw1uxIbhjmeqEYJqdjw34VbylOmDWLTwvx4=;
 b=FxFWBCLyMcAsYqpJjb36Cr042GXl3LlMSYmNZ5bjs87yHeUZ0229YO8VRm1Xw7OgPb
 giqqMiI/8iBQcIITdHHCiXdPnJ1J9IgenfvCIr6C5i6FzVTROmWPhC2YMGILQlhIVpCS
 9iYHwmGN/GRedVeyahyfSwQDQqkGP83o5uqSTC8pKpsMW7I+158FlPdIYE5pjLDWxNEU
 PpqmVrB4Gepzfj+yuzIZervkc3tn2fbs2zrWXMVjpHb8CYD/Urv8HX7BoIn1OAlXJ7gk
 /v8//8bMTiLnyoFLtrndfLL+KiW2Elc6mR2On8r/i6FboglmHdph/Jmc4YK0bbjlIPY4
 ftag==
X-Gm-Message-State: AOJu0YxfdAmUEt1EL0+dChOZDoWVrjBR2EzQatdr3zJxIQsWe1+zEigH
 CDVBGFiqxcm4TcEts0FDgjg5kheuKhPQvKnSJVvPh6sg4R/+tAFnxJCcs9V+
X-Google-Smtp-Source: AGHT+IHC0J9+zgjr7h0VEYt97jGSExgSr1FAsQqqdgyp0zbhmgvQIcgxO+eUjmYELzyzyL1eJMTb6Q==
X-Received: by 2002:a05:6512:4004:b0:52f:336:e846 with SMTP id
 2adb3069b0e04-53567790120mr922274e87.14.1725466541521; 
 Wed, 04 Sep 2024 09:15:41 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5356827b716sm205130e87.240.2024.09.04.09.15.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2024 09:15:41 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Cc: sstabellini@kernel.org, anthony@xenproject.org, paul@xen.org,
 peter.maydell@linaro.org, alex.bennee@linaro.org, xenia.ragiadakou@amd.com,
 jason.andryuk@amd.com, edgar.iglesias@amd.com,
 xen-devel@lists.xenproject.org
Subject: [PULL v1 01/12] MAINTAINERS: Add docs/system/arm/xenpvh.rst
Date: Wed,  4 Sep 2024 18:15:25 +0200
Message-ID: <20240904161537.664189-2-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240904161537.664189-1-edgar.iglesias@gmail.com>
References: <20240904161537.664189-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x12c.google.com
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

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Acked-by: Stefano Stabellini <sstabellini@kernel.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3584d6a6c6..c2fb0c2f42 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -559,6 +559,7 @@ F: include/hw/xen/
 F: include/sysemu/xen.h
 F: include/sysemu/xen-mapcache.h
 F: stubs/xen-hw-stub.c
+F: docs/system/arm/xenpvh.rst
 
 Guest CPU Cores (NVMM)
 ----------------------
-- 
2.43.0


