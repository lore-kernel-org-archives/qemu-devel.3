Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E411AC4450A
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 12:53:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkLZy-0004kM-TP; Thu, 16 Jul 2026 08:52:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wkLZx-0004k2-6f; Thu, 16 Jul 2026 08:52:41 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wkLZv-0000m5-R2; Thu, 16 Jul 2026 08:52:40 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66GACwLK2901409; Thu, 16 Jul 2026 12:52:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=XJQBp5YWB1h7xx3xdckiEvPE6kE0FA
 DZEFJG+IjOe7c=; b=fhU+6PA1h5TF0e4CUX1DT599uyF2rujWp3+XigiPzD3UWw
 2rvBxYecx7RBbwSuGbOW8XXmvxb1pi7giEZiEsrXGuhZZKHx7WHeLMbHx5EOBmY1
 5IVof3qOVn+ENuFjO40OX15FLncIepPntZF787Sxc2klGz3Eo23BMwMaZPgL+Btc
 V97yy1VP/RdNjuwNoJEJZVA2fL22w3uPticVZx+NQev103iprP7HJ9GqD9Ya0Vd+
 j9C1rl2lAti9nchne525IXUTUw8ISRg5mdUpvjxY0Wv8/JdbYt8C6fLBMrm+LYKA
 0KmXZ0rye+HNKwtJpBO5+Vf8r6v+SNa3Teh8L8ww==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbegc0629-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Jul 2026 12:52:30 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66GCnaQl000637;
 Thu, 16 Jul 2026 12:52:29 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc05qd7qa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Jul 2026 12:52:29 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66GCqPET51314954
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 16 Jul 2026 12:52:25 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C80C22004B;
 Thu, 16 Jul 2026 12:52:25 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B885720049;
 Thu, 16 Jul 2026 12:52:18 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.39.17.30]) by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Thu, 16 Jul 2026 12:52:18 +0000 (GMT)
Date: Thu, 16 Jul 2026 18:22:15 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: Saif Abrar <saif.abrar@linux.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, harshpb@linux.ibm.com,
 clg@kaod.org, npiggin@gmail.com, fbarrat@linux.ibm.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com, cohuck@redhat.com, pbonzini@redhat.com,
 thuth@redhat.com, lvivier@redhat.com, danielhb413@gmail.com,
 kowal@linux.ibm.com, chalapathi.v@linux.ibm.com, calebs@linux.ibm.com,
 milesg@linux.ibm.com, jishnuvw@linux.ibm.com, amachhiw@linux.ibm.com
Subject: Re: [PATCH v5 6/9] pnv/phb5: Set link-active status in HPSTAT and
 LMR registers
Message-ID: <aljTx6wiZmmg_Gpn@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
References: <20260617095058.652789-1-saif.abrar@linux.ibm.com>
 <20260617095058.652789-7-saif.abrar@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260617095058.652789-7-saif.abrar@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=fOcJG5ae c=1 sm=1 tr=0 ts=6a58d40e cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=Cpqwdy_U1NLdr3Vyi5wA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDEzMSBTYWx0ZWRfXxwxwkkBQ0Uy7
 AAf43kMb6ZbacGTH5kJUKvR9QKJ3Lt8CFt35GecH/ZZWsOtcm4MNs1c07cVuTP7DRfwINULrSE6
 FUHsCmOEauGQhDgfbPYBHWDPzyXzeM2Ssn5zhlRgQCLNS28JMjhcO0eMWX0c7LSP05EmzWioj/1
 DY5egkWz2xJPU12P9BLDsVGY+4JKXiQLdzxPwQbvVH/55LgitVJWLZbUFhX6gimeqX81CfIbhxD
 B4AQJxdcXBn2VliHIRgT5tjgOP5johw3/Dor8iOD+rPdV9Q5hyyKEcvWgzLlLX/e4B/hGdrJoJS
 D8IHaGiVpG5CVsVWcqyp2mYUHDEfoLv1/wVvKOvVOwdL2TG063eTjendsifxhb1amsplNEzvpHl
 WZX9BksO31FNxjJM/X/IQ+Oz9WdIdAxPDqxSiiC+B+hd/UKN1TJWtwfrr8M+ZObpeaCA66g4QPA
 ZhPJuiaN+jjd5vxJAkg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDEzMSBTYWx0ZWRfX5A9DDdCW0FOP
 y6SL4OfeQ+kiKSQe6Dqq6rynDkAbStU0aLuFW8I48TdHvBsqPqwIE4DQCno2AmxasSvEmvOfNMk
 g06E1wuariemGDW8Y6ywh5AnRsi+ww0=
X-Proofpoint-GUID: ilaq8BlvPwaDQ8XIbTWJPgCiICnA5EnJ
X-Proofpoint-ORIG-GUID: k8uwA7WXiba4LwTBvmAjWyw5up4qCcDB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_04,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607160131
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
> @@ -951,6 +1005,11 @@ static uint64_t pnv_phb4_reg_read(void *opaque, hwaddr off, unsigned size)
>      case PHB_PCIE_LMR:
>          /* These write-only bits always read as 0 */
>          val &= ~(PHB_PCIE_LMR_CHANGELW | PHB_PCIE_LMR_RETRAINLINK);
> +
> +        /* Check if link is active and set the bit */
> +        if (is_link_active(phb)) {
> +            val |= PHB_PCIE_LMR_LINKACTIVE;
> +        }
>          return val;
>  
>      /* Silent simple reads */

Looks good to me. Feel free to retain the rb.

Reviewed-by: Aditya Gupta <adityag@linux.ibm.com>

Thanks,
- Aditya G

> -- 
> 2.52.0
> 

