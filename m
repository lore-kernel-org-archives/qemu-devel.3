Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1A02C5B572
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 20:02:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ww3X9-00085Q-Aa; Mon, 17 Aug 2026 16:02:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1ww3X7-00084x-TY; Mon, 17 Aug 2026 16:02:09 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1ww3X6-0007wD-5J; Mon, 17 Aug 2026 16:02:09 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67HIVmwk2219286; Mon, 17 Aug 2026 20:02:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=mS24EC
 rx2ZN1ODhngL7KHlSboD3mE8jmwUM+cpa3lK0=; b=shUL8+JA5y/HyPr7ASLptL
 BW9djuBluxizpz8AVkLE52n6TD5nLrKK1lmOhk9y0Lql4NQlrwgGmYjZoQ+YDL2h
 a4uOMjzWD9a/Z61DfTqN7IOzvb0PUr5jnwOxcZChXzF80NiQifaNIrpcI2EtpHxw
 nwrR1l4jZA7ok326uqEe8yFep5Uiu51Zc5byahNVmOtGZKYlMKGuqZGohWpARgGC
 nitLltgcwjGkBVbF+LFQVWMtC13nFh81xOTuivSxq+EiYUOozexQ5F3C1333f2vn
 molgk/oFQInSYihYgSa18+uW1dOrcR50uxP+mhyqaZTd7KRibq0/O/4+2KHh2POw
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2frt3p0y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Aug 2026 20:02:04 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67HJuMjG021649;
 Mon, 17 Aug 2026 20:02:03 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g32tvymcq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Aug 2026 20:02:03 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67HK22di62718274
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Aug 2026 20:02:02 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6ECA258062;
 Mon, 17 Aug 2026 20:02:02 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3159558054;
 Mon, 17 Aug 2026 20:02:01 +0000 (GMT)
Received: from [9.61.69.254] (unknown [9.61.69.254])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Mon, 17 Aug 2026 20:02:01 +0000 (GMT)
Message-ID: <89f410e5-b0f1-49f8-8e6e-8999b1d6fe78@linux.ibm.com>
Date: Mon, 17 Aug 2026 16:02:00 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/3] tests/functional/s390x/test_secure_ipl: Add
 virtio-blk-pci boot dev case
To: Joshua Daley <jdaley@linux.ibm.com>, qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, zycai@linux.ibm.com, borntraeger@linux.ibm.com,
 jjherne@linux.ibm.com, pasic@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, richard.henderson@linaro.org,
 iii@linux.ibm.com, david@kernel.org, cohuck@redhat.com
References: <20260812152112.3330493-1-jdaley@linux.ibm.com>
 <20260812152112.3330493-4-jdaley@linux.ibm.com>
Content-Language: en-US
From: Jared Rossi <jrossi@linux.ibm.com>
In-Reply-To: <20260812152112.3330493-4-jdaley@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=OfaoyBTY c=1 sm=1 tr=0 ts=6a8368bc cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=KD8XR-cNDDLtVoqGBqwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDE1MyBTYWx0ZWRfX87FqV0QCCXZs
 /9prszy7PNn7ZR3RI8BK3c1PbyY9RxQyDfn7FkdrmvrkQehZCaTJfXIg795i4jLdpHrtgkzKLmM
 9rg1zk+NoZIktpZjZNDZMwjte1j1kB4=
X-Proofpoint-GUID: A0vx7DmOHkNH2PTuTExgNe3wnDo5exh2
X-Proofpoint-ORIG-GUID: A0vx7DmOHkNH2PTuTExgNe3wnDo5exh2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDE1MyBTYWx0ZWRfX3Qnbz3g96Nu7
 2lo6C1n9f8FOTY57QEBx8ZzfivX3TJy4AgySM7JP8zzA/HZgVBFctnJXPLf0P96cP7eG6aS+UC9
 uhCHJJXwy4sYtCdAlaUNCyqDj6eaGe+l+qHvz/PfrDqKj9SXq4ZqakIim8yu0eu/v9JXWJoyewM
 qbvBJKUf2mg2BP/YlHhSPkZtwyHt9LPIrMfTyrJ5sbnnUppWw0QnxaZQgMnIchyDsnpK8K9OCW6
 1Yv5clWv55yHR9N7h846+jAjMaGwsobFo11jUI+wJbn15hOTzk+SS5isKLCCWoP1RwEErtX/V6W
 5xOYu9DnmBhpIj26ppk/V41C6LxaRAy+axfWAaceGlVGoIb9GPA/xT6ZsF4D6qWnlkEe5RAHnMb
 5lhrjBZpzaingzK91eSgnjnH1tOahDi5onhChwWyTPFAmhmxUrP5hu0urvR0OOnCsGQnN8cOz69
 1HFULQ3NOvJRWauBZSA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 phishscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608170153
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jrossi@linux.ibm.com;
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



