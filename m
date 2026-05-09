Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFB3FCD3445
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2026 14:35:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLil7-0008FL-P5; Sat, 09 May 2026 10:34:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wLil5-0008Ew-Q7; Sat, 09 May 2026 10:34:23 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1wLil4-0006et-3C; Sat, 09 May 2026 10:34:23 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6492w7fg2532617; Sat, 9 May 2026 14:34:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=bzBV14qsZBTSXJJWhq56xkkrkr2f3z
 hneGC1QehrTMs=; b=Kq4gJJKrIui11Ych9siZpyZvZroQTaO7GByrNZ1YgVEEV/
 BszM2xo+5qI3NP1vcSQVdTdde0GRJCHg0eYj6fKam5lNGCMLXdwPI3XUSUd1R6am
 /PerJXRQli78QB79AEFDatzEieZiIGCiCFkIZYAbumy7+g2hRp6OJA8pRW7zQjOg
 Z6KnJsCWLO9WfrzfdCcsrzSZNayK543YWysSzC9pagglxt0MkMaIAjy3GBlG7qik
 CUtP12PFGR2gBPzZvv+d7CaB2vLd8U8pZ5wlTExKDpGzIZockAAX0/XyajYPQppf
 wLJn2AMnxKXNGP9Ilc/KEr/XDE8/mK1/gqPsEHjg==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e1vkqhush-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 09 May 2026 14:34:09 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 649EXK6Y012452;
 Sat, 9 May 2026 14:34:08 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dww3hmse0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 09 May 2026 14:34:08 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 649EY4Nj57868746
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 9 May 2026 14:34:04 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AC43920043;
 Sat,  9 May 2026 14:34:04 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 80F1420040;
 Sat,  9 May 2026 14:33:59 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.39.25.188]) by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Sat,  9 May 2026 14:33:59 +0000 (GMT)
Date: Sat, 9 May 2026 20:03:56 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: Saif Abrar <saif.abrar@linux.vnet.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, clg@kaod.org,
 npiggin@gmail.com, fbarrat@linux.ibm.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com, cohuck@redhat.com, pbonzini@redhat.com,
 thuth@redhat.com, lvivier@redhat.com, danielhb413@gmail.com
Subject: Re: [PATCH v4 1/9] qtest/phb4: Add testbench for PHB4
Message-ID: <af9FJIWPOH5Bej7y@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
References: <20260210134110.1515322-1-saif.abrar@linux.vnet.ibm.com>
 <20260305060923.3753402-1-saif.abrar@linux.vnet.ibm.com>
 <20260305060923.3753402-2-saif.abrar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260305060923.3753402-2-saif.abrar@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA5MDE1MyBTYWx0ZWRfX0ctax6skL1Xc
 O4Bj71XcKOm6dpqcP1AgGcSiFiwa2LYAFz+01AyXNjJ6t2m19Oimo2wujsre31R90p+rt5DOsR/
 UmCYXtYs2NfSeScCVGM+1xzi4O7qv36vuyGSnJ2LaWst7N0E15jjA94JKV7+RW9rhEBRzWS9mU9
 XKZ4eoo/MlYkhW26c/w89BLwmIs4Mm6j447/C73fIcA3ajhU8mOIthFwlkROa3ye00+hxSGZN9M
 phCIQEShSv5HWBG2YsiJcFF399O8i2Ou9VqS3oMnjD26X3EXg6HZGUys2HguNnZyJ6kwrJhycy9
 NfNQ4Jm2Ysp7DCezqDvUwtLfCnIW4SBK4J7sUuCIvy/Xp9HaPiLXCLFwOClOZ7jRZBNDrp+bZxh
 Y1YDGPy2wWI76/ioQ+4BAtXhgLdcSpPmUFxp9db7KaSEJLYegWIMJLA7kXXDRl/0CjTX8Y/TbEN
 CMHSrVRVeRl4hjZ1ftg==
X-Authority-Analysis: v=2.4 cv=OaWoyBTY c=1 sm=1 tr=0 ts=69ff45e1 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=H97nr7XNmJ8aTNrLKxoA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: KzHzXk39OldCYTSl-860LifLujsD64ET
X-Proofpoint-GUID: NEkgFZCJV6gLpMUsNOp3thafoVWoNxWl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-09_04,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 clxscore=1015 bulkscore=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605090153
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

On 26/03/05 12:09AM, Saif Abrar wrote:
> <...snip...>
>
> +#define PHB3_PBCQ_SPCI_ASB_ADDR      0x0
> +#define PHB3_PBCQ_SPCI_ASB_DATA      0x2
> +
> +/* Index of PNV_CHIP_POWER10 in pnv_chips[] within "pnv-xscom.h" */
> +#define PNV_P10_CHIP_INDEX      3

nit: this is unused as of this patch.

rest looks good to me. i had comment about using p11, but noticed none
of the qtest having it, maybe that can be done separately.

Thanks,
- Aditya G


