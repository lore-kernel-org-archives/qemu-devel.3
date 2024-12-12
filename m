Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33749E77180
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 20:49:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLq6t-0003gA-Qc; Thu, 12 Dec 2024 15:48:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLq6o-0003em-Tz
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 15:48:32 -0500
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLq6k-0000wN-Nj
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 15:48:30 -0500
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-71e1158fe3eso564972a34.1
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 12:48:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734036505; x=1734641305; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mSpM/cySkQR88JEHiMbsxZTNBsH+C3Qxc74QedSJwMg=;
 b=fYlOflId2p1z3a9XQIUvtAom4SGareHjLmDElGSJ4a+CQcr4bLwpQ0cLvb3+YT8dPl
 3NE33OyVOr8JXSKpmAPXL4gYYCuYbb2jK0Cj3zD08X1XqiAemOLSz47I7OCbN3AwPMOK
 QZjd9/mkAVu7QDox3Ud+Jg04sB+0HVmARzPc84OyIbWjUBD6RmYLs+BEtZ0MSoMMWwVa
 oiKdoHge9l9/g8MQpTJBlsAuQwFI8KxYB6P+dTV+uha829zKouk4rdTuyUY15iTOAYwu
 s0/+qsChfeLwnK3XiUfKBUMWG4KSKSenEb3fP/9oGZmWUuFujfLToNfDi1KG1nkhTqPw
 m1cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734036505; x=1734641305;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mSpM/cySkQR88JEHiMbsxZTNBsH+C3Qxc74QedSJwMg=;
 b=jmEIDM5ktTWK8wf00FyzQnJ3clg4OHwzZlup1w72ffzdt4giz+HRe4Z3w7TBKbqbei
 lYs1z5Egz0UTe1V2DDXz4RdMtwZVSCg0FN4izZa8omqFOe1LAiYE8bpznKFUgHuXTlm+
 A8JjO8eFnR5OMaLWnEiSMO9yVWPT6yj9lUsAqQ/qNZGUhDYfaoJYP81AhuB6wRMGbHME
 nWYqxh89x3CNiziOJnrH4N0/BbboXhP4JssLKeP2RBEsSKFHmNbxKGJEz6AeeykMcFma
 JA9W5DuQNL+v7OGdWhVyLF96G1w2N0/7YXHA7MJGNNYtDiDyPTVRqCDP8szGtoOjdJ9b
 qtCg==
X-Gm-Message-State: AOJu0YxQ/7zrZEd5jyrT7zBmcsSqYKr2mvNRDX2/qly/vuU6YTqd+OVK
 CT9OGueyciNRVHu9gApEdH8sURJSjRLj78nkhK5KhikCS03eupu5AvCJd1odj0ki70SCqlmMnmt
 U9iK3Jl7h
X-Gm-Gg: ASbGncsE8oa5dtcJto+1rOv/uybArW1Sczmelm4C0TOslN/TnyDG077WL0Nsxc4gTSD
 opLVVE7TkxfebMw767Fv0yd2hOT1QI7G/IPZeKaWPkiRv9fGXaXXYOgltr8bwKawQdYxv5DZyDH
 cm7+HuTWNyS1obRKBpsBsvELa+S/RGsp0LMt29T3af0bh6e0iSrOsCCk8A3+HdWZ8eigE4obrLU
 Nn6aaUecarE9ofSDpBmqrJ3Uk+bg7VLDWsCfn+j9pKfdn34jZuROGV+i4MpqeRd
X-Google-Smtp-Source: AGHT+IEHdjCVPyjg5OvMhFRLnpuRl7C0YZyocogpv2ifcwscOtbU0ASilIgX6Y8c6HWEUrkWyUrTnQ==
X-Received: by 2002:a05:6830:490c:b0:717:f666:9559 with SMTP id
 46e09a7af769-71e36e862acmr1008373a34.9.1734036505327; 
 Thu, 12 Dec 2024 12:48:25 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5f2b8197b58sm2129758eaf.12.2024.12.12.12.48.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Dec 2024 12:48:24 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 3/4] include/exec: Introduce fpst alias in helper-head.h.inc
Date: Thu, 12 Dec 2024 14:48:17 -0600
Message-ID: <20241212204818.2468583-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241212204818.2468583-1-richard.henderson@linaro.org>
References: <20241212204818.2468583-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::332;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x332.google.com
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

This allows targets to declare that the helper requires a
float_status pointer and instead of a generic void pointer.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/helper-head.h.inc | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/exec/helper-head.h.inc b/include/exec/helper-head.h.inc
index 5ef467a79d..bce5db06ef 100644
--- a/include/exec/helper-head.h.inc
+++ b/include/exec/helper-head.h.inc
@@ -23,6 +23,7 @@
 #define dh_alias_ptr ptr
 #define dh_alias_cptr ptr
 #define dh_alias_env ptr
+#define dh_alias_fpst ptr
 #define dh_alias_void void
 #define dh_alias_noreturn noreturn
 #define dh_alias(t) glue(dh_alias_, t)
@@ -39,6 +40,7 @@
 #define dh_ctype_ptr void *
 #define dh_ctype_cptr const void *
 #define dh_ctype_env CPUArchState *
+#define dh_ctype_fpst float_status *
 #define dh_ctype_void void
 #define dh_ctype_noreturn G_NORETURN void
 #define dh_ctype(t) dh_ctype_##t
@@ -96,6 +98,7 @@
 #define dh_typecode_f64 dh_typecode_i64
 #define dh_typecode_cptr dh_typecode_ptr
 #define dh_typecode_env dh_typecode_ptr
+#define dh_typecode_fpst dh_typecode_ptr
 #define dh_typecode(t) dh_typecode_##t
 
 #define dh_callflag_i32  0
-- 
2.43.0


