Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 634E3C61DB9
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 19:27:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wywnc-00081E-7H; Tue, 25 Aug 2026 15:27:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wywnZ-00080T-NK; Tue, 25 Aug 2026 15:27:05 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wywnY-00077h-5n; Tue, 25 Aug 2026 15:27:05 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67PI1tOg1661547; Tue, 25 Aug 2026 19:27:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=QOaI7L
 1PXjsW/n37GWVoHq6tT5ZBqAuCkDp8Ii895wA=; b=ZgChdyx0HqQyF0Vi4bsIj+
 3H629fPNP6As7jHa0rRPOlaof5OVftizf30N1QOG0HoC2u48m83sfDVF5Qpv4zZY
 mQUxm/M98zrmXCdEjjd4CBJUBVTSBe947bwKbGGenU43Bpwq/uj3v3I9vRCvH949
 heZZ7sYOT9phLYEYnuFbUu9BEMCPIYT1Ubp3cBFJux5ry17ZWvXs650Ypg9mTGQS
 +MBVhEdq2HyUgsbDOrYlGpFq4HnDTX8f8rLfqLMiJhud3pD0EyN4Fgg4B2mIbMFS
 XB73IL4WnHm+eMlImzk0FIrHfGYgD+j7sokPVyvjPYYdS5An1MdAIPQSRG7sf+HA
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73dxa2ee-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 25 Aug 2026 19:27:00 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67PJQHMV019721;
 Tue, 25 Aug 2026 19:26:59 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7qkh60rg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 25 Aug 2026 19:26:59 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67PJQwgi32506506
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 25 Aug 2026 19:26:58 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A8EBF58056;
 Tue, 25 Aug 2026 19:26:58 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2B9A058052;
 Tue, 25 Aug 2026 19:26:58 +0000 (GMT)
Received: from [9.61.21.147] (unknown [9.61.21.147])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 25 Aug 2026 19:26:58 +0000 (GMT)
Message-ID: <a4ffeab2-82d1-4100-ae25-c00c2d562c7e@linux.ibm.com>
Date: Tue, 25 Aug 2026 15:26:57 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/8] hw/s390x/ipl: Fix incorrect PCI IPL block length
 constant
To: Jared Rossi <jrossi@linux.ibm.com>, Zhuoying Cai <zycai@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org, cohuck@redhat.com,
 "Jason J . Herne" <jjherne@linux.ibm.com>
References: <20260811144629.866641-1-jrossi@linux.ibm.com>
 <20260811144629.866641-3-jrossi@linux.ibm.com>
 <51730ac3-ff1f-4eca-98f9-b31b47596185@linux.ibm.com>
 <1bf6e2a3-be53-47b3-8694-9b249770a655@linux.ibm.com>
 <0ba0a7aa-623a-48e3-bde9-48ee82331d1a@linux.ibm.com>
 <36b43f47-32d7-4ff0-ad76-2d1ab1df2c7f@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <36b43f47-32d7-4ff0-ad76-2d1ab1df2c7f@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDE2MiBTYWx0ZWRfX3fBF9aioJlob
 dniGGwzjKzutck4qaCkfNjIScnJPxY/Z6z5QZHduIMAwgZ8z7gvCAAdLYIJPdf7o4mxG/zd3cX5
 hTN4OEWaFTb2sZgs72CgxHkrQqmio/4=
X-Authority-Analysis: v=2.4 cv=AYuB2XXG c=1 sm=1 tr=0 ts=6a8dec84 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=-ZfgVfZnYPOhb2TOWeoA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: vBqr-V0ZbINvH5cZE68LvzPZYpaHQXPB
X-Proofpoint-GUID: vBqr-V0ZbINvH5cZE68LvzPZYpaHQXPB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDE2MiBTYWx0ZWRfX2/t99cYMpjbW
 Ovrcr1lOk8xAmlDQ7AvmXQ2CGxeGwqiMXDfn4w6Otf12iuDGKbQ/kC08bLWUH1O6stJbhZI7cpS
 yx/0i65yrka59olBrJG1aa36pz5zTuwm+qBiXnKekAjcxIZ9yMJ1DYxKvvv8hfW9ff7q+E3FG47
 IW3zGThZh8OJsgfWrcvKV6oescGOD15MvyKZWnLpbx9fw1uZ7voQsepv+P7buEVmn/SAGhCA1fb
 61AsTzc6JD3q6OiGZV9b9FCMJR53USLeH69HdQAJfhWy2Ur1/BhU/7QAn9T2NlGh6oMG5WHOv1W
 lVPh43gOW5UhexSwXHeo10gDsJgR6hij3wskVo0s0VSmjx8Kyw5TOTZ8w+sxRFt5fDbkfkhddBi
 ykdJ10JU8AGNy5npcvpoA6OEEHCv7qALJ5VHvr0mGEt81QF/Uu6plWPLQ0xS5MsQPgYSDf3uXgL
 fZ8loemHlVzYSzZokRQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_05,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608250162
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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


>>>>
>>> Given that, should the #define be sizeof(IplBlockPci) + 24?
>>>
>> If IplBlockPci is likely to expand in the future, it might make sense to
>> derive this value from the structure layout. For example,
>> offsetof(IplParameterBlock, pci) + sizeof(IplBlockPci) could be more
>> accurate. Otherwise, keeping it as a constant like the other definitions
>> seems reasonable as well.
> 
> All of those suggestions would be valid, but I'm leaning toward keeping it
> defined without using sizeof() for the sake of consistency if nothing
> else.  The other IPLB types are already defined as fixed numbers and for
> the IplBlockQemuScsi being used later in this patch series, it actually has
> a minimum value that is less than the sizeof() itself due to the same
> struct
> servicing both PCI and CCW controllers, where the minimum size for CCW is
> less than PCI.
> 
> I can envision several ways to improve the definitions and/or naming
> conventions, but I think it is outside the scope of this series because the
> changes should be uniformly applied to all definitions, not just PCI.

Ehh...  If you already think the other definitions should be fixed then
convention is not a good enough reason to propagate the bad practice to
new code.  Doing the new definition the right way now in this patch is
certainly within the scope of this series.

If we have structures that define the entire 336 bytes, I personally
would much prefer to see that written out with sizeof()s vs a magic
number that coincidentally must line up with the size of one or more
well-defined structures.

As for existing definitions, I agree that is out of scope: you could
follow-up later with one or more patches that cleanup the existing
definitions.

Thanks,
Matt

