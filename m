Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A398AC982FA
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 19:22:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x963z-0000a2-8q; Tue, 22 Sep 2026 15:22:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x963a-0000Xo-9h
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 15:21:40 -0400
Received: from mail-oo2-x0d.google.com ([2607:f8b0:4864:31::d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x963Y-0002O4-NU
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 15:21:34 -0400
Received: by mail-oo2-x0d.google.com with SMTP id
 006d021491bc7-6b1ae6c9b72so51410eaf.0
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 12:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1790104891; x=1790709691;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=m7q789p/m6jOBw/fvMfhmLO8/a6GbP+IgiRNfeG/66Q=;
 b=ZU+UT5aJvfIiMwQn+W2BwDfwlvMVGy0WlEuPkksjjt4s5yA+YiGfqlsXyjBzFIXkkY
 nJwQnVmTxqr5mzvszdtiZzKCt8xCPB2np5dZMqJ2slh2wgGGhrCls0mE9iipHhKxV3HK
 J3JXtf7yexGn+bJN3rEfL48j3lmq0KcQBCpxtFeo5M6zApVUdEmPdU+vzcckAsHsRWHF
 EDi6ffc7dvt8HL/9MgrTi6Ws4SJqtR3rqZjQBA1bVUvKdOLH3ef5XzT8UbhVa/NzQUGA
 ZeP9o6PVX1hJ7aPnO7HxuvkfikSBjHDVI5hV7S7yI+6dsn/U4SdWI6RpFt3qAZh6hBKB
 k5Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790104891; x=1790709691;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=m7q789p/m6jOBw/fvMfhmLO8/a6GbP+IgiRNfeG/66Q=;
 b=uxWrHwKPolmxmG8/PZ3noclKZTJOynEFzHHCn1+crQlPG0ddghztnVZxBJg0OZ9/Go
 95jm+2lJlrnrmLjIIbru9iYJdeyLnvyRqzQ19lP/O97lB8HORtjRQ5agdZm453dSakih
 Ux8RPkpeIUfOLGk2vzidc2ybTJ04OY9OqUOqAOXJzVzj+I0i7Nr1aik16uk1ix2fuguu
 3k/7RIvFiVy5x2SsMsduYkNtHfcEQrIxEGFDs+AVNRQ/BOzOaVdOtAdVpKab/WQXzn83
 29+obYlPrTNNvFNASah9io4FMQpmDmwP+cFUKSm2NlsZyn5EX46RxsnFPVee82VRRDYV
 fL4Q==
X-Gm-Message-State: AFuF++kKWV5joWZ60VYIE44O1ix6jYYdbg/5Sfr/HlgGLPyB71maLWqF
 zbVNJs7UyTX0LBei226vZ05oYYEAgWNqdDGg9ZrTWNdnrtVsZXqKJxiiuKtXF+xJyIxM1+SCAte
 QnEtgw84=
X-Gm-Gg: AYBFou1UzzwLfmopX/lkoR+aKaszAM2qTzQLZ6OFVXAkUPqFUy8w/yfTN+sPW25NPVS
 8gqKeMCKs8bdj2V7keH8UIo7zM9RbEV8MSTz8kJ+KT/Qwv9x4lgCpVIA+zmRYSqCeL6awpv7Fiz
 hd7aoU6aP2tthL3XAIRghwSuUfopx29bdIgHhAfUHrWw4aK9/W0kIm61pkbBDS5OFFYRGOGwZmy
 LsLu1GCPqxATc50uE++wrFLIUirzhYjhUEXVOrJmkFeXA7le29f+zlyw1Ho4zpEiswdXmC1tHHh
 U48O9HriwUg9gyZ2GG1imwUkzGSDovnGek1bgYwGuSK72KGLqR+f0og2ZFXAp8L5D3dSbUaXLiZ
 AF6qp38T0P/LxKCVxeyL5YNCGiwptVr++yziL3e104OmzjgRO2JvTyXIzonNPzAeizsKOH6yvyh
 dxO5dEf0xNE+A4lLMEEO6dmy1E9+g8pgxUdnW8lUxPjZhvU1ojsozQaN0HKP/an+anDAMSsw==
X-Received: by 2002:a05:6820:4def:b0:6c1:db64:da34 with SMTP id
 006d021491bc7-6d2c96b4921mr356527eaf.18.1790104891329; 
 Tue, 22 Sep 2026 12:21:31 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6d2ce763f72sm646776eaf.7.2026.09.22.12.21.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 12:21:30 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 03/11] bsd-user: Flag shared memory as needing atomics
Date: Tue, 22 Sep 2026 13:21:01 -0600
Message-ID: <20260922192109.98467-4-imp@bsdimp.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260922192109.98467-1-imp@bsdimp.com>
References: <20260922192109.98467-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:31::d; envelope-from=imp@bsdimp.com;
 helo=mail-oo2-x0d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Catch up with linux-user 228168cbb7c:
    Signal the translator to use host atomic instructions for
    guest operations, insofar as it is possible.  This is the
    best we can do to allow the guest to interact atomically
    with other processes.

as well as subsequent tweaks and adjustmentst for bsd-user's code
structure (we don't have one exit path linux-user does and could frankly
stand to resturcture a bit to match the evolved code in linux-user). On
non-private mmap(2) sharing and all successful shmat(2) calls we tell
tcg that we're in a parallel context, which changes how it does atomics.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/bsd-mem.h | 8 ++++++++
 bsd-user/mmap.c    | 9 +++++++++
 2 files changed, 17 insertions(+)

diff --git a/bsd-user/bsd-mem.h b/bsd-user/bsd-mem.h
index 3086143d40..65270e2cdf 100644
--- a/bsd-user/bsd-mem.h
+++ b/bsd-user/bsd-mem.h
@@ -389,6 +389,14 @@ static inline abi_long do_bsd_shmat(int shmid, abi_ulong shmaddr, int shmflg)
         }
     }
 
+    /*
+     * We're mapping shared memory, so ensure we generate code for parallel
+     * execution and flush old translations.  This will work up to the level
+     * supported by the host -- anything that requires EXCP_ATOMIC will not
+     * be atomic with respect to an external process.
+     */
+    begin_parallel_context(thread_cpu);
+
     return raddr;
 }
 
diff --git a/bsd-user/mmap.c b/bsd-user/mmap.c
index fe77eceb48..548b4824df 100644
--- a/bsd-user/mmap.c
+++ b/bsd-user/mmap.c
@@ -662,6 +662,15 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int prot,
     printf("\n");
 #endif
     mmap_unlock();
+    /*
+     * If we're mapping shared memory, ensure we generate code for parallel
+     * execution and flush old translations.  This will work up to the level
+     * supported by the host -- anything that requires EXCP_ATOMIC will not
+     * be atomic with respect to an external process.
+     */
+    if ((flags & MAP_TYPE) != MAP_PRIVATE) {
+        begin_parallel_context(thread_cpu);
+    }
     return start;
 fail:
     mmap_unlock();
-- 
2.55.0


