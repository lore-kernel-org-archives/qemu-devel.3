Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21A2DC48BEF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 06:25:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raV7U-0003Es-O9; Thu, 15 Feb 2024 01:21:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1raV7Q-0002zh-Hv
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 01:21:12 -0500
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1raV7O-0005bp-Sv
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 01:21:12 -0500
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-290da27f597so413910a91.2
 for <qemu-devel@nongnu.org>; Wed, 14 Feb 2024 22:21:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707978069; x=1708582869; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e+A2qkcrgjaI9rrkh97Ktn6PEwqN2bQkXlFCXE4NZ3E=;
 b=ZKKbMeDrMzEYzqVTYfXnb0dqw4ImR5L3YY2JHrGAmKx6W+nEcEDxLmRWrEKQEIKpdA
 WvF/ZUB0PcVoYx/q6VCzs1ClGfmIXIzkzclcvckkPRVYLfKvMk2TgqJJWfTudywh8w5o
 Ag+O4O+4ENtY8GEdlvoSrb7vyFSj/J+zzApJawOPrFoRLHc7vsYitfllLzFeRZivAI57
 lMrvBcW7mqBLElvrQBPgF9OV+xUO+WhOhZFb/ezrRhLegjsW4yA2bXchu+gr6yZluNki
 zk6ZD8rBQOrBLE9sfHSDsovmL6iXzJaRRQFvlFZ5owSWagPgiBkNE5OGL7lzP4W7YH2l
 yD7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707978069; x=1708582869;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e+A2qkcrgjaI9rrkh97Ktn6PEwqN2bQkXlFCXE4NZ3E=;
 b=Z9WWISlzwyEQWJyuZUUTotT5WIOVJnkbAhV1Zm3P2xxHjE9WMxVnS1EDHBH6zJMTUN
 dLX4zmmXSFaQiU+pGk8SJ/usRpgW4kHCC61Q6tsGhksJjxCU+Rbj+4kZ551L0uSQLwyu
 UZouW4OfvUDxrWWNJ/1vfjTAoNRKhIPyqD7EmN9JA8ulUnyTcWjcoyLpYjpdnRvut+Zd
 57c0KhB0NXFCj5JllNXaqhMr6tcj9rBvf2RZrV1AqsJjSA+lxOm0mp3UbR+NlkelyhlA
 MuYX/YwkaT1wJB1cNe5j8KGJJT5Fbc1SMfDuCqZ+aya3iPXXHT2/XnXPr9mscbVS6jLQ
 efsg==
X-Gm-Message-State: AOJu0YxRQyR0Mxs1kesv8mPt1CD7G04c/qd//7UDsiJLAVORpUt2Bh/I
 0feW1eCnrFjbsQAK3515tep2Q4J9vG+7JFJeCnH2z5590UDmBmPhomuiRr7URwOkAYLlpQX3jvY
 8
X-Google-Smtp-Source: AGHT+IHvSotyUzofOW75hdefpNocwa7y+Z6VqrRB/m8C5gG3sEMq0eITnn4RgnW6bgNDGFYNVyAXsA==
X-Received: by 2002:a17:90b:2308:b0:298:d43b:812e with SMTP id
 mt8-20020a17090b230800b00298d43b812emr882435pjb.7.1707978069512; 
 Wed, 14 Feb 2024 22:21:09 -0800 (PST)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 d5-20020a170902b70500b001d6f29c12f7sm464418pls.135.2024.02.14.22.21.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Feb 2024 22:21:09 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Helge Deller <deller@gmx.de>
Subject: [PATCH v4 33/36] linux-user: Bound mmap_min_addr by host page size
Date: Wed, 14 Feb 2024 20:20:15 -1000
Message-Id: <20240215062018.795056-34-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240215062018.795056-1-richard.henderson@linaro.org>
References: <20240215062018.795056-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1030.google.com
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

Bizzarely, it is possible to set /proc/sys/vm/mmap_min_addr
to a value below the host page size.  Fix that.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Acked-by: Helge Deller <deller@gmx.de>
Message-Id: <20240102015808.132373-32-richard.henderson@linaro.org>
---
 linux-user/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/main.c b/linux-user/main.c
index 12bb839982..551acf1661 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -901,7 +901,7 @@ int main(int argc, char **argv, char **envp)
         if ((fp = fopen("/proc/sys/vm/mmap_min_addr", "r")) != NULL) {
             unsigned long tmp;
             if (fscanf(fp, "%lu", &tmp) == 1 && tmp != 0) {
-                mmap_min_addr = tmp;
+                mmap_min_addr = MAX(tmp, host_page_size);
                 qemu_log_mask(CPU_LOG_PAGE, "host mmap_min_addr=0x%lx\n",
                               mmap_min_addr);
             }
-- 
2.34.1


