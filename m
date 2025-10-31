Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFD3FCCFA02
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 19:47:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEv3y-0001Xl-MU; Fri, 31 Oct 2025 15:45:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1vEv3w-0001X9-EU
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 15:45:28 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1vEv3q-0002s4-NE
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 15:45:27 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59VASPc3026029
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 19:45:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=POt2zd
 YJ7pAdExy6KjBpWuIMGovP9XhKcuPEVaKXn6Y=; b=ilDcjAwLdlQUDFr0M6r1GN
 DR7KWp/l5174oQyvVGGKOm7DmiR519KogOJnyp660Ufn0Uh/fFYQWiPNdFhsU1+K
 RgH4aJVAgIA4RHM46gtw/MjT9Opc+5rqw0L2E94BcWZ9GKfmRMgk71nEY6imYJvu
 /RV4Tjj8hMYFqVa1X8RxMydn6+HF8SVPjOKODC+1uU9S870VvgmbYnXnN2+3334B
 sfeLcwvsZn136bQRdhpmF140Yv90euC5zQoHQzxVY/hw4VeGgzpG3WU4bzLX5kIY
 nd0K3cG8X0/PbapVd4UMFIy8fPHYIMTGh17aN/MbkJFswCjDFWE/K4ILQycv4uPQ
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a34aayas3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 19:45:13 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59VGKGYi018748
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 19:45:12 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4a33xwqwt7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 19:45:12 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59VJjB7h32899778
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 19:45:11 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 543F158056
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 19:45:11 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2FEA95803F
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 19:45:11 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 19:45:11 +0000 (GMT)
Message-ID: <800989e7-d889-492d-a814-f0a6c4979b7f@linux.ibm.com>
Date: Fri, 31 Oct 2025 15:45:10 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] tmp_emulator: improve and fix use of errp
To: qemu-devel@nongnu.org
References: <20251028130738.29037-1-vsementsov@yandex-team.ru>
 <20251028130738.29037-3-vsementsov@yandex-team.ru>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20251028130738.29037-3-vsementsov@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=ALkgKXG8 c=1 sm=1 tr=0 ts=690511c9 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=6R7veym_AAAA:8 a=9LEeJrRFzkvvDkBgsgkA:9 a=QEXdDO2ut3YA:10
 a=ILCOIF4F_8SzUMnO7jNM:22 a=poXaRoVlC6wW9_mwW8W4:22 a=pHzHmUro8NiASowvMSCR:22
 a=nt3jZW36AmriUCFCBwmW:22
X-Proofpoint-ORIG-GUID: xVmKbuypdZUkzA9Vt0IIyTs6DYHDaLs9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDE2NiBTYWx0ZWRfX4UW3+dA07B2J
 YUNfiBzzcdX1W5AGYPjy9yZHFfedVvAhZlm5+8EcdAaZXSTx+Wv2bDWoRzPhOEDNcxxWz8Bd2WP
 j8pQU7QNWHJx/6w9HFcX/8BcwJf3FzmZKNOnhgH+JsAg86fCXXTvWmmTxFkeqhY/DcMZZUVmLoj
 ER8bmLcJ+IfaTxfrp9UQzDlDjGNb+L2R5EtS8fvajI8YIWQl3wzUQq1pmDIt462Yx4FnSB0N3/j
 g3CZydkMkhZS16cWgNU4dgi9RzyWLB88NQzvrFN0GpNzWjSKtSgaGpTWIp/jnXPjRGBmD7FUMGl
 7hGKa38Ii+LYEbYvNQEvn23RcclgyaAW+YGnZjby/nZSyZnbj80X5yBoFw90r+5hQM8M05PZ9LI
 +0ph3nWYPuDMwalU6650ilZDSCypQg==
X-Proofpoint-GUID: xVmKbuypdZUkzA9Vt0IIyTs6DYHDaLs9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-31_06,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 impostorscore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2510280166
Received-SPF: pass client-ip=148.163.158.5; envelope-from=stefanb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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



