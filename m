Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8877AC98302
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 19:35:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x96Gg-0007TT-1w; Tue, 22 Sep 2026 15:35:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jdaley@linux.ibm.com>)
 id 1x96GW-0007Rj-AP; Tue, 22 Sep 2026 15:34:56 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jdaley@linux.ibm.com>)
 id 1x96GS-0003d9-7h; Tue, 22 Sep 2026 15:34:54 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68MI7eHs965180; Tue, 22 Sep 2026 19:34:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=OOIpPf
 7Zzxt2d0gfQMnDvXUPjt1Gn5UMoRwSzJwcO+M=; b=LNocAy2oJ9W0LCPOkGvHdg
 TKKuPQHn5o5jiyxVHT+ptbyx37hgR5EX80VoPim/4zpYJq1VQoVWZdEm/pVldzn7
 ZUfEoWLVNJKB8bBmVZZ/LdXYm8mnh4XukDs3r9msBl2Q0H2gntIOJz9BShmbuLhT
 E5jo6xLW8BundBmZto5LgCH+bO59N25oXRZLQ4cncl/krhh0w8wrVjN2qgf5kIEo
 4fNdMdAEmgyJfoUFkDgr7KY/WQgOkYpkLYNsDuohGGwaQhkiOZI4sWC7m7NxnXo/
 NS/VFeBT0+ZdEyvpQfCefCU9t1PbTAYmmnjlYU5ior/5DWQpLXUq/qePrm3mixmw
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gske1fbxu-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 22 Sep 2026 19:34:49 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68MIHsEt3279998; Tue, 22 Sep 2026 19:34:48 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gt4qqbbff-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 22 Sep 2026 19:34:48 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68MJYl5o31392352
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 22 Sep 2026 19:34:47 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 77A045805C;
 Tue, 22 Sep 2026 19:34:47 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3E1E258059;
 Tue, 22 Sep 2026 19:34:46 +0000 (GMT)
Received: from [9.57.45.223] (unknown [9.57.45.223])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 22 Sep 2026 19:34:46 +0000 (GMT)
Message-ID: <10bf42e6-1f50-47d5-b43e-3acb24ee47e8@linux.ibm.com>
Date: Tue, 22 Sep 2026 15:34:45 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/8] tests/qtest: Check s390x boot device support in
 pxe-test.c
To: Zhuoying Cai <zycai@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: mst@redhat.com, jrossi@linux.ibm.com, borntraeger@linux.ibm.com,
 jjherne@linux.ibm.com, cohuck@redhat.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, pasic@linux.ibm.com, farosas@suse.de,
 lvivier@redhat.com, pbonzini@redhat.com
References: <20260914193438.526407-1-zycai@linux.ibm.com>
 <20260914193438.526407-7-zycai@linux.ibm.com>
Content-Language: en-US
From: Joshua Daley <jdaley@linux.ibm.com>
In-Reply-To: <20260914193438.526407-7-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: kvJegoKCOHDtcTwaFpvHSsLRJyp2tzkJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDI4MCBTYWx0ZWRfX8mlI4q1koY3B
 CVaWiN+MZB9whpp3LfpFGJYtvyVmDKCiJo0O4LM68/AcwbaULsCsUEfKLv2irPQrsB2UaxWCVra
 ejNb8cXSjvfrcQr46Ij32/796u51n4yIO9j3il4ZMTgwTONOfcnhVdXtBcM2Ldz0JMA8Nu7hABd
 DHt/NHOX6wdEB9Dmy9Nlyg7KRhVapjJGsaDXR1KNVLAnDtvHod68hQVysDQLq2meGlYdHMkpveX
 lvZxolntSbIhLL/0W3oPoD1g+zMaFxixZ89c7zsONWwXC1ZHxBSWr4Ok1ANXNlWJVcP435Ehbwq
 eL9a9gLNVv4t1abwB/AI0fY0iKnCXaEBiZc62qwjOs57f9i0VTnhSGRxYcO2prZKECUivd/7Iys
 P86TaJKca70ApPGNMrX5HDxBgiaWPrlwXUA+LPjq5OEwEhNDNjwZfwg+PxETqWSoS5LeylvFfEb
 hermxJ4ebOKUV0d+j1Q==
