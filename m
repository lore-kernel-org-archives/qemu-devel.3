Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C87B1CA1000
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 16:08:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNmP-00073H-8K; Sat, 30 Aug 2025 11:46:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7bx-0004tr-Id
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:30:21 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7bu-0003wd-Uq
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:30:21 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-32326793a85so2132410a91.1
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 15:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756506616; x=1757111416; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jy4YLGNWV0R4ND2Aq+PHs1ssPj/3u/mwblyCWLL2x1w=;
 b=pkX1JEQXdqDnBdXrlf5FGfj2huNU2nc8MIeYq1P2rWs59f9ozFfa+gO69jAsoY78GG
 Jt7OwA8cJR/IwCNz33kFrCQ3a/YwyqLVNdqhgO0lr0C1htx93EiKN87f0+v04t6t/o7E
 PnZhXxvvnzQAP4zda+/Gyz2us5fxSa/XErCuwfCLbjr1eCq5TOQz0+sz4bSyuEyP/OEg
 LOGaPCQ+M6YF57OjcoxWN9RtwnOVcwXoAPk7PK/TKGMQmYmDO6MVzqJ1HipbUb2dgmGz
 JEbYeKVhcWx/0w/PZdM6ESSFs2p6boNxLrIkg6eVbcGYY8lRD3euHbiPzhUAmFXReTYi
 +uAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756506616; x=1757111416;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jy4YLGNWV0R4ND2Aq+PHs1ssPj/3u/mwblyCWLL2x1w=;
 b=bPJrFVHPW/JPF+CLob+0FlG7jV7zVpZnRiMveCUatb6Rp1ZvGBX9+nw/6yyGgftdjk
 mF9dB7SshGmebR8Mb7i/GnGPP7V+VZz478dTnC3uMakZLiMdHtlgzy4kPDSSDNlV0llQ
 TRI5NYTlJG35Mlkm1pBJYObk64szcJNF0seJvIO+mLAj1wCHt6qr8Dcii6L9dhWV+7VE
 JVvjeyJCXDN1HynxT3EV5jST6wWKzDXrQ41Imy8ZkKkfhg5QQKpRKihzpFFJt+cpHPVq
 Z2AR4wMGa2NI/fetd1fKTG1KAt01CjG2jSejNQzUXEejAIXIN+96KOhQD5flzmxe2TnM
 LTXw==
X-Gm-Message-State: AOJu0YyrglhoHwpxPZD2OKXyDkHG70AQ9yNjSevtYOVBCTJb3pl1IkMy
 GdqihyTA8BUFcLKJ+LoH4A5i4R8wl8Skc86qF5FnW/0FYRTtKRxpbmyhmxX8U6vQnqoq/iSJZxY
 tPpzINoI=
X-Gm-Gg: ASbGncu2PJXUWyH6cw1j06bSL+Phd9Yqv+Bb8Ux+oHHVQDr2w0LfqS42+p628gSPvF9
 ZTpkyqigvozNCi3xM0BGAnaK2Ai3OiR4Z1hS9/MKb11xwKAWiTxD3J/w4TJDjqssprrw60/P2RL
 sfwPPE6v2KxxlKLkXj69sh3gNelDh1dZZOUaVKn1nJDTieJFYsh4E7HMKAiyHiGuVbsYKsJhCXA
 Mae9cOHmUM49qZ/XURTCf4XoFdL3lkGW4mvx6VtrQn2glc9qKlnhuqhyLD4190xMbc/r9RPjook
 aNqxNs72UR2UdiTmJJiqkpR8H/Sm66UR5IgWhjGrJG2roISe5LdeMvoPs/pf+ZgBW8wWp8qi0Bj
 d5+4YhPc0VFA/3aufExeet2zUTsb9qzm4g51JL7X9Uv+heNSJX/xcX+9yxSARguf8TgHMuITCQw
 ==
X-Google-Smtp-Source: AGHT+IH4V5GIIlIa+vcW7Ss7tjLJRJ6DhBrmVXZ/xH+hYGT+MXDpoXB23o5LvpLo1dg43VDCs2ek9g==
X-Received: by 2002:a17:90b:2ec8:b0:327:5081:d5d0 with SMTP id
 98e67ed59e1d1-328156bac3dmr300898a91.19.1756506615899; 
 Fri, 29 Aug 2025 15:30:15 -0700 (PDT)
Received: from stoup.. (122-150-204-179.dyn.ip.vocus.au. [122.150.204.179])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7722a4bb5dasm3364297b3a.55.2025.08.29.15.30.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 15:30:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 67/91] linux-user: Remove redundant ELF_DATA definitons
Date: Sat, 30 Aug 2025 08:24:03 +1000
Message-ID: <20250829222427.289668-68-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250829222427.289668-1-richard.henderson@linaro.org>
References: <20250829222427.289668-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
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

We already provide ELF_DATA based on TARGET_BIG_ENDIAN.
Remove the extra definitions from openrisc and s390x.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 59e6605e36..8ff9f83bb8 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -305,7 +305,6 @@ typedef abi_int         target_pid_t;
 
 #define ELF_ARCH EM_OPENRISC
 #define ELF_CLASS ELFCLASS32
-#define ELF_DATA  ELFDATA2MSB
 
 #endif /* TARGET_OPENRISC */
 
@@ -333,7 +332,6 @@ typedef abi_int         target_pid_t;
 #ifdef TARGET_S390X
 
 #define ELF_CLASS	ELFCLASS64
-#define ELF_DATA	ELFDATA2MSB
 #define ELF_ARCH	EM_S390
 
 #define VDSO_HEADER "vdso.c.inc"
-- 
2.43.0


