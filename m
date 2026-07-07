Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D161CC43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 10:42:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh3FD-0004Xd-W5; Tue, 07 Jul 2026 06:41:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1wh3FC-0004Uz-AM; Tue, 07 Jul 2026 06:41:38 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1wh3FB-0003rz-1S; Tue, 07 Jul 2026 06:41:38 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6678IQSn2252945; Tue, 7 Jul 2026 10:41:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=orwVO9
 dyyZFXy0kOUMLZmhXktJ+z2vLyvDIl1COp72o=; b=hC7LhY/EPbF9hyTurZHAGA
 ny0B8edKEc5vdB2YY2xi4SYOj9+O9Lc+cV8IFIs/eBfmDc7GfRhQDy7B9gbpAwzM
 EhaY4Qz/2iAx/vlq898dcXmUUK5HEAylU3hCLABDVymNEWz9Snz3eSzQBLLkfazX
 7Avz3aXmoXwPtgbvy3nmt2rr44qfzaEv/SSGyhBStcubRU8Tuq4JEVC0RQNlva1P
 A9dNAIt3PJ9lAMuB52zVHtxnfMmIhj/TUnZrbOfwQTXCC475Fww4UwH1z0tGpypJ
 KJEQT/tUK1TXCvayFZ1HmuiEV2ioyT0qsiUc/FRpEWevECfYQDwlEX64drfhEErg
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6stsq2u7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Jul 2026 10:41:35 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 667AYmbU024960;
 Tue, 7 Jul 2026 10:41:34 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7f6y21ed-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Jul 2026 10:41:34 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 667AfU8s14811568
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 7 Jul 2026 10:41:30 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 878A52004B;
 Tue,  7 Jul 2026 10:41:30 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 401DB20043;
 Tue,  7 Jul 2026 10:41:28 +0000 (GMT)
Received: from shivang.upadyay (unknown [9.39.26.166])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  7 Jul 2026 10:41:27 +0000 (GMT)
Message-ID: <73c7fa5ffe9617d308d79d5a18073aa2f6b44a48.camel@linux.ibm.com>
Subject: Re: [RFC PATCH 23/28] target/ppc: Move VMX integer arithmetic and
 BCD instructions to decodetree.
From: Shivang Upadhyay <shivangu@linux.ibm.com>
To: Chinmay Rath <rathc@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: milesg@linux.ibm.com, richard.henderson@linaro.org, harshpb@linux.ibm.com
Date: Tue, 07 Jul 2026 16:11:26 +0530
In-Reply-To: <fe7d9247-70f5-4f37-b5d5-86938518e7c9@linux.ibm.com>
References: <20260520160728.2283628-1-rathc@linux.ibm.com>
 <20260520160728.2283628-24-rathc@linux.ibm.com>
 <fe7d9247-70f5-4f37-b5d5-86938518e7c9@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: JRJt4e91kuv87Jd7MH57R3DF7MdTFeTh
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDEwMCBTYWx0ZWRfX9f/iRrDy37R9
 IXJs55BiVLubpMsu0T2obJNpfl6156ZsSXxmNyjZt3+aaEdrRwP6nsAImk7mRFeZiYuLqLMhV2u
 zlZ/MzsI9fnd3EoQ0uRG47Or2re8Vr0=
X-Authority-Analysis: v=2.4 cv=DKW/JSNb c=1 sm=1 tr=0 ts=6a4cd7df cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=x2Vzjss8galgWXRkoT4A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: JRJt4e91kuv87Jd7MH57R3DF7MdTFeTh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDEwMCBTYWx0ZWRfX4Z5VVoXuz+zp
 uSsILbuZAWRnB1JmUok60Ph01eQ6jVF9ObkLaVC8+Ckbu/0Mq76TiyQXkPGHDWFqDhtvVHlWB4K
 XdWKxYScZCteh61hIBAcusJur5HGmLmYmlzUuoXCW0BOLS/39aeGS6ZDSMqZ/YdyG3uTd6hmAZG
 8PBRA9rCUQkUkby0A1sKGv8L2+RXs2iySCmyFFVu08Mngm3vJgsoPNvZMUaxe8nl/Et6aLtaxLQ
 IqOFn9kwgP0GkOjrIlF4kEUG2Zgo3qWIX804CBkWlSE69EaUzvFlVOrxXBZWmSfumhMNAz0NQNX
 wMqY6u5s1cfMoPlmhTLYDAErKVdWK1WInHu68fo5TSNAioxNP03VMbIT2cdwZs9idD8MELl+zot
 J9JGmGIpcJxTY7brxBl5uJQHZ11DKPItb0381F+SEtm0LSy3ulWtwWi5oSBfY6tUXMYUGKmurI0
 pC1czg+S2i0zbTJZ38w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 phishscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607070100
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=shivangu@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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

On Mon, 2026-07-06 at 20:52 +0530, Chinmay Rath wrote:
> Please clean up any macros that end up being unused after the
> movement.
> GEN_VXFORM_V is one such.
Nice find.
Thanks.

~Shivang.

