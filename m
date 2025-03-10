Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDED3C2BA1B
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 05:02:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trVEW-0003Cl-Hh; Mon, 10 Mar 2025 00:59:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1trVEG-0002ma-Q5
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 00:59:05 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1trVEE-0008DT-In
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 00:59:04 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-22409077c06so47319445ad.1
 for <qemu-devel@nongnu.org>; Sun, 09 Mar 2025 21:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741582741; x=1742187541; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IPEDYJNluDpPES/gm3SGsU7HvgYj8dBtSrlHoVBQ0cc=;
 b=w5WAxzQkQYi719ro+LOhQPeexczifTbfpsjRxYjDw/CzalY7NBp7/8HHWfIljuD5HV
 1uuvLMK752Mxts0Jd6K9n+bcm4mtDr9tv6Cphri8doMk7Dd6G7PccsGKGLG93KHytLIO
 GiT3dzmdoF9amAnfzzHjYmf5EfqN8vmp8fR1REztrOMbxmxCh9Bh+R3RZ43u2N0gVdCl
 kUoNQb+qFxBYUI0W+Q+UDcEpKUBcIepg9XyxKQxH43vxhDgMsDfLQHUB6fRQQFjMICOb
 8ykoUy8bNapGbnyfd18CnhHlVd15EsXkGmMZ9K1q0WKE3m/rBpqwoEGEeAcSuwtbgGcV
 ngJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741582741; x=1742187541;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IPEDYJNluDpPES/gm3SGsU7HvgYj8dBtSrlHoVBQ0cc=;
 b=nPVFsKpCmdrLMjCj2Sun1fPQXpe9IddVluH6xeZP+Wn40VoA2C/flTmogji8YKvI2U
 /AU9ed2/YFF+0+eaOww4UlT+uk/xV8zPLSc8FMI9S24EClH0zptMIx8lYmfnfJxPPoat
 M4Wv2mSGuNp2licAwOoKeoi1ZuSM7Ib8zNdPAn9oPjJNppnCYLEipQwH4DA9KS6ZWy+C
 Sua501S6Nzpvu6CIhyYqX4hAVQgAOaeJgEkmaRFyr3+i1SElmjPJvrn4KdzPrW2QzHb0
 rIcO1UYW8wdYT4bpWPdPoO/QjCuLCQ6O+kAzhIJxptYvRKbNQlTdDO4FXM26tiWl24+H
 eDbA==
X-Gm-Message-State: AOJu0Yxizcw91DJKVAbF9oYQmXBsC4TtSmzu4B505N4sbfFoPEsd+nfF
 4ou2HdFoQMUiGQHlJWsksol1jvJNbROasuFClMlttrQ2cA59+WtbYpuS9DYSxn8tWdjCpxrDSNt
 YopY=
X-Gm-Gg: ASbGncv6AGmOcSBt82mLtjqAPLWhHfKj/03atZ2ygT2ro76PRLCMqxvvQ/8N/kCZYFH
 cI/1FyJuEIQrkWA+14X6Tsw0+IMQgN+r1kIot82QDTt4HcGgdaoDAfATDJGH7H2kuRt3XhtRjfS
 BFWdDsEBwgwz2Uab1H8+ROJSofT3FkAaZ5YVVWwjTm5NDJR52JZ449WQjds891S8tKh0qInSdOA
 yOzCKcsM9VM3BuXcpwytxILA+Cw2T7eyTEnxEbbw58ugY6SoPD1/CcHPvO3JypQioftpvgrt66i
 f22vVWJyZOPvpYUYLjv3Yj70eGNjhCxHJaWsC0z8x41K
X-Google-Smtp-Source: AGHT+IGnRL2uatBuqKhV40BV7IK05QSeZki08kFFlneJ+DA+/in0OuYiAmS5NbuJabl8/7CaVrRM1Q==
X-Received: by 2002:a05:6a00:cc2:b0:736:4704:d5da with SMTP id
 d2e1a72fcca58-736aab14d5amr19552625b3a.22.1741582740826; 
 Sun, 09 Mar 2025 21:59:00 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-736d2ae318csm1708308b3a.53.2025.03.09.21.58.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Mar 2025 21:59:00 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Alistair Francis <alistair.francis@wdc.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, alex.bennee@linaro.org,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, kvm@vger.kernel.org,
 Peter Xu <peterx@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 David Hildenbrand <david@redhat.com>, Weiwei Li <liwei1518@gmail.com>,
 Paul Durrant <paul@xen.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Anthony PERARD <anthony@xenproject.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 manos.pitsidianakis@linaro.org, qemu-riscv@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, xen-devel@lists.xenproject.org,
 Stefano Stabellini <sstabellini@kernel.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 09/16] exec/memory-internal: remove dependency on cpu.h
Date: Sun,  9 Mar 2025 21:58:35 -0700
Message-Id: <20250310045842.2650784-10-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250310045842.2650784-1-pierrick.bouvier@linaro.org>
References: <20250310045842.2650784-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/exec/memory-internal.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/exec/memory-internal.h b/include/exec/memory-internal.h
index 100c1237ac2..b729f3b25ad 100644
--- a/include/exec/memory-internal.h
+++ b/include/exec/memory-internal.h
@@ -20,8 +20,6 @@
 #ifndef MEMORY_INTERNAL_H
 #define MEMORY_INTERNAL_H
 
-#include "cpu.h"
-
 #ifndef CONFIG_USER_ONLY
 static inline AddressSpaceDispatch *flatview_to_dispatch(FlatView *fv)
 {
-- 
2.39.5


