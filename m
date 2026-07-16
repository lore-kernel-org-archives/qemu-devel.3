Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAE0FC44501
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 12:50:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkLXi-0004JY-13; Thu, 16 Jul 2026 08:50:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wkLXf-0004J8-JF; Thu, 16 Jul 2026 08:50:20 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wkLXd-0000Vu-MJ; Thu, 16 Jul 2026 08:50:19 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66GABxfB1019788; Thu, 16 Jul 2026 12:50:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=aQV+dCmb58H0g3jBNRqCAQZmjRC2QB
 5S9eH7CLsvLcs=; b=a+1L2rNiZPksQ5q5ao/Np/Z86g4gX37yR5cybOmUd2IiD+
 7J764WCzqwNz/liqgWFV153OQ5GQuxEiGhhvSjmyJw6z6GBZi1zsQjQya0Faf8fs
 UtVQEKAwSnlyNc7N0Cxmq2TPLCDDPdhmRNMq2LHAn0kvol1WkavjvhRlM6qR/6B9
 Lx2rM7ZT5Mks1urBiooWupCwE4ZF+jwtCUBetZ/H0Q3H20W+HXXbwEi65N4AIaSR
 q2EeCmWb5ZI1A9A6HLOgvvw3B+nwMO6Ag+LkkrW/egK/GcHFQjPlMGcDeDJj5gGY
 KOAcvhuByNrfiCfHwU9dEkVCExuxiR+zGaiPC8WQ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fcv33hd3k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Jul 2026 12:50:07 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66GCna4f017944;
 Thu, 16 Jul 2026 12:50:06 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fc0hwd4wj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Jul 2026 12:50:06 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66GCo2Vs31851256
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 16 Jul 2026 12:50:02 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3E5132004B;
 Thu, 16 Jul 2026 12:50:02 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3737D20040;
 Thu, 16 Jul 2026 12:49:54 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.39.17.30]) by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Thu, 16 Jul 2026 12:49:53 +0000 (GMT)
Date: Thu, 16 Jul 2026 18:19:50 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: Saif Abrar <saif.abrar@linux.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, harshpb@linux.ibm.com,
 clg@kaod.org, npiggin@gmail.com, fbarrat@linux.ibm.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com, cohuck@redhat.com, pbonzini@redhat.com,
 thuth@redhat.com, lvivier@redhat.com, danielhb413@gmail.com,
 kowal@linux.ibm.com, chalapathi.v@linux.ibm.com, calebs@linux.ibm.com,
 milesg@linux.ibm.com, jishnuvw@linux.ibm.com, amachhiw@linux.ibm.com
Subject: Re: [PATCH v5 5/9] pnv/phb5: Implement write-clear and return 1's on
 unimplemented reg read
Message-ID: <aljQz3yux9eLr68H@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
References: <20260617095058.652789-1-saif.abrar@linux.ibm.com>
 <20260617095058.652789-6-saif.abrar@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260617095058.652789-6-saif.abrar@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDEzMSBTYWx0ZWRfX76t0MoU7E7TW
 Vr+dmaImf885+hbAAeJEmzFxVQtrOyCSoS9YtzKXWhtW+6k5ekkgQnPPXi9eJCpbSV+i+iUmfza
 lgTED00+nL02d3WmK3/dIItd6WieDYE=
