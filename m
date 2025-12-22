Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FADEE674B2
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Dec 2025 13:51:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vXgIo-0004WD-SZ; Mon, 22 Dec 2025 08:50:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@inux.ibm.com>)
 id 1vXdg2-0006b3-7H; Mon, 22 Dec 2025 06:02:10 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@inux.ibm.com>)
 id 1vXdg0-0000bM-8R; Mon, 22 Dec 2025 06:02:09 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BM6S1mm028691;
 Mon, 22 Dec 2025 11:02:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=KHgQx06tPz8OVmpKwM4nKUnm2MEk6q
 nECpV2771JLbA=; b=miYzJ16apBaoD5iCI0Q2DTussa1hkW34bfypVrBW3OKMQQ
 Rv2jomll2ZrUb/P1zmuZyQflzHDfwj1a29VI/74TEcRy3j6rUBGTj0sJjvT3F/aw
 7XwUOHYOesqZ2IPW2EZ5mYaDW3Wu48LjQrauStMDijNwemv9znqRnAUEMSVNJA/C
 0sj7RUWQUf9HbTzstDX9eYLqb/YagDoFLnCrMwgaAz35+dh9PR7hjLjCdRzvDIwV
 MT49pwPEmLOMcRnziYGRG+fc6/KAnRTDrrFGJ7cX6kBB+LAScEp14um+nFeqisfm
 BmGyQd1KjobJmYVW+uqsjvqa5NACtfg0t6BAJqgw==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b5j7dyg8c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 22 Dec 2025 11:02:04 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BMB1qUO000730;
 Mon, 22 Dec 2025 11:02:04 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b5j7dyg88-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 22 Dec 2025 11:02:04 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BM8svEa030236;
 Mon, 22 Dec 2025 11:02:03 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4b66gxnry1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 22 Dec 2025 11:02:03 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5BMB224130278170
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 22 Dec 2025 11:02:02 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 516E15810A;
 Mon, 22 Dec 2025 11:02:02 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B134E58107;
 Mon, 22 Dec 2025 11:01:58 +0000 (GMT)
Received: from [9.43.97.98] (unknown [9.43.97.98])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 22 Dec 2025 11:01:58 +0000 (GMT)
Content-Type: multipart/alternative;
 boundary="------------7P6MHtFg9ayi8KcmkZMwuMXE"
Message-ID: <8ed05d78-f09a-4718-9ed6-ea24d3ca5f57@inux.ibm.com>
Date: Mon, 22 Dec 2025 16:31:57 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/7] hw/ppc: Snapshot support for several ppc devices
To: Caleb Schlossin <calebs@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, npiggin@gmail.com, adityag@linux.ibm.com,
 milesg@linux.ibm.com, alistair@alistair23.me, kowal@linux.ibm.com,
 chalapathi.v@linux.ibm.com, angeloj@linux.ibm.com
References: <20251216151359.418708-1-calebs@linux.ibm.com>
Content-Language: en-US
From: Chalapathi V <chalapathi.v@inux.ibm.com>
In-Reply-To: <20251216151359.418708-1-calebs@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=G8YR0tk5 c=1 sm=1 tr=0 ts=6949252c cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=r77TgQKjGQsHNAKrUKIA:9
 a=VnNF1IyMAAAA:8 a=wHiem6IieiiRUXXAGRcA:9 a=lqcHg5cX4UMA:10 a=QEXdDO2ut3YA:10
 a=ne1qJFFQzzWKJjgbsqMA:9 a=cQ-qXL1PVvI1Su4U:21 a=_W_S_7VecoQA:10
X-Proofpoint-ORIG-GUID: kOhtb2z5oOjQLBsxpHq6jbOcsHvd85DA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIyMDA5OCBTYWx0ZWRfX/CLEmaRMgVpd
 OlxXpf/GM2bOMiU5YjB0SmXEzo3QnoZ5Gz3fWeyAcnPNeD8YMOTP7cXCGiaxEKDXXe4pwTI9/KZ
 87SYQCoT4Q9jvZBF7akYik3E/6Ff3XNu/aVtH3zmWFBGwwoNizJkVl+8dNa9ub4Zip3WuUCJhLh
 etYwPShfOvPGO0lpgcw7PDk4SDsrOkFwmqOCleDNTrgqbWRIUvRpqPwyPrcv5KyeX3hWE/4IJ27
 9l3PXBCdmqOPF6NnLmaD9gJAxzEGuVKiIyTkMkq3J/VJHHrPrLxPbv/kJr5eKMUw34rcFN12qCI
 QGnAS4ks7w6IEtTL+2GIvXYUeAoF5vUNl2pDipCUPZWbtp4+LHPP89Y93WdaNpNKQOnTsDu60IK
 QKDqF/L+hm+V0bluidk5MPk3JGh1rlX2Kd6f7kyriMyUmeI6r5paW30M84ZwgkTJfxf98v1UFiu
 /9D6NZ1htBDaMeqoBmw==
X-Proofpoint-GUID: detX7HnQw3Vvm_iJIzH-o2belNT6AyEq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-21_05,2025-12-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 clxscore=1034 adultscore=0 spamscore=0
 malwarescore=0 impostorscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2512220098
