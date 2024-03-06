Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89940C54E41
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 14:43:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhsS4-0007QN-Rv; Wed, 06 Mar 2024 09:41:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rhsS1-00076r-6r
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 09:40:57 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rhsRx-0001TY-9D
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 09:40:55 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-33e17fc5aceso563758f8f.0
 for <qemu-devel@nongnu.org>; Wed, 06 Mar 2024 06:40:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709736045; x=1710340845; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gtRa7kRDjdE8sreaiOincZXchoFU4nQ40xW4Eh4gbzA=;
 b=U4+fDTDUSvY0703hj3cU46/Yv4Nwr145UUQWIaC0AA1bGvE2m18GlB03G67q17y9EQ
 u3EHHJEkPXo6TikU1sab5svXlsIK9TkmrvwhD8/VWw1PSOxft+1cYWH2D4COktROp2qF
 yD4qRrv3BrwC6ya2KB0aTdQbDHCCpIW/9xS0NG2y11rdU/4OnDZ0y5r0vYX71PDPf2Ra
 QUO3DLbzwRxPKlJfFdpkasYCcRVKIkbt/e6ltsN36+xbEy1piMSyc8e/0TcReYbHANmM
 0cfTSixSADTo/Mr77a5Bot6gKs6IuLaa+uyWVYEtshEbJk7T1Ybz5E+rcR8igxLCQ8hX
 PFgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709736045; x=1710340845;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gtRa7kRDjdE8sreaiOincZXchoFU4nQ40xW4Eh4gbzA=;
 b=FEYJNF2C8yZu/2XW4k6AKXgw6A95pVUO4PpbXVW8kcKCnDa6Vf2c25ZGTaYCZ4NXft
 QKWi6Z2R8K9HgeNcZ4Aor3jPiXtElliQwxfhc3UPIr2gLVrUo1pWaJVuW7XsePGmYFPs
 w0BUwk0w1xJTAZBh2YKkMXXXiiDVUGLSWODdq/2RNtfDIOCWxetLJwZJdwdz019jy6Ca
 N0W6yRJLyG7YzcNa1YOpTBPU4H+GYJDhcOFzkt+sLQqu9Zn7YyWachWkno3O2y9kiI2F
 m2xDNMp6oBUCgZk4+5dlW+oj311Y8fbktlDsatCTYSOeF8FnMLEdV8pbAfBJ3DFLhWi+
 gzAA==
X-Gm-Message-State: AOJu0YxezjX4cqXDft3UAoOGo0asHL03NbPUvmW7oKvUNAJffvV9A9lc
 EDwRRKWG07wdFHYdXOjLCN1308XDY+W90slDgRoGsa8SjIT7NhmsmyTmL38KlBcUrBKu8WAhtX8
 N
X-Google-Smtp-Source: AGHT+IGSd9p4x/t2mW+GacMLuOYYe8vzFsp30MiWW3LfoWirOUwQiBhjZhJ5KTfVTuXSMpLwVFQnmg==
X-Received: by 2002:adf:a3ce:0:b0:33e:2090:a439 with SMTP id
 m14-20020adfa3ce000000b0033e2090a439mr5161061wrb.10.1709736045137; 
 Wed, 06 Mar 2024 06:40:45 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 u4-20020a056000038400b0033e456f6e7csm6195304wrf.1.2024.03.06.06.40.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Mar 2024 06:40:42 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 08F0E5F954;
 Wed,  6 Mar 2024 14:40:42 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Warner Losh <imp@bsdimp.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Kyle Evans <kevans@freebsd.org>, Laurent Vivier <laurent@vivier.eu>
Subject: [PULL 04/29] {linux,bsd}-user: Update ts_tid after fork()
Date: Wed,  6 Mar 2024 14:40:16 +0000
Message-Id: <20240306144041.3787188-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240306144041.3787188-1-alex.bennee@linaro.org>
References: <20240306144041.3787188-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42b.google.com
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

From: Ilya Leoshkevich <iii@linux.ibm.com>

Currently ts_tid contains the parent tid after fork(), which is not
correct. So far it has not affected anything, but the upcoming
follow-fork-mode child support relies on the correct value, so fix it.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Warner Losh <imp@bsdimp.com>
Message-Id: <20240219141628.246823-4-iii@linux.ibm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240305121005.3528075-5-alex.bennee@linaro.org>

diff --git a/bsd-user/main.c b/bsd-user/main.c
index 512d4ab69fc..e39eef3040f 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -134,6 +134,7 @@ void fork_end(int child)
          * state, so we don't need to end_exclusive() here.
          */
         qemu_init_cpu_list();
+        get_task_state(thread_cpu)->ts_tid = qemu_get_thread_id();
         gdbserver_fork(thread_cpu);
     } else {
         mmap_fork_end(child);
diff --git a/linux-user/main.c b/linux-user/main.c
index 551acf16619..699da773714 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -161,6 +161,7 @@ void fork_end(int child)
             }
         }
         qemu_init_cpu_list();
+        get_task_state(thread_cpu)->ts_tid = qemu_get_thread_id();
         gdbserver_fork(thread_cpu);
     } else {
         cpu_list_unlock();
-- 
2.39.2


