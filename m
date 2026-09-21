Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CDF2C982DE
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 10:22:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8b8g-0002WQ-D9; Mon, 21 Sep 2026 06:20:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x8b8d-0002SI-4j
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 06:20:43 -0400
Received: from mail-oi2-x10.google.com ([2607:f8b0:4864:32::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x8b8b-0002gg-Nb
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 06:20:42 -0400
Received: by mail-oi2-x10.google.com with SMTP id
 46e09a7af769-801a8bf8112so989037a34.1
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 03:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1789986041; x=1790590841;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wkWH1ZE6wt9RwfiMkvGZiBnMh0Vi3XqmzfxwWeKEcvw=;
 b=AKHjYOPfoP1kjv/3mu9w0WXRGyBgwrNTbljiQ+BBrus7hGnWdDUw8sophhUGitxKRY
 il/ChxW+NzThUd+aOxW6iX9SquU+SwUx0mGtuwglNqn0IpPiw06cBxTvXTT2TIl2ffje
 JHjcie5/ecYI2v93+JYlcrjA8nv9/13wcjA5I3ISpbV44JOPAsRvPbNVLGio+2VViYge
 9sXtlzAD49ID4c1stte/M8ak2U8kilAa6SIgrItExJ7anvMIPyS54zluT5e/WYmUPD1J
 MMpVblkfgyYlWxsZmHdGHWElKI2wihpgSK8NVq9zJ+LNmxFo6FgZp0QiILzsM10Br0As
 7ieA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789986041; x=1790590841;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wkWH1ZE6wt9RwfiMkvGZiBnMh0Vi3XqmzfxwWeKEcvw=;
 b=u1kx684QGHGg+4JqDcXIWlFoCZMGg+Ef7FT7prdPIBFgyWtO89PNsvcR9Z6AW4vUvx
 Dzt9vNLMFc7+7oKow+/KrO0DY3QHGjbk9SWpdAGeWbBCkF+JptOfNxJvX+BPuadL3qBf
 9XMgni6JqKaFxNq247vlouPue16XRYLyDFe28MMmySPGSrYOlO2MXffjjVu+9ZmKTDmL
 RZaTVuGNuyVixLs+gsx6mkBm9OepbZ4ZV36cwg1Fsi44T+5jW0W9qk88dBFNXY8SSe++
 YE24RN4rJ300A9+0lc8F6SUoVtXno8neuUa8i3A5tgZB1NL8bnaYlkolzpHr+0WPbVjm
 /z+w==
X-Gm-Message-State: AFuF++kQ/NnRsnbk8cjNPV/coNcxKxzDBa+gCnfJI3PpCQWaaK+8tUn7
 Lwm4DBxtCld6yPj9w42iSZfJylizMp6F7o7iNMyORgan9MnZxOjPFvHdGDPnXb0JoZoCv+FJzfP
 BgEuEgtU=
X-Gm-Gg: AYBFou2dkgpHo2tIEjojqcQCNlkJJdPp8jVfES91fbXVOoi1TqRSAgdPwuWjnzZ+/6s
 STzESd6P1IhOgUcmWYNAPFo3vsVMlNQuETbEobd48l5oELc1C/TIX1yTdZ413ckCIJWtFenf2q4
 BU4/nr4Be7rOophFBZE/VEARBaiStGNOOaw6lMk+zvZJBqSJS0SYXVFpoVnw3qwRZ8y64miKDba
 vddzFUKykIEKC6NTFohNbiPRnJl09N0l4Z8FXDLwiJckuXL8EWsiRQRc6QkFQxilPElRlDJQ48q
 kcYpAVnFPVSZDd2DT1Mah+XturxnoNtIfhUVl1NsbiiZuuZUsnjwFHsjm5van/tZfUW16yDndFW
 lmmskhoOh4ywB5w3G2MHYEXSK4OTQAWEOHJxvL2Rb0JTmVlV2pTHmTLFu6JFDirrxYxGpz+fBFH
 hYSFUjdvnu0u/XyT4ZpEVYQ0+GTk/aHdDojlD0/Hefe1KY4VSten8cdJARlSHeFSM84gXF
X-Received: by 2002:a05:6830:660f:b0:805:6a93:d9ba with SMTP id
 46e09a7af769-80de33e9139mr10768123a34.15.1789986040666; 
 Mon, 21 Sep 2026 03:20:40 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-8107dd8f425sm7613601a34.4.2026.09.21.03.20.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 03:20:39 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Mon, 21 Sep 2026 04:19:50 -0600
Subject: [PATCH v2 08/11] bsd-user: Implement sigfastblock
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-misc-2025q4-v2-8-5eae157d31d3@bsdimp.com>
References: <20260921-misc-2025q4-v2-0-5eae157d31d3@bsdimp.com>
In-Reply-To: <20260921-misc-2025q4-v2-0-5eae157d31d3@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Warner Losh <imp@bsdimp.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2090; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=17Ryw/lxO2Pse8NV9o6To3pLR/TQx9He+lK8vRViddg=;
 b=kA0DAAoBbBzRKH2wEQAByyZiAGqxBN6gmIRHkkTE0CL4y1ei1wn5fTWoKKmAlSclnLAjVUwxd
 YkCTwQAAQoAORYhBCA1+JSwCqPPfM3ht2wc0Sh9sBEABQJqsQTeGxSAAAAAAAQADm1hbnUyLDIu
 NSsxLjEyLDIsMwAKCRBsHNEofbARALHSD/wNxU+Zyb90FCrARi/92xsHoKqKDU7Z3paw8brtkdP
 1lR4qJIbTc9t8o3vT0es+LFkIX6NyaSIIR/ouuHLuI4HbN788+BQru/7qFxwIXRxxheOw2PgOXh
 xw3zpGuUOji+lgodOGEUm3/Mrg2WmAwLDkUXyV90NEHEBG/Gms8Q6rrSCEbwGXkENVQR9cZaZ5k
 UztEAl25Xwx6qcKnUMaHzMrb5d634GCFvnf7rxM3+Hugc4mXK0qg2whbpDH1tTBRu9rBJRytlZJ
 Z0Z7zbnY2OMKY8dJr/E54sdv10KKiGB5zNyXL0alHM8Lq50FsZG5mPwUHfdMPs4dA8C+k783c9O
 DVHcp48qflyaGo6+oqk0UTztjh1W5IEX8Me29TIm6QnjrxQm1eX5RB5KQgwl4aahZUtvSrawYtR
 Y27QG8ccf0ZCB3OR580Sp4bMKd40NXSYD/IDNzcpGD8RUM0SKZjvdGvcNSZLKYCC9Xo/7NwSnxg
 hgU+L8+xJLwyR61WFr3Q3C9wGfniaK0QVBUd0oq6Jr07LrXSrW2mGOf7eMaWxyRfpt0XRhw5eo5
 6eVFYxZxNhyWNVm1BAIY8UvXCQlUi0nxMYVw/O1B+8XQSrq0KcmuryTMg9PJa8gfPnzOjWZw3xl
 Mo5s0I3e+9IbOaOsq4whR4wR/2tL9kMQVCGpxOFeiLw==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:32::10;
 envelope-from=imp@bsdimp.com; helo=mail-oi2-x10.google.com
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
 bsd-user/freebsd/os-syscall.c |  5 +++++
 bsd-user/freebsd/os-thread.h  | 11 +++++++++++
 2 files changed, 16 insertions(+)

diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index e87924fbb5..b5178f298e 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -97,6 +97,7 @@ safe_syscall3(ssize_t, sendmsg, int, s, const struct msghdr *, msg, int, flags);
 safe_syscall1(int, thr_suspend, struct timespec *, timeout);
 safe_syscall5(int, _umtx_op, void *, obj, int, op, unsigned long, val, void *,
     uaddr, void *, uaddr2);
+safe_syscall2(int, sigfastblock, int, cmd, void *, ptr);
 
 /* used in os-time */
 safe_syscall2(int, nanosleep, const struct timespec *, rqtp, struct timespec *,
@@ -1175,6 +1176,10 @@ static abi_long freebsd_syscall(CPUArchState *env, int num, abi_long arg1,
         ret = do_freebsd__umtx_op(arg1, arg2, arg3, arg4, arg5);
         break;
 
+    case TARGET_FREEBSD_NR_sigfastblock: /* internal */
+        ret = do_freebsd_sigfastblock(arg1, arg2);
+        break;
+
         /*
          * ioctl(2)
          */
diff --git a/bsd-user/freebsd/os-thread.h b/bsd-user/freebsd/os-thread.h
index 6552c60337..dfb22e7cc2 100644
--- a/bsd-user/freebsd/os-thread.h
+++ b/bsd-user/freebsd/os-thread.h
@@ -17,6 +17,7 @@
 
 int safe_thr_suspend(struct timespec *timeout);
 int safe__umtx_op(void *, int, unsigned long, void *, void *);
+int safe_sigfastblock(int, void *);
 
 #if HOST_BIG_ENDIAN == TARGET_BIG_ENDIAN && \
     (TARGET_ABI_BITS == HOST_LONG_BITS || defined(UMTX_OP__32BIT))
@@ -593,4 +594,14 @@ static inline abi_long do_freebsd__umtx_op(abi_ulong obj, int op, abi_ulong val,
     return ret;
 }
 
+static inline abi_long do_freebsd_sigfastblock(abi_long cmd, abi_long ptr)
+{
+    void *hostptr = g2h_untagged(ptr);
+
+    if (hostptr == NULL) {
+        return -TARGET_EFAULT;
+    }
+    return get_errno(safe_sigfastblock(cmd, hostptr));
+}
+
 #endif /* FREEBSD_OS_THREAD_H */

-- 
2.55.0


