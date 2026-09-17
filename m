Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4530FC982D2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 17:52:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7GHD-0006WS-0v; Thu, 17 Sep 2026 13:52:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nikhilks@linux.ibm.com>)
 id 1x7GH5-0006Vi-Rg; Thu, 17 Sep 2026 13:52:00 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nikhilks@linux.ibm.com>)
 id 1x7GH2-0003W2-2p; Thu, 17 Sep 2026 13:51:53 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68HHVfaQ3143685; Thu, 17 Sep 2026 17:51:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=5MMvVd
 8jwd/aIPBKyD9KVUiINi1fAXgrUKb/kIVZnmY=; b=qAUrb8zoTlD6/itr+wVGXD
 AE3ZM/zFa+neziDHO9NeDn58revexJjqZ+53VUBEnqilVo81piS+FbHLg7VKNHHe
 O7koF8DCN/ge41L+WqgTx+zk092D05ZeFMJ4iUFIN4NSKOpc/Rda+XDsWRiHiQeI
 xUGqB+FGDwJdWjFbA3JMYPehwqm9mzStaclQH8s6NsSXolMHqww7KOk3uEm3nWJp
 7Idjb3uUQ3GlUCpH+gTSOy04fCPsFOMn8uQiOn/UkFVgVjzV3ss5kJTjpEC6CtXK
 NFTleMswqMxtzctZJTlVYJfpMDhOK1AgqVlhhiXEH2IrVSLOY+dOniDp4JBWcTuQ
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmx843y3u-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 17 Sep 2026 17:51:49 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68HH9Gaw3494061; Thu, 17 Sep 2026 17:51:48 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gr5fjkm1e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 17 Sep 2026 17:51:48 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68HHpgmp53477686
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 17 Sep 2026 17:51:42 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8E7DD2004D;
 Thu, 17 Sep 2026 17:51:42 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 43F412004B;
 Thu, 17 Sep 2026 17:51:38 +0000 (GMT)
Received: from [9.43.67.51] (unknown [9.43.67.51])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 17 Sep 2026 17:51:38 +0000 (GMT)
Message-ID: <09af11cb-e455-4a9a-83ce-e0ee037663e7@linux.ibm.com>
Date: Thu, 17 Sep 2026 23:21:36 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/6] ppc/spapr: Add ibm,errinjct RTAS call handler
To: Narayana Murty N <nnmlinux@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, mahesh@linux.ibm.com, sbhat@linux.ibm.com,
 anushree.mathur@linux.vnet.ibm.com, clg@redhat.com,
 sourabhjain@linux.ibm.com, adityag@linux.ibm.com
Cc: pierrick.bouvier@oss.qualcomm.com, rathc@linux.ibm.com, npiggin@gmail.com, 
 harshpb@linux.ibm.com, amachhiw@linux.ibm.com, hbathini@linux.ibm.com,
 shivangu@linux.ibm.com
References: <20260901174110.45356-1-nnmlinux@linux.ibm.com>
 <20260901174110.45356-3-nnmlinux@linux.ibm.com>
Content-Language: en-US
From: Nikhil Kumar Singh <nikhilks@linux.ibm.com>
In-Reply-To: <20260901174110.45356-3-nnmlinux@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDI1MCBTYWx0ZWRfX+pubTH5nS8sL
 VZNRiYQYcSNTfU6ivt3UhZRAEHmFNl4SKN9GsfrWg8Rq2sqrfJMzJo1kv1UQsWJgeu7KZxfbDOp
 qyXry41FxMCrShjojiH0iEetr89JuT1O/oowosjoJtXsSJ5F3YE/C7jdd/2ywIEbbp+8c+1EE8v
 E67Cjbz30ga387L4fQYg2g1VwV7cxs1LLH6EqCyjlC+C1UIAWPFzC/Z9MVdebBPSMBMHLjGoBbk
 0rYP7FsAH0tNFZnUtEVCH4s10SOUCN8rRdJT+9ZL+MifWFkA2eMAXkPJnnsOGJsmVauB784qb74
 Db5AzOzJkumFgxPx8lsDRIKcfCv2oV5HDOOJxjMwRP8pr6pu+lHACNJ6hpJv+1uJmMWnNYgqgqt
 JXKkc/NG1gh6+2TXyApz89dkQaXPah2hkFZjACC8iMVJ41S8OLi8NGlBiFq0L35yRT1QT2rs0pT
 p+X1pZN8Cuds1/KcaOw==
