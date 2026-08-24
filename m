Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44C20C5DF9C
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 15:59:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyX4b-0005Fc-04; Mon, 24 Aug 2026 11:58:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wyX4X-0005EI-Qi
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 11:58:53 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wyX4S-0001mF-VO
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 11:58:52 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67OFnFZc3329816
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 15:58:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=hCQy0mHnaVb
 DAwTpeZiwfNJ0h2z/hVkXsuta5kPZ9Fc=; b=p3kRXEqbJY82VRi6L4U1Rsm3lz3
 w7VFXdawZ2SQOVloMV+eTa5q8FNO/w96Oj9FHZThTvGQ7NpQ7825UlgvH55JYyrH
 CPi1j5HpwiQUAJs8xJPaQbCrC0xqOrylb+VR/+Ylm4TQyin8ZXP7vIdqagoVif4Z
 dTRdQwLSx1zkfXFpNBJIIN6+brNZ9RaDEEh7F09kv114UtntBn9Rcj6I7s6Za/+q
 DA38PEd7FuVsxnyUpaT1Dtje8oiTPTedmPN9lXC7iEhDgf9/xOaRglLwbQEyyoM3
 QIu+rihL6qrTsgqeisnbfWzdIM11gsxqTlAEKdYqh4NCeJVFMDsIq/1AGgQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g8j7r1xyf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 15:58:37 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-38e25e4b41cso4084603a91.0
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 08:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787587117; x=1788191917; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hCQy0mHnaVbDAwTpeZiwfNJ0h2z/hVkXsuta5kPZ9Fc=;
 b=cP0eoiMUQWPyt1cyfCEWQPaPFA2YsTtdZnVydW3ZEbMKZ+ZUvPe3P7PRdC8w+n9JKr
 oc6WPhbD0VdGPQnmNLmyJbDDA5lzXJ5/OSjPCp8OL7r5xPJwXv6oU+Q3e/Up6wfn+Rm4
 GEms7b5reAMKEGtIejnzNxmjPFbY9WML+2qf2CG9+lqx71607OJBSjviqmlgFYTwHzZv
 JWbazsR+fUaZdm1/53u3L93F2hYz0pAe6p/2HNigkqMiv5wSYTNkyL7hwveHRFR5XvV6
 /zjwgjcGWAbx2+q2zC9pZXCK+FJuSl9buyEs82YL23tgNp/tmqAObWpaFZYXLFZ4KRSL
 4XZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787587117; x=1788191917;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=hCQy0mHnaVbDAwTpeZiwfNJ0h2z/hVkXsuta5kPZ9Fc=;
 b=OrkHazznR2W7Ub+5yAXfls5SgBy09fjstfImJcx7PHIFF5cAAW1VYmtseXB4OiBpyV
 hDJD3wbICEoLCPsBu8R+sjar+f2QFzfDIPweHA/F04NIMefvb9DNwCNXOKlwYyE6kXB5
 nRsyUgNrTjopVMnn/r0p1vPKKlOzKXV+dFSqo5HVRjIVZDj7MT0wM0pPo62qZMQhft2q
 OrV3LjDp8JVfHKwGplrfVKSqplDcio3dK11q6V+FUVm14AVs5T3+PQm/ssdBeZct22fw
 uz1AAkkBe5ksyC3IIoTP7knSkwFH6BsPG4bAcbm9qATLIGHtJt3NN97mD+EzyKWve6DU
 tfwA==
X-Gm-Message-State: AFuF++noyQENIYfQpH+N0law/tRyCvDZjVP3xrtYFrVBd/MNzRnz7q1L
 2MvR150uek4PS+xo2mFvO97iin6ZVkYKpHA8zOpQc2vz++5X8HFnxvbjOqaYcxWyw6KuRTfUF0S
 aaQJb8Ikq9TXV7kDQwBZrVDnskDzFe/2k+BYLQMRxVzPA1vR3UxqqOh/8XfhpdBvHAEZD
