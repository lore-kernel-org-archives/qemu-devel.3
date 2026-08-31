Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAE31C624CE
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 14:10:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x12i4-0002xC-IO; Mon, 31 Aug 2026 10:10:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1x12i3-0002wu-NJ
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 10:10:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1x12i2-0006Ow-9Z
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 10:10:03 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67VBVjSk956634; Mon, 31 Aug 2026 14:10:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=1vqQj8
 24YRff5Y6udmregmLZ1tmxI3Nz2knTVviSifw=; b=cIKEWuSKo3UxGP6/95HREG
 qMcb05ek5IIFHe47Y9hBSpQUNQXaXo9Ip45hDElfnyuY5Ww31/gWygf/o7jrQuAk
 LMChHjLDrKemTtyDfj1mX0V7JFZr4HrZ33FO2MLt9Ek9DyCvKHL2SkMcnAEFXavc
 oXM3LCaq/25OnNBeNnCPp6GDJ5ZMdHnasAapQkWh+yhTkn4KfaG7hdaBNbxjdVRw
 0KfbOS50R6eaJoXiYg86l4EEhwwMuK0U5JzjVDGx6U14cTuFzZAoL0YudTnrXTnB
 zdpR4sMHhwnlk8u1bOUheJlr6+98JAcdIvVF/LMyJDy14vF3wDunSJ04XQ0at34A
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbnudhr5p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 31 Aug 2026 14:10:01 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67VDuHwR001683;
 Mon, 31 Aug 2026 14:10:00 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gccexx1ey-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 31 Aug 2026 14:10:00 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67VE9x6K32637552
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 31 Aug 2026 14:10:00 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ADCE058058;
 Mon, 31 Aug 2026 14:09:59 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4B19B5805B;
 Mon, 31 Aug 2026 14:09:59 +0000 (GMT)
Received: from [9.61.31.247] (unknown [9.61.31.247])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 31 Aug 2026 14:09:59 +0000 (GMT)
Message-ID: <ee2d0262-03ef-4441-bffd-f1bba88a2396@linux.ibm.com>
Date: Mon, 31 Aug 2026 10:09:58 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] crypto/x509-utils: propagate the error
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: berrange@redhat.com
References: <20260831121009.2810804-1-marcandre.lureau@redhat.com>
Content-Language: en-US
From: Zhuoying Cai <zycai@linux.ibm.com>
In-Reply-To: <20260831121009.2810804-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 6yjyns-A8izPwQFOf9CHgAejkty4kF2K
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDEyMSBTYWx0ZWRfXwwTD6gY8dgdc
 J3MZfackX8IAwT/niiGojNn1fK6uHMgAJc6+xdeGTrHe0UcKlXR0BGL3N4VgPfDDnHiLqrXsgmf
 +CZ/WZmGc7j1TWYdMzZlW3jGIUsgmp1eRAoC77t8HKzb9O/8M436iWAcupx8jV6TnXiwk+Lqol7
 OGBP0+q/8USs0PuFTkbatm/O1Ihp/+uMNG9srvjarYG22juvdmfkAd6ngDFsAoCcWb5H6iLfbAe
 /9oNOpryh7EqncFoNBkVb/MVhgUp9nVx4xm19qjgd12sT5Ht6zrNRF7yZqoT2mt4j3+Jl7xEK+l
 MOy6YlcTh+gzOvuSlB+LubRb4Tqyn/jEo0lhjaBKjsnMMZOeVlLysvU1HpEgrH3PcTkyQeVc51k
 fmFUDxjB+7TtUEsQll2Ci9x8SQoGufwalt4xP4rrUU504Kz29Jqvvw4c0yLdj6M0h+yXt6bEfdl
 Umcpm5tJw1tOHfu6Luw==
X-Proofpoint-ORIG-GUID: 6yjyns-A8izPwQFOf9CHgAejkty4kF2K
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDEyMSBTYWx0ZWRfX/4ONZxB2ejhw
 PdbaXZ+07jGQWqnJLD9mHivK0XhwxCxy4dUwKheNl0HoWUxUCyOjQLRdMTUTYf1lAg5ugc/4Tui
 WQSy8uY6WDhqpIa14SRFDZDEV6+l+pc=
X-Authority-Analysis: v=2.4 cv=B92JFutM c=1 sm=1 tr=0 ts=6a958b39 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=20KFwNOVAAAA:8 a=zhgLkVULathdIK0Tm94A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_04,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 clxscore=1011 suspectscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608310121
Received-SPF: pass client-ip=148.163.158.5; envelope-from=zycai@linux.ibm.com;
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

Reviewed-by: Zhuoying Cai <zycai@linux.ibm.com>

On 8/31/26 8:10 AM, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Propagate the error when qcrypto_x509_get_pk_algorithm fails, instead of
> falling through to return 0 (success) with *errp set.
> 
> Fixes: e8317c4c9f68 ("crypto/x509-utils: Add helper functions for DIAG 320 subcode 2")
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  crypto/x509-utils.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/crypto/x509-utils.c b/crypto/x509-utils.c
> index 34cbfca26bff..edcc44de80d3 100644
> --- a/crypto/x509-utils.c
> +++ b/crypto/x509-utils.c
> @@ -319,6 +319,9 @@ int qcrypto_x509_check_ecc_curve_p521(uint8_t *cert, size_t size, Error **errp)
>      int curve_id;
>  
>      algo = qcrypto_x509_get_pk_algorithm(cert, size, errp);
> +    if (algo < 0) {
> +        return -1;
> +    }
>      if (algo != GNUTLS_PK_ECDSA) {
>          return 0;
>      }


