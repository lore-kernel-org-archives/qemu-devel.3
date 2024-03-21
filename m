Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18C9EC54E68
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Mar 2024 15:49:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnKf3-0004Jn-AN; Thu, 21 Mar 2024 11:48:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rnKf1-0004JT-Iq
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 11:48:55 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rnKez-0001BU-Lb
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 11:48:55 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-41466e01965so7931095e9.3
 for <qemu-devel@nongnu.org>; Thu, 21 Mar 2024 08:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711036131; x=1711640931; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bTgCkgY7q586A21zu0JSDs5UTTpVyxNoAlIlHHAmSdk=;
 b=d2jICh1dd4XIjkMWk8imYmpKT9o4rOLdhDCls43AAKP3nsU9riB59s0ZTYeXFMY9dj
 FS0F7q8MMIxsR1dvd7n4pvSj0PORqRshsN9wiYCNwyNHME3hGoGIiPVX9FPF16X3kPFI
 2ZE1ORKaloEMfv6+/wfpA5EurTUEeMDAzfRseHysj8mG+ujmy/HO8rMIH+TAOBZNx+05
 Mb6RHetRCj2peiAKX/IgH5Y0YGZBHmKyD0OgqwgJ8v1Xc+n65CuYLzPX8SPJPvypByrE
 8ag0DPjWoSYpDGROeS2Mza34EuAYjYeLurz4Y0a4kcLHqeAQP/7gNoSbCf/lyKS/g/Fi
 rkZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711036131; x=1711640931;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bTgCkgY7q586A21zu0JSDs5UTTpVyxNoAlIlHHAmSdk=;
 b=xNNcF7V1MkV/6pw6mzeZzTncyizEb5mwLZh+xWh3Mj2ympw0c4TIj/OszloDtK70Uo
 HB4va3NVTswdObdhPii8EXrPG6qdDcpQC1dZxEH/fOWXUEqFHiTK4qvKpxDNI7TDh6BI
 TWDFlYlyeNufNqApNoy97g23ZtnYztz+iXfbaGsysaCSXdy7iZX8fd69dBbNuxDdavMg
 MH6dif4zXBo5pFtrKEvOiI4wpu8dvpMqVP0THSZ9eA5i8pmOv0nyzV6Sf/wZs4SiqNP6
 14S6s4MxStkPIafBNtx5sOusZ3ifsYxwX9957dGVxHFMWljeptz25xKM+BhOUfMeFQjh
 tRTg==
X-Gm-Message-State: AOJu0YxXup4WrKglA2WXN3pzkJEdO+Ma02hwniCCktgtIuMcuHukaZAw
 CCx5ivDF5GIrYLpPji7HOk3gDjcWEmqdhaiHWi+ajZhE7CPe7s2W/pXLLFKpaRjfeGiJevSAGUa
 wCKs=
X-Google-Smtp-Source: AGHT+IE92dHNbX39E5CpL6fzghojPWn69hg0rMxVmayS2tpnQqnqbNz6dlTYqB9LpiS/OQbj/28ECQ==
X-Received: by 2002:a05:600c:3514:b0:414:63c4:c40d with SMTP id
 h20-20020a05600c351400b0041463c4c40dmr6529657wmq.40.1711036130799; 
 Thu, 21 Mar 2024 08:48:50 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.206.222])
 by smtp.gmail.com with ESMTPSA id
 t6-20020a05600c198600b004131310a29fsm141401wmq.15.2024.03.21.08.48.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 21 Mar 2024 08:48:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Artyom Tarasenko <atar4qemu@gmail.com>, Chris Wulff <crwulff@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Marek Vasut <marex@denx.de>, Max Filippov <jcmvbkbc@gmail.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.0? 01/21] host/atomic128: Include missing
 'qemu/atomic.h' header
Date: Thu, 21 Mar 2024 16:48:17 +0100
Message-ID: <20240321154838.95771-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240321154838.95771-1-philmd@linaro.org>
References: <20240321154838.95771-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

qatomic_cmpxchg__nocheck(), qatomic_read__nocheck(),
qatomic_set__nocheck() are defined in "qemu/atomic.h".
Include it in order to avoid:

  In file included from include/exec/helper-proto.h:10:
  In file included from include/exec/helper-proto-common.h:10:
  In file included from include/qemu/atomic128.h:61:
  In file included from host/include/aarch64/host/atomic128-cas.h:16:
  host/include/generic/host/atomic128-cas.h:23:11: error: call to undeclared function 'qatomic_cmpxchg__nocheck'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    r.i = qatomic_cmpxchg__nocheck(ptr_align, c.i, n.i);
          ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 host/include/generic/host/atomic128-cas.h  | 2 ++
 host/include/generic/host/atomic128-ldst.h | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/host/include/generic/host/atomic128-cas.h b/host/include/generic/host/atomic128-cas.h
index 6b40cc2271..4824f14659 100644
--- a/host/include/generic/host/atomic128-cas.h
+++ b/host/include/generic/host/atomic128-cas.h
@@ -11,6 +11,8 @@
 #ifndef HOST_ATOMIC128_CAS_H
 #define HOST_ATOMIC128_CAS_H
 
+#include "qemu/atomic.h"
+
 #if defined(CONFIG_ATOMIC128)
 static inline Int128 ATTRIBUTE_ATOMIC128_OPT
 atomic16_cmpxchg(Int128 *ptr, Int128 cmp, Int128 new)
diff --git a/host/include/generic/host/atomic128-ldst.h b/host/include/generic/host/atomic128-ldst.h
index 691e6a8531..12e4aca2da 100644
--- a/host/include/generic/host/atomic128-ldst.h
+++ b/host/include/generic/host/atomic128-ldst.h
@@ -11,6 +11,8 @@
 #ifndef HOST_ATOMIC128_LDST_H
 #define HOST_ATOMIC128_LDST_H
 
+#include "qemu/atomic.h"
+
 #if defined(CONFIG_ATOMIC128)
 # define HAVE_ATOMIC128_RO 1
 # define HAVE_ATOMIC128_RW 1
-- 
2.41.0


