Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB08BCCD1AA
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 12:52:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBBqq-0003UG-TU; Tue, 21 Oct 2025 08:52:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brueckner@linux.ibm.com>)
 id 1vBBqi-0003NR-Be; Tue, 21 Oct 2025 08:52:25 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brueckner@linux.ibm.com>)
 id 1vBBqe-0007v9-Jf; Tue, 21 Oct 2025 08:52:24 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59LAAMPx031838;
 Tue, 21 Oct 2025 12:52:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:sender:subject:to; s=pp1; bh=2aTT1ZoIiy0Yev3B//YT5KR
 96K+LmveIGB3insz6HWU=; b=qabT9DAbi4Tnd2H0rY/juHXHtPlfFXcOhPtJwwP
 G+KIigKC9JripEDfBA8dIX5ke6wzN4fThsKMrJFwbvtmeANFaKczn6jgOWr7XgD0
 jWyhSMW4Aet8eRUvT5lXEazGo5+gt4AX7beJw0lVZzvLcjZ5QjcQlnQD8rpuTROT
 anJ6/v/y7i7lXhCJxgjZq0ki+eQGRkayf/9LlRYoVuUOE7oARyO4R+ImCJ0PFRDy
 3VbwQ0DMa6/sfUTWiiulALCxtqY2848YBKlSWRosFSqvkhXVbLVJdW4Cmwj/N/e3
 oVzhiBw5C6ApiCKRuXSL+gyEmdei/azaNrmI254/LOCY/bQ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v33f71cn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 Oct 2025 12:52:16 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59LC7YFW024987;
 Tue, 21 Oct 2025 12:52:15 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49vpqjtpmj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 Oct 2025 12:52:15 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59LCqB0I36635128
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 21 Oct 2025 12:52:11 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 95FA32004B;
 Tue, 21 Oct 2025 12:52:11 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 85D3820043;
 Tue, 21 Oct 2025 12:52:11 +0000 (GMT)
Received: from vela (unknown [9.155.211.212])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Tue, 21 Oct 2025 12:52:11 +0000 (GMT)
Received: from brueckner by vela with local (Exim 4.98.2)
 (envelope-from <brueckner@linux.ibm.com>) id 1vBBqV-00000000Dou-15Zf;
 Tue, 21 Oct 2025 14:52:11 +0200
Date: Tue, 21 Oct 2025 14:52:11 +0200
From: Hendrik Brueckner <brueckner@linux.ibm.com>
To: Shalini Chellathurai Saroja <shalini@linux.ibm.com>
Cc: qemu-s390x mailing list <qemu-s390x@nongnu.org>,
 Thomas Huth <thuth@redhat.com>, Sebastian Mitterle <smitterl@redhat.com>,
 qemu-devel mailing list <qemu-devel@nongnu.org>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 Hendrik Brueckner <brueckner@linux.ibm.com>,
 Michael Mueller <mimu@linux.ibm.com>
Subject: Re: [PATCH v3 2/2] tests/functional: add tests for SCLP event CPI
Message-ID: <aPeB-9qspIgbWGtg@linux.ibm.com>
References: <20251016121708.334133-1-shalini@linux.ibm.com>
 <20251016121708.334133-2-shalini@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251016121708.334133-2-shalini@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=FMYWBuos c=1 sm=1 tr=0 ts=68f78200 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8 a=WP5zsaevAAAA:8 a=1wHtL1Bk02DuYSqJXVUA:9
 a=CjuIK1q_8ugA:10 a=t8Kx07QrZZTALmIZmm-o:22 a=poXaRoVlC6wW9_mwW8W4:22
