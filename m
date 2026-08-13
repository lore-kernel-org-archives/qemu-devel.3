Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C9B7C5B572
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 16:03:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuXtP-0003TY-QM; Thu, 13 Aug 2026 12:02:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nikhilks@linux.ibm.com>)
 id 1wuXtM-0003IY-NN
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 12:02:53 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nikhilks@linux.ibm.com>)
 id 1wuXtJ-0004u3-Lk
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 12:02:51 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67DFXAp42642019
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 16:02:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=sclMDQ
 L0KaKiLchKWvf6jI9R4l0THet36G61B0Ip9II=; b=RIa/RWX9/ojNxSJtZUUXdf
 WjGrWpnBEYLC1A/GAhBD/6ZvgXB1a2cMyygCfLeAQaSMwHRD5myaxubLAlUO8A5D
 HXuBvcc9ja1PRbvjJ1h5eIezrpDOXe5NXN+vwxRTOvQ2pSe/g6ZsgQIM1kp/cXU5
 rdKRZcCrnhMLpgy8Smj0Lmb7auvtgRW7D1Spyw3/mdhPN4u1KoqJgSG42YV8P+uG
 I0TwauHQkFwl7F7Qz3zwmqfTZN0DxciLvFGSywuxM9OJgV/tNw0Dy4wS1tggL81U
 q5kK1zW/gGOKohodD87vrEcbHnFWTXy35aW1KC0WTyN3ukCUImdhgyo2VhYTyx5w
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvp37qcw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 16:02:45 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67DFuJPo025560
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 16:02:44 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxg9hbk72-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 16:02:44 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67DG2ghb41156914
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 16:02:42 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 729EF2004D
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 16:02:42 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E9AC520043
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 16:02:41 +0000 (GMT)
Received: from [9.43.103.247] (unknown [9.43.103.247])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 16:02:41 +0000 (GMT)
Message-ID: <874321f1-05fa-43b3-916a-adf7e9a6bf5f@linux.ibm.com>
Date: Thu, 13 Aug 2026 21:32:22 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/6] ppc/spapr: Add VFIO EEH error injection backend
To: qemu-devel@nongnu.org
References: <20260520095446.64206-1-nnmlinux@linux.ibm.com>
 <20260520095446.64206-2-nnmlinux@linux.ibm.com>
Content-Language: en-US
From: Nikhil Kumar Singh <nikhilks@linux.ibm.com>
In-Reply-To: <20260520095446.64206-2-nnmlinux@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=AMtp2X5w c=1 sm=1 tr=0 ts=6a7deaa5 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=z27-1JofBHpxt0W0GYAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: gaBv6Jrbz0JPerNaLIwlknUIPq2IK2lf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDExNSBTYWx0ZWRfXwB8nDIQHkBUz
 eqK/FHSmi/maxCYTzOWsY7CD/GvO8DST68FaivBp3Xm9E/wxIwAOpiOC80gCUOGzH7OEBNCFLep
 Q4cXZtmR+uZQ795cyvOaIO5Yo9GndLbSMoXFOiuQtasGVRfmyu3ZIbFsC6WNZT2fmlOTm9yTO78
 1fCWWTcpWFBrFzPIUagNRFEoe27faKQFuCApp+p6AL+4P2zzWW4fA8qC3ShCFxKRju38Ov3Zgl8
 yMjTmHj9sD2v54ImlBvojVUuYFQ15VJYvCpHodviwNRwjlm5fQoSVwbWfEw9EabH+1WmM0S98JT
 ACNpBBmt3XMYbKcBHv4joGCcrXmcbiMUwWEPz0GQ3VvTx61/3wbi3kKdwBhzN2gZ95HhRdg7VtA
 7jSVjE2O4qD3szlrRDLOK5KEji4avoyghmUrT41okc7cn1u3zSkhuu8YxEVBQk5g8CicLTnA/di
 lZVt4SIlupJ+Vg5cPTw==
X-Proofpoint-ORIG-GUID: gaBv6Jrbz0JPerNaLIwlknUIPq2IK2lf
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDExNSBTYWx0ZWRfX3n6IlSI7q/nF
 NHqIKmEznhHVDI4fwmv7v8kc/e6xM+iUveLHnBGWL5x2oxY2vs6+ujtTNebrIjW5wFRYodpUm18
 WTr96NN83oeuxcfGf7x5LOzeqXV6/Qo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_05,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608130115
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=nikhilks@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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

Hi Narayana,

This patch looks good to me.
Reviewed-by: Nikhil Kumar Singh <nikhilks@linux.ibm.com>

Thanks,
~ Nikhil

