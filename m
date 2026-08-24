Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E685DC5DF94
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 14:56:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyW5N-0005p3-38; Mon, 24 Aug 2026 10:55:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wyW5L-0005on-Oh; Mon, 24 Aug 2026 10:55:39 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wyW5K-0004P2-4g; Mon, 24 Aug 2026 10:55:39 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67OD1aAX1958015; Mon, 24 Aug 2026 14:55:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=DBkB2V
 imlQcY2+9UBAO8htSM0c1BNcWM/31fWYzuLI8=; b=CkcUg9wQUnlp2JDMpbd4XB
 shdGE8+AmfYcix4jsM7gRlyPrAVaFxwJtvN2Uu+Vtji/arhSVOmDOmHTn/KGlS8n
 lP5TelioaPbu8+6f6f3H0S3bYERzpEmv9Kx4UG+K9Z8kaAYdOjhHUUWt4tiCZvVZ
 6rWvYMFOg2pYx5PW/kRL+Ee+rhAaSOjH0o/QtJ7xrrwUbzKBBx73PDqasjiqmfrv
 Sd13U1/c3YFQ7ouCXFGzmnHPM3zAcXTDGxzA8hmLCm9cNu5JI2Ssdn4wEo+t01kz
 /yoOLzjpCiyN98MUSxiRLCrCU8QqOfTAQD2yO4E4gG53WcaHQqEqmciYitr/TOrw
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73g4j3qt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Aug 2026 14:55:33 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67OEfNYT020577;
 Mon, 24 Aug 2026 14:55:32 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7pfvxrxc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Aug 2026 14:55:32 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67OEtVEV9569010
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Aug 2026 14:55:31 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3FBEC5805C;
 Mon, 24 Aug 2026 14:55:31 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F36B35805A;
 Mon, 24 Aug 2026 14:55:29 +0000 (GMT)
Received: from [9.61.21.147] (unknown [9.61.21.147])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 24 Aug 2026 14:55:29 +0000 (GMT)
Message-ID: <f2f3b5de-e1de-4e8c-82c8-2379b78e9ff9@linux.ibm.com>
Date: Mon, 24 Aug 2026 10:55:29 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/3] tests/functional/s390x/test_secure_ipl: Add
 virtio-blk-pci boot dev case
To: Joshua Daley <jdaley@linux.ibm.com>, qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, jrossi@linux.ibm.com, zycai@linux.ibm.com,
 borntraeger@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 farman@linux.ibm.com, richard.henderson@linaro.org, iii@linux.ibm.com,
 david@kernel.org, cohuck@redhat.com
References: <20260812152112.3330493-1-jdaley@linux.ibm.com>
 <20260812152112.3330493-4-jdaley@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260812152112.3330493-4-jdaley@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: F7XajmPqJh-p0s2YbfQOEF2irvgDw5YO
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDEyMiBTYWx0ZWRfX05Yydt/FKRTF
 b2jfP0/M9yiiXSCdqTZsOVpzNuRNXk1Uu/jDVI4Z9vlUmpzllieJwpHXx2OnYZt1/UmPYTgiq0/
 +qBekqeX6g1HmqlYwdyyn4Dn+bPkPVw=
X-Proofpoint-GUID: F7XajmPqJh-p0s2YbfQOEF2irvgDw5YO
X-Authority-Analysis: v=2.4 cv=JZyMa0KV c=1 sm=1 tr=0 ts=6a8c5b65 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=YaG0G0OC3Pa_izDdi3AA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDEyMiBTYWx0ZWRfXw7VY+crEiNmB
 6nI/gTPDYjFPUzdF3iSddTvijrx5T1Q3KpxqzPpI1Thdz6AzslRazN2hMM+ZdTCMKp/1eu7NLTe
 8dInIv2lpMc8YhHSWbzL2jblDTrI6giy7NZAves7Oig+nupT5/2MOtPVd/OXtJocIlWADqRW50x
 xONnHltU76Df/TAtbe7Mm8NPe2RyPxltD8iA6crRYkThRMX1viFWGX9l2oz+IKW1v+S1a20evFh
 T76HdB06HUUf7vL9rUjOUR+WwHWiFnSB/cmUuapo1xTERneaW2PjVU3/YG/OFJxjvbRYuuIneab
 3rC8DGN4zRaqKgmWMamk162pKUeXWbNrecc6HUqrNA+V7vdEq4PYNd9CHtSRPgRvV4OEICBTSRs
 kks4E38OYaw8LfYenHZ+hFSMRErQdVKdc7ZkzqPMiCVhZPb0YvQvQUpwACbf7HfD6Wdc9qmwR15
 Xe2dxdbMhgqGbrqAklg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_04,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240122
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

On 8/12/26 11:21 AM, Joshua Daley wrote:
> Split test_s390x_secure_ipl() into two subtests. Each tests with a
> different boot device: virtio-blk-ccw or virtio-blk-pci. Use a state var
> such that the setup is run only once.

[...]

> +
> +    @skipBigDataTest()
> +    def test_s390x_secure_ipl_ccw(self):
> +        """Test secure IPL with a virtio-blk-ccw boot device."""
> +        self.require_accelerator('kvm')
> +        if not self.setup_done:
> +            self.setup_s390x_secure_ipl()

AFAICT this setup_done check won't do anything.

If I run this file I will enter setup twice, once for
test_secure_ipl.S390xSecureIpl.test_s390x_secure_ipl_ccw
and again for
test_secure_ipl.S390xSecureIpl.test_s390x_secure_ipl_pci

I think it's because each test will run with it's own instance of the class.

> +        self.verify_s390x_secure_ipl('ccw')
> +
> +    @skipBigDataTest()
> +    def test_s390x_secure_ipl_pci(self):
> +        """Test secure IPL with a virtio-blk-pci boot device."""
> +        self.require_accelerator('kvm')
> +        if not self.setup_done:
> +            self.setup_s390x_secure_ipl()

Same

Unless this is really time consuming, I think the simple answer is to
just let the setup run twice and don't try to share between the 2 instances?

Thanks,
Matt


