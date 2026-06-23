Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F37CCD4F26
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 06:58:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbv4W-0003My-LM; Tue, 23 Jun 2026 02:57:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1wbv4U-0003Ml-VI; Tue, 23 Jun 2026 02:57:22 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1wbv4S-0003mb-2r; Tue, 23 Jun 2026 02:57:22 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65N6mQxx1207000; Tue, 23 Jun 2026 06:57:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=U9/skzFrUWP7F61OLRMfCbEGu8fb+T
 w6bA4/X1+ZQmQ=; b=koLKZr72+VkXfdWOlP8nLHP5RmZFa0unDcFQ+gP3JMe/aJ
 dqExrK0eWA778dHSp09lDzsounF+KTjkL3EPoRXYaD870zGmbbeWsMpK8iI4rHdx
 VYg3bp0N23jvOMpRIdOz7Wt4yZorGich1+GAAvOc5udNFmYhYK0t+qlnJj17KHoS
 E2rOTANvAhxZsmsg7jk3dVlspc7sYz9sr8BtOE+285r51chz53Ku5ESp2sSJz7MY
 tJ+UbUQ3lyf2PyiZQ6YPqfwhV/43FPYC+nypR52CEZq17yvvQ+YXGASbW0asdLmb
 QGlitydrkNEETbRMnbULvYqZdU/cPsh7nMPmMZdg==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjc3d3u9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Jun 2026 06:57:16 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65N6nxuV002277;
 Tue, 23 Jun 2026 06:57:15 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex7vyhnh8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Jun 2026 06:57:15 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65N6vBTN49676692
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 Jun 2026 06:57:11 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A1E1320043;
 Tue, 23 Jun 2026 06:57:11 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 262C420040;
 Tue, 23 Jun 2026 06:57:10 +0000 (GMT)
Received: from fedora (unknown [9.5.7.39])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Tue, 23 Jun 2026 06:57:09 +0000 (GMT)
Date: Tue, 23 Jun 2026 12:27:13 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Shivang Upadhyay <shivangu@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, adityag@linux.ibm.com,
 harshpb@linux.ibm.com, npiggin@gmail.com, milesg@linux.ibm.com
Subject: Re: [PATCH 2/2] ppc/pnv: add test to verify external DTB is honored
Message-ID: <20260623122410.5fae6f07-db-amachhiw@linux.ibm.com>
Mail-Followup-To: Shivang Upadhyay <shivangu@linux.ibm.com>, 
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org, adityag@linux.ibm.com, 
 harshpb@linux.ibm.com, npiggin@gmail.com, milesg@linux.ibm.com
References: <20260623063156.1110370-1-shivangu@linux.ibm.com>
 <20260623063156.1110370-3-shivangu@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260623063156.1110370-3-shivangu@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=X4Ni7mTe c=1 sm=1 tr=0 ts=6a3a2e4c cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=ID6ng7r3AAAA:8
 a=NEAV23lmAAAA:8 a=VnNF1IyMAAAA:8 a=z2b1RXnOswK0OTJWYjIA:9 a=CjuIK1q_8ugA:10
 a=AkheI1RvQwOzcTXhi5f4:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDA1MyBTYWx0ZWRfX6q2LT+6KXSX5
 FF1hRbpgAdS0EngQyFpVhvwtG183TRBBQql/6AE26Hd3qvVrhKzm3DFEDtJm0EtxpBE+2+AZ+9T
 kCufc7vIQouCIrI3h+F0VuQDLJBWuDQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDA1MyBTYWx0ZWRfX4A4Fwuyefa2q
 b/AtvEkqzU4rS79M4S0g7nLx9BQ+n4A0ccNceRaZi8d7+I67Uu7SPhb75sv8YJvQ5Vzb4lhnt4z
 wJ3cGOtn4jEbvFS7t4xDciR0RiYYI0AW/FF5ChXX1daj+sOdcLhA0azpxTUNp1KQKSi/PL101GY
 Dy8ELwImAX46pcCVCtFFwoYZU7NUUE6gpxTGFMaxCLtPuV3MR699cnnjkl2itg2gRNHJzCVT0TN
 xgGJUJYGg0voaxmtPNImxMxnsZM+5dk2ekiQ52mJTsYl/O6hJFMc4D3hbISbfK4hcNgKY8R6Gtv
 FA/1iauG6/cLT2vvU52nCcESdPnRAuA2FuZFneoMg7iSuhy30ljHrDGAoLPq22+LHrmmCdBcsjy
 94CMCRF6MmNwP+/j22EH5TofGshV/JlrQL69RURCkDcmhdL4kSU1R3VVzHSsCPg+Fb9gSPcBYnM
 00JuqPqiumQpmK5skQw==
