Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42239FDEE39
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 00:44:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wG4ew-0007fM-VT; Thu, 23 Apr 2026 20:44:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wG4eq-0007Oc-TX; Thu, 23 Apr 2026 20:44:38 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wG4eo-0005xs-DR; Thu, 23 Apr 2026 20:44:36 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63NHre4w982124; Fri, 24 Apr 2026 00:44:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=TLdlfV
 NFZDvxtqSD3pYF6NqyWGU/cRCDoXlYU+VoKYc=; b=IjrWFpDJlzpHK10558iclk
 qqAzptIUtTgaao5q/OP6kh8JkqWBNMpyo6dMs1pr0+sbpaS7DYTgjyV1oUEXzWtN
 cxe4WxZ6LG4d3g25MpShoEPWZHc5OdtQoOJMHfwseo29Rr5KyZ6lnoztsMtkibYM
 hY153VYPABhz51Txg2pCBwHDDikFr2HlrhkYOkB0DZb1QsfOY6iKFMSVIEoLDzVH
 k7CW2MifYIo4ED0wuIpSkzmEPKpcLl94uUbJ3ku5Et5y97NQ2MLiJw4osAliaPg9
 M8goI5tYOrLDFzu/WNE31JcsgR74Fp/LTd0LiFYO7eNOOBkYZn9LyWq732JtbsZg
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dpeu7tpwa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Apr 2026 00:44:30 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63O0ZMPC010897;
 Fri, 24 Apr 2026 00:44:30 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dpjky8thv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Apr 2026 00:44:30 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63O0iTj23539770
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 24 Apr 2026 00:44:29 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C276458059;
 Fri, 24 Apr 2026 00:44:29 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 380D65804B;
 Fri, 24 Apr 2026 00:44:29 +0000 (GMT)
Received: from [9.61.79.186] (unknown [9.61.79.186])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 24 Apr 2026 00:44:29 +0000 (GMT)
Message-ID: <9ff8cb74-8abc-4c9a-8f25-044cd4b9d921@linux.ibm.com>
Date: Thu, 23 Apr 2026 20:44:28 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/11] 11.1 compat machines and s390x updates
To: Stefan Hajnoczi <stefanha@gmail.com>, Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
References: <20260423094856.270215-1-cohuck@redhat.com>
 <CAJSP0QWFK9noq+CRRG4E1DM4HSyaHxHqmZytqzUHnu-_VsRjUA@mail.gmail.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <CAJSP0QWFK9noq+CRRG4E1DM4HSyaHxHqmZytqzUHnu-_VsRjUA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: kHukQ-36l6lIRDDTVM6q_ojPijaM-OSV
X-Authority-Analysis: v=2.4 cv=Ksp9H2WN c=1 sm=1 tr=0 ts=69eabcef cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=p0WdMEafAAAA:8
 a=20KFwNOVAAAA:8 a=G84QbbO70JEjHbqarpgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Ib4zD8ysY3yzZ1N6fn2OqBo4kVLKyVDQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI0MDAwMSBTYWx0ZWRfXxL0aibm3aELv
 daw4E3goCE9CE3ssYXS+vAvNGq8JeokCAzm9FJ5+vYMzZ+TrYxUJelgfgjabBS+Up3O3qC74cvc
 oKDPaG2qK66xhgryYFHE3kRlDHXdxcsZ7stM+YOV/IvDyxlKDM+UsHTtsWa9a+ZDx6ntcNtxdnm
 oL9BNAMAtLLTHOP/xUhxQVhP9Ux6pQtM23dr8KQ3TSiImJMe+0f77xyin+9TLwkN4ZoO3EiTQ6T
 WF8VcT3/Id7UJLW7f+DLPoWYxb3CB+AnL19xjYmtvz1ulJvJTLjia5RuxuPnwhifYRgtieuOzvj
 q61LVdE+ga/G6y1spVLIOJlI9PjPJKOLkbtgZeH68b/xiOIU2tO5EZptQhhm1eOe8j7HsUBS8p6
 u/LI8zcLl0FcNTAXZcilRUPOqmGIVDMPP5KkQ7N9zDjKNJG5MHsMxRIhyIrVAIvYUawkwM8vp2F
 L5WtPriPBUfj3i0CDVQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 adultscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604240001
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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

On 4/23/26 7:20 PM, Stefan Hajnoczi wrote:
> On Thu, Apr 23, 2026 at 5:50 AM Cornelia Huck <cohuck@redhat.com> wrote:
> 
>> The following changes since commit
>> 98b060da3a4f92b2a994ead5b16a87e783baf77c:
>>
>>   Update version for v11.0.0 release (2026-04-21 16:28:47 +0100)
>>
>> are available in the Git repository at:
>>
>>   https://gitlab.com/cohuck/qemu tags/s390x-20260423
>>
>> for you to fetch changes up to 83f5164d25634f9104b5fb4a6772766ae646ad59:
>>
>>   hw/s390x/ccw: Disable legacy virtio-pci by default (v11.1+) (2026-04-22
>> 11:28:03 +0200)
>>
>> ----------------------------------------------------------------
>> First batch of updates for 11.1:
>> - compat machines for 11.1
>> - s390x: simplifications, cleanups, and a new test
>>
> 
> Hi Cornelia,
> There is an s390x timeout regression in this pull request that reproduces
> both in the CI and locally:
> 
> $ make check-functional-s390x
> 13/13 qemu:func-thorough+func-s390x-thorough+thorough /
> func-s390x-ccw_virtio         TIMEOUT        420.07s   killed by signal 15
> SIGTERM


Hi Connie, it looks to me like the failure is due to disabling legacy
virtio-pci by default for s390x starting with 11.1.

I was able to get the test to pass again with the diff below.  But
wasn't sure, do we only care about the default/latest machine version
for functional tests? 

diff --git a/tests/functional/s390x/test_ccw_virtio.py b/tests/functional/s390x/test_ccw_virtio.py
index 0455337856..1d4958bbe2 100755
--- a/tests/functional/s390x/test_ccw_virtio.py
+++ b/tests/functional/s390x/test_ccw_virtio.py
@@ -136,7 +136,7 @@ def test_s390x_devices(self):
                     r'0x1af4')
         exec_command_and_wait_for_pattern(self,
                     r'cat /sys/bus/pci/devices/0005\:00\:00.0/subsystem_device',
-                    r'0x0001')
+                    r'0x1100')
         # check fid propagation
         exec_command_and_wait_for_pattern(self,
                     r'cat /sys/bus/pci/devices/000a\:00\:00.0/function_id',
@@ -203,7 +203,7 @@ def test_s390x_fedora(self):
                         'while ! (dmesg | grep enP7p0s0) ; do sleep 1 ; done',
                         'virtio_net virtio0 enP7p0s0: renamed')
         exec_command_and_wait_for_pattern(self, 'lspci',
-                             '0007:00:00.0 Class 0200: Device 1af4:1000')
+                             '0007:00:00.0 Class 0200: Device 1af4:1041')
         exec_command_and_wait_for_pattern(self,
                              'cat /sys/class/net/enP7p0s0/address',
                              '02:ca:fe:fa:ce:12')



