Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B411FD2068C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2024 01:53:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0tDK-0000NB-HV; Tue, 15 Oct 2024 21:52:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1t0tDI-0000Mu-60
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 21:52:36 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1t0tDG-0002jR-1Q
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 21:52:35 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49G0uffe022066;
 Wed, 16 Oct 2024 01:52:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=IOjpC5
 73XcZUFLL10JWtZXebF52FN+eryGw5NFhXQHs=; b=WZFqH3fwVT3RyIHbw0b+JV
 xv6ToP64RbhPzRc2/Jfwzn0biylRykNfNsPa1MXnLy2wo369zX9UsnGaBKo6Y4FZ
 GqQCaiT+N2BVpAWBxyLMd61G8qS28kcVPxLALMCPc0JkAVwaUaWFcseLnMzZ86OS
 QgFbsFDeVrcpbvFt/PiqylOSyBsRHqpQ5mJJ6tDNsEtP5pFFy5+1v7oN2nIS06NL
 kHMQ8fP7WzaYKh2eCgRbjCUOfnOmdMnRsZPltWpNjJ6xmoVgImwCo6+NnqQVvHY6
 /KbJ+cePck5WIHLu7Y68jQM3AhvQoKO7w54XpT2PTMeKUpjjQOD48bJjIFtV29wQ
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42a3c9r4hq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 16 Oct 2024 01:52:32 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49G1Sssg006671;
 Wed, 16 Oct 2024 01:52:31 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4283ery25x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 16 Oct 2024 01:52:31 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 49G1qUfU27853406
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 16 Oct 2024 01:52:31 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A53CD5803F;
 Wed, 16 Oct 2024 01:52:30 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 765B958056;
 Wed, 16 Oct 2024 01:52:30 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 16 Oct 2024 01:52:30 +0000 (GMT)
Message-ID: <68423739-272e-4826-a9c9-50e4755cc8a4@linux.ibm.com>
Date: Tue, 15 Oct 2024 21:52:30 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: tpm-tis-device-swtpm-test timeout
From: Stefan Berger <stefanb@linux.ibm.com>
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
References: <87jze9qlrp.fsf@suse.de>
 <077cee03-efd0-4716-865a-b9990afb91a3@linux.ibm.com> <87h69dqigg.fsf@suse.de>
 <865424c1-f79c-44ad-b70f-8bf3e455e025@linux.ibm.com> <87ed4hqgvl.fsf@suse.de>
 <d9b18dc6-994b-4fdb-8f6c-5cb9bd11eb64@linux.ibm.com> <87ed4hgh2l.fsf@suse.de>
 <eee403f1-058f-4222-902f-eb1e78ab54e0@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <eee403f1-058f-4222-902f-eb1e78ab54e0@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: nl5vI1B46kuesElnofK6pEDInIv-UoYo
X-Proofpoint-GUID: nl5vI1B46kuesElnofK6pEDInIv-UoYo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 bulkscore=0
 phishscore=0 mlxlogscore=862 suspectscore=0 lowpriorityscore=0 spamscore=0
 malwarescore=0 priorityscore=1501 impostorscore=0 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410160008
Received-SPF: pass client-ip=148.163.158.5; envelope-from=stefanb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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



On 10/15/24 7:35 PM, Stefan Berger wrote:
> 
> 
> On 10/15/24 6:02 PM, Fabiano Rosas wrote:
>> Stefan Berger <stefanb@linux.ibm.com> writes:
>>

>>>
>>
>> Yes, I've been using that method to reproduce live migration race
>> conditions as well. It's quite effective.
>>
>> If you don't think you'll be able to find the root cause due to the
>> unreproducibility on your side, maybe we could at least add an assert
>> that bcount is not larger than rsp_size. I think that would at least
>> give an explicit error instead of a buffer overflow.
>>
>> I can also try to dig deeper into this when I get some time. At the
>> moment I know nothing about the tpm device emulation.
>>
> 
> The loop has run 3000 times by itself so that part is stable. However, 
> it seems there is some other test case that the loop cannot run in 
> parallel with. So, yes there is 'something'. ... ... Just having all 
> CPUs in a system busy requires waiting for migration to be complete on 
> the dst_qemu side as well. Can you try it with this patch:
> 
> diff --git a/tests/qtest/tpm-tests.c b/tests/qtest/tpm-tests.c
> index fb94496bbd..b52cd44841 100644
> --- a/tests/qtest/tpm-tests.c
> +++ b/tests/qtest/tpm-tests.c
> @@ -115,6 +115,7 @@ void tpm_test_swtpm_migration_test(const char 
> *src_tpm_path,
> 
>       tpm_util_migrate(src_qemu, uri);
>       tpm_util_wait_for_migration_complete(src_qemu);
> +    tpm_util_wait_for_migration_complete(dst_qemu);
> 
>       tpm_util_pcrread(dst_qemu, tx, tpm_pcrread_resp,
>                        sizeof(tpm_pcrread_resp));
> 

Only waiting on the destination side is also possible:

diff --git a/tests/qtest/tpm-tests.c b/tests/qtest/tpm-tests.c
index fb94496bbd..197714f8d9 100644
--- a/tests/qtest/tpm-tests.c
+++ b/tests/qtest/tpm-tests.c
@@ -114,7 +114,7 @@ void tpm_test_swtpm_migration_test(const char 
*src_tpm_path,
                       sizeof(tpm_pcrread_resp));

      tpm_util_migrate(src_qemu, uri);
-    tpm_util_wait_for_migration_complete(src_qemu);
+    tpm_util_wait_for_migration_complete(dst_qemu);

      tpm_util_pcrread(dst_qemu, tx, tpm_pcrread_resp,
                       sizeof(tpm_pcrread_resp));


