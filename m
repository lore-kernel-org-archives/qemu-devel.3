Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BD4EC44501
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 20:10:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjMwW-0005lt-43; Mon, 13 Jul 2026 16:07:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wjMwU-0005l7-0i
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 16:07:54 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wjMwS-0006Sb-9n
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 16:07:53 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66DJ9R9W2409605
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 20:07:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=YG3Zw7TAzJC
 SNyyFoInQs9SV0Ktc8Bw77k7ZPMPyDA4=; b=ILDXK0per57vxDL38nHhKTw0anj
 hdQoaLl4qEvWT/WL0ALEWDGYepw4oxV7xHu9C4jPg1/zslQ1lP2BcGgGye+3lw8S
 a31nLY+4XzVCIAy7MkuMOxvBb3KFJNGssYImkaLB5WK1LVHhzHZ92POGAXw4HDCZ
 mZXBSbyOnTwRWriMebu0J9TZIho2rB5jBELJNTKwjV4a34tg52BqPgR4ZaiWmYof
 XTHf+16mIsb3TWHjv50zQjJNkV6c80BConnDSj1GzH4KyBDvS7vLjjS3uCYMYbLl
 vxWtpugNbqTkdhnnb5LI9aFmj8+zLF9r3Tn/Gt0oOOsPx5L51DTYbuTbS8Q==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcuj030rq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 20:07:41 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-384419c6c74so4800663a91.1
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 13:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783973260; x=1784578060; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YG3Zw7TAzJCSNyyFoInQs9SV0Ktc8Bw77k7ZPMPyDA4=;
 b=M4rOwCQG0DsJh1e7438oDunXIrY5FxNGkFnT/AggJ/iS/Qd1XRufq7XWHsrry2BDy3
 fosUBVl69C4M63G335y+tAPrdA9qIzYVlxlMLK6BdIBnNDKncj9VgCBx8bezTZoMtx6f
 W9Z88afbvxEH3+bfAiFs+2UUMZmzrtTH2hz31CNGwJM+95THFv4GhRZ1YQdmJaMmrs6P
 x2qrXpo6vA1FN06wKq+QWd9mkOhc95xOZwCkIaP25ZfuPEC+Akxzu/3/OIhluFrXOUbK
 G3/Bajqt5s8UHLzNgCScMjTqYsrurvmh/Zr+9R9bWdY7cDDwOr6KuOMr4B+1g4cyB3mP
 vtYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783973260; x=1784578060;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=YG3Zw7TAzJCSNyyFoInQs9SV0Ktc8Bw77k7ZPMPyDA4=;
 b=jvZcZRCsSxVAJhwdWZaVIZJE4EIt5EKBJi3LHLsRxt2QxihLE0MHVDBpmPk4wyXMoe
 ebJHPZ0pGbiQ0Awy/BSXx1etuO/iJN4JpFYioDsxE2+I0jrjb3y6BitvWDrLm/JFJwMY
 FcpvlKJ89jKZU+NF5lPhnaUUXM1pnwrsW4T4F/2iEaCqh1BcyOp0ZnhCvpkRG/x67f6c
 AYo7Qf1EbYQbTALqlE9SVxvPU1OHyGCj9YI8ch3Ltls39onW8sDn7jIRMfVPhBgrTD5h
 TndM9tnOJO+RC9rrqpXLWpXIIGTgT4hTrBrNrHInG0seMN7fznCFiPl3yccJpADrWAEu
 YXOg==
X-Gm-Message-State: AOJu0Yx0vG+Z1M96G8Mh6gzPtTLWG/OQn9+AISYgBEQVsYfZPymlWf8z
 erL8d4hH3avc6fMzHbPoe9DCocyXcI/rJWVVKRw0JP5Xb6pgPqyFHG9ttxctRVrKsufT/YeSIdK
 di6Myh3AP9RBttaA58G2uyEcLM0EtOGagfR3kSr71WjDW2b0LWepEmD/dJhaEkr0eEpse