X-Proofpoint-ORIG-GUID: 5xa7MOjdF85atlfPpifOKpnePesfz5TB
X-Proofpoint-GUID: cFHAfdBHHxf-7XK8vNuY5qcJUbMhMVuw
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDI1MCBTYWx0ZWRfX0oKlA9XrpAXs
 gAqldP+aQ27EGWAhSel06g6UyGktgp9zc9plRxZelFLnf7ash2gMOd7vY2loOkb2OMfeg6DD3lK
 E+ib2IHm9XpxMteDNVbvIrqsMrzkzvE=
X-Authority-Analysis: v=2.4 cv=cY9HPXDM c=1 sm=1 tr=0 ts=6aac28b5 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=Cz9WfFLmUSrPgHwx-qUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 impostorscore=0 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609170250
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=nikhilks@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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



On 01/09/26 23:11, Narayana Murty N wrote:
> +    switch (type) {
> +    case RTAS_ERR_TYPE_IOA_BUS_ERROR:
> +    case RTAS_ERR_TYPE_IOA_BUS_ERROR_64:
> +        is_64bit = (type == RTAS_ERR_TYPE_IOA_BUS_ERROR_64);
> +        ret = spapr_errinjct_parse_ioa_bus_error(param_buf, is_64bit,
> +                                                 &addr, &mask,
> +                                                 &config_addr, &buid, &func);
> +        if (ret != RTAS_OUT_SUCCESS) {
> +            goto param_error_exit;
> +        }
> +        break;
> +
> +    case RTAS_ERR_TYPE_RECOVERED_SPECIAL_EVENT:
> +    case RTAS_ERR_TYPE_CORRUPTED_PAGE:
> +    case RTAS_ERR_TYPE_CORRUPTED_DCACHE_START:
> +    case RTAS_ERR_TYPE_CORRUPTED_DCACHE_END:
> +    case RTAS_ERR_TYPE_CORRUPTED_ICACHE_START:
> +    case RTAS_ERR_TYPE_CORRUPTED_ICACHE_END:
> +    case RTAS_ERR_TYPE_CORRUPTED_TLB_START:
> +    case RTAS_ERR_TYPE_CORRUPTED_TLB_END:
> +        spapr_errinjct_return_non_ioa_unsupported(rets);
> +        return;
> +
> +    default:
> +        goto param_error_exit;
> +    }

Hi Narayana,

In Patch 1, you defined full suite of RTAS error types in enum 
rtas_err_type. However, the switch (type) statement in 
rtas_ibm_errinjct() only handles a subset of them. The omitted types 
fall to the default case and jump to param_error_exit. But they are not 
wrong params, they are just not supported by QEMU. This is just a nit, 
as I can see in grep that both RTAS_OUT_PARAM_ERROR and 
RTAS_OUT_NOT_SUPPORTED map to -3 value, but it would be good for code 
clarity to explicitly route these valid-but-unimplemented types to the 
unsupported path and not PARAM_ERROR, as this explicitly signals to 
future readers that these are valid PAPR tokens lacking a QEMU 
implementation, rather than invalid parameters.

Rest the patch looks good to me. My above mentioned concern is not a 
blocker. Feel free to add my tag:

Reviewed-by: Nikhil Kumar Singh <nikhilks@linux.ibm.com>

Thanks & Regards
~ Nikhil

