Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28D28CAC582
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 21:18:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvjEz-0007dz-7c; Mon, 08 Sep 2025 17:17:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1uvjEw-0007dB-6D; Mon, 08 Sep 2025 17:17:30 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1uvjEs-0003p4-4l; Mon, 08 Sep 2025 17:17:29 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 588IgtNd005802;
 Mon, 8 Sep 2025 21:17:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=K6M6fygqSurjFQeEtrODnJ6FGetZk6QFR99tF/YeM8A=; b=ESZ0BDfQ/yFq
 7duh+YQAZntCpSNc0tvScThvhT2UCBR7DM5XOpFcyqx6pe0JujXvMQi7HzmUKuAo
 M0pfTdjsSQPR0VJHalAUCQmsW7rJLn3TDpBISxtyDJogw3m7QVl6QVQoMAeHiDsC
 1Iqedqo9/vFHSwyKSc2EYrxtzmOqnsUuYxBuAh4ink9/3ibciokAgMYITO2b9ZAM
 CHqGOHj9Yz7EeQYeuRPuRfqWzB7lijtoUVzJqHcd+qiH0maRznGdcqQqXwMHXZjx
 3AepNVuTWcXRJ8MJUj6eZFagcIVOBg8bsPprqd7Li4ajDRNk562xeK0IPFI+tFBX
 zYEMB/nENA==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490acquyp4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 08 Sep 2025 21:17:22 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 588LCXNr006963;
 Mon, 8 Sep 2025 21:17:22 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490acquyp3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 08 Sep 2025 21:17:22 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 588KSmwk020469;
 Mon, 8 Sep 2025 21:17:21 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 490yp0r4hh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 08 Sep 2025 21:17:21 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 588LHKGn35062114
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 8 Sep 2025 21:17:20 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 67E635805D;
 Mon,  8 Sep 2025 21:17:20 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AEDC258053;
 Mon,  8 Sep 2025 21:17:19 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  8 Sep 2025 21:17:19 +0000 (GMT)
Message-ID: <cc33c790bbc44f6145dcc3c41c8c2ddd32ca30dd.camel@linux.ibm.com>
Subject: Re: [PATCH v3 9/9] tests/functional: Add test for IBM PPE42
 instructions
From: Miles Glenn <milesg@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, clg@redhat.com, npiggin@gmail.com,
 harshpb@linux.ibm.com, thuth@redhat.com, rathc@linux.ibm.com,
 richard.henderson@linaro.org
Date: Mon, 08 Sep 2025 16:17:19 -0500
In-Reply-To: <20250908200028.115789-10-milesg@linux.ibm.com>
References: <20250908200028.115789-1-milesg@linux.ibm.com>
 <20250908200028.115789-10-milesg@linux.ibm.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: U6-pkWnL9ikdx5YsMGAV8OeibhuZ81jS
X-Authority-Analysis: v=2.4 cv=Mp1S63ae c=1 sm=1 tr=0 ts=68bf47e2 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=NEAV23lmAAAA:8 a=VnNF1IyMAAAA:8
 a=20KFwNOVAAAA:8 a=69wJf7TsAAAA:8 a=up-X0YpDAAAA:8 a=WP5zsaevAAAA:8
 a=CLfRNzIOj5P8Y0e6oOcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=Fg1AiH1G6rFz08G2ETeA:22 a=86FmjZgct7XXK6GGpxvI:22 a=t8Kx07QrZZTALmIZmm-o:22
X-Proofpoint-ORIG-GUID: hhGWTKkYp_uU1XwgEZuyM_Q2VyocwCxT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAwMCBTYWx0ZWRfX4gCJ0KG782du
 Otk3QW7bM8Cufb10ruW3iNiKyJvj/N4nU5/XtGEHeLBy+K3dSof4nILWiSDlW9NrJUgqS7JuJTe
 Ytgh5shWAqCi1DhPJhYU5q85nfahtaGOP4kqJXqwlmOPZlI3KX161YNrSdo1+OGLA/z5YdbnFde
 JFMsZbTnkihc38sj/cWbSNUlogAvlJ2lnDK4pQn7RQIx98Q7GJfEOZjpNLFOwqMzQ5TBW62uTHf
 ciYSV184eoM4TccWz12wnVs1kBEfsur6/KyfRdT17MECZxrJ3aappFVMczPQzOJftfrs0ItvghL
 JzjKUyNA3284Mea280ncS72225L8YH1u/q6OjFFvxBqMgqCxzMrXBjyjNzC+3PMZlmtzIMzJzuq
 SUQlkcrM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_06,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 clxscore=1015 phishscore=0 spamscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060000
Received-SPF: pass client-ip=148.163.158.5; envelope-from=milesg@linux.ibm.com;
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
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: milesg@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

I noticed after sending this that it did not apply cleanly to the
latest master branch.  Looks like the tests/functional directory
structure has been changed.  Not sure how this situation is normally
handled. I assume I can just send out a v4 patch that is rebased on the
latest master branch once I get feeedback for v3.

-Glenn

