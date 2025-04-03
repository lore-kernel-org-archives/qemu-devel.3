Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FA3DC3600C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 15:50:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0MpP-0001AJ-JP; Thu, 03 Apr 2025 11:50:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u0MpM-00019M-VW
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 11:50:01 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u0MpL-0007xm-Bx
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 11:50:00 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-7fd581c2bf4so902939a12.3
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 08:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743695398; x=1744300198; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=phMJGK7ObD43/liCFUY9oN63kjuv978shOeaZzCSd64=;
 b=yePde7irbuAAHS63MyGw/ubVl3RxmyVVwZwMsnimL079UlfBG7niLNfLhBXuThsGXp
 HVPNlU8ZLDvPVOlsu4+NBZR320o6fCLnog4rLx3YoH2XF6gvVmadJFotBojcQDKc7Ne5
 eh7PEnHYZzfWG+O6JpJaO5ugY4W6Fvr3FBIotVwGeuewhyx+dylLqFZAlaS22ahRowSx
 D3/o3ZbXcHbuUkncLF2sM1z6I4wuN4dq/K3vO3psLqKl1VP2gr/a0QZB0r+lhTfLkHwK
 Owo9zvd9qwT95WxNrBLEjJdyn+VIdB26e3o0E21LW+GWqJo6eztiXH7qsu/cwWh87nbL
 vsLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743695398; x=1744300198;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=phMJGK7ObD43/liCFUY9oN63kjuv978shOeaZzCSd64=;
 b=iPfmlEIfh3IcQheTV2/nM9JahdL/QAC2GfpdgnzEAkgXPfA+Bww9TIqmgHNOwnSUw4
 AUDUU2Y1QFL35zvbWmMLb15Njgs2ud7wmIUEH4x/T3nju7g8AeSUpZ0jceKxMMP7fvCP
 1FLW60sjx4ebWuz4/bd0ACwv2swM5zeNq4IJJrYj4ciBhXdptRsaXOj/iLrh/kO0rDUd
 CBcZ+oBa/SyyUOKzbohgHrfgduKCNXiWgaV5aBeMMvTRRaZ9uDPwpWBdVcarERnJvImN
 DcCDYNAkdkX9a5MV2pYYZy2aTwFx317nAJIOLSfSrlMYntn05UDfDRKcsuMrtmpO/Xzf
 1KUA==
X-Gm-Message-State: AOJu0Yxg4Hv/NGsjSOD1FKRDfHGHGTTnIUXhVvpMsvBSjJ8dyxmD6qOv
 Vt6c3jysqGhzQpk5zjTyQU/WH9vK7QB3lxGXDxYZ1zO//i3Uvrw7NSnjyOLknkvM0T9psH82Rd/
 3
X-Gm-Gg: ASbGncsEgtlZYR+Y8eZWOXqVOg8ZFwlsf4FsVNOoj7iFSOiH6UW98gS/5C2Mosrf8zW
 tDCMh+WEX6clMN2BTHSAZjbBzfE4WYj/JKJVfS22tefHLotEN73/oF/Gs66K2gUm/PKUx/efBz6
 kXQ/+fRkYvAEADT3lOldxYadoruLJ8XophU3XqUPOUqRE/W/q/LDgcRTtFF4mDwG+/avPi3Jb0s
 DTvtFIfP8tMTaEKGNnX8zeboRZr7L+XPXfXGQHSMNh5TCq/EDAr63yMX5M9O8eCHp+Eu4yIyykN
 NdGGBa2o2jBNLc6J3p+Q9V+R9wNvQ7N1nOlkV1yrO5icvwYZPQBl6U6uVM2GbCg4mUixW9gSITb
 p
X-Google-Smtp-Source: AGHT+IHjSEn9DoJ7Jc1GEniqKTUrjZdpW3kdW8491eQ2VoqdONuHoPkl/+nHqngw48WOyHQuNFOsDg==
X-Received: by 2002:a17:90b:51cd:b0:2fe:b9be:216 with SMTP id
 98e67ed59e1d1-306a4934526mr56651a91.31.1743695397661; 
 Thu, 03 Apr 2025 08:49:57 -0700 (PDT)
Received: from stoup.. (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-305983d9bb5sm1812798a91.45.2025.04.03.08.49.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Apr 2025 08:49:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@nongnu.org
Subject: [PATCH] target/hexagon: Implement CPUState.mmu_index
Date: Thu,  3 Apr 2025 08:49:56 -0700
Message-ID: <20250403154956.791976-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52f.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hexagon/cpu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index 766b678651..59fc9ed698 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -313,6 +313,11 @@ static void hexagon_cpu_realize(DeviceState *dev, Error **errp)
     mcc->parent_realize(dev, errp);
 }
 
+static int hexagon_cpu_mmu_index(CPUState *cs, bool ifetch)
+{
+    return MMU_USER_IDX;
+}
+
 static void hexagon_cpu_init(Object *obj)
 {
 }
@@ -341,6 +346,7 @@ static void hexagon_cpu_class_init(ObjectClass *c, void *data)
                                        &mcc->parent_phases);
 
     cc->class_by_name = hexagon_cpu_class_by_name;
+    cc->mmu_index = hexagon_cpu_mmu_index;
     cc->dump_state = hexagon_dump_state;
     cc->set_pc = hexagon_cpu_set_pc;
     cc->get_pc = hexagon_cpu_get_pc;
-- 
2.43.0


