Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B755FE7718B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 16:26:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOfhH-0007nW-Bs; Fri, 20 Dec 2024 11:17:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOfgr-0007Zw-PP
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 11:17:29 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOfgo-000809-Tj
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 11:17:24 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-436202dd730so15406195e9.2
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2024 08:17:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734711441; x=1735316241; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eN/chgeK5TLllxsnxAEr9sTVcOcj0cFLmrLq0ykzav8=;
 b=iEhMIMfQEPzeEASF8EYJZHFADVjp8zskYZuEifn0Q1o8fLoXw8mxQXoHs0iGZKPMXy
 wF8JH9rPH6YVH7TvLkQ4H5lHFOt6nxsBKjlD3i3L4JdvgrqtnriDEDxWJJNFgeEWGF6s
 eDdY82Ra0Fz/wQq5AsObNFh031ULoybFEwN58maNsAy2hjKARMM1C4OIuO6DFggm76Pf
 lxKIRWlhyI8LmxkTzydVGZ4dWxjs8RPFQMfDiW92Aq6bCfb0Xul26cyKWMedTAiO7Pxx
 je9nR4dXI/7RuU8updmcRJniQRE2he8n2Z849CP/kinzsDTeWP0rxbOUsfxTVZ6Wl6gH
 wlTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734711441; x=1735316241;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eN/chgeK5TLllxsnxAEr9sTVcOcj0cFLmrLq0ykzav8=;
 b=IaW9k5fUAhrQmVuANNj6+iDJwlbjJxwHBSC8MFUj4uZrY3snrqCyODZ266OBo/o6xV
 Coy1YO2K77xE4mPNqZvG3xp0kvZHxqu0p8DnIU9PXS6oq5TuDL+y9lCUs2CxB2aYdvDa
 2j/wRCL1MFuMtB0p4qh/dDERswOWZfvnaB4a50jnAvv+5uebKCrWJ+vYmqtq/BFobBXx
 yiAP19n19zbzjX2kZbk2qRwCeCfRFtZ0SPeydFflnCBhu99FzR/UuPv6ecU3X6VpUtdV
 Fm71damNvo0Zs9EpTrGYIyEmgjGhGUxcGm1YIhR4R6vcJ2I5/1MohQpWsSuzAYmQErMj
 Tbpg==
X-Gm-Message-State: AOJu0YzkwXWv22u9YFbGycYFsXQDSNve/GAh4XUXAX1c6cfdbrOi8eay
 0OB7oQpGRXF+MeW8juBArqeJJZaSH6L/wLoCgExmnDYOVEWiPFOhUhyM7lEOlXDYBkj4Sx1q45V
 s
X-Gm-Gg: ASbGnct0JTspqQvmXwbIyMrFwr9CI5wFRjexL0mINOcbyKCGNi6+aNKuNafy4biVutT
 ADT3DoU+Ea+Ux9BPdh+kJxUbIQeZHlcVVjV+maex8XkLpe4cLQuXldOTtEziNmjQzqbFALafWkN
 P8xKxtJD56b0RE1Dr5wSWoYxTGicbR1KQ1r8MYq/L00acSuB8Yq0KwJckX2LDpWAOnMnOE3NOhl
 nrOIaRX7klYw121MLk2QF5vKqnk53X/H6pWokmz98+1rafmBs4v7fsZ/D4XvFaLyKrFUAFwvzM=
X-Google-Smtp-Source: AGHT+IFrPX+V/UrYTi0VRYsuFFzH/nKQs5oKW/Gtyco9kwenqHcvb8lzy0GVcJvPSdxgpqbxtBlzpA==
X-Received: by 2002:a5d:5e09:0:b0:385:e328:890a with SMTP id
 ffacd0b85a97d-38a223fd7e1mr3271942f8f.49.1734711441035; 
 Fri, 20 Dec 2024 08:17:21 -0800 (PST)
Received: from localhost.localdomain ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c8292f4sm4473730f8f.3.2024.12.20.08.17.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Dec 2024 08:17:20 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 19/59] linux-user/aarch64: Include missing 'user/abitypes.h'
 header
Date: Fri, 20 Dec 2024 17:15:10 +0100
Message-ID: <20241220161551.89317-20-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220161551.89317-1-philmd@linaro.org>
References: <20241220161551.89317-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

arm_set_mte_tcf0() uses the abi_long type which is defined
in "user/abitypes.h". Include it in order to avoid when
refactoring:

  In file included from ../../target/arm/gdbstub64.c:28:
  ../linux-user/aarch64/mte_user_helper.h:30:42: error: unknown type name ‘abi_long’; did you mean ‘u_long’?
     30 | void arm_set_mte_tcf0(CPUArchState *env, abi_long value);
        |                                          ^~~~~~~~

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20241212185341.2857-3-philmd@linaro.org>
---
 linux-user/aarch64/mte_user_helper.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/linux-user/aarch64/mte_user_helper.h b/linux-user/aarch64/mte_user_helper.h
index 8685e5175a2..0c53abda222 100644
--- a/linux-user/aarch64/mte_user_helper.h
+++ b/linux-user/aarch64/mte_user_helper.h
@@ -9,6 +9,8 @@
 #ifndef AARCH64_MTE_USER_HELPER_H
 #define AARCH64_MTE USER_HELPER_H
 
+#include "user/abitypes.h"
+
 #ifndef PR_MTE_TCF_SHIFT
 # define PR_MTE_TCF_SHIFT       1
 # define PR_MTE_TCF_NONE        (0UL << PR_MTE_TCF_SHIFT)
-- 
2.47.1


