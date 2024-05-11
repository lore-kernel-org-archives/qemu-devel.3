Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 596AEC04FFE
	for <qemu-devel@archiver.kernel.org>; Sat, 11 May 2024 11:56:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5lIs-0000Jw-6O; Sat, 11 May 2024 07:54:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s5lIq-0000Ib-Ip
 for qemu-devel@nongnu.org; Sat, 11 May 2024 07:54:12 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s5lIo-0006y1-Md
 for qemu-devel@nongnu.org; Sat, 11 May 2024 07:54:12 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-34e28e32ea4so1740610f8f.2
 for <qemu-devel@nongnu.org>; Sat, 11 May 2024 04:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715428449; x=1716033249; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fK+33hG7y7qtK+XmeBcuCbI8Hmdt6nSy4YCvnmn+BlU=;
 b=wSlsbqcJBeruehim4alPKMSxmRDPdzNo36p22Fnkh/03yF+DgOG0PoyvEBKsLpsKG2
 xfVVuYdzUSGkrWUT8VjmI3uRCSHKYvj/lQARa42tEtE7cVs6VzYEAfkeiNvmshAiFmi8
 5vJFmPHJH91+m1ReXyCDYC2MwbRbL/n8Alv6KyUFbpNZXnBg8CIDPzKVS5OJtxdr4wmt
 71n/WO3bFKnl+Q6FuvWRNHy1JF4DnCPRr6SZf5deah0zfDjOBVpnAvfioSj16l9ALz51
 pGe5iZKvJGkPDAgsbV8lNm3UUraAuMcf4iv/qj0+Uwi9H09r+GLlRK7rVNlreb8Rwc5T
 IdRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715428449; x=1716033249;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fK+33hG7y7qtK+XmeBcuCbI8Hmdt6nSy4YCvnmn+BlU=;
 b=KTfFUWCF2gspDTTlTCEFARW4Ig+J0uBRObl1l5v8Qch2I1dmz0y2ZSXENmmsvC/s8O
 vXyFv0KTppJm9lFnjXkLvIuiYZXnPadSfi7IYkmNwUlS07L8JoNgwLfqEbJkezXr9UA1
 SDiFQC4sD75atGumzCG1BqdAaWvt8FIvxKPMdBiyDlwHb3oalvos+gwfpHQh0s8Yjasq
 VGO7njMyXgkYXg/qyyjjLgZRG0NyyG49TUWKAmhemwGXx5stEAv3FH4Oholk1+HApipI
 zSPIRuPLDoeFSlLYaQS/s8yos0RksRzTNV1H+6Hnx51oNqmCFVljgJxtfmSTJJ0uU2kw
 RM/A==
X-Gm-Message-State: AOJu0Yx8Q5IG3TH6inPa619893usrak2lKv6KXF7ejbqTSpXOVPuDVbI
 k8fTB0pBXKdvTJ1CbhooEJQ3Sr8pk5AqHnO8eUMrJDtnvwcIzwzbuffPkaMtauwYStn8IBx5aBD
 JN+Q=
X-Google-Smtp-Source: AGHT+IHgPt8H57AZtUUsJVQpox8VPsFKvhnx6y5anFqpzcG83pYyyf81tylHlg+AyHZaIX5Mj/VZLg==
X-Received: by 2002:a5d:4b0d:0:b0:345:c1cc:2d85 with SMTP id
 ffacd0b85a97d-3504a96a6femr3911614f8f.55.1715428449366; 
 Sat, 11 May 2024 04:54:09 -0700 (PDT)
Received: from stoup.. ([195.76.196.165]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502bbbbf20sm6764797f8f.93.2024.05.11.04.54.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 May 2024 04:54:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH 07/17] ppc64: Compare all bits of CCR
Date: Sat, 11 May 2024 13:53:50 +0200
Message-Id: <20240511115400.7587-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240511115400.7587-1-richard.henderson@linaro.org>
References: <20240511115400.7587-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x434.google.com
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

There are 32 bits in this register, and they are all valid
comparision destinations.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 risu_reginfo_ppc64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/risu_reginfo_ppc64.c b/risu_reginfo_ppc64.c
index 67ea3ce..109b87b 100644
--- a/risu_reginfo_ppc64.c
+++ b/risu_reginfo_ppc64.c
@@ -78,7 +78,7 @@ int reginfo_is_eq(struct reginfo *m, struct reginfo *a)
         return 0;
     }
 
-    if ((m->gregs[CCR] & 0x10) != (a->gregs[CCR] & 0x10)) {
+    if (m->gregs[CCR] != a->gregs[CCR]) {
         return 0;
     }
 
-- 
2.34.1


