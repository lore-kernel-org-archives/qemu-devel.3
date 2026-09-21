Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C73DBC982EE
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 10:21:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8b8d-0002Uu-WC; Mon, 21 Sep 2026 06:20:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x8b8c-0002Ru-0l
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 06:20:42 -0400
Received: from mail-oi2-x10.google.com ([2607:f8b0:4864:32::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x8b8a-0002gH-Dp
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 06:20:41 -0400
Received: by mail-oi2-x10.google.com with SMTP id
 46e09a7af769-7f4f0d298caso1147611a34.0
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 03:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1789986039; x=1790590839;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ssighiSPUExRNK+u6YhdtC00lHHudlBtMjJ6uyLW9p8=;
 b=FD5JG0lLEGITkGV2uyGHM4Eb6nq7IVbcHlPwkhsbs27BQ9q/DhEtyOzflbnuxr/sQr
 5jyQe8v52KOXbClKE5I3UdgJm+DLfd2G8v5YEZNpoQRfd4HDLVb1ZB0VWQf7HWy4rfHj
 UBC246+DlV2yxPbOD107FjbhA4aHSwurdmi4RoqbMKcSrYaYfV08Gw2v/3FtorDgF352
 JaKu+6uV2qsm/3AOZe/hqkka4TKEPTdj6uURf5nTlulakySAxsQYLV73omjt7SrhWH7e
 +ov4OwAcf5Ak9926CCptse21+GhzAHwxnJALUQzHXACs6txP5ndNX9v9T+XK8IAl1fxU
 UrOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789986039; x=1790590839;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ssighiSPUExRNK+u6YhdtC00lHHudlBtMjJ6uyLW9p8=;
 b=PHlUvRpV1RBdHoTjmCa4OJw6GzCzSvEgAhz5EhQkX4XBY3TAIgbmu+4D4i+ZOHUdlh
 2O96Amja5LGdfgKcGk89zFXaywZ0lEAF6PEqnZE1qwgetIemFC/cUPROy0I53vBtsIza
 19xyB+2GIzv/aMOHEC3oO+2VO/2yNGc6aT5HtdBV0OPNe9D6bb8xzH4LZxNZwVgvL1wA
 asYkvmz7lLWYH0+ZKF5QypS50xUPrZymbJGlsH6yEBpJkAjnAywGbYCNtAtS8W64O9We
 tIHLpfmX+GzJSJXsWpilV9ltbl8/Ljkd+OsT0iCrnOqtJt6yaFphzkcYRF5KclhpB9AT
 aZ6Q==
X-Gm-Message-State: AFuF++l3L5XYQeJl8zfRwBvUSpwG/FtRIzVjuzZ/4W1viRtjU0iL2xQR
 dqNODFuGjIG4AUphqt2fJFoC9cgjde8mlhr0a7sjPvEVdyCyvqajF63yax15J9k8nQGuFQDrTOe
 5EH27Qsw=
X-Gm-Gg: AYBFou3pQBD1c2k8o3VOMzRxeCFOIeTofoaI5XWsjtDFCsET8cP9vQK/isjyOZQv2Bi
 Mzm856DgVPzBF5hqjx2vE/suuf/vRyjUe+b4mwsULW2Z4hNhT40CLDko1mq6Co+JFhDXA4j/BoF
 8FtK+xcEPUwDbvSzMrep3PlmRE4c0Q4r6LFdLn5fGFDeKjWL4UUqDQqiZNmaL0+ZxNEqxKxcPos
 ug44TedLKVUTJwZoGE0/vyqbuXwd/aUG9wKaLggD0c52sm8nU34V20dwb+8q57BU4vP+DGokc66
 SVQTi4EsS4zuhMcb5QwlWt+DwWw62Z/AtPKSdvpGn74pxVg3RArQ8TUtXS7sdUul2Ifo15M1urB
 fVgd/YzgOCilpeG1DDZZIhKnRLOHfsaOGKjEE6MrF6U0ykkyCk0wc508SwMe7bbVD0jw1NzlfmC
 Du263GkhGdY3nrIKJx8VAbIB+SFiiNpfCPlKOvESwIeY5ZfxdsZ8kYJni3soE=
X-Received: by 2002:a05:6830:442b:b0:80a:3b3b:8ac6 with SMTP id
 46e09a7af769-80de21ccc78mr10847031a34.14.1789986039022; 
 Mon, 21 Sep 2026 03:20:39 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-8107dd8f425sm7613601a34.4.2026.09.21.03.20.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 03:20:38 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Mon, 21 Sep 2026 04:19:49 -0600
Subject: [PATCH v2 07/11] bsd-user: Implement exterrctl(2)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-misc-2025q4-v2-7-5eae157d31d3@bsdimp.com>
References: <20260921-misc-2025q4-v2-0-5eae157d31d3@bsdimp.com>
In-Reply-To: <20260921-misc-2025q4-v2-0-5eae157d31d3@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Warner Losh <imp@bsdimp.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1678; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=S2hYo9J+XOEsZ2N3+GzJd5woLvB78xfoaqGahFntErE=;
 b=owEBiQJ2/ZANAwAKAWwc0Sh9sBEAAcsmYgBqsQTeVehENgUEGbShaWL1Z0oPlMlpGas8I030q
 M4MS7PwkMeJAk8EAAEKADkWIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCarEE3hsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDMACgkQbBzRKH2wEQBbhxAAje89C0aOsGNvUXZn/qA8vFOMkBtAy4A
 ZWJPD4v236OzrlKLYHhqEqncpQaDBja+f/r4fEFaJhUPAc0+iRqBeU+htOFYpiQNtFMJ2jjlKQb
 0GTvtHO4zffKiAQQdyp2c+HLJXtJiHWhZ4rud00ZnjyAdG3SHiDDGNgtKrLKNYhtL0qAyk2YwF9
 e46H1qirbI2pfwdQleySvRw1nD0rL1XCH5mQ42n2C6b3HDCM8CjEcA24afE9IuTX1NDsBGRTk3b
 JlabhnmJ8ywiHgKoztW1IsyVcTxDwmhgGPky31U7g0u3QhF1E8HrvSiWXlUamGDTwZovcEbUHHZ
 rT9Uoy1NT4qwP7e9iuQQsPF4XTXjPvbLDiDr+n3loQh6rd0bIioxAj5HWbVoX5+Wu4OwmAH4znn
 vKtH1ZXzdvLv9qtlOeCqU2ch8ZKVTmnoHrseXnvPpZdtbEmzfXavd4H9Lt/4lNWcu6XxUqLby6Z
 ulSSmVcEfG+1KT+yXeN1AizSqbxScIbz7hYtJSkW6x5kIx3jLcTLcqkMGwj0jBRB95904xK0JJe
 MMp1o44fVISWE+oFGwznZRxhPoRTMNHfZEEW9bZii0n4GSk6sH7V14KsbGc2EOXq1G8a2TuRzln
 aFt/A9Y5+MxIQCInBl8o7dDdqKdq5Bf2r/sXJuIqVfdVaHkxpLHE=
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
 bsd-user/freebsd/os-misc.h    | 16 ++++++++++++++++
 bsd-user/freebsd/os-syscall.c |  6 ++++++
 2 files changed, 22 insertions(+)

diff --git a/bsd-user/freebsd/os-misc.h b/bsd-user/freebsd/os-misc.h
index be549c4bd9..fa40261da3 100644
--- a/bsd-user/freebsd/os-misc.h
+++ b/bsd-user/freebsd/os-misc.h
@@ -9,6 +9,9 @@
 #define OS_MISC_H
 
 #include <sys/cpuset.h>
+#ifdef TARGET_FREEBSD_NR_exterrctl
+#include <sys/exterrvar.h>
+#endif
 #include <sys/random.h>
 #include <sched.h>
 #include <kenv.h>
@@ -538,4 +541,17 @@ static inline abi_long do_freebsd_kenv(abi_long action, abi_ulong name,
     return ret;
 }
 
+#ifdef TARGET_FREEBSD_NR_exterrctl
+static inline abi_long do_freebsd_exterrctl(abi_long op, abi_long flags, abi_long ptr)
+{
+    void *hostptr = 0;
+
+    if (op == EXTERRCTL_ENABLE) {
+        hostptr = g2h_untagged(ptr);
+    }
+
+    return get_errno(exterrctl(op, flags, hostptr));
+}
+#endif
+
 #endif /* OS_MISC_H */
diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index 7e400c89bc..e87924fbb5 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -1592,6 +1592,12 @@ static abi_long freebsd_syscall(CPUArchState *env, int num, abi_long arg1,
         ret = do_freebsd_kenv(arg1, arg2, arg3, arg4);
         break;
 
+#ifdef TARGET_FREEBSD_NR_exterrctl
+    case TARGET_FREEBSD_NR_exterrctl:
+        ret = do_freebsd_exterrctl(arg1, arg2, arg3);
+        break;
+#endif
+
     /* XXX */
     case TARGET_FREEBSD_NR_cap_rights_limit:
     case TARGET_FREEBSD_NR_cap_ioctls_limit:

-- 
2.55.0


