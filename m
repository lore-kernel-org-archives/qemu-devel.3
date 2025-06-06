Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3727C677C4
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 16:47:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNaCe-0005lu-L9; Fri, 06 Jun 2025 12:46:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uNaCL-0005TM-3G
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 12:45:47 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uNaCJ-0003QF-AF
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 12:45:40 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-450cf0120cdso21939685e9.2
 for <qemu-devel@nongnu.org>; Fri, 06 Jun 2025 09:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749228337; x=1749833137; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d/XNfWiSbWGdYBzuDNRVlb7gdtXynRKks1ss0p+cqNk=;
 b=Zq13RdC1hr+mbjJh0YMy8dt/RcaAIX/A//QgJhzb/OqYzfw+miOk/yEZAUG9fKpR+E
 2CB1ITzXf8hM/w/LVCW8nLmcBlNOVQgSYoSyyZ8PaJ+5wFeLguTkuUS+nYNe9eT5aaZm
 uEMeTsE+OO89u/htXaBz9Qbrz7qnXLfPBgiO6VNc6H+58Z2oeiLrK3P1f8/SGtEw0MRt
 uTYqv4AB3c8XkGtLfP57xA54LHzlfFkyKahI/3yqB4zywA9j/lHJg1xzMXCSna1bFz5U
 dWMMbJ85xzQIL6CFuluqU/IljkrLMoz2ANkGdiMflYf/sJ0yA7uspSG1o4L+On6x+tYN
 wMzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749228337; x=1749833137;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d/XNfWiSbWGdYBzuDNRVlb7gdtXynRKks1ss0p+cqNk=;
 b=UJVU1FG9AnZaZLswz2p92njpdZP0d4uLmmBBklSvAoW3UHs0NsdOQGNyiQUOhDw2np
 LfrDeDgmL8o752SiSwq2OFJOrxtV1048k80oKEB0RptsmpPKIDnyiHHP+rhS40SRUO/y
 2iNSHyRdre5QjvMCveZPLyvDves+kEdo2J+yD29AjXjIpMMJqjM8J7d2DIMdX2xyKfuu
 h48azFCPlxdOx0TAJrYyiImH7hC+HdD7ctfOmqc4gec4pWXsMoc1Ano/aU9f+79T9scO
 qRVuy8pD9ktyhYvrL5V5d9crEFhbcr2+slyOhI0tFFyDXSQGl7wsg8y1oeDidWPWwAmY
 0/GA==
X-Gm-Message-State: AOJu0YzNpGr4kaADEyE8glH5LR6R9IhiU4uR/HkbAbx6ZJbh7dytBeYG
 20Yt400xpxXMRMt35EfVjzlQcOhavu3tfONHKyaD+GsGlam/spIOqM/g2xxxGJeRixDzOgWeWqN
 N8ECntp9BwQ==
X-Gm-Gg: ASbGncsnu3ec75CWQFk3A8o06zHWgYHx+2hF5rIUcNtyxD7rrhMlqdu6DO4RRalBxck
 qj0JZjX9eY0o3NDDv6BR5OEAHYos+kAdnAq8IbcZdvsRyy+r8n7dLtOz9Aqa2XEWSl8Iy87MeGo
 3ycMooT4xhaLGLjYIwv0tD/We0xhZaLMLZeSNjJKz6IHria+vvONrntfYBt9/PMycYBspRmt8nH
 IsAZbO5nA/63MyxlKzsMZ/jfBK8YuxE1R4+Xuhu41q5F0kSe0+jopdJOcaQfRP7CdsBJRSz/WbZ
 z4ihGYIj+lMynFebRBFim71fpe9TGr/f4eKQlEH78+f5EHCuYb8qjbVWULKSM1MsOrZwFPMyoRa
 DQGJwEF4IyjWJW0L+nbMRG1bFC0YsRML2yRsJZxgC3XBDEt/c
X-Google-Smtp-Source: AGHT+IGU+hGMKOTFmlNWWRga/zciSsEUVEbDz0Ap5vWKhtRMxHgJDnXVglly2xgVH+sdT58W1jk81w==
X-Received: by 2002:a05:600c:1e09:b0:442:ccf0:41e6 with SMTP id
 5b1f17b1804b1-45201340872mr50661325e9.3.1749228336787; 
 Fri, 06 Jun 2025 09:45:36 -0700 (PDT)
Received: from localhost.localdomain (59.red-95-127-62.dynamicip.rima-tde.net.
 [95.127.62.59]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-452fba4621csm17499185e9.13.2025.06.06.09.45.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 06 Jun 2025 09:45:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [RFC PATCH 10/19] accel/dummy: Factor dummy_thread_precreate() out
Date: Fri,  6 Jun 2025 18:44:09 +0200
Message-ID: <20250606164418.98655-11-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250606164418.98655-1-philmd@linaro.org>
References: <20250606164418.98655-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

Initialize the semaphore before creating the thread,
factor out as dummy_thread_precreate().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/system/cpus.h |  1 +
 accel/dummy-cpus.c    | 12 +++++++++---
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/include/system/cpus.h b/include/system/cpus.h
index 3226c765d01..bfaa339dd73 100644
--- a/include/system/cpus.h
+++ b/include/system/cpus.h
@@ -8,6 +8,7 @@ void cpus_register_accel(const AccelOpsClass *i);
 const AccelOpsClass *cpus_get_accel(void);
 
 /* accel/dummy-cpus.c */
+void dummy_thread_precreate(CPUState *cpu);
 
 /* Create a dummy vcpu for AccelOpsClass->create_vcpu_thread */
 void dummy_start_vcpu_thread(CPUState *);
diff --git a/accel/dummy-cpus.c b/accel/dummy-cpus.c
index 867276144fa..7c34e6c0fc5 100644
--- a/accel/dummy-cpus.c
+++ b/accel/dummy-cpus.c
@@ -64,15 +64,21 @@ static void *dummy_cpu_thread_fn(void *arg)
     return NULL;
 }
 
+void dummy_thread_precreate(CPUState *cpu)
+{
+#ifdef _WIN32
+    qemu_sem_init(&cpu->sem, 0);
+#endif
+}
+
 void dummy_start_vcpu_thread(CPUState *cpu)
 {
     char thread_name[VCPU_THREAD_NAME_SIZE];
 
+    dummy_thread_precreate(cpu);
+
     snprintf(thread_name, VCPU_THREAD_NAME_SIZE, "CPU %d/DUMMY",
              cpu->cpu_index);
     qemu_thread_create(cpu->thread, thread_name, dummy_cpu_thread_fn, cpu,
                        QEMU_THREAD_JOINABLE);
-#ifdef _WIN32
-    qemu_sem_init(&cpu->sem, 0);
-#endif
 }
-- 
2.49.0


