Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C49D2C5DF81
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 17:53:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyYrT-00063A-EU; Mon, 24 Aug 2026 13:53:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wyYrN-00061z-37; Mon, 24 Aug 2026 13:53:25 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1wyYrK-0004mS-Aq; Mon, 24 Aug 2026 13:53:23 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67OG203c2260810; Mon, 24 Aug 2026 17:53:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=YWBEd5
 R3apMwtEMG4pYSvfGBG5CY9O78fcw8ianKAOo=; b=I4k/ymOsEgZ2j+Qp537Nwt
 8m1L5Q0Vlp4nZe/Dsb7r0ZbGsmATubj2YElzY0e0dmTS4xfz6BOYx4K/p4WsNfwu
 e5sFdtJQf6ZrlCon+1LNBA5eDPtgZNV4uorjsYEfnZcQ1LVvaGiUPVmcSH2DLBuU
 yYIV8mahBebh0EaYMVLKqXzb9fJtQ+CdlwDBx6TBgnzIEdyFIByms197JtSiozve
 L29M4q97Ybi9SeGhMBSS5vvKlyCE3knNKORaSvChKbk36wPazAP1uDj/fY4e4UMG
 fa18b7OpxOi+6LidHEuLvqdIhQSey61XfaAnuTLOu93vqRN5cIV7pjOan16Z2aUw
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g716hkc7s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Aug 2026 17:53:20 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67OHfH6D015254;
 Mon, 24 Aug 2026 17:53:19 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7rag7dkd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Aug 2026 17:53:19 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67OHrG1h8127262
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Aug 2026 17:53:16 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7044358050;
 Mon, 24 Aug 2026 17:53:16 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C9FAE58045;
 Mon, 24 Aug 2026 17:53:15 +0000 (GMT)
Received: from [9.61.26.206] (unknown [9.61.26.206])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 24 Aug 2026 17:53:15 +0000 (GMT)
Message-ID: <51730ac3-ff1f-4eca-98f9-b31b47596185@linux.ibm.com>
Date: Mon, 24 Aug 2026 13:53:10 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/8] hw/s390x/ipl: Fix incorrect PCI IPL block length
 constant
To: jrossi@linux.ibm.com, qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 cohuck@redhat.com, mjrosato@linux.ibm.com
Cc: farman@linux.ibm.com
References: <20260811144629.866641-1-jrossi@linux.ibm.com>
 <20260811144629.866641-3-jrossi@linux.ibm.com>
Content-Language: en-US
From: Zhuoying Cai <zycai@linux.ibm.com>
In-Reply-To: <20260811144629.866641-3-jrossi@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDE0OCBTYWx0ZWRfX4iDzXvSmfzN2
 7LIZZEzOhbcXP4miDSBYmhapdxnPyzisEhWMxDKq1nTi6UwdKZz2bEFDxOFQFUPnWONuRS7wA1w
 bmjjRJIcK89BsrIZM89R0MS0dX6r4EA=
X-Proofpoint-GUID: Azr_3UwqZ_w3lQqLUJlfBcPr2GGc0UuM
X-Proofpoint-ORIG-GUID: Azr_3UwqZ_w3lQqLUJlfBcPr2GGc0UuM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDE0OCBTYWx0ZWRfX1OTtN5wIqZVa
 brMz9Ykm7NfPEsp9rvMI8L4D3d51X+CEnIHx4BPwGChDPYPvs/uM/anc5OS0FNZqXbLgFabQQXS
 gFy8O+q4qIE+hWZybMqfNtM1i3moK33k4NTSTPW+lDGIg7cghGT9C9QOTR8rVp7LbXDkiF5Zy3k
 UWlCHoJ5ZFy5YaDQekYk2Bkz1Cf4JrCZXEwvb4/m2pMZEWn+fQTb/mKI7VHhpxIJw5VKQVJkcSG
 UvJDkht/3kHrjeZA/xJy3qTKPO2BnqRpL+20rUbZC/S959/xX7AbCzjK8iUV93WmYXhTqudhl+M
 BC+ZTMH+GWmte4H+lhZrJz/fV78roidTiKpEGg+e6EOfLOnMluoVleMO5VH5uTByqXimj/a10gJ
 b/I0r/JCU0v08QqTaBrmtP1CZRh6Bv7lMul4cLuqXBkoejgZxjnRvXKKQWUHCIvHFJh5javC0fY
 qTNJiBSQSID1CX1fytQ==
X-Authority-Analysis: v=2.4 cv=H7brBeYi c=1 sm=1 tr=0 ts=6a8c8510 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=FTh_sHrDSB8c7nXAWp8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_05,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240148
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

On 8/11/26 10:46 AM, jrossi@linux.ibm.com wrote:
> From: Jared Rossi <jrossi@linux.ibm.com>
> 
> The IplBlockPci struct is 336 bytes in length.
> 

The commit message is slightly misleading because IplBlockPci itself is
312 bytes in length.

Maybe reword it to something like:
"IplBlockPci is 312 bytes, so the minimum PCI IPLB length is 336 bytes."

Otherwise:
Reviewed-by: Zhuoying Cai <zycai@linux.ibm.com>

> Fix the S390_IPLB_MIN_PCI_LEN to reflect this, and assign a valid blk0_len
> while we are at it.
> 
> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
> ---
>  hw/s390x/ipl.c | 2 ++
>  hw/s390x/ipl.h | 2 +-
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
> index d5fdc3ea0f..fd6e9100f9 100644
> --- a/hw/s390x/ipl.c
> +++ b/hw/s390x/ipl.c
> @@ -526,6 +526,8 @@ static bool s390_build_iplb(DeviceState *dev_st, IplParameterBlock *iplb)
>          switch (devtype) {
>          case PCI_DEVTYPE_VIRTIO:
>              iplb->len = cpu_to_be32(S390_IPLB_MIN_PCI_LEN);
> +            iplb->blk0_len =
> +                cpu_to_be32(S390_IPLB_MIN_PCI_LEN - S390_IPLB_HEADER_LEN);
>              iplb->pbt = S390_IPL_TYPE_PCI;
>              iplb->pci.fid = cpu_to_be32(pbdev->fid);
>              break;
> diff --git a/hw/s390x/ipl.h b/hw/s390x/ipl.h
> index fac30763df..b4d93054a7 100644
> --- a/hw/s390x/ipl.h
> +++ b/hw/s390x/ipl.h
> @@ -107,7 +107,7 @@ QEMU_BUILD_BUG_MSG(offsetof(S390IPLState, iplb) & 3, "alignment of iplb wrong");
>  #define S390_IPLB_MIN_PV_LEN 148
>  #define S390_IPLB_MIN_CCW_LEN 200
>  #define S390_IPLB_MIN_FCP_LEN 384
> -#define S390_IPLB_MIN_PCI_LEN 376
> +#define S390_IPLB_MIN_PCI_LEN 336
>  #define S390_IPLB_MIN_QEMU_SCSI_LEN 200
>  
>  static inline bool iplb_valid_len(IplParameterBlock *iplb)