X-Proofpoint-ORIG-GUID: yx9WwmSHrrVxPv3A2QEY-E0X3p8YV-CR
X-Proofpoint-GUID: FBbrBOlZ7zsqlDCYokwk5oWUEzUBQcan
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_02,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 suspectscore=0 spamscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230053
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=amachhiw@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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

On 2026/06/23 12:01 PM, Shivang Upadhyay wrote:
> Signed-off-by: Shivang Upadhyay <shivangu@linux.ibm.com>
> ---
>  tests/functional/ppc64/test_powernv.py | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)

The test addition looks fine, but the commit message body is missing.
According to the official QEMU submission guidelines at:

  https://www.qemu.org/docs/master/devel/submitting-a-patch.html#write-a-meaningful-commit-message

  "Commit messages should be meaningful and should stand on their own as
  a historical record of why the changes you applied were necessary or
  useful."

You may want to add a commit message body in the next version.

Thanks,
Amit

> 
> diff --git a/tests/functional/ppc64/test_powernv.py b/tests/functional/ppc64/test_powernv.py
> index 0ea6c93e42..80801ee3dc 100755
> --- a/tests/functional/ppc64/test_powernv.py
> +++ b/tests/functional/ppc64/test_powernv.py
> @@ -27,6 +27,11 @@ class PowernvMachine(LinuxKernelTest):
>           'buildroot/qemu_ppc64le_powernv8-2025.02/rootfs.ext2'),
>          'aee2192b692077c4bde31cb56ce474424b358f17cec323d5c94af3970c9aada2')
>  
> +    # testdtb for power11, which contains string "hello world" in command line
> +    ASSET_SAMPLE_DTB = Asset(
> +        ('https://github.com/roz3x/qemu/raw/refs/heads/sample-dtb/output.dtb'),
> +        '2dd3330561768fc5c8e4b93aa29bc44c64278d186f1e0f8c584cdf15c3f8cf43')
> +
>      def do_test_linux_boot(self, command_line = KERNEL_COMMON_COMMAND_LINE):
>          self.require_accelerator("tcg")
>          kernel_path = self.ASSET_KERNEL.fetch()
> @@ -104,6 +109,20 @@ def do_test_ppc64_powernv(self, proc):
>          # Device detection output driven by udev probing is sometimes cut off
>          # from console output, suspect S14silence-console init script.
>  
> +    def test_ppc64_powernv_external_dtb(self):
> +        self.set_machine('powernv11')
> +        self.require_accelerator("tcg")
> +
> +        kernel_path = self.ASSET_KERNEL.fetch()
> +        sample_dtb_path = self.ASSET_SAMPLE_DTB.fetch()
> +        self.vm.set_console()
> +        self.vm.add_args('-kernel', kernel_path,
> +                         '-dtb', sample_dtb_path)
> +        self.vm.launch()
> +
> +        # check if custom dtb is reflected or not
> +        wait_for_console_pattern(self, "Kernel command line: hello world", self.panic_message)
> +
>      def test_powernv8(self):
>          self.set_machine('powernv8')
>          self.do_test_ppc64_powernv('P8')
> -- 
> 2.54.0
> 
> 

