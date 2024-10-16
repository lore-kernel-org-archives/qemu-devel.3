Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EAF6D2A53D
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2024 17:52:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t18BU-0001x0-K7; Wed, 16 Oct 2024 13:51:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1t18BN-0001wV-P1
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 13:51:37 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1t18BL-00085o-L7
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 13:51:37 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49GHUSuK022130
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2024 17:51:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=P/T5znw8vVJEcn58Q
 nJFvd31nFP6XYEhJ5pKklmQe3s=; b=nz48jgkLuMcbGSMX0fWNfwNPufaXjWd70
 AQircq47Z0iGFmkmFt8OcwFYJwCPhAbBBterWWBcTAIqwiQdn2n/SfIxwESDj4PG
 KhiXpuG0oRhnQ6fmCcUiAzhwF2IDqA54PY6OoGK/hga806d6Gp4w1HyVYjX63R2+
 ZKPnai2m3hqB1D4kiT8yT7OOTM9fKssSAoq7hT4tkmWfYqaYQUXG8SmQEdcWnkR6
 Y135T6arD7AfRtwX1rIXYf1fjXmqCOcLrY59oEpKWHDtFIK5wfqWkcsxYS8GgIxl
 mL2fIeRltGu/Le1xr9sFpgTZYsmlMTtK1vvSEozGCtLyCtId6fB7g==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42ahxj02re-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2024 17:51:33 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49GHpXbT001871
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2024 17:51:33 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42ahxj02r9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 16 Oct 2024 17:51:33 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49GH0x0X006757;
 Wed, 16 Oct 2024 17:51:31 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4284xkamj3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 16 Oct 2024 17:51:31 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 49GHpVdG46727522
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 16 Oct 2024 17:51:31 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 125CE58063;
 Wed, 16 Oct 2024 17:51:31 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CB41958062;
 Wed, 16 Oct 2024 17:51:30 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 16 Oct 2024 17:51:30 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, marcandre.lureau@gmail.com,
 Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v4 1/2] tpm: Use new ptm_cap_n structure for PTM_GET_CAPABILITY
Date: Wed, 16 Oct 2024 13:51:28 -0400
Message-ID: <20241016175129.1319176-2-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241016175129.1319176-1-stefanb@linux.ibm.com>
References: <20241016175129.1319176-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: sJQiB35omjjPp4Rzzl-B61WldeUOjLWP
X-Proofpoint-ORIG-GUID: YSDfiInoRcdjd0QdR9Q9qVpz0nZ53xUh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0
 clxscore=1015 bulkscore=0 adultscore=0 mlxlogscore=999 lowpriorityscore=0
 phishscore=0 priorityscore=1501 suspectscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410160112
Received-SPF: pass client-ip=148.163.156.1; envelope-from=stefanb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Use the new ptm_cap_n structure for getting the PTM_GET_CAPABILITY response
from swtpm. Previously only 17 bits could possibly have been set in ptm_cap
(=uint64_t) in big endian order and those bits are now found in the 2nd
32bit word in the response in the caps field.

This data structure makes it now clear that the 1st 32bit word carries the
tpm_result like all the other response structures of all other commands
do.

The changes are taken from the swtpm project's tpm_ioctl.h.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 backends/tpm/tpm_emulator.c | 14 ++++++++------
 backends/tpm/tpm_ioctl.h    | 13 ++++++++++++-
 backends/tpm/trace-events   |  2 +-
 3 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/backends/tpm/tpm_emulator.c b/backends/tpm/tpm_emulator.c
