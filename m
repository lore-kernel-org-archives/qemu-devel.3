Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08A45EA813C
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 15:53:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpq2v-0001aO-5B; Tue, 10 Feb 2026 10:53:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1vpq2n-0001X5-1Z
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 10:52:53 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1vpq2Z-0003hG-Pa
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 10:52:51 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61A3jb4p3537614; Tue, 10 Feb 2026 15:48:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=7jzwZyY+Z/N8QC5x4
 wP77+MLsBzTXVWktB+4y3hSvYw=; b=eHvw7rUcMaq2CPkoccr87aYOzCWzJHMSr
 UQ3olxThERfE1I0+DnkvYgZHlMTNs0RjXwFWqWROTsxwFgiSHwnViXmc6Bd+kioz
 KB8Ws7QxQkKIK+C+2AD7l7x1tAEwCViqk38GzYNzCPIrBX82P9tnOEPsUnCNBoBP
 5prTv7AdOyI3EsMtB+3w8qM2wPjMmDJPaLbmiORz1gQ1qrffAPHHai+kRo7z2/Ep
 MmjfD+mmcjzqmK81+mrhOWTXj1TYIg/2/rkLF1jHbeC5XXv5H/XXBHTDgvv0VCwt
 2w3QiCJQvsbBX5FcIFALJ/tvmi54SJdUw2UHK1+4/a6hFiztJLmeQ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c696v2sa8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Feb 2026 15:48:05 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61AE1qZY008400;
 Tue, 10 Feb 2026 15:48:05 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4c6g3ya0u8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Feb 2026 15:48:05 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 61AFm5d35899238
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Feb 2026 15:48:05 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DF47C5805A;
 Tue, 10 Feb 2026 15:48:04 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5693E58054;
 Tue, 10 Feb 2026 15:48:04 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 10 Feb 2026 15:48:04 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Stefan Berger <stefanb@linux.ibm.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PULL v1 2/3] tpm_emulator: drop direct use of errno variable
Date: Tue, 10 Feb 2026 10:48:00 -0500
Message-ID: <20260210154801.1662032-3-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260210154801.1662032-1-stefanb@linux.ibm.com>
References: <20260210154801.1662032-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: AHS-8QehAnS2CozD7nU6TJzF8q7utOgX
X-Proofpoint-ORIG-GUID: AHS-8QehAnS2CozD7nU6TJzF8q7utOgX
X-Authority-Analysis: v=2.4 cv=JdWxbEKV c=1 sm=1 tr=0 ts=698b5335 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=6R7veym_AAAA:8 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8
 a=ek3WFFHKF6qGx2XKqDkA:9 a=ILCOIF4F_8SzUMnO7jNM:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEwMDEzMiBTYWx0ZWRfX+8fmvESlH3sr
 XPa9lTRAhEDmHaIIQm/ck3kDoZI0FHuAuvqRnu7n6O29m1q82ZWqqnAMdqwA7TBGqyg2ao0wuSq
 BlTYkFY/UVtKUTfZEuODxG1CtoLf7bfOxP9W2V8sVlTCQjQpId0OWg4U16Blv4grvhfmNglqTbV
 AzXUfirVHcsVVrtG5BW7qTn5qMhyQSFX0lRuz5GmUol7uNzFNF45StvaS4laZpYjJGjARaa+rVe
 O9bfXaJnvrNwz1XZHoljLW5ssEEYa2K6I8TLz5VVQSLMhnkLZbdF61Z83tOND2sZ96XQ/E+xL8v
 mastu0XHLJelt7nhtMIHsUKvvlorWMw8CCqAGRiSrK3y3ga/vFsBpGQY1LxNAtpagRX83DAoSqX
 Ak9jPVFJGBWanJitC8zaS3A6az9eRLsasZCdBknxjjrujeB/ffOmf5zfuLqzmqEI2acr3t7yPw+
 CXsbatRu8AVCTVVb5SQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-10_01,2026-02-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 impostorscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602100132
Received-SPF: pass client-ip=148.163.158.5; envelope-from=stefanb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

The code tends to include errno into error messages after
tpm_util_test_tpmdev() and tpm_emulator_ctrlcmd() calls.

Both has error paths, where errno is not set, examples:

tpm_emulator_ctrlcmd()
  qemu_chr_fe_write_all()
    qemu_chr_write()
      replay_char_write_event_load()
        ...
        *res = replay_get_dword();
        ...

