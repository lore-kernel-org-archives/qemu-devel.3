Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B27C0D1D870
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 20:58:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0obm-00040a-L4; Tue, 15 Oct 2024 16:57:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1t0obl-00040Q-5Y
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 16:57:33 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1t0obj-0005X8-IO
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 16:57:32 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49FKnve4008472;
 Tue, 15 Oct 2024 20:57:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=eJYA4N
 Fpqoex/LJiOqYEscajZwawUOAXiFkURMzZOM0=; b=RNXGBS0uy05d/NPdKwExta
 eDDJn9bbi0sIoPQA3lBwVRLY1GBo66qvJ8YZFe19hS71Qtvv20gMmE2+qUodr+EB
 ihNpyflaydEy5AFmmfU+z24KjFlqxmaT+CTezfYN529yG/5xdflIFtZ4G3x6z/aZ
 /+awsXVJXpaoDJMEa6W2aQVb4R/Ya3u909Gc+E0Dw4YUwkhUsCy+9rD/gI6rs4pn
 1663Eqp3ozZj0By/t3MyOHhGqa+hhNoRc1lt/Zf50ASxHUkatFrpV9PhovYpvNnl
 2Qma96fb5fZj3OFndi5zKH8djIITjakKSIQiVUHr3huEBrIo+ir6W4Emp7p3ICow
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 429ysbr0nk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Oct 2024 20:57:29 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49FJ0pS4005936;
 Tue, 15 Oct 2024 20:57:28 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 428650whxg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Oct 2024 20:57:28 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 49FKvRXK34669232
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 15 Oct 2024 20:57:28 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 992EC5806C;
 Tue, 15 Oct 2024 20:57:27 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7AA4158061;
 Tue, 15 Oct 2024 20:57:27 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 15 Oct 2024 20:57:27 +0000 (GMT)
Message-ID: <d9b18dc6-994b-4fdb-8f6c-5cb9bd11eb64@linux.ibm.com>
Date: Tue, 15 Oct 2024 16:57:27 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: tpm-tis-device-swtpm-test timeout
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
References: <87jze9qlrp.fsf@suse.de>
 <077cee03-efd0-4716-865a-b9990afb91a3@linux.ibm.com> <87h69dqigg.fsf@suse.de>
 <865424c1-f79c-44ad-b70f-8bf3e455e025@linux.ibm.com> <87ed4hqgvl.fsf@suse.de>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <87ed4hqgvl.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: AP5r44VhB6Fxu0hLQ3IF9P3rnqkNggc8
X-Proofpoint-ORIG-GUID: AP5r44VhB6Fxu0hLQ3IF9P3rnqkNggc8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0
 impostorscore=0 malwarescore=0 mlxlogscore=999 clxscore=1015 spamscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2409260000 definitions=main-2410150138
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



On 10/15/24 3:57 PM, Fabiano Rosas wrote:
> Stefan Berger <stefanb@linux.ibm.com> writes:
> 

>>
>> So this here is failing for you every time?
>>
>> QTEST_QEMU_BINARY=build/qemu-system-aarch64
>> ./build/tests/qtest/tpm-tis-device-swtpm-test
> 
> Sorry, I was unclear. No, that runs for about 30 iterations before it
> fails. I just ran each of these in a terminal window:
> 
> $ for i in $(seq 1 999); do echo "$i =============";  QTEST_QEMU_BINARY=./qemu-system-aarch64 ./tests/qtest/tpm-tis-device-swtpm-test || break ; done

On my Fedora 40 host this command line here alone has been running for 
250 loop iterations now and is still continuing.

> $ make -j$(nproc) check

So this needs to be run in parallel to the above command line to cause 
the failure?

> $ while :; do ps aux | grep -v grep | grep swtpm; done