index 5a8fba9bde..b0e2fb3fc7 100644
--- a/backends/tpm/tpm_emulator.c
+++ b/backends/tpm/tpm_emulator.c
@@ -72,7 +72,7 @@ struct TPMEmulator {
     CharBackend ctrl_chr;
     QIOChannel *data_ioc;
     TPMVersion tpm_version;
-    ptm_cap caps; /* capabilities of the TPM */
+    uint32_t caps; /* capabilities of the TPM */
     uint8_t cur_locty_number; /* last set locality */
     Error *migration_blocker;
 
@@ -239,13 +239,15 @@ static void tpm_emulator_handle_request(TPMBackend *tb, TPMBackendCmd *cmd,
 
 static int tpm_emulator_probe_caps(TPMEmulator *tpm_emu)
 {
+    ptm_cap_n cap_n;
+
     if (tpm_emulator_ctrlcmd(tpm_emu, CMD_GET_CAPABILITY,
-                             &tpm_emu->caps, 0, sizeof(tpm_emu->caps)) < 0) {
+                             &cap_n, 0, sizeof(cap_n)) < 0) {
         error_report("tpm-emulator: probing failed : %s", strerror(errno));
         return -1;
     }
 
-    tpm_emu->caps = be64_to_cpu(tpm_emu->caps);
+    tpm_emu->caps = be32_to_cpu(cap_n.u.resp.caps);
 
     trace_tpm_emulator_probe_caps(tpm_emu->caps);
 
@@ -254,7 +256,7 @@ static int tpm_emulator_probe_caps(TPMEmulator *tpm_emu)
 
 static int tpm_emulator_check_caps(TPMEmulator *tpm_emu)
 {
-    ptm_cap caps = 0;
+    uint32_t caps = 0;
     const char *tpm = NULL;
 
     /* check for min. required capabilities */
@@ -527,8 +529,8 @@ static size_t tpm_emulator_get_buffer_size(TPMBackend *tb)
 static int tpm_emulator_block_migration(TPMEmulator *tpm_emu)
 {
     Error *err = NULL;
-    ptm_cap caps = PTM_CAP_GET_STATEBLOB | PTM_CAP_SET_STATEBLOB |
-                   PTM_CAP_STOP;
+    uint32_t caps = PTM_CAP_GET_STATEBLOB | PTM_CAP_SET_STATEBLOB |
+                    PTM_CAP_STOP;
 
     if (!TPM_EMULATOR_IMPLEMENTS_ALL_CAPS(tpm_emu, caps)) {
         error_setg(&tpm_emu->migration_blocker,
diff --git a/backends/tpm/tpm_ioctl.h b/backends/tpm/tpm_ioctl.h
index 1933ab6855..ee2dd15d35 100644
--- a/backends/tpm/tpm_ioctl.h
+++ b/backends/tpm/tpm_ioctl.h
@@ -29,6 +29,16 @@
 
 typedef uint32_t ptm_res;
 
+/* PTM_GET_CAPABILITY: Get supported capabilities (ioctl's) */
+struct ptm_cap_n {
+    union {
+        struct {
+            ptm_res tpm_result; /* will always be TPM_SUCCESS (0) */
+            uint32_t caps;
+        } resp; /* response */
+    } u;
+};
+
 /* PTM_GET_TPMESTABLISHED: get the establishment bit */
 struct ptm_est {
     union {
@@ -242,7 +252,8 @@ struct ptm_lockstorage {
     } u;
 };
 
-typedef uint64_t ptm_cap;
+typedef uint64_t ptm_cap; /* CUSE-only; use ptm_cap_n otherwise */
+typedef struct ptm_cap_n ptm_cap_n;
 typedef struct ptm_est ptm_est;
 typedef struct ptm_reset_est ptm_reset_est;
 typedef struct ptm_loc ptm_loc;
diff --git a/backends/tpm/trace-events b/backends/tpm/trace-events
index cb5cfa6510..05e30533ce 100644
--- a/backends/tpm/trace-events
+++ b/backends/tpm/trace-events
@@ -16,7 +16,7 @@ tpm_util_show_buffer_content(const char *buf) "%s"
 # tpm_emulator.c
 tpm_emulator_set_locality(uint8_t locty) "setting locality to %d"
 tpm_emulator_handle_request(void) "processing TPM command"
-tpm_emulator_probe_caps(uint64_t caps) "capabilities: 0x%"PRIx64
+tpm_emulator_probe_caps(uint32_t caps) "capabilities: 0x%x"
 tpm_emulator_set_buffer_size(uint32_t buffersize, uint32_t minsize, uint32_t maxsize) "buffer size: %u, min: %u, max: %u"
 tpm_emulator_startup_tpm_resume(bool is_resume, size_t buffersize) "is_resume: %d, buffer size: %zu"
 tpm_emulator_get_tpm_established_flag(uint8_t flag) "got established flag: %d"
-- 
2.47.0


