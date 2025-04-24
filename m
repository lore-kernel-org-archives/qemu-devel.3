Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D1C5C369D1
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 19:08:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u81vO-0007Ba-Ks; Thu, 24 Apr 2025 15:07:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u81vJ-0007A2-Bq
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 15:07:49 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u81vG-0004Cm-GD
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 15:07:49 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-736b0c68092so1199021b3a.0
 for <qemu-devel@nongnu.org>; Thu, 24 Apr 2025 12:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745521665; x=1746126465; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=TP4Q9rzJluVzd5O9r6CuXRojocrwY/XR62UryJPD5ts=;
 b=nmzjbLQrd8hD29rAdryMv/B0L0CYQ/Fz9E6H2XuttoLWKhQqXsgmyRt1Vk8tYa6lO0
 +hCjZFYbzxSro098/OQwveqUILPt1bcQekWDDm1Sdef6SViWVaMXPXBRX0qkndS2NUMK
 vrvssmhIJvxrAKwHlEY6yEz1T2e7z853yEYV2HCnkDwMgnzpzYuQmA1wlvLK5PFMK6g5
 J3+PmvXMCTNKEFvn6A987H+l7BaAfTcjk7sUtGpM3PjfxF+jywqMZBIV2wWgQaXVPh1X
 b7g3Nzg/XA7XFoXAUkCRM7d6GDUFbuDOIWxZ/ZeyFnfzSrodyzzmPao6emz0SXLdCgBh
 MyoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745521665; x=1746126465;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TP4Q9rzJluVzd5O9r6CuXRojocrwY/XR62UryJPD5ts=;
 b=AEeBp8ljsVxuEvsI+cjpOCsd1zm/hqWCDrF8JBpDZWdfaKZlWzAiC99KcIsCYzVS8w
 rzJGlZX+vo0P2ZGPm52BZTo2OgPCs8HtNNLMAc7eeeAGfI4irjHl0/oCedyw4Bs6jw7G
 3UxEqR36urHHfdqj/wrwVm/5W7dJ+hKPYcrn9mgJJRroKb73RCOYe/O3tf6177Q8FT9X
 /F4sDTaTa6+0Hg241RWYsJT59gJCVIJZn7W/CHlyvf2b1eo4LGTYSyLTrTTXIE/nAtx4
 Y/aoqbbwVDdx7+dLe+3S+Gl37W2xTLs/TuiJBFIco5puNiAlwDX0YclpqTQ5gUl+/OFa
 YB+Q==
X-Gm-Message-State: AOJu0Yyj+VsQhDvdSVGnHK0rEta5VCwGYWKWDi+eHz2cJI5KUbvDySX8
 5PE/S8W4r55TtA7yKsDVOskB4TTPKUhA6q+1yAmP+Gmz+eNNTl7BqgqPlXIZS26p4jL/CgPqaNq
 o
X-Gm-Gg: ASbGncsLJrKGZPhPEplxMEgahXtrGjnytmN3K2fFiqYvbmOeEhU6S6/uTJKhB5SSnfp
 +Yx3Gghml7TYX1kPb4RwzxwA/1U2NNICLUiVwNVJv02bjdriXrQHK1CRn1cKDdPp246oblZysuO
 8S9bRpYDq3NTVyXCMkS5WdXo9yMdCOQfYLoxEqQ375hEE+O/aYUt1ksgm2UPl2UlX2QNKrKoePj
 8TrvycR0PZmkhV96Y59GIt7YnAZSpQZFA86OCKEZTXC0AqdsXxaa+oER1BYNyg3WfbRpu2PXBvA
 gIKfBKUlE2cg+sYCaLPrlxvat1iVdpiLkt/IalXlXvDsZQfX83MvZeZXouKc05hMwat9wn1Q8n8
 =
X-Google-Smtp-Source: AGHT+IEdIGgHbX2zmkaB5N/zgRiO4SAMETDbLzKQGFDOA0fNveCUbyiuG+LsXzM8lHe9vZnGQpgjAw==
X-Received: by 2002:a05:6a00:3e20:b0:736:a6e0:e66d with SMTP id
 d2e1a72fcca58-73e245ddadfmr5059117b3a.6.1745521662988; 
 Thu, 24 Apr 2025 12:07:42 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e259134d5sm1846463b3a.19.2025.04.24.12.07.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Apr 2025 12:07:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: git@xen0n.name
Subject: [PATCH 0/2] tcg/loongarch64: constraint fix and improvement
Date: Thu, 24 Apr 2025 12:07:39 -0700
Message-ID: <20250424190741.738515-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

Fix an assertion failure in sextract64 which shows up in make check.
While in the area, improve the constraint match for VCMP.

r~

Richard Henderson (2):
  tcg/loongarch64: Fix vec_val computation in tcg_target_const_match
  tcg/loongarch64: Improve constraints for TCG_CT_CONST_VCMP

 tcg/loongarch64/tcg-target.c.inc | 48 ++++++++++++++++++--------------
 1 file changed, 27 insertions(+), 21 deletions(-)

-- 
2.43.0


