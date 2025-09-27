Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D675CAC5B0
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Sep 2025 13:29:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v2Uya-0008V6-HA; Sat, 27 Sep 2025 09:28:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1v2UyY-0008QU-BL; Sat, 27 Sep 2025 09:28:34 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1v2UyN-0004zs-Uy; Sat, 27 Sep 2025 09:28:33 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58R1W46h025006;
 Sat, 27 Sep 2025 13:28:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=77U7kX
 Ziz2xmbH4efLztBDH/MwkePyteYsjHi7Dbu7k=; b=GATzbSEA8vQu7de/zdWnLe
 w+I4+yCzrUxvE2Rmc5Clpl5Mmg9HB9/79MrJzQZtWzZug73VvpMXbzvtma57nOn0
 O3LpTWSF7bPiDezSUuY7mU90izssDH5MBLd4xEbKvpSmtNO2g2TLyTOShumgot//
 Mk8YeNsRNT/VdwUqaE8h6n/lL7kl+2/kurjebNU5wpnc28so/ulkeoLUmaRO5aVg
 sRCY0XpVyuqS+/2MOzzTS8MeItxh8egCXQp02lYhLLazQFACXBIWW9GgVy6U3y55
 5M/U+iP9x28zsNjUIR9VuRW/PGa03u2N3R8WRx5B8tc9oe07U+efJt3xf/qx86vw
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49e6bh24nm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 27 Sep 2025 13:28:12 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58RDSBek007991;
 Sat, 27 Sep 2025 13:28:11 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49e6bh24nh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 27 Sep 2025 13:28:11 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58RAiXFS030103;
 Sat, 27 Sep 2025 13:28:10 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 49dawmh73r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 27 Sep 2025 13:28:10 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 58RDS6aY50528572
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 27 Sep 2025 13:28:06 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CC7332004E;
 Sat, 27 Sep 2025 13:28:06 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EADBA20040;
 Sat, 27 Sep 2025 13:28:03 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.124.209.231])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Sat, 27 Sep 2025 13:28:03 +0000 (GMT)
Date: Sat, 27 Sep 2025 18:58:02 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Gautam Menghani <gautam@linux.ibm.com>,
 Mike Kowal <kowal@linux.ibm.com>, Miles Glenn <milesg@linux.ibm.com>,
 Ganesh Goudar <ganeshgr@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Subject: Re: [PATCH v10 0/8] Power11 support for QEMU [PowerNV]
Message-ID: <x3of4pakasmckowlhdrg4hk4higevd3pfc3czgm6k4ejnaspn3@w6drtwgrylca>
References: <20250925173049.891406-1-adityag@linux.ibm.com>
 <196e0a04-1241-4500-934b-6966124df485@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <196e0a04-1241-4500-934b-6966124df485@redhat.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Se/6t/Ru c=1 sm=1 tr=0 ts=68d7e66c cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=NEAV23lmAAAA:8 a=p0WdMEafAAAA:8
 a=20KFwNOVAAAA:8 a=Klqv0banK_dW1p5tXGcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=poXaRoVlC6wW9_mwW8W4:22 a=pHzHmUro8NiASowvMSCR:22 a=n87TN5wuljxrRezIQYnT:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAxMCBTYWx0ZWRfXyBk9EGqrZ7vl
 CQYBoG600Yqer/GgtkfXvjsUJFbsjFj3Liejm0Pb3WmEV6L4vhksjEK+fW7Tikr6mnotdpD2nAq
 VXshcnYGCo3j0DjZIRbwWgS1nrQWDYk4Hl85/Du+L9kBt4em4ZGmS2MCJOIPOUPTh6bQHNmyUQ0
 AnhBb+tPZD8p5gDhhETx5s+J/sMIkZSD42Eusl1cRHIQi8GtV8nZvj5Y6x7JrjHvAqX/5VvllPy
 pKowFXAHZr0Hs6ZpqyiZQ5G7hNEqzvi70sdn+rHTSTlyVnl6lmu/FCMKWxKf/XfD29n0NViFnGA
 N6mVpWwrUhYe+akAwXOeKk6pLXpRD2D7IAYmKzDQXShSzpaCgqSl/jxCg1Eqjk+DZfqu3j2HulS
 YmVqsVq90owztjtSBnYlzV29Q1BoDw==
X-Proofpoint-GUID: N9UJRDr1qmP5op1WwWA7-oC9lqqRzT5r
X-Proofpoint-ORIG-GUID: Fp1qYXAkOQDZnSRoWxVtIWADCR9qjMxJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-27_04,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 clxscore=1015 phishscore=0 priorityscore=1501 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270010
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
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

On 25/09/25 11:12PM, Cédric Le Goater wrote:
> On 9/25/25 19:30, Aditya Gupta wrote:
> > Overview
> > ============
> > 
> > Add support for Power11 powernv machine type.
> > 
> > As Power11 core is same as Power10, hence much of the code has been reused
> > from Power10.
> > 
> > Power11 PSeries already added in QEMU in:
> >    commit 273db89bcaf4 ("ppc/pseries: Add Power11 cpu type")
> > 
> > Git Tree for Testing
> > ====================
> > 
> > QEMU: https://github.com/adi-g15-ibm/qemu/tree/p11-powernv-v10
> > 
> > The patches apply cleanly on below commit:
> >    95b9e0d2ade5 ("Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging")
> > 
> > Tests ran:
> > * `make check`
> > * '-M powernv' / '-M powernv10' / '-M powernv11'
> > * '-smp' option tested
> > * 'e1000e' device
> > * tested changing irq affinities to remote chips for xive functionality
> > * compile test with --without-default-devices
> 
> 
> Did you run 'make check-functional' ?

I ran 'make check-functional-ppc64'. Should have mentioned in tests ran.

> 
> 
> This config looks fine :
> 
> Architecture:             ppc64le
>   Byte Order:             Little Endian
> CPU(s):                   16
>   On-line CPU(s) list:    0-15
> Model name:               Power11, altivec supported
>   Model:                  18.0 (pvr 0082 1200)        <-- is that a bug ?

No, it's the PVR is intentionally DD2.0.

>   Thread(s) per core:     4
>   Core(s) per socket:     2
>   Socket(s):              2
>   Frequency boost:        enabled
>   CPU(s) scaling MHz:     64%
>   CPU max MHz:            3800.0000
>   CPU min MHz:            2000.0000
> Caches (sum of all):
>   L1d:                    128 KiB (4 instances)
>   L1i:                    128 KiB (4 instances)
> NUMA:
>   NUMA node(s):           2
>   NUMA node0 CPU(s):      0-7
>   NUMA node1 CPU(s):      8-15
> 
> 
> 
> Tested-by: Cédric Le Goater <clg@redhat.com>

Thanks for all your reviews and the tag Cedric !

- Aditya G

> 
> Thanks,
> 
> C.
> 


