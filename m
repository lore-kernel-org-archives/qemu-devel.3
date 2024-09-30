Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFA16CE8349
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 14:20:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svHG1-0000Wl-0a; Mon, 30 Sep 2024 10:20:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1svHFx-0000Mb-3t; Mon, 30 Sep 2024 10:20:09 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1svHFu-00074J-Qp; Mon, 30 Sep 2024 10:20:08 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48UDmkYD021041;
 Mon, 30 Sep 2024 14:20:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=1
 OT0CCfWOyZHEbTUvoXNfX23gXVblKKWwnsKfQblVx4=; b=IT+uQlQqtCySWw17K
 TiTdVEOOw2+amw1HIaoIRK7kRak1mymuDOjBynOHQg7YeKPaYLXo8Dz4dxnS0U4G
 ipltIRpYIPLbGF7veNSjFNuUPrGJ48/Y+xwQU0h3n65c8m0KmiEsXICsTTmSH6v0
 40UNrGIqjWtLrSXz/0/+MmYyhY8im9OrRlSB0kSBGbOPfKBLnh/1twXlbJUJni/0
 lF/TUd4EViibx2gyD35l3tfDXEvJN5KQUnCdjusC+4LB/j/Id5gPpA1sDKk2FNo3
 TsWw+1a0oWdgOhInRuW0QEpaxScXVE8ZAL8XKCxMUpn9LgzRLqF8kqdzI61Y+/7G
 y28RQ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41x9fwt9xt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 30 Sep 2024 14:20:04 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48UEK33g004204;
 Mon, 30 Sep 2024 14:20:03 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41x9fwt9xq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 30 Sep 2024 14:20:03 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48UCU7JW002767;
 Mon, 30 Sep 2024 14:20:03 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 41xxu0xkt0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 30 Sep 2024 14:20:02 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 48UEK2Lg24576612
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 30 Sep 2024 14:20:02 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 00FD558062;
 Mon, 30 Sep 2024 14:20:02 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9D9B458061;
 Mon, 30 Sep 2024 14:20:01 +0000 (GMT)
Received: from [9.61.73.98] (unknown [9.61.73.98])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Mon, 30 Sep 2024 14:20:01 +0000 (GMT)
Message-ID: <73e67bb1-d7bd-42cf-82b6-2c7c79f20dde@linux.ibm.com>
Date: Mon, 30 Sep 2024 10:20:00 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 0/18] s390x: Add Full Boot Order Support
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: frankja@linux.ibm.com
References: <20240927005117.1679506-1-jrossi@linux.ibm.com>
 <11deab13-116a-415e-bc44-82fd80dd516a@redhat.com>
Content-Language: en-US
From: Jared Rossi <jrossi@linux.ibm.com>
In-Reply-To: <11deab13-116a-415e-bc44-82fd80dd516a@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: QydQxF34e29RiV8OtEncmwhkzQgLN0v-
X-Proofpoint-GUID: QKCQzwdhRTOqBi1WQS9TA2A0xqcUJxeg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-09-30_12,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 clxscore=1015 malwarescore=0 adultscore=0 spamscore=0 impostorscore=0
 mlxscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409300102
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jrossi@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



On 9/30/24 9:14 AM, Thomas Huth wrote:
> On 27/09/2024 02.50, jrossi@linux.ibm.com wrote:
>> From: Jared Rossi <jrossi@linux.ibm.com>
>> ...
>
> Thanks, this looks already much better than the "jump back to start" 
> stuff in v1 !
>
> One thing I noticed while testing your patches: Booting from ISO 
> images seems to be broken for me now, e.g. something like:
>
> ./qemu-system-s390x -nographic -accel kvm -m 1G \
>  -bios pc-bios/s390-ccw/s390-ccw.img \
>  -drive 
> if=none,id=d1,file=Fedora-Server-dvd-s390x-38-1.6.iso,format=raw,media=cdrom 
> \
>  -device virtio-scsi -device scsi-cd,drive=d1,bootindex=1
>
> used to work fine in the past, but gives me a "Failed to IPL this ISO 
> image!" error now.
>
> Does ISO IPL-ing work for you?
>
>  Thomas
>
>

Hi Thomas,

Firstly, I just wanted to say thank you for your continued support and 
guidance
on this feature. Converting all of the panics to returns ended up being 
rather
invasive and touched a lot of code I had not initially expected to 
modify, so
I appreciate your patience with the rework.

As for the ISO IPL, after reading your review comments I’m not surprised it
fails for you. The problem is certainly caused by the mismatched error
condition checks you pointed out in your response to patch 07. I also
recognize that means this code path was not sufficiently exercised in my own
testing, so I will resolve that and also double check for any other gaps in
coverage on my side.

I will make the changes you suggest and also add the automated test 
cases you
previously requested, and try to get v3 posted ASAP.

Thanks again,
Jared Rossi

