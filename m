Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBFC4CA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 17:06:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usO02-0000oZ-J9; Sat, 30 Aug 2025 12:00:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usERg-0007Zf-VL
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 01:48:14 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usERd-00053P-Hg
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 01:48:12 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-248cb0b37dfso26143035ad.3
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 22:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756532887; x=1757137687; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RrRDTwGDphkvvBtsV/mK2pHDoMT9L4tWZDtSjWVgm+E=;
 b=VODi5qWzHCHWrXyl5SvBraebE+RtyxsvCJmkYPsDbFDT5O+fNOrZvdZDhgDi6cvbX8
 ZtuvOXm647teiUaM2pyEKSnwXHQXc/+79tO4nKDHHgiDvnDfTieQVnoUi9gUmga+R+aq
 182YB8rQzm0f8XBHCIOKbWG6CK9gEoGtiHo/Dxb8yYKGh0TtrVH3ssv9u4Dq0f6tbr5Y
 vExFJ//z+aM7/B/49zjhSiZmnByaR9+VBU/HUBjqLs0QZcN+5hBTokEMSfNY26Y4NbBW
 5kX/YVtuDD+h6bANfbVHbAhIvVt8jYFpCoXpLed/+6Ml8s2zoCR5QSvqtdkuXl9+CTmw
 E0qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756532887; x=1757137687;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RrRDTwGDphkvvBtsV/mK2pHDoMT9L4tWZDtSjWVgm+E=;
 b=ky8y+NYHAYIiD27VyvoLtFVgPlxI7twGQsbxgz4uP6mocm5SbLHmqDNiJBN6sYxMx3
 OJJww5nR2Tnj2a332h8JuN9SMyUU5OTI9zTzXz8WsOmTrcMwPqoHrRbJHDx+F80zqi5/
 Hjnbgtzv7kna/DH2MKi6nfJBgVuqkUHp8JaQDojG3OezmNOwkYmTk6iPjdGxn4lUCaQ2
 WX7XS7WJG6C3NfBoSLbq4LXpBR8BuTSmuCW0bec+yonHa/Ehc/gW64zJNGTuKO89YiCx
 75TjJRWP/jjnpEkgcbUevAf1HNO56laKW63rmp/rvRZghPNIrRKVP1thXx4I1oGM3i6z
 xhhA==
X-Gm-Message-State: AOJu0YzhjNJzFVD9HumbeZy9IPL8xt2FEop7Hrdf1PNqe89u+6ecaiyt
 yiidDN70aoJXlstLgOIDngEOSpMN772HXIWDUiBe42NnTAZj03xjHpOcsQiJNjt/6zCbNh0qUl9
 HaHacWtg=
X-Gm-Gg: ASbGncvrRhFfEX5k+1TqqC/TBiJHCjIS3YncYahsTq/F+VVzVN5t4CltDqeJRQ/Atq1
 6SjUpVxoapGCp49WASWzHSJHxnJlQHoEQ+FZwl/ldkzo0pXoGo/uza92IkWS5LFlYX/iVoX5qru
 Rm4sv7JdntTFK6Ge2+nvAXRkLFiHc6SwFJjpJGiOtbX+NZL/F4j95ImNZiiuk8IODoUd3FXrfu1
 1P/pAMN2D7TPn+nnhbZV3yB1Px5Blan8gX05tsKUaMCeOwEcfZlU7rzuV7XgNCzAEu8rwf417If
 PHQoIW49IDJ2RC0rrxN5ixuasA20PD2/6qdAfv513RvyUnGxOeF63PHrcIkGg7mDLWS6ObW9aGc
 pf2lzrZXcgs3XGcO7LMDlb6Rhb+RQzaUUiEpuz+MrVOabZuFsLgnkXYhkBeP4IhA=
X-Google-Smtp-Source: AGHT+IGoHCdK1kauU9bmFRl/SqKDamGWvYyD6nzAwFXTX6HBF0hItUjUJFLxIVqbU97cHLuXO7nYfA==
X-Received: by 2002:a17:902:ce02:b0:246:a42b:a31d with SMTP id
 d9443c01a7336-24944ad758dmr13747515ad.44.1756532886866; 
 Fri, 29 Aug 2025 22:48:06 -0700 (PDT)
Received: from stoup.. (122-150-204-179.dyn.ip.vocus.au. [122.150.204.179])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2490658999fsm40852715ad.112.2025.08.29.22.48.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 22:48:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 75/84] linux-user/aarch64: Allocate new gcs stack on clone
Date: Sat, 30 Aug 2025 15:41:19 +1000
Message-ID: <20250830054128.448363-76-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250830054128.448363-1-richard.henderson@linaro.org>
References: <20250830054128.448363-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


