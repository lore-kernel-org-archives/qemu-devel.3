Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3D54C61DFD
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 02:07:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1Dto-0000Rc-M1; Mon, 31 Aug 2026 22:06:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jdaley@linux.ibm.com>)
 id 1x1Dtm-0000Lv-8k; Mon, 31 Aug 2026 22:06:54 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jdaley@linux.ibm.com>)
 id 1x1Dtj-0006X4-Lv; Mon, 31 Aug 2026 22:06:53 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68111mP53993420; Tue, 1 Sep 2026 02:06:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=HNRG12
 bIWZUgz2s7zIt/q7ZJukOwHh7wKb3lGDSqrg4=; b=HLe1xRLDC1N2Nzz7tJAo/2
 JX9YXSEjMdXG6bnwbVqKLdvT3pm9E5pwaSwhp/05rFkvKn6MRRLWv/92rL8aagb2
 MexT7hiBgLS53E1o+B96VH8XnfP+PIczbhCHB4ajv1hgIxylOzjJvrpIHgCoUOj4
 0afkUMfmdgRRvL4OUY7GbB6vVHeM+Mu29lG831Nzl0DxfMBzC1aFqqID7gYnbVIe
 +XlDqw62t0lw+PlIGBldjW/tTk/25F1yLd7MVzHkJDFpl8OevX8LkNy1T6OJzqoq
 n9VhPBLe/m3kwS0JovGOxOYxd75ApK3WXha8mJeshial64i8UW92paNa3X0DHNlg
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq2t4vu7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Sep 2026 02:06:48 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6811uKUb016836;
 Tue, 1 Sep 2026 02:06:48 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gcark1a3c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Sep 2026 02:06:48 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68126kgL41419278
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 1 Sep 2026 02:06:47 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C48E158131;
 Tue,  1 Sep 2026 02:06:46 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2A7145812B;
 Tue,  1 Sep 2026 02:06:46 +0000 (GMT)
Received: from [9.61.253.112] (unknown [9.61.253.112])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  1 Sep 2026 02:06:46 +0000 (GMT)
Message-ID: <f7edb9f4-c6a4-45a7-9cf5-76020db74bab@linux.ibm.com>
Date: Mon, 31 Aug 2026 22:06:45 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 8/8] tests/qtest: Add s390x PCI SCSI fallback test to
 cdrom-test.c
To: jrossi@linux.ibm.com, qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 cohuck@redhat.com, mjrosato@linux.ibm.com
Cc: farman@linux.ibm.com, jjherne@linux.ibm.com, zycai@linux.ibm.com
References: <20260831194919.3830270-1-jrossi@linux.ibm.com>
 <20260831194919.3830270-9-jrossi@linux.ibm.com>
Content-Language: en-US
From: Joshua Daley <jdaley@linux.ibm.com>
In-Reply-To: <20260831194919.3830270-9-jrossi@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=bc1bluPB c=1 sm=1 tr=0 ts=6a963339 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=wL-UeyzXiPBlyIwwWGIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDAxNSBTYWx0ZWRfXw2S0mRz35vaO
 t+4gb3yhq/2m+TbET2xCGtBAsGOUoLHAy01G2KzFQHuzr8nceq8mjAZ4pDtFh21wszNF/KPMueH
 mNG4x9/dSx9Iz+K3S8a9fqzYwtvCMx4=
