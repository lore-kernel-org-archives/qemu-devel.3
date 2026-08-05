Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 927FEC55174
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2026 17:18:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrfFq-0006KL-PU; Wed, 05 Aug 2026 13:18:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wrfFp-0006K5-Qv; Wed, 05 Aug 2026 13:18:09 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wrfFn-0006o7-UF; Wed, 05 Aug 2026 13:18:09 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 675FljeA2398087; Wed, 5 Aug 2026 17:18:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=rCzNif
 giIc0vzX3W59L5RJS+DyQRrUzDtgEmaO5kVVc=; b=GAGykhh5+rYXwWOF7VNpZx
 2CZAbxO0QnaUnGa7Vpmu71JnegcFQqPfWL8OkrMVdX8vkEzQRJmoJL+NJ2JwufEV
 WY/pOWqoTDmHeaShIXoNQWd8V6bCM52XzSlFDCK6g3cxeSfwF/iPqJEAXzbEhNzf
 E4A6YUzaPaOV9HnY/T1WtCCAr3I8fCWyBSPiweekj1P0BjRmvANL+kgREQkxmp04
 B4kPui9Y/YzqYptrj8mSS7qOsUQoXJOsNTUeThUvMyXlyq+6nhG4itQa93IjuYeU
 BkizJHFYcj6a9Dkve+/lf0uuBJbzgyywKPQsEtRi2QwGo2ox2GWkZkLORMl753XA
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8fqv4mb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 05 Aug 2026 17:18:02 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 675HBIij005624;
 Wed, 5 Aug 2026 17:18:01 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsvmhff3k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 05 Aug 2026 17:18:01 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 675HI0eo33751688
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 5 Aug 2026 17:18:00 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ECB925804E;
 Wed,  5 Aug 2026 17:17:59 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BEB395803F;
 Wed,  5 Aug 2026 17:17:58 +0000 (GMT)
Received: from [9.61.23.247] (unknown [9.61.23.247])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  5 Aug 2026 17:17:58 +0000 (GMT)
Message-ID: <f2d2181e-a399-4faf-90ec-a7e38803f72f@linux.ibm.com>
Date: Wed, 5 Aug 2026 13:17:58 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] target/s390x: Allow 2G hugepages guest backing
To: Claudio Imbrenda <imbrenda@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, borntraeger@de.ibm.com, frankja@linux.ibm.com,
 pasic@linux.ibm.com, mhartmay@linux.ibm.com, david@kernel.org,
 farman@linux.ibm.com, richard.henderson@linaro.org, iii@linux.ibm.com,
 cohuck@redhat.com
References: <20260805103728.97602-1-imbrenda@linux.ibm.com>
 <20260805103728.97602-2-imbrenda@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260805103728.97602-2-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: H3-JyiFO5dip2Jj-d5kEnYb1hSLYG7zT
X-Proofpoint-ORIG-GUID: H3-JyiFO5dip2Jj-d5kEnYb1hSLYG7zT
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDE0MSBTYWx0ZWRfX2/xcGsB/5sTy
 LnVjMCifXOVtRd4v/EoLmkcDzbq3JhtCztE2xCgTM7uyP7t6deVG3MjV9ZviTEVVybzCIjkAMBY
 Zk+qy/aI+hns5tjBOTEnUul/wjiBlqk=
X-Authority-Analysis: v=2.4 cv=K8cS2SWI c=1 sm=1 tr=0 ts=6a73704a cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=lTBg_gQgYjYnJuI21ZsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDE0MSBTYWx0ZWRfX1vhjnvHvAs7d
 iHIAkx7aCvKD3bMDsReeu9F/kozPjujovM0Bw9x+iVy+UkMNHAsID5BQp8wZgT7HyGk/+1nGi/F
 krsIXwnI92u/N8pNR3D/M3SgsA9oJmr0MaxETe+8NPY2z3BTO2L6heDSIkcxJNDb/WZSn31Uwf2
 CqRnxumUnB2/SySpil/hxGnl2cCsQgjDxXegyygPGO/BNXd7wsrQwri09Ft7mv8U6OPgUg9g6NZ
 HLuwYuLx2O+9VQhaaH3H2fJJYre859uSwRsAnSXNKLfXu8FYm6O2WrqRIUOY6w5L6E3+8RFlbiL
 kBWhYVHccgHVChvgb2zj3ztuwjRzS28Pb39G/y9Q6Uxrw/PqVxglypED2dSTz7DmtDtkl5LM2hI
 hDIGVt+6Gygrvdbq9Xx28TUMYldynciqswkBy0STJ1ST/z6R8R6x4anm80/raApJ6cNezt0tSk2
 TqC6If+VeJgZEQCUstQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_05,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608050141
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

On 8/5/26 6:37 AM, Claudio Imbrenda wrote:
> Allow mapping guest with 2G hugepages on hosts that support it.
> 
> Rename kvm_s390_get_hpage_1m() to kvm_s390_get_hpage() to reflect that
> it is not anymore limited only to 1m hpages.
> 
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> Reviewed-by: Eric Farman <farman@linux.ibm.com>
> Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>