X-Gm-Gg: AR+sD11OGVRFOx8nRYXqxu8TyPuxvzEWZNdPVkCT7m0i7+xOGgWgJ3LUS7rgpg7H+jp
 Q5jq1DuwuuP7pan+HpU243cC9KhId5uIgx0H1EIJrd6Uq2QYGmllPXff1QkTDfxHUtgvE75wdAl
 nPmP/1bUz8M4zBS+zkXzFBO6f5UpstD5uByMcSg547VT0uSmeJ+pepBEkwCny6LdxyAA1PyDpsD
 Ff6/6BSILbfBRSlzG4OO4AuRllM1d65YaF3YSsKO3hy5069yRPzYTVSZfp0Nz4BCca51JPC0K2E
 E35V2WL8erRAkXnOJGU9JFIxpRy7gFYhkcu44t4xQB25ltsgbUiQ0lFNzmfGh9MTgvuyAhBdXqI
 b3acr5OIv/wATiBl7WAEBovK5DSoBae80yZRtJwiOPWKb5GXACMk8fVlRGOVbDWs=
X-Received: by 2002:a17:90b:1f8d:b0:38c:a59b:5189 with SMTP id
 98e67ed59e1d1-395df67778fmr36780353a91.15.1787587116824; 
 Mon, 24 Aug 2026 08:58:36 -0700 (PDT)
X-Received: by 2002:a17:90b:1f8d:b0:38c:a59b:5189 with SMTP id
 98e67ed59e1d1-395df67778fmr36780250a91.15.1787587116256; 
 Mon, 24 Aug 2026 08:58:36 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14186183c0esm41152935c88.12.2026.08.24.08.58.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 08:58:35 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: ale@rev.ng, anjo@rev.ng, brian.cain@oss.qualcomm.com,
 marco.liebel@oss.qualcomm.com, philmd@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com
Subject: [PATCH v4 10/14] target/hexagon: add main arch-specific semihosting
 operations
Date: Mon, 24 Aug 2026 08:58:19 -0700
Message-Id: <dde79236486f234eac0c1452e8c6aa8e917afb53.1787586642.git.matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1787586642.git.matheus.bernardino@oss.qualcomm.com>
References: <cover.1787586642.git.matheus.bernardino@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDEzNCBTYWx0ZWRfXwGAT8p/ERuHv
 0k7HzzmQBoJcmpy8WHweT7ESNvqr4iWES9zedF4jrqDGRsZwwQgyfflcCoTykqOuZBp2e35bDDe
 EVFl87L6qfsOHAi181RdCImjeIpK4qq/V3Ar7NKDI7x4HkBFyVvQLIO70V2YliKJD8MoFh1VDRi
 HJepH79so9FINypzn6Caplk1PeKrDeda07LQN+mg3ybwvjQhwjgh/o1EIHkpArluhPvRb6r2g77
 Cr8uWyML8CGs4HsjNfGkvOc8nsWwQC7gAfRqKsAHg6eb5OSzT/MFTNY21dVwEANN34M20OX3wjf
 xorXmgrudZCZBkHxAXIE27gVAc+Dmt83Dl72vg7fD5XSsr65/utSE13NFJZ0aouy7lhw+0GH83N
 NW29c0NwO97C4rfqlX6C/nHeuzcarcgaJ0trPv/tvpVZJOiAFPlD84MSDY0hqgiGhdtI8y9Jbsg
 z0lHnoc9lRWOzIYs3Gg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDEzNCBTYWx0ZWRfXymvAAfE8C7+1
 GMu+Lg2EENJnpEsiVhuY/abVjvMxUqH4UTRGUAmqn5ElqNFVNo+VU0FhoFUXAne4BVXSkRhDhNG
 7h1qwtyebuS0DZ3gdm/touOlkmu+E4g=
X-Proofpoint-GUID: rsYfgFw5VCG5Crwb7UggZ4Z8GuPTDnIg
X-Authority-Analysis: v=2.4 cv=IL8yzAvG c=1 sm=1 tr=0 ts=6a8c6a2d cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=UwY7kZyrlkj7TMZqf0EA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: rsYfgFw5VCG5Crwb7UggZ4Z8GuPTDnIg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_05,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 phishscore=0 priorityscore=1501 suspectscore=0
 spamscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240134
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

The Hexagon semihosting ABI extends the arm-compatible set with
operations like OPEN, WRITECREG, WRITE0, ISTTY, STAT, FSTAT, FTELL,
SEEK, FTRUNC, ACCESS, and GETCWD. Implement these trap0 handlers so
that baremetal programs using the standard Hexagon simulator ABI can
perform file I/O when running on qemu-system-hexagon.

Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>
Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
---
 include/semihosting/common-semi.h |   1 +
 semihosting/arm-compat-semi.c     |   2 +-
 target/hexagon/hexswi.c           | 290 +++++++++++++++++++++++++++++-
 3 files changed, 291 insertions(+), 2 deletions(-)

