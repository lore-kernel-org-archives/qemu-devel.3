Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CCA9C54E41
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Mar 2024 04:14:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgGjH-0005M3-Qn; Fri, 01 Mar 2024 23:12:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgDpj-0008II-C0
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 20:06:36 -0500
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgDph-0001q8-W6
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 20:06:35 -0500
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6e5796d01c8so2080197b3a.0
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 17:06:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709341593; x=1709946393; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=72XxUBIqz7vi+7Nek64Y5gomRVx4hdx3L9w0Ay29Drg=;
 b=TNocJI31qs82FeT7bRUIq4DHZABCOz6Obnpm9tFjprjJTbxVqqUAqraUpijQ9N1iHy
 wkfifkHL45eUHZr3ijHgSYlOl0PI63JU5s5pWpA4+CjCxRuw37C7sjaMacbaVq3s/7yQ
 1RBPg+QoF4fjJ9cWkKhuNxXQAhwQ2L9S6WoIQMyLbCqT3uO/G5rCJVy6aHUS70Fh4AJ1
 t/zcueWFyemBua+e/T7uG/cNap2Hx65gJrmHiuq7kE0RAuJV4TboIU7m79BQ7NttwwG2
 fPSZSG/TEAz9xnDPfT84+qJHB6g38LqYF0p+xEThPWECShAdV14Rj244CODP5xRvCdNU
 rVKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709341593; x=1709946393;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=72XxUBIqz7vi+7Nek64Y5gomRVx4hdx3L9w0Ay29Drg=;
 b=H9dw3D/C1DWYalMGMgy8A4ayLYTzEKLY4td1GZckpGgiWPUU6/Rkw8K/puwwoHTvvp
 frjW4g+/h+0OO7n98SGwrcboNxMfGrRQYHqI2ONUaRAuxbMyWuT5+5LXYnSu4peQhOFU
 3s8lxND7hXRX8x+C3rxRdQiJahckBkOFwdRzUDOXZg3qMEYtJFN2Ow3hf4KlOmGejUdo
 jxbPhSk4185rNStc78OhOs4HRmg7tUCZf66ml83TSL+N9txrRUk4esE2NGV1zWrH8VTo
 gClTNLf8LABKf1qhu4ysqF0LjOezqx1Oxd9OuO4xwx5QGxXFLjRU+RpN2tkz65jwkfoL
 4dPg==
X-Gm-Message-State: AOJu0YwFS+iL0iu3KplEpNRHAkBo23dHA4WTl32t5KYJjTUbSw2sp1FL
 IUCELF5WNEFJzW2aCIMOf/82ra5dCu4W1m6JVGnRlhAdosEAGGRJhe6UqfloLrtPJZu+GP6kFmJ
 0
X-Google-Smtp-Source: AGHT+IEzaKFxPoXDQOuNbzq709VjS8bxpYdu/iFfP3gXfSVdPqOKCSRjQtVah0nIajzqc3dxzVrpww==
X-Received: by 2002:a05:6a00:2406:b0:6e4:9ba6:d153 with SMTP id
 z6-20020a056a00240600b006e49ba6d153mr2955645pfh.8.1709341592720; 
 Fri, 01 Mar 2024 17:06:32 -0800 (PST)
Received: from stoup.. (098-147-055-211.res.spectrum.com. [98.147.55.211])
 by smtp.gmail.com with ESMTPSA id
 lo21-20020a056a003d1500b006e5acdb5c94sm2399881pfb.176.2024.03.01.17.06.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 17:06:32 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Subject: [PATCH 2/3] linux-user: Implement PR_{GET,SET}_SPECULATION_CTRL
Date: Fri,  1 Mar 2024 15:06:26 -1000
Message-Id: <20240302010627.12998-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240302010627.12998-1-richard.henderson@linaro.org>
References: <20240302010627.12998-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

Both of these only pass and return integral values.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 263b651cc5..efa200878f 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -6451,6 +6451,8 @@ static abi_long do_prctl(CPUArchState *env, abi_long option, abi_long arg2,
     case PR_GET_IO_FLUSHER:
     case PR_SET_IO_FLUSHER:
     case PR_SET_CHILD_SUBREAPER:
+    case PR_GET_SPECULATION_CTRL:
+    case PR_SET_SPECULATION_CTRL:
         /* Some prctl options have no pointer arguments and we can pass on. */
         return get_errno(prctl(option, arg2, arg3, arg4, arg5));
 
@@ -6465,8 +6467,6 @@ static abi_long do_prctl(CPUArchState *env, abi_long option, abi_long arg2,
             return ret;
         }
 
-    case PR_GET_SPECULATION_CTRL:
-    case PR_SET_SPECULATION_CTRL:
     case PR_GET_TID_ADDRESS:
         /* TODO */
         return -TARGET_EINVAL;
-- 
2.34.1