X-Proofpoint-ORIG-GUID: qF7iBhlQ7FU86dlPbtS5SwhaAbO7Zbv9
X-Proofpoint-GUID: qF7iBhlQ7FU86dlPbtS5SwhaAbO7Zbv9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDAxNSBTYWx0ZWRfX1pzbqVjHJhlW
 xE8CGsnKAN9MH40I1Y9p+Ntdm3NU2xQDftMwLmF0gfOknsOntuysOryDkFkCjHGsj3ud4xZHn2y
 SJf0MIKzgW2qTqjgI2x4bicamXCD7IvN3ggO7IbVN7utG82wCi/vgi07m9cvm3CVNlEcDSMk3cy
 LdU8IwDneKbeoFHBmJDWDxiQbce1lVpwrOf+lgPlGWYeq4ERgDLnOM+0JqOyXy/qlPVbLlJVrFm
 xlnt4QjIjbjr/OAs5vBkbjbIWvN6KTLTXMIwvXR97328KUjlvavyGX1zPQW2nHkoV2SJXkXKL1R
 x0UHaDss7dIo38RWs4GBF0MSpDzcZVna8JrEBE45VJSUkqAawsksFKF4FqzgaXwgwco7f4vPcPM
 rTha21SjKd9ILfkWq6jRRifjZ5vPNEnm/b/0EUJ7NTMU5ugxX6hs0hxLbbl2JDNccj0CWw+RxEd
 m1EpaMxajGUQWF36LfA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_01,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609010015
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

On 8/31/2026 3:49 PM, jrossi@linux.ibm.com wrote:
> From: Jared Rossi <jrossi@linux.ibm.com>
> 
> Add a test to verify that a guest can use a PCI controlled CD as a fallback boot
> device after a failed CCW IPL.
> 
> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
> ---
>   tests/qtest/cdrom-test.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/tests/qtest/cdrom-test.c b/tests/qtest/cdrom-test.c
> index a65854d2bc..ab34930404 100644
> --- a/tests/qtest/cdrom-test.c
> +++ b/tests/qtest/cdrom-test.c
> @@ -253,6 +253,14 @@ static void add_s390x_tests(void)
>                               "-drive if=none,id=d1,media=cdrom,file=",
>                               test_cdboot);
>       }
> +    if (qtest_has_device("virtio-scsi-pci")) {
> +        qtest_add_data_func("cdrom/boot/pci-scsi-fallback-from-blk-ccw",
> +                            "-device virtio-scsi-pci -device virtio-serial "
> +                            "-device virtio-blk-ccw,drive=d1,bootindex=1 "
> +                            "-drive driver=null-co,read-zeroes=on,if=none,id=d1 "
> +                            "-device scsi-cd,drive=d2,bootindex=2 "
> +                            "-drive if=none,id=d2,media=cdrom,file=", test_cdboot);
> +    }
>   }
>   
>   int main(int argc, char **argv)

Tested-by: Joshua Daley <jdaley@linux.ibm.com>

Note: need to install xorriso to run these tests. If it is not installed, they will not run, with no indication of why. In cdrom-test.c:main(), if the exec_xorrisofs check fails, we return g_test_run() early, without having added any subtests. Maybe a separate patch can add a message that is printed in that case.


meson test --suite qtest-s390x 'qtest-s390x/cdrom-test'

...
# starting QEMU: exec ./qemu-system-s390x -qtest unix:/tmp/qtest-185425.sock -qtest-log /dev/null -chardev socket,path=/tmp/qtest-185425.qmp,id=char0 -object monitor-qmp,id=qmp0,chardev=char0 -display none -audio none -run-with exit-with-parent=on -accel kvm -accel tcg -no-shutdown -device virtio-scsi-pci -device virtio-serial -device virtio-blk-ccw,drive=d1,bootindex=1 -drive driver=null-co,read-zeroes=on,if=none,id=d1 -device scsi-cd,drive=d2,bootindex=2 -drive if=none,id=d2,media=cdrom,file=cdrom-boot-iso-g8yma5  -accel qtest
ok 8 /s390x/cdrom/boot/pci-scsi-fallback-from-blk-ccw

Also, I was able to boot via virtio-scsi-pci manually:

qemu-system-s390x \
-nographic \
-accel kvm \
-m 1024 \
-machine s390-ccw-virtio \
-drive file=Fedora-Server-dvd-s390x-43-1.6.iso,media=cdrom,if=none,id=cdrom0 \
-device virtio-scsi-pci \
-device scsi-cd,drive=cdrom0,bootindex=1