X-Gm-Gg: AfdE7cksi6UacVFgUL+G1xtn9RCKUXoNPsunmzGj/85cTqcIL7nBPISPnMAEHJgRbgO
 tW/3LaE2ILWHZnQyhQvNhz6OyGuoGNPyZyw/byYvfJxSjO5NpFEgmA7TBdmfK5Lb/eyAHCUBuiF
 6dFfbBptYhq1QyLe9LGsKFrzqG2stQWC9rpcAVTuEIv2/BpznrJspVgRcvAyutcFyE3s8kvvMAU
 L9tF2M+/PoTenVoge4KqlTDZllBTvGtMEF/OTo0gzdl4oSJysC8/Ebu75stSxEjORGjR1VpF5eN
 s8cWMIlmzwTzsboL7TlksicVWUdf6k2Sj36CcRucUIXmkCDC0k6DnsTHEaLJGgXn+vb9XLhZ053
 F/bPZVmNE0TS0lrrJjwpGRpbkcSH0IXfTFcf086UoSnzcjo2fopH+wjkmhWur8VujVrYxHAkfJA
 ==
X-Received: by 2002:a17:90b:2c83:b0:380:f34a:6ff1 with SMTP id
 98e67ed59e1d1-38dc75eb657mr9291467a91.17.1783973260381; 
 Mon, 13 Jul 2026 13:07:40 -0700 (PDT)
X-Received: by 2002:a17:90b:2c83:b0:380:f34a:6ff1 with SMTP id
 98e67ed59e1d1-38dc75eb657mr9291435a91.17.1783973259870; 
 Mon, 13 Jul 2026 13:07:39 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-313cb804197sm24106543eec.13.2026.07.13.13.07.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 13:07:39 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com,
 marco.liebel@oss.qualcomm.com, philmd@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng
Subject: [PATCH 12/14] target/hexagon: Add an errno mapping
Date: Mon, 13 Jul 2026 13:07:20 -0700
Message-Id: <60a8f2decf0af0581a82f95edc0f58c5420042f6.1783973054.git.matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1783973054.git.matheus.bernardino@oss.qualcomm.com>
References: <cover.1783973054.git.matheus.bernardino@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDIwOCBTYWx0ZWRfXwy/iYqx7DHR3
 zXm775Wr9OZcNQEfumczy04/JX6BT1j+o6ZuYYuvHcqE9rdV3LtvlTEtRU9i61L61fJj5tIS83y
 TZiDu+l4c2DpDMXMDos5jezoCKO1LNc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDIwOCBTYWx0ZWRfX2zlRvif2v5et
 A0Q41s0BFFsLn/7s4E64MTneE/CM9q6KMyqVo9x8bBrxJ5OvSKAGcIhXH7AHs4BvnilkpshjP3X
 RGKjwFxZyfY2Qb3F8ZGPR5woJLNVIVO+NNcAS3Sf0Vx0DdJGkYozmw9UZ2ngxVOAMZIs6HPiKaA
 W4fqgx0+/5YPc4+bB+EWpI8EqC1zqLd/xgqkc0Bga2AVCqNJd17xMOeuO5JcgOXfsjAFlbRSK1I
 V1N+rtOHg6kTCPMj1cUU5cXDUTVptt64hGoe/E8NBOvoiywfuVktafuAc91kEEljQbE0zKGmjNI
 7qlC48P032Bbyn2djAGE5NAGhkREqeVQVMiVn8rskIIZ0SLzCf4eeIcDZ9DyeB+fm8Y07OsOPd2
 TQ1Zh2R7u1wGRo8as/rFsnraAuCQj1nOI090mL+2MWl6tqsuvF9C+V+IRBxK7N49NxXPw//1GZB
 v3B+h9KzHgpX6XmxhbQ==
X-Proofpoint-ORIG-GUID: nV4fZ8lkj51Tr06_jo4VZL4msgtrLmSn
X-Authority-Analysis: v=2.4 cv=DbcnbPtW c=1 sm=1 tr=0 ts=6a55458d cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=PHjQTd04LRaCaomXAJMA:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: nV4fZ8lkj51Tr06_jo4VZL4msgtrLmSn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_05,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 phishscore=0 suspectscore=0 bulkscore=0 adultscore=0 spamscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607130208
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=matheus.bernardino@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

From: Brian Cain <brian.cain@oss.qualcomm.com>

