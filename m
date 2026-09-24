Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A25E3C9830E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 13:35:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9jbG-0004z3-R5; Thu, 24 Sep 2026 09:34:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1x9jbF-0004yu-8O
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 09:34:57 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1x9jbD-0005YH-CY
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 09:34:57 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68OC6CWs2221263; Thu, 24 Sep 2026 13:34:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=L3wHk/
 zpR9PjycsjLV3r7yUKAcnFxukVup0hP4+PCEA=; b=mfoottV7BhGIkhH91N+gj2
 BPU3DJqSB3DoL/nuMDkTMaUlXub5Q74k47kZxUhiZC3JcwYKiZlohyNIixgzFAqo
 gwbM6jbxy7mXE7oQmiOcQAzn9TPDDKsHoif9xui+ssshURJdVM1GnrvONKEP/vzV
 F5Pc6cy92S80zL6/7+eXyW3z5bEECaQb6X21BB+HFzB33RueQKutFlbg5cgTfChF
 aAUHq7oEnkPvkI0A3+k2cROLpmj/NbjXfP6rOuMHEs8iabi+N1dtbVmKs/g3Gk8w
 gLDg+f8vwdHRPOi5vpfPy8NxswZeVmnLFIiVsHuC/qMcHHkRT3gdaIQyb2r84OLA
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskdvgng4-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 24 Sep 2026 13:34:53 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68OCHpsO2008989; Thu, 24 Sep 2026 13:34:52 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gvbt2wxmd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Sep 2026 13:34:52 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68ODYqbV33882856
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Sep 2026 13:34:52 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F2B4C5805C;
 Thu, 24 Sep 2026 13:34:51 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ADE0E5805A;
 Thu, 24 Sep 2026 13:34:51 +0000 (GMT)
Received: from [9.47.158.153] (unknown [9.47.158.153])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 24 Sep 2026 13:34:51 +0000 (GMT)
Message-ID: <869ab465-60d1-4b0c-ad6c-88f0e8540d90@linux.ibm.com>
Date: Thu, 24 Sep 2026 09:34:51 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/10] hw/tpm: tis: Only read from response buffer if
 rw_offset < len
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, armenon@redhat.com, marcandre.lureau@gmail.com
References: <20260924012527.858527-1-stefanb@linux.ibm.com>
 <20260924012527.858527-5-stefanb@linux.ibm.com>
 <179023566485.1794827.7521598151635314490.b4-review@b4>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <179023566485.1794827.7521598151635314490.b4-review@b4>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: _xRHd_yqXVJIO5ijQmE2gsxJnTSgzd0K
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA1NCBTYWx0ZWRfX+jLb0S3Ho3x8
 4aLcQmAfb4sxY5knUEbDWVgmAjRTGsjSEoF8PfBrcFo+cUIVdR882cxjm2y7lc9k3f2X7kq22mA
 9Tztdg8z5nV2iEYsJBwf7vU4f3Y6Gd8=
X-Authority-Analysis: v=2.4 cv=FLiOVOos c=1 sm=1 tr=0 ts=6ab526fd cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=20KFwNOVAAAA:8
 a=VnNF1IyMAAAA:8 a=AvTrgDeqMaXFr3S1oaYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: TeZyYrutdYOsp-EuBSIU86UcvluM8u1w
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA1NCBTYWx0ZWRfX6W8xJ7fZYjR3
 wcdjp4Y1bBRasYZaFdGn/zIaU6rzixpb56XcgZUVlpoIdOxB5UVjhBaWDD2oPRA2bQ/XiMUC3l6
 jbPF9W7PHMi+EHwgBY00UnTaQ+z5nq3j69bIRol/q5n5j9MAH6c7nmUJxx9XjQO0tKW1T2h89Af
 K7omjoDBxiLZSuvMCiGQ13L6lI4QjqEhjau0ASmcVYnAikFftX0iODmulJ1E2Bf1zzWCS9w3eMm
 rGJXKs8KE/x2ItGE2OO7ZYLud4Ejr76c8ePmQaEtHQNGZcjI5kb0330yfc/tJu1YeVQov0vpLxW
 h7WdsvaBF0106M4VXaEKo5Yx6/ja0vBkKv/3pflbakSWAkGTGhcwZNHTOhgd46Uh3J0QSF6BFTV
 El425fHa5BvdfFlf/GSUVfIZ2KY+t0c3Y+tVji25YzaynExyXzWO9jwh5qQgj3tuXrLJn49glHH
 LZ1FFK7xTpg2MwMyqmg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 phishscore=0 spamscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609240054
Received-SPF: pass client-ip=148.163.158.5; envelope-from=stefanb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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



On 9/24/26 3:41 AM, marcandre.lureau@redhat.com wrote:
>> Only read a byte from the response buffer, if the rw_offset < len.
> 
> OOB read from malicious driver is CVE-level.

It would not read outside the allocated bounds of the s->buffer but 
outside of the bounds of the returned TPM response. But this is only 
possible if 0 bytes were returned, so it would only ever read s->buffer[0].
The foollowing line then resets the TPM_TIS_STS_DATA_AVAILABLE flag so 
that it would not read another byte. IMO, this is not a CVE.

tpm_tis_sts_set(&s->loc[locty], TPM_TIS_STS_VALID);


> 
>>
>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>> Message-ID: <20260924012527.858527-5-stefanb@linux.ibm.com>
>>
>> diff --git a/hw/tpm/tpm_tis_common.c b/hw/tpm/tpm_tis_common.c
>> index a134d5c20599..4ba228116b64 100644
>> --- a/hw/tpm/tpm_tis_common.c
>> +++ b/hw/tpm/tpm_tis_common.c
>> @@ -273,13 +273,15 @@ static uint32_t tpm_tis_data_read(TPMState *s, uint8_t locty)
>>           len = MIN(tpm_cmd_get_size(&s->buffer),
>>                     s->be_buffer_size);
>>   
>> -        ret = s->buffer[s->rw_offset++];
>> +        if (s->rw_offset < len) {
>> +            ret = s->buffer[s->rw_offset++];
>> +            trace_tpm_tis_data_read(ret, s->rw_offset - 1);
>> +        }
>>           if (s->rw_offset >= len) {
>>               /* got last byte */
>>               tpm_tis_sts_set(&s->loc[locty], TPM_TIS_STS_VALID);
>>               tpm_tis_raise_irq(s, locty, TPM_TIS_INT_STS_VALID);
>>           }
>> -        trace_tpm_tis_data_read(ret, s->rw_offset - 1);
>>       }
>>   
>>       return ret;
> 
> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> 


