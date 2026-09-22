Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D5BBC982FA
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 19:38:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x96JG-0000oC-5W; Tue, 22 Sep 2026 15:37:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jdaley@linux.ibm.com>)
 id 1x96JD-0000mk-IP; Tue, 22 Sep 2026 15:37:43 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jdaley@linux.ibm.com>)
 id 1x96JC-0003xk-0M; Tue, 22 Sep 2026 15:37:43 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68MI7Z8h965132; Tue, 22 Sep 2026 19:37:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=uNvIyp
 kbaZ4MwmTZNFsAMNd/d72KsmJlTQWQi+AjhIg=; b=MUbCSE2xFHDaLkjsl1KcDO
 viqfJpuE7y5gVkkMtqiw5vyPP2/T/k6D11zIxAyfJ504n9M7IlNLo6VNnA3Mvuk5
 YPRDdURNRCiDqBORtMDjmu3t/kFjzTi5rG4DucjnhY9y7hSAggMSV93hgW0eW+z6
 0+VoOPrY7gvuKzeHKFk+CyX/adJLeOgjRuHe9up0muFzgTZjFFeZCuwrenlJ3ioK
 I02UndAhJux7qRks4/h7S1kwT9OhXBzIPWB5YfroEc4o0cAkfKA3RRP8ly52vZ2l
 Woo+BJyDWA4echZXrWGiEKVHxGdfR8o0wd/tV8S0PBfPUgcxgt/r7ODCW6jQQYCQ
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gske1fc6y-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 22 Sep 2026 19:37:40 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68MIHb6d3220323; Tue, 22 Sep 2026 19:37:40 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gt53vka86-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 22 Sep 2026 19:37:40 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68MJbcKD13107724
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 22 Sep 2026 19:37:39 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9186F5805C;
 Tue, 22 Sep 2026 19:37:38 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6FCF458058;
 Tue, 22 Sep 2026 19:37:37 +0000 (GMT)
Received: from [9.57.45.223] (unknown [9.57.45.223])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 22 Sep 2026 19:37:37 +0000 (GMT)
Message-ID: <774c684d-edff-4771-90ac-58bd21aaab4a@linux.ibm.com>
Date: Tue, 22 Sep 2026 15:37:36 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/8] tests/qtest: Add s390x virtio net PCI test to
 pxe-test.c
To: Zhuoying Cai <zycai@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: mst@redhat.com, jrossi@linux.ibm.com, borntraeger@linux.ibm.com,
 jjherne@linux.ibm.com, cohuck@redhat.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, pasic@linux.ibm.com, farosas@suse.de,
 lvivier@redhat.com, pbonzini@redhat.com
References: <20260914193438.526407-1-zycai@linux.ibm.com>
 <20260914193438.526407-8-zycai@linux.ibm.com>
Content-Language: en-US
From: Joshua Daley <jdaley@linux.ibm.com>
In-Reply-To: <20260914193438.526407-8-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: -rOIwfBySJzlw_zT-yY_ba869KThWhbX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDI4NyBTYWx0ZWRfX7+CYCzwIdP0b
 gO5wG6IGZ9CyN7qq0ox+r0f3vpL9CJBMf5C6w1zZKPf00uXO05+ujzFvreF7KfGAPh/QXCzthuf
 EBcA13vRGDP1i1BgmtddeEW5mFr7YtaVmutSF7QW1PFQE3CHwnWFHM6dvZR7np+zMnbkbYKS+YG
 nIfsEmVHmRHIVTLNYW7xu/8wwfVV2UmH2E0gjJo9jDl/0r7W5wSeq7pryXYgMFgDkbPcpfjggHa
 POmuRsh4Gr1xj4l3/Mkb59OqaNS37qbEBxCU2ENW1xV+x3A1IbDUH/KKNDYV5gDN/ZR8leMp6vA
 m/mT+YtfRB7gWoW0ALHIQ+pY60fBUnHkgn/Lbk3dWZxTXdWoNxZ8fZRukW6mpzheJ+n4s7/4Hri
 4edoZ9BWY8r+aaG8abU0rZDupqStyWj9MajOjZibsoczhyd1F9QBaPoK7DqECAd6j80IRL58Y5B
 fLLHeNplnJuH0Ci3e3Q==
