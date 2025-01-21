Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32DF0C02182
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 10:23:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taBPT-00066h-Dw; Tue, 21 Jan 2025 05:23:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1taBPS-00066W-Gu
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 05:23:02 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1taBPR-0000Sf-00
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 05:23:02 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50L7XLhD010145;
 Tue, 21 Jan 2025 10:22:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=ANKfck
 WiTsT0e0Zh7/H9/mkgivV4RwIQ09EwusxBR0s=; b=AOG0byAmqVezsh6LJXOEyt
 2fmZJhqo8WEi1tgGqyLWA+9PkCW5NFF7a4CiO58Q7bduGTKfPd5XsWEEJ/G8WPJF
 J+KY8ykoJvawC3000vF4Jd/IZbXDnk6JavFOTQPRNXQvX51dHzDyDPdhyzYjiAdM
 HpWu+4QyCbYwJ61y4zpG2MWOcOqRvylVrim9Y4CSGT9pBMTvnjeGqUlvvvPY/mNu
 SV27D0B2xBwjabKas28friIy6Ob06X3TAyApbS/2pubVloJGkdJVZ84wwaGmQU0x
 yuXqERcd1fF4yjCZYzg79LUamH7kRxdd9/VUj7tLwID51sHfXVXbyyxa0M4kZjjw
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44a79n0rm7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 Jan 2025 10:22:53 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50LAJrmc009775;
 Tue, 21 Jan 2025 10:22:52 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44a79n0rm4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 Jan 2025 10:22:52 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50L6FOQo029594;
 Tue, 21 Jan 2025 10:22:52 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 448qmnam0f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 Jan 2025 10:22:52 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 50LAMpsU7537284
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 21 Jan 2025 10:22:51 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 35C0E58060;
 Tue, 21 Jan 2025 10:22:51 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2A8BA58054;
 Tue, 21 Jan 2025 10:22:49 +0000 (GMT)
Received: from [9.199.192.140] (unknown [9.199.192.140])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Tue, 21 Jan 2025 10:22:48 +0000 (GMT)
Message-ID: <0d9eabcf-8d4e-4f36-a593-b1ff1ad16e7b@linux.ibm.com>
Date: Tue, 21 Jan 2025 15:52:46 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 00/16] TCG code quality tracking
To: Nikita Shubin <nikita.shubin@maquefel.me>, richard.henderson@linaro.org
Cc: fei2.wu@intel.com, qemu-devel@nongnu.org,
 "Vanderson M. do Rosario" <vandersonmr2@gmail.com>, harshpb@linux.ibm.com
References: <2932b992b411497ccd3bbbb717621473e06a96b7.camel@maquefel.me>
Content-Language: en-US
From: Chinmay Rath <rathc@linux.ibm.com>
In-Reply-To: <2932b992b411497ccd3bbbb717621473e06a96b7.camel@maquefel.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: GhuOzw_cZVzkBMt-x3k6Nub8wUrlHt5J
X-Proofpoint-ORIG-GUID: cWrK2Wj8jD5rpWLE8L66aJPxnElDrI0R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-21_05,2025-01-21_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 mlxscore=0
 lowpriorityscore=0 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 spamscore=0 mlxlogscore=657 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501210082
Received-SPF: pass client-ip=148.163.158.5; envelope-from=rathc@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.036, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hello Richard,

Are you planning to come up with any new iterations of this patch series, or planning to merge it sometime ?
This seems to be very useful, hence wanted to know your plans with this.

Thanks,
Chinmay

On 11/14/24 14:58, Nikita Shubin wrote:
> Hello Richard and Vanderson !
>
> Any news on this series ? It's been 26 spins already (yep i am counting
> Vanderson series also).
>
> While it's a really great idea in general, it also has great
> educational purpose.
>
> I've rebased v17 on the top of current master branch, but maybe we can
> hope for another spin ? Especially with graphs, which are missing in
> latest series.
>
> ---
> Yours,
>
> Nikita Shubin
>

