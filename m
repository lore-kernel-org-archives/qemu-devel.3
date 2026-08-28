Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39DE4C61DB9
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 04:59:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzofb-0006KZ-9s; Fri, 28 Aug 2026 00:58:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nikhilks@linux.ibm.com>)
 id 1wzofZ-0006KB-Hw
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 00:58:25 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nikhilks@linux.ibm.com>)
 id 1wzofX-0006V9-NZ
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 00:58:25 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67S22KhR624547
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 04:58:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=fMCYjB
 JDvAd+PYMhUvGt4Ph/cLhbrRtr3XfVnxwp65s=; b=BeO3A0e19xwJ5dxsbcY1tH
 ECEM1DC39Rxxlt/+3+Gjlqd4rm+cVhltz3FfT769Y0pFxst5zgbmj14xzBQE8tEC
 2kkRj6xWeDMgHC4jNjr0PoIH1jvAbgq3YiQhSjF8dt5lpvLMkP/Bb/U9inuXVm+F
 ognnZwD86/vIn7yojYFIJtLU+K1dGCkP1zKRlf8sF7o8Nl8UTEMNCZA3BP+kiytN
 f9Mm4lAqFRIsVP6SMVEyt3HU920i83ZNhH6yZ6QLCn3vtsbpQ/kpgGyJ7XzXmUCo
 e8U+N19EG9oOXKA5Lxl1y8x9jIO1xSStmpEDGkxgQEa14qYqoRcpqYdff3OvThRw
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73g5a64r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 04:58:20 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67S4uJHI024060
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 04:58:19 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7qkhm9wy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 04:58:19 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67S4wH3o46399978
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 04:58:17 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 730D920043
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 04:58:17 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 07CA120040
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 04:58:17 +0000 (GMT)
Received: from [9.43.120.200] (unknown [9.43.120.200])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 04:58:16 +0000 (GMT)
Message-ID: <42ab3e39-1397-422d-92c4-7b3fe68bf8dc@linux.ibm.com>
Date: Fri, 28 Aug 2026 10:28:15 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/pci-host/pnv_phb4: fix guest-triggerable abort on
 8-byte config access
To: qemu-devel@nongnu.org
References: <20260805090530.1333997-1-nikhilks@linux.ibm.com>
 <501df67e-28d0-4630-b98a-769abb41086b@oss.qualcomm.com>
 <c21c72fc-672a-4674-a8d6-0b999502b4ad@linux.ibm.com>
 <19c3ff9e-6559-491d-a3f5-b1786db6b9da@oss.qualcomm.com>
 <eb8f5972-e494-483a-b093-5d67f64f70f8@linux.ibm.com>
Content-Language: en-US
From: Nikhil Kumar Singh <nikhilks@linux.ibm.com>
In-Reply-To: <eb8f5972-e494-483a-b093-5d67f64f70f8@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: SAyRjTX68Bh-QJtMCHD7jNvCWfuFl-eW
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDAzNiBTYWx0ZWRfXy8nFiKRgme2G
 VqhvmMuEcgHzwXYVC2eQBeuhmNnNvyjxUoEROztky6F439y5LvYqLddt+womR1XMunE7IcqPQmg
 DYTS5DB+v3ZIZbw2mvJyKX6sM4h9SdQ=
X-Proofpoint-GUID: SAyRjTX68Bh-QJtMCHD7jNvCWfuFl-eW
X-Authority-Analysis: v=2.4 cv=JZyMa0KV c=1 sm=1 tr=0 ts=6a91156c cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=iHid8GlTqDyzVVAvd0gA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDAzNiBTYWx0ZWRfX/lcHI0OBH/IW
 j2bmhm4jD5QXq3coYnwNFvwxtdrTkBtf8+caaFuHXW/+vy0uhlvv8MFJjyFizgV3ZGvI2iLUn5U
 1rk0BDWQZptEAQy8EPZwAYHGTXUigGRY0mMChwSu+MYrYt5ZbTsrdQwfucniOSRZuI7FfWS6W/f
 IIZdsHjWFOiesmu2xxjDXQVEF+wLTh6OiYD/UnePwASDABFk9wZZgTco8/+p/oIeqWDosPlf6PU
 d5l/L1YFNWT5WsGKv2/+jtOJCGGosFzYFP5nXQrNPW9GAHRcLelf6jLk8b9MS4MLwg67f69Me57
 Liz4P6qNHc2MZUy1upSzdbciRwIKx9coKgd+Lewa6Q3c+uR7GCibRGDqscMhO2kuKN2VJdPkP2j
 D3XtBtZUZPKr0OYvoXIBOKEe1eT7kZpad27D4tYszRz84DcxwlcZfeWFfFikzoD+mQVkNiUxOfZ
 1ca3eqaYVlkZxpOuSag==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_01,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280036
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=nikhilks@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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

Hi Harsh & Aditya,

Since Philippe noted he has no objection to the minimal fix, let's 
proceed with merging this patch as-is to get the immediate DoS resolved 
in stable.

Moving the config window to pci_host_data_le_ops requires a proper 
memory region overlay split. I will take that up and send it as a 
separate follow-up patch.

Thanks and Regards,
~ Nikhil

