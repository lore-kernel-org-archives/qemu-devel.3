Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4296CCF9E3
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Nov 2025 19:32:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vHSBi-0000md-Jz; Fri, 07 Nov 2025 14:31:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1vHSBf-0000kO-0B
 for qemu-devel@nongnu.org; Fri, 07 Nov 2025 14:31:56 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1vHSBc-0005XI-QA
 for qemu-devel@nongnu.org; Fri, 07 Nov 2025 14:31:54 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A7EsYwv030398;
 Fri, 7 Nov 2025 19:31:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=u1G8ZT
 TEastqAKGZLCC4k7UzGQyJ0MbNtcEP9fXj8kg=; b=LwXV3XtRMQhaFN0MdB5KVT
 /3wqm9PPvjaJDvYENZThM+VFc7WaG9AlzR/1EHtgmJpJEHpvwRZWsx+vLXYBF1/b
 Ux4eeVsuwIHxqL/s4WnNygpRNEEuNjlJ/9BAbiYv8Q3ct4dihthu8pWDE71gRzrF
 1A0wgJf9oe/81vdssBUvq7QMTrVspDa2ZvmCvZPKKIO1ojAsoJ8xS2tZgirAnQIh
 Fkkws1YfhIUfDTFPWIy1SEthZ4eN4prLIjPssKJ5Q0Jiqx1qP/DP42sOpRcra13T
 KRFYnh2tXfFjuO5iFI84/0pgbQ9m5U/yWrMIbAR+Z/LAZy8kN4Zqg2KiXqd/hKgw
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a9jxmsfwe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 07 Nov 2025 19:31:50 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5A7GSOsE012923;
 Fri, 7 Nov 2025 19:31:49 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4a5y82c84m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 07 Nov 2025 19:31:49 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5A7JVmHG5440032
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 7 Nov 2025 19:31:49 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B2D7858051;
 Fri,  7 Nov 2025 19:31:48 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5E3175805E;
 Fri,  7 Nov 2025 19:31:48 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  7 Nov 2025 19:31:48 +0000 (GMT)
Message-ID: <bd855481-a93a-4406-bd0d-a02896b93296@linux.ibm.com>
Date: Fri, 7 Nov 2025 14:31:48 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] tpm_emulator: drop direct use of errno variable
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 stefanb@linux.vnet.ibm.com
Cc: qemu-devel@nongnu.org, armbru@redhat.com, peterx@redhat.com
References: <20251106194126.569037-1-vsementsov@yandex-team.ru>
 <20251106194126.569037-3-vsementsov@yandex-team.ru>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20251106194126.569037-3-vsementsov@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=BZvVE7t2 c=1 sm=1 tr=0 ts=690e4926 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=6R7veym_AAAA:8 a=JrHu9dhyOHYeVUA1F3MA:9 a=QEXdDO2ut3YA:10
 a=ILCOIF4F_8SzUMnO7jNM:22 a=poXaRoVlC6wW9_mwW8W4:22 a=pHzHmUro8NiASowvMSCR:22
 a=nt3jZW36AmriUCFCBwmW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA3MDEyMiBTYWx0ZWRfXx1SpKCAx8Epb
 rdUy5Fmxob1P7HXDvDjoVZ/baI0pGh1/B6nJhqbOGoP/NVySYHnH+goN7dViMnBja7ZfjzAGbqQ
 MQVJ3Yj5PdwHxs9Ua1Zb7rszu+DkoUrAtU7GSWg+JXjrdgdNT8V4EoY+IT/wOpNfAbS+lTX266N
 3pl4bM2pMdfPzrh3d9MSpkBL1Uf50clQAggtMsOHNAFPQlacE0epSkkHlw5jBXeIy2KMb4Hcs1m
 9aY8dhYlg/aeglt7rSp1Tlyq7Wspme9+WC12jfFdNkmgo8xxDpXAwKOWuCA2zFYdT/qCJVrCF/V
 x7Gd5b63JyjbDCR+kOLWV2gVvgW4EtoaxlvhxW+omwono764Ui+U1G2hUSr4T168iSyItbnad15
 8S3R1eU7QCRdLjTvxe/tUm818Cwlqg==
X-Proofpoint-GUID: pXNoAXoZ-o8an7Wp6g6pGJHSXwRVhTRk
X-Proofpoint-ORIG-GUID: pXNoAXoZ-o8an7Wp6g6pGJHSXwRVhTRk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-07_05,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 phishscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511070122
Received-SPF: pass client-ip=148.163.156.1; envelope-from=stefanb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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



On 11/6/25 2:41 PM, Vladimir Sementsov-Ogievskiy wrote:
> The code tends to include errno into error messages after
> tpm_util_test_tpmdev() and tpm_emulator_ctrlcmd() calls.
> 
> Both has error paths, where errno is not set, examples:

