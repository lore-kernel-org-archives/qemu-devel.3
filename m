Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 531D2C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 15:34:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjIeb-0000D0-F5; Mon, 13 Jul 2026 11:33:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wjIeO-0008UR-Q9
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 11:33:02 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wjIeK-0001A9-Fa
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 11:32:54 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-493f45e206dso16252225e9.1
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 08:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783956770; x=1784561570; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DoDTO26KrouGuDQsepvCm3zXNuI374PRo/EHI06RfAM=;
 b=GUTRxNf0LSkgm0BNhrbelE3hy0eDcTuzbSpaPLbFyYOu0E9J4Me5QTyxpUeAY155x8
 9B4E4rLut2e/pdFSH6/7zNzlp+ADgOjAFljuVv6wFEveepJLTEIUEW0Jq3Qms4wD72bu
 A6jL5rdl2Nyl7lyiLYX3B2erzdcGLrGrVSVPfZWpCc6aC2ySWTC5Ka+6cnKdgMRUPVhb
 a8zilW+ZPN9ORi9G9gLqc+CCjfNRbfQDlFQfhfdjWrDdBZnOVXERxg/2MJqof5gartb9
 3n7sT32+pKXugmG3Op9H7sK+0KDqyM8G64uz3d2IxBQEgYYx2zIIz54KRy2wL3ofr14O
 RGjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783956770; x=1784561570;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DoDTO26KrouGuDQsepvCm3zXNuI374PRo/EHI06RfAM=;
 b=ZReMQLxmAmIGbWHFbd1lJbKRQpwzKiL7GrUGlQufDK0QR7cg+JcPK8E2H81Ff1vHa0
 8Z83XhrVIko0bKDiyynTa6pVp5DVdwOCF/7vuZkMXiq+E8cdzifz2YLzu6LXwBL5kDvq
 FODXq44OXaSaMX2xf886lqD+V77Q0Dh9On9x/MTJHIGhsR2lpdy3xZGHhnwnuMljoU0b
 0AoXBm6zNEnoURME8NmrNm/qGrwSpnNmrlQv/psq5yx3Ue7AmQv4/ojxyrn6b5P27s/W
 XNFAWawLMPYlFqDiKZwLdu/xukR6BzccpSu6iPUADfKg9PShhbi4JV8hWRRcG8fKjPN2
 VSSQ==
X-Gm-Message-State: AOJu0YxYV8qBkBppywbZ6x5kVS1B6vK2R9HGjwwTHG4EocYJxqANOCbf
 04b5d52H+PDL62mXspvrswuDzyZDw1TFbuxSK9HhMJeBxUZ6zmEXc6lhu31hniueWrDqTgu70co
 Ct0t2be7+5Q==
X-Gm-Gg: AfdE7clO7E2IRQZo3wDKabgiyk7ObNvj+vPaw5MLXpZLnJZWuViPIFMwkLUZw7zHTaE
 9uYocOq9fRZ4uRBvEZUZgpbokrRRZWfUDQ5D8zVkIMA1cPLf4xYhhTkS/sCyo276y1sfdqa5ZHH
 GR8M8cESA5/u5U1lu0PD5Bez7A6jRyN2nWF5qJ89zsLjMdZGZwkFswrV3CkvpWIihHutGf4OU6b
 ntlTV10+cNmytAtHuSj+tVebu5TwMT9O0jmmNj2D5cpKZd1d2224qQS9ZKZeMeHQGNHcfMwkMgT
 a3s1rBkY+cW8A6thqp5tmTottTZlieuAUrMhjlZzZJaUXiWPbGCqeRUI4W7WQ22UxudUqQTeDCB
 HKxVxWRAE36ZHn2NZfhmpFp8Jm2noESOho4hkkLK90q0ywv8HIwbkMCS2wykR1BruRtU+y6xHvz
 nEzTo4jfXSIBK7e+tx3IN08mp5SJfeemChjiyf7ejFibMi2UAwyY3aBnEhyp8n+wQV4OL9vz3R8
 bVhbbx4p2m2Gdpx1aXbRg==
X-Received: by 2002:a05:600c:8b53:b0:493:f13c:9c03 with SMTP id
 5b1f17b1804b1-493f88dc201mr91004205e9.19.1783956769912; 
 Mon, 13 Jul 2026 08:32:49 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49508727f7dsm3825985e9.4.2026.07.13.08.32.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 08:32:49 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 16/26] docs/system: add FEAT_HAF
Date: Mon, 13 Jul 2026 16:32:23 +0100
Message-ID: <20260713153233.3391818-17-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260713153233.3391818-1-peter.maydell@linaro.org>
References: <20260713153233.3391818-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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

From: Alex Bennée <alex.bennee@linaro.org>

This is a subset of FEAT_HAFDBS which we have already implemented.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260708145841.3032079-9-alex.bennee@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/emulation.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 903a5f90880..9930974a501 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -95,6 +95,7 @@ the following architecture extensions:
 - FEAT_FlagM2 (Enhancements to flag manipulation instructions)
 - FEAT_GCS (Guarded Control Stack Extension)
 - FEAT_GTG (Guest translation granule size)
+- FEAT_HAF (Hardware management of the Access flag)
 - FEAT_HAFDBS (Hardware management of the access flag and dirty bit state)
 - FEAT_HBC (Hinted conditional branches)
 - FEAT_HCX (Support for the HCRX_EL2 register)
-- 
2.43.0


