Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B5EFCC6B33
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 18:09:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHPtJ-0003nr-VH; Thu, 15 Oct 2026 14:09:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xHPtG-0003n7-5N
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 14:09:18 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xHPtE-00011J-1I
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 14:09:17 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4a018dc1f98so45280735e9.3
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 11:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792087755; x=1792692555; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=cb83B0DVu7VB0LbtmGD2wsC1zLnnqxfUynf1dn4QGkA=;
 b=lFbhy3s1ZQh+jhOBSoy4oUietNPbdpPoEVfYumk76QLUBHWWUej5k4f4cDP9NgMO0e
 W+1P2OEKiL/A6pTAbQyLagD6DYxD+zLymoXlZYbRUu+iHWcCOh87wOiZQJQUSpmScEfG
 GElzndZeRK3yZuxF/Mygl81FKpfv4rL2paoZpYXihno0LcCBClVHSmeWNV4ruCm4uuCs
 mpbtZY/baOt3I9xeTJrHBtNGvlmGJiUBTPKfcG3oUAIXURwHIdR8mPd7hKD5kzmezpl5
 bVia/CRChDgVph6dAeng6WgY5sFoP4VaTwcq9bGQp6/TUG0sv27AJfz4kNij1ez9VrMz
 cs4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792087755; x=1792692555;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=cb83B0DVu7VB0LbtmGD2wsC1zLnnqxfUynf1dn4QGkA=;
 b=KwipuyFDCCeU6HnWF3HCMJIrkzbzhsugXSQ4M2BOUI9cd0zKHWsCw86qRUWDeq09/o
 xqKj1xXKrXT/WaJh+D9dqIRQsV9Gg+BNdJPtbVgHjj4w113CIJEWyQTH491Di08Cj0Q2
 HdQswXMqPXg0OV4hmPwiR5ZgMCQ//4/FWvV2McYQZ6hswqwk3dP0iDy8OddA9XN8tdD0
 aRdOOQKv0r94DB3CZZqLi8mFRlL37tpjNOUtRcjJFEKH/fVDntGxOLAouErQUimaHUSc
 m+dIyhlg/76dAY8lKM2KjUZg3HbXHel6/EKMLZgSMjLcUXV1q0Wzs5n+4MheCGWIxzzV
 tkYw==
X-Gm-Message-State: AFq9FYIXldJwMoS/sYzjhrSCHPPNxfWYhukw/tiU3yeLJkdh3JuYIVOW
 OryEEV7O25d7KHb+CvToeDBO/iDTJ2JV3Eo5uBDlkCD9MEgSLNoJrjHIYcIw/eXVJbBIngenXsj
 3IIMOydA=
X-Gm-Gg: AYBFou0xx3Ue2UzcDw1NzufhwHtZt351XSfuEhoMddV/hK9ZtsLQfpUHJuAB1ZQbr7h
 PZhBLuIYxJ8zlFUkV1yvT33XZf+rv4z5I+prvMiqa65XgrCdWHTNlfeo+qetALf2A98L9p2mtTV
 ayLQxZjlbuYgv/WbxK8VeoSHEmY1bjxN5k24XIrxenDGYw0KxJPm64i+L0ALoWXRRXwSJPO444C
 S4UAcGDueKB/HXLY8+rF7uCBB3MmWFFANfyUbXHKvUzwy74uPkJwHdhII3vi2N2gerjDx+RdVlP
 YDlaXTvA7eruI/lFrmKmSsWMvEC3jIToauftJpXpUhpEfjw5AazFa0CnXaQwh6wPyZXQE8HQDTe
 imLrytFSbIJrFgKNDmTXaqsDsqjDsWn8o5k9v9/gH0n6a6zmbKBGoX7e/gURsh3xjFWsD0+cUZI
 ZPRY76EiszUPBIYmZVPZFxPwTEvnTOmXNmnu2TmlnkDdfO7CBceVgNn06pdlfIzPYtyYN+tLPZM
 l0TinJIKrBCFG3jJM5UmU7OTDWdoqtpZt9EOvgOX6SK4qMmfrVLni5/p3VPbWPvW5e0TRSjtwCp
 8MRVGJkEmJtfdw==
X-Received: by 2002:a05:600c:8b65:b0:49e:6683:d23c with SMTP id
 5b1f17b1804b1-4a18e3ef1bdmr377924805e9.0.1792087754687; 
 Thu, 15 Oct 2026 11:09:14 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de7773d02sm14692701f8f.13.2026.10.15.11.09.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 11:09:14 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/16] target/arm: Squash accessfn in
 modify_arm_cp_regs_with_len
Date: Thu, 15 Oct 2026 19:08:53 +0100
Message-ID: <20261015180858.1863407-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261015180858.1863407-1-peter.maydell@linaro.org>
References: <20261015180858.1863407-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Richard Henderson <richard.henderson@linaro.org>

When reducing permission of ID registers for userspace
access for an emulated kernel, drop the access check as well.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20261010070952.323466-4-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 4cd418b962a..7974c46000b 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -8406,11 +8406,13 @@ void modify_arm_cp_regs_with_len(ARMCPRegInfo *regs, size_t regs_len,
             if (pat && g_pattern_match_string(pat, r->name)) {
                 r->type = ARM_CP_CONST;
                 r->access = PL0U_R;
+                r->accessfn = NULL;
                 r->resetvalue = 0;
                 /* continue */
             } else if (strcmp(r->name, m->name) == 0) {
                 r->type = ARM_CP_CONST;
                 r->access = PL0U_R;
+                r->accessfn = NULL;
                 r->resetvalue &= m->exported_bits;
                 r->resetvalue |= m->fixed_bits;
                 break;
-- 
2.43.0