X-Proofpoint-GUID: n-nOUHdA7jz91xeNCi-8OFvfl9IghtPj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX3QE6anemZKw0
 gQ11o63sCWdLWwhaN21GnB/5u7YhBa95QEMh9HNcuYstorEuoibX5KkIwRLUWssKsxyoJjc8SzD
 vqXxxnK7r5vVV7Wq2cyJxwxsWpZXb77Q1r0Ji1rV1bGlu/JVih6e4iNQsuinJ4MxBVSONFZSKp4
 RFqkP6S9y77bEIP+R/FaYn8jURdnSlLn5RJqs0K3Iqssiqa7WSmkqCzYUhGmOLt78G1wzIyFTOX
 5KcoRc2yU4BZGNDh1e71tGifo+vEZpmOJL94bxAsnECsGcB27aA+dG8zk3QzgA4S2azE/usUDO8
 Aa0lDwUwgPlHF0DzrTrP3m7j40k+sHzBldfCgEUw95bbNZ7yeB9AZrMrZiDjfNfXXheQoq9VqYO
 /hdDQlO04ifiL+mSdrOdRBltE05eSQ==
X-Proofpoint-ORIG-GUID: n-nOUHdA7jz91xeNCi-8OFvfl9IghtPj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-21_01,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=brueckner@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Oct 16, 2025 at 02:17:08PM +0200, Shalini Chellathurai Saroja wrote:
> Add tests for SCLP event type Control-Program Identification.
> 
> Signed-off-by: Shalini Chellathurai Saroja <shalini@linux.ibm.com>
> Suggested-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/functional/s390x/test_ccw_virtio.py | 26 +++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/tests/functional/s390x/test_ccw_virtio.py b/tests/functional/s390x/test_ccw_virtio.py
> index 453711aa0f..0455337856 100755
> --- a/tests/functional/s390x/test_ccw_virtio.py
> +++ b/tests/functional/s390x/test_ccw_virtio.py
> @@ -15,6 +15,7 @@
>  import tempfile
>  
>  from qemu_test import QemuSystemTest, Asset
> +from qemu_test import exec_command
>  from qemu_test import exec_command_and_wait_for_pattern
>  from qemu_test import wait_for_console_pattern
>  
> @@ -270,5 +271,30 @@ def test_s390x_fedora(self):
>                          'while ! (dmesg -c | grep Start.virtcrypto_remove) ; do'
>                          ' sleep 1 ; done', 'Start virtcrypto_remove.')
>  
> +        # Test SCLP event Control-Program Identification (CPI)
> +        cpi = '/sys/firmware/cpi/'
> +        sclpcpi = '/machine/sclp/s390-sclp-event-facility/sclpcpi'
> +        self.log.info("Test SCLP event CPI")
> +        exec_command(self, 'echo TESTVM > ' + cpi + 'system_name')
> +        exec_command(self, 'echo LINUX > ' + cpi + 'system_type')
> +        exec_command(self, 'echo TESTPLEX > ' + cpi + 'sysplex_name')
> +        exec_command(self, 'echo 0x001a000000060b00 > ' + cpi + 'system_level')
> +        exec_command_and_wait_for_pattern(self,
> +                                          'echo 1 > ' + cpi + 'set', ':/#')
> +        try:
> +            event = self.vm.event_wait('SCLP_CPI_INFO_AVAILABLE')
> +        except TimeoutError:
> +            self.fail('Timed out waiting for the SCLP_CPI_INFO_AVAILABLE event')
> +        ts = self.vm.cmd('qom-get', path=sclpcpi, property='timestamp')
> +        self.assertNotEqual(ts, 0)
> +        name = self.vm.cmd('qom-get', path=sclpcpi, property='system_name')
> +        self.assertEqual(name.strip(), 'TESTVM')
> +        typ = self.vm.cmd('qom-get', path=sclpcpi, property='system_type')
> +        self.assertEqual(typ.strip(), 'LINUX')
> +        sysplex = self.vm.cmd('qom-get', path=sclpcpi, property='sysplex_name')
> +        self.assertEqual(sysplex.strip(), 'TESTPLEX')
> +        level = self.vm.cmd('qom-get', path=sclpcpi, property='system_level')
> +        self.assertEqual(level, 0x001a000000060b00)
> +
>  if __name__ == '__main__':
>      QemuSystemTest.main()

Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>

