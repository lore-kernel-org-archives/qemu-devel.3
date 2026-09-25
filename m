Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65B34C9830E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 16:52:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xA99V-0003dJ-9r; Fri, 25 Sep 2026 12:52:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1xA99L-0003b5-UZ; Fri, 25 Sep 2026 12:51:52 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1xA99J-0003Ou-7t; Fri, 25 Sep 2026 12:51:50 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68PG5S1j3853825; Fri, 25 Sep 2026 16:51:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=zNSu+U
 E+d2Em/hWRxiY1fobwGJA9W80DlE0DCXH/p4M=; b=iHQEmr78RVxZcgctrx+KPQ
 JB5Eq7mxOvk0WLXUsGBB5JrrNmIHIxdPPKgRULtDo1+p2i2Hu45pR83+Zk2HcSbP
 QUhcw2ZXNirBxa1X62Wc3bXjgtLuoD/RJYw8nj+azoPM458pXiCJab3V8j/53blu
 Evk2v2mYji+5p5fw+XRdaBNES7FIZFAiiTLjSXkas565/Db2q+fZs8N8Ue288thy
 7ZYOW6OqIKny1sXqPds8lhEPXEoutlleni4MJe5ig2MLcni1FH7inYaaD5auM1g/
 UrfiYsyZJCo79TnrSf0aCoef300DsoFqMgAPLKYOEoJzrMj5kUacY0TxG1tdjQbA
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gske285ku-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 25 Sep 2026 16:51:45 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68PG33dB4191778; Fri, 25 Sep 2026 16:51:44 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gvb8k374d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 25 Sep 2026 16:51:44 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68PGphBq2425358
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 25 Sep 2026 16:51:43 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 30A2F58059;
 Fri, 25 Sep 2026 16:51:43 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B5C9D58053;
 Fri, 25 Sep 2026 16:51:41 +0000 (GMT)
Received: from [9.61.148.101] (unknown [9.61.148.101])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Fri, 25 Sep 2026 16:51:41 +0000 (GMT)
Message-ID: <73a91ec0-12b2-4db4-a209-62c91685d6bd@linux.ibm.com>
Date: Fri, 25 Sep 2026 12:51:40 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 7/8] tests/qtest: Add s390x virtio net PCI test to
 pxe-test.c
To: Matthew Rosato <mjrosato@linux.ibm.com>,
 Zhuoying Cai <zycai@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: mst@redhat.com, borntraeger@linux.ibm.com, jjherne@linux.ibm.com,
 cohuck@redhat.com, farman@linux.ibm.com, pasic@linux.ibm.com,
 farosas@suse.de, lvivier@redhat.com, pbonzini@redhat.com,
 jdaley@linux.ibm.com
References: <20260924194837.80732-1-zycai@linux.ibm.com>
 <20260924194837.80732-8-zycai@linux.ibm.com>
 <032734ca-0c40-4e85-97ec-bfb1240199d8@linux.ibm.com>
Content-Language: en-US
From: Jared Rossi <jrossi@linux.ibm.com>
In-Reply-To: <032734ca-0c40-4e85-97ec-bfb1240199d8@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: -o00YzcH8RUwX5lBwpQJx6l_XiYEX9ZR
X-Authority-Analysis: v=2.4 cv=EOCTQFZC c=1 sm=1 tr=0 ts=6ab6a6a1 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=JO3BLXImQ-Fy3Z_aLiYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA2NiBTYWx0ZWRfX5EuM6oljkOkp
 HwtpwfdiuKXodFuHGP6ZqpNYr+IAriNByua/0iW+ew8gbG68oRSB1G3oFnZMTclJFrmeJQp474+
 e7P1I/k5ADvU40NRV3+FlxwnquWTm9Y=
X-Proofpoint-GUID: -o00YzcH8RUwX5lBwpQJx6l_XiYEX9ZR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA2NiBTYWx0ZWRfX6lT92Vo/tYni
 S4nf9vMudL0vUcOKG4lM8H5u40tFri4+HKBRRR+zhkP2trw542So9EyugiLw2K87U8qXU2q8uug
 yl+QZS/O0nyKe164v0LTvpxTlq5rv7qdj/jjE9XEHJzfy0ZCJAkeYqFgW2DMawk/8gGZZhdRgzy
 dgY2W7Dt8AZhrQ3i5KNjuNPjxZwONHhjWnx8rkvpBAkwvEamnkvw1uHM8IsfGOC4b8lGyv3Wkqj
 iJCoCGgmFVkEXiGWAjq9CbAy1/udzSw1CcJb+Y+xf57fMRvWDcbwWePEFX2PwOL8232JjwYazAA
 XS55fHvMVr6MLHwZ2MKv5gt51ZS8uLfmLKUpdVisqzaihPglPcYWnrGDbgq1kTzK83X9YfBp2Az
 6fSwhU+diLQ11CXZgE6eB8uFbONT/S7/yM3JmjfZpTLa/hG3UmIzakFGWEOkgWTEvcWDTomxC24
 LSyOS4HXY6MndqPGqkQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250066
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jrossi@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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



On 9/24/26 5:15 PM, Matthew Rosato wrote:
> On 9/24/26 3:48 PM, Zhuoying Cai wrote:
>> Add test coverage for virtio-net-pci network booting on s390x by
>> including it in the PXE test suite. The test verifies that PXE
>> network booting works correctly with virtio-net-pci devices.
>>
>> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
>> Tested-by: Joshua Daley <jdaley@linux.ibm.com>
> It's still kind of confusing, but this is a little better.
>
> Not sure if we will need to come up with a better way of identifying the
> existence of a feature for s390x bios in the future, but for now:
>
> Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>

Probably the normal console messages just need to be updated. Currently
it prints a message like "using virtio-blk" or "netboot started" and that
was fine when only CCW was supported for those devices, but now that there
are a lot more device/bus combinations I think we need to be more verbose.
That would make feature checks easier and also provide better diagnostic
output in general.

In the meantime, this particular output could be clarified by simply using
a substring of the same string literal:

     return s390_bios_has_string("virtio-net-pci");

Will result in:

     # "virtio-net-pci" found in bios

(or not found) which is much more logical to me.  I wouldn't respin the
series just for that though since the test itself does work as intended.

Reviewed-by: Jared Rossi <jrossi@linux.ibm.com>

