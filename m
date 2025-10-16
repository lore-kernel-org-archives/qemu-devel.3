Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A1E1CCD183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 11:52:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9MVu-00037p-P6; Thu, 16 Oct 2025 07:51:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shalini@linux.ibm.com>)
 id 1v9MVr-00033j-HV; Thu, 16 Oct 2025 07:51:19 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shalini@linux.ibm.com>)
 id 1v9MVe-0004wl-0f; Thu, 16 Oct 2025 07:51:18 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59G1KNmV012442;
 Thu, 16 Oct 2025 11:50:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=WIH7io
 jamKpeQam6JA6Xg84CXece3MAh58Jm+Rkk17o=; b=iIb/KoHtNS8CircW6Mmuvd
 hh3LxoX8mXlc5QZm45zEBo6n5zD/HQilu4yWMIGrqxe1jfdd4mg7ojWehO7V2sTe
 /o4HPDnu8C490V+Ewtke81ePtVFvyD3b5dtER6HkgMZ2CRAsJ3/urlaHflazvQOh
 qk2w2Kmt4DiLIIOETXs2FMCxTq1HlF3XimwPZ0pcy/Z/CDGh0TpAEr5udkzairoO
 863JcjSDbjWgHuIMR1yLMmNPJlgHP7EfMSdsZwyb5gEBHwKNAayyZcDTWSM1swWG
 o5EIxSlxVwDku5RsDjzJmViyc8t4iPvz6kRiUEUooLGtIv7oUGKHzNYJ8LQXa5EA
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qcnrhj7m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Oct 2025 11:50:53 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59G9KlvI003623;
 Thu, 16 Oct 2025 11:50:53 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49r1xy5k9f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Oct 2025 11:50:53 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59GBop3U17892040
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 16 Oct 2025 11:50:51 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5CAAC58061;
 Thu, 16 Oct 2025 11:50:51 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A85195805F;
 Thu, 16 Oct 2025 11:50:50 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 16 Oct 2025 11:50:50 +0000 (GMT)
MIME-Version: 1.0
Date: Thu, 16 Oct 2025 13:50:50 +0200
From: Shalini Chellathurai Saroja <shalini@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-s390x mailing list <qemu-s390x@nongnu.org>, Sebastian Mitterle
 <smitterl@redhat.com>, qemu-devel mailing list <qemu-devel@nongnu.org>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>, Hendrik Brueckner
 <brueckner@linux.ibm.com>, Michael Mueller <mimu@linux.ibm.com>
Subject: Re: [PATCH v2 2/2] tests/functional: add tests for SCLP event CPI
In-Reply-To: <f4ec5b8c-2bdb-43a2-a100-cfb1685aeb52@redhat.com>
References: <20251013133902.111233-1-shalini@linux.ibm.com>
 <20251013133902.111233-2-shalini@linux.ibm.com>
 <f4ec5b8c-2bdb-43a2-a100-cfb1685aeb52@redhat.com>
Message-ID: <d0eac34ad0a8f244d5fbe1dd91ab0801@linux.ibm.com>
X-Sender: shalini@linux.ibm.com
Organization: IBM Deutschland Research & Development GmbH
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=M5ZA6iws c=1 sm=1 tr=0 ts=68f0dc1d cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8 a=WP5zsaevAAAA:8 a=NvKNCtQwuY3EklFOmYsA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=t8Kx07QrZZTALmIZmm-o:22
 a=poXaRoVlC6wW9_mwW8W4:22
X-Proofpoint-GUID: lwQGOsi7kKVvG4ZuAH0z-ijm_ch_rl3f
X-Proofpoint-ORIG-GUID: lwQGOsi7kKVvG4ZuAH0z-ijm_ch_rl3f
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEwMDE0MCBTYWx0ZWRfX3lmcdCBUvUci
 On2cbpeFMWqCG9Wwf/iZvtsgwxho/+pyeVhQ/qGCN7M+JjNc0f8bZB8MnYre+8deklLlNanzdD7
 EQjUATjdJrbdImnmGAb14hsinoiFfyhrO/CEpRuFfZNQVBl5fx6BNU+ctYijKmfuX/wMCe7ss1B
 Yzc1RMf5kS7MqWeDVqAgLRoGIvhTDVcUuqnPr9WkeV7Lxpb1fvAIJQu7GFCCBnf3GKncOWfJP+8
 rr589LjKCKz16flkEFDOUY+l9N9h/FH8UIqRMDbQRnphEW9AbDhlhvp51sPyBvT8L+w+qw+o2tn
 Qyxi8/yfAli/EVE1rNvw0WX+ee7vFtXzkHXX0jFWw24U7fTNyB5c1JihXsM9D1J7UyzKylrKgwt
 yi+8OVKR8MWl9dF/d7so3UEaYngBhw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 spamscore=0 clxscore=1015 impostorscore=0
 phishscore=0 adultscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510100140
