Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A18FC021AA
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 19:32:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk6pl-0002mx-8R; Mon, 17 Feb 2025 14:31:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tk6pC-0001zV-4u
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 14:30:45 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tk6p8-0008RT-02
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 14:30:37 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-220dc3831e3so66724015ad.0
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 11:30:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739820632; x=1740425432; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d1zb22AyjlqmHw+UQQqRIL7eiAR7k2i23HZM7g6s8GU=;
 b=OquQvsvn/+GYRvFyn+egjNMJQeba5IZ6E+iNUEV7zHNkXK1898FNytiOfQABDaePZD
 tlXpKYaJL9zUNMuRzKVLyC1MJ754Mi7H1a/bPANBtwdZh8rE5MMQrth+i1HqPRAbs8m8
 YX05OX6gE7Ghzxm6vcP2hJBOWxV8teJnSsh4+1EGZ74D7uKJvdNSkJfCSyREwSf5EiaK
 pbOxI08P0+Frw0B00zS/pituRRaCJxBFdB8NOknsPDyP8k5H1n3/VLvNxm5HgGuLTGtD
 TA59lNV7T0XZcutfgBk2Mb3Ci7pub/y2IDdLxlcM1O+GtzPt5cvNRfVHU8QX8krW+Di0
 YuIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739820632; x=1740425432;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d1zb22AyjlqmHw+UQQqRIL7eiAR7k2i23HZM7g6s8GU=;
 b=wwZETN/j+ug7iV6xPYcnOM/9EdW9yizdRGqMLeTNa4iuPdblCTTNCI3541F9VwsFZT
 tULh6FYFPYZljCGzvvgG4PAecMT6FA1aTcyd7I3vM2MgchLewc5ACbwndGB8qZb09xrC
 2oBCNzQfJxy+bWo4KQsSRGkjLbDs37y/ITnMsMac5Xvpjs/708z70aG8Prt9a7VF4WWP
 LxoNO2psvPfYTAuy7LnG1PskA3R0SCy6axKxQIkpl0qCI5ytbyM4RC1q9Bb3RGmWrIEd
 Ytdv8YQX7GB4PwuiLdeE1EP52+u7PpLQURjgY1bZrcGp7BAghnr3O27s9E7mF7Yf4C8+
 IT3A==
X-Gm-Message-State: AOJu0YwBSGm2+HmSfYd35CJSgl7CMOenFE3gQ0+V7LGpFYs6nmak4xPE
 omzAlDJzuLNPSTpoMfnHNYVRK+1UajOGbIiXHFY9WopFfrspSTvTTL7/C2BsSwPAEHq8f0/Lpvv
 9
X-Gm-Gg: ASbGncttZC9/HFdssXLDwTZp0OPHL7OB05WfgApn12Uz2z9pUBzIuhU3TTod3KHb+Yx
 yM3b8JwRQZobIYxkfpTFokpTZGwUplNB5AZZGDaHPWrq7QbNbrke3rwbmL3ZE/idLg5+P5iscUs
 b4S3EL8XnDM4fN77aRLTLjmPn859/Y9FWqLHgKBiXaVSotZ+papkGvArQ5ie3ypCXMAi4L2A9sQ
 6qiGzZ9RKO8TO+t4SLUyjqsvTK3Nk76o3PBKlSZfHG5zsc/MCQppO/kQypwoHVGIS561EvNnNmz
 iz2Ttv5oNweDuCHF7CLDNVx2GWbYxy26bxCF7EVW/BZuvyo=
X-Google-Smtp-Source: AGHT+IG6FhL9GJFL8+DIF3H88xaThTVcronUGyLZuFH+4tQou1WNp4L8e7i8zikp5D70i/PUk6bEyA==
X-Received: by 2002:a05:6a00:4fd2:b0:730:949d:2d52 with SMTP id
 d2e1a72fcca58-73262158ademr17638718b3a.3.1739820631952; 
 Mon, 17 Feb 2025 11:30:31 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7326a38ff76sm4347164b3a.160.2025.02.17.11.30.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2025 11:30:31 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL v2 26/27] tcg/i386: Use tcg_{high,
 unsigned}_cond in tcg_out_brcond2
Date: Mon, 17 Feb 2025 11:30:07 -0800
Message-ID: <20250217193009.2873875-27-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250217193009.2873875-1-richard.henderson@linaro.org>
References: <20250217193009.2873875-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

