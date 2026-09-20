Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9403FC982CC
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2026 05:22:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x89zC-0006Rf-N7; Sun, 20 Sep 2026 01:21:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x89zB-0006RE-8l
 for qemu-devel@nongnu.org; Sun, 20 Sep 2026 01:21:09 -0400
Received: from mail-oa2-x10.google.com ([2607:f8b0:4864:30::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x89z9-0002BS-Sx
 for qemu-devel@nongnu.org; Sun, 20 Sep 2026 01:21:09 -0400
Received: by mail-oa2-x10.google.com with SMTP id
 586e51a60fabf-466cc9b2f1dso1272891fac.0
 for <qemu-devel@nongnu.org>; Sat, 19 Sep 2026 22:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1789881667; x=1790486467;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RHkFSt7MhhxUNe0QhPmodooRIEifjLHH0i3vCsBy+y8=;
 b=MZRorinO87FHQOyOul3+n0r063SN6cgUytbH+S62j7xcNagNz63x898wlSRLB+WjVg
 pDsgiizG57paBjBkXXHmms6LwoK74heeTSgTNFg6tNQeTXhDiPMBxI4DKe7XWMVPXQ75
 fE+HBhnNWkc+CDG7CzoR8joYWzjT9mfjNG3zrd3fGONMl30SoFjQAITLcf8OFKRppKnL
 eyaOxqDPr/OIDWrou7+Hf8oTKQy0M6mExGKNXTZlB/mi46OfZLUAuhPdMr4XIhQ83hbw
 A5l6PDOANAc5w9GbLcxDrgAgYj1nqX1sI/3ixxl8r2uhw/Xm+E42oxRqAxBMnohAyrXi
 F/0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789881667; x=1790486467;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RHkFSt7MhhxUNe0QhPmodooRIEifjLHH0i3vCsBy+y8=;
 b=BcDmstiCFHzS7FxN8yuyru0wk9v1+eAFBIctGG2SsbIeYh7l2QnXeby1iesCnO8uXT
 /M3DARTUWLXG6GwXdTDymqV371vXF3cKdFl2tTT1nLMdVRl1M9PjisEnCgXw309SEgyT
 5jK6jvhxxWD8733aZbeHBtUK4Ox/2VfdaDVtkpTLGQajbx37skEz+jKQ+Of+NMSuy8OK
 WHmv4/MYSdc0bttaX0EuwpCMGAycbN4RA3d9k8RrIw2aFVJoqnNpZBYME5xs5o6OnR+M
 OQI7Leg2Ba+Oss2kYi7kaDLTL2sz/F7J373B++eb9Dxf5ndnFOiO3EIwpnQQ8UD5JXwC
 nK2w==
X-Gm-Message-State: AFuF++mRlb89b3lq//ofGQ31w04zFZZ1Q9P0ZGki6tsAuD7UVCB8IQ0O
 FMHxN7ssJly61s/7S7H7BwIYQK136C0992FV6Y3TF8CFDK++DAAYbGn9LkJtu9oeknI=
X-Gm-Gg: AYBFou3CvliM8mSQjMLpQmg4Zn16F2mu18aWeDhobpWLBXUJ6Rls31FYkBKm7K85Rtn
 FqhCH3na3mEqByx7cDW/wkaSVLVAAG+Yvb12EDmqUK1RnjPzz1eHzF7nDe+OrSVHmNQ8dfGsif2
 Q2tjUZin/kdbcxXCkbRtFrbPd7MxEffPkXNBHKD0mSMfazVkDnsS60+NpvTLaTnjsuFQQld2qWj
 1nUk2ivFAfh2bGNbJOoDxdXh3PveWtO6hkmzHYPzW6Jlln0+hPgdbFGnDeo2HNAGkzM841/X49S
 9wl6vSFDJ2JwO9w65IjhOiHx7mHY05XmhXfyts+0KJKQ5M3Cm9GBwzdXJPl7tTPmZQ8OMSB+kb6
 3xKP49LMDIVOQ38PT4whPFreYTl4q78YeRyF0lT+zNJ3Dz59HVIPhbwBJL7GEBhWiI4V5nObv0x
 xCnN/deBhJCA9M0FwqTaoUOP7eiVmayWfFiKL/LlTw9Me76Kl5eqQVDTHLH9k=
X-Received: by 2002:a05:6870:320e:b0:46a:c673:a16c with SMTP id
 586e51a60fabf-486dd63192dmr6360449fac.5.1789881666834; 
 Sat, 19 Sep 2026 22:21:06 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-48821db3b4bsm3936865fac.17.2026.09.19.22.21.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Sep 2026 22:21:06 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Sat, 19 Sep 2026 23:20:41 -0600
Subject: [PATCH 05/14] bsd-user: Initialize per-arch child registers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260919-misc-2025q4-v1-5-ebfa61049bd7@bsdimp.com>
References: <20260919-misc-2025q4-v1-0-ebfa61049bd7@bsdimp.com>
In-Reply-To: <20260919-misc-2025q4-v1-0-ebfa61049bd7@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Warner Losh <imp@bsdimp.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=621; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=g+cMMi679VKrSz3/Aor9Gfh7G0a6pGxx7R1eUOqdDkA=;
 b=owEBiQJ2/ZANAwAKAWwc0Sh9sBEAAcsmYgBqr20w2hw0L63Ks8mMYdGTvvAWI9+ZDZekkZ8Qb
 /WV7NSFZ5SJAk8EAAEKADkWIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaq9tMBsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDMACgkQbBzRKH2wEQB1IA/9E2j0ykpFGvU6K3pYNJg36KW4m4O3D+4
 WZ4bsNVBJYjjfH+PhNvdzFtGp/IKpjLQEjCXkfSsqXL0Q9CBLKorDsp05ypojqT8g1xdLpCVumJ
 s7cLRNAhjaXIYBBpz9b7/+AKzXXXZOx58Hqm9CSfvIpuxMJRLtW4nr97ERCV6liUUP4w0Bafbbm
 EGp+9gTqv8jd9dxEVFNN67aVRG00Ehw2pYsglwefpBEPhzbKt6xVI2m+AAGWRYbjWCszePjh33p
 XIhrMnxPsr6zcKyqHlWuKuBs6C+tRanOeuNSb1TR3CCJb8TwQpK7u4AK0ODPiKnkUZ/Mi0vioVg
 50P9OtqdE466S9QCgAmn+G0KG/VI/ZpJtkPR7ICWGXfq1rFZmnv23wyfziJOzuDl909eEHCV6Sf
 y/p0TKGJp3AxLenQ7Y6n8BZuaGEIPAdim8OfjOOHH+0P2p78nNV/wi6Rakkx7/8BEG1lHaUuw1B
 /9ca4j2lYuUzCnAkF66MqIOvZAdBwiU5SwC4LF1V44I/LSi/voYFirX6Ik9vqgsKHjTlbnCzvY5
 JgBjGOgyrsfWXxma8xLGOhlUqE5RPF8M/Dr2ERiM15MU3h0JGqPDItUbO+6LxrjdDG6oa4AcWqB
 Vpy3YtKhPlq7C0EbGQDEvMV05/5lUydlJHKZaAHaV7f76Zo5yszQ=
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:30::10;
 envelope-from=imp@bsdimp.com; helo=mail-oa2-x10.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-thread.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/bsd-user/freebsd/os-thread.c b/bsd-user/freebsd/os-thread.c
index 15872f03fd..eaab062d3d 100644
--- a/bsd-user/freebsd/os-thread.c
+++ b/bsd-user/freebsd/os-thread.c
@@ -1629,6 +1629,9 @@ abi_long do_freebsd_thr_new(CPUArchState *env,
 
     new_env = cpu_copy(env);
 
+    /* Init regs that differ from the parent. */
+    target_cpu_clone_regs(new_env, 0);
+
     new_cpu = env_cpu(new_env);
     new_cpu->opaque = ts;
     ts->bprm = parent_ts->bprm;

-- 
2.55.0