Received-SPF: none client-ip=148.163.158.5;
 envelope-from=chalapathi.v@inux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 22 Dec 2025 08:50:05 -0500
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

This is a multi-part message in MIME format.
--------------7P6MHtFg9ayi8KcmkZMwuMXE
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

For the series:
Reviewed-by: Chalapathi V <chalapathi.v@linux.ibm.com>

<mailto:milesg@linux.ibm.com>Thank You,

Chalapathi


On 16/12/25 8:43 pm, Caleb Schlossin wrote:
> Addressing comments from V2 review:
>
> Updates in V3:
> - pnv_psi: Remove PSI_DEBUG section as it was not used
> - pnv_psi: Add missing post_load and vmstate info
>
> Updates in V2:
> - Added new patch set for PnvPsi support as it fits with the rest
> - Added vmstate support for Power8 and Power9 for LPC
> - Fixed pnv_core.c commit message
>
> Tested:
> passed make check
>
> Thanks,
> Caleb
>
> Michael Kowal (2):
>    hw/ppc: Add VMSTATE information for LPC model
>    hw/ppc: Add VMSTATE information to PnvPsi
>
> Caleb Schlossin (2):
>    hw/ppc: Add pnv_spi vmstate support
>    hw/ppc: Add pnv_i2c vmstate support
>
> Angelo Jaramillo (3):
>    hw/ppc: pnv_adu.c added vmstate support
>    hw/ppc: pnv_core.c add vmstate support
>    hw/ppc: pnv_chiptod.c add vmstate support
>
>   hw/ppc/pnv_adu.c             | 12 +++++++++++
>   hw/ppc/pnv_chiptod.c         | 38 +++++++++++++++++++++++++++++++++
>   hw/ppc/pnv_core.c            | 22 +++++++++++++++++++
>   hw/ppc/pnv_i2c.c             | 11 ++++++++++
>   hw/ppc/pnv_lpc.c             | 41 ++++++++++++++++++++++++++++++++++++
>   hw/ppc/pnv_psi.c             | 36 +++++++++++++++++++++++++++++--
>   hw/ssi/pnv_spi.c             | 27 ++++++++++++++++++++++++
>   include/hw/ppc/pnv_chiptod.h |  2 ++
>   8 files changed, 187 insertions(+), 2 deletions(-)
>
--------------7P6MHtFg9ayi8KcmkZMwuMXE
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p>
    </p>
    <p style="margin:0in;font-family:Calibri;font-size:11.0pt"
      lang="en-US">For the series:<br>
      Reviewed-by:
      Chalapathi V <a href="mailto:milesg@linux.ibm.com">&lt;chalapathi.v@linux.ibm.com&gt;<br>
        <br>
      </a>Thank You,</p>
    <p style="margin:0in;font-family:Calibri;font-size:11.0pt"
      lang="en-US">Chalapathi</p>
    <p style="margin:0in;font-family:Calibri;font-size:11.0pt"
      lang="en-US"><br>
    </p>
    <div class="moz-cite-prefix">On 16/12/25 8:43 pm, Caleb Schlossin
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:20251216151359.418708-1-calebs@linux.ibm.com">
      <pre wrap="" class="moz-quote-pre">Addressing comments from V2 review:

Updates in V3:
- pnv_psi: Remove PSI_DEBUG section as it was not used
- pnv_psi: Add missing post_load and vmstate info

Updates in V2:
- Added new patch set for PnvPsi support as it fits with the rest
- Added vmstate support for Power8 and Power9 for LPC
- Fixed pnv_core.c commit message

Tested:
passed make check

Thanks,
Caleb

Michael Kowal (2):
  hw/ppc: Add VMSTATE information for LPC model
  hw/ppc: Add VMSTATE information to PnvPsi

Caleb Schlossin (2):
  hw/ppc: Add pnv_spi vmstate support
  hw/ppc: Add pnv_i2c vmstate support

Angelo Jaramillo (3):
  hw/ppc: pnv_adu.c added vmstate support
  hw/ppc: pnv_core.c add vmstate support
  hw/ppc: pnv_chiptod.c add vmstate support

 hw/ppc/pnv_adu.c             | 12 +++++++++++
 hw/ppc/pnv_chiptod.c         | 38 +++++++++++++++++++++++++++++++++
 hw/ppc/pnv_core.c            | 22 +++++++++++++++++++
 hw/ppc/pnv_i2c.c             | 11 ++++++++++
 hw/ppc/pnv_lpc.c             | 41 ++++++++++++++++++++++++++++++++++++
 hw/ppc/pnv_psi.c             | 36 +++++++++++++++++++++++++++++--
 hw/ssi/pnv_spi.c             | 27 ++++++++++++++++++++++++
 include/hw/ppc/pnv_chiptod.h |  2 ++
 8 files changed, 187 insertions(+), 2 deletions(-)

</pre>
    </blockquote>
  </body>
</html>

--------------7P6MHtFg9ayi8KcmkZMwuMXE--


