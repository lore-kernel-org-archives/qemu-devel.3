Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CD1BC43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 01:48:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wf6Xn-0004l6-97; Wed, 01 Jul 2026 21:48:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wf6Xl-0004j2-LE; Wed, 01 Jul 2026 21:48:45 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wf6Xj-0005Ml-Du; Wed, 01 Jul 2026 21:48:45 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6621KFRv2646339; Thu, 2 Jul 2026 01:48:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=//duOK
 bgNjRngKN9SVJ9vhI0amx2YFuqHwuSBBlO948=; b=qYRLFIyBkGN3zPyPX0wP96
 LUMNvk3gS9G0l9aA40qPvcQQgRVXrMqk2gXoqN0z0uSkP7iQLhoDAPckNNYXgkkV
 atD3cqDFQTEflyV+pv5jqA4gPTtsEE06o4wFcjDt3DxhctXD5OLhIax9UMqFTNhD
 9wLSN/LMjSRg5Fy+Z4vVvrFrQsoXv55tiBgrlEpvcdV+4mPfgSYXLNDwplVYFRCO
 aNF72hj08G2Gn/cLu/cUBIBwA1Odd0k04NhZF9mls7GDDe2Wpj+HRjQteycJMwWU
 DhYsqduK5i9VcokCEM81oTi1hoP6oeQ6QFZMkB0PpCNLd0r+4weDCrhoyAKe+A/g
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26qg7huc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Jul 2026 01:48:39 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6621YhkM029361;
 Thu, 2 Jul 2026 01:48:38 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2s7wa1vy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Jul 2026 01:48:38 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6621mbZA3408558
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 2 Jul 2026 01:48:37 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 163A558053;
 Thu,  2 Jul 2026 01:48:37 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 22A0658059;
 Thu,  2 Jul 2026 01:48:35 +0000 (GMT)
Received: from [9.61.65.1] (unknown [9.61.65.1])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  2 Jul 2026 01:48:35 +0000 (GMT)
Message-ID: <c9a6b8a6-edbd-482d-9f01-7aa09073c934@linux.ibm.com>
Date: Wed, 1 Jul 2026 21:48:34 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 33/35] tests/functional/s390x: Add secure IPL
 functional test
To: Zhuoying Cai <zycai@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: jrossi@linux.ibm.com, cohuck@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, david@kernel.org, walling@linux.ibm.com,
 jjherne@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, iii@linux.ibm.com, eblake@redhat.com,
 armbru@redhat.com, alifm@linux.ibm.com, brueckner@linux.ibm.com,
 pierrick.bouvier@oss.qualcomm.com, jdaley@linux.ibm.com
References: <20260701204922.1320349-1-zycai@linux.ibm.com>
 <20260701204922.1320349-34-zycai@linux.ibm.com>
From: Matthew Rosato <mjrosato@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20260701204922.1320349-34-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=RYqgzVtv c=1 sm=1 tr=0 ts=6a45c377 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=IU-fhFLuSML5SMJrpGEA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDAxNiBTYWx0ZWRfXwCww0JK8Mg1S
 PBjtQrbRSMYyBG/SNh51QbGxY788s/MKDA5W7QPktQQDUS3rkySFHGrFjCxVSDDefgYGbvqjod6
 hm688DH3ol1IfjMMuPuYQOciUz0T05k=
X-Proofpoint-GUID: WjgfqK4s_7kk2GOtKaI1P1iNr6uA8DQi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDAxNiBTYWx0ZWRfX55eWSMaDSufe
 xH1f9iZPVGfVYSoAGah2Be2HPJHWgAa3S0jFqRtbuY8H05agjFGZY2qVGrkPwQNDZATo4d+eTJI
 WBAyi2Y8Uzo4u26jbS76HhkUmS6Lvu7+EocjrjddvdEKVopv2nOp1cp1ezUoK2PirsNlECTKHkf
 LFkcg8XBlEE/28I1A6ZB56ZkjGXbuVQV8YfsQTNsZwvCFJ6y2FRF24Q69HsjWax0UrEgW9lOTbm
 XlNZL7E9NJSD/Xf1/uTxgXEMWF66EcChZfg3beRAIiGzxo8was2OPyc4Wcwli5kFQnmt8Zkh5w4
 /eXyKcvUn424uOucs5c8uzwfUYibEySei4/qxBvOw8WsrTGqvPLT/VFAbGKQYvCJWV8Kxipb6CQ
 duQiZTg9SQYagAq5fPk+pY7tLeu02JWozKb8HLW1pIsIDm2r03JHpzHgfdfV2TRoLIAi4NKC1F9
 rMNoviYmcPjqmFkLD0w==
X-Proofpoint-ORIG-GUID: WjgfqK4s_7kk2GOtKaI1P1iNr6uA8DQi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020016
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

On 7/1/26 4:49 PM, Zhuoying Cai wrote:
> Add functional test for secure IPL.

Thanks for writing a test!  I (accidentally) verified that it fails
without a s390-ccw.img that includes your changes + passes once your
changes are built.

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>

But one question below, possibly a future enhancement...

[...]

> +    @skipBigDataTest()
> +    def test_s390x_secure_ipl(self):
> +        """
> +        Verify secure boot validation during s390x guest boot.
> +
> +        Expects two "Verified component" messages and confirms
> +        /sys/firmware/ipl/secure reports secure boot is active.
> +        """
> +        self.require_accelerator('kvm')

I thought this would work for tcg too?  If so it would be nice to be
able to enable this test also for cross-platform testing w/ tcg..

Thanks,
Matt


