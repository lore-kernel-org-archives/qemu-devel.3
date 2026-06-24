Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CF26CDB481
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 13:46:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcNuP-0002CL-Cy; Wed, 24 Jun 2026 09:44:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wcNuH-0001ux-0Y; Wed, 24 Jun 2026 09:44:45 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wcNuE-0002F9-Ml; Wed, 24 Jun 2026 09:44:44 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65OAmI8p717962; Wed, 24 Jun 2026 13:44:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=609Qy2
 QRAh3UT4t+QGWfdWpflVpd5G2N8Ar3eCfS/Co=; b=lj72WA72zF4BHl8gKXU75i
 zGZp5dZu5LorT5VaW0fFq2tYGvOyT8Ijm4X9lT4/tjxm+iDKhZr+cL3RcCThtoi7
 2mUMnUqVlAqE55+JGngGquQC7L5cV67qNzC06ROhunZiD6nYFzGN6jSWCXi2ZqvN
 suQZadBUfCjNsIVCn3oa8HR3RlZ3HVOHRe++K6CzMBdKf34gc07jFVsPyTykKy7q
 0hG1M4XuUv+5YccQFuyCAlELbFwCkkSUvY/hk5z3dX4K9HXVEuvWUweTibud8DWh
 pcjA5UMD/mvykAARBdZgDDuPZHktY9rkpNAPFbxaQ6YiAzpSrwuXnP8nBqsB2AXQ
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjc3mgw3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 24 Jun 2026 13:44:37 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65ODYhVd014807;
 Wed, 24 Jun 2026 13:44:36 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ex6phgsd2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 24 Jun 2026 13:44:36 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65ODiWf049479980
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 24 Jun 2026 13:44:32 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7224F20043;
 Wed, 24 Jun 2026 13:44:32 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 012F620040;
 Wed, 24 Jun 2026 13:44:24 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.39.19.28]) by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Wed, 24 Jun 2026 13:44:23 +0000 (GMT)
Date: Wed, 24 Jun 2026 19:14:20 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: Shivang Upadhyay <shivangu@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Miles Glenn <milesg@linux.ibm.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, devel@lists.libvirt.org,
 Misbah Anjum N <misanjum@linux.ibm.com>,
 Anushree Mathur <anushree.mathur@linux.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 kvm@vger.kernel.org, Gautam Menghani <gautam@linux.ibm.com>,
 Chinmay Rath <rathc@linux.ibm.com>
Subject: Re: [PATCH 3/8] tests/qtest: Add Power11 chip & machine to qtests
Message-ID: <ajvemcUx0k12xOIW@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
References: <20260623141933.577981-1-adityag@linux.ibm.com>
 <20260623141933.577981-4-adityag@linux.ibm.com>
 <54a9b8d16347f6cc94a625aca81897ba6b875385.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <54a9b8d16347f6cc94a625aca81897ba6b875385.camel@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=X4Ni7mTe c=1 sm=1 tr=0 ts=6a3bdf46 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=vGWFop1ilFAJY-VmeoUA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDExMCBTYWx0ZWRfX+4kUqhpMkB7t
 m68FCHOPtNnpfeKAicOlNIiqoA0TPcgsIn063Ij33CM/EVL2D9/0osvor/V6cVxz3yd7X2aucDh
 y4go0kmtLxd6bjYFK3NBGCPl3YJpjv0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDExMCBTYWx0ZWRfX26F8NPrWVCHU
 vWB8eNmTnKEjGtvMTuxFPdJmwvSt1EMCOPi/YiJKpvV1BU5eFNTB+p6CDXYnJDScZlwLSPGOiEh
 AHqarufebHGUrG/SKKuFHlp0bKFQQTsKlKEe7xuaEGVyFZn1A51808x+GRQsDhjq1GsP/qAQbBF
 DSggOUzcHxQdlN42W2yD5ude5mcZQHXf40uCybqhtQiAdWebVWh4I0V2zUZDYE34RAl/sRV2weL
 /eZ+McpC5IG6S1OntEWma12EyDHJEcx/6igVZM7jmeSbAFI5MsJajTjHrX0bUFrL2g9fEq1p1Iq
 bPzRu9O/MS08Dzo/zm6hMSUScireQWt0eeG2T3krFxhtHssiuvzYJXhq8EvdkU6gLvXSBNXlfo8
 xTfviSdbX8zdfhnzqaCg9uA42W27mw==
X-Proofpoint-ORIG-GUID: JVcqIU18sorVx2kxlWkqGHXMIzn6q46g
X-Proofpoint-GUID: dqMh5Dcoww8-0RXr8jcdJ5JfqIoN99BJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 suspectscore=0 spamscore=0 malwarescore=0
 adultscore=0 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2606150000 definitions=main-2606240110
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

On 26/06/23 09:24PM, Shivang Upadhyay wrote:
> On Tue, 2026-06-23 at 19:49 +0530, Aditya Gupta wrote:
> > +static const char *pnv_get_machine_type(enum PnvChipType chip_type)
> > +{
> > +    if (chip_type == PNV_CHIP_POWER8) {
> > +        return "powernv8";
> > +    } else if (chip_type == PNV_CHIP_POWER9) {
> > +        return "powernv9";
> > +    } else if (chip_type == PNV_CHIP_POWER10) {
> > +        return "powernv10";
> > +    } else if (chip_type == PNV_CHIP_POWER11) {
> > +        return "powernv11";
> > +    } else {
> > +        g_assert_not_reached();
> > +    }
> > +}
> 
> How about refactoring to the following?
> 
>     static const char *const machine_types[] = {
>         [PNV_CHIP_POWER8]  = "powernv8",
>         [PNV_CHIP_POWER9]  = "powernv9",
>         [PNV_CHIP_POWER10] = "powernv10",
>         [PNV_CHIP_POWER11] = "powernv11",
>     };
>     return machine_types[x];

Has a subtle difference, that it may not assert/segfault on unknown
value for x, I want the test to crash/fail if this is called with an
unknown/new processor chip. I believe the if-else/switch is better as it
handles (by 'crashing') unknown values too.

- Aditya G

> 
> ~Shivang.

