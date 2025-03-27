Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EC60C3600B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Mar 2025 18:28:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txrx9-0001sU-2h; Thu, 27 Mar 2025 14:27:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1txrx7-0001sD-D1; Thu, 27 Mar 2025 14:27:41 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1txrx4-00047c-TJ; Thu, 27 Mar 2025 14:27:41 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52RCSIGI000593;
 Thu, 27 Mar 2025 18:27:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=GGMzb3
 lJiuuKxzzkxjmkZd58BsBqO+LnaNCIkYL6ZJE=; b=oh0Qnk26w1Swup0dQOlOzD
 kuZ89kf3wToOEA9FcYozqheCFMwjB2JRut5VVfUpT24IKdUBwPeOE1AW1n5wIbqP
 w0biT/jKkkNWclvXU+FzF5A5KN4zpLVrlypcwxjG8Saka1QIxcYaE8DyE6A/EW6K
 DFOkb8K7V9Q996+e3KIVQJ86a1cDvvluddQSaKwaDPJtbvnHtrJ9dgSAnLKi67LQ
 rWh6IEzah8RgU9Vt+C34GxUbqpo/inZ8GdEgAk+opQWD338h1SK2695co8gBO7np
 WRBWWKyxFyzM58A0zm08Lu5ZpkCeW/12hNEo0U2dBcuy19IQW8LNdByJdo3e2bPw
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45n6q2a478-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Mar 2025 18:27:32 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52RIQtWW009966;
 Thu, 27 Mar 2025 18:27:32 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45n6q2a476-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Mar 2025 18:27:32 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52RH0ud3009694;
 Thu, 27 Mar 2025 18:27:31 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 45j9rkxfdm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Mar 2025 18:27:31 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 52RIRRDU42140000
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 27 Mar 2025 18:27:27 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 826F12004F;
 Thu, 27 Mar 2025 18:27:27 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6000A20043;
 Thu, 27 Mar 2025 18:27:25 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.124.214.220])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Thu, 27 Mar 2025 18:27:25 +0000 (GMT)
Date: Thu, 27 Mar 2025 23:57:17 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?utf-8?B?RnLDqWTDqXJpYw==?= Barrat <fbarrat@linux.ibm.com>,
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Subject: Re: [PATCH v6 07/10] ppc/pnv: Introduce Power11 PowerNV machine
Message-ID: <d6tnw62l274b6sa3oh7fvw7wzqqewgci4pjqll6uu3g75h5is6@rlnypq2fpisr>
References: <20250325112319.927190-1-adityag@linux.ibm.com>
 <20250325112319.927190-8-adityag@linux.ibm.com>
 <952b3afa-dc63-4230-bdff-5decabc8c25c@kaod.org>
 <8567b41e-f2b8-413c-93b8-15c74788c171@linux.ibm.com>
 <5a08e139-a18d-4aae-836f-0ec0bb8fadc9@kaod.org>
 <6d610966-cdc0-42c2-abb8-e80b4be1178d@linux.ibm.com>
 <6e830dd1-88c1-4029-bae7-d2817d95262f@kaod.org>
 <4ef14a73-576b-47c1-b1c0-bc7b234fac87@linux.ibm.com>
 <d9f75038-5a29-4216-b363-cf467a28edb4@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d9f75038-5a29-4216-b363-cf467a28edb4@kaod.org>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 2vlNPZT9Gtcy0WA_UpSXTPKj3qWiYQGQ
