Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 225A8C83000
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Jun 2025 20:50:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uVG1H-0005KU-AV; Fri, 27 Jun 2025 16:49:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yodel.eldar@gmail.com>)
 id 1uVG1F-0005Jn-M6
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 16:49:57 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yodel.eldar@gmail.com>)
 id 1uVG1E-0005Gx-2p
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 16:49:57 -0400
Received: by mail-pf1-x444.google.com with SMTP id
 d2e1a72fcca58-7424ccbef4eso460236b3a.2
 for <qemu-devel@nongnu.org>; Fri, 27 Jun 2025 13:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751057394; x=1751662194; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0gSz33xHmaVtu30g6vxInvrZ9e8pSFX2qbDlfLsKI7Y=;
 b=D89J2BCTJUIE/n9SUNjlyFxTEDzjJdq2mwWyg7QzIxLzDDvor1dWPW66rxMzkmmKjC
 sZl4w3ICm7nFs0jLKq9G7U/cxgvUUOVM2gIspfqX0OnDTmVRnvp57UZX2HkzUW+l7H5C
 4/OpUBLfmwIJzWmrvVOfmTwmcz0Y5WfstT+OVFb3Gv1IEYsobKhbJmm6wHLw8ptWDFzp
 vC87DhlN20ouzcL+FA8OMCekht4plrZoWZmrjjV8D/XzmZURPdABoLyPswNjLl0+OSxD
 m+UEdezk0fKaoS/h5FjHZ/P69HqFJEAt54cPM+kOg2wYwHniLKmZYrTlmkUWi3QxgaJq
 23NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751057394; x=1751662194;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0gSz33xHmaVtu30g6vxInvrZ9e8pSFX2qbDlfLsKI7Y=;
 b=pNCczYHFpgmMVKIxrADT2t1/CAea6ibTtEPtuzrTDJIMqJjnspRITCepW6Cpof+vDL
 QKXZHJ2kd/lpby1jQlDfaw4hITuY8Mu5fInrzw9CFpmOZiPg40ESp2O85xHMmpioypqk
 dREI+AdU0tHA1X5uef9E/1pQze4LZyyKSvvpB6nR2xrZDgcVmkAnZEHnzw58scITEbGk
 8BU4ropqrwVTdx0lWv37iNHrswBgprcbBcjW/OvR+lQ66V6C+eQyUo7wHng7NQv428PJ
 COP+9bjKOcPxd0cHzJWyxbGh5SYZP/Y5ddShgZMp3MRK3AG1nnW6e3mWnIvj0YQlUJsk
 Ot4Q==
X-Gm-Message-State: AOJu0YwZ5h7C81HRj3PKfYx8q1bRnuF2uHR83a232uK1EapryD48hxi7
 i1D3wCqEv+PF0e9YdP/qo0VNbbGZZtIrjMHPVeng5++6Tr+Q4QOtFR9+BCaFR9SE
X-Gm-Gg: ASbGnctNO5HIEGYoOla3HIyxWfiBWhQmLvoO60u2Oo2sfQI8j3dZdS5ufKetRpx63PI
 asMnyHEifMWPbG8mLGLjNRw9Yg0KjWeCxeun5ELcnc5BCaCHSMBH38yW9isjtQspDW14Ltw1wfp
 LZC7oayhFskaeOeDQONRm/+cqFBPTybd202BbO5raiGISAG3QVstC8ZDTi/yWY8CxQg43TOSjqH
 hxd3NrGOdPjppsQOYNElE0Yycbg5BkLYvOA7uKxuOjw0pXCa3utB/Rhd7B/qDBT8d/GypAsoN/r
 imLejIOABO7gTDeI7zETAodl6QNz2ab/nzENcNaCwEGY9myIlgyEBwu9Bw==
X-Google-Smtp-Source: AGHT+IHNHnE5n184IoXzFk0mUO1CUl5fl/zwGo3fARm7ohp4TdgowSTtvsb//f3+ffj5WhVnT148aA==
X-Received: by 2002:a05:6a20:9194:b0:1ee:8435:6b69 with SMTP id
 adf61e73a8af0-220a129b630mr6343737637.1.1751057394513; 
 Fri, 27 Jun 2025 13:49:54 -0700 (PDT)
Received: from darlin ([89.187.185.165]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74af557b3bcsm2977538b3a.101.2025.06.27.13.49.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Jun 2025 13:49:54 -0700 (PDT)
From: Yodel Eldar <yodel.eldar@gmail.com>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, richard.henderson@linaro.org, laurent@vivier.eu,
 Yodel Eldar <yodel.eldar@gmail.com>
Subject: [PATCH 1/2] contrib/plugins/execlog: Add tab to the separator search
 of insn_disas
Date: Fri, 27 Jun 2025 15:47:58 -0500
Message-ID: <20250627204817.47595-2-yodel.eldar@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250627204817.47595-1-yodel.eldar@gmail.com>
References: <20250627204817.47595-1-yodel.eldar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=yodel.eldar@gmail.com; helo=mail-pf1-x444.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Currently, execlog searches for a space separator between the
instruction mnemonic and operands, but some disassemblers, e.g. Alpha's,
use a tab separator instead; this results in a null pointer being passed
as the haystack in g_strstr during a subsequent register search, i.e.
undefined behavior, because of a missing null check.

This patch adds tab to the separator search and a null check on the
result.

Also, existing, affected pointers are changed to const.

Lastly, a break statement was added to immediately terminate the
register search when a user-requested register is found in the current
instruction as a trivial optimization, because searching for the
remaining requested registers is unnecessary once one is found.

Signed-off-by: Yodel Eldar <yodel.eldar@gmail.com>
---
 contrib/plugins/execlog.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/contrib/plugins/execlog.c b/contrib/plugins/execlog.c
index d67d010761..08fc1f12d4 100644
--- a/contrib/plugins/execlog.c
+++ b/contrib/plugins/execlog.c
@@ -232,12 +232,15 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
          */
         if (disas_assist && rmatches) {
             check_regs_next = false;
-            gchar *args = g_strstr_len(insn_disas, -1, " ");
-            for (int n = 0; n < all_reg_names->len; n++) {
-                gchar *reg = g_ptr_array_index(all_reg_names, n);
-                if (g_strrstr(args, reg)) {
-                    check_regs_next = true;
-                    skip = false;
+            const gchar *args = strpbrk(insn_disas, " \t");
+            if (args) {
+                for (int n = 0; n < all_reg_names->len; n++) {
+                    const gchar *reg = g_ptr_array_index(all_reg_names, n);
+                    if (g_strrstr(args, reg)) {
+                        check_regs_next = true;
+                        skip = false;
+                        break;
+                    }
                 }
             }
         }
-- 
2.50.0