X-Authority-Analysis: v=2.4 cv=O/KsLx9W c=1 sm=1 tr=0 ts=6ab2d859 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=LEGLlaIbr-4xVOpytVwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDI4MCBTYWx0ZWRfX1mxqRBwDNSEr
 gyp0FcxdaJmUIk34yDJRn1JCnCulEL5cT5sd7vmmanTRzPGVqMXWiAdi7A5cJ9PhyLk7JsDiw2W
 hUKtQTzy3J+LxvVY6XOZm5dddDc/5Y4=
X-Proofpoint-GUID: kvJegoKCOHDtcTwaFpvHSsLRJyp2tzkJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220280
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
> The pxe test for a net device does not fail gracefully when the
> s390-ccw.img in use was built without support for booting that device.
> 
> Add a boot_dev_support check that searches for a known string in the
> bios image to confirm boot support. If absent, the test is skipped
> gracefully instead of failing.
> 
> Also re-enable pxe-test in qtests_s390x, which was accidentally
> removed by commit 973d97feca93.
> 
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> ---
>   tests/qtest/meson.build |  1 +
>   tests/qtest/pxe-test.c  | 84 ++++++++++++++++++++++++++++++++++++++++-
>   2 files changed, 84 insertions(+), 1 deletion(-)
> 

...snip...
> diff --git a/tests/qtest/pxe-test.c b/tests/qtest/pxe-test.c
> index e85dec5a4e..8b6015b6cd 100644
> --- a/tests/qtest/pxe-test.c
> +++ b/tests/qtest/pxe-test.c

...snip...

> +static bool s390_bios_has_string(const char *needle)
> +{
> +    const char *contents;
> +    gsize len;
> +    bool found;
> +
> +    contents = s390_bios_load(&len);
> +    found = memmem(contents, len, needle, strlen(needle)) != NULL;
> +
> +    g_test_message("%s %s", needle, found ? "found" : "not found");
> +    return found;
> +}
How about:
g_test_message("\"%s\" %s in bios", needle, found ? "found" : "not found");

then

# Setup failed for virtio-net-pci not found

becomes

# "Setup failed for virtio-net-pci" not found in bios

--------------------------------------------------------------------------

Tested-by: Joshua Daley <jdaley@linux.ibm.com>

make check-qtest-s390x MTESTARGS="--setup=thorough qtest-s390x/pxe-test"

Bios with the string:

# Loaded /root/repos/qemu/build/qemu-bundle/usr/local/share/qemu/s390-ccw.img
# Network boot starting... found
# starting QEMU: exec ./qemu-system-s390x -qtest unix:/tmp/qtest-56871.sock -qtest-log /dev/null -chardev socket,path=/tmp/qtest-56871.qmp,id=char0 -object monitor-qmp,id=qmp0,chardev=char0 -display none -audio none -run-with exit-with-parent=on -accel kvm -accel tcg -machine s390-ccw-virtio -nodefaults -boot order=n -netdev user,id=net0,tftp=./,bootfile=tests/pxe-test-disk-KBoif7,ipv4=on,ipv6=off -device virtio-net-ccw,bootindex=1,netdev=net0   -accel qtest
ok 1 /s390x/pxe/ipv4/s390-ccw-virtio/virtio-net-ccw
...
# Using cached bios contents
# Network boot starting... found
# starting QEMU: exec ./qemu-system-s390x -qtest unix:/tmp/qtest-56871.sock -qtest-log /dev/null -chardev socket,path=/tmp/qtest-56871.qmp,id=char0 -object monitor-qmp,id=qmp0,chardev=char0 -display none -audio none -run-with exit-with-parent=on -accel kvm -accel tcg -machine s390-ccw-virtio -nodefaults -boot order=n -netdev user,id=net0,tftp=./,bootfile=tests/pxe-test-disk-KBoif7,ipv4=off,ipv6=on -device virtio-net-ccw,bootindex=1,netdev=net0   -accel qtest
ok 2 /s390x/pxe/ipv6/s390-ccw-virtio/virtio-net-ccw

Bios without the string:

# Loaded /root/repos/qemu/build/qemu-bundle/usr/local/share/qemu/s390-ccw.img
# Network boot starting... not found
ok 1 /s390x/pxe/ipv4/s390-ccw-virtio/virtio-net-ccw # SKIP The bios does not support booting this device
...
# Using cached bios contents
# Network boot starting... not found
ok 2 /s390x/pxe/ipv6/s390-ccw-virtio/virtio-net-ccw # SKIP The bios does not support booting this device


