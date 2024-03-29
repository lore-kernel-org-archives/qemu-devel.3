Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5656C6FD1F
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Mar 2024 22:32:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rqKlG-0002bI-0P; Fri, 29 Mar 2024 18:31:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rqKkw-0002X0-ET
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 18:31:26 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rqKku-0003Va-Ey
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 18:31:26 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1e0fa980d55so20854405ad.3
 for <qemu-devel@nongnu.org>; Fri, 29 Mar 2024 15:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711751483; x=1712356283; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rTAbsZOgycJ6347QzcFwwaG8+pgXG7uj80wvUu+rRqA=;
 b=mhaiQmMI0Ot0cDeEYTl33jugXqoui9H+0aq/0IljP54efufFGzv9EMu26uGOarG18/
 V/tq7dtq2N6EBM7BskpdocEl7krlM1cAfSJzgfl8CoaDOGgeHD0KCZ403lbgIxgNRvjV
 J8n8uVd/ZDzgphOtiJnZHTnnZDcPlhf+zAaTOqk+HzLCLybG1jpR2aYPXer7n7+fs/CJ
 7A5yxmooZHBimK+8KCWiJ3OkkEvXbljDVgQPM8ATQ3bTqlqtiCT37dfXWF94U6iz9xBy
 6Xd+oVwZT+aSR+UrnudSpZ55PcwQQnpYYquRIJFmUdruC+8uxi/DA6sVru8gOktZhbV3
 FjDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711751483; x=1712356283;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rTAbsZOgycJ6347QzcFwwaG8+pgXG7uj80wvUu+rRqA=;
 b=MQlv1mAubfVrkcB1xCzc0HYr94YC0fp0GwkNWKNjUXhUsavW6RILNBlyCizHwCohPV
 Adp6CbbdEX4GF7I13JasX3z2/iEQ1Zf5w22vAIL7QIvtaDJvAP5xpHdUf+Ccvr/Y3d8U
 43gA0XC8uJkIA1CykNpPRPEvkWlsZaGGX3OIPFF4VuFWW/inRVFD0xv6tJVjSZdkUM0F
 srJ7Q08bzEd/jLuW+oALY8rQAoSCAdtyLPf4no3kcNH697TdHdeH31BvmVSKw7xQaN/g
 TYF9MWZ2Sj+1kjMvtFtDHJU0c6K6Z+q9s8tS6+Rz9tRuaa1/YJT4DDHueASJ5TMeVvjJ
 gCBA==
X-Gm-Message-State: AOJu0YyTmIbwFnklRq6xoGk85EQNRRa/p6Rr7o2rEGTxN+2W6Vcw94XB
 FgCSeM4WCXFynojPDy8q4gyyK7wyns3s+NbTgy2aEsKKhmEPbFGn1GeZkKYAWBXncTrTdgm1U1T
 d
X-Google-Smtp-Source: AGHT+IE0D/s7lct38ADwCqw97UzkeGmGWLLdFzHnzvhju1z2j75McBU/bZP5JKIEiLNsCbI6Fg8qgw==
X-Received: by 2002:a17:902:c406:b0:1de:eac5:9294 with SMTP id
 k6-20020a170902c40600b001deeac59294mr4119264plk.13.1711751483094; 
 Fri, 29 Mar 2024 15:31:23 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 f8-20020a170902684800b001e09b636cafsm4000955pln.287.2024.03.29.15.31.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Mar 2024 15:31:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
Subject: [PULL 06/18] target/hppa: Tidy read of interval timer
Date: Fri, 29 Mar 2024 12:30:59 -1000
Message-Id: <20240329223111.1735826-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240329223111.1735826-1-richard.henderson@linaro.org>
References: <20240329223111.1735826-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

The call to gen_helper_read_interval_timer is
identical on both sides of the IF.

Reviewed-by: Helge Deller <deller@gmx.de>
Tested-by: Helge Deller <deller@gmx.de>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 8c1a564c5d..5b8c1b06c3 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -2082,11 +2082,9 @@ static bool trans_mfctl(DisasContext *ctx, arg_mfctl *a)
         nullify_over(ctx);
         tmp = dest_gpr(ctx, rt);
         if (translator_io_start(&ctx->base)) {
-            gen_helper_read_interval_timer(tmp);
             ctx->base.is_jmp = DISAS_IAQ_N_STALE;
-        } else {
-            gen_helper_read_interval_timer(tmp);
         }
+        gen_helper_read_interval_timer(tmp);
         save_gpr(ctx, rt, tmp);
         return nullify_end(ctx);
     case 26:
-- 
2.34.1