X-Authority-Analysis: v=2.4 cv=O/KsLx9W c=1 sm=1 tr=0 ts=6ab2d904 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=IRfdFlLoIuNrUPaBy-QA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDI4NyBTYWx0ZWRfX+6g7EpT54BlT
 5F2evhL7mfx451DUH6SB69lgHGHVfGia0t45+T/EhiaKQ32E4om9nSQzyGtNRUWy3lqZnSeMLYY
 P4mY0Luj08ogKCPKQopjpXnRQraPvr4=
X-Proofpoint-GUID: -rOIwfBySJzlw_zT-yY_ba869KThWhbX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220287
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jdaley@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

On 9/14/2026 3:34 PM, Zhuoying Cai wrote:
> Add test coverage for virtio-net-pci network booting on s390x by
> including it in the PXE test suite. The test verifies that PXE
> network booting works correctly with virtio-net-pci devices.
> 
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> ---
>   tests/qtest/pxe-test.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/tests/qtest/pxe-test.c b/tests/qtest/pxe-test.c
> index 8b6015b6cd..c29386ed4b 100644
> --- a/tests/qtest/pxe-test.c
> +++ b/tests/qtest/pxe-test.c
> @@ -129,9 +129,16 @@ static bool s390_bios_has_net_ccw(void)
>       return s390_bios_has_string("Network boot starting...");
>   }
>   
> +static bool s390_bios_has_net_pci(void)
> +{
> +    return s390_bios_has_string("Setup failed for virtio-net-pci");
> +}
> +
>   static testdef_t s390x_tests[] = {
>       { "s390-ccw-virtio", "virtio-net-ccw",
>         .boot_dev_support = s390_bios_has_net_ccw },
> +    { "s390-ccw-virtio", "virtio-net-pci",
> +      .boot_dev_support = s390_bios_has_net_pci },
>       { NULL },
>   };
>   

Tested-by: Joshua Daley <jdaley@linux.ibm.com>

make check-qtest-s390x MTESTARGS="--setup=thorough qtest-s390x/pxe-test"

Bios with the string:

# Setup failed for virtio-net-pci found
# starting QEMU: exec ./qemu-system-s390x -qtest unix:/tmp/qtest-57259.sock -qtest-log /dev/null -chardev socket,path=/tmp/qtest-57259.qmp,id=char0 -object monitor-qmp,id=qmp0,chardev=char0 -display none -audio none -run-with exit-with-parent=on -accel kvm -accel tcg -machine s390-ccw-virtio -nodefaults -boot order=n -netdev user,id=net0,tftp=./,bootfile=tests/pxe-test-disk-u0HvTJ,ipv4=on,ipv6=off -device virtio-net-pci,bootindex=1,netdev=net0   -accel qtest
ok 2 /s390x/pxe/ipv4/s390-ccw-virtio/virtio-net-pci
...
# Setup failed for virtio-net-pci found
# starting QEMU: exec ./qemu-system-s390x -qtest unix:/tmp/qtest-57259.sock -qtest-log /dev/null -chardev socket,path=/tmp/qtest-57259.qmp,id=char0 -object monitor-qmp,id=qmp0,chardev=char0 -display none -audio none -run-with exit-with-parent=on -accel kvm -accel tcg -machine s390-ccw-virtio -nodefaults -boot order=n -netdev user,id=net0,tftp=./,bootfile=tests/pxe-test-disk-u0HvTJ,ipv4=off,ipv6=on -device virtio-net-pci,bootindex=1,netdev=net0   -accel qtest
ok 4 /s390x/pxe/ipv6/s390-ccw-virtio/virtio-net-pci

Bios without the string:

# Setup failed for virtio-net-pci not found
ok 2 /s390x/pxe/ipv4/s390-ccw-virtio/virtio-net-pci # SKIP The bios does not support booting this device
...
# Setup failed for virtio-net-pci not found
ok 4 /s390x/pxe/ipv6/s390-ccw-virtio/virtio-net-pci # SKIP The bios does not support booting this device