diff --git a/include/semihosting/common-semi.h b/include/semihosting/common-semi.h
index a11905ef4e..1e7699d7bb 100644
--- a/include/semihosting/common-semi.h
+++ b/include/semihosting/common-semi.h
@@ -34,6 +34,7 @@
 #ifndef COMMON_SEMI_H
 #define COMMON_SEMI_H
 
+void common_semi_cb(CPUState *cs, uint64_t ret, int err);
 void do_common_semihosting(CPUState *cs);
 uint64_t common_semi_arg(CPUState *cs, int argno);
 void common_semi_set_ret(CPUState *cs, uint64_t ret);
diff --git a/semihosting/arm-compat-semi.c b/semihosting/arm-compat-semi.c
index c54753f696..b930a02864 100644
--- a/semihosting/arm-compat-semi.c
+++ b/semihosting/arm-compat-semi.c
@@ -229,7 +229,7 @@ static inline uint32_t get_swi_errno(CPUState *cs)
 #endif
 }
 
-static void common_semi_cb(CPUState *cs, uint64_t ret, int err)
+void common_semi_cb(CPUState *cs, uint64_t ret, int err)
 {
     if (err) {
 #ifdef CONFIG_USER_ONLY
diff --git a/target/hexagon/hexswi.c b/target/hexagon/hexswi.c
index a5d56fb844..fe588d9489 100644
--- a/target/hexagon/hexswi.c
+++ b/target/hexagon/hexswi.c
@@ -85,6 +85,41 @@ static inline bool is_hexagon_specific_swi_flag(enum hex_swi_flag what_swi)
 }
 #undef DEF_SWI_FLAG
 
+static const unsigned int angel_to_host_filemode_table[] = {
+    O_RDONLY,
+    O_RDONLY | O_BINARY,
+    O_RDWR,
+    O_RDWR | O_BINARY,
+    O_WRONLY | O_CREAT | O_TRUNC,
+    O_WRONLY | O_CREAT | O_TRUNC | O_BINARY,
+    O_RDWR | O_CREAT | O_TRUNC,
+    O_RDWR | O_CREAT | O_TRUNC | O_BINARY,
+    O_WRONLY | O_APPEND | O_CREAT,
+    O_WRONLY | O_APPEND | O_CREAT | O_BINARY,
+    O_RDWR | O_APPEND | O_CREAT,
+    O_RDWR | O_APPEND | O_CREAT | O_BINARY,
+    O_RDWR | O_CREAT,
+    O_RDWR | O_CREAT | O_EXCL
+};
+
+/*
+ * This must match the caller's definition, it would be in the
+ * caller's angel.h or equivalent header.
+ */
+struct __SYS_STAT {
+    uint64_t dev;
+    uint64_t ino;
+    uint32_t mode;
+    uint32_t nlink;
+    uint64_t rdev;
+    uint32_t size;
+    uint32_t __pad1;
+    uint32_t atime;
+    uint32_t mtime;
+    uint32_t ctime;
+    uint32_t __pad2;
+} sys_stat;
+
 static void init_semihosting_guestfds(void)
 {
     static gsize initialized;
@@ -119,10 +154,19 @@ static void do_preload(CPUHexagonState *env, target_ulong swi_info, bool load)
     hexagon_peek_memory_range(env, addr, count, retaddr);
 }
 
+static void common_semi_ftell_cb(CPUState *cs, uint64_t ret, int err)
+{
+    if (err) {
+        ret = -1;
+    }
+    common_semi_cb(cs, ret, err);
+}
+
 static void sim_handle_trap0(CPUHexagonState *env)
 {
     target_ulong what_swi, swi_info;
     CPUState *cs = env_cpu(env);
+    uintptr_t retaddr = 0;
 
     g_assert(bql_locked());
     init_semihosting_guestfds();
@@ -177,7 +221,251 @@ static void sim_handle_trap0(CPUHexagonState *env)
     }
     break;
 
-    /* TODO: implement other hexagon-specific semihosting calls */
+    case HEX_SYS_OPEN:
+    {
+        char filename[BUFSIZ];
+        target_ulong physical_filename_addr;
+        unsigned int filemode;
+        int length;
+        int real_openmode;
+        int ret, err = 0;
+        int i = 0;
+
+        hexagon_read_memory(env, swi_info, 4, &physical_filename_addr, retaddr);
+        hexagon_read_memory(env, swi_info + 4, 4, &filemode, retaddr);
+        hexagon_read_memory(env, swi_info + 8, 4, &length, retaddr);
+
+        if (length >= BUFSIZ) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: filename too large (%d)\n",
+                          __func__, length);
+            common_semi_cb(cs, -1, ENAMETOOLONG);
+            break;
+        }
+
+        do {
+            hexagon_read_memory(env, physical_filename_addr + i, 1, &filename[i],
+                                retaddr);
+            i++;
+        } while (filename[i - 1]);
+
+        /* convert ARM ANGEL filemode into host filemode */
+        if (filemode < ARRAY_SIZE(angel_to_host_filemode_table)) {
+            real_openmode = angel_to_host_filemode_table[filemode];
+        } else {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: invalid OPEN mode: %u\n",
+                          __func__, filemode);
+            common_semi_cb(cs, -1, EINVAL);
+            break;
+        }
+
+        if (strcmp(filename, ":tt") == 0 &&
+            qemu_semihosting_console_has_chardev()) {
+            ret = alloc_guestfd();
+            console_guestfd(ret);
+        } else {
+            ret = open(filename, real_openmode | O_BINARY, 0644);
+
+            if (ret == -1) {
+                err = errno;
+            } else {
+                int guestfd = alloc_guestfd();
+                associate_guestfd(guestfd, ret);
+                ret = guestfd;
+            }
+        }
+        common_semi_cb(cs, ret, err);
+    }
+    break;
+
+    case HEX_SYS_WRITECREG:
+    {
+        char c = swi_info;
+        qemu_semihosting_console_write(&c, 1);
+    }
+    break;
+
+    /*
+     * Hexagon's SYS_ISTTY is a bit different than arm's: we do not return -1
+     * on error, neither errno. So we override with our own implementation.
+     */
+    case HEX_SYS_ISTTY:
+    {
+        int fd;
+        hexagon_read_memory(env, swi_info, 4, &fd, retaddr);
+        common_semi_cb(cs, isatty(fd), 0);
+    }
+    break;
+
+    case HEX_SYS_SEEK:
+    {
+        int fd;
+        target_ulong off;
+        hexagon_read_memory(env, swi_info, 4, &fd, retaddr);
+        hexagon_read_memory(env, swi_info + 4, 4, &off, retaddr);
+        semihost_sys_lseek(env_cpu(env), common_semi_ftell_cb, fd, off,
+                          GDB_SEEK_SET);
+    }
+    break;
+
+    case HEX_SYS_STAT:
+    case HEX_SYS_FSTAT:
+    {
+        struct stat st_buf;
+        uint8_t *st_bufptr = (uint8_t *)&sys_stat;
+        int rc, err = 0;
+        char filename[BUFSIZ];
+        target_ulong physical_filename_addr;
+        target_ulong statBufferAddr;
+        hexagon_read_memory(env, swi_info, 4, &physical_filename_addr, retaddr);
+
+        if (what_swi == HEX_SYS_STAT) {
+            int i = 0;
+            do {
+                hexagon_read_memory(env, physical_filename_addr + i, 1,
+                                    &filename[i], retaddr);
+                i++;
+            } while ((i < BUFSIZ) && filename[i - 1]);
+            rc = stat(filename, &st_buf);
+            err = errno;
+        } else {
+            int fd = physical_filename_addr;
+            GuestFD *gf = get_guestfd(fd);
+            if (!gf || gf->type != GuestFDHost) {
+                qemu_log_mask(LOG_UNIMP,
+                              "fstat semihosting only implemented"
+                              " for native mode\n");
+                g_assert_not_reached();
+            }
+            rc = fstat(gf->hostfd, &st_buf);
+            err = errno;
+        }
+        if (rc == 0) {
+            sys_stat.dev   = cpu_to_le64(st_buf.st_dev);
+            sys_stat.ino   = cpu_to_le64(st_buf.st_ino);
+            sys_stat.mode  = cpu_to_le32(st_buf.st_mode);
+            sys_stat.nlink = cpu_to_le32((uint32_t) st_buf.st_nlink);
+            sys_stat.rdev  = cpu_to_le64(st_buf.st_rdev);
+            sys_stat.size  = cpu_to_le32((uint32_t) st_buf.st_size);
+            sys_stat.atime = cpu_to_le32(st_buf.st_atime);
+            sys_stat.mtime = cpu_to_le32(st_buf.st_mtime);
+            sys_stat.ctime = cpu_to_le32(st_buf.st_ctime);
+        }
+        hexagon_read_memory(env, swi_info + 4, 4, &statBufferAddr, retaddr);
+
+        for (int i = 0; i < sizeof(sys_stat); i++) {
+            hexagon_write_memory(env, statBufferAddr + i, 1, st_bufptr[i],
+                                 retaddr);
+        }
+        common_semi_cb(cs, rc, rc == 0 ? 0 : err);
+    }
+    break;
+
+    case HEX_SYS_FTRUNC:
+    {
+        int fd;
+        off_t size_limit;
+        hexagon_read_memory(env, swi_info, 4, &fd, retaddr);
+        hexagon_read_memory(env, swi_info + 4, 8, &size_limit, retaddr);
+        semihost_sys_ftruncate(cs, common_semi_cb, fd, size_limit);
+    }
+    break;
+
+    case HEX_SYS_ACCESS:
+    {
+        char filename[BUFSIZ];
+        uint32_t FileNameAddr;
+        uint32_t BufferMode;
+        int rc;
+
+        int i = 0;
+
+        hexagon_read_memory(env, swi_info, 4, &FileNameAddr, retaddr);
+        do {
+            hexagon_read_memory(env, FileNameAddr + i, 1, &filename[i],
+                                retaddr);
+            i++;
+        } while ((i < BUFSIZ) && (filename[i - 1]));
+        filename[i] = 0;
+
+        hexagon_read_memory(env, swi_info + 4, 4, &BufferMode, retaddr);
+
+        rc = access(filename, BufferMode);
+        common_semi_cb(cs, rc,  rc == 0 ? 0 : errno);
+    }
+    break;
+
+    case HEX_SYS_GETCWD:
+    {
+        char cwdPtr[PATH_MAX];
+        uint32_t BufferAddr;
+        uint32_t BufferSize;
+        uint32_t rc = 0, err = 0;
+
+        hexagon_read_memory(env, swi_info, 4, &BufferAddr, retaddr);
+        hexagon_read_memory(env, swi_info + 4, 4, &BufferSize, retaddr);
+
+        if (!getcwd(cwdPtr, PATH_MAX)) {
+            err = errno;
+        } else {
+            size_t cwd_size = strlen(cwdPtr);
+            if (cwd_size > BufferSize) {
+                err = ERANGE;
+            } else {
+                for (int i = 0; i < cwd_size; i++) {
+                    hexagon_write_memory(env, BufferAddr + i, 1,
+                                         (uint64_t)cwdPtr[i], retaddr);
+                }
+                rc = BufferAddr;
+            }
+        }
+        common_semi_cb(cs, rc, rc != 0 ? 0 : err);
+        break;
+    }
+
+    case HEX_SYS_EXEC:
+    {
+        qemu_log_mask(LOG_UNIMP, "SYS_EXEC is deprecated\n");
+        common_semi_cb(cs, -1, ENOSYS);
+    }
+    break;
+
+    case HEX_SYS_FTELL:
+    {
+        int fd;
+        hexagon_read_memory(env, swi_info, 4, &fd, retaddr);
+        semihost_sys_lseek(cs, common_semi_ftell_cb, fd, 0, GDB_SEEK_CUR);
+    }
+    break;
+
+    case HEX_SYS_READ_CYCLES:
+    case HEX_SYS_READ_TCYCLES:
+    case HEX_SYS_READ_ICOUNT:
+    {
+        env->gpr[HEX_REG_R00] = 0;
+        env->gpr[HEX_REG_R01] = 0;
+        break;
+    }
+
+    case HEX_SYS_READ_PCYCLES:
+    {
+        env->gpr[HEX_REG_R00] = hexagon_get_sys_pcycle_count_low(env);
+        env->gpr[HEX_REG_R01] = hexagon_get_sys_pcycle_count_high(env);
+        break;
+    }
+
+    case HEX_SYS_PROF_ON:
+    case HEX_SYS_PROF_OFF:
+    case HEX_SYS_PROF_STATSRESET:
+    case HEX_SYS_DUMP_PMU_STATS:
+    case HEX_SYS_HEAPINFO:
+        common_semi_cb(cs, -1, ENOSYS);
+        qemu_log_mask(LOG_UNIMP,
+                      "SWI call %" PRIx32
+                      " is unimplemented in QEMU\n",
+                      (uint32_t)what_swi);
+        break;
 
     default:
         qemu_log_mask(LOG_UNIMP,
-- 
2.37.2


