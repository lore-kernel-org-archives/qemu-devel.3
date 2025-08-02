Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5202DC87FD3
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 23:58:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLwj-00031t-I6; Sat, 02 Aug 2025 19:47:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLoX-0005ze-KH
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:39:03 -0400
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLoW-0006Rr-5E
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:38:57 -0400
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-741a254d4a0so895680a34.1
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754177934; x=1754782734; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RrRDTwGDphkvvBtsV/mK2pHDoMT9L4tWZDtSjWVgm+E=;
 b=Wfk0ZuNYhfQNg9bgl1kFYjOelfS6gyUWT0rtWjc8aWSEpgzVYvTJ6d1L+VzVbw3HXK
 Utl3/vBScFk2EJM4yxz4uwJY2VA1Jo3b7wMguhFTxVEz02D/7HYRJD4tLh3SfR2hNSu+
 bl5dpINX5RQwKYbbT13Kuwta3vzLOFxCSA/Rc+KMf7GzdTdwcl4EDYfTxXtYcifGARdu
 cinekQzsvVz8qUnGgJaKB1NeHS3U1S3xqLM7B1ZB11wi34a/OctaK+CSXztZrzfRZ6Wf
 GuEY8FW/gsII7+++vJYHqD9zUVuPiPoHU6VER9In8IkScNjiaRMUq/VIY8YRBKYZvOF7
 pQfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754177934; x=1754782734;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RrRDTwGDphkvvBtsV/mK2pHDoMT9L4tWZDtSjWVgm+E=;
 b=BpeOzMA11+HI+kAyXXknkIdTNkr0GIZHlny++wqVb2Z0ZV76dOtNxII/r2tFEi4Vgw
 sHsCazSUhKsXYq14TtFa0YyxQreuu8USJ/fispbu8rS7ggAVGBlWPfty7q61ulnhLxYj
 fLY/jc0kfFD08HgUG4E8icEA3esUEKjFNna5y8wQ4lP6QixWF1QhD2hQxC9ue92PpAT6
 XPLhKH3xm/hogU2DOu5LfXWufXNz5Wjv/6fkUdCJGEDz7la9i4bsZufRN4inSI+WB1R7
 pRFRuT/SXf83cHJMZDdGGfmEPnXQzJ/W+kvYKUw/KQOLuu9YU/l5tIzbMjaUXAhdB1gJ
 NiMw==
X-Gm-Message-State: AOJu0YyesgZ5bHOY3waAOA9FGVEqtZOCIkxHYEAZvCoyFyixm0fsKIrC
 5GXpsD0wu82Sf18hn+nYrn9qALxKOkOKbUscsTjOaq4OZjymnT3xraTMJ7tYCSH/yqUbErbkpZR
 d1bHjetk=
X-Gm-Gg: ASbGncu+yJoinjG2JjFZpGI7MfSpSpBtV45IN7iy/zQYjaK3yAMubAsoBTyyFXpXrOp
 mI+3HQHHlKIYooO74HsYdh6cF72Af61ROr2EfPSr1lpxM7ScgFlw4Hs7WPNrG9/tExlkofe/L1y
 16VvxcBdAYgGGyLwsqG+UVGyrL7G5Wn5cggWpp2lK3NoWb9C62SwutINjTYvO8F7FksFNHSLM6C
 SZOkfL9XUSFgiV4igUvUvq6LDGUeKuTwFLEzS+lkwtzD4WfxlvVG/co1O/LoWRX/0xyqSCAjZUl
 e4P5GeJHeMVsQbW2vjQm/nSNsr47GUO2m6RxWiIdjOyHnTopVzp50un1a1GADKTnEGgo2qQxp2K
 6KkqbBfqUxoShR0EioMrX+4hpRAY/m49c6ZyaCsL6dsCzh04a58Cn
X-Google-Smtp-Source: AGHT+IGw1bzQ4Rg/QOqe126gdbj/vnQBc0bhhNVwYVofR6EJ80zR6O5rhc3XIZCixKktVa9F3169iA==
X-Received: by 2002:a05:6830:651a:b0:741:4a0f:b869 with SMTP id
 46e09a7af769-74187ab6780mr7075066a34.13.1754177933982; 
 Sat, 02 Aug 2025 16:38:53 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-741a71dc78asm380409a34.30.2025.08.02.16.38.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 16:38:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 75/85] linux-user/aarch64: Allocate new gcs stack on clone
Date: Sun,  3 Aug 2025 09:29:43 +1000
Message-ID: <20250802232953.413294-76-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250802232953.413294-1-richard.henderson@linaro.org>
References: <20250802232953.413294-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32d;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32d.google.com
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

Allocate the new stack early, so that error reporting need
not clean up other objects.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 2f1e881046..91210775ed 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -6652,6 +6652,21 @@ static int do_fork(CPUArchState *env, unsigned int flags, abi_ulong newsp,
         ts = g_new0(TaskState, 1);
         init_task_state(ts);
 
+#ifdef TARGET_AARCH64
+        /*
+         * If GCS is enabled in the parent thread, it is also enabled
+         * in the child thread, but with a newly allocated stack.
+         */
+        abi_long new_gcspr = 0;
+        if (env->cp15.gcscr_el[0] & GCSCR_PCRSEL) {
+            new_gcspr = gcs_new_stack(ts);
+            if (new_gcspr == -1) {
+                g_free(ts);
+                return -TARGET_ENOMEM;
+            }
+        }
+#endif
+
         /* Grab a mutex so that thread setup appears atomic.  */
         pthread_mutex_lock(&clone_lock);
 
@@ -6676,6 +6691,11 @@ static int do_fork(CPUArchState *env, unsigned int flags, abi_ulong newsp,
         ts->info = parent_ts->info;
         ts->signal_mask = parent_ts->signal_mask;
 
+#ifdef TARGET_AARCH64
+        ts->gcs_el0_locked = parent_ts->gcs_el0_locked;
+        new_env->cp15.gcspr_el[0] = new_gcspr;
+#endif
+
         if (flags & CLONE_CHILD_CLEARTID) {
             ts->child_tidptr = child_tidptr;
         }
-- 
2.43.0