Both have ...>
> tpm_emulator_ctrlcmd()
>    qemu_chr_fe_write_all()
>      qemu_chr_write()
>        replay_char_write_event_load()
>          ...
>          *res = replay_get_dword();
>          ...
> 
> tpm_util_test_tpmdev()
>    tpm_util_test()
>      tpm_util_request()
>        ...
>        if (n != requestlen) {
>            return -EFAULT;
>        }
>        ...
> 
> Both doesn't document that they set errno.

Both do not ...

> 
> Let's drop these explicit usage of errno. If we need this information,
> it should be added to errp deeper in the stack.

It's not clear to me why this is an actual problem. Is it better to now 
not set this error message?

> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>   backends/tpm/tpm_emulator.c | 44 ++++++++++++++-----------------------
>   1 file changed, 16 insertions(+), 28 deletions(-)
> 
> diff --git a/backends/tpm/tpm_emulator.c b/backends/tpm/tpm_emulator.c
> index 24aa18302e..79f3e6b1f2 100644
> --- a/backends/tpm/tpm_emulator.c
> +++ b/backends/tpm/tpm_emulator.c
> @@ -225,8 +225,7 @@ static int tpm_emulator_set_locality(TPMEmulator *tpm_emu, uint8_t locty_number,
>       if (tpm_emulator_ctrlcmd(tpm_emu, CMD_SET_LOCALITY, &loc,
>                                sizeof(loc), sizeof(loc.u.resp.tpm_result),
>                                sizeof(loc)) < 0) {
> -        error_setg(errp, "tpm-emulator: could not set locality : %s",
> -                   strerror(errno));
> +        error_setg(errp, "tpm-emulator: could not set locality");
>           return -1;
>       }
> 
> @@ -264,7 +263,7 @@ static int tpm_emulator_probe_caps(TPMEmulator *tpm_emu)
>       if (tpm_emulator_ctrlcmd(tpm_emu, CMD_GET_CAPABILITY, &cap_n, 0,
>                                sizeof(cap_n.u.resp.tpm_result),
>                                sizeof(cap_n)) < 0) {
> -        error_report("tpm-emulator: probing failed : %s", strerror(errno));
> +        error_report("tpm-emulator: probing failed");
>           return -1;
>       }
> 
> @@ -315,8 +314,7 @@ static int tpm_emulator_stop_tpm(TPMBackend *tb, Error **errp)
> 
>       if (tpm_emulator_ctrlcmd(tpm_emu, CMD_STOP, &res, 0,
>                                sizeof(ptm_res), sizeof(res)) < 0) {
> -        error_setg(errp, "tpm-emulator: Could not stop TPM: %s",
> -                   strerror(errno));
> +        error_setg(errp, "tpm-emulator: Could not stop TPM");
>           return -1;
>       }
> 
> @@ -344,8 +342,7 @@ static int tpm_emulator_lock_storage(TPMEmulator *tpm_emu)
>       if (tpm_emulator_ctrlcmd(tpm_emu, CMD_LOCK_STORAGE, &pls, sizeof(pls.u.req),
>                                sizeof(pls.u.resp.tpm_result),
>                                sizeof(pls.u.resp)) < 0) {
> -        error_report("tpm-emulator: Could not lock storage within 3 seconds: "
> -                     "%s", strerror(errno));
> +        error_report("tpm-emulator: Could not lock storage within 3 seconds");
>           return -1;
>       }
> 
> @@ -377,8 +374,7 @@ static int tpm_emulator_set_buffer_size(TPMBackend *tb,
>       if (tpm_emulator_ctrlcmd(tpm_emu, CMD_SET_BUFFERSIZE, &psbs,
>                                sizeof(psbs.u.req), sizeof(psbs.u.resp.tpm_result),
>                                sizeof(psbs.u.resp)) < 0) {
> -        error_setg(errp, "tpm-emulator: Could not set buffer size: %s",
> -                   strerror(errno));
> +        error_setg(errp, "tpm-emulator: Could not set buffer size");
>           return -1;
>       }
> 
> @@ -426,8 +422,7 @@ static int tpm_emulator_startup_tpm_resume(TPMBackend *tb, size_t buffersize,
>       if (tpm_emulator_ctrlcmd(tpm_emu, CMD_INIT, &init, sizeof(init),
>                                sizeof(init.u.resp.tpm_result),
>                                sizeof(init)) < 0) {
> -        error_setg(errp, "tpm-emulator: could not send INIT: %s",
> -                   strerror(errno));
> +        error_setg(errp, "tpm-emulator: could not send INIT");
>           goto err_exit;
>       }
> 
> @@ -482,8 +477,7 @@ static bool tpm_emulator_get_tpm_established_flag(TPMBackend *tb)
>       if (tpm_emulator_ctrlcmd(tpm_emu, CMD_GET_TPMESTABLISHED, &est, 0,
>                                sizeof(est) /* always returns resp.bit */,
>                                sizeof(est)) < 0) {
> -        error_report("tpm-emulator: Could not get the TPM established flag: %s",
> -                     strerror(errno));
> +        error_report("tpm-emulator: Could not get the TPM established flag");
>           return false;
>       }
>       trace_tpm_emulator_get_tpm_established_flag(est.u.resp.bit);
> @@ -511,8 +505,7 @@ static int tpm_emulator_reset_tpm_established_flag(TPMBackend *tb,
>                                &reset_est, sizeof(reset_est),
>                                sizeof(reset_est.u.resp.tpm_result),
>                                sizeof(reset_est)) < 0) {
> -        error_report("tpm-emulator: Could not reset the establishment bit: %s",
> -                     strerror(errno));
> +        error_report("tpm-emulator: Could not reset the establishment bit");
>           return -1;
>       }
> 
> @@ -542,8 +535,7 @@ static void tpm_emulator_cancel_cmd(TPMBackend *tb)
>       /* FIXME: make the function non-blocking, or it may block a VCPU */
>       if (tpm_emulator_ctrlcmd(tpm_emu, CMD_CANCEL_TPM_CMD, &res, 0,
>                                sizeof(ptm_res), sizeof(res)) < 0) {
> -        error_report("tpm-emulator: Could not cancel command: %s",
> -                     strerror(errno));
> +        error_report("tpm-emulator: Could not cancel command: %s");
>       } else if (res != 0) {
>           error_report("tpm-emulator: Failed to cancel TPM: 0x%x",
>                        be32_to_cpu(res));
> @@ -604,8 +596,7 @@ static int tpm_emulator_prepare_data_fd(TPMEmulator *tpm_emu)
> 
>       if (tpm_emulator_ctrlcmd(tpm_emu, CMD_SET_DATAFD, &res, 0,
>                                sizeof(ptm_res), sizeof(res)) < 0 || res != 0) {
> -        error_report("tpm-emulator: Failed to send CMD_SET_DATAFD: %s",
> -                     strerror(errno));
> +        error_report("tpm-emulator: Failed to send CMD_SET_DATAFD");
>           goto err_exit;
>       }
> 
> @@ -662,8 +653,8 @@ static int tpm_emulator_handle_device_opts(TPMEmulator *tpm_emu, QemuOpts *opts)
>        */
>       if (tpm_util_test_tpmdev(QIO_CHANNEL_SOCKET(tpm_emu->data_ioc)->fd,
>                                &tpm_emu->tpm_version)) {
> -        error_report("'%s' is not emulating TPM device. Error: %s",
> -                      tpm_emu->options->chardev, strerror(errno));
> +        error_report("'%s' is not emulating TPM device.",
> +                      tpm_emu->options->chardev);
>           goto err;
>       }
> 
> @@ -753,8 +744,7 @@ static int tpm_emulator_get_state_blob(TPMEmulator *tpm_emu,
>                                /* always returns up to resp.data */
>                                offsetof(ptm_getstate, u.resp.data),
>                                offsetof(ptm_getstate, u.resp.data)) < 0) {
> -        error_report("tpm-emulator: could not get state blob type %d : %s",
> -                     type, strerror(errno));
> +        error_report("tpm-emulator: could not get state blob type %d", type);
>           return -1;
>       }
> 
> @@ -856,9 +846,8 @@ static int tpm_emulator_set_state_blob(TPMEmulator *tpm_emu,
>       /* write the header only */
>       if (tpm_emulator_ctrlcmd(tpm_emu, CMD_SET_STATEBLOB, &pss,
>                                offsetof(ptm_setstate, u.req.data), 0, 0) < 0) {
> -        error_setg_errno(errp, errno,
> -                         "tpm-emulator: could not set state blob type %d",
> -                         type);
> +        error_setg(errp, "tpm-emulator: could not set state blob type %d",
> +                   type);
>           return -1;
>       }
> 
> @@ -1040,8 +1029,7 @@ static void tpm_emulator_shutdown(TPMEmulator *tpm_emu)
> 
>       if (tpm_emulator_ctrlcmd(tpm_emu, CMD_SHUTDOWN, &res, 0,
>                                sizeof(ptm_res), sizeof(res)) < 0) {
> -        error_report("tpm-emulator: Could not cleanly shutdown the TPM: %s",
> -                     strerror(errno));
> +        error_report("tpm-emulator: Could not cleanly shutdown the TPM");
>       } else if (res != 0) {
>           error_report("tpm-emulator: TPM result for shutdown: 0x%x %s",
>                        be32_to_cpu(res), tpm_emulator_strerror(be32_to_cpu(res)));