Eliminate code repetition by using the appropriate helpers.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target.c.inc | 65 +++++----------------------------------
 1 file changed, 8 insertions(+), 57 deletions(-)

diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index cfea4c496d..33d303a123 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -1658,6 +1658,7 @@ static void tcg_out_brcond2(TCGContext *s, const TCGArg *args,
         tcg_out_brcond(s, 0, cond, args[1], args[3], const_args[3],
                        label_this, small);
         break;
+
     case TCG_COND_NE:
     case TCG_COND_TSTNE:
         tcg_out_brcond(s, 0, cond, args[0], args[2], const_args[2],
@@ -1665,64 +1666,14 @@ static void tcg_out_brcond2(TCGContext *s, const TCGArg *args,
         tcg_out_brcond(s, 0, cond, args[1], args[3], const_args[3],
                        label_this, small);
         break;
-    case TCG_COND_LT:
-        tcg_out_brcond(s, 0, TCG_COND_LT, args[1], args[3], const_args[3],
-                       label_this, small);
-        tcg_out_jxx(s, JCC_JNE, label_next, 1);
-        tcg_out_brcond(s, 0, TCG_COND_LTU, args[0], args[2], const_args[2],
-                       label_this, small);
-        break;
-    case TCG_COND_LE:
-        tcg_out_brcond(s, 0, TCG_COND_LT, args[1], args[3], const_args[3],
-                       label_this, small);
-        tcg_out_jxx(s, JCC_JNE, label_next, 1);
-        tcg_out_brcond(s, 0, TCG_COND_LEU, args[0], args[2], const_args[2],
-                       label_this, small);
-        break;
-    case TCG_COND_GT:
-        tcg_out_brcond(s, 0, TCG_COND_GT, args[1], args[3], const_args[3],
-                       label_this, small);
-        tcg_out_jxx(s, JCC_JNE, label_next, 1);
-        tcg_out_brcond(s, 0, TCG_COND_GTU, args[0], args[2], const_args[2],
-                       label_this, small);
-        break;
-    case TCG_COND_GE:
-        tcg_out_brcond(s, 0, TCG_COND_GT, args[1], args[3], const_args[3],
-                       label_this, small);
-        tcg_out_jxx(s, JCC_JNE, label_next, 1);
-        tcg_out_brcond(s, 0, TCG_COND_GEU, args[0], args[2], const_args[2],
-                       label_this, small);
-        break;
-    case TCG_COND_LTU:
-        tcg_out_brcond(s, 0, TCG_COND_LTU, args[1], args[3], const_args[3],
-                       label_this, small);
-        tcg_out_jxx(s, JCC_JNE, label_next, 1);
-        tcg_out_brcond(s, 0, TCG_COND_LTU, args[0], args[2], const_args[2],
-                       label_this, small);
-        break;
-    case TCG_COND_LEU:
-        tcg_out_brcond(s, 0, TCG_COND_LTU, args[1], args[3], const_args[3],
-                       label_this, small);
-        tcg_out_jxx(s, JCC_JNE, label_next, 1);
-        tcg_out_brcond(s, 0, TCG_COND_LEU, args[0], args[2], const_args[2],
-                       label_this, small);
-        break;
-    case TCG_COND_GTU:
-        tcg_out_brcond(s, 0, TCG_COND_GTU, args[1], args[3], const_args[3],
-                       label_this, small);
-        tcg_out_jxx(s, JCC_JNE, label_next, 1);
-        tcg_out_brcond(s, 0, TCG_COND_GTU, args[0], args[2], const_args[2],
-                       label_this, small);
-        break;
-    case TCG_COND_GEU:
-        tcg_out_brcond(s, 0, TCG_COND_GTU, args[1], args[3], const_args[3],
-                       label_this, small);
-        tcg_out_jxx(s, JCC_JNE, label_next, 1);
-        tcg_out_brcond(s, 0, TCG_COND_GEU, args[0], args[2], const_args[2],
-                       label_this, small);
-        break;
+
     default:
-        g_assert_not_reached();
+        tcg_out_brcond(s, 0, tcg_high_cond(cond), args[1],
+                       args[3], const_args[3], label_this, small);
+        tcg_out_jxx(s, JCC_JNE, label_next, 1);
+        tcg_out_brcond(s, 0, tcg_unsigned_cond(cond), args[0],
+                       args[2], const_args[2], label_this, small);
+        break;
     }
     tcg_out_label(s, label_next);
 }
-- 
2.43.0


