Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA84CC369D3
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 00:54:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7kmk-0005Cd-Cq; Wed, 23 Apr 2025 20:49:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kmi-0005Bc-FK
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:49:48 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kmg-0004KH-Pz
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:49:48 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-7370a2d1981so306121b3a.2
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 17:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745455785; x=1746060585; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2WELs9tSDoOhv8oNl+uvddaNLwloxys1OzwUaiFl4qY=;
 b=kShSzXiysginPpDpA4J3l64+KCA2lkwa5SXPam5O9eq64OEkRIIsPAr8T4tyyf0tkF
 Cp5xHsMnmjBrHN7MjgQtmsAGcMyPkb2ULPJcgtWGfStLIWV04Ef//JgIlq6C5YnY9pk/
 GnAvN97cnsg10tHig/LmwCVJ+8dKcjTVM4NFWTB6D9ItUWwQwrw9LY099tM8O7LUqzEJ
 /ozo8XsmvHROTDs34/8u+ViewwEU4eeU3GR91QJONKTGhJsqAzmnQPaZz8Ei/yxYpFcv
 clKAqIEqRcXGFIYiSTgEixO40UBFMgNu6qPb1vgT5A1Ig4YgEUwh2T3CedEtCwjqqGtW
 wSTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745455785; x=1746060585;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2WELs9tSDoOhv8oNl+uvddaNLwloxys1OzwUaiFl4qY=;
 b=FipO6ho+8a6YSf+zn0cY8RlGsDe8vDRbEph2HAqVj3lQO6aWJp38a7r1zAHebskkMu
 ySDg4HD5raMX4VVsk35W6iiOC/c9tSRVlXJfuDNKuAHYvo6nkejc4PtDG9epoHR4x0Sk
 1EvAtZYnDDJNTa7T3IvIi/s+2xhKQZNC6VaB0nmONFupYH8ILnakPmt5eRs31jqf4PWj
 MJ1rtIm2yiLJlKpEp5t2SCq9YsnL5f/oCKNDx1C+XH0/LX7am9OlD/biEs0Wv9mVks9l
 gMHb/NxzN9JBfZBNGajGqO+76DBqqZjarx8WM+qf+xgAo45LHf7sQ/iaV3xyiwSfIm5P
 p8Bg==
X-Gm-Message-State: AOJu0Yz2+8MUBdqvSndYtM1NPnAOMAJzcfGMekJZ+STFTFDuxEPfylc+
 YH4GW12Km1q/qGkOIUIen79NE0e31vOm92nViuCiGzQOeNwcQ3QcYZC4FKSbV4NKNC0IHtC8O1S
 X
X-Gm-Gg: ASbGncti42CeO7X2tdPXxSJxwgGLIlrP7IkTRN2Gzd0sIdGQcey2WrwP+wd4UKtIEZ/
 GrmJZ+KPViV25ityGRX/yi4/zhfbk7fvyhow87pncuQns+ARAF+j3I05/qqqimLwTGiARmwxtH8
 BAy0/rt41A/DCqEif3n4KvKdwkE0USDwIj+y+C+D19iyMuHcG9IFCDr7/BSljV92lwtrPxYHAwp
 kDw0ErtsXhxV/RQxQyEifZwU64Ku6KUPBnwSynQ2HnBUjyXHKojvt/8Tfp/N+0O8IFfOeqUt5Ob
 7pi9okVhxwk2Eji5YUnMY036/fvl0zmY6WseUIVuQqpjCMYwPGsav3+prKAv6WJtFd0LOoXYk0l
 veg4qJhbECA==
X-Google-Smtp-Source: AGHT+IF0kqTXtNFZl8t3F4mdlu8hVGjLBI0iHTRkdd7fydQWe6bgWUeoRs8zE3nKEbsCVfvtx3WLkQ==
X-Received: by 2002:a05:6a20:158d:b0:1f5:9016:3594 with SMTP id
 adf61e73a8af0-20444e9b4femr898600637.18.1745455785146; 
 Wed, 23 Apr 2025 17:49:45 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25a9a0f1sm207344b3a.137.2025.04.23.17.49.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 17:49:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 014/148] system/physmem: compilation unit is now common to all
 targets
Date: Wed, 23 Apr 2025 17:47:19 -0700
Message-ID: <20250424004934.598783-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424004934.598783-1-richard.henderson@linaro.org>
References: <20250424004934.598783-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250317183417.285700-15-pierrick.bouvier@linaro.org>
---
 system/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/system/meson.build b/system/meson.build
index eec07a9451..bd82ef132e 100644
--- a/system/meson.build
+++ b/system/meson.build
@@ -3,7 +3,6 @@ specific_ss.add(when: 'CONFIG_SYSTEM_ONLY', if_true: [files(
   'ioport.c',
   'globals-target.c',
   'memory.c',
-  'physmem.c',
 )])
 
 system_ss.add(files(
@@ -16,6 +15,7 @@ system_ss.add(files(
   'dma-helpers.c',
   'globals.c',
   'memory_mapping.c',
+  'physmem.c',
   'qdev-monitor.c',
   'qtest.c',
   'rtc.c',
-- 
2.43.0


