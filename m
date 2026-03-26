Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8951110A1E82
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 11:56:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5jJW-0005BL-M3; Thu, 26 Mar 2026 07:55:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1w5jJU-0005AD-0e; Thu, 26 Mar 2026 07:55:48 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1w5jJS-0005tq-AT; Thu, 26 Mar 2026 07:55:47 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62Q28LqE511489; Thu, 26 Mar 2026 11:55:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=g07LVYIUi04BUfiGNdCjVwQJRgDfsf
 3qP47kIX6viNQ=; b=VZGsFWj/+yLhbqhyNkDL4gZ/OE5Qum6U2N6npdkZdMn8ok
 ny4OvSavyHruz6B/qm6Z1LurnXl81t3HKiTIJ+K7xlE50yOhUDopBb1egxJ08rV1
 GZ3swXyn1odGEvwUL1RFGL8TxKvEG2GAckMQe7XbnywonvINlDN7REMThQTGwog5
 8pvlTKJAorZOz+WtrJptGDCxktjuObLiN8Zk+KB9eiD5orirxpWXj026oZstZ2HX
 FQClD/gJ2ZUe6OTD2uHmdJlRO+XE5stcpFiqrkkzpKUiygrVnJvjHTQ9NdLUmzpF
 8fO7giYVScrgNuTrY9/7Djj6J67nKA41ZKSPFP+w==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kwa51fe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 26 Mar 2026 11:55:29 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62Q809pW012177;
 Thu, 26 Mar 2026 11:55:28 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d27vkaksw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 26 Mar 2026 11:55:28 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62QBtOGP48497132
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 26 Mar 2026 11:55:24 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9A72320043;
 Thu, 26 Mar 2026 11:55:24 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6746320040;
 Thu, 26 Mar 2026 11:55:22 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.123.10.203])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Thu, 26 Mar 2026 11:55:22 +0000 (GMT)
Date: Thu, 26 Mar 2026 17:25:20 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Shivang Upadhyay <shivangu@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, npiggin@gmail.com, milesg@linux.ibm.com,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, qemu-stable@nongnu.org,
 Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH] ppc/pnv: generate dtb after machine initialization is
 complete
Message-ID: <acUeF_LPXihjYkR7@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
References: <20260324135026.247418-1-shivangu@linux.ibm.com>
 <acUTurZoQJf8jRhJ@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
 <CAFEAcA-f+XQPgQ+udz9ts-V51E+jqBHwKpPsh=oArfs1d19wfg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA-f+XQPgQ+udz9ts-V51E+jqBHwKpPsh=oArfs1d19wfg@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: rsicwLSkNYbs8JdgnGGn0l9Vf4pgUFWN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDA4MiBTYWx0ZWRfX7BpcV1v+F76n
 26gJENFP2WKVmpoCTdQ11YLM0wWf8IfvN+7XpN64Ivjbaq59BZhKYjAVZqkaXdnMyUCA++tg5GT
 v1vxRF4tFpNEG1bIVDPwa3HHjbNn688xhnH6uxS2vtLR117Sml2q6mfW2NwZiIJERxrFZ+S57Ry
 JDD0bGoKUVxeXI07HeVjZ1x2d0VXGjGaQM8Jv5NYUuj3+WNC5+QND/naQ8JZ/RUm3iTyeqqy0Gm
 5D1EnwJeHnnV/tYToGDyC1YhndILlgIO2u+2cuT8JQI/Th+z4C8d3eDT8YmcMGSWBjLPYgTNLPh
 PO8V849Y+612qnQmLIosv5WG/wSETKjVO/ht96Fes2TnzXPOPiHr33H8e8NszY83E/OdjbazpSG
 UGV7x7NSyj4wS5Z/K5WOnptuGxnPKsxhb9JvStjgxQnyEyaIyBCUJ5CJ0JVaMwg9dXuGx8Yzgya
 QRCmUJc7BmMK+NKjMcQ==
X-Proofpoint-GUID: F54UaSz7FUu8hkP_Ol4QjeAzmzieihEY
X-Authority-Analysis: v=2.4 cv=OsZCCi/t c=1 sm=1 tr=0 ts=69c51eb2 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=lmEiTuvyoTZ7PBWBH6sA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_02,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 phishscore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603260082
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 26/03/26 11:25AM, Peter Maydell wrote:
> On Thu, 26 Mar 2026 at 11:16, Aditya Gupta <adityag@linux.ibm.com> wrote:
> > But still the dts we have is different from what we should have at
> > pnv_reset. Adding a pnv_dt_create at the end of pnv_reset, as it used to
> > be before, gives me a 'bmc' node also in device tree.
> >
> >         $ diff /tmp/dts.machinedone /tmp/dts.pnvreset
> >         16a17,33
> >         >       bmc {
> >         >
> >         >               sensors {
> >         >                       #size-cells = <0x00>;
> >         >                       #address-cells = <0x01>;
> >         >
> >         >                       sensor@0 {
> >         >                               ipmi-sensor-type = <0x23>;
> >         >                               ipmi-entity-instance = <0x01>;
> >         >                               ipmi-entity-id = <0x23>;
> >         >                               ipmi-sensor-reading-type = <0x6f>;
> >         >                               compatible = "ibm,ipmi-sensor";
> >         >                               reg = <0x00>;
> >         >                       };
> >         >               };
> >         >       };
> >         >
> >
> > This isn't handled at machine_init_done as 'pnv->bmc' is not set at this
> > time
> >
> > Two ways to fix it:
> > 1. Have pnv_dt_create in pnv_reset as well, like previously
> > 2. Move the pnv_bmc_find code in pnv_reset to pnv_init
> >
> > What do you say ?
> 
> My feeling would be that the pnv_bmc_find() handling
> should move to the machine-init-done notifier. (pnv_init()
> would be too early -- the pnv_bmc_find() code is looking
> for a device that has been added via the -device command
> line option, so it won't be there yet in pnv_init().)

thanks! agreed, pnv_bmc_find wouldn't work in pnv_init.
moving it to machine-init-done seems okay. if shivang decides to move
pnv_bmc_find this should be good

- Aditya G


