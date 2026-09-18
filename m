Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55BB6C982D8
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 18:44:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7dYy-0008RI-WA; Fri, 18 Sep 2026 14:43:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1x7dYf-0008P4-4S; Fri, 18 Sep 2026 14:43:38 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1x7dYd-0006Or-5o; Fri, 18 Sep 2026 14:43:36 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68IH1rw3660624; Fri, 18 Sep 2026 18:43:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=GHgZoH3AlE5hs/FJyj6VsFCZdlcNfj
 QNnacKpoe5IcE=; b=dzt5pprumP5s43euAo4/d5N30dqk5LBC0M+6FGuPq4laOd
 4tcNodmCSPsZH4f9bknuOZRiShPRALaqAoSqwPfWY/86pALBwYqcT7dD7nfvBW19
 fLEH6DZhEVDt46eW2Qn9w5zdADmMzRAF6Pl0UBZPsZfXQMg0B+TFA4DKdDmqZ9Lu
 /6hPA9lNvHVYTXjEwlqRTBDslmIeqmL5/8iVvUN3+jvA5G7FGRQ1Avtr8JYmwT5E
 Vss5tTWq6mDwZfP7WoO3M5pevzIRuuQIIMU+tHyeKKkegA0X/qo2nDWtL0xxHhRF
 iCGN/wOvd1J7IGp0I5QxeOoY8tmMVA/jKsqz982Q==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmw5eh9bv-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 18 Sep 2026 18:43:32 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68IGp3TM983720; Fri, 18 Sep 2026 18:43:31 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gs56q9gdn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 18 Sep 2026 18:43:31 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68IIhRwf51511766
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 18 Sep 2026 18:43:27 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A6C3020043;
 Fri, 18 Sep 2026 18:43:27 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5F30B20040;
 Fri, 18 Sep 2026 18:43:25 +0000 (GMT)
Received: from fedora (unknown [9.5.7.39])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Fri, 18 Sep 2026 18:43:25 +0000 (GMT)
Date: Sat, 19 Sep 2026 00:21:11 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Aniket Sahu <asahu1x@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, npiggin@gmail.com,
 rathc@linux.ibm.com, milesg@linux.ibm.com, harshpb@linux.ibm.com,
 anushree.mathur@linux.ibm.com, misanjum@linux.ibm.com,
 adityag@linux.ibm.com, gautam@linux.ibm.com, thuth@redhat.com
Subject: Re: [PATCH v2 1/2] tests/functional/ppc64: extend pseries migration
 tests
Message-ID: <20260919002034.1d2bad71-fa-amachhiw@linux.ibm.com>
Mail-Followup-To: Aniket Sahu <asahu1x@linux.ibm.com>, 
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org, npiggin@gmail.com,
 rathc@linux.ibm.com, 
 milesg@linux.ibm.com, harshpb@linux.ibm.com, anushree.mathur@linux.ibm.com, 
 misanjum@linux.ibm.com, adityag@linux.ibm.com, gautam@linux.ibm.com,
 thuth@redhat.com
References: <20260916103635.7797-1-asahu1x@linux.ibm.com>
 <20260916103635.7797-2-asahu1x@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916103635.7797-2-asahu1x@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDI2NiBTYWx0ZWRfXwJnNy7P6V07I
 krO6GAa+oSLT4yYH+mVKvHYNsK0rHn1JNdj/zNs4okw3bDZJhz+UfM2rLAsjZwM7z2gH3fEP1sn
 UmnRvD1KrVw9exHz3ZCWa/FvENH7DKPAUOWgRojxHLJ1uyIVbO+lnnSBa6zaSgokHwcqx1L4O6A
 2YqgN7q8I2KwHss01NTt3hWikYm1jupVz3V324RTQEZea4k6+Pk1n+vnL7FmxeWOsCt5EvBMm+U
 zM/c2g3fE3I4XpyWSk+BcTOsYmfGEcurhMIlCrBWZ4t+Wgkr1hegEvq1YHsyIx35cDphYUjE33b
 p5u7HqbobNKaWQCPWAwWF88WlKrDZB07QxJFdQsyDgKBtbFz6nueVeFCHiBn1EqDAFXel3wGh7E
 WmwGXsM/MudN4AVXJf+y80Fi8Iu5uHQYbDVndC+yQE1F1zo82iXxBo2zRRNH3gA20KY01/KqV+U
 Kapz7+b0BCfwHbzQYJA==
X-Authority-Analysis: v=2.4 cv=E/NYNqdl c=1 sm=1 tr=0 ts=6aad8654 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=Wme-NVSrK1k7gbpzGMEA:9
 a=CjuIK1q_8ugA:10 a=O8hF6Hzn-FEA:10
