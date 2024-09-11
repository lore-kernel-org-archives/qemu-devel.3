Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 852A8EE499E
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 12:27:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soMIO-000202-Id; Wed, 11 Sep 2024 08:18:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1soMHG-0007Ay-6G
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 08:17:11 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1soMHB-0007WT-6I
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 08:16:50 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-374c962e5adso547357f8f.1
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 05:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726057007; x=1726661807; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m4I+NOD0wib/I9pEA/OFAtVljb4eFRTvTggSagE3YZw=;
 b=dRuK0qY+wBFICSNS/84Hd/dQIOcxCiNyF08zCcjsA//g3GikAeCqX4d7C4dWME2mSo
 O2aovxjLh3/q3eDl669KQ4sJY7F6QQGe2Q5Ryb2p9hCxDT7Rpd4uFF49xNzZ9cc/JVtb
 PRiMkL6gJ9OUDDEhtN7a0RVgOgS5NJQWTT/+H0O0KZne/o3mwWj9tTmYTrpx3pJJlivH
 89zGWPAM+zUTtKQGcDFmmrxgnlElYpU6sPLrFxp1ZD84sKpHLfUTEOfINfUQBgC6bIFx
 EQhdvVT87DzKlPRNmnCcbYF4zK/oudStPLqi7313gZkQaD9SqFqnKb0QfvVGMXZoj2tO
 wKXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726057007; x=1726661807;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m4I+NOD0wib/I9pEA/OFAtVljb4eFRTvTggSagE3YZw=;
 b=tQE4HHoWxpmCYvIPXFV/clTncCO3ZLJpkppjj3OeJWSaXpvCaXi3aEkbPq9ICk7GTv
 m5MDdCa22yCdk5gLCQ1iwiOXQyt2wtpz+Wwg5lXbUy+GXkVbptlNmniVIoytcPs3VzM4
 f6L/OvZ2RtU5NPM2fC3wF50N/y1b5u6toC//hNA6m8KCCSGMEOuvnJglOfy0sXO2eF13
 U/whH0SusWoTrnq1NySUzdTwXKdc0CdQLFV4B58hxQQSW89+ybrmB+AtzroIpKLhzNND
 0lkQ+zBGInLp4WgiBfhO7a+7ey1rdt+tNu+pmN0RXpqUsZr8vM2U/WzethVxwljXSdLE
 5Gwg==
X-Gm-Message-State: AOJu0YxfOQ5OguuYTiRpb6ESi+xw90jotX04Y6OGJjgHFh5jG0P+WrHk
 Yr9MUjA6IGhiYn2f7e0Skg12St5teapjBUL5o7b/ozYGr94vNt0xxPjqfqjqE5SfK6L2wCHZ/mx
 z
X-Google-Smtp-Source: AGHT+IH1SDyCdUvrD6dV+ZITXfradAISlhEfY9S0XlQ1vLz1F+ySDrY3mt+aQlg4RqC6cnoERw5w+Q==
X-Received: by 2002:a5d:5f87:0:b0:374:c400:8556 with SMTP id
 ffacd0b85a97d-378a8a1b6a6mr4856670f8f.11.1726057007001; 
 Wed, 11 Sep 2024 05:16:47 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.196.107])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-378956d374fsm11482382f8f.86.2024.09.11.05.16.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 11 Sep 2024 05:16:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>
Subject: [PULL 20/56] seccomp: Remove check for CRIS host
Date: Wed, 11 Sep 2024 14:13:45 +0200
Message-ID: <20240911121422.52585-21-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240911121422.52585-1-philmd@linaro.org>
References: <20240911121422.52585-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

As per the deprecation notice in commit c7bbef4023:

  The CRIS architecture was pulled from Linux in 4.17 and
  the compiler is no longer packaged in any distro [...].

It is now unlikely QEMU is build on CRIS host.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Acked-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Message-ID: <20240904143603.52934-16-philmd@linaro.org>
---
 system/qemu-seccomp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/system/qemu-seccomp.c b/system/qemu-seccomp.c
index 98ffce075c..71ac444802 100644
--- a/system/qemu-seccomp.c
+++ b/system/qemu-seccomp.c
@@ -47,10 +47,10 @@ const struct scmp_arg_cmp sched_setscheduler_arg[] = {
 };
 
 /*
- * See 'NOTES' in 'man 2 clone' - s390 & cross have 'flags' in
+ * See 'NOTES' in 'man 2 clone' - s390 has 'flags' in
  *  different position to other architectures
  */
-#if defined(HOST_S390X) || defined(HOST_S390) || defined(HOST_CRIS)
+#if defined(HOST_S390X) || defined(HOST_S390)
 #define CLONE_FLAGS_ARG 1
 #else
 #define CLONE_FLAGS_ARG 0
-- 
2.45.2


