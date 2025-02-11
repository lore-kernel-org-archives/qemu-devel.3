Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34D5BC0219B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 13:07:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thpyG-0001M6-0Z; Tue, 11 Feb 2025 08:06:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1thpyE-0001Lp-5z
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 08:06:34 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1thpyB-0006Ov-UR
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 08:06:33 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-38dc660b56cso4281140f8f.0
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 05:06:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739279188; x=1739883988; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=KvkNjTeRragMRh+PEtaxFCPvqzPT6cVpx4DPzGg4c0s=;
 b=tjl/laxuc+fuBvzw5+4OiQTJOVFAdUZqWKeHu85UOFpnyxkPViNhCd2vqDAZWiENLr
 E9FfHEdkmWD7vRHhrgrw/d/ExqNHAlkh2I0QTRDKohfSI1XJd9bdIcSvbHDwcAUyG7gy
 /TYS0Mb2CQyBmIg1Nh7gwaDoLTM+Lof5SibfhzkjRVg9LO1kN/mKpmMZevu4wY3+5/Xe
 SccMxVJUMCqH+2FDBgO96FuOYsUAYmyc1p3zX9maKp5oA9QTLOXSQl6whWioxCfp6rtd
 OqpfMRJxv97Uo6Np8/37PRJOc/VloJtv5H8PgHSa3rW0Fj1qvmMsR+VtVfO/z+EZ2164
 TpFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739279188; x=1739883988;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KvkNjTeRragMRh+PEtaxFCPvqzPT6cVpx4DPzGg4c0s=;
 b=I8278SCBj1phBWFij7YlA9uBiBHHptgHbcpZjezQM+CcaASgEBSHWZpciiIwSNJytE
 SLOxQkQO+uNwsy/Y84/xf7e044C+ehdtRD5EiD7AJhycG8cFe7VWS0Ojv1aJUX1VWg5B
 GMWmU06Slvcu6/H9AF+L1MzWDewCiujRTpM8n3V9kqnwdDS8xhKZnUlfz4o6ZUGMfUT8
 lg492crF6esGlBHNcKEA/ghXoJfxxQfERcK3gEaSYr3sBDYMlBZzW5F0MLDmgJnIhTts
 A82PgFW0+ATlS/UBU9cdJgr2zBT21y7y6TdjWCgAtbVEvD4zT7fugg91aHk+7+QVzVhm
 VccA==
X-Gm-Message-State: AOJu0Yx5RnoSQo7y8hT719av9E74EN8qervcSHEH2T4nfdTj5srmSZJ9
 /N188ujo8Z9JoKCOMelhBTypc3PGy/SxOXLwpidFAXzY4PA9YBIhRhSOi9sH4WqriBCzGt9S4SY
 L
X-Gm-Gg: ASbGncs197Qho1a0erGfkVz48YuUTliixvJ38zf3a/Aq0YVhKNbINxPEZLkPhDcr2Yt
 6btR30BW2ytXl6Odl8tzEzPvG8ZFkl7coOpohlgxLCLZXODqTzs4EEMnr2dZmw0TAebLa8OwzfJ
 Kg4pg6CABPhdJH1ECn2M0Eu7xMyX3RJSzWXbmwT1zDLoFdO2KVzJ9JLQHt/mGnSpkhmcVkEqArb
 1Xt8kOen3qiS8b8X4ff3p8HRxcrWq1TTZqOtfeYzcELDDg8VeU5HQ3uWOWeNAWE9lWrcFlCfdT9
 gyRSvOmdUsRgcYRNOoDE
X-Google-Smtp-Source: AGHT+IFqm0OI+kd+S8btlE3uTQMsBbHTMR0FGbnZgizCu6sInTViMxuO7OYOOHeyqu3Mko6XCsMzLA==
X-Received: by 2002:a5d:47a9:0:b0:38d:d9e4:9ba0 with SMTP id
 ffacd0b85a97d-38dd9e49cccmr9174097f8f.25.1739279188519; 
 Tue, 11 Feb 2025 05:06:28 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dbdd1af07sm14973737f8f.15.2025.02.11.05.06.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 05:06:27 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH] target/alpha: Don't corrupt error_code with unknown softfloat
 flags
Date: Tue, 11 Feb 2025 13:06:26 +0000
Message-Id: <20250211130626.3940412-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42d.google.com
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

In do_cvttq() we set env->error_code with what is supposed to be a
set of FPCR exception bit values.  However, if the set of float
exception flags we get back from softfloat for the conversion
includes a flag which is not one of the three we expect here
(invalid_cvti, invalid, inexact) then we will fall through the
if-ladder and set env->error_code to the unconverted softfloat
exception_flag value.  This will then cause us to take a spurious
exception.

This is harmless now, but when we add new floating point exception
flags to softfloat it will cause problems.  Add an else clause to the
if-ladder to make it ignore any float exception flags it doesn't care
about.

Specifically, without this fix, 'make check-tcg' will fail for Alpha
when the commit adding float_flag_input_denormal_used lands.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
I guess I forgot to run a 'make check-tcg' for all targets until
I was getting around to queuing the FEAT_AFP series :-/

 target/alpha/fpu_helper.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/alpha/fpu_helper.c b/target/alpha/fpu_helper.c
index 63d9e9ce39c..f810a9b6a47 100644
--- a/target/alpha/fpu_helper.c
+++ b/target/alpha/fpu_helper.c
@@ -476,6 +476,8 @@ static uint64_t do_cvttq(CPUAlphaState *env, uint64_t a, int roundmode)
             exc = FPCR_INV;
         } else if (exc & float_flag_inexact) {
             exc = FPCR_INE;
+        } else {
+            exc = 0;
         }
     }
     env->error_code = exc;
-- 
2.34.1


