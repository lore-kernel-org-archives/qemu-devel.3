Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02B19CCF9E3
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Nov 2025 19:35:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vHSEz-0001V7-Nk; Fri, 07 Nov 2025 14:35:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1vHSEx-0001Uh-Ks
 for qemu-devel@nongnu.org; Fri, 07 Nov 2025 14:35:19 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1vHSEw-0007CS-4l
 for qemu-devel@nongnu.org; Fri, 07 Nov 2025 14:35:19 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A7FMshH018784;
 Fri, 7 Nov 2025 19:35:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=hByAF8
 WQk94ZQTCSrNVCj/npyBdH2ADsabgSQSrhmeY=; b=HsLmQCL3I8/I/Zzerr4pre
 rAbrqI0pkQKinL5FfjFbp0Tjmzt+NMhVDVJ21pqm7Pwzv6GZwsB9sazYdHxlcRtK
 dHtfa5mVAFKLI3qWcgN3OMsHaSixmb4WGBrqfhzWJzTC9/1HmaK9NHyTH/x207km
 JL0dHSbzkkR5WOVoyleAsHgAROk+Hq6MXVwjg1KqdN3emsF2J3cXyuGvR0+ivqNe
 fQojPvHz87Hl7d0FxZDKNemf5LMK8JeeaS/Dk7k9eB2iw4yo115W7TMAvJfG/WiH
 cSDkM+WxyJfbc9IlOmW77LnfvnGwy6Ae6f8NvxuWoECM8zk2JFforOlXpAX9dOtw
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a57mrnja2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 07 Nov 2025 19:35:16 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5A7HvaZX027375;
 Fri, 7 Nov 2025 19:35:16 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4a5vwyvphq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 07 Nov 2025 19:35:16 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5A7JZFr726149450
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 7 Nov 2025 19:35:16 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9F0C25805E;
 Fri,  7 Nov 2025 19:35:15 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 49A7C5805F;
 Fri,  7 Nov 2025 19:35:15 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  7 Nov 2025 19:35:15 +0000 (GMT)
Message-ID: <b4c55d4c-cd96-4a10-994c-65c7dac61dd2@linux.ibm.com>
Date: Fri, 7 Nov 2025 14:35:14 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] tpm_emulator: tpm_emulator_set_state_blobs(): move to
 boolean return
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 stefanb@linux.vnet.ibm.com
Cc: qemu-devel@nongnu.org, armbru@redhat.com, peterx@redhat.com
References: <20251106194126.569037-1-vsementsov@yandex-team.ru>
 <20251106194126.569037-4-vsementsov@yandex-team.ru>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20251106194126.569037-4-vsementsov@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: MDuJ0QaOPeMWBbax3kK3iVHP3hqr8ogf
X-Authority-Analysis: v=2.4 cv=MKhtWcZl c=1 sm=1 tr=0 ts=690e49f5 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=6R7veym_AAAA:8 a=VnNF1IyMAAAA:8 a=r9GxYZjsfqJT_D8YL9kA:9 a=QEXdDO2ut3YA:10
 a=ILCOIF4F_8SzUMnO7jNM:22 a=poXaRoVlC6wW9_mwW8W4:22 a=pHzHmUro8NiASowvMSCR:22
 a=nt3jZW36AmriUCFCBwmW:22
X-Proofpoint-ORIG-GUID: MDuJ0QaOPeMWBbax3kK3iVHP3hqr8ogf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAxMDAwMSBTYWx0ZWRfXyXzdwxkwZrL3
 fqsFwGqYgfWIhbj2ZHMVHvIzjY4sNAkzN2ngHzsuOi1tIEXPdtdXb+r9YqAUbx4kyt+h3+xA3Iz
 tMNEfKL9qq3AEVvRxAedlZd+BoBRLIj+ml+kGsqJQ8VNm+ngP0V1qFeWxlopAFRxQ/+jLaXy3S6
 /FIIBv3I6pVFNiry4zi56G1W5QI28A0/TUW1sDFq0qOTTBXQjFo1vJ9iEmpBiwa6CZLlD8HzZH+
 NvVNzbunzXFkELbZ3WPwkrNnflIWD7l+pmRGvf9Qaz1JtGTU7ind/0dUs7FyB+tRPsO+Fr8OcHL
 H+wqp8x9HtesTHhTy8fFD6Gje3KvzfvtAvIZ7zvdPEonwGQuTnnJy34tUgav7mz9srRLomORDAt
 N6nzjf4Wytii893gX55XPEKNcp2tMw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-07_05,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 bulkscore=0 impostorscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 adultscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511010001
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



On 11/6/25 2:41 PM, Vladimir Sementsov-Ogievskiy wrote:
> The returned error is only used to check for success, so no reason
> to use specific errno values.
> 
> Also, this is the only function with -errno contract in the file,
> so converting it simplifies the whole file from three types of
> contract (0/-1, 0/-errno, true/false) to only two (0/-1, true/false).
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>   backends/tpm/tpm_emulator.c | 13 +++++--------
>   1 file changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/backends/tpm/tpm_emulator.c b/backends/tpm/tpm_emulator.c
> index 79f3e6b1f2..3c62bfa3ed 100644
> --- a/backends/tpm/tpm_emulator.c
> +++ b/backends/tpm/tpm_emulator.c
> @@ -885,10 +885,8 @@ static int tpm_emulator_set_state_blob(TPMEmulator *tpm_emu,
>   
>   /*
>    * Set all the TPM state blobs.
> - *
> - * Returns a negative errno code in case of error.
>    */
> -static int tpm_emulator_set_state_blobs(TPMBackend *tb, Error **errp)
> +static bool tpm_emulator_set_state_blobs(TPMBackend *tb, Error **errp)
>   {
>       TPMEmulator *tpm_emu = TPM_EMULATOR(tb);
>       TPMBlobBuffers *state_blobs = &tpm_emu->state_blobs;
> @@ -897,7 +895,7 @@ static int tpm_emulator_set_state_blobs(TPMBackend *tb, Error **errp)
>   
>       if (tpm_emulator_stop_tpm(tb, errp) < 0) {
>           trace_tpm_emulator_set_state_blobs_error("Could not stop TPM");
> -        return -EIO;
> +        return false;
>       }
>   
>       if (tpm_emulator_set_state_blob(tpm_emu, PTM_BLOB_TYPE_PERMANENT,
> @@ -909,12 +907,12 @@ static int tpm_emulator_set_state_blobs(TPMBackend *tb, Error **errp)
>           tpm_emulator_set_state_blob(tpm_emu, PTM_BLOB_TYPE_SAVESTATE,
>                                       &state_blobs->savestate,
>                                       state_blobs->savestate_flags, errp) < 0) {
> -        return -EIO;
> +        return false;
>       }
>   
>       trace_tpm_emulator_set_state_blobs_done();
>   
> -    return 0;
> +    return true;
>   }
>   
>   static int tpm_emulator_pre_save(void *opaque)
> @@ -959,8 +957,7 @@ static bool tpm_emulator_post_load(void *opaque, int version_id, Error **errp)
>       TPMBackend *tb = opaque;
>       int ret;
>   
> -    ret = tpm_emulator_set_state_blobs(tb, errp);
> -    if (ret < 0) {
> +    if (!tpm_emulator_set_state_blobs(tb, errp)) {
>           return false;
>       }
>   

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>


