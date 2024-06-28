Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69A24C3064D
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 07:19:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN5k1-0007ea-1c; Fri, 28 Jun 2024 03:09:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5jw-0007IV-MI
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:09:48 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5jt-0004Ys-Mp
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:09:47 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-36743a79dceso863598f8f.0
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 00:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719558584; x=1720163384; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=l1JW4AJQQbgrb8lXxKMuM1qRbY1uuDZlLJblyEzxQh4=;
 b=PpZWD/+iLDmHqauQUg9sIQngn+ofCv5s3DypOxDmNqiWA9F0OYrjNPC2PI5OaCx1PK
 GFglA/px8tDaM764WlegNRY7wZFceoB9up1x9x519+4OyyQBlNzOaW/YKN0bgxv554rB
 Ogi8MeFVOO3irYMl0jyeoj+LWeWAjI4/kJBDKM8XKkmwRxgLAvAlFsiDqnfIN7fCGXI0
 Vngu1RR7cwDwFqq3g/HMf/KAjhI0ulDljEwYkDTHAqAAiAo3wKMJSFHw839V/WPBynXB
 f8HRpBTDlBNB/GVfYoh2ix+j0E+h5ynYaQXw8IW8x1sdLr8JXAJazPkkIOh27Ql4FJ0+
 p1YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719558584; x=1720163384;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l1JW4AJQQbgrb8lXxKMuM1qRbY1uuDZlLJblyEzxQh4=;
 b=wBk+zYhJhrHSUbBJkczdvFyKjiYKSyVZ/TMDE+stqtoqsISRnZ0/y/1CVWtJr40L1H
 F33ykxmI/5t18c3Wzz74bau5FlssgjBYSZ7XSwt01brMKnBM13/YK684E1zQt1+dG6ci
 74n7E5a/YRrxRNWuAi3rSIyJeG0vKz+WhvDiPV7milcFk76p5U9aNZAttKky1WiRnLLD
 2bDdP1CeLF29tarqg/Qq7kmEi4Iqjn9YfmZFhGOSCEH6aIy8G+YFzMzk/GzfF/+5Llbw
 tocTF3V/7e+pJ31LNwqtrllTgC0qgfeRyDXKoIqIdKbPKZ0LWiiIrB8KxPrZ7A1j7y+q
 99GQ==
X-Gm-Message-State: AOJu0Ywj4z5nigTfBOIQLN2BdknBX6xoVzWyxV7WRhbjwfQot4aPhEn5
 JOCt5UEf5/zJv7bplmLFQB03PqqtOBkFRlNzoxaqasundP9Cs0bqHB8d5SmKLf8C1EgF6u73WYa
 olws=
X-Google-Smtp-Source: AGHT+IGDCZ+1eCilwcEX5KuIHeHVVm5xNglOUoeS+e3CvrRSCilsafTvySeQpU55gkx2VjssMstRTQ==
X-Received: by 2002:a5d:64ca:0:b0:362:ff95:5697 with SMTP id
 ffacd0b85a97d-36760aa2b8cmr640206f8f.28.1719558584023; 
 Fri, 28 Jun 2024 00:09:44 -0700 (PDT)
Received: from m1x-phil.lan (cho94-h02-176-184-4-239.dsl.sta.abo.bbox.fr.
 [176.184.4.239]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256b0c19eesm21387115e9.45.2024.06.28.00.09.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 28 Jun 2024 00:09:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v42 75/98] hw/sd/sdcard: Remove sd_none enum from sd_cmd_type_t
Date: Fri, 28 Jun 2024 09:01:51 +0200
Message-ID: <20240628070216.92609-76-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240628070216.92609-1-philmd@linaro.org>
References: <20240628070216.92609-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

All handlers using the 'sd_none' enum got converted,
remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/sd/sd.h | 1 -
 hw/sd/sd.c         | 7 +------
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/include/hw/sd/sd.h b/include/hw/sd/sd.h
index 29c76935a0..c1a35ab420 100644
--- a/include/hw/sd/sd.h
+++ b/include/hw/sd/sd.h
@@ -76,7 +76,6 @@ typedef enum  {
 } sd_uhs_mode_t;
 
 typedef enum {
-    sd_none = 0,
     sd_spi,
     sd_bc,     /* broadcast -- no response */
     sd_bcr,    /* broadcast with response */
diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 6a9d611429..7f93d363c7 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -526,17 +526,12 @@ static void sd_set_rca(SDState *sd, uint16_t value)
 static uint16_t sd_req_get_rca(SDState *s, SDRequest req)
 {
     switch (s->proto->cmd[req.cmd].type) {
-    case sd_none:
-        /* Called from legacy code not ported to SDProto array */
-        assert(!s->proto->cmd[req.cmd].handler);
-        /* fall-through */
     case sd_ac:
     case sd_adtc:
         return req.arg >> 16;
     case sd_spi:
-        g_assert_not_reached();
     default:
-        return 0;
+        g_assert_not_reached();
     }
 }
 
-- 
2.41.0


