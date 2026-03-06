Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCFC4F0182E
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 12:06:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyTwj-000133-UW; Fri, 06 Mar 2026 07:06:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyTwU-00011M-FK
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 07:06:10 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyTwP-0005Mf-Hj
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 07:06:04 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-439cd6b0aedso1656314f8f.1
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 04:05:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772798758; x=1773403558; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rx8bHQhpnL/fCk2BWrG/DjwxQeUDQZ5dItdynQ8eOM0=;
 b=nniDNIqG+TvCuIAtFkIUqDPeGOnL+JVodT+dVeTrOQnpoSfeJySZ233XNxbfbgtbr2
 x0RtVjEyWkOP7j7zsTOrPyisF04gtwjHTyA7bn5TvrezpYdoREshXZ3ZhV3mtf9JrD1B
 NR1Wmg3yMEy1/5vjUp63EAqrECOAJOQxg3O7OCKLJn1jxVbgnABl9PWym3P1llUPjRGQ
 qw11EWgjfWqj5LMmrN/kkXcWYNzohvZKQCHiTsambwhYhhhr7iUlHQM6DmkIugkWrOim
 lZ8x/mD4FWsnui/O88+iGdWM0D4zihDkJqgEjW1F9dojjZkg2TzW3BKJ74QtAMuVjHGs
 3vkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772798758; x=1773403558;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=rx8bHQhpnL/fCk2BWrG/DjwxQeUDQZ5dItdynQ8eOM0=;
 b=AJqzOpNkfNwd5wDHTMk1UeUMFV09fEzXM1qDUAenaTZDct1v0iLO51pPGtsPtVBwt8
 Q8VbcowE0H//Cf8qHzgnkATqxmJkkBywlIG/qlL5vGtJjOMaYq+Ho/nj9RNn6oausmHQ
 EYz/cPxI/QSXk7VBPno+mgs9jNn78y39hjqZ57U+R9EH5KXfJwl+POn9Zzfr7lH3yWzf
 6vuMa6RtkmFakj3Vw1u3VFOj3niZJZX135RsJlgRZHnTDtv9B/EsmnYn652a6ZAb03LO
 ORphigBtHuCmMu216MTWD5mQf46gmIiqXNBkBVJWZuB8rFrb8/SLAPuIiPKwWY4g9Ecb
 yw5w==
X-Gm-Message-State: AOJu0Yytv2WONzEOHSYd16J771rkv5C7AQ9AV/WcFGp4NSCFs4xMZlY/
 x/5Yufsdd9/zsvCn+KEekcKNErCPBExGWQXXZ7+NuE+Q3OK6aXO4qLEmT5niXFhsASQOEi98r+U
 Yu2M4
X-Gm-Gg: ATEYQzxsoBFIW++Iya1zf9zQazuBPzjKiWssyz0FmqDgCcT8YCH2qJcqIoaWeWopWmk
 IgQL3U66WOoFkim352sP/GR+DI0p79vWaiwXv2/5VsjPs5N5SfNNHmiw78NWBREZ6HvGxXd47VN
 mFddT1VNvYoVgrOF4PUQX2d9FUfKFbndyiYPX2CXr8T4t4ZUdfSvdKXLQksbEhN9sMNgQP88aRt
 VkE0onWxgPMVXqf4X1wB8/RGNwZjaJyak4nEcyzxGgBX1VzYwZwFhArDxjs+RSGmHRJjXhbDXR/
 D9Jp/r3A1ojZClxp7ayEbn4aY1yISv6m+Kpx/s04vdOEZxmH7dw+afN4/BT++JuiGDp4Ka+PTkW
 RZIg2UQ5LxduUbrNwsmCmcFz67PnFbpG9kk05SsQ5U/La3tMH3zkxn2L5ve1wq2prmXZlTDzmws
 8eNIGCS2PymtjcktBt72ANORTSHVnRynwRVaCVIqd+RHBPCKktz05FX3ik3idD3UBhP5twjdPiq
 0UMwvObsOgnblh4q8zxDPqWkrsqg1g=
X-Received: by 2002:a05:600c:4752:b0:480:4a8f:2d5c with SMTP id
 5b1f17b1804b1-4852697721cmr29250645e9.29.1772798758118; 
 Fri, 06 Mar 2026 04:05:58 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48527681e2bsm32841945e9.5.2026.03.06.04.05.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 04:05:57 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/6] MAINTAINERS: Remove Hannes Reinecke
Date: Fri,  6 Mar 2026 12:05:50 +0000
Message-ID: <20260306120555.2035421-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306120555.2035421-1-peter.maydell@linaro.org>
References: <20260306120555.2035421-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x435.google.com
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

Hannes Reinecke doesn't wish to be listed in MAINTAINERS any more;
remove his email from the relevant sections.

As 'megasas' no longer has any listed maintainers, move it to
"Orphan" status.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6698e5ff69..75fd16695e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2645,9 +2645,8 @@ F: include/block/ufs.h
 F: tests/qtest/ufs-test.c
 
 megasas
-M: Hannes Reinecke <hare@suse.com>
 L: qemu-block@nongnu.org
-S: Supported
+S: Orphan
 F: hw/scsi/megasas.c
 F: hw/scsi/mfi.h
 F: tests/qtest/megasas-test.c
-- 
2.43.0


