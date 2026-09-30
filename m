Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84253CA5FC7
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 15:33:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBwIt-0001Ok-Nh; Wed, 30 Sep 2026 11:33:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1xBwIr-0001OR-4M; Wed, 30 Sep 2026 11:33:05 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1xBwIp-0003OB-BW; Wed, 30 Sep 2026 11:33:04 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68UE5QoU3203185; Wed, 30 Sep 2026 15:32:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=03kAhh
 XzuPy6BLsdshkVM+ladkjtll9yJ3j0EW06W34=; b=CGvLJRB8X4Itzw/oCtC5kC
 uVL+Tt1XXcvPXPqDozFE/3bwrQuHNINcRI5qzisrTugjU5BlM2YPRCIkhr/KeFyF
 AIEbV2Lq2MNe5QPsult/lR4dE7Ib69/NloRwo+Bq0men87Pq/kexRpL+1wW063UL
 sR6RPJJY8wDUu+oXwMooa/VRs1Mj00gZf2NlEA2yG5WPyS6esTQn7QiSfSsrMkDz
 qNlNzLDRggWK/1VYjA0JYekPO+YJlron0N0aOJMZWWZt9U79RKF/Ku1F+oCzFg87
 KdoJZ4y7wVil6ryTl/nLtBoCE8K1qdvGk7Dw+JisS4yaDVbwUNwqGz3X2NVkTeZg
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5j5e1by-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 30 Sep 2026 15:32:59 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68UE36am3541465; Wed, 30 Sep 2026 15:32:58 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h0hfpcg7j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 30 Sep 2026 15:32:58 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68UFWvI324969866
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 30 Sep 2026 15:32:57 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2724658062;
 Wed, 30 Sep 2026 15:32:57 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 62E005805F;
 Wed, 30 Sep 2026 15:32:56 +0000 (GMT)
Received: from [9.61.92.210] (unknown [9.61.92.210])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 30 Sep 2026 15:32:56 +0000 (GMT)
Message-ID: <523a3e09-856c-4adb-8134-9a4dc44e16ba@linux.ibm.com>
Date: Wed, 30 Sep 2026 11:32:55 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/2] s390x/pci: Reset a device in error state
To: Farhan Ali <alifm@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: farman@linux.ibm.com, cohuck@redhat.com, alex@shazbot.org, clg@redhat.com
References: <20260922171756.920-1-alifm@linux.ibm.com>
 <20260922171756.920-3-alifm@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260922171756.920-3-alifm@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA2MCBTYWx0ZWRfX8quCDz4slcFh
 pbBZ/iy1v/cCFK5HruVnW3YEtbzsQkolO4Cz8mhIwZFtZRGo3NvpkWMnLmCv7mpnZ5M4AZulgRa
 mkBrzPjkKofFNxI8BnLWAaQJCjN+RUk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA2MCBTYWx0ZWRfXxjKBQv5GJIRB
 NvTFcqsiAa2KiuPXuyV1zthM015kr0vXCHUSAJrhWSArKmb/TgvOrsB00bglynkuJniXWbtByEg
 Oe3AVIiEq0IIYeNk3XcqhHGdpnDAQOwpssO5e48YT9fq7CKuqYCvR/KqKCVY3eXJa4vo+nbOpPD
 vGEB4z1/l6FfgoGwn3sO2FIYfm1Thtps3CDcXiLw6gmVcK766l9ASd4a52IwqUoT2Q0gWCtwYkd
 y/36Q+jdHyNTn0eJmIeQCFq/4LBtq1+KcbB/c3ICrBHAqlD/jT2St6RG0dYpkIJJIg95q+z1/zu
 ipHonSiyzcGUN7OVvJcm/8HjOhjFezdhjGAyKTNTcF5ol92xFoLEi023FaqE4I3CN+XL5Vfr44h
 4/71NivSQ+IWnBBbRJSacDg/fAOkNkFg6+q2h3g3zT8fdTFCzRRerloYCHDXNjCgHPxcVX3iwGm
 QI/c9bB8xRWwenM4OfA==
X-Proofpoint-GUID: z7H6OrMarOvGwlklOqrzcsQZU5xU3DED
X-Authority-Analysis: v=2.4 cv=RKcmjIi+ c=1 sm=1 tr=0 ts=6abd2bab cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=aKqPpTAkTjwgDZUcLcQA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: z7H6OrMarOvGwlklOqrzcsQZU5xU3DED
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0
 adultscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300060
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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


> --- a/hw/s390x/s390-pci-bus.c
> +++ b/hw/s390x/s390-pci-bus.c
> @@ -1505,6 +1505,8 @@ static void s390_pci_device_reset(DeviceState *dev)
>          return;
>      case ZPCI_FS_STANDBY:
>          break;
> +    case ZPCI_FS_ERROR:
> +        break;
>      default:
>          pbdev->fh &= ~FH_MASK_ENABLE;
>          pbdev->state = ZPCI_FS_DISABLED;
> @@ -1517,6 +1519,11 @@ static void s390_pci_device_reset(DeviceState *dev)
>      } else if (pbdev->summary_ind) {
>          pci_dereg_irqs(pbdev);
>      }
> +
> +    if (pbdev->state == ZPCI_FS_ERROR) {
> +        s390_pci_reset(pbdev);
> +    }

I know it was mentioned in the prior version, so apologies for not
chiming in til now.  But you really need a comment block explaining why
it's OK to reset the device yet leave it in the ZPCI_FS_ERROR state
after the fact.  That's confusing.

You mentioned in the last version it's because this happens on the
disable path, and there yes we will set the device to ZPCI_FS_DISABLED
right after this -- but what about any other case where we drive this
reset path (e.g. subsystem reset, reboot, and the ISM-specific extra paths)

Note that the non-error cases are ensuring we either leave this function
with the device listed as disabled or standby/reserved.

Would there be harm in, after performing the reset, doing
pbdev->fh &= ~FH_MASK_ENABLE;
pbdev->state = ZPCI_FS_DISABLED;
for the ZPCI_FS_ERROR case now?

Consider that:
1) For a guest-initiated disable, we already checked those were valid
before reaching this point.
2) For all other reset cases, if the device were not in
error/reserved/standby we were leaving here with the device disabled
before this patch.  If the device happened to be in error, now you fix
it up but isn't the proper fix state now 'disabled' to match what an
enabled device would have been?

Thanks,
Matt

