Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18E65CA5FF5
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 20:38:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDpSF-0005iu-8h; Mon, 05 Oct 2026 16:38:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1xDpSC-0005iI-MA; Mon, 05 Oct 2026 16:38:32 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1xDpSB-0005qK-4q; Mon, 05 Oct 2026 16:38:32 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 695HZPqT1339401; Mon, 5 Oct 2026 20:38:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=2gkMR0
 FIIBk0qvsc9mYnUsjtMvziGycBnTIP3VVyVPU=; b=DZKSafi1ClpBOKTkeBZVrb
 whx2cNpjB+6gmHCq13h4h7RCkg016mG0QSbJlSoCR3IO78GlnlDu/fZjbqxU18fa
 hLBTEdD/2BqSva6b7G1I9DtJlPTXOVbHnLXttBTMpaqYAX39RQrHSi83oZaoCHcW
 ygp4HNY+EkE51TbADXjo/DNRmcy8OmjEtO1f4nN/P8m2TwR2+LTX5aCs9+ZRPQUX
 toT9UTIkaAw9Hts9fhr7kO3FU5Z/1O+gTvDEFoBK2RvjNfm8Cr8+03+CJ4HWnMdb
 QDea09Q9W++l/nYLI1wPgzRvoRUeQlWZTPbGr9u1nhP54TlAjRmVdWet0bnjG4SQ
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2s74mey1-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 05 Oct 2026 20:38:28 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 695HMbuf3280917; Mon, 5 Oct 2026 20:38:28 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h3dhgq0np-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 05 Oct 2026 20:38:28 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 695KcQ3d41026090
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 5 Oct 2026 20:38:26 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8B0215805C;
 Mon,  5 Oct 2026 20:38:26 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 10D785805A;
 Mon,  5 Oct 2026 20:38:26 +0000 (GMT)
Received: from [9.61.15.56] (unknown [9.61.15.56])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  5 Oct 2026 20:38:25 +0000 (GMT)
Message-ID: <5d03e50e-4e53-4640-bb13-68733d978a6e@linux.ibm.com>
Date: Mon, 5 Oct 2026 16:38:25 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/2] s390x/pci: Reset a device in error state
To: Farhan Ali <alifm@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: farman@linux.ibm.com, cohuck@redhat.com, alex@shazbot.org, clg@redhat.com
References: <20261005174314.871-1-alifm@linux.ibm.com>
 <20261005174314.871-3-alifm@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20261005174314.871-3-alifm@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: _tQ3JqkbQuvuqzALvDgNWEoBm7vDpEFP
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA4MSBTYWx0ZWRfX+U4M4NQP7yAz
 n4OWnqB7eqqg6zXfqLnB5H+/jTvSmw31axX1KTMkNdHhUHd/kDx5QzuCwJXWxKz8VrxKIiu/q7F
 HVbYup8y2FMivJ8tsQxnuBRQVF6XxIk=
X-Proofpoint-GUID: _tQ3JqkbQuvuqzALvDgNWEoBm7vDpEFP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA4MSBTYWx0ZWRfX/U2LJpNuDAxG
 xqVdk/b3dkoLGEKwZhnPSe/dwd60hxWEkoG7pPlzYMsRxzPC6qBjHQtEEEkFqCZtVDIlUkA4hso
 IjRc53rAJW/xBHo9dUsoyoHjJakpY2fCM2Mc7SbgZ4Z/QWceWW6fxZANHCep0ccnlF/Gn81rGsF
 SIb6RZ4atNywuV/H2LwR4yVMB0e/mjlU+JPPJV9/NzC4d2DbrzsEHo46vLIM9eUGfaeyM+lnsRu
 1l3bap3ii0JhMSUVV53N5UCxx6vuoWsWSQOfM17JtCVrJ0OTRdcoFEWoV9DodkUlkJSxIxPc8kI
 QXWZD8dbpZYM4wuHIYtcN1LaUkwZ5czAxErv+0JdlSVR0wkE6cVO753UUio3c7SSPNbEBoclmqe
 kVIpAi4Yyz20Dahr12IuZ1iy1EfUipJ7Q1dxBml+Lzizpdv2p9/eEUykm0M9AoC/ypKT0FCCCdm
 cH80CJKBh/WGFP68Y2g==
X-Authority-Analysis: v=2.4 cv=fM2sTpae c=1 sm=1 tr=0 ts=6ac40ac5 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=Tm8Z0uH1JAIsG0wHSzQA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
 a=zZCYzV9kfG8A:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_05,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050081
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

On 10/5/26 1:43 PM, Farhan Ali wrote:
> For passthrough devices in error state, for a guest driven reset of the
> device we can attempt a reset to recover the device. A reset of the device
> will trigger a CLP disable/enable cycle on the host to bring the device
> into a recovered state.
> 
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>



