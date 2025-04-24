Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89C38C369CB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 00:56:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7krD-0002j3-Sy; Wed, 23 Apr 2025 20:54:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kqN-0000yH-DQ
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:53:36 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kpw-0004gG-ER
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:53:10 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-73712952e1cso394768b3a.1
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 17:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745455986; x=1746060786; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ijlmz6/bRJsdkPdqsV+cz0ErI9CNddyOzeS8owSZGCU=;
 b=wJsMhpmkKCil5gR73qxokjttlzfiM17AcutQEgcQiLJLAE3nhEK1f6Yzqj+kVEzON2
 B9wLeqHnWmO4mJdj7Ibw7gZPsRWQ+2QFjt3AA+NIma8Ac7j8DdMHYvqVgUC2Wzy5LNtp
 pWkmLbfTEOImZyzxJ1guaRxinZDVxjgeSR9PnKsDF/A4KyR+QKX+7EOzu+FtEDywGTY8
 L5M3fGK96ME7L2Eu4VnXa5SMTTu66YNZoHWSBS4Chy3Dcrh7ZcabPhO82bNLKib9OEAk
 F8Y7x2E3V00Qp3ojSw4NTyy8tJrHxoDlXgviFVYqGHt53huT1sfzq9zTfpoX6xW/WPpJ
 pQWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745455986; x=1746060786;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ijlmz6/bRJsdkPdqsV+cz0ErI9CNddyOzeS8owSZGCU=;
 b=re/6DsYJ438qyZNfzEEuzXaCBNKBPpX+Nj+q8T3pQRmwafqBwi3ymCvAXuPOAg0mOW
 8CsfIBIJANeXYZcV72kkizrRsaFfOY3oUwKCckX/l8KcecAFzzrMzoYHh/QnxPVGZV5Z
 fEP4FfoQECgA0olxBhia4Yx/Uaw0S+o4f84GbLxO1nQ+gUDt0FrSYVP+/+cWdyFoR0Ks
 p7xKb/KLgsgIg+IgWXSx2SA+tPr5QCAsmWhowejnquFBCARPne9nUQvKyrk5x6QWY7s0
 PMAFC8dIFdcEdTkfntc+WdbmgCE4HkyjFin5lbSIiJBOSDUaoFMpuThdYcmsZ0J9Vadc
 5LDQ==
X-Gm-Message-State: AOJu0YylUGGrchfxylZq4Fi3d8urBPImGKLMIgCaU+YVOAwI2NgdEi6g
 pgDpEtZb5ipXhRvBZLF5GocoSziAZIrszN5RabmtmZnUh7tKPMA0a5ExXWiJH5fT9qE5/xYhxaa
 i
X-Gm-Gg: ASbGncun/RU/iDQuqX9pN3ss3qtnJDKdYETmjs8A9oJelmdN4PFLTJB69xmyZ+8oFy5
 rBdzofx+FXaenWdWnEGyBxR7qQzQGRc/bHBLX7smNwT0YQvqfkOr3WvspoDrmrpx8WEU1e+GIVA
 6A+wZTU5V8tp4r73qOBI71A9NtJytLttkIqFZdUJZXarbFbDLZMc6XxTVH3SvYzWFeGj6nJnXdv
 +zK3xtQjUU80MQDi9vsCSY9lKRzJuIw4YIaJmSplrxskaJV0zYKGVswGbYXOqoHEH/E7BKZw/HF
 Yz3lmmgN868a+A6cL3MPYc3dWMJ4xZymVA99uO6dks7xiZc37Wn5sdmiIBGv0y5nYAguj/7UBr0
 =
X-Google-Smtp-Source: AGHT+IHYePiiohZs0NE5+CaAztgHfPZ4XX+aXL4dIn6TAFr1MQI38RCIgTCE5Mlm8JOc+uIe/CZr5Q==
X-Received: by 2002:a05:6a00:98e:b0:725:96f2:9e63 with SMTP id
 d2e1a72fcca58-73e24e156e1mr1216994b3a.24.1745455986462; 
 Wed, 23 Apr 2025 17:53:06 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25a6a971sm209353b3a.103.2025.04.23.17.53.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 17:53:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 042/148] gdbstub: Move syscalls.c out of common_ss
Date: Wed, 23 Apr 2025 17:47:47 -0700
Message-ID: <20250424004934.598783-43-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424004934.598783-1-richard.henderson@linaro.org>
References: <20250424004934.598783-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

Copy to libuser_ss and libsystem_ss.
This file uses semihosting/semihost.h, which has separate
implementations with and without CONFIG_USER_ONLY.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 gdbstub/meson.build | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/gdbstub/meson.build b/gdbstub/meson.build
index 0e8099ae9c..b25db86767 100644
--- a/gdbstub/meson.build
+++ b/gdbstub/meson.build
@@ -7,15 +7,15 @@
 # We build two versions of gdbstub, one for each mode
 libuser_ss.add(files(
   'gdbstub.c',
+  'syscalls.c',
   'user.c'
 ))
 
 libsystem_ss.add(files(
   'gdbstub.c',
+  'syscalls.c',
   'system.c'
 ))
 
-common_ss.add(files('syscalls.c'))
-
 # The user-target is specialised by the guest
 specific_ss.add(when: 'CONFIG_USER_ONLY', if_true: files('user-target.c'))
-- 
2.43.0


