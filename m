Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 822F0C369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 14:59:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uA8to-0002Cl-J4; Wed, 30 Apr 2025 10:59:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uA8tk-00028M-9I
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 10:58:56 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uA8ti-0002e5-1X
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 10:58:55 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-3012a0c8496so5948363a91.2
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 07:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746025132; x=1746629932; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fGiNi7KD9gyOgMyKCivUKJWXpCWPNSCcBCjqGbD2GJ8=;
 b=lxW7mP3Vr9qapPWNSdWMGjABX0bDsEumAvM9F4C17MYK40xgOUhZNuaIUPtQD8gz1O
 y44LkQFcRShI4VKa5hV5GA+1Y6lwGu6grMwYpPLU9WeEUa8Kbg1luEMV12rsikLb9EHF
 obKCRZzz8j1GOXl/re3u+jSPFim1P91uGbFvS6T6TG0igLwLstOnIktV51JsjNwlGgtE
 LRGRfZrIWn3YkLOcxTplZqsG1D1CIDAErMOv+50LOsUbNi+8wQ7fNxAowFd4DoCoIUSx
 bk/LPDdyFwPVFbD03Qoa+v1ZFgP2G+hkY8s/Kssk51ZXj38M0I+bRq9fefvN1lfgu1xw
 O4fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746025132; x=1746629932;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fGiNi7KD9gyOgMyKCivUKJWXpCWPNSCcBCjqGbD2GJ8=;
 b=XrBMqHt8KyUu4iIKvuaSskR9AYCTfC56K0xk4J0C4BOxg2P43rgwrIUSCpu/B8BkNm
 xWTBfmD6iMF4xwsUKzXmeU5Zm/Nr4GPDZvVA4vXOmjY/8dkks2TgdAQLlMPCLxVnqhfZ
 PmFxV6ldMi+dHyPmD+VOCv8lE3JXdHmIU/Izmn4DoUusLWmsC7KDqlzXHmdadcBIUezk
 9ikqSXW5jdd/KRl+mQL8x1IBchZlA8l9j8mA+INuplRVeZ6HuYcSOeYgE65EWY3Bpd5l
 CBW3kLo+95s2CHniz7VAMm99FtVNs7QtWNg9QHF3EXY80pKyj6XX0Hmy+kg2eFmN8TOA
 K0vg==
X-Gm-Message-State: AOJu0YxE2WkLvt7B0KW9m9XHFrlU25ep2/J5a1oyxA50i03ON9yasbuX
 TLbmdkcdpv5VY5j8bDhsZmoD5FI6tv7WTYHvWRkq0glUKELQfKbyJU5++TGfoaLyBuu7aA3sEl4
 E
X-Gm-Gg: ASbGncsNmAEgD/H4vZrzCo/6/+ls7Wq8DR8COobnaa7qsB2KNd2+PX/7fRfs7zaXWsn
 4yi94my1JSU8Cxk8TdBRa5igJQAQ3l5Tarz0w4wzyAJ3tplw7Rov3hak5Oe2exZy+rWzpfSwRkL
 1FQyFGSu/SZijgll993Pc3Xc21brfzW9R2R/EYefbmpPBp/k0NYg15Ti8cBlfdZhcOYccmlLqcE
 JuGblYyYu2md/iNSqukx+5sh/4Cq+wfBWai91od6VtrNUjXZgXT4Z36SVyx9JtiAqJDjaGsYVof
 mV1gDUbPp2r2xDeiKe2JeQB1bA6vevnrFasAwQ3D
X-Google-Smtp-Source: AGHT+IH+BLmMRNO1d2Il9lIsPzqV/zNMQYpfuEcaTVrwEpMBAGNrwX24xYIWCRPNN9NX2WqOLluU4w==
X-Received: by 2002:a17:90b:514c:b0:309:fffd:c15a with SMTP id
 98e67ed59e1d1-30a343ecc28mr4110023a91.13.1746025132462; 
 Wed, 30 Apr 2025 07:58:52 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30a34a5bd78sm1705652a91.42.2025.04.30.07.58.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Apr 2025 07:58:52 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 kvm@vger.kernel.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 alex.bennee@linaro.org, richard.henderson@linaro.org, anjo@rev.ng,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 02/12] include/system/hvf: missing vaddr include
Date: Wed, 30 Apr 2025 07:58:27 -0700
Message-ID: <20250430145838.1790471-3-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250430145838.1790471-1-pierrick.bouvier@linaro.org>
References: <20250430145838.1790471-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102f.google.com
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

On MacOS x86_64:
In file included from ../target/i386/hvf/x86_task.c:13:
/Users/runner/work/qemu/qemu/include/system/hvf.h:42:5: error: unknown type name 'vaddr'
    vaddr pc;
    ^
/Users/runner/work/qemu/qemu/include/system/hvf.h:43:5: error: unknown type name 'vaddr'
    vaddr saved_insn;
    ^
/Users/runner/work/qemu/qemu/include/system/hvf.h:45:5: error: type name requires a specifier or qualifier
    QTAILQ_ENTRY(hvf_sw_breakpoint) entry;
    ^
/Users/runner/work/qemu/qemu/include/system/hvf.h:45:18: error: a parameter list without types is only allowed in a function definition
    QTAILQ_ENTRY(hvf_sw_breakpoint) entry;
                 ^
/Users/runner/work/qemu/qemu/include/system/hvf.h:45:36: error: expected ';' at end of declaration list
    QTAILQ_ENTRY(hvf_sw_breakpoint) entry;

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/system/hvf.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/system/hvf.h b/include/system/hvf.h
index 730f927f034..356fced63e3 100644
--- a/include/system/hvf.h
+++ b/include/system/hvf.h
@@ -15,6 +15,7 @@
 
 #include "qemu/accel.h"
 #include "qom/object.h"
+#include "exec/vaddr.h"
 
 #ifdef COMPILING_PER_TARGET
 #include "cpu.h"
-- 
2.47.2