tpm_util_test_tpmdev()
  tpm_util_test()
    tpm_util_request()
      ...
      if (n != requestlen) {
          return -EFAULT;
      }
      ...

Both doesn't document that they set errno.

Let's drop these explicit usage of errno. If we need this information,
it should be added to errp deeper in the stack.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 backends/tpm/tpm_emulator.c | 41 +++++++++++++++----------------------
 1 file changed, 16 insertions(+), 25 deletions(-)

diff --git a/backends/tpm/tpm_emulator.c b/backends/tpm/tpm_emulator.c
index 6d8529da3b..dc84380b13 100644
--- a/backends/tpm/tpm_emulator.c
+++ b/backends/tpm/tpm_emulator.c
@@ -225,7 +225,7 @@ static int tpm_emulator_set_locality(TPMEmulator *tpm_emu, uint8_t locty_number,
     if (tpm_emulator_ctrlcmd(tpm_emu, CMD_SET_LOCALITY, &loc,
                              sizeof(loc), sizeof(loc.u.resp.tpm_result),
                              sizeof(loc)) < 0) {
-        error_setg_errno(errp, errno, "tpm-emulator: could not set locality");
+        error_setg(errp, "tpm-emulator: could not set locality");
         return -1;
     }
 
@@ -263,7 +263,7 @@ static int tpm_emulator_probe_caps(TPMEmulator *tpm_emu)
     if (tpm_emulator_ctrlcmd(tpm_emu, CMD_GET_CAPABILITY, &cap_n, 0,
                              sizeof(cap_n.u.resp.tpm_result),
                              sizeof(cap_n)) < 0) {
-        error_report("tpm-emulator: probing failed : %s", strerror(errno));
+        error_report("tpm-emulator: probing failed");
         return -1;
     }
 
@@ -314,7 +314,7 @@ static int tpm_emulator_stop_tpm(TPMBackend *tb, Error **errp)
 
     if (tpm_emulator_ctrlcmd(tpm_emu, CMD_STOP, &res, 0,
                              sizeof(ptm_res), sizeof(res)) < 0) {
-        error_setg_errno(errp, errno, "tpm-emulator: Could not stop TPM");
+        error_setg(errp, "tpm-emulator: Could not stop TPM");
         return -1;
     }
 
@@ -342,8 +342,7 @@ static int tpm_emulator_lock_storage(TPMEmulator *tpm_emu)
     if (tpm_emulator_ctrlcmd(tpm_emu, CMD_LOCK_STORAGE, &pls, sizeof(pls.u.req),
                              sizeof(pls.u.resp.tpm_result),
                              sizeof(pls.u.resp)) < 0) {
-        error_report("tpm-emulator: Could not lock storage within 3 seconds: "
-                     "%s", strerror(errno));
+        error_report("tpm-emulator: Could not lock storage within 3 seconds");
         return -1;
     }
 
@@ -375,8 +374,7 @@ static int tpm_emulator_set_buffer_size(TPMBackend *tb,
     if (tpm_emulator_ctrlcmd(tpm_emu, CMD_SET_BUFFERSIZE, &psbs,
                              sizeof(psbs.u.req), sizeof(psbs.u.resp.tpm_result),
                              sizeof(psbs.u.resp)) < 0) {
-        error_setg_errno(errp, errno,
-                         "tpm-emulator: Could not set buffer size");
+        error_setg(errp, "tpm-emulator: Could not set buffer size");
         return -1;
     }
 
@@ -424,7 +422,7 @@ static int tpm_emulator_startup_tpm_resume(TPMBackend *tb, size_t buffersize,
     if (tpm_emulator_ctrlcmd(tpm_emu, CMD_INIT, &init, sizeof(init),
                              sizeof(init.u.resp.tpm_result),
                              sizeof(init)) < 0) {
-        error_setg_errno(errp, errno, "tpm-emulator: could not send INIT");
+        error_setg(errp, "tpm-emulator: could not send INIT");
         goto err_exit;
     }
 
@@ -479,8 +477,7 @@ static bool tpm_emulator_get_tpm_established_flag(TPMBackend *tb)
     if (tpm_emulator_ctrlcmd(tpm_emu, CMD_GET_TPMESTABLISHED, &est, 0,
                              sizeof(est) /* always returns resp.bit */,
                              sizeof(est)) < 0) {
-        error_report("tpm-emulator: Could not get the TPM established flag: %s",
-                     strerror(errno));
+        error_report("tpm-emulator: Could not get the TPM established flag");
         return false;
     }
     trace_tpm_emulator_get_tpm_established_flag(est.u.resp.bit);
@@ -508,8 +505,7 @@ static int tpm_emulator_reset_tpm_established_flag(TPMBackend *tb,
                              &reset_est, sizeof(reset_est),
                              sizeof(reset_est.u.resp.tpm_result),
                              sizeof(reset_est)) < 0) {
-        error_report("tpm-emulator: Could not reset the establishment bit: %s",
-                     strerror(errno));
+        error_report("tpm-emulator: Could not reset the establishment bit");
         return -1;
     }
 
@@ -539,8 +535,7 @@ static void tpm_emulator_cancel_cmd(TPMBackend *tb)
     /* FIXME: make the function non-blocking, or it may block a VCPU */
     if (tpm_emulator_ctrlcmd(tpm_emu, CMD_CANCEL_TPM_CMD, &res, 0,
                              sizeof(ptm_res), sizeof(res)) < 0) {
-        error_report("tpm-emulator: Could not cancel command: %s",
-                     strerror(errno));
+        error_report("tpm-emulator: Could not cancel command");
     } else if (res != 0) {
         error_report("tpm-emulator: Failed to cancel TPM: 0x%x",
                      be32_to_cpu(res));
@@ -601,8 +596,7 @@ static int tpm_emulator_prepare_data_fd(TPMEmulator *tpm_emu)
 
     if (tpm_emulator_ctrlcmd(tpm_emu, CMD_SET_DATAFD, &res, 0,
                              sizeof(ptm_res), sizeof(res)) < 0 || res != 0) {
-        error_report("tpm-emulator: Failed to send CMD_SET_DATAFD: %s",
-                     strerror(errno));
+        error_report("tpm-emulator: Failed to send CMD_SET_DATAFD");
         goto err_exit;
     }
 
@@ -659,8 +653,8 @@ static int tpm_emulator_handle_device_opts(TPMEmulator *tpm_emu, QemuOpts *opts)
      */
     if (tpm_util_test_tpmdev(QIO_CHANNEL_SOCKET(tpm_emu->data_ioc)->fd,
                              &tpm_emu->tpm_version)) {
-        error_report("'%s' is not emulating TPM device. Error: %s",
-                      tpm_emu->options->chardev, strerror(errno));
+        error_report("'%s' is not emulating TPM device.",
+                      tpm_emu->options->chardev);
         goto err;
     }
 
@@ -750,8 +744,7 @@ static int tpm_emulator_get_state_blob(TPMEmulator *tpm_emu,
                              /* always returns up to resp.data */
                              offsetof(ptm_getstate, u.resp.data),
                              offsetof(ptm_getstate, u.resp.data)) < 0) {
-        error_report("tpm-emulator: could not get state blob type %d : %s",
-                     type, strerror(errno));
+        error_report("tpm-emulator: could not get state blob type %d", type);
         return -1;
     }
 
@@ -853,9 +846,8 @@ static int tpm_emulator_set_state_blob(TPMEmulator *tpm_emu,
     /* write the header only */
     if (tpm_emulator_ctrlcmd(tpm_emu, CMD_SET_STATEBLOB, &pss,
                              offsetof(ptm_setstate, u.req.data), 0, 0) < 0) {
-        error_setg_errno(errp, errno,
-                         "tpm-emulator: could not set state blob type %d",
-                         type);
+        error_setg(errp, "tpm-emulator: could not set state blob type %d",
+                   type);
         return -1;
     }
 
@@ -1037,8 +1029,7 @@ static void tpm_emulator_shutdown(TPMEmulator *tpm_emu)
 
     if (tpm_emulator_ctrlcmd(tpm_emu, CMD_SHUTDOWN, &res, 0,
                              sizeof(ptm_res), sizeof(res)) < 0) {
-        error_report("tpm-emulator: Could not cleanly shutdown the TPM: %s",
-                     strerror(errno));
+        error_report("tpm-emulator: Could not cleanly shutdown the TPM");
     } else if (res != 0) {
         error_report("tpm-emulator: TPM result for shutdown: 0x%x %s",
                      be32_to_cpu(res), tpm_emulator_strerror(be32_to_cpu(res)));
-- 
2.52.0


