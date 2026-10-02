Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77068CA5FD4
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 18:29:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xChzh-0007CS-Ft; Fri, 02 Oct 2026 14:28:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1xChze-0007Ba-S7; Fri, 02 Oct 2026 14:28:27 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1xChzd-0003QX-9G; Fri, 02 Oct 2026 14:28:26 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 692H74bR4024881; Fri, 2 Oct 2026 18:28:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=BHn7no
 QXDoCV074o81O78rkRFXg4YHI9PtudVeVtWN0=; b=Suppdvc70NR/v+5G06E0JQ
 +lcszz8qM3UcYnTDccuYNpO2h72zAY/7kfi1C0ce2JyjK1cBY3lvPgJqgYvW2r6k
 jbhvxm8G4JDj+tO/0830InENB4x/pHNkOY/fGeMgaNgEe0ito9RJbdyDC7XreyLG
 4MlC5Fq4qUl8qyCYa8dBEOjtQF8ihDyrLkBmCleVXBpRcs11sb+0HKEBQMDlIDDq
 8UqQIXiDzHl+ZtjS3pVi0QVCCskTXpOmT5l5q/wNdBBvRduQ9rqBqhGrEGZXcTJt
 2NumdyWgpbeS/PCSq+10AA4LQNvICWg0IXGUrn4AhQda0JwoiKc2WMAWJd+oPhDQ
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx4fesedd-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 02 Oct 2026 18:28:19 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 692HHWKR1562150; Fri, 2 Oct 2026 18:28:18 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h0q4pndg7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 02 Oct 2026 18:28:18 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 692ISHIK33620588
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 2 Oct 2026 18:28:18 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A27EE58054;
 Fri,  2 Oct 2026 18:28:17 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8715A5805C;
 Fri,  2 Oct 2026 18:28:16 +0000 (GMT)
Received: from [9.61.92.210] (unknown [9.61.92.210])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  2 Oct 2026 18:28:16 +0000 (GMT)
Message-ID: <a58ad322-bfb3-4ca6-a9fd-098391da4f3b@linux.ibm.com>
Date: Fri, 2 Oct 2026 14:28:15 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 14/16] s390x/pci: Factor ioat sanity checks into a
 separate function
To: Konstantin Shkolnyy <kshk@linux.ibm.com>
Cc: alifm@linux.ibm.com, farman@linux.ibm.com, richard.henderson@linaro.org,
 iii@linux.ibm.com, david@kernel.org, cohuck@redhat.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
References: <20260930145255.140164-1-kshk@linux.ibm.com>
 <20260930145255.140164-15-kshk@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260930145255.140164-15-kshk@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=FYWiV5+6 c=1 sm=1 tr=0 ts=6abff7c3 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=OYmD3GKB3kDPFZGHF4IA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDA3MiBTYWx0ZWRfXyNeu2fUUya0Q
 3ze+fBfY4X6OOicYfJpMFs6fld8eizQo9+EgDRoml5TZyWjcikX/UU/tv59aIw9rqlCPZVn7Ozi
 38ehM8kNQyYbEcBPz5BHQPJseEliO88=
X-Proofpoint-ORIG-GUID: X3fNpyW69K5qstI8npwM-DtNQ_A846jQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDA3MiBTYWx0ZWRfX6aEItQZos/e2
 XWOU/jH61wui0TAxephER2EoYwmokRro1BCRWCzsqe90kUlcG54dnVHFUf5y9i92dFiZj71cVjz
 8v0rsdC0ZOAPApFQPeqGZA2kU2BX7nryrsPJaA/pUrDDM43lZH2Usjaqi0XI5Hd5erwwgLDHyhq
 RiOG5SXKyhpi/cJT0XXwDzlcovZ3MpPNqawvsAYeh6t9vs4njzwWL/4NAwkMSgA8QuHlUINNxUF
 rY+D1WUUHrKqgyujNPyjGvhtbxBu9QeB2p6bla/jGoRjgaY5lXaRSQR+j7cSOvEIciKDUgijs2D
 vU9hfzDghNPSAbwTNaQBj+otuWPrGOJb3XRlyFd9GgY6n1/FgNdU5Bxo6b5sPgvngJiUN6pm4uB
 3ZZ+ER692p81alnG3yS+oXz9hna40jv04IXbTU1z/OERv1hl90KX1VVuTfARjq78tNHooeQ/9p1
 d/7iEuSiEHGuOjICLEA==
X-Proofpoint-GUID: X3fNpyW69K5qstI8npwM-DtNQ_A846jQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_05,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610020072
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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


> -static int reg_ioat(CPUS390XState *env, S390PCIBusDevice *pbdev, ZpciFib fib,
> -                    uintptr_t ra)
> +bool s390_pci_ioat_validate(S390PCIBusDevice *pbdev, uint64_t pba,
> +                             uint64_t pal, uint64_t g_iota, Error **errp)
>  {
> -    uint64_t pba = ldq_be_p(&fib.pba);
> -    uint64_t pal = ldq_be_p(&fib.pal);
> -    uint64_t g_iota = ldq_be_p(&fib.iota);
>      uint8_t dt = (g_iota >> 2) & 0x7;
>      bool t = s390_pci_is_translation_enabled(g_iota);
>  
> -    pba &= ~0xfff;
> -    pal |= 0xfff;
>      if (pba > pal || pba < pbdev->zpci_fn.sdma || pal > pbdev->zpci_fn.edma) {
> -        s390_program_interrupt(env, PGM_OPERAND, ra);
> -        return -EINVAL;
> +        return false;

This will now violate include/qapi/error.h because you're returning
false but not setting errp:

 * - On success, the function should not touch *errp.  On failure, it
 *   should set a new error, e.g. with error_setg(errp, ...), or
 *   propagate an existing one, e.g. with error_propagate(errp, ...).

A simple solution would be to add a new message for this case.

[...]
> +
> +static int reg_ioat(CPUS390XState *env, S390PCIBusDevice *pbdev, ZpciFib fib,
> +                    uintptr_t ra)
> +{
> +    Error *err = NULL;
> +    uint64_t pba = ldq_be_p(&fib.pba);
> +    uint64_t pal = ldq_be_p(&fib.pal);
> +    uint64_t g_iota = ldq_be_p(&fib.iota);
> +    bool t = s390_pci_is_translation_enabled(g_iota);
> +
> +    pba &= ~0xfff;
> +    pal |= 0xfff;
> +
> +    if (!s390_pci_ioat_validate(pbdev, pba, pal, g_iota, &err)) {
> +        if (err) {
> +            qemu_log_mask(LOG_GUEST_ERROR, "%s\n", error_get_pretty(err));
> +            error_free(err);
> +        }

With that change, you won't need the if (err) check anymore.

Thanks,
Matt

