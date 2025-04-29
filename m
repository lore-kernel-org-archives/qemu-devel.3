Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7B31C3ABA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 20:53:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9rxL-0002F1-2f; Tue, 29 Apr 2025 16:53:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1u9rxJ-00029c-LU
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 16:53:29 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1u9rxH-0001Ps-Qk
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 16:53:29 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53TEsPQ6029059;
 Tue, 29 Apr 2025 20:53:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=N/+FaQ
 a5e0rxEO2wr84Vq4odJeuMMHFJnZe++XzPxP0=; b=jUblxD0A+lF6ZBu/+5w4EK
 3iyBb1cveLrzmTEkvqU71lEe4EApH7K+r5Xzwjt/JJn5H9vfXIU3+yaeBB3xRyv5
 5GokHi/gcNaDjyZ6vDFavxcwDxqdahO0MMcRSK0Ar80HmmM3vE9f71TpKh7CizD0
 PDESzrWI+NncwyglzavAluceTaDd4+YYpD66zvwLRI3YLGqSAngp8DOVxnAcDSgk
 sF0JSj3d7YXXbyzf7oNrF19OUgQukV4puNP2jC3VVhJLGuBDpKyfQpH8FQOxOWcS
 mZVrGIqSsHfOqLxvjlI2muxL3ALIUzpLt8q6tKHKCzu5ndYQMZFryHz/9spxkvfw
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46ah8mdgen-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 29 Apr 2025 20:53:25 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53THkV52000644;
 Tue, 29 Apr 2025 20:53:24 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 469atpd2s9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 29 Apr 2025 20:53:24 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 53TKrLgg18940538
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 29 Apr 2025 20:53:21 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CCA5258064;
 Tue, 29 Apr 2025 20:53:23 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8864B5805A;
 Tue, 29 Apr 2025 20:53:22 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 29 Apr 2025 20:53:22 +0000 (GMT)
Message-ID: <63c35e00-ea78-41e2-bd8b-348c90e31af4@linux.ibm.com>
Date: Tue, 29 Apr 2025 16:53:22 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] qdev: make release_tpm() idempotent
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20250429140306.190384-1-marcandre.lureau@redhat.com>
 <20250429140306.190384-4-marcandre.lureau@redhat.com>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20250429140306.190384-4-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Z4aTU7YeFR5xAZyGPWdTADur-FWFyhHE
X-Proofpoint-GUID: Z4aTU7YeFR5xAZyGPWdTADur-FWFyhHE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI5MDE1MiBTYWx0ZWRfX5u4xAQpNXZX+
 ig+Z2UZIFseTuF2/mwBanzvBx3yFselF/zCb5URqgv1vByX0MjjInD8jaCn21laWRjupTf1k4p8
 3OWFyuT1PFedMapt7+LyOVVKTMweMz1v/sTkjHdaxQGSPPGMb1R9k/5MFrRT0Qp+Ked34tBZTTJ
 gxD1T3B3lDKkZ3ggi87xSZLtbvuXSYTNQUdnp/FicnQLicQtpAmPjhhBDogMy9U60tMkHnQ6enC
 JX/hHBG495/+TYQPkNPpIwx256s98WjeqJg4mOgKchKbfy7KcxhTOFUsIJpuratW2RG8W63IPZB
 faqBwOPFFajWmmSctvwpB9TMXtlq6dcXUkJ5SFQBvVgg8HBurOK6wp4IgAqGUdc4QJvF+4Vysbm
 B0O0JLlpSySjM0GzerlBTQPwguIFeh8EZ/B+zSK/WibymGDaYOj3lphJjYg2KdBJvMbo+J42
X-Authority-Analysis: v=2.4 cv=QNRoRhLL c=1 sm=1 tr=0 ts=68113c45 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8
 a=m7fl6o8Nl9rBM92gsO0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-29_07,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 clxscore=1015 mlxscore=0 malwarescore=0
 bulkscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504290152
Received-SPF: pass client-ip=148.163.156.1; envelope-from=stefanb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



On 4/29/25 10:03 AM, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> So it can eventually be called multiple times safely.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   backends/tpm/tpm_util.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/backends/tpm/tpm_util.c b/backends/tpm/tpm_util.c
> index f2d1739e33..16eab82cd2 100644
> --- a/backends/tpm/tpm_util.c
> +++ b/backends/tpm/tpm_util.c
> @@ -72,6 +72,7 @@ static void release_tpm(Object *obj, const char *name, void *opaque)
> 
>       if (*be) {
>           tpm_backend_reset(*be);
> +        *be = NULL;
>       }
>   }
> 

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>


