Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D957CC53219
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 06:40:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wobTP-0004qK-Nq; Tue, 28 Jul 2026 02:39:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1wobTI-0004pa-9W; Tue, 28 Jul 2026 02:39:24 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1wobTG-0000d4-Hp; Tue, 28 Jul 2026 02:39:24 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66S3lsOh4140369; Tue, 28 Jul 2026 06:39:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=58SW7D
 iBDzSTXg/bsamdXMU+OEEdLJ0vVNJPQTpi0pw=; b=pJi2G8Mekjt7XZdx5A2irA
 4SOErH5vvTgh6e61Vcw5XvUoZTdndp6rTu33wyfMQnrb8f0ALvSx7uHp3LEImmue
 vptFqyeBFg361SDyYOdSqn6NZxW+uzROsYUpZkvXj9JrUp1yBcSggGLCVYE2S0vt
 zKTscTSHu3QOlCbfY9kR3269AmQGd0rnpx43K0igM7A4nLRnF0rc0+tIdNwOba+H
 Y8vF1YgckKkOXc/RNvxdu6FUWGRPBJGK9Dak5oxS7KJgENZc8aqBrni6jAOKZkxA
 vO/i4Ebwqg+DzKLl2PuhoU6VAFa0MBDnxEk0O05Ll9WeCXN/BsivpF++RZvtE7VA
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0xkugj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Jul 2026 06:39:18 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66S6QL6h014873;
 Tue, 28 Jul 2026 06:39:17 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn7uw0rqh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Jul 2026 06:39:17 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66S6dCRi52298130
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 28 Jul 2026 06:39:12 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BEA4C200C5;
 Tue, 28 Jul 2026 06:39:12 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7D60B200A3;
 Tue, 28 Jul 2026 06:39:12 +0000 (GMT)
Received: from [9.224.77.173] (unknown [9.224.77.173])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 28 Jul 2026 06:39:12 +0000 (GMT)
Message-ID: <cacdc31e-e0be-4b23-9bd1-4e2d0190a86c@linux.ibm.com>
Date: Tue, 28 Jul 2026 08:39:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] more hardening fixes for s390
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>,
 Halil Pasic <pasic@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Hendrik Brueckner <brueckner@linux.ibm.com>,
 Joshua Daley <jdaley@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Jared Rossi <jrossi@linux.ibm.com>, Zhuoying Cai <zycai@linux.ibm.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20260727115052.24289-1-borntraeger@linux.ibm.com>
 <87ldawsk8a.fsf@redhat.com>
 <49089127-7189-4bdc-bbf9-5a3ecdc99659@linux.ibm.com>
 <87fr14sc8l.fsf@redhat.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <87fr14sc8l.fsf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 3w3sWh979Q47T-j_l-ML_FOYCfXhugCI
X-Proofpoint-ORIG-GUID: 3w3sWh979Q47T-j_l-ML_FOYCfXhugCI
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA1NiBTYWx0ZWRfX9eDxSsV41sd8
 vo2L8nUkPV8bzMA99aHW/HFtVUd4x7DcAWxsny37uBlLrKDkAjKWSx2OE57PgJBoCCHHLkZqf5f
 ciX2xy1cW4/fVTdVqjZW3DqI2tH6kvU=
X-Authority-Analysis: v=2.4 cv=dYuwG3Xe c=1 sm=1 tr=0 ts=6a684e96 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=NLiCwHATAAAA:8
 a=VnNF1IyMAAAA:8 a=TSjmaRUnQfWvMaOh7N0A:9 a=QEXdDO2ut3YA:10
 a=F9tHCgz3TLBaZgltkx5D:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA1NiBTYWx0ZWRfX96S9e3J5Mq4l
 8zZt4u4t6MghyYoX1c1a16ipwbE6ZnkwMWbFhZq0QraArd5pZZwcr9imu4aQoEnFqYRpZ8Gjm2D
 91V+IslTH7bZU3oHuPVGvEh0JzhAFKo+9wuVW+3G3Do+aPPyIZt1WGB/8HPFTFUN0sXOP+a+3mS
 BXEXjtmw2mU1mwoEFYeaaWOxfC0aQ/OSOXhyx9HbJHHOvNQm0b/BGlAs5r+2Q8u4ixrXQpPJs4F
 Qt/VO214IhMSvOcaT2pfXu4bNnUqF49SoWugJXJlMPwx73zhqO+sQDPkb/qweYBpDZaUVjBuHp8
 2ivoaRshqXEVI/EdrjszAHbuPbTxw4XtbqVqA43VoPyKbSYJCQrFjzsW4uMroGJ0EWNvTp6NARI
 A5RtoBhzWEPXoBS8mes0Er16yqgNPyohjTJYw+iFJihplHv12xsCIWnkwQitHxjz80frwvm8lM7
 cD37hgWucqDTba0oe4g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_01,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 phishscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280056
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=borntraeger@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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


Am 27.07.26 um 17:06 schrieb Cornelia Huck:
> On Mon, Jul 27 2026, Christian Borntraeger <borntraeger@linux.ibm.com> wrote:
> 
>> Am 27.07.26 um 14:14 schrieb Cornelia Huck:
>>> On Mon, Jul 27 2026, Christian Borntraeger <borntraeger@linux.ibm.com> wrote:
>>>
>>>> Cornelia, Eric, Matt,
>>>>
>>>> here are 5 more fixes for hardening QEMU against invalid input. Nothing
>>>> is strictly a security issues as defined in the policy. For example
>>>> https://qemu-project.gitlab.io/qemu/system/security.html says assert /
>>>> abort: If triggering the code path requires kernel privileges (or root
>>>> account access) in the guest, asserts/aborts in QEMU are a self
>>>> inflicted denial of service. These will not be treated as security
>>>> flaws, at most hardening bugs.
>>>> And if anyone can provide invalid boot loader content it can provide
>>>> anything to boot if secure boot is not available.
>>>> We should fix those anyway, probably even for 11.1
>>>
>>> Fixing: yes. For 11.1: how easy are they to trigger? For the bios fixes,
>>> I assume you need a broken/crafted disk image; I assume that for the
>>> other two, you need some buggy/misbehaving guest. Did you actually
>>> manage to trigger this via some kind of test case?
>>
>> Easy to trigger, but only with modified guests or modified zipls. Normal
>> guests will not trigger those.
> 
> Ok, so I think these would be suitable for the next release, but maybe
> with a cc:stable.
Ok with me. 



