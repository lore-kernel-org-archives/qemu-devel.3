Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67159CA0EC0
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Aug 2025 09:57:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulPG4-0001i9-Lj; Mon, 11 Aug 2025 05:56:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ulPG2-0001hn-Ik
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 05:55:58 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ulPG0-0004hQ-3W
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 05:55:58 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-459d62184c9so23756315e9.1
 for <qemu-devel@nongnu.org>; Mon, 11 Aug 2025 02:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754906152; x=1755510952; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=CJISXNEJxGQu18NgteCrAwYqLc0YqGdFqHqlb2bbpF8=;
 b=bil20BbjyTmU+wEn8O5gmnRnpzBD3xccyCpP+zQpqj2LJMy6dwbeiOInzzgO5nrNEX
 4KdWA9dYQ4kdPwJFyaiqq/NHgN658OFPlLOTdvBYEgwqPEj+3O8af/6cy7xgN9J2cwZ2
 UzLYpM4+BDJgPYxks26TKhOiPYptAKh08C+e3DRCBoUVzr7Frs31gzsOTp0klEZ3Ejnx
 TIBz9PRArTSdSpTwykQJ62tE8TqFfr1QYt/XJFwU9ZGMTjBK0IfLsxtOXYfHJLV7YrFt
 CXWdHXh+2Yc4g3Htmi2Ap1inOMIhBRPEhV9A354diLNdr/NicgOemLnw8MdB5LGHIhkk
 cr0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754906152; x=1755510952;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CJISXNEJxGQu18NgteCrAwYqLc0YqGdFqHqlb2bbpF8=;
 b=LKp3/kb9xqWiNqiXAVgMEBssWyKpn1flzBaoK29dTTgko2Sekfoqv8PrzbZ4Gcw3tR
 1XxwENREPJAVfq270UQx+TpyxMN1MtYUgOvXUEkk1BIXajKcIl2VfUlXhyTKGHeLL87B
 2bKdveEfLRwDlG9XT8WS9wrGG0kksjvBwX2Y0lkOhQZNAac9Ogo1d5raabpJ2TUkQ9Wv
 gCEVtK+vQaaORtHOUmkbb869JvF7YWcczHgLqnHXc4Ba8QGZCS5PUEt+ON0H3bAiZ77E
 h/AzbCSNK2/foeSGdtSLlgqnxWgwZzXWz3aKrXdQLx1Au2fISzHXfiPrSv0EB+uwpYc5
 k92A==
X-Gm-Message-State: AOJu0Yz4xvXK5Nf6e0jGMvRnODA9+svwyOV/gi0R+zGAs8tf9oD57NdU
 0AmrtVKyRaq0AWgC50446chyLbFhEBF1X2MAaO2AjIU0RAaWwCJqgs2jFvuFraxg8R3UGPgtGwb
 eTDnt
X-Gm-Gg: ASbGncs2a5cwdBAM5RYr53phGgEpr5ZZHR7dsBtQK7xCXUFnBUov/08FpKg1uhOV1Y2
 aW5GJba6JlROgeDrC53fctd2reWmllxc5G7S31gzim8AB9EOJjsBVSzpInH9diJcW/PbqUzUywZ
 fdlkyatTHwRDVrGcMHcFt6z/9t8kp+LqJQnN+yb0xMQxBNuAE4kjJyTb6PFwAKSYCnNAnWmRDAA
 91ip++6+R1jFmlfCTBZ+zQnGp5egdW31324FYNsewQ2oyPf9PM+U/wX9xycgTR7XvZXMZ5XZEPs
 5zHuYwwxnWM0wQeZWqxkTOIPwjUoe/EJnDAtYZDW08EfrS+uYRRZ1V8gz9krgObgfzVUvlkRlKQ
 aeD0TZW1SL1P7+sMj6S6Eic7V+VT8owYnhwbRkBxh9m3lcVL9jOL46Z017QxpaOdN9Dh8iykmZJ
 Qv71l+4ew=
X-Google-Smtp-Source: AGHT+IH9Reoe9b1AizLFtLGwusDgLsXR3VcfuQ6zVauyVe4N4TZoBRHA+vlXACqqL/Qbb/zDVLAXlA==
X-Received: by 2002:a05:600c:3b1f:b0:43c:f0ae:da7 with SMTP id
 5b1f17b1804b1-459f4ea0e52mr100137115e9.7.1754906151777; 
 Mon, 11 Aug 2025 02:55:51 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459e5843021sm268040275e9.3.2025.08.11.02.55.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 11 Aug 2025 02:55:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Don Slutz <don.slutz@gmail.com>, Fam Zheng <fam@euphon.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] hw/scsi/mptsas: Avoid silent integer truncation in
 MPI_FUNC_IOC_INIT
Date: Mon, 11 Aug 2025 11:55:50 +0200
Message-ID: <20250811095550.93655-1-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

For the MaxDevices 8-bit field of the request / response structures
of the MPI_FUNCTION_IOC_INIT command, the 0x00 value means "max 256
devices". This is not a problem because when max_devices=256, its
value (0x100), being casted to a uint8_t, is truncated to 0x00.
However Coverity complains for an "Overflowed constant". Fix by
re-using the request fields in the response, since they are not
modified and use the same types.

Fix: Coverity 1547736 (Overflowed constant)
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/scsi/mptsas.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/scsi/mptsas.c b/hw/scsi/mptsas.c
index 1ebe0b82a79..4ada35b7ec8 100644
--- a/hw/scsi/mptsas.c
+++ b/hw/scsi/mptsas.c
@@ -579,11 +579,11 @@ static void mptsas_process_ioc_init(MPTSASState *s, MPIMsgIOCInit *req)
     }
 
     memset(&reply, 0, sizeof(reply));
-    reply.WhoInit    = s->who_init;
+    reply.WhoInit    = req->WhoInit;
     reply.MsgLength  = sizeof(reply) / 4;
     reply.Function   = req->Function;
-    reply.MaxDevices = s->max_devices;
-    reply.MaxBuses   = s->max_buses;
+    reply.MaxDevices = req->MaxDevices;
+    reply.MaxBuses   = req->MaxBuses;
     reply.MsgContext = req->MsgContext;
 
     mptsas_fix_ioc_init_reply_endianness(&reply);
-- 
2.49.0


