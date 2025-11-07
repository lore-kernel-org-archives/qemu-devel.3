Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95A21CCF9E3
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Nov 2025 19:28:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vHS7w-00082W-Ck; Fri, 07 Nov 2025 14:28:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1vHS7u-00082J-CF
 for qemu-devel@nongnu.org; Fri, 07 Nov 2025 14:28:02 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1vHS7s-0004WQ-CP
 for qemu-devel@nongnu.org; Fri, 07 Nov 2025 14:28:02 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A7HWbRV032159;
 Fri, 7 Nov 2025 19:27:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=giV2zc
 iYLhnDQ9Fvo3R6ifNrOm2uVyM3n3T/MlAtMbM=; b=qkEb/9Lgd6Mlo6mNIIJFVR
 AWk8jCK604ZNOs6fUkNJWiN2F1h0c5XeCwzMdbFmazfqEHMGPlWW37IuY+odklQn
 xWIAOXPqm0B0DRIG2bV58UbHOZa/rqnINU0bplrjqOjPl0W3RdPqCd6JRHNR2S+H
 2S++Rg9ZUk2IHCWL2vvH/uZDPsQI0VesXHhVCuzmYwB98UO77ac1cp3q9AjXbXyR
 3rgw8wS9pI2cJkbyOMRZB2q+POAURReBwgBRJ6hwBn5JxsLZ4Xzv0dGjuK3N3lLF
 xORT5TiK6KZTKcH/A/5pY/CL5WAzXXfTOttkEEMurlb4k96MFM0ZweNAIth7NKbw
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a59vuxx71-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 07 Nov 2025 19:27:56 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5A7IVl2A018784;
 Fri, 7 Nov 2025 19:27:55 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4a5whnvftc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 07 Nov 2025 19:27:55 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5A7JRsH832899684
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 7 Nov 2025 19:27:55 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C4D785805A;
 Fri,  7 Nov 2025 19:27:54 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7439258051;
 Fri,  7 Nov 2025 19:27:54 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  7 Nov 2025 19:27:54 +0000 (GMT)
Message-ID: <b3b6fda3-2910-4a66-96c0-fe7c3ac52202@linux.ibm.com>
Date: Fri, 7 Nov 2025 14:27:54 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] tpm_emulator: print error on error-ignore path
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 stefanb@linux.vnet.ibm.com
Cc: qemu-devel@nongnu.org, armbru@redhat.com, peterx@redhat.com
References: <20251106194126.569037-1-vsementsov@yandex-team.ru>
 <20251106194126.569037-2-vsementsov@yandex-team.ru>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20251106194126.569037-2-vsementsov@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: -tONcedYmOsORB6KSjTV3Mpl1pWzMVhn
X-Proofpoint-GUID: -tONcedYmOsORB6KSjTV3Mpl1pWzMVhn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAxMDAyMSBTYWx0ZWRfX0pk27T2IVEDx
 BD5Nmh0xMGysJ3x+9GWf/gtP2OTckJhjuY+XIXhVaSDf59rGnkMxloioJCQWGtk8Bp0icJC1yuk
 QC6UAqBR+jrAmlheHn1vEbXIbWNk3SO1ytYmE4Nl1NPtrIoUN6z2uO8rQh/B4y1x+4sLJZcqf8n
 sPGyP38inFxVe9emhAg66p/H0SHyvK0uxHLRR+VJTGqo2Ijf0IMdXSciF3quiEQuD1rJLpyY6wf
 W4IHcN51tJRBwVeUfMP1qUrAASdClt7FcQyn85LAfjGaBv5BlfTjcNqRxeBGnrixXlqi7KPT/fh
 rCMvMOfbd/3lCQ50u1ATSwOBlWEhs8vobjVbJ28iPJCPIM9k8O3O+dQR4GiZgFRoNCyG3sFGxza
 aKWQH+pK9fWadKDR75JIOVN7xhE7Dg==
X-Authority-Analysis: v=2.4 cv=U6qfzOru c=1 sm=1 tr=0 ts=690e483c cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=6R7veym_AAAA:8 a=VnNF1IyMAAAA:8 a=0Onw2Fa-JIaQeuQxtZ4A:9 a=QEXdDO2ut3YA:10
 a=ILCOIF4F_8SzUMnO7jNM:22 a=poXaRoVlC6wW9_mwW8W4:22 a=pHzHmUro8NiASowvMSCR:22
 a=nt3jZW36AmriUCFCBwmW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-07_05,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 spamscore=0 phishscore=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511010021
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
> Commit 3469a56fa3dc985 introduced errp passthrough for many
> errors in the file. But in this specific case in
> tpm_emulator_get_buffer_size(), it simply used errp=NULL, so we lose
> printed error. Let's bring it back
> 
> Note also, that 3469a56fa3dc985 was fixing another commit,
> 42e556fa3f7a "backends/tpm: Propagate vTPM error on migration failure"
> and didn't mention it.
> 
> Fixes: 3469a56fa3dc985 "tmp_emulator: improve and fix use of errp"
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>   backends/tpm/tpm_emulator.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/backends/tpm/tpm_emulator.c b/backends/tpm/tpm_emulator.c
> index f10b9074fb..24aa18302e 100644
> --- a/backends/tpm/tpm_emulator.c
> +++ b/backends/tpm/tpm_emulator.c
> @@ -560,8 +560,10 @@ static TPMVersion tpm_emulator_get_tpm_version(TPMBackend *tb)
>   static size_t tpm_emulator_get_buffer_size(TPMBackend *tb)
>   {
>       size_t actual_size;
> +    Error *local_err = NULL;
>   
> -    if (tpm_emulator_set_buffer_size(tb, 0, &actual_size, NULL) < 0) {
> +    if (tpm_emulator_set_buffer_size(tb, 0, &actual_size, &local_err) < 0) {
> +        error_report_err(local_err);
>           return 4096;
>       }
>   

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>



