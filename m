Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63475C83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Jul 2025 21:09:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugV5P-0003yQ-OL; Mon, 28 Jul 2025 17:08:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1ugV2m-0002uJ-92; Mon, 28 Jul 2025 17:06:11 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1ugV2j-0001bW-Hp; Mon, 28 Jul 2025 17:05:59 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56SFo2F9009981;
 Mon, 28 Jul 2025 21:05:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=leoXtK
 OMS/1KzZW/3iOFEmWOAtTEJBeMFf4Tme6CXgE=; b=PRGk/OAms/aRfHfjnMxjdn
 21Z0rEGsI/0w8wmzjZcZjWMpWw2Qrsjz5b1gsjGf9+iOpHWWmQIwnVtHLrFqLnSt
 wfDips0pqnYOhY4v2Fes3MIDhF+DYYp/5+P+mW8gbLuwRYlIfjEXDP2zSNh6dkHV
 rusXpsQ9iMMMnVo6Y+EB39/ffsEkQw2Vfeic100HM83BtbCss2F2fxQUP3BtBV9y
 AqopvHe9B1RLBRSFEliZxsSLUxGoYunVVyLZlA5XKKUojyqRaomYu4cdQGqSs/rK
 Uvv0zCCp/3VX/O3ZS0cyxxeDPv3KCoZCZGEPCSmr2EzpqJeCfvKRtDAK4web0KEA
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 486c6hh9k6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 28 Jul 2025 21:05:54 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56SK8MSI006209;
 Mon, 28 Jul 2025 21:05:53 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 485bjky9v2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 28 Jul 2025 21:05:53 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 56SL5j5m21692982
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 28 Jul 2025 21:05:45 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EC6B65803F;
 Mon, 28 Jul 2025 21:05:51 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 50F735804E;
 Mon, 28 Jul 2025 21:05:50 +0000 (GMT)
Received: from [9.67.140.90] (unknown [9.67.140.90])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Mon, 28 Jul 2025 21:05:50 +0000 (GMT)
Message-ID: <94b2236a-3797-418d-9062-e81fa7908500@linux.ibm.com>
Date: Mon, 28 Jul 2025 17:05:49 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Collin Walling <walling@linux.ibm.com>
Subject: Re: [PATCH v4 20/28] pc-bios/s390-ccw: Add signature verification for
 secure IPL in audit mode
To: Zhuoying Cai <zycai@linux.ibm.com>, thuth@redhat.com, berrange@redhat.com, 
 richard.henderson@linaro.org, david@redhat.com, pbonzini@redhat.com,
 jrossi@linux.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: jjherne@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, iii@linux.ibm.com
References: <20250711211105.439554-1-zycai@linux.ibm.com>
 <20250711211105.439554-21-zycai@linux.ibm.com>
 <eccbac31-7c1d-4b75-a284-a46ad98675db@linux.ibm.com>
 <86deb470-54a6-460f-bf25-239d2256ea28@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <86deb470-54a6-460f-bf25-239d2256ea28@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: DZ2q0RGW9sCyQmrL0TFaxLvTi9t_0M0n
X-Authority-Analysis: v=2.4 cv=Mbtsu4/f c=1 sm=1 tr=0 ts=6887e632 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=YWRnWzmL_sF1-JY41XEA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: DZ2q0RGW9sCyQmrL0TFaxLvTi9t_0M0n
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI4MDE1NCBTYWx0ZWRfXz8aI2uclOEBt
 9LfwjM79RANuVgTvI8LZs0jVpi5KpchOQkQvroSQrImVqYQcfXJVDWVTJmOiAKEOFIuIt9mgpb5
 7NirjoqHgp663ch7GdlzerS3/XErvJ8NJztqk2lM3lc0KqF2GW59hzFqkyGgkLi/NA8oiR465KL
 IFVZMRlC57KZ2+JFRaLLlUYHIcqlEXTWUoWYpzCsMxyCy5Hq+t+AuvNJYCI4f89oQAyIwtHaGkI
 fAc0jSK1wrqjChgAJ7l+3raR6JrnJxK42gJ2hveX4oFjhavjMzlt/fAQODVNMQPASbMPUgT0gLx
 i0PMdFi64fa0Y4xiRZWJLMGOAg3sPZ0NjKiunXdRrjaR2WgX30hvYU4/04GGI9obtpWHeazMFT8
 gZOZ1PB9mkxXp9/aNoCeFOSnyqhPG8urcle5stzS1eLsVgMHRMmripVss2Gn7073D8OkpIq3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-28_03,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 spamscore=0 mlxscore=0 impostorscore=0 phishscore=0 mlxlogscore=762
 lowpriorityscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507280154
Received-SPF: pass client-ip=148.163.156.1; envelope-from=walling@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 7/21/25 17:50, Zhuoying Cai wrote:
> On 7/11/25 6:50 PM, Collin Walling wrote:
>> On 7/11/25 5:10 PM, Zhuoying Cai wrote:

[...]

>>>  
>>> +typedef enum ZiplBootMode {
>>> +    ZIPL_NORMAL_MODE = 1,
>>> +    ZIPL_SECURE_AUDIT_MODE = 2,
>>> +} ZiplBootMode;
>>
>> These should be ZIPL_BOOT_MODE_*
>>
>> Also, is there a reason why the list starts at 1 and not defaulting to
>> the implicit 0?
>>
> 
> boot_mode is a global variable defined in pc-bios/s390-ccw/main.c, and
> it defaults to 0, which indicates that the boot mode hasn’t been
> determined yet.
> 
> We start the list at 1 to reserve 0 as the implicit “undefined” or “not
> yet set” value. The actual boot mode is only set later when boot_mode == 0:
>     if (boot_mode == 0) {
>         boot_mode = zipl_mode(iplb->hdr_flags);
>     }
> This allows us to distinguish between an unset state and valid boot modes.
> 

I would have thought to default the boot mode to NORMAL, but I haven't
had my eyes on the BIOS patches in a bit.  Unsure what makes sense.

For now, I'd suggest adding ZIPL_MODE_UNSPECIFIED (or something like
that) to the list.

[...]

-- 
Regards,
  Collin

