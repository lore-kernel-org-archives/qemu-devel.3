Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14EF2F8D761
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 17:07:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDQAe-0002Zk-Hs; Thu, 16 Apr 2026 13:06:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nilay@linux.ibm.com>)
 id 1wDJhW-0007cM-7f; Thu, 16 Apr 2026 06:11:58 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nilay@linux.ibm.com>)
 id 1wDJhU-0000uj-Cl; Thu, 16 Apr 2026 06:11:57 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63G8wGlg1733768; Thu, 16 Apr 2026 10:11:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=PW+d0u
 usYcglTAyZdUGVF5INcu+1nsW+wWDFiizuqeE=; b=oiFg3qWq7zgRUBUoJHTwyE
 ASRQrnql3Rr7IUvVZwJZj1MzerY/nA4hXNFbjBe1MD61OGtmTAp9nwG7zzBO5tCz
 Mw+QAjpPtT9eDTtFVJB9KixNLcIyUBxzml1yLNGfasfTcGpKI0BhJcOr7KbI2Orh
 Ct39ur5sq1hIDu107u4G4VLbqQ7Z/iwd4TaNwhpib5DsdGCkTSmrafFBBgfns60V
 f/merYWoFyq9hmjk5zVWXnpM4DETy7WWq3q5nzBKymYXOLXfMbY8dqGx7riE91+p
 yo9ZCLHsOmV1IvrlQCDd85ZSmynZVy7hYv4g2fHSDf7vBhY8uHeihPqAVpxXhDGg
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dh89mbxu7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Apr 2026 10:11:48 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63G6PmIu015149;
 Thu, 16 Apr 2026 10:11:47 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dg0mstjqy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Apr 2026 10:11:47 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63GABkt223200434
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 16 Apr 2026 10:11:46 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B2F0A58066;
 Thu, 16 Apr 2026 10:11:46 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EB1D05804B;
 Thu, 16 Apr 2026 10:11:43 +0000 (GMT)
Received: from [9.123.7.57] (unknown [9.123.7.57])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 16 Apr 2026 10:11:43 +0000 (GMT)
Message-ID: <2160c130-eff7-4068-8377-6c28b89ac046@linux.ibm.com>
Date: Thu, 16 Apr 2026 15:41:42 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] NVMe namespace hotplug and drive reconnection support
To: John Meneghini <jmeneghi@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Klaus Jensen <its@irrelevant.dk>
Cc: mr-083 <matthieu@minio.io>, qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 kbusch@kernel.org, mr-083 <matthieu@min.io>
References: <20260409060155.94704-1-matthieu@min.io>
 <ad0lMYOrRa-K1Ach@AALNPWKJENSEN.aal.scsc.local>
 <20260414124221.GB111076@fedora>
 <0743e428-cde4-436a-9af4-7477271fd8ab@redhat.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <0743e428-cde4-436a-9af4-7477271fd8ab@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=I/dVgtgg c=1 sm=1 tr=0 ts=69e0b5e4 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=jsQgLUCoJTa5QCtIDiEA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: MNv83AAjAvJg8aGRF20FFjPfYMCBhvGz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDA5MiBTYWx0ZWRfX8sz1VGATontX
 Li9+JfOITsG9xZW3h33RIZDbkJHKSbAu2GMFEC+TVUdpcBRMYoWtRXevT1g5fXDQDjwUUyK3pVA
 K8cFJZAGpmug2/WnbJhLHMB6pWShc4cNjaT7S8QXSl5XNBrUPDYjvRuOXEKgvPXkayvBQKgHNyY
 TlFeySwbb9yuKU8HK1rEtu3LExQifOMXtFLcVi3HmO0jydTWTOAiihPvQ6B4ZjAESo3QmCUR1gz
 izYKUVThTmD2a1qvXyrWYDq03BmIK5zkgkIgzKYJDDoCXcuwcuBYVJ5yffePkoVg1yyNpnEYbXd
 omWNaJEG61lXkuTJTmn4RuKvTS8KJQht22wbp591Am3vWuuIzR94b9f674wi1SF0Q7OjrF/qhgf
 9FBK+yxuzxVKaAMfi9pPiplRa3WuhoLZcdlHiFdEuHvCLnf64oMU2MOZLB+1Zuqsrx87OxNXJdT
 I7gAyOCfaSqSSOBNp0w==
X-Proofpoint-ORIG-GUID: MNv83AAjAvJg8aGRF20FFjPfYMCBhvGz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_02,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 clxscore=1011 adultscore=0 lowpriorityscore=0
 suspectscore=0 impostorscore=0 phishscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604160092
Received-SPF: pass client-ip=148.163.158.5; envelope-from=nilay@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 16 Apr 2026 13:06:26 -0400
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

Hi John,

On 4/14/26 7:34 PM, John Meneghini wrote:
> Adding Nilay who has done a lot of work on nvme hot plug.
> 
> Nilay please take look at these patches and let us know if they can work on powerpc
> 
> I'll set up a test bed and try this out with x86_64.
> 

Thanks for looping me in.

I tested this patch series on pseries QEMU, and overall it works as expected.
For the first patch (NVMe namespace hotplug), the functionality behaves correctly
and achieves its intended goal. That said, from an NVMe specification perspective,
the operation appears closer to a namespace attach/detach rather than a traditional
“hotplug.” I understand that in the QEMU device model, this is framed as a hotplug
event, which is likely why the terminology is used here, but it may still be somewhat
confusing when viewed through the NVMe spec lens.

For the second patch (drive_insert), the implementation also works as intended on
pseries. However, I have a concern regarding how the backend is handled. The flow
effectively removes the backing storage using drive_del and later reattaches it
using drive_insert. While the expectation is to reconnect the same backing store,
there is currently no enforcement of this. As a result, it is possible—perhaps
unintentionally—to reattach a different backing file. If this happens, it may lead
to inconsistencies with the in-memory state maintained by the kernel (e.g., page
cache or filesystem metadata), especially if the original device was already in use
or mounted. This may potentially result in data corruption or undefined behavior
from the guest’s perspective. It might be worth considering whether some form of
validation or restriction should be added to ensure that the same backing store
is reattached, or at least to make this behavior more explicit.

Overall, both patches are functional on pseries, but the above points may be worth
addressing.

Thanks,
--Nilay