On 8/12/26 11:21 AM, Joshua Daley wrote:
> Split test_s390x_secure_ipl() into two subtests. Each tests with a
> different boot device: virtio-blk-ccw or virtio-blk-pci. Use a state var
> such that the setup is run only once.
>
> Signed-off-by: Joshua Daley <jdaley@linux.ibm.com>
> ---
>   tests/functional/s390x/test_secure_ipl.py | 70 +++++++++++++++--------
>   1 file changed, 47 insertions(+), 23 deletions(-)
>
> diff --git a/tests/functional/s390x/test_secure_ipl.py b/tests/functional/s390x/test_secure_ipl.py
> index 5af36b91d8..7fd4cfeaab 100755
> --- a/tests/functional/s390x/test_secure_ipl.py
> +++ b/tests/functional/s390x/test_secure_ipl.py
> @@ -28,6 +28,7 @@ def __init__(self, *args, **kwargs):
>           self.qcow2_path = None
>           self.cert_path = None
>           self.prompt = None
> +        self.setup_done = False
>   
>       def _require_host_secure_ipl_support(self, vm):
>           """
> @@ -150,41 +151,64 @@ def setup_s390x_secure_ipl(self):
>   
>           # Shutdown temp vm
>           temp_vm.shutdown()
> +        self.setup_done = True
>   
> -    @skipBigDataTest()
> -    def test_s390x_secure_ipl(self):
> +    def verify_s390x_secure_ipl(self, boot_dev_bus: str):
>           """
>           Verify secure boot validation during s390x guest boot.
>   
>           Expects two "Verified component" messages and confirms
>           /sys/firmware/ipl/secure reports secure boot is active.
>           """
> -        self.require_accelerator('kvm')
> -        self.setup_s390x_secure_ipl()
> -
> -        self.set_machine('s390-ccw-virtio')
> -
> -        self.vm.set_console()
> -        self.vm.add_args('-nographic',
> -                         '-machine', 's390-ccw-virtio,secure-boot=on,'
> -                         f'boot-certs.0.path={self.cert_path}',
> -                         '-accel', 'kvm',
> -                         '-m', '1024',
> -                         '-drive',
> -                         f'id=drive1,if=none,format=qcow2,file={self.qcow2_path}',
> -                         '-device', 'virtio-blk-ccw,drive=drive1,bootindex=1')
> -        self.vm.launch()
> +        if boot_dev_bus not in ['ccw', 'pci']:
> +            raise ValueError(
> +                f"boot_dev_bus must be 'ccw' or 'pci', got {boot_dev_bus}")
> +
> +        vm = self.get_vm(name=f'sipl_test_vblk_{boot_dev_bus}')
> +        vm.set_machine('s390-ccw-virtio')
> +
> +        vm.set_console()
> +        vm.add_args('-nographic',
> +                    '-machine', 's390-ccw-virtio,secure-boot=on,'
> +                    f'boot-certs.0.path={self.cert_path}',
> +                    '-accel', 'kvm',
> +                    '-m', '1024',
> +                    '-drive',
> +                    f'id=drive1,if=none,format=qcow2,file={self.qcow2_path}',
> +                    '-device',
> +                    f'virtio-blk-{boot_dev_bus},drive=drive1,bootindex=1')
> +        vm.launch()
>   
>           # Expect two verified components
>           verified_output = "Verified component"
> -        wait_for_console_pattern(self, verified_output)
> -        wait_for_console_pattern(self, verified_output)
> +        wait_for_console_pattern(self, verified_output, vm=vm)
> +        wait_for_console_pattern(self, verified_output, vm=vm)
>   
>           # Login and verify the vm is booted using secure boot
> -        wait_for_console_pattern(self, 'localhost login:')
> -        exec_command_and_wait_for_pattern(self, 'root', 'Password:')
> -        exec_command_and_wait_for_pattern(self, self.root_password, self.prompt)
> -        exec_command_and_wait_for_pattern(self, 'cat /sys/firmware/ipl/secure', '1')
> +        wait_for_console_pattern(self, 'localhost login:', vm=vm)
> +        exec_command_and_wait_for_pattern(self, 'root', 'Password:', vm=vm)
> +        exec_command_and_wait_for_pattern(
> +            self, self.root_password, self.prompt, vm=vm)
> +        exec_command_and_wait_for_pattern(
> +            self, 'cat /sys/firmware/ipl/secure', '1', vm=vm)
> +
> +        vm.shutdown()
> +
> +    @skipBigDataTest()
> +    def test_s390x_secure_ipl_ccw(self):
> +        """Test secure IPL with a virtio-blk-ccw boot device."""
> +        self.require_accelerator('kvm')
> +        if not self.setup_done:
> +            self.setup_s390x_secure_ipl()
> +        self.verify_s390x_secure_ipl('ccw')
> +
> +    @skipBigDataTest()
> +    def test_s390x_secure_ipl_pci(self):
> +        """Test secure IPL with a virtio-blk-pci boot device."""
> +        self.require_accelerator('kvm')
> +        if not self.setup_done:
> +            self.setup_s390x_secure_ipl()
> +        self.verify_s390x_secure_ipl('pci')
>   
>   if __name__ == '__main__':
>       QemuSystemTest.main()
Reviewed-by: Jared Rossi <jrossi@linux.ibm.com>

