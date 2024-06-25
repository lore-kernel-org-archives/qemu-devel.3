Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2660BC2BBCA
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 07:36:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sM0hr-0004dE-PT; Tue, 25 Jun 2024 03:35:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sM0hq-0004cz-NN
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 03:35:10 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sM0hp-0003xt-7w
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 03:35:10 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3627ef1fc07so3909790f8f.3
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2024 00:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719300907; x=1719905707; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VA5f/N1mW7Z/7ENwZP3WQRg2cxqQYBPog8kTusH9efU=;
 b=GbyCTq02YFrWzrmaf6cniUn+zZ6b3uaVHqN0CzkVeHUEQCs7Jx8JTVfM663+Xa67n6
 Wj0BHkPR2d3ypVu81lsh0hdeTY+w2LS+8/EcorXqwOjG8q9A6cgNnfZYisoNqJCU5ra2
 MalYVqBwL4A0NkeH4acjDt9ggvg45A0ZUbm1C0XQUXOVsazFERXhKdJNlCUJo1qMhO5/
 SGyTab+v4AE18q84pjFXpcmA4TzTpKkF678rom0xrv1sYBbN3DpCluml9hczICvVn0gF
 sZceInfL3UWWzOZP8ujD9BvqYd+uK2klk6vAVa/CPWlydW/4H6YOkDTZmIAZNkxzVt+h
 JEmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719300907; x=1719905707;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VA5f/N1mW7Z/7ENwZP3WQRg2cxqQYBPog8kTusH9efU=;
 b=tKAbTMW2vpGlDREVO82nVBKEnSgi4mzK3RD5JLVuOwLfSHRUThvxgWaDgxSqDUgJOf
 JNmFPkcVIc1fn9XPPzP42AMdKowKvpC9z6Bd0KBUAk58AihzpQrg5EYAm1i1LvUfmiVs
 BmavLKJvl5pz8wIHzlVf29YIOEpNYANPi1PvAafzwfcPdICBJhbiTa/jR18KlSeoupng
 enq+vPsqdy+PvQOclhRhYXqu0a8a0BP4/RKukwCQrX7p/jLv6Dra4O/m8Q7lZSriwpPG
 06C90U0UGqQ9VAQbP7jbK58xQZBkkMjb4GJxrbUG4+78IAjZ4ZDsYR+aF4bxZbrkJz9E
 CQrQ==
X-Gm-Message-State: AOJu0YyFY+uccSsHRSJNuqwROKtm1FyTVY7GUxw4pK8USr8YFyeB+DYr
 SgnQqFs/ikPqex64sjSdUHfbUG6JqpLau4I8dbZz1TKKKqKpliBYJ1bsCrQQO1+gmnhn6XXQGkQ
 V
X-Google-Smtp-Source: AGHT+IFaV2nELuj9RPYhb56fhfRIckdrkrVT3yqTI6WKrXRVgvMzkG05Mwx5rMBz6Fk6cYJOMxhG7Q==
X-Received: by 2002:adf:fdc7:0:b0:360:81f8:698 with SMTP id
 ffacd0b85a97d-366e96be4dcmr4311067f8f.58.1719300906944; 
 Tue, 25 Jun 2024 00:35:06 -0700 (PDT)
Received: from m1x-phil.lan (mau49-h01-176-184-41-129.dsl.sta.abo.bbox.fr.
 [176.184.41.129]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36647e7eb4fsm12112264f8f.18.2024.06.25.00.35.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 25 Jun 2024 00:35:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH 4/7] hw/sd/sdcard: Convert PROGRAM_CID to generic_write_byte
 (CMD26)
Date: Tue, 25 Jun 2024 09:34:38 +0200
Message-ID: <20240625073441.34203-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240625073441.34203-1-philmd@linaro.org>
References: <20240625073441.34203-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sd.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index fff4be3ae2..9db3b32b0b 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1491,17 +1491,7 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
         break;
 
     case 26:  /* CMD26:  PROGRAM_CID */
-        switch (sd->state) {
-        case sd_transfer_state:
-            sd->state = sd_receivingdata_state;
-            sd->data_start = 0;
-            sd->data_offset = 0;
-            return sd_r1;
-
-        default:
-            break;
-        }
-        break;
+        return sd_cmd_to_receivingdata(sd, req, 0, sizeof(sd->cid));
 
     case 27:  /* CMD27:  PROGRAM_CSD */
         switch (sd->state) {
@@ -2064,8 +2054,7 @@ void sd_write_byte(SDState *sd, uint8_t value)
         break;
 
     case 26:  /* CMD26:  PROGRAM_CID */
-        sd->data[sd->data_offset ++] = value;
-        if (sd->data_offset >= sizeof(sd->cid)) {
+        if (sd_generic_write_byte(sd, value)) {
             /* TODO: Check CRC before committing */
             sd->state = sd_programming_state;
             for (i = 0; i < sizeof(sd->cid); i ++)
-- 
2.41.0


