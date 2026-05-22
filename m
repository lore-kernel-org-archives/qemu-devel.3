Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 531BECD5BB3
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 18:51:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQUxU-0007hm-6g; Fri, 22 May 2026 14:50:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wQUxO-0007gR-Ld; Fri, 22 May 2026 14:50:50 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wQUxN-0005PT-3H; Fri, 22 May 2026 14:50:50 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64MAxIXo610903; Fri, 22 May 2026 18:50:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=6/og/X
 FTwZMueepvS1t7xR9pUfZSLbmBttetJcg26P4=; b=dutS5fhJY2fvSliYI8UMs9
 oxbBXTQ+vCwGlyIYTdwpynaySPri3MZPQsBmReIka0JWKeoKh6XjpgXHRp3YKO2r
 4gyxOOeAUivreTB2IWjWH1UvKtp7FK7ZYmdAjllIsShItzTsZw7y/LIqlvJrBsNb
 Se2seoH5XKGljlRh3NG28AMtjh5fSDYBbPRKOHa3hcB2MsC+WY+b2f1qWPW5xKoT
 o+0AwZ5fT/hdj+WGn+T9H487JQbVWHH+3e0PStWGiQa2Fyiu4YYrt2LjLb9K3nrS
 hhquZ3G+jYILRq00IeICQlsJwiOP8bqZizJaNl8i4I7T2f/LU1kkIr9ITScxOxpg
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6hb8uv3e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 22 May 2026 18:50:46 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64MId4mY028682;
 Fri, 22 May 2026 18:50:45 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e739wac78-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 22 May 2026 18:50:45 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 64MIoiw431982204
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 22 May 2026 18:50:44 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1CE4458043;
 Fri, 22 May 2026 18:50:44 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3F3EB5805F;
 Fri, 22 May 2026 18:50:43 +0000 (GMT)
Received: from [9.61.48.218] (unknown [9.61.48.218])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 22 May 2026 18:50:43 +0000 (GMT)
Message-ID: <5b276d9b-9322-4c5e-81f0-906505bc73bd@linux.ibm.com>
Date: Fri, 22 May 2026 14:50:42 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] s390x/pci: Fix interrupt forwarding disable for
 interpreted devices
To: Farhan Ali <alifm@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: farman@linux.ibm.com, cohuck@redhat.com, qemu-stable@nongnu.org,
 Niklas Schnelle <schnelle@linux.ibm.com>
References: <20260521182946.1607-1-alifm@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260521182946.1607-1-alifm@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDE4NSBTYWx0ZWRfXzr/hbcsxAKwp
 5aGlGMq9LA1e1zmO4lTGPgxTA6aILHSo3PxTxhtc+Lb8n1zIVhRkPhoUg43Sz3IcyQKNNglGxQC
 ahJDJc3jD6qEOohAvkzMg7JnCyMlRwdFQRlAt3GT2ZLX8cwOjgaL8xUKVXLQDQXBsqU68mRfhoC
 NviY7JdvFKhHULEOMZeIq07CL+Fpg88xdw30eDofV8qjmdmevhKLNqEKJZo1JNY7slTolbzBOIr
 3G3qBx64rorxIyepROeZtCGHLJtooqSRK+rQMQ/YjgTNMQwFSfyXG+JcdqlNpJOpbtiePkEiFRg
 gteZUeZSpz/mEpoPmwnnqCpXLphNFybI+U08VgI8WtQvFvktoVvFzqV0iYG/H4drSa0ImOWk0Z/
 7JtdeZJG2z/p160YERZsqeOxlqxoIawnmLnndKAD7/iAd36DSAis88mtlxrPk9siT2HrOOHmRtx
 HkMJU4H0jNVkQwMQ6mw==
X-Proofpoint-GUID: RbARRzSJa_IERIgx2YP_rIh2zYdhQKEB
X-Proofpoint-ORIG-GUID: RbARRzSJa_IERIgx2YP_rIh2zYdhQKEB
X-Authority-Analysis: v=2.4 cv=aYBRWxot c=1 sm=1 tr=0 ts=6a10a586 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=69wJf7TsAAAA:8
 a=VnNF1IyMAAAA:8 a=mwfT7ZPovA2SVNklJ4IA:9 a=QEXdDO2ut3YA:10
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_05,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1011 spamscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220185
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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

On 5/21/26 2:29 PM, Farhan Ali wrote:
> Remove the FH_MASK_ENABLE check when disabling interrupt forwarding
> during device reset. This check was broken for the default case in
> the switch statement above, preventing proper cleanup of interrupt
> forwarding.
> 
> The pbdev->aif check in s390_pci_kvm_aif_disable() already guards
> against double-disabling of interrupt forwarding.
> 
> Cc: qemu-stable@nongnu.org
> Reported-by: Niklas Schnelle <schnelle@linux.ibm.com>
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>

Thanks Farhan (and Omar for testing).

This issue was exposed by recent changes to the kernel but both the
initial implementation of AIF + the attempts at avoiding duplicate
registration failed to catch this case, which we can now encounter
easily with the new code in the guest kernel.

The goal of the enabled function handle check here was intended to
avoid double-deregistration, but in fact we can get here when the
function handle is already disabled but AIF was never cleaned up in
response to guest activity (e.g. guest is not required to issue the
corresponding MPCIFC to clean it up).

Prior to the introduction of pbdev->aif, this check did help
prevent instances of double-deregistration but was not sufficient
to also catch the case where the function was already disabled but
AIF was never cleaned up.  So I think it's been broken from the
beginning (d0bc7091c2) but it was not safe to remove this check until
we introduced pbdev->aif (07b2c8e034), which allows us to reliably tell
whether or not aif cleanup still needs to happen during reset.

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>

> ---
>  hw/s390x/s390-pci-bus.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
> index 3665aba106..2f7b214891 100644
> --- a/hw/s390x/s390-pci-bus.c
> +++ b/hw/s390x/s390-pci-bus.c
> @@ -1542,7 +1542,7 @@ static void s390_pci_device_reset(DeviceState *dev)
>          break;
>      }
>  
> -    if (pbdev->interp && (pbdev->fh & FH_MASK_ENABLE)) {
> +    if (pbdev->interp) {
>          /* Interpreted devices were using interrupt forwarding */
>          s390_pci_kvm_aif_disable(pbdev);
>      } else if (pbdev->summary_ind) {


