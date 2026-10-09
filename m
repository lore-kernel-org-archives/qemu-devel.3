Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14DABCA9EBB
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 20:37:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFHL7-0002OF-U6; Fri, 09 Oct 2026 16:37:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1xFHL6-0002Nh-8R; Fri, 09 Oct 2026 16:37:12 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1xFHL3-0007l6-NZ; Fri, 09 Oct 2026 16:37:12 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 699K5m6I1007023; Fri, 9 Oct 2026 20:37:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=okKdqX
 UnirBsvvDH/Oywc6kAOSaW1JgF9UGmkrq6IQA=; b=Qb8VW7MoukkkaEoJ2downD
 9e9w7NygNAOK/x/YikVceaXSqjy57IqeFIOmT+/1JgBL3UNIyR0ai5oc3UGRcuvp
 qfOVLuzHDnbPJk+0UtpXAEZbkaHoD1L1RP/elHmaHsWBirUFMaI9hQ7XUMylo5Fc
 Ysm3iyA3FRCJ0ezi9gAJa2qXmir3g3o/TM3ziqcs3RF9uBY+kXqOUFLlFXSYTx76
 Cx0Np9KKEzISU8K7Nu8ebv9NQQ8yH/gITtUwAsk7FvuNlynAJ9k8qFbv40e+96uH
 GeXpuExFlt8imhkVDBdnuBwYCdwCzgZIMpFLCilxFSaNmz2pmfntihJMniz5Sn3A
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h74tersts-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 09 Oct 2026 20:37:04 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 699K3CpM1403842; Fri, 9 Oct 2026 20:37:03 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h6hsnmnd0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 09 Oct 2026 20:37:03 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 699Kb26l31523336
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 9 Oct 2026 20:37:02 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3F8695805D;
 Fri,  9 Oct 2026 20:37:02 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3D21058054;
 Fri,  9 Oct 2026 20:37:01 +0000 (GMT)
Received: from [9.61.169.201] (unknown [9.61.169.201])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  9 Oct 2026 20:37:01 +0000 (GMT)
Message-ID: <073c5c53-0063-4aa4-8c7a-01e6352e3271@linux.ibm.com>
Date: Fri, 9 Oct 2026 16:37:00 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] s390: mark features that depend on deprecated
 features as deprecated
To: Collin Walling <walling@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: Hendrik Brueckner <brueckner@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 qemu-stable@nongnu.org
References: <20261009185559.144750-1-walling@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20261009185559.144750-1-walling@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA4MiBTYWx0ZWRfXzeUC4Ojby7nI
 siNFmUqDrW8gIP0MSsBMk53gS7u+ZFI7rc/yAyMiqBTqQVLYVaDs6+gODxKiekHXRjborlE3Ceu
 SWvjn/fYiB3XKnCpDh0FiuDVQbFfQDI=
X-Proofpoint-GUID: nQWByJ1IGlGy2I8hi6o0pIR7xw5PzV5N
X-Authority-Analysis: v=2.4 cv=P42vFSAu c=1 sm=1 tr=0 ts=6ac95070 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=q1lb9nn91R6JBGDZ00UA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: nQWByJ1IGlGy2I8hi6o0pIR7xw5PzV5N
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA4MiBTYWx0ZWRfX3HnobDZ71vEe
 uMzYF+jKyqf6rj1dgbQDV6rqbrbN+Tm14r7QhQ6Q89sx3OhJWtoJ46BLfjBxeGoBYZbC3IhxI89
 q/Ur7tPhjuRgkbBmlIIrnggm6na0zotiDwBE4FbdmTe9KmeDPx6mkILe2ISZ4SsP70Oid2QMMCg
 2RJ2LWvCR+pet2b5SNaD9D9br6pqDeHQIbJ7/ez45WFcQi5BpdnohyLk35k5PQcEslodTWm39h6
 dRBvI7rPdWfJGke9Zr3K0xkl1UuaWGZNTWns93LpiID5Z4omQdHVoiwh1QPfo7UhVKwZf/Q61Vd
 kQwkMjvcWaFvKeGO1oSDmpSXcJGoTIQ5hrM32VlApAGQKplsijtuJPMy1CysEYYmWn9bYnRa0dY
 aWSubhDNLFd98U4HB09ligfK0lefUle13Mds1pTaKuC+tafAZ5G0EPLfcnM5eKomCrn+odVMP03
 D2EfWwdskczsnx7MhCA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_06,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 suspectscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610090082
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

On 10/9/26 2:55 PM, Collin Walling wrote:
> Changelog:
>   v2
>     - updated loop structure to restart and check if previous dependencies
>        need to be accounted for

To clarify, this was in response to a comment I made to Collin off-list
that I failed to mirror here.

My concern was that v1 was handling a case where A was deprecated and B
depended on A -- but was not catching something like C depending on B
which depended on A -- while B would be marked as deprecated, it would
not be added to feats[], so C would ultimately not be marked deprecated
because B would not be found in feats[].

His v2 patch 2 not only loops to ensure we catch dependencies that may
not yet have been marked deprecated on the previous pass, but it also
instead looks directly at the most up-to-date features bitmap instead of
the local feats[].

AFAICT this is a theoretical problem today, but a potential future
hazard since we definitely have such daisy-chained feature dependencies.



