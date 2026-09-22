Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F4A1C98304
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 20:47:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x97OJ-00079g-8M; Tue, 22 Sep 2026 16:47:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1x97OH-00079G-FW; Tue, 22 Sep 2026 16:47:01 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1x97OF-0003Bm-VQ; Tue, 22 Sep 2026 16:47:01 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68MI7NEE4144223; Tue, 22 Sep 2026 20:46:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=Q5DSeZ
 b4lKDqgkz+ZLWUIhUElYi4dlCgP5f4JVXt8DE=; b=PiWTSaLpiPnCVsXdja/AAD
 RBcd2x/8JlfVoS+RvM1g2EuayNzAElJ/RJwzjCTxUhyHKtWV0bh9bfRK+GoSXCIB
 5ExhCwTIFZ3mLf7p5boSJ5orJoR5QAP49BMIrONrlKl2EZn5TN+/7F1526Sz+ytP
 33YSEBHgLHz3klahkTfgvH7+s7ITDPWtuBuMbGGpAq3n3Mk48sSSESCpuTn2j5WV
 /bMk8o3O2cq4GmMMPqx/xwtpxDWL4gSQfkh+ymvg/AYbuHWccalkJveG/Au6mBzb
 qCOicRxKrDCp76scuZKit4H06RRAAPEAkj3g1zSkwQsftcfBHhrm+LOW1FLyp0ug
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgqfgkq-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 22 Sep 2026 20:46:55 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68MIHeTX3279519; Tue, 22 Sep 2026 20:46:55 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gt4qqbk1k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 22 Sep 2026 20:46:55 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68MKkpG435455274
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 22 Sep 2026 20:46:51 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 836742004D;
 Tue, 22 Sep 2026 20:46:51 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0DF0A20043;
 Tue, 22 Sep 2026 20:46:51 +0000 (GMT)
Received: from [9.111.77.23] (unknown [9.111.77.23])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 22 Sep 2026 20:46:50 +0000 (GMT)
Message-ID: <3b919775-621e-445a-afd8-59afc7a5014f@linux.ibm.com>
Date: Tue, 22 Sep 2026 22:46:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 15/16] s390x/pci: Implement migration for emulated
 devices
To: Konstantin Shkolnyy <kshk@linux.ibm.com>, mjrosato@linux.ibm.com
Cc: alifm@linux.ibm.com, farman@linux.ibm.com, richard.henderson@linaro.org,
 iii@linux.ibm.com, david@kernel.org, cohuck@redhat.com,
 pasic@linux.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
References: <20260922183654.798470-1-kshk@linux.ibm.com>
 <20260922183654.798470-16-kshk@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20260922183654.798470-16-kshk@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=G+OJgNk5 c=1 sm=1 tr=0 ts=6ab2e93f cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=Cw-iWatwN-UAAQttplEA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDI5NSBTYWx0ZWRfXx6zIS3eCiRYb
 5hrGq0VU+Wl7kxHML84/8ncaCmO0BTJGmbY1BaJjqLb3sK6Me54tEDFdmOrqgdcN1Y29fLb9rEq
 h0Ev3I3uYpWZFI10cZYgJDl6+4YWs2aPdYjrg9nSLoe4APO523aZRSQz2mbjnkfIbtT9Z/DTGvE
 dnZy6SgBGGd6hYh8s59IWuAUC+eldc7i7o29QF5B2H7q2h38BmLxSBDwkDeAxZKb+hf5eJ96oPN
 sNiiPL/UDT/QS69eyQhAJ5CLspmLPcHFdDOpChqI2OjyTXsSvA37k0RaoYO1ooAKJ+nQIfRj7Kq
 0DjDaSRVPeaXrJbR2IIqGiXQq7SPTqG1WiHcCLhieLBFmYOAGEm9nz6heyDFkruuRdI27AGWrN2
 g8vObr06EV3MOke2aShEF9FHl/lMzOOUAaXy0rRx+VdP0WrMGj+T8OjmgrmudEyrLNL4AQfsU+v
 dfl8GlmvS4wLaRUveGA==
X-Proofpoint-ORIG-GUID: Ir8prSVWBFvw5WR4A7MOLtc0juST_Q1c
X-Proofpoint-GUID: Ir8prSVWBFvw5WR4A7MOLtc0juST_Q1c
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDI5NSBTYWx0ZWRfX2VByC38zaEW7
 /WJETJksXE2Goq2a1/fx6eYD6to97vw0cd23oSd+qHXCJgFLkge4Zbllrlms8vuY6WP4u/iGB8T
 sQPZHKaIp3ehJeqIz582pxAEdwHB5jI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220295
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=borntraeger@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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



Am 22.09.26 um 20:36 schrieb Konstantin Shkolnyy:

> +static const VMStateDescription vmstate_s390_pcihost = {
> +    .name = TYPE_S390_PCI_HOST_BRIDGE,
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_END_OF_LIST()
> +    },
> +    .subsections = (const VMStateDescription * const []) {
> +        &vmstate_s390_pcihost_pending_sei,
> +        NULL
> +    }
> +};

This section is registered and emitted unconditionally as far as I can
see so new -> old migration breaks for EVERY s390x VM on machine types
  <= 11.1 (tested).

vmstate_s390_pcihost has no top-level .needed; only the pending_sei
subsection is gated (x-zpci-migr-enabled && !empty).

Simply add a .needed as well, for example "return s->zpci_migr_enabled",


