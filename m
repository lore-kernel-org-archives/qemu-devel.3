Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 023C0D59D67
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 20:05:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFfFP-0005JX-L3; Mon, 25 Nov 2024 14:59:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1tFfFK-0005En-Hi
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 14:59:46 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1tFfFD-0004t3-OF
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 14:59:46 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-382442b7d9aso3702400f8f.1
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2024 11:59:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732564778; x=1733169578; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+uO/papoLLk0b3uqMB8ZdXvs73vVNVF+lSFeGHBI0zI=;
 b=OhLABPK0bpZqrobwEtOOLMTKOkMVtkJ5E7s1GUlIG6BExVa7kBportjf1o4p578c5i
 c1yiJORL9E2+FOSULKNlW+m6rTnMFmLY9cUpTMxZBXhp6Fn4Cha96b2NKzh7JxxlVDkf
 LDFd012ecJThVk2mhIexaaZa+huU9GvCJASXDIMl5TsyBq8O/sX5ojAZkfnx9OaENrX/
 XdsfnWLqjehD45XJyZJbwR9i7k+DaUvq5sb9NY3viFJ4Sszp6JwCJFFqaIHPoZ2gdHf1
 Bz9gXBeHHZcKDMcAECk+FgL0CL43V4Gph6I/l0460RVkM3wRzIw03qavu+mcQfwKsMC+
 k39Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732564778; x=1733169578;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+uO/papoLLk0b3uqMB8ZdXvs73vVNVF+lSFeGHBI0zI=;
 b=OIn6yHfbJWPNaEB1p6eR35ThMxHjD22iOEAqcqjSfUUGdBoOhADR3ibbKrLA9zoGLc
 8Hv4Kk36jk7pLknvqScHdefJwthsn9KVvg94Dai155YVg3VtwEstdDJgCHZlQQAtfvRA
 u6sn8chfBYJ5e5CQGCImNz945k0DcqXuxsxcgey+ZR96xZKHotY4g1dE1wPyFn6jlPil
 op/RAwdUrTUhjjL5hCxDbrEmiGYBXphuj66TnKpYgYkTyotCpb0Mn22RL1eYnmqB9nOl
 pMQeVU85HmT0HlNMLfrbbpRwSOog1IDw7fP128VJEv4yxhBG/RLCXglquWbxcuBNmZ/9
 arNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUAAlaAmrzehqdVI8fYx/N30hmCZGZoeRuGhXOt7WrzDFVO0IhzkPFMlt3SIgMobMau3+xjiZx/iQ3I@nongnu.org
X-Gm-Message-State: AOJu0YztX1TU9GW3v0mH108Ezkvvs7wb0dWFMwcJ3KzRZ6Ur/x7Xe8ZS
 GG0MaB6asyPFwHFD92BGP9L3PrqzZ8Hz+3FKQ27xvGKtn6BQb+wNeZXFbgUfbFk=
X-Gm-Gg: ASbGnctMHZ3ueQXosvC1Tl7tX+LgCP0ma2MpbNsTfiKqevMYBhNGKibe1PCKOz5zThv
 a3ITWZPcff9laaZWaOI/4joqTpnZEDhbWHOxIFeH6M81jWL6PVj9B/6OQLp9IdhZ2U7yeyzdyYK
 XWfJag/rLhE3EMJwLTj2Lnd+gAokoHLIzeVOH207b/DLFVFjZ7FmAPcUyYBLIuMxRPQViJel3CE
 xFn5Wx/btD5tBRmearkOSmh6h6vXUK81R+Eb1mnUbpOfTwS5De49lcytUbqoyVACyJ+
X-Google-Smtp-Source: AGHT+IGczDRNS0/GYso0gUYtSQC3fi60MTtYP0+QSa7oHPzr77RTsYNzR/7WGuk/JJO1HJo4LUm2pg==
X-Received: by 2002:a05:6000:1541:b0:382:2f62:bd45 with SMTP id
 ffacd0b85a97d-38260b70e7emr10262936f8f.29.1732564778383; 
 Mon, 25 Nov 2024 11:59:38 -0800 (PST)
Received: from localhost.localdomain ([2.221.137.100])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fd0fbdcsm11237971f8f.109.2024.11.25.11.59.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2024 11:59:38 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: peter.maydell@linaro.org
Cc: richard.henderson@linaro.org, philmd@linaro.org, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, alex.bennee@linaro.org,
 Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [RFC PATCH v3 24/26] hw/core/loader: Add fields to RomLoaderNotify
Date: Mon, 25 Nov 2024 19:56:23 +0000
Message-ID: <20241125195626.856992-26-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241125195626.856992-2-jean-philippe@linaro.org>
References: <20241125195626.856992-2-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=jean-philippe@linaro.org; helo=mail-wr1-x431.google.com
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

In order to write an event log, the ROM load notification handler needs
two more fields.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
v2->v3: New
---
 include/hw/loader.h | 2 ++
 hw/core/loader.c    | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/include/hw/loader.h b/include/hw/loader.h
index 0cd9905f97..73f317966d 100644
--- a/include/hw/loader.h
+++ b/include/hw/loader.h
@@ -355,6 +355,8 @@ ssize_t rom_add_option(const char *file, int32_t bootindex);
 
 typedef struct RomLoaderNotify {
     /* Parameters passed to rom_add_blob() */
+    const char *name;
+    uint8_t *data;
     hwaddr addr;
     size_t len;
     size_t max_len;
diff --git a/hw/core/loader.c b/hw/core/loader.c
index 759a62cf58..4ff40e8762 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -1278,6 +1278,8 @@ static void rom_reset(void *unused)
         trace_loader_write_rom(rom->name, rom->addr, rom->datasize, rom->isrom);
 
         notify = (RomLoaderNotify) {
+            .name = rom->name,
+            .data = rom->data,
             .addr = rom->addr,
             .len = rom->datasize,
             .max_len = rom->romsize,
-- 
2.47.0


