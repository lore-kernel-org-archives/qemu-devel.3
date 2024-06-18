Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FA32C2BB85
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 16:11:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJbMP-00012Z-Tx; Tue, 18 Jun 2024 12:07:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJbM8-0000R1-VI
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 12:06:54 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJbM4-0007mj-DK
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 12:06:45 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-35f23f3da44so5042982f8f.0
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 09:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718726795; x=1719331595; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kgk379QG4gces2QJuUS6NM5ocwUhk589UugM1F9rqoM=;
 b=agBYO7DXcHMscWdtP7LQgpZKed52yeVyJ8X/jjEMjCtqtcwxL2Fzv1Rtr3NRGiRqwy
 1OhJfsIi+vhdIqqlBRbyr4+G+AL+C10afDGk78utDHuwIlfPBzBDoTe0s+nEenSBrhia
 ppRZ1DgPY7qbB/f9H+Ol5xDG2gXqeM6OgBopao7fsjCzGw0WvAZH5DwB15bpLnQ8WtnR
 wI7bUcX1OrYEhiLdmmGA7aXDa4EF++01tXTn4JtsFuR1chIHiNGI27Vw/rKry34Tv+EU
 xXqmGrieO7k3+KVqUeb+nMYs/4LUur25fQqimEt3FUbftfVzMfw4f99FrtLEzdtbq4MV
 pWug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718726795; x=1719331595;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kgk379QG4gces2QJuUS6NM5ocwUhk589UugM1F9rqoM=;
 b=TAhzxVGyzZFNOBrIObauX+lS5ekyJs91Kn7lpxyYJz1u4PlJT/CTuZJ03yplZJUXQS
 7SDEOe2c9TJTOy6EK/qsOFKwjJ4I0MFlstlnT/HUTJUTuwD4YRzdz/qVqTavXculJBfZ
 qLG3ajid2JOpGK7+uzhtAWiy9ehwmeavC1oJ6zk2LYGLrYcCL2WPFVcu2w20m2HQHTeI
 IJOeDrlQlQfFekqv4SDyv38wtLZkrzH2j11ZRy7sAOWRsckS45jJfKmbB6rrv2dieVsc
 MNvdKxrJbTwhKhVFbDLe75Z8qWYa9MIR2PpXizI/aorLY1yT2xdI6OmZtm0sj1r1E+DY
 ngzg==
X-Gm-Message-State: AOJu0YxD7ET8GHHNmKkFt15HEAphazoH54zatuwnJxUXZyfqIXh3ugX0
 JY7TALdfUv5tQG/Y7gP+sKykpoToGq7cRTv70QNVodTZKW0YOfs6XGJmMH4dEIsajLnqvhMO9y/
 v
X-Google-Smtp-Source: AGHT+IGoGr4o8b5kJ+3OUkztPlXYAHnu6lxPeznPM7emiclS4Ry3gk4rTgc3kNQAl/e+gXYaW+wxIQ==
X-Received: by 2002:adf:f04e:0:b0:360:9180:760f with SMTP id
 ffacd0b85a97d-36319a85e94mr8325f8f.66.1718726795416; 
 Tue, 18 Jun 2024 09:06:35 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.212.55])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3621a4a17e6sm1580858f8f.19.2024.06.18.09.06.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 18 Jun 2024 09:06:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Fabio D'Urso <fdurso@google.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 61/76] hw/usb/dev-mtp: Correctly report free space
Date: Tue, 18 Jun 2024 18:00:23 +0200
Message-ID: <20240618160039.36108-62-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240618160039.36108-1-philmd@linaro.org>
References: <20240618160039.36108-1-philmd@linaro.org>
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

From: Fabio D'Urso <fdurso@google.com>

In order to compute the amount of free space (in bytes), the number
of available blocks (f_bavail) should be multiplied by the block
size (f_frsize) instead of the total number of blocks (f_blocks).

Signed-off-by: Fabio D'Urso <fdurso@google.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240618003657.3344685-1-fdurso@google.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/usb/dev-mtp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
index 7e4a0765ae..554b397e88 100644
--- a/hw/usb/dev-mtp.c
+++ b/hw/usb/dev-mtp.c
@@ -886,7 +886,7 @@ static MTPData *usb_mtp_get_storage_info(MTPState *s, MTPControl *c)
     rc = statvfs(s->root, &buf);
     if (rc == 0) {
         usb_mtp_add_u64(d, (uint64_t)buf.f_frsize * buf.f_blocks);
-        usb_mtp_add_u64(d, (uint64_t)buf.f_bavail * buf.f_blocks);
+        usb_mtp_add_u64(d, (uint64_t)buf.f_frsize * buf.f_bavail);
         usb_mtp_add_u32(d, buf.f_ffree);
     } else {
         usb_mtp_add_u64(d, 0xffffffff);
-- 
2.41.0


