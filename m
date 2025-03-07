Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2405C28B24
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 18:58:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqcsh-0007Xz-05; Fri, 07 Mar 2025 13:57:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tqcsV-0007T8-0N
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 13:56:59 -0500
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tqcsS-0007nW-Cy
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 13:56:58 -0500
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2ff6ae7667dso4392664a91.0
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 10:56:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741373814; x=1741978614; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=13ZFhLiBHBjpoAqV9uKZaMKlyYRJeq7eTuuvmkqTawA=;
 b=MJHLb+4qdZheBqrNvc+rfUB/yzNXmhOxppiTeY5oedFF2ty/4gKjGLGM9qxGron3nC
 b2UQEMe76KkzWjiePnblvuH2ANwyFQAzk3AEMjdyrjdwLPIVoQOUrwRDjNmwnQH6BEwD
 68Kd3uaC8GnqcjUPvabBlTUEveFhvzGd/jcKs/HK0WiMEGz/Yc7dxIH0FS4TnE7QLslJ
 hllIHqPZcvtz2zmnn4c3NrHct9o2CufA+nQXwbsUiVAaegD5Kn7e3hyFcsBq1CjSbhqu
 v/XIJHoF49O5++GP4M5PPrcIv3EBQ6zXjiEsD2YB5XQr6pUS4zNha5j4HT2jru4s2HH5
 a3pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741373814; x=1741978614;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=13ZFhLiBHBjpoAqV9uKZaMKlyYRJeq7eTuuvmkqTawA=;
 b=k+QojHKfwt3yNjGYaMtLH7NtZlo3wO3u0Ays2r3w0/TpqLZOk5matEA+gplLv/SlXx
 mOg8G2dQSprwPdP4CvmNVQb3A0vTN2QqOa3ck7GzH8HfK5s9vAZhBcEBgPpiQknQiUMD
 310vMu6K5mZrQACf88OfhE69HptervsHDS5xvBXAfgyQ+M0+27QPeIP5qsFolef8miy0
 mCcMDo7ttc+Kpwc+sd/oLWSvApWjXpEqAw0lCY634MeQBLGNBNbjJWIdtJMo9cq+ZjH0
 kXeEMq6BDKun/jTZy3Y0jnrbJXpunbFjwzro6oXzcsXFzwyU8Gd3YQ2nZJFd2ZUp2pOI
 3Ltg==
X-Gm-Message-State: AOJu0YzDmRtX7BPUeZylNVpb8V3BIiibaebRM3cm1lHyzcgNrM//bXVc
 1c6x/xnR19BwP8lFzc2r99fgoRFhJE6Exh1hBuAFnzSNBvkEzGbpAP6idmnW7q7jgKdYwu0go8p
 V
X-Gm-Gg: ASbGncsFjQMSH6UIa0S0e9Gt00aZNvtmgJQ9AjEj9ZnH8o5ZAOPKhVYLpMDNc1arA+F
 eHkvUlOTHnFLfLW0RkrZfQmpMZ56eY+SeQczQ0MM4CcbtMB82f/q3YQTd4TwypChOwngIcPadyI
 lfhevPd7oUKTLron4nuXq6cp1TU5LeuqpePaKbzULrpLOT8wZ6KIA3Q39gJ1MoSZjwoc9wFDUmI
 9qgIiTpcZOsRh/KiT+5uvVD4O+5/ADAYONe/yw9G2Aak8Q3TlIdEs3VQBFaLumKG9X1/pH57rd/
 b3q2DiWVjiGWPJeoVyJux4D/Yvez2oMGL4M8NQW2cIR5xHkNMlG/TSUSUYYmNiT3VWXqVJFwL2Y
 v
X-Google-Smtp-Source: AGHT+IEAY/SPgd3nEC+70Ay82umoGARB5I1yeVNjbtP87Prcx09es8xIt2jI2qthEYcfy4pdsVb0Sg==
X-Received: by 2002:a17:90b:4cca:b0:2ff:7b28:a51c with SMTP id
 98e67ed59e1d1-2ff7cf32cb7mr5728103a91.34.1741373814493; 
 Fri, 07 Mar 2025 10:56:54 -0800 (PST)
Received: from stoup.. (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ff693534f8sm3391917a91.17.2025.03.07.10.56.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Mar 2025 10:56:54 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH 09/16] system: Build watchpoint.c once
Date: Fri,  7 Mar 2025 10:56:38 -0800
Message-ID: <20250307185645.970034-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250307185645.970034-1-richard.henderson@linaro.org>
References: <20250307185645.970034-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
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

Now that watchpoint.c uses cputlb.h instead of exec-all.h,
it can be built once.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 system/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/system/meson.build b/system/meson.build
index 4952f4b2c7..c83d80fa24 100644
--- a/system/meson.build
+++ b/system/meson.build
@@ -3,7 +3,6 @@ specific_ss.add(when: 'CONFIG_SYSTEM_ONLY', if_true: [files(
   'ioport.c',
   'memory.c',
   'physmem.c',
-  'watchpoint.c',
 )])
 
 system_ss.add(files(
@@ -24,6 +23,7 @@ system_ss.add(files(
   'runstate.c',
   'tpm-hmp-cmds.c',
   'vl.c',
+  'watchpoint.c',
 ), sdl, libpmem, libdaxctl)
 
 if have_tpm
-- 
2.43.0


