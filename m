Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 108E9C79FB6
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2026 12:44:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5N5h-0005Gs-Q8; Sat, 12 Sep 2026 08:44:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1x5N5g-0005Gg-CR; Sat, 12 Sep 2026 08:44:20 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1x5N5e-00038O-Ni; Sat, 12 Sep 2026 08:44:20 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68CC1d1N341543; Sat, 12 Sep 2026 12:44:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=vUY2SOGHUCz44owY28ksN46Oqw9IaV
 xbPbZ4vEm2Kxc=; b=MxjRBqYQNBKMUtdgrNrpDierivVEDBODMu/Us91uxU348d
 fKEACz01LMmUW23W5ItQ769peK0KLgZFMMO9NyVQkzhJ8JtY7o6EkpZ3DVtYZ5lj
 Xtvj9OL78lnVllF57QEDCCeX5nUDeBIPaorY/d2hie9kst98fyi7jPK380R7PrWg
 xYwdaPFsNGqgFdHlxfxlqM0QfHum4Oj7iPXEVH9af7btWnYqNOz+PzGqoHH74QT3
 4URld9fjfwpFmu2mknEju59CYWz+lP1DpSmBZMSMtTi/jOZLKDXr1tWkiGHuYhJa
 GWX3rR2kliBxLMhrT6W5KoSrVvO647SqRZYtwXNw==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmv5h9muf-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Sat, 12 Sep 2026 12:44:07 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68CBbNuu3229694; Sat, 12 Sep 2026 12:44:06 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gkvwkb3a9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 12 Sep 2026 12:44:06 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68CCi2mE48628050
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 12 Sep 2026 12:44:02 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 719EE20043;
 Sat, 12 Sep 2026 12:44:02 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BD61F20040;
 Sat, 12 Sep 2026 12:43:57 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.87.143.209])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Sat, 12 Sep 2026 12:43:57 +0000 (GMT)
Date: Sat, 12 Sep 2026 18:13:55 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: Saif Abrar <saif.abrar@linux.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, harshpb@linux.ibm.com,
 clg@kaod.org, npiggin@gmail.com, fbarrat@linux.ibm.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com, cohuck@redhat.com, pbonzini@redhat.com,
 thuth@redhat.com, lvivier@redhat.com, danielhb413@gmail.com,
 kowal@linux.ibm.com, chalapathi.v@linux.ibm.com, calebs@linux.ibm.com,
 milesg@linux.ibm.com, jishnuvw@linux.ibm.com, amachhiw@linux.ibm.com
Subject: Re: [PATCH v6 0/9] pnv/phb5: Update PHB4 to the latest PHB5 spec
Message-ID: <aqVIdRcqvKTxCWsH@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
References: <20260831123005.1485518-1-saif.abrar@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831123005.1485518-1-saif.abrar@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEyMDE4MSBTYWx0ZWRfX8elkAmLK/uJT
 YC1NrQr6h/yyzbcCL2ulOkiC8chfBELsP+fVg18AHowMZm7GHfbKutwDbpJGBfkU28AROod1Qg4
 g8+WA9fmkjENW0MqEC4DBLuFDf8V3AX9FN6SrrWzDlQu38wS1t7cquQrdiFLUXU1Frh5pdCBFuH
 s0/FvRbD+0MfeoAMijJLTNS2DuoTGrZnPv6OwojtcbHrAyXMFUJIABadCg2GETtYap+aWdupsnE
 +bzgJ37PNbXOOui8jk/HVxg9kpo0poy7G7DLmu+zXpKYi/+OhHDog24879SvSPvN9dJAIQGum8D
 zeBBJeSmSAZZSw0kdiZzUaR3IP6OLEIsipqcHoAOBiCNs59dE+HvnW31I7q/O/JnB/G5JV2ae5a
 Qu9RHniPwguoVkNzMBjbAX+oB3gwb685ZBtM1GXOvWyrQ++HRvTd4aYjLJNqZUHy7b9RjBwVzxL
 L4eHfRWfmcfzEm3zwrQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEyMDE4MSBTYWx0ZWRfX2SkKvGh5jBcn
 JH3x3qRX2TPhzQayVc+1irMSeJe+tUJKQDAMT7z8lMvhZ8qM3oIsMQFwxeA82M/H91R01DvEI+b
 KyY1onEk/IgTTOCQHshtb0swi5PX+8M=
X-Authority-Analysis: v=2.4 cv=Zsx4uN7G c=1 sm=1 tr=0 ts=6aa54919 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=p_D0MeX6N1AXP1W3KKcA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: vIZbxENH6iZJ1SbaOC4yBA4rYCUQW80g
X-Proofpoint-GUID: TsyAEADYKbIDBat0t2lv1kRTtmea58zp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-12_04,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609120181
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
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

On 26/08/31 07:29AM, Saif Abrar wrote:
> Hello,
> This patchset resolves the review comments for v5:
> https://lore.kernel.org/qemu-devel/20260617095058.652789-1-saif.abrar@linux.ibm.com/
> 
> Major updates include the following:
> - Separate reset and register read/write methods for PHB5.
> - PHB4 and PHB5 specific reset values.
> - Read/write logic for registers added and removed in PHB5.
> - General cleanups.
> 
> Tested with 'make check' and 'make check-functional-ppc64'.

Thanks for the patchset Saif ! Helps cleanup as well as add phb5
functionality nicely.

I was on vacation for past 2 weeks, couldn't review then.

With the minor non-code comments in patch #1, 2 and 6 fixed, the patch
series looks good to me !

Feel free to retain the rb:
Reviewed-by: Aditya Gupta <adityag@linux.ibm.com>

Thanks,
- Aditya G


