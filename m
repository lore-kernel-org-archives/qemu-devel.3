Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF875CDB466
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 07:03:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wce6X-0006u5-Ib; Thu, 25 Jun 2026 03:02:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wce6W-0006sL-BE; Thu, 25 Jun 2026 03:02:28 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wce6U-00026X-GQ; Thu, 25 Jun 2026 03:02:28 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65P3mX5S2977964; Thu, 25 Jun 2026 07:02:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=nguo0ZUsflm4ee/mXoexypnPtmJm7+
 TVeCA6Z4WBgpI=; b=fNuREHlNdqTuuiUNIcyyML9RMTQ7VM+0hdpPjQ4w9E+FLg
 c5SGCiYnZoNjWRbNX7bm1DmE7YTs3TBxCDCW/D9oNHMEDwsOP7FEEK7DbRPudxHA
 QSiDjmKsWN4EUM6VxuhPrLZcYj3K3voENKuwa+hXF/j6md5GuiJW3/bB5WsVfmQ+
 rUklIP7iv4KKgPbAlREPfSLIsaotNxz4poFu3ATw+fvG3CcjGWk1jSJveUF/jOXT
 dm5tkTxL4fkhcXUcEIiO9emtl15fZlyoS+t3FKMVZDEF97fgh7PMTRTA46LQtCQr
 XwuqpJFYK3CkWWKlFaFs/5vrgs3h20DQdk8R3WCA==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjk4resq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Jun 2026 07:02:23 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65P6o1pb023466;
 Thu, 25 Jun 2026 07:02:22 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex7vyvkha-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Jun 2026 07:02:22 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65P72Hrq38470140
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 25 Jun 2026 07:02:17 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0D0F620043;
 Thu, 25 Jun 2026 07:02:17 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3CA942004B;
 Thu, 25 Jun 2026 07:02:14 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.39.21.199]) by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Thu, 25 Jun 2026 07:02:13 +0000 (GMT)
Date: Thu, 25 Jun 2026 12:32:11 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: Shivang Upadhyay <shivangu@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, harshpb@linux.ibm.com,
 npiggin@gmail.com, milesg@linux.ibm.com
Subject: Re: [PATCH 2/2] ppc/pnv: add test to verify external DTB is honored
Message-ID: <ajzSBFuXi_QP3kDG@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
References: <20260623063156.1110370-1-shivangu@linux.ibm.com>
 <20260623063156.1110370-3-shivangu@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260623063156.1110370-3-shivangu@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDA1NyBTYWx0ZWRfX0EjiJjSAFtfa
 3GSL+kg2fzTGZULtXNoZLXvxgl96oJ/ASo+t0Rbh7pM4Sz9D0hi8E3RMK/cBLLeCOsV4gXuOY1w
 ETpb0arg2N3mSe9cg+2rS08XpqwfuVw=
X-Proofpoint-ORIG-GUID: m1s00VT_4fc7EnRMWTkHfniSgm9_XpnW
X-Authority-Analysis: v=2.4 cv=Oph/DS/t c=1 sm=1 tr=0 ts=6a3cd280 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=NEAV23lmAAAA:8
 a=VnNF1IyMAAAA:8 a=MacDSDUIfHXgkWtIPksA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDA1NyBTYWx0ZWRfXxl/ydvoHL2BC
 21iohTRwlIASMZgpTzSPL6FClyWt57rpWLJweO8/4A+i9f0ad2caBLDz/ZBxEYPR7fH9Sq+Ne/T
 SQMwF+/NFB2Iqg+0YN518VDGXqsaLGW2pvvRTbiGiM6mdemtbr2NdgE4S6vyQzKVNoZxmMyx59S
 1H4B6sBL1iM7iJbTVlXfkM+K9L0XDSqd0JVcZH6twxd8jyYDvPCEq/2U1ypD2W+01ThNROo0EHm
 MTSMcMtMCERyzz2w8AW1DeJ45z6cSRxXWP7AlUjZ/EeeLJ/CtrZpcIJyzBBKm/mHWHOZh9M5UF/
 +hynaMJ6goz6Tg+4ffG5dN3qF/vrxRTvWLBa2rOYvMTxIN+eFpcp0iyfC5IsfjdU5M77TRX8m8W
 SVhsreu4H7YisbEo6TN768wY5ZbfuoM39blpQY88Cz+mqNaWP/bHsJ0+rcRvQKPCZPkzfVRI+6f
 wLliXhFSQViT8NPF+KA==
X-Proofpoint-GUID: 4_j9Q10xzydH-dkJEahRKumjq1In5w0d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_01,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606250057
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

On 26/06/23 12:01PM, Shivang Upadhyay wrote:
> Signed-off-by: Shivang Upadhyay <shivangu@linux.ibm.com>

description, as pointed by amit

> <...snip...>
> +    # testdtb for power11, which contains string "hello world" in command line
> +    ASSET_SAMPLE_DTB = Asset(
> +        ('https://github.com/roz3x/qemu/raw/refs/heads/sample-dtb/output.dtb'),
> +        '2dd3330561768fc5c8e4b93aa29bc44c64278d186f1e0f8c584cdf15c3f8cf43')
> +
>      def do_test_linux_boot(self, command_line = KERNEL_COMMON_COMMAND_LINE):
>          self.require_accelerator("tcg")
>          kernel_path = self.ASSET_KERNEL.fetch()
> @@ -104,6 +109,20 @@ def do_test_ppc64_powernv(self, proc):
>          # Device detection output driven by udev probing is sometimes cut off
>          # from console output, suspect S14silence-console init script.
>  
> +    def test_ppc64_powernv_external_dtb(self):
> +        self.set_machine('powernv11')
> +        self.require_accelerator("tcg")
> +
> +        kernel_path = self.ASSET_KERNEL.fetch()
> +        sample_dtb_path = self.ASSET_SAMPLE_DTB.fetch()

update the dtb also when you post v2, this dtb is of power10, works, but
better to have power11's dtb here

Thanks,
- Aditya G

