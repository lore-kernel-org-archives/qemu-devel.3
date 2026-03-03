Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A9D8EDEBF7
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 21:47:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxXa3-0003F9-1Z; Tue, 03 Mar 2026 16:47:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1vxXa0-0003Ew-F1; Tue, 03 Mar 2026 16:47:00 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1vxXZy-00006V-Q9; Tue, 03 Mar 2026 16:47:00 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 623GpdI51621757; Tue, 3 Mar 2026 21:46:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=usN6kB
 0qk0Owl4ftTW1ilmJ51sqXN5xXEAIuKUpFC4c=; b=dpVdp0Hl0ecAEIPcckGhl8
 t9xeHzALMzHiD9DfODREUUVejqeB4yokdMRMbh50zLrGP+M5oH8SaQ0AWN2FQGQb
 8PuHrpFUIQP5f+Rrr2HXDEBoM7vR5cCFcu51Tv2XB2wCo0Q+P9T8noHMFSo44WFs
 Kul4fXVaFaKM4kbfvM36rGyPKc/b8Y6a5/w1Re7lbNHH+LwcuYBhXVJjTqNjq9+p
 ZEFd76chfhAkwPM9Csrvf6R+2RbHgVyGhbmHSrvRS5Ts2BKTWqzJ5upj4qURZCiL
 u71itdF/AtTVyi0dEX46ha8FZ7Pdd6YE9xjudtIO+X5nWajZJyVJj7Q8E2Wlu3Mw
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ckssmmptg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 03 Mar 2026 21:46:54 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 623HdOM9028952;
 Tue, 3 Mar 2026 21:46:53 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cmaps4aby-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 03 Mar 2026 21:46:53 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 623LkqrG31326952
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 3 Mar 2026 21:46:52 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1C9C158052;
 Tue,  3 Mar 2026 21:46:52 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4E7E358045;
 Tue,  3 Mar 2026 21:46:50 +0000 (GMT)
Received: from [9.61.253.239] (unknown [9.61.253.239])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  3 Mar 2026 21:46:50 +0000 (GMT)
Message-ID: <e434be13-1099-4d4d-b689-e4f6b7752b45@linux.ibm.com>
Date: Tue, 3 Mar 2026 13:46:49 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 19/30] pc-bios/s390-ccw: Add signature verification for
 secure IPL in audit mode
To: Zhuoying Cai <zycai@linux.ibm.com>, thuth@redhat.com, berrange@redhat.com, 
 richard.henderson@linaro.org, jrossi@linux.ibm.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: david@kernel.org, walling@linux.ibm.com, jjherne@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, brueckner@linux.ibm.com
References: <20260212204352.1044699-1-zycai@linux.ibm.com>
 <20260212204352.1044699-20-zycai@linux.ibm.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20260212204352.1044699-20-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDE3OCBTYWx0ZWRfX4/oth6VkurgV
 Hr0FKw00lPZDzf661ek9QwVmClWU1MxynmTBmIc1uQknzPrIShhUPL1n8rpJhSDG3RsB/GehYaz
 6c8Ur7y2ha/vqtspCXNR+dQQwiq8A9qJliHuc7lhZ0ErFN/Wp3WMFDtzviRyIW2eDaPhIYXglY6
 BuySyA/ySRJVVY2t8z/Sz+11KPmEHVbH8tjys9beNxNICTLjbDlQjyelLn3D+e3ymGUKKY9MNI4
 e+OvWBc91DUoTDcXyUHoyg93s4PBu5xr3GwSKF9tgPz0FPSgSx32MF3mlIeLJs5hiGkzJ/KBN3i
 uoQukBfcGO48ApmmyIFfpEpwmLAYUuBBVrcFQNrfC/gu/TV86TIBTIsT12gyojqfutWAFw8sOhB
 gvAqjoH42qMuJfGA7Jdj2T+N8ykkadEKQd2lvgdF22e/SyP1DK4HU4gTI+DMIrU+MFk8ucWj2a5
 W4H5wv3sIEJwWLcWYjg==
X-Proofpoint-ORIG-GUID: GgmBqZePQBfn5gDfGrjawR8ZO862Bnda
X-Proofpoint-GUID: GgmBqZePQBfn5gDfGrjawR8ZO862Bnda
X-Authority-Analysis: v=2.4 cv=AobjHe9P c=1 sm=1 tr=0 ts=69a756ce cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=69GBZIUKv3m5IH6vkPEA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-03_03,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 spamscore=0 clxscore=1011 suspectscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603030178
Received-SPF: pass client-ip=148.163.158.5; envelope-from=alifm@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

<...snip...>

On 2/12/2026 12:43 PM, Zhuoying Cai wrote:
> uint8_t vcssb_data[VCSSB_MIN_LEN] __attribute__((__aligned__(PAGE_SIZE)));

I don't see us setting vcssb_data set to 0 before we even start secure 
ipl verification. I think we should be safe and set it to 0 before the 
first time we touch this? otherwise if its pointing to garbage data it 
can break the length checks.

Thanks

Farhan

> +
> +VCStorageSizeBlock *zipl_secure_get_vcssb(void)
> +{
> +    VCStorageSizeBlock *vcssb;
> +
> +    vcssb = (VCStorageSizeBlock *)vcssb_data;
> +    /* avoid retrieving vcssb multiple times */
> +    if (vcssb->length >= VCSSB_MIN_LEN) {
> +        return vcssb;
> +    }
> +
> +    if (!is_cert_store_facility_supported()) {
> +        puts("Certificate Store Facility is not supported by the hypervisor!");
> +        return NULL;
> +    }
> +
> +    vcssb->length = VCSSB_MIN_LEN;
> +    if (diag320(vcssb, DIAG_320_SUBC_QUERY_VCSI) != DIAG_320_RC_OK) {
> +        return NULL;
> +    }
> +
> +    return vcssb;
> +}

<...snip...>