On Mon, 2025-09-08 at 15:00 -0500, Glenn Miles wrote:
> Adds a functional test for the IBM PPE42 instructions which
> downloads a test image from a public github repo and then
> loads and executes the image.
> (see https://github.com/milesg-github/ppe42-tests for details)
> 
> Test status is checked by periodically issuing 'info register'
> commands and checking the NIP value.  If the NIP is 0xFFF80200
> then the test successfully executed to completion.  If the
> machine stops before the test completes or if a 90 second
> timeout is reached, then the test is marked as having failed.
> 
> This test does not test any PowerPC instructions as it is
> expected that these instructions are well covered in other
> tests.  Only instructions that are unique to the IBM PPE42
> processor are tested.
> 
> Signed-off-by: Glenn Miles <milesg@linux.ibm.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> ---
> 
> No changes from v2 patch 4
> 
>  MAINTAINERS                        |  1 +
>  tests/functional/meson.build       |  1 +
>  tests/functional/test_ppc_ppe42.py | 79 ++++++++++++++++++++++++++++++
>  3 files changed, 81 insertions(+)
>  create mode 100644 tests/functional/test_ppc_ppe42.py
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 52fa303e0a..af412ad0ce 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1536,6 +1536,7 @@ M: Glenn Miles <milesg@linux.ibm.com>
>  L: qemu-ppc@nongnu.org
>  S: Odd Fixes
>  F: hw/ppc/ppe42_machine.c
> +F: tests/functional/test_ppc_ppe42.py
>  
>  PReP
>  M: Hervé Poussineau <hpoussin@reactos.org>
> diff --git a/tests/functional/meson.build b/tests/functional/meson.build
> index 311c6f1806..ddfef55bd2 100644
> --- a/tests/functional/meson.build
> +++ b/tests/functional/meson.build
> @@ -233,6 +233,7 @@ tests_ppc_system_quick = [
>  ]
>  
>  tests_ppc_system_thorough = [
> +  'ppc_ppe42',
>    'ppc_40p',
>    'ppc_amiga',
>    'ppc_bamboo',
> diff --git a/tests/functional/test_ppc_ppe42.py b/tests/functional/test_ppc_ppe42.py
> new file mode 100644
> index 0000000000..26bbe11b2d
> --- /dev/null
> +++ b/tests/functional/test_ppc_ppe42.py
> @@ -0,0 +1,79 @@
> +#!/usr/bin/env python3
> +#
> +# Functional tests for the IBM PPE42 processor
> +#
> +# Copyright (c) 2025, IBM Corporation
> +#
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +from qemu_test import QemuSystemTest, Asset
> +import asyncio
> +
> +class Ppe42Machine(QemuSystemTest):
> +
> +    timeout = 90
> +    poll_period = 1.0
> +
> +    ASSET_PPE42_TEST_IMAGE = Asset(
> +        ('https://github.com/milesg-github/ppe42-tests/raw/refs/heads/main/'
> +         'images/ppe42-test.out'),
> +        '03c1ac0fb7f6c025102a02776a93b35101dae7c14b75e4eab36a337e39042ea8')
> +
> +    def _test_completed(self):
> +        self.log.info("Checking for test completion...")
> +        try:
> +            output = self.vm.cmd('human-monitor-command',
> +                                 command_line='info registers')
> +        except Exception as err:
> +            self.log.debug(f"'info registers' cmd failed due to {err=},"
> +                            " {type(err)=}")
> +            raise
> +
> +        self.log.info(output)
> +        if "NIP fff80200" in output:
> +            self.log.info("<test completed>")
> +            return True
> +        else:
> +            self.log.info("<test not completed>")
> +            return False
> +
> +    def _wait_pass_fail(self, timeout):
> +        while not self._test_completed():
> +            if timeout >= self.poll_period:
> +                timeout = timeout - self.poll_period
> +                self.log.info(f"Waiting {self.poll_period} seconds for test"
> +                               " to complete...")
> +                e = None
> +                try:
> +                    e = self.vm.event_wait('STOP', self.poll_period)
> +
> +                except asyncio.TimeoutError:
> +                    self.log.info("Poll period ended.")
> +                    pass
> +
> +                except Exception as err:
> +                    self.log.debug(f"event_wait() failed due to {err=},"
> +                                    " {type(err)=}")
> +                    raise
> +
> +                if e != None:
> +                    self.log.debug(f"Execution stopped: {e}")
> +                    self.log.debug("Exiting due to test failure")
> +                    self.fail("Failure detected!")
> +                    break
> +            else:
> +                self.fail("Timed out waiting for test completion.")
> +
> +    def test_ppe42_instructions(self):
> +        self.set_machine('ppe42_machine')
> +        self.require_accelerator("tcg")
> +        image_path = self.ASSET_PPE42_TEST_IMAGE.fetch()
> +        self.vm.add_args('-nographic')
> +        self.vm.add_args('-device', f'loader,file={image_path}')
> +        self.vm.add_args('-device', 'loader,addr=0xfff80040,cpu-num=0')
> +        self.vm.add_args('-action', 'panic=pause')
> +        self.vm.launch()
> +        self._wait_pass_fail(self.timeout)
> +
> +if __name__ == '__main__':
> +    QemuSystemTest.main()