X-Authority-Analysis: v=2.4 cv=Mp1iLWae c=1 sm=1 tr=0 ts=6a58d380 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=6WmQozfOMwaGxlpHVjIA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: qgsKXDbxDcL_LzQQogmRdH6Gt2By5PRy
X-Proofpoint-ORIG-GUID: pVuVSZF8xlIK-xxT99typUVbkM1b6Hst
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDEzMSBTYWx0ZWRfX4N2AynyVC1jR
 Vel16CBfCc+QbrLOs1dPDEXN7nh0+blxhZ+dyNWVxCbVRgcd13sSj0gmzAts/dVxL5i7LPQl3lp
 5x9T+HIMlk896wjC6tABL7CudpBcdETrYMBv4LfpXl98249kXFFe78K79QGWcc8YWHfV13LU61v
 PmVLVHhjnG+HKuHRmD1NRL0d5egOXaBO2/fb5pk7si5aRQHy82JwCvGFD/y9JrmYC0R8n/dCiWB
 mAdNII/wcQ8Clu8VhsDg34WzBUMn/NRYYJNOX9efwEMKGIsdpLs0NfFe2LRZZY88gBrRziVAKl4
 KifB/7T+rFb+zgNt2AKkgTJYJxYe3+WbBgs+derUduMYsYhBVq9tr0WCFG76gUBzu9yEsKBMj8E
 NnNx0Q6KZv7Ah/eEDmdm7Qsm0fu7CE2Sv1v2xBwLfbyTVWnv4Ch9akkCZD+eY+gF+yd5wEwDYsN
 ETfR+Ql5jhfCyNzBXhw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_04,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 suspectscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160131
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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

On 26/06/17 04:50AM, Saif Abrar wrote:
> <...snip...>
>
> @@ -724,6 +762,7 @@ static void pnv_phb4_reg_write(void *opaque, hwaddr off, uint64_t val,
>              pnv_phb4_update_all_msi_regions(phb);
>          }
>          break;
> +
>      case PHB_M32_START_ADDR:
>      case PHB_M64_UPPER_BITS:
>          if (changed) {
> @@ -771,27 +810,63 @@ static void pnv_phb4_reg_write(void *opaque, hwaddr off, uint64_t val,
>          break;
>  
>      /* Silent simple writes */
> -    case PHB_ASN_CMPM:
> -    case PHB_CONFIG_ADDRESS:
> -    case PHB_IODA_ADDR:
> -    case PHB_TCE_KILL:
> -    case PHB_TCE_SPEC_CTL:
> -    case PHB_PEST_BAR:
> -    case PHB_PELTV_BAR:

Few of these are not handled in new code, like ASN_CMPM.

As you said in v4 that these are removed in PHB5 spec. The ASN_CMPM in
particular was anyways a silent skip, and now it will turn up as
unimplemented.

With separation of phb5, i will let you remove them or keep them as
silent skip for phb4.

Can you also check if there are any other such regs which may have been
skipped ?

> --- a/tests/qtest/pnv-phb-test.c
> +++ b/tests/qtest/pnv-phb-test.c
> @@ -88,11 +88,10 @@ static void phb5_sticky_rst_test(QTestState *qts)
>      g_assert_cmpuint(val, ==, (PPC_BITMASK(24, 27) | PPC_BITMASK(36, 37) |
>                       PPC_BITMASK(39, 45) | PPC_BITMASK(47, 48) |
>                       PPC_BITMASK(52, 54)));
> -
>  }
>  
>  /* Check that write-only bits/regs return 0 when read */
> -static void phb4_writeonly_read_test(QTestState *qts)
> +static void phb5_writeonly_read_test(QTestState *qts)
>  {
>      uint64_t val;
>  
> @@ -143,6 +142,12 @@ static void phb4_writeonly_read_test(QTestState *qts)
>      g_assert_cmpuint(val, ==, 0x0);
>  }
>  
> +/* Check that reading an unimplemented address 0x0 returns -1 */
> +static void phb5_unimplemented_read_test(QTestState *qts)
> +{
> +    g_assert_cmpint(PHB5_XSCOM_READ(0x0), ==, -1);
> +}
> +
>  static void phb5_tests(void)
>  {
>      QTestState *qts = NULL;
> @@ -156,7 +161,10 @@ static void phb5_tests(void)
>      phb5_sticky_rst_test(qts);
>  
>      /* Check write-only logic */
> -    phb4_writeonly_read_test(qts);
> +    phb5_writeonly_read_test(qts);

With PHB5 separated out from PHB4, let's keep phb4_writeonly_read_test
also.

Thanks,
- Aditya G


