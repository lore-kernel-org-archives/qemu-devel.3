Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0E4CCA601E
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 20:42:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFHPo-0003YW-LI; Fri, 09 Oct 2026 16:42:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1xFHPn-0003Y1-83; Fri, 09 Oct 2026 16:42:03 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1xFHPl-00088P-Lj; Fri, 09 Oct 2026 16:42:02 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 699K5VB01006813; Fri, 9 Oct 2026 20:41:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=BHOMLA
 CITSxRKvKcZAuXx3qGhacXBp41d2reZpsL7ns=; b=DgFbKZRRVU23iqsEQr8S7n
 GOBsw9n2UVejDDMoLj5DZLgCdg8UXrQhBxD+SAtEd7/TEVVCbr1nCN7H7NrvlUal
 Xs357DX0Zr1g05qXgv+ZIet+XH+s7ROJ9fYLVi1TcwDDvCfvrIGrBe9154+e1t7W
 TBGz2R1NfXWGXwgBQkzY2Ebe7sfsc44fbR1FFAsJZxziIuHI6443CqukbD4bgdma
 jlthvVSC/4U8+41YLZey/heM1MWhYV/QbkonHslZyMEfH211ZBCCGx6abLR+JUT5
 zDwgqQTi7b/0DEsHj72YOPZPi+CFy4J4zWjmv9NEP8UcDfMKhPr1joD+C7JtZeLg
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h74tert93-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 09 Oct 2026 20:41:57 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 699KI4hP1366875; Fri, 9 Oct 2026 20:41:56 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h5s352btp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 09 Oct 2026 20:41:56 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 699Kf9mp31130234
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 9 Oct 2026 20:41:09 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 404CD5805A;
 Fri,  9 Oct 2026 20:41:55 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 32A8858054;
 Fri,  9 Oct 2026 20:41:54 +0000 (GMT)
Received: from [9.61.169.201] (unknown [9.61.169.201])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  9 Oct 2026 20:41:54 +0000 (GMT)
Message-ID: <b09e81aa-079f-4b00-a898-7455394f8bb3@linux.ibm.com>
Date: Fri, 9 Oct 2026 16:41:53 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] target/s390x: mark feats dependent on deprecated
 feats as deprecated
To: Collin Walling <walling@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: Hendrik Brueckner <brueckner@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 qemu-stable@nongnu.org
References: <20261009185559.144750-1-walling@linux.ibm.com>
 <20261009185559.144750-3-walling@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20261009185559.144750-3-walling@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA4MiBTYWx0ZWRfX1+YFpjaZjqc0
 YbZWLRscDeVQtNppJ1bt7CiXI9aD+PVcSm+QWLU4/MLXnW5cTm24+gvJzjb8XYrGvW3uztTq7ir
 YL4qJ7WHQuh9HCn6rqetX2SaM0PZ0oo=
X-Proofpoint-GUID: oSbMazehh6ZO4a9LRn5To_afOO26aht_
X-Authority-Analysis: v=2.4 cv=P42vFSAu c=1 sm=1 tr=0 ts=6ac95195 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=5rU0E4ExTrrksosqX8gA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: oSbMazehh6ZO4a9LRn5To_afOO26aht_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA4MiBTYWx0ZWRfXxz/KBpXblz+j
 YCmpRMyzJccjF+VQa03jFGqnx85FgE73wkHGzjeV+XVw8T/wtsXAF7DAKtJlwOaKTUmADC5vq/g
 tCluD+DTRsFguW1HbmyY089o1fq4n6K6FsTZ9ddFgbx4QdrW45O7UpJ/SK2OUNeLaPStG4njp7H
 U9oRou6wOgag+ZzsrYXRqkhGzuAlxNeZmAPjHxNpITxm6MeOHJ5Erc7oy227oN7/jLeDKYrLIaR
 sLub+6iR62b4F7wd650II0Mwc9dT50RBKlx1CR+vUCLSYqFkUg7hRGHb67eDkVALKx/Gsay8SKT
 F4ewnA5wB6FUwCGF09afYDhsyJWid98J+1lGM1yjvFYHSdYnfCV5ptRlsLKLcerU+JC1pvvQot4
 vIPTTg+hcjy3l8cZOazVIjg4wTNg4TILr8EJNhFxgp4ElqXdnewe7ZR8cJtPYC6ooQmpErHokU9
 4hcUkpOcwh3ZAyxtTTw==
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
> There are certain CPU model features that depend on other features
> that are flagged for deprecation. For example `ineff_nc_tx` depends
> on the `te` deprecated feature.
> 
> If a user defines a VM with the current list of deprecated features
> disabled, the following warning occurs:
> 
> 	warning: 'ineff_nc_tx' requires 'te'
> 
> To alleviate this, add these "dependent features" to the deprecated
> features list. This allows the user to see *all* features that should
> be disabled to ensure a successful migration to a host system that
> may not support certain deprecated features.
> 
> Fixes: 6e55b32d45 ("target/s390x: flag te and cte as deprecated")
> Signed-off-by: Collin Walling <walling@linux.ibm.com>
> Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>

I tested to verify that the facility in question (ineff_nc_tx) is not
visible to the guest with this patch using host model.

I also tested that purposely deprecating S390_FEAT_VECTOR_ENH via the
feats[] array correctly picked up both ENH2 and ENH3 via the code added
by this patch.

Thanks,
Matt