On 10/28/25 9:07 AM, Vladimir Sementsov-Ogievskiy wrote:
> tpm_emulator_post_load() and tpm_emulator_set_state_blobs() has
> error paths, where they return negative value, but do not set
> errp.
> 
> To fix that, we also have to convert several other functions to
> set errp instead of error_reporting.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>   backends/tpm/tpm_emulator.c | 63 +++++++++++++++++++++++--------------
>   1 file changed, 39 insertions(+), 24 deletions(-)
> 
> diff --git a/backends/tpm/tpm_emulator.c b/backends/tpm/tpm_emulator.c
> index dacfca5ab7..6abe9872e6 100644
> --- a/backends/tpm/tpm_emulator.c
> +++ b/backends/tpm/tpm_emulator.c
> @@ -308,22 +308,22 @@ static int tpm_emulator_check_caps(TPMEmulator *tpm_emu)
>       return 0;
>   }
>   
> -static int tpm_emulator_stop_tpm(TPMBackend *tb)
> +static int tpm_emulator_stop_tpm(TPMBackend *tb, Error **errp)
>   {
>       TPMEmulator *tpm_emu = TPM_EMULATOR(tb);
>       ptm_res res;
>   
>       if (tpm_emulator_ctrlcmd(tpm_emu, CMD_STOP, &res, 0,
>                                sizeof(ptm_res), sizeof(res)) < 0) {
> -        error_report("tpm-emulator: Could not stop TPM: %s",
> -                     strerror(errno));
> +        error_setg(errp, "tpm-emulator: Could not stop TPM: %s",
> +                   strerror(errno));
>           return -1;
>       }
>   
>       res = be32_to_cpu(res);
>       if (res) {
> -        error_report("tpm-emulator: TPM result for CMD_STOP: 0x%x %s", res,
> -                     tpm_emulator_strerror(res));
> +        error_setg(errp, "tpm-emulator: TPM result for CMD_STOP: 0x%x %s", res,
> +                   tpm_emulator_strerror(res));
>           return -1;
>       }
>   
> @@ -362,12 +362,13 @@ static int tpm_emulator_lock_storage(TPMEmulator *tpm_emu)
>   
>   static int tpm_emulator_set_buffer_size(TPMBackend *tb,
>                                           size_t wanted_size,
> -                                        size_t *actual_size)
> +                                        size_t *actual_size,
> +                                        Error **errp)
>   {
>       TPMEmulator *tpm_emu = TPM_EMULATOR(tb);
>       ptm_setbuffersize psbs;
>   
> -    if (tpm_emulator_stop_tpm(tb) < 0) {
> +    if (tpm_emulator_stop_tpm(tb, errp) < 0) {
>           return -1;
>       }
>   
> @@ -376,16 +377,17 @@ static int tpm_emulator_set_buffer_size(TPMBackend *tb,
>       if (tpm_emulator_ctrlcmd(tpm_emu, CMD_SET_BUFFERSIZE, &psbs,
>                                sizeof(psbs.u.req), sizeof(psbs.u.resp.tpm_result),
>                                sizeof(psbs.u.resp)) < 0) {
> -        error_report("tpm-emulator: Could not set buffer size: %s",
> -                     strerror(errno));
> +        error_setg(errp, "tpm-emulator: Could not set buffer size: %s",
> +                   strerror(errno));
>           return -1;
>       }
>   
>       psbs.u.resp.tpm_result = be32_to_cpu(psbs.u.resp.tpm_result);
>       if (psbs.u.resp.tpm_result != 0) {
> -        error_report("tpm-emulator: TPM result for set buffer size : 0x%x %s",
> -                     psbs.u.resp.tpm_result,
> -                     tpm_emulator_strerror(psbs.u.resp.tpm_result));
> +        error_setg(errp,
> +                   "tpm-emulator: TPM result for set buffer size : 0x%x %s",
> +                   psbs.u.resp.tpm_result,
> +                   tpm_emulator_strerror(psbs.u.resp.tpm_result));
>           return -1;
>       }
>   
> @@ -402,7 +404,7 @@ static int tpm_emulator_set_buffer_size(TPMBackend *tb,
>   }
>   
>   static int tpm_emulator_startup_tpm_resume(TPMBackend *tb, size_t buffersize,
> -                                     bool is_resume)
> +                                           bool is_resume, Error **errp)
>   {
>       TPMEmulator *tpm_emu = TPM_EMULATOR(tb);
>       ptm_init init = {
> @@ -413,7 +415,7 @@ static int tpm_emulator_startup_tpm_resume(TPMBackend *tb, size_t buffersize,
>       trace_tpm_emulator_startup_tpm_resume(is_resume, buffersize);
>   
>       if (buffersize != 0 &&
> -        tpm_emulator_set_buffer_size(tb, buffersize, NULL) < 0) {
> +        tpm_emulator_set_buffer_size(tb, buffersize, NULL, errp) < 0) {
>           goto err_exit;
>       }
>   
> @@ -424,15 +426,15 @@ static int tpm_emulator_startup_tpm_resume(TPMBackend *tb, size_t buffersize,
>       if (tpm_emulator_ctrlcmd(tpm_emu, CMD_INIT, &init, sizeof(init),
>                                sizeof(init.u.resp.tpm_result),
>                                sizeof(init)) < 0) {
> -        error_report("tpm-emulator: could not send INIT: %s",
> -                     strerror(errno));
> +        error_setg(errp, "tpm-emulator: could not send INIT: %s",
> +                   strerror(errno));
>           goto err_exit;
>       }
>   
>       res = be32_to_cpu(init.u.resp.tpm_result);
>       if (res) {
> -        error_report("tpm-emulator: TPM result for CMD_INIT: 0x%x %s", res,
> -                     tpm_emulator_strerror(res));
> +        error_setg(errp, "tpm-emulator: TPM result for CMD_INIT: 0x%x %s", res,
> +                   tpm_emulator_strerror(res));
>           goto err_exit;
>       }
>       return 0;
> @@ -441,18 +443,31 @@ err_exit:
>       return -1;
>   }
>   
> -static int tpm_emulator_startup_tpm(TPMBackend *tb, size_t buffersize)
> +static int do_tpm_emulator_startup_tpm(TPMBackend *tb, size_t buffersize,
> +                                       Error **errp)
>   {
>       /* TPM startup will be done from post_load hook */
>       if (runstate_check(RUN_STATE_INMIGRATE)) {
>           if (buffersize != 0) {
> -            return tpm_emulator_set_buffer_size(tb, buffersize, NULL);
> +            return tpm_emulator_set_buffer_size(tb, buffersize, NULL, errp);
>           }
>   
>           return 0;
>       }
>   
> -    return tpm_emulator_startup_tpm_resume(tb, buffersize, false);
> +    return tpm_emulator_startup_tpm_resume(tb, buffersize, false, errp);
> +}
> +
> +static int tpm_emulator_startup_tpm(TPMBackend *tb, size_t buffersize)
> +{
> +    Error *local_err = NULL;
> +    int ret = do_tpm_emulator_startup_tpm(tb, buffersize, &local_err);
> +
> +    if (ret < 0) {
> +        error_report_err(local_err);
> +    }
> +
> +    return ret;
>   }
>   
>   static bool tpm_emulator_get_tpm_established_flag(TPMBackend *tb)
> @@ -546,7 +561,7 @@ static size_t tpm_emulator_get_buffer_size(TPMBackend *tb)
>   {
>       size_t actual_size;
>   
> -    if (tpm_emulator_set_buffer_size(tb, 0, &actual_size) < 0) {
> +    if (tpm_emulator_set_buffer_size(tb, 0, &actual_size, NULL) < 0) {

You would have to pass a &local_err here as well otherwise the error is 
ignored.

>           return 4096;
>       }
>   
> @@ -889,7 +904,7 @@ static int tpm_emulator_set_state_blobs(TPMBackend *tb, Error **errp)
>   
>       trace_tpm_emulator_set_state_blobs();
>   
> -    if (tpm_emulator_stop_tpm(tb) < 0) {
> +    if (tpm_emulator_stop_tpm(tb, errp) < 0) {
>           trace_tpm_emulator_set_state_blobs_error("Could not stop TPM");
>           return -EIO;
>       }
> @@ -960,7 +975,7 @@ static int tpm_emulator_post_load(void *opaque, int version_id, Error **errp)
>           return ret;
>       }
>   
> -    if (tpm_emulator_startup_tpm_resume(tb, 0, true) < 0) {
> +    if (tpm_emulator_startup_tpm_resume(tb, 0, true, errp) < 0) {
>           return -EIO;
>       }
>   

Thank you.

    Stefan