X-Proofpoint-ORIG-GUID: l-OKkD-ymRBe5dPXZi3_Gvm04mzr-lEY
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDI2NiBTYWx0ZWRfX2yV2c1tSYRKv
 4iD7kaVgQ1KWnUJTrEnhpE1fPqhdykOqHm5urZfPamPAvyspfXJgG6JYYWmcriF/x6fkNCXWbIO
 Id6hGeKPcSosjaS4P8DowdrgN2VAO4c=
X-Proofpoint-GUID: HHOZqIWs_dlugD7DRqbqS7zMOuEMH7oi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_05,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 adultscore=0 clxscore=1015 bulkscore=0 malwarescore=0 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609180266
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=amachhiw@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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

On 2026/09/16 04:06 PM, Aniket Sahu wrote:
> Made a few changes to test_pseries.py to extend the migration
> tests to validate exec (socat) and UNIX paths.
> 
> - Refactored test_ppc64_linux_migration to a private method
> _do_linux_migration(dst_uri, src_uri=None).
> - It is then called by three separate methods which exercise the
> TCP, UNIX and exec paths via the migrate_vms method from
> MigrationTest.

Also noticed: the patch is missing a Signed-off-by tag.  Please add it.

> ---
>  tests/functional/ppc64/test_pseries.py | 41 ++++++++++++++++++++++----
>  1 file changed, 36 insertions(+), 5 deletions(-)
> 
> diff --git a/tests/functional/ppc64/test_pseries.py b/tests/functional/ppc64/test_pseries.py
> index cb6d25dc81..19f31141b1 100755
> --- a/tests/functional/ppc64/test_pseries.py
> +++ b/tests/functional/ppc64/test_pseries.py
> @@ -8,8 +8,9 @@
>  # later.  See the COPYING file in the top-level directory.
>  
>  from qemu_test import Asset
> -from qemu_test import wait_for_console_pattern
> +from qemu_test import wait_for_console_pattern, which
>  from migration import MigrationTest
> +from qemu_test.ports import Ports
>  
>  class PseriesMachine(MigrationTest):
>  
> @@ -88,12 +89,20 @@ def test_ppc64_linux_big_boot(self):
>          wait_for_console_pattern(self, console_pattern, self.panic_message)
>          wait_for_console_pattern(self, self.good_message, self.panic_message)
>  
> -    def test_ppc64_linux_migration(self):
> +    def _do_linux_migration(self, dst_uri, src_uri=None):
> +        """
> +        Boot a pseries kernel on a source VM, wait until Linux is up, then
> +        migrate to a destination VM over the given URI(s) and verify the boot
> +        continues on the destination.
> +        """
>          self.set_machine('pseries')
>  
>          kernel_path = self.ASSET_KERNEL.fetch()
>          kernel_command_line = self.KERNEL_COMMON_COMMAND_LINE
>  
> +        if src_uri is None:
> +            src_uri = dst_uri
> +
>          dest_vm = self.get_vm(name="dest-qemu")
>          dest_vm.add_args('-incoming', 'defer')
>          dest_vm.add_args('-smp', '4')
> @@ -111,16 +120,38 @@ def test_ppc64_linux_migration(self):
>          source_vm.set_console()
>          source_vm.launch()
>  
> -        # ensure the boot has reached Linux
> +        # ensure the boot has reached Linux before migrating
>          console_pattern = 'smp: Brought up 1 node, 4 CPUs'
>          wait_for_console_pattern(self, console_pattern, self.panic_message,
>                                   vm=source_vm)
>  
> -        self.migration_with_tcp_localhost_vms(dest_vm, source_vm)
> +        self.migrate_vms(dst_uri, src_uri, dest_vm, source_vm)
>  
> -        # ensure the boot proceeds after migration
> +        # ensure the boot continues on the destination after migration
>          wait_for_console_pattern(self, self.good_message, self.panic_message,
>                                   vm=dest_vm)
>  
> +    def test_ppc64_linux_migration(self):
> +        with Ports() as ports:
> +            port = ports.find_free_port()
> +            if port is None:
> +                self.skipTest('Failed to find a free port')
> +            self._do_linux_migration('tcp:localhost:%u' % port)
> +
> +    def test_ppc64_linux_migration_unix(self):
> +        self._do_linux_migration(
> +            'unix:%s/migration.sock' % self.socket_dir().name)
> +
> +    def test_ppc64_linux_migration_exec(self):
> +        if not which('socat'):
> +            self.skipTest('socat is not available')
> +        with Ports() as ports:
> +            port = ports.find_free_port()
> +            if port is None:
> +                self.skipTest('Failed to find a free port')
> +            self._do_linux_migration(
> +                'exec:socat TCP-LISTEN:%u -' % port,
> +                'exec:socat - TCP:localhost:%u,forever' % port)
> +
>  if __name__ == '__main__':
>      MigrationTest.main()
> -- 
> 2.52.0
> 
> 

