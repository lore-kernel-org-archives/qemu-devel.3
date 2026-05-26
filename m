Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F19A8CD5BC8
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 14:33:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRsma-0000Ii-1P; Tue, 26 May 2026 10:29:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRsmN-0008Kw-OV
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:29:13 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRsmM-0001FH-4S
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:29:11 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4903d730b1fso42656645e9.2
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 07:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779805748; x=1780410548; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=x6UmId4uQz5l4M/orJXCZGhbYCPNs3zlI45bSFNuQcc=;
 b=rPCu5s4GBCJQyPOYhgOqGwTCieHJPu1b16hysQD4UovGafbFu9hbtyQXSuvD8IaiJK
 qKdPnJnJh+FotV4nw6Bj9d6aCswoaAE+CznfR4vCNwoxlcJvYx+fvKWfmpyTXfAVxiS1
 NJ8DPSATzQR3j198vz8rLdUydm+oHWyCGdSlgczSxB9xFF/7KucWDWiOQd0JDn1oPJDu
 oVixErnBqZltF1Qe4XPqA96qsiMeR41gUG5qOUWDtTsrbcI2SAQ4MVl8MVOWKNVarBRT
 jBIYWxldP7mm7OmmM5r5lKJ8PrsqwUfDgxUBUTpbP1olkxUeHNLq3cID/QnUnfBGiKgu
 Ofkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779805748; x=1780410548;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=x6UmId4uQz5l4M/orJXCZGhbYCPNs3zlI45bSFNuQcc=;
 b=tUtMsMhxm0FMEOPA3DaYrRpdfBs9qpYAu0pqFSs5xXfL2iGdRU7osdNyKI6UKot6hQ
 ueO/l+nq1l6GDMiiDb0QglENRJDDNwfHItr2eEV5EHyezyhH9ADlCGcUHvUkkb0Vc5AJ
 +IlsJxNtq0zxmhOyvpSZaqrKual4kmqcuMihtnNXQIItJTAfLcWIVfphdixIw0QhqW1r
 NezudZUX7Pkq7CVJW6Ddgs5KVnO+LFZo6IFKBH2Ch4Eu927SqLcn6+2AFn+1jkjDATnH
 kCPUxwOfFTE3F8R9y5vq+BazHZW4jEpTpHbF3DYiZwbyEIyWWP128w6SART3fG8urBfD
 9x/w==
X-Gm-Message-State: AOJu0YwB+RwJkYNGjiyzIK8nHZKThVBdW13Javm8eG/qIo0z/FsUDMGt
 PRb6CrnQpODtsD1Ne4cmtRhASccx9ydrxNu908hIlaab2dgDpqz10t7wlRddslBdfYXR0WAVkEA
 ie1Jv
X-Gm-Gg: Acq92OFK3tbRQ/n/drdLhLq6yi0+x6Ukzfgir2YDWk3KaZWveqzBoX2p+pq0m+ew7gX
 raVc1iDU3nzmn0WV0hBlKTq136NTB6flFxKyrE2sGGwabt+RuABb6SLZE9u8twPq6EXpyiTLiOG
 7xnRSm5USAnPEqi+IxleR7J0aAh8WCEzXJmH//o2PjfWACv46q4mthfZECZtSzDl5BX9exV713r
 ScwypWqk1cAm2boxqYffSZGQ2E7/9097Akt9+ok4UH7QBx6+kqUTHqDV0fY7HOnRWUbcEMewD0M
 eZZKMI/3dCxUJa5YOOXLy+z7bks+EjvfPHVZcdDe5M6hDMhKA0A8xCZoJHaBh8G8tEhDd8LGLCn
 0Mppw42HAyG534EgctgqleTxXF81Ut1dVFgn30Ek8xke5Si1/Q+Ybze+2IhXlfjJhfrkEQl/w7z
 edZ5gevg6sWuswfkWyu07naaMMheml5D2Rp4+F06aeKhGUTyrARZhTTzKOLhZm5HNpWtm4dgUyJ
 xgg0FPGXurbxiPkzkTppKdSrR29AeY=
X-Received: by 2002:a05:600c:3b0a:b0:490:60cb:560b with SMTP id
 5b1f17b1804b1-49060cb57b1mr186844695e9.28.1779805748452; 
 Tue, 26 May 2026 07:29:08 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6d70c51sm38325225f8f.36.2026.05.26.07.29.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 07:29:07 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 17/54] target/arm/ptw: Flip sense of get_phys_addr_v5 return
 value
Date: Tue, 26 May 2026 15:28:13 +0100
Message-ID: <20260526142850.2326589-18-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260526142850.2326589-1-peter.maydell@linaro.org>
References: <20260526142850.2326589-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260515142541.571911-5-peter.maydell@linaro.org
---
 target/arm/ptw.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 33735bc14b..53c2ed439e 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -1169,11 +1169,11 @@ static bool get_phys_addr_v5(CPUARMState *env, S1Translate *ptw,
         goto do_fault;
     }
     result->f.phys_addr = phys_addr;
-    return false;
+    return true;
 do_fault:
     fi->domain = domain;
     fi->level = level;
-    return true;
+    return false;
 }
 
 static bool get_phys_addr_v6(CPUARMState *env, S1Translate *ptw,
@@ -3793,7 +3793,7 @@ static bool get_phys_addr_nogpc(CPUARMState *env, S1Translate *ptw,
                regime_sctlr(env, mmu_idx) & SCTLR_XP) {
         return !get_phys_addr_v6(env, ptw, address, access_type, result, fi);
     } else {
-        return get_phys_addr_v5(env, ptw, address, access_type, result, fi);
+        return !get_phys_addr_v5(env, ptw, address, access_type, result, fi);
     }
 }
 
-- 
2.43.0