The Hexagon semihosting ABI defines its own errno values
which may differ from the host's.  Translate host errno to
the Hexagon-specific values before returning results to the
guest so that baremetal programs see the expected error codes.

Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
---
 target/hexagon/hexswi.c | 81 +++++++++++++++++++++++++++++++++--------
 1 file changed, 66 insertions(+), 15 deletions(-)

diff --git a/target/hexagon/hexswi.c b/target/hexagon/hexswi.c
index edadb40bed6..81fe3d5046d 100644
--- a/target/hexagon/hexswi.c
+++ b/target/hexagon/hexswi.c
@@ -122,12 +122,63 @@ static void do_preload(CPUHexagonState *env, target_ulong swi_info, bool load)
     hexagon_touch_memory(env, addr, count, retaddr);
 }
 
+/* Hexagon semihosting errno values */
+#define HEX_EINVAL          22
+#define HEX_ERRNOS \
+    HEX_ERRNO(EPERM,        1) \
+    HEX_ERRNO(ENOENT,       2) \
+    HEX_ERRNO(EINTR,        4) \
+    HEX_ERRNO(EIO,          5) \
+    HEX_ERRNO(ENXIO,        6) \
+    HEX_ERRNO(EBADF,        9) \
+    HEX_ERRNO(EAGAIN,       11) \
+    HEX_ERRNO(ENOMEM,       12) \
+    HEX_ERRNO(EACCES,       13) \
+    HEX_ERRNO(EFAULT,       14) \
+    HEX_ERRNO(EBUSY,        16) \
+    HEX_ERRNO(EEXIST,       17) \
+    HEX_ERRNO(EXDEV,        18) \
+    HEX_ERRNO(ENODEV,       19) \
+    HEX_ERRNO(ENOTDIR,      20) \
+    HEX_ERRNO(EISDIR,       21) \
+    HEX_ERRNO(EINVAL,       HEX_EINVAL) \
+    HEX_ERRNO(ENFILE,       23) \
+    HEX_ERRNO(EMFILE,       24) \
+    HEX_ERRNO(ENOTTY,       25) \
+    HEX_ERRNO(ETXTBSY,      26) \
+    HEX_ERRNO(EFBIG,        27) \
+    HEX_ERRNO(ENOSPC,       28) \
+    HEX_ERRNO(ESPIPE,       29) \
+    HEX_ERRNO(EROFS,        30) \
+    HEX_ERRNO(EMLINK,       31) \
+    HEX_ERRNO(EPIPE,        32) \
+    HEX_ERRNO(ERANGE,       34) \
+    HEX_ERRNO(ENAMETOOLONG, 36) \
+    HEX_ERRNO(ENOSYS,       38) \
+    HEX_ERRNO(ELOOP,        40) \
+    HEX_ERRNO(EOVERFLOW,    75)
+
+/* Map host errno to hexagon semihosting errno */
+static void semi_cb(CPUState *cs, uint64_t ret, int err)
+{
+#define HEX_ERRNO(NAME, CODE) case NAME: err = CODE; break;
+    switch (err) {
+    case 0:
+        break;
+    HEX_ERRNOS
+    default:
+        err = HEX_EINVAL;
+        break;
+    }
+    common_semi_cb(cs, ret, err);
+}
+
 static void common_semi_ftell_cb(CPUState *cs, uint64_t ret, int err)
 {
     if (err) {
         ret = -1;
     }
-    common_semi_cb(cs, ret, err);
+    semi_cb(cs, ret, err);
 }
 
 static void coredump(CPUHexagonState *env)
@@ -360,7 +411,7 @@ static void sim_handle_trap0(CPUHexagonState *env)
             qemu_log_mask(LOG_GUEST_ERROR,
                           "%s: filename too large (%d)\n",
                           __func__, length);
-            common_semi_cb(cs, -1, ENAMETOOLONG);
+            semi_cb(cs, -1, ENAMETOOLONG);
             break;
         }
 
@@ -377,7 +428,7 @@ static void sim_handle_trap0(CPUHexagonState *env)
             qemu_log_mask(LOG_GUEST_ERROR,
                           "%s: invalid OPEN mode: %u\n",
                           __func__, filemode);
-            common_semi_cb(cs, -1, EINVAL);
+            semi_cb(cs, -1, EINVAL);
             break;
         }
 
@@ -396,7 +447,7 @@ static void sim_handle_trap0(CPUHexagonState *env)
                 ret = guestfd;
             }
         }
