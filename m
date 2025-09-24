Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CA35CAC5A5
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 19:09:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1UnF-0007oQ-48; Wed, 24 Sep 2025 15:04:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1Ult-0006ux-Ss
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 15:03:25 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1Ujr-0007nq-KO
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 15:03:17 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-77f343231fcso110891b3a.3
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 12:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758740471; x=1759345271; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KNbTOxBm3YqBctSYJsKq4uJkVqqLqDpR5gssxBaoGRE=;
 b=BX2+yoEGrGbQyvCpm4EYCoFIQGipKz7sfB0iiBzZL9a1iCMH1cLWzfR0T714v76Cn7
 tzOASI0jYO6UNNViw6bQo6Spi30WzN8TKc7v35Q3uDUpdOhVmMOHXO6qVoV2ScQ/kqB4
 gZBcARTuZbK6gXx0KijAoQvmaRyo+9o7QVTAT9LuwqnBWsscYaYfddS6QHrGdaPuE811
 7ZHTo8pAjC+ZCPz84godPYppB09NZiIbLXoU5ZKR5kjivbDWrxNsaMf/F2+epCaUJ2mm
 R0JjITovkHDi3RJNCyMiXYl4Y4+um90Jz4hJt93mz8C0/Hombn31F0reSHoAYbcPE4J1
 u6Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758740471; x=1759345271;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KNbTOxBm3YqBctSYJsKq4uJkVqqLqDpR5gssxBaoGRE=;
 b=gmVyuNbcdPZdd/MuXFHgJqwRaeKzZxh1OOv+/aA4jfIUKgHLiIl3nYlT6WkS09jZWn
 Rd8+Oji5rtW+bBdTdHcgpiFvIIWwYwLvTgF6riQw0h6NiljhVZ4hZ2w5XBn7bssa9tvB
 +x7vDMX+RGRiy3BJMrHc0fxCr9jLod5fRWuZnCH74WjhqdvkR8emoteWeHwiU99gEfIa
 uj21O/eIN4gvIWCrCwUO7UDFhMTTF5cxROvW2IL0YQvChfKLIUH5Yj8HHDSU/0wVZ6Md
 m49/peWpu9lO93WttnLUigKulJyy6u0Sbetj19zLNhfHV6g5RCkfPFq5qoRxIMcwOrR0
 NboA==
X-Gm-Message-State: AOJu0YwOcuLAeB4SgjmlOuJqac/+vJUCVfcKvmFeHSVqX9FKhqyZEre+
 WEn734gSbyXDfFJeUjsdEyygpoAQjMpmoHLkPpTPy9hLFtUYWAxHDAi/ZoIHzA+AxnAIe9i6GjP
 OrQ9v
X-Gm-Gg: ASbGncszdymF/VHQgzgpE7203f2g40TQTC3b9219ttsUrUFyvl9xkh7XEgzdDGraH/i
 i2Q1Qr3/LupbEDBlE3YgtJyC0VudaOFqoBuFQDZ1ASITya1m0ObPCWL7pd6su46oxT+ppM4yNuZ
 P8v/gedFOCifN/qoIkNZI6lIgMOgrXSFS8j+5Se64fFtw+ZG4GGaoObcczmbGldq+Q083jmBM3G
 vMZFOoALuWCK8Iardl1YfQzu9aUYoVAoLNkbghWBzS+Nb0BK1ORqwcWt76rd6Ca+Bz9cFbm6Jxw
 RDixn7DEx1i1G1QOdea3/LczQ1+d7wq0ewMpuoQSDyYxaiXT2wE0GtC61mYLLrVd1v92O0yrpey
 SsCOfMN4GYGZdGN+bREtQQYi2+Hj+
X-Google-Smtp-Source: AGHT+IEpR/BtSYqKohfyYhq9fzNE4eVuFjC/roAQBRrIT87jyGbtN7HEm58aRP84iyLzyoNlnuyBdw==
X-Received: by 2002:a17:90b:4f8e:b0:32e:7270:94a4 with SMTP id
 98e67ed59e1d1-3342a22f5c5mr680742a91.14.1758740470881; 
 Wed, 24 Sep 2025 12:01:10 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-33439103461sm63221a91.8.2025.09.24.12.01.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Sep 2025 12:01:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 05/32] target/sparc: Allow TRANS macro with no extra arguments
Date: Wed, 24 Sep 2025 12:00:38 -0700
Message-ID: <20250924190106.7089-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250924190106.7089-1-richard.henderson@linaro.org>
References: <20250924190106.7089-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

Use ## to drop the preceding comma if __VA_ARGS__ is empty.

Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index b922e53bf1..336583beab 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -2487,7 +2487,7 @@ static int extract_qfpreg(DisasContext *dc, int x)
 
 #define TRANS(NAME, AVAIL, FUNC, ...) \
     static bool trans_##NAME(DisasContext *dc, arg_##NAME *a) \
-    { return avail_##AVAIL(dc) && FUNC(dc, __VA_ARGS__); }
+    { return avail_##AVAIL(dc) && FUNC(dc, ## __VA_ARGS__); }
 
 #define avail_ALL(C)      true
 #ifdef TARGET_SPARC64
-- 
2.43.0