X-Proofpoint-GUID: 8NhrHuITHPHefDhV5zmVn0ogrr6ZGyiB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-27_03,2025-03-26_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=846
 priorityscore=1501 lowpriorityscore=0 spamscore=0 phishscore=0
 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 impostorscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2502280000 definitions=main-2503270126
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 25/03/26 11:09PM, Cédric Le Goater wrote:
> On 3/26/25 18:21, Aditya Gupta wrote:
> > On 26/03/25 13:39, Cédric Le Goater wrote:
> > 
> > > On 3/25/25 18:38, Aditya Gupta wrote:
> > > > <...snip...>
> > > > 
> > > > On 25/03/25 22:45, Cédric Le Goater wrote:
> > > > > One nice about it IIRC was being able to tune the number of
> > > > > PHBs per chip, which reduced booting time (for 16s) and also
> > > > > provided support to test various chip configs. Check that first.
> > > > > 
> > > > I tried some variations of 'device_add/device_del'. Unable to see how to dynamically add/remove phbs.
> > > 
> > > I don't think hotplug works, this would require FW support, only
> > > coldplug is supported : devices should be defined on the command
> > > line.
> > 
> > 
> > Got it. Thanks for mentioning this, found a bug in my patch:
> > 
> > 
> >      $ ./build/qemu-system-ppc64 -nographic -M powernv11 -nodefaults -serial mon:stdio -device pnv-phb -device pnv-phb-root-port
> >      <$QEMU_DIR>/include/hw/ppc/pnv_chip.h:110:PNV10_CHIP: Object 0x564afddb5e00 is not an instance of type pnv10-chip
> >      [1]    1253963 IOT instruction (core dumped) ./build/qemu-system-ppc64 -nographic -M powernv11 -nodefaults -serial -devic
> > 
> > Happens due to 'pnv_pec_add_phb' assuming phb5 to be related to pnv10:
> > 
> > 
> >      if (phb->version == 4) {
> >          Pnv9Chip *chip9 = PNV9_CHIP(chip);
> > 
> >          pecs = chip9->pecs;
> >      } else if (phb->version == 5) {
> >          Pnv10Chip *chip10 = PNV10_CHIP(chip);
> > 
> >          pecs = chip10->pecs;
> >      }
> > 
> > 
> > Top of my mind, hacky ways come up to differentiate Pnv11Chip and Pnv10Chip, other (still hacky) might be to add "pecs" as a property to the chip objects and get it that way, still feels hacky.
> > 
> 
> The pnv-phb and pnv-phb-root-port devices introduced too much
> complexity for an unused feature. It is time to step back and
> deprecate.
> 
> The segfault on P11 should be fixed. Failing gracefully is OK.

Sure Cedric, for now I have removed the dynamic phbs in powernv11, so it
fails like this:

    ./build/qemu-system-ppc64 -nographic -M powernv11 -nodefaults -serial mon:stdio -device pnv-phb -device pnv-phb-root-port
    qemu-system-ppc64: -device pnv-phb: Parameter 'driver' expects a dynamic sysbus device type for the machine

Regarding deprecating for p10, don't know, as you said it gave benefits
in power10 bringup, maybe since it's working for power10 it might keep
it. I haven't personally needed it though.

Thanks,
- Aditya Gupta

> 
> Thanks,
> 
> C.
> 
> 
> 
> 
> 
> > Can't pass extra args (pecs) to the function, without handling this pnv10 vs pnv11 in the callers.
> > 
> > 
> > Is adding a callback to PnvChipClass->get_pecs a good idea, similar to xive callbacks on the chipclass ?
> > 
> > Will think of alternate ways. Thanks.
> > 
> > 
> > > 
> > > > 
> > > > Do you have any options to device_add/del which I can try, I want to see if the dynamic addition/removal of PHB changes if i remove that '_allow_dynamic_sysbus_dev' call.
> > > > 
> > > > 
> > > > > Also, you should add functional tests for the powernv11 machine.
> > > > > 
> > > > > See under tests/functional/test_ppc64_powernv.py.
> > > > > 
> > > > Currently the test uses op-build kernels, which don't support Power11, working on that side, will post as soon as op-build creates a new release with p11 support (any linux >= 6.9).
> > > 
> > > And is that planned ? I doubt it since open-power boxes are out
> > > of business.
> > > 
> > > You could use a buildroot image instead. :
> > > 
> > > https://github.com/buildroot/buildroot/blob/master/configs/qemu_ppc64le_powernv8_defconfig
> > > 
> > I was thinking there should be. I will ask.
> > 
> > 
> > Thanks,
> > 
> > - Aditya Gupta
> > 
> > > Thanks,
> > > 
> > > C.
> > > 
> 