Received-SPF: pass client-ip=148.163.158.5; envelope-from=shalini@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 2025-10-16 09:17, Thomas Huth wrote:
> On 13/10/2025 15.39, Shalini Chellathurai Saroja wrote:
>> Add tests for SCLP event type Control-Program Identification.
>> 
>> Signed-off-by: Shalini Chellathurai Saroja <shalini@linux.ibm.com>
>> Suggested-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   tests/functional/s390x/test_ccw_virtio.py | 25 
>> +++++++++++++++++++++++
>>   1 file changed, 25 insertions(+)
>> 
>> diff --git a/tests/functional/s390x/test_ccw_virtio.py 
>> b/tests/functional/s390x/test_ccw_virtio.py
>> index 453711aa0f..82e73ecf5e 100755
>> --- a/tests/functional/s390x/test_ccw_virtio.py
>> +++ b/tests/functional/s390x/test_ccw_virtio.py
>> @@ -15,6 +15,7 @@
>>   import tempfile
>>     from qemu_test import QemuSystemTest, Asset
>> +from qemu_test import exec_command
>>   from qemu_test import exec_command_and_wait_for_pattern
>>   from qemu_test import wait_for_console_pattern
>>   @@ -270,5 +271,29 @@ def test_s390x_fedora(self):
>>                           'while ! (dmesg -c | grep 
>> Start.virtcrypto_remove) ; do'
>>                           ' sleep 1 ; done', 'Start 
>> virtcrypto_remove.')
>>   +        # Test SCLP event Control-Program Identification (CPI)
>> +        cpi = '/sys/firmware/cpi/'
>> +        sclpcpi = '/machine/sclp/s390-sclp-event-facility/sclpcpi'
>> +        self.log.info("Test SCLP event CPI")
>> +        exec_command(self, 'echo TESTVM > ' + cpi + 'system_name')
>> +        exec_command(self, 'echo LINUX > ' + cpi + 'system_type')
>> +        exec_command(self, 'echo TESTPLEX > ' + cpi + 'sysplex_name')
>> +        exec_command(self, 'echo 0x001a000000060b00 > ' + cpi + 
>> 'system_level')
>> +        exec_command(self, 'echo 1 > ' + cpi + 'set')
> 
> I think at least the last statement should be replaced by
> exec_command_and_wait_for_pattern, waiting for the shell prompt.
> Otherwise there is a small race condition here that the exec_command()
> has been sent, but not executed yet. Ok, the event_wait() will wait
> for a while, so it's very unlikely, but let's better play save and
> wait for the shell prompt first, before waiting for the event.
> 

ok.

>> +        try:
>> +            event = self.vm.event_wait('SCLP_CPI_INFO_AVAILABLE')
>> +        except TimeoutError:
>> +            self.skipTest('SCLP Event type CPI is not supported')
> 
> Should we rather fail the test in case we don't receive the event?

ok.

Hello Thomas,

I will incorporate the changes and will send the v3. Thank you for
the review.

> 
>> +        ts = self.vm.cmd('qom-get', path=sclpcpi, 
>> property='timestamp')
>> +        self.assertNotEqual(ts, 0)
>> +        name = self.vm.cmd('qom-get', path=sclpcpi, 
>> property='system_name')
>> +        self.assertEqual(name.strip(), 'TESTVM')
>> +        typ = self.vm.cmd('qom-get', path=sclpcpi, 
>> property='system_type')
>> +        self.assertEqual(typ.strip(), 'LINUX')
>> +        sysplex = self.vm.cmd('qom-get', path=sclpcpi, 
>> property='sysplex_name')
>> +        self.assertEqual(sysplex.strip(), 'TESTPLEX')
>> +        level = self.vm.cmd('qom-get', path=sclpcpi, 
>> property='system_level')
>> +        self.assertEqual(level, 0x001a000000060b00)
> 
>  Thomas

-- 
Mit freundlichen Grüßen / Kind regards
Shalini Chellathurai Saroja
Software Developer
Linux on IBM Z & KVM Development
IBM Deutschland Research & Development GmbH
Dept 1419, Schoenaicher Str. 220, 71032 Boeblingen
Vorsitzender des Aufsichtsrats: Wolfgang Wendt
Geschäftsführung: David Faller
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht 
Stuttgart, HRB 243294

