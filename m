Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87507C5478C
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 20:48:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdFvd-0008I4-Ku; Thu, 22 Feb 2024 15:44:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rdFvc-0008CS-1u
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 15:44:24 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rdFva-0002pe-LL
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 15:44:23 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1dc139ed11fso10255355ad.0
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 12:44:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708634661; x=1709239461; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e+A2qkcrgjaI9rrkh97Ktn6PEwqN2bQkXlFCXE4NZ3E=;
 b=RrxczqX+DJ4rzVYxr7cCaSq6WYI4RSotzi5F4ezjurSAHy/rOrlKz/QZ+Ms3gWACOM
 5gdI5crYQrQC8xBYi1dRR6N2NXU69uDGr9MqwNifraFl6rFXj+FFSCpA2Tq6aKPEJLdx
 sFDbZfOGzJtWFUC+8Nru1fAc4bPIgKnoo4jix9fcyDbXu9dO7miVUWegZMvQivG3bWaw
 nqlxT9WK/XJVoHV+/4L4kQY5e+ZpetnR0bQiduiYgxoBGq7InfIm5YX8S+5YjBYOiFCW
 hE5JfIJvVb7aVyea50WzeqQeMBrzma2G1fhZM8YyhCt7cMVQHKYgBiZaP+9Q4ko3aQmP
 YDAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708634661; x=1709239461;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e+A2qkcrgjaI9rrkh97Ktn6PEwqN2bQkXlFCXE4NZ3E=;
 b=JukUD7LxSbbu0sOsp8+kQTMWd+YUvn6ckBQvgrOhYqJyNmkI2jcZ88GyW3Pc53BjaS
 mLY1lwsdGOyQ/LRk8XlQruAq3golS6hN+eO5gSLBSrWNa6R5RtaMjYIOHQvBuwEYf/4L
 wRsJAD6Ul9csef615dxnVqVy6VIbXDkq4y5tCpuCsuDCecLd2H47ymqgKc1jnJt4CJMo
 fy31gLqJjbQCLbOcx4nUcPi1fRgWgvPDLgj8/+3W4VhUnzJTqYj9uT/A4/yMJT9bTYie
 DHlcHvp86UjDzgX7+CzSaMtVbNNO5JNWtJrbQ16U2CcqZQ5HZfwHjo/ph+9mmdAXZsK8
 pe0Q==
X-Gm-Message-State: AOJu0YymqH3UIzp2VIfsr5oAoyn0ydsz3aC6kJrl2xj6QaXYjShbFolK
 goUhbkNu/Pr1WhS7rab3bBklKX/swjUxqHEhXfllHqJ4hsZMkbf4qiyqfCd0f16HS/i1dsRh7fc
 B
X-Google-Smtp-Source: AGHT+IHj4x4KoLMrZPuSmly4HIFtIoXiJHEcY/4fxE7YzC+IG65DzjnX8lBKkrLmgEMYNB7kM/k/mw==
X-Received: by 2002:a17:902:c942:b0:1db:b96f:4a50 with SMTP id
 i2-20020a170902c94200b001dbb96f4a50mr206635pla.14.1708634661426; 
 Thu, 22 Feb 2024 12:44:21 -0800 (PST)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 l12-20020a170902d34c00b001d8f81ecebesm10275500plk.192.2024.02.22.12.44.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Feb 2024 12:44:21 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Helge Deller <deller@gmx.de>
Subject: [PULL 36/39] linux-user: Bound mmap_min_addr by host page size
Date: Thu, 22 Feb 2024 10:43:20 -1000
Message-Id: <20240222204323.268539-37-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240222204323.268539-1-richard.henderson@linaro.org>
References: <20240222204323.268539-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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