-        common_semi_cb(cs, ret, err);
+        semi_cb(cs, ret, err);
     }
     break;
 
@@ -415,7 +466,7 @@ static void sim_handle_trap0(CPUHexagonState *env)
     {
         int fd;
         hexagon_read_memory(env, swi_info, 4, &fd, retaddr);
-        common_semi_cb(cs, isatty(fd), 0);
+        semi_cb(cs, isatty(fd), 0);
     }
     break;
 
@@ -496,7 +547,7 @@ static void sim_handle_trap0(CPUHexagonState *env)
             hexagon_write_memory(env, statBufferAddr + i, 1, st_bufptr[i],
                                  retaddr);
         }
-        common_semi_cb(cs, rc, rc == 0 ? 0 : err);
+        semi_cb(cs, rc, rc == 0 ? 0 : err);
     }
     break;
 
@@ -506,7 +557,7 @@ static void sim_handle_trap0(CPUHexagonState *env)
         off_t size_limit;
         hexagon_read_memory(env, swi_info, 4, &fd, retaddr);
         hexagon_read_memory(env, swi_info + 4, 8, &size_limit, retaddr);
-        semihost_sys_ftruncate(cs, common_semi_cb, fd, size_limit);
+        semihost_sys_ftruncate(cs, semi_cb, fd, size_limit);
     }
     break;
 
@@ -530,7 +581,7 @@ static void sim_handle_trap0(CPUHexagonState *env)
         hexagon_read_memory(env, swi_info + 4, 4, &BufferMode, retaddr);
 
         rc = access(filename, BufferMode);
-        common_semi_cb(cs, rc,  rc == 0 ? 0 : errno);
+        semi_cb(cs, rc,  rc == 0 ? 0 : errno);
     }
     break;
 
@@ -558,14 +609,14 @@ static void sim_handle_trap0(CPUHexagonState *env)
                 rc = BufferAddr;
             }
         }
-        common_semi_cb(cs, rc, rc != 0 ? 0 : err);
+        semi_cb(cs, rc, rc != 0 ? 0 : err);
         break;
     }
 
     case HEX_SYS_EXEC:
     {
         qemu_log_mask(LOG_UNIMP, "SYS_EXEC is deprecated\n");
-        common_semi_cb(cs, -1, ENOSYS);
+        semi_cb(cs, -1, ENOSYS);
     }
     break;
 
@@ -588,7 +639,7 @@ static void sim_handle_trap0(CPUHexagonState *env)
         } else {
             err = errno;
         }
-        common_semi_cb(cs, rc, rc != 0 ? 0 : err);
+        semi_cb(cs, rc, rc != 0 ? 0 : err);
         break;
     }
 
@@ -622,7 +673,7 @@ static void sim_handle_trap0(CPUHexagonState *env)
             }
             rc = guest_dir_entry;
         }
-        common_semi_cb(cs, rc, err);
+        semi_cb(cs, rc, err);
         break;
     }
 
@@ -641,7 +692,7 @@ static void sim_handle_trap0(CPUHexagonState *env)
         } else {
             err = EBADF;
         }
-        common_semi_cb(cs, ret, ret == 0 ? 0 : err);
+        semi_cb(cs, ret, ret == 0 ? 0 : err);
         break;
     }
 
@@ -680,7 +731,7 @@ static void sim_handle_trap0(CPUHexagonState *env)
     case HEX_SYS_PROF_STATSRESET:
     case HEX_SYS_DUMP_PMU_STATS:
     case HEX_SYS_HEAPINFO:
-        common_semi_cb(cs, -1, ENOSYS);
+        semi_cb(cs, -1, ENOSYS);
         qemu_log_mask(LOG_UNIMP,
                       "SWI call %" PRIx32
                       " is unimplemented in QEMU\n",
@@ -693,7 +744,7 @@ static void sim_handle_trap0(CPUHexagonState *env)
         qemu_log_mask(LOG_GUEST_ERROR,
                       "unknown swi request: 0x%" PRIx32 "\n",
                       (uint32_t)what_swi);
-        common_semi_cb(cs, -1, ENOSYS);
+        semi_cb(cs, -1, ENOSYS);
     }
 }
 
-- 
2.37.2


