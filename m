Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF73DC982D0
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2026 05:21:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x89zB-0006RG-DJ; Sun, 20 Sep 2026 01:21:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x89z9-0006QP-0c
 for qemu-devel@nongnu.org; Sun, 20 Sep 2026 01:21:07 -0400
Received: from mail-oa2-x10.google.com ([2607:f8b0:4864:30::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x89z7-0002B5-6u
 for qemu-devel@nongnu.org; Sun, 20 Sep 2026 01:21:06 -0400
Received: by mail-oa2-x10.google.com with SMTP id
 586e51a60fabf-466cc9ab667so2405637fac.0
 for <qemu-devel@nongnu.org>; Sat, 19 Sep 2026 22:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1789881664; x=1790486464;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0I2wZ8UvlTTGDzdCRUVXg6ot6cMzAzuU6AAijhk8jTM=;
 b=drMHhDvucCPerNZwC5qA81tBm10jFSHoKrF5DM0gfkMLjXZYn2co5DJvPDcogMCyf8
 JQxo7wqrqQG18lS8amGYG0pP3xFj/exmXvxCyttdFFXTdyRAscFFa4SEqKYoW3dzS675
 1HmptZiXNarzRmcRgiqy1QrT9wnzVKiZYzDwUygxhzAAh5j5E1F5BDfzptwCH9q1ewfv
 WgfqeiexC+i+9UZnI8Oj9wcoMrxG+qgBYSlC7MDKLtOnj8ECrzZ6X7NGh6h1KB4/0qMb
 KyCdd2cZsK3k0q66HaBA0AaSobzrWePOEVkDQy9YRHdWrjQge1hwO+60N96ikHRhadye
 qWYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789881664; x=1790486464;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0I2wZ8UvlTTGDzdCRUVXg6ot6cMzAzuU6AAijhk8jTM=;
 b=ALSOQam+993ZU0tWRj158B7vsPAuYmDkeDOngwNv2qtQ+dp4XGRgj21PwTQ72hVFx6
 UuTsl21LYict7YfbM2N9efQ6OGaLRGmDUNT7tVnx0JNPO0dAajiqs64LbYPmsNCJ4eRg
 8uFYqXqWfWmWTA6onnZGDS4qUZ34vKS/LUziRAsFHqQsWzj5pTnuS4eNrkxiMGQL3KNx
 sfBuwNsWMB5dt+sNbB5CwzaM9Rydwnjd30T66nKF541ZlHPxQiFzJuytxn+n31LTA4Xy
 lAaFD+QWwL56X8JF5Cwr3r3NMcE9LNwMoMQXxISvdLsKG4ZXr/1IdChdSb6Mz/WRx5oI
 78ZA==
X-Gm-Message-State: AFuF++nrIW79MNt6C3R4NO+HRi44cmrSJPTXgA7OslE9VI/5UUD0ywrF
 od1gsd/lYztT41DsizkU1GelBJPnVqfJzRkedcVRRNQJopMmvSsFYdjCKyrs5uBr6xI=
X-Gm-Gg: AYBFou0HLywoQiqI3OYnDpUS4YxWLNnSnAS9pAV83bvGe4LO3lMCsPSmc3CI1z2W/Dj
 Zc6fpH6EJGKG5wbFQJaNCzxiCxqIZlnq+ggQw8FB3+Wf925Mxq5uksW1NFWuoF8QCKYhz74N/O0
 i/tS2VHOdZVxts7IUb2lpfFeb/WDO1zCbc4h76GRLyBj4wbLvvkdO174a8k9774W25Yt+Im1Gzm
 BUNslgGJBtnLpFrMXQFexS5TEWzX2E2f9lxCsb8KdRY7LuEUjrNGS98LiSftPDwwC4ek0h7/Qfw
 wXulzwe2a0s7wsf3UhbSkftkUJ3fWxT2368cuSxvXL4QQmdJXhMxQLNUVF6CP+omLcTY+e+mlNi
 zmnUFleZcSMj4xjEfdkJcZnSM11CbxXgubDghJoCWu1+w+gi1TtyMzflTh8JW65RPBoshlNSXcp
 PxqEoOmxOcLeX6zN8AR3Z1hZp02933TC8FPV8MdtItyV/1t3t0rSd71bJM+A==
X-Received: by 2002:a05:6870:9208:b0:475:a153:2dc8 with SMTP id
 586e51a60fabf-486e7628ccbmr7177384fac.30.1789881664071; 
 Sat, 19 Sep 2026 22:21:04 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-48821db3b4bsm3936865fac.17.2026.09.19.22.21.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Sep 2026 22:21:03 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Sat, 19 Sep 2026 23:20:39 -0600
Subject: [PATCH 03/14] bsd-user: Flag shared memory as needing atomics
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260919-misc-2025q4-v1-3-ebfa61049bd7@bsdimp.com>
References: <20260919-misc-2025q4-v1-0-ebfa61049bd7@bsdimp.com>
In-Reply-To: <20260919-misc-2025q4-v1-0-ebfa61049bd7@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Warner Losh <imp@bsdimp.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2163; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=EsD1CCui6Ggc3FFFDKak8+ryuo+n7d2Cc9wX8bC1Bwk=;
 b=owEBiQJ2/ZANAwAKAWwc0Sh9sBEAAcsmYgBqr20wioyLynMDVdTJWgn7j74en/xB1IZhXHTLa
 JHRM9XE+1+JAk8EAAEKADkWIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaq9tMBsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDMACgkQbBzRKH2wEQBmZQ/+NPoHAu01SYMF/WBk/u7DT9m+T4bJ93P
 RPv81kns+08KTwu9N+VFMSsmlVimkfCU889NJL/dBU1o4njOXksAMbf58EJmGP3OVNS54S/aQGR
 dMqBcZUZEs+FASVYqxD7i8y/sDXZ2W7O32CiU/zNMqAx03JMFfPtTlP9sRJ9eAFaKG5elkjafK+
 +7gra+4Ot1LpMspqS3caT5OtYI34QMD/S4gIEZzGc0SON1PXDceySwgMtdWox0ypbqQGtJr+gIY
 xzISNez71HOKVh/xo4K0dXeVYDsaJdmEhDL1jz5YIlptbkGVRyuuilYUbGkiAXt8VAN3OZrT5Mw
 IqPg7sNQhOm1LgV/pDJfoaXnZ//ohOSr8wmb3POLUzrD5LvfldQGDnOOldeqO8mJF5aC9e2Tee3
 mEajgfCXWJXBB63FANTcbKDphGbHIOoMA/nT/N1m1clWycSIoNgbB1KAHgs52gZ8CsKEgSNF0hh
 guWPSc0gJ4u+yseLWLlM+wkIwtiXOELY73+5uPxnydnBx+rYs7wq1iiignuPy73jhq+oyxeJZd2
 /je9Os5q7LhntayGtFPDJceyYFPgdmMFt/rxq+xoI+o77jINgPsWcp0C/SyXmu1qyeZSfamCwVZ
 zsAwA7CG4EOUS3X0fMm3mpUzKHAdnjYymTRCkcjEnc1XrJwNEvJs=
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


