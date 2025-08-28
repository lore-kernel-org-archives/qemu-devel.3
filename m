Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2EC8C8303F
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 12:19:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urbXZ-00012m-R8; Thu, 28 Aug 2025 08:15:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbSA-0003ZB-F8
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:10:06 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbS8-0007Nq-BO
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:10:06 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-b4c3c36643aso536656a12.3
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 05:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756383002; x=1756987802; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JxjMxi/5KR08xw8JnjOd2CrQg8f6S7OfdVSLT4S7fM0=;
 b=I6D/y/wHVGkOJiFazYmsYO3HNTC05jXtLcmXCeFDX5uOhBktSSBso3BMoDWL+42PlG
 h2EYMjedwofu+Pa1Tj4PCY4qRHuph9pMS7CGM8KVFztM2yVRaJ4SsE8Q1iCAY+nViXAA
 ic8N/Sut9LS34LBo76K41yEa5UcEs7tc2VlCP4lSyVc47cQp2MEfN9n9/IvA31z9aETr
 EIXXVgScHuWQW3durAfBliqrbdd2+jZPQcPdHqfIGxFaedaaHYFQDJoT/NCkRdMVARy0
 16oeBCkFHWbxXPgN9mfXDk34BTRWJ+ouf+lj/Z9jlsBwOEEvMvR0Jy0Z1NRvuvQJ7+o3
 3v2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756383002; x=1756987802;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JxjMxi/5KR08xw8JnjOd2CrQg8f6S7OfdVSLT4S7fM0=;
 b=Iawmjt1xXezBsr5KiOmub3tSnRcLG++n4prf3V4ascsHQ02bOvJ6aPpPAJO9EkCpJ8
 PH/1Qwx6h7is6FV30kvs93fYNFEAgaaRcyAE2WQPbNYiMecx4ITa6dQi3A2UiE5xvIDZ
 a+GSKZHQfoeL0UkNeYxqesOd8RZbejvnPtEOqA+ebBzu6oqR6azAw6lXSaAofQk+NZBY
 yyA5nFK4YbzFAJtDaPOfu4vQ4iiKPZl8pUe9E8WaUZCymu3iuros9b4jqOguZ98+knQn
 L4xwQsq26yAUCCz03aOVj/L7K4HMG7ISXPT+xprI0I/GROtP/P2SnqNuqRWZA2KP/qnr
 R62Q==
X-Gm-Message-State: AOJu0Yyjf2L+Rs4/5qCSk8Gt5NER9oBsVabCxS7T9ImL3e/S4Gj5NlSw
 qvQ6rrAbWJ40quy5SkHnV7XI+TZpOPDbb6f9mjg2PzBb9DmhyQEl/tUmMFYrruBMbxr+Pl9VabB
 FWh4y4zc=
X-Gm-Gg: ASbGnctP03gd3QC8jj7KVoCQcmKMInVtD7TW440jVyip4JhfeBy1z27ED0IGCBeeVju
 dsuMgCXcHRf47aSbk+5un1tydLELfDsSXH1kClglDDIcn3jzv+GmgAY0Eozuu93naGUcgl73OuF
 tv4sYIxQCRuvQwR3YsUlN/mvUw4orTG8GOKE36MUzHz9W/qqqArovEowzJkh2wNHY8IhxmJFG/g
 bVrK3ssi2jexUASyt4KtStHiCzSCMl4kwu1hheM5D5deHanxLU819JBz8yjKPWoLOSJdknmLHZe
 u2zGg9R/uUKnh2UUYOboFRlUQwaDOMgV//uyFa0+f9Vna/0XZaQkHNzZ2osUbtgP1dmI6w7DwRU
 tNEvBh41SXg4dYp4ybExVgodEjWC2WzDw719XruaTlBQdKJU=
X-Google-Smtp-Source: AGHT+IGjrPVrdxlHQMCnomsOUJcBHjCk7wL9f9Zbb1Wo3CqSJHpnGs6s1YzkWwmXqpGVy6eSXjoLzg==
X-Received: by 2002:a17:90b:53c8:b0:327:cd72:36b9 with SMTP id
 98e67ed59e1d1-327cd723a1amr556219a91.20.1756383002479; 
 Thu, 28 Aug 2025 05:10:02 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b49cb8b4b98sm13933222a12.19.2025.08.28.05.10.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 05:10:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v3 34/87] linux-user/x86_64: Fix dump of fs_base, gs_base
Date: Thu, 28 Aug 2025 22:07:43 +1000
Message-ID: <20250828120836.195358-35-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828120836.195358-1-richard.henderson@linaro.org>
References: <20250828120836.195358-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x536.google.com
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

We were storing the selector, not the base.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/x86_64/elfload.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/linux-user/x86_64/elfload.c b/linux-user/x86_64/elfload.c
index 18d632ec34..12de1c54c7 100644
--- a/linux-user/x86_64/elfload.c
+++ b/linux-user/x86_64/elfload.c
@@ -44,8 +44,8 @@ void elf_core_copy_regs(target_elf_gregset_t *r, const CPUX86State *env)
     r->pt.flags = tswapal(env->eflags);
     r->pt.sp = tswapal(env->regs[R_ESP]);
     r->pt.ss = tswapal(env->segs[R_SS].selector & 0xffff);
-    r->pt.fs_base = tswapal(env->segs[R_FS].selector & 0xffff);
-    r->pt.gs_base = tswapal(env->segs[R_GS].selector & 0xffff);
+    r->pt.fs_base = tswapal(env->segs[R_FS].base);
+    r->pt.gs_base = tswapal(env->segs[R_GS].base);
     r->pt.ds = tswapal(env->segs[R_DS].selector & 0xffff);
     r->pt.es = tswapal(env->segs[R_ES].selector & 0xffff);
     r->pt.fs = tswapal(env->segs[R_FS].selector & 0xffff);
-- 
2.43.0


