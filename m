Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D73E7C83038
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Jun 2025 19:33:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWKEa-0004xW-2m; Mon, 30 Jun 2025 15:32:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1uWKEP-0004u9-AB; Mon, 30 Jun 2025 15:31:59 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1uWKEM-0003WX-JI; Mon, 30 Jun 2025 15:31:57 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55UHcJsB019490;
 Mon, 30 Jun 2025 19:31:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=fBTPa0
 eNDlJmgTyTXWjL88Pq5P/0yz4jmN2qU+VqpjM=; b=DA3lyhF13tJVA929+BDFcC
 DZNKPVxyKV2hJKecp4vSnYJXIQllsSUpJunK6+GASUKHxRO+KSRQtaoTk2JriRLC
 6xRm+EWJXCaJ/YUeV3EduP8RSEF9laerxYTzlEkkbsLLs5TDPPpZqPZrtJf5amrM
 UN4kTBEuNDzG0um5TH6KhFpp3UzGyLOIuG6OWs+/Zup3ZBuvSohFaSChaMB9aWLD
 tnsOONGD4If7iFBG9RD05FY7RlWayF7dFBRw9Tn/Ytpo77qh1mvshIXurmFxaW9p
 Htk83IJ2VwskI+32DVXrSZ9PN0pL2gAow9NfrYUUzGxRcrXzt02o1y/pKoCX0EHg
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47j7wrbcup-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 30 Jun 2025 19:31:43 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55UILuJ9021939;
 Mon, 30 Jun 2025 19:31:42 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47juqpf96u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 30 Jun 2025 19:31:42 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 55UJVe4L62587218
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 30 Jun 2025 19:31:40 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 929C558051;
 Mon, 30 Jun 2025 19:31:40 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B08E85805C;
 Mon, 30 Jun 2025 19:31:39 +0000 (GMT)
Received: from [9.61.110.65] (unknown [9.61.110.65])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Mon, 30 Jun 2025 19:31:39 +0000 (GMT)
Message-ID: <25eb9d2e-b6d5-4af7-9087-dfeede1a879f@linux.ibm.com>
Date: Mon, 30 Jun 2025 15:31:39 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/28] Add boot-certificates to s390-ccw-virtio machine
 type option
To: Jared Rossi <jrossi@linux.ibm.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 pbonzini@redhat.com, walling@linux.ibm.com, jjherne@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
 iii@linux.ibm.com, eblake@redhat.com, armbru@redhat.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org
References: <20250604215657.528142-1-zycai@linux.ibm.com>
 <20250604215657.528142-2-zycai@linux.ibm.com> <aEL0bVhOFaCQbiBS@redhat.com>
 <7451ec24-1e42-4fb7-8a6a-4b7fa7009452@linux.ibm.com>
 <4cf2bc35-f735-43d6-9716-d449cfc43980@linux.ibm.com>
Content-Language: en-US
From: Zhuoying Cai <zycai@linux.ibm.com>
In-Reply-To: <4cf2bc35-f735-43d6-9716-d449cfc43980@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=E/PNpbdl c=1 sm=1 tr=0 ts=6862e61f cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=OvTz5OeRKy__VLHic7wA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: yWD2Sgyi2KkiDOq41Dn2OesLNX_HRgto
X-Proofpoint-ORIG-GUID: yWD2Sgyi2KkiDOq41Dn2OesLNX_HRgto
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjMwMDE1NyBTYWx0ZWRfXzyG3lNMhJplu
 5yFJJ5VI+17MgLvA6GvBJL8SGHTJ1BplzKAVd9umbFdQiWE32u4idcr8q/QrFB3DIFBPiMLn4Jg
 cUY6MyDkfo1EjuAatbIEWoLsjHibOUssFu/h1f8cJPRsvwLYml3EmfkNOVr37+ex9Iy4ZWzxSLE
 rjyvK3TyE+MRMm4yc8tVpgw5k7BnogyONA+B0IuFHME4+PFQavfUIs33gN5EzKyvkBqQOJBEaBb
 /j91XVuLQUfCFbLhmEJVc7WBoQWYPKOd1w6ThPbmChNkku3ZkiwdSmfDkzh1k4NU6xml9o+dZEk
 6WeRz17ECOL9CmeRXuB83iCU5vuJoqemQdgQRV1/kA6tk3ZEq97f4WE3nMKFIhcSTv2t3l1CXLL
 hFwYMPxrKNMpIm/gVtBMy4gO5djwhico1Mu5AYF3sNlTrEjQx5pd9v1tJZdFhHKRLfBb13EX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-30_04,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0
 bulkscore=0 priorityscore=1501 phishscore=0 suspectscore=0 mlxlogscore=999
 lowpriorityscore=0 mlxscore=0 clxscore=1015 adultscore=0 impostorscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506300157
Received-SPF: pass client-ip=148.163.156.1; envelope-from=zycai@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 6/24/25 11:03 AM, Jared Rossi wrote:
> 
> 
> On 6/20/25 11:45 AM, Zhuoying Cai wrote:
>> On 6/6/25 10:00 AM, Daniel P. Berrangé wrote:
>>> On Wed, Jun 04, 2025 at 05:56:29PM -0400, Zhuoying Cai wrote:
>>>> Add boot-certificates as a parameter of s390-ccw-virtio machine type option.
>>>>
>>>> The `boot-certificates=/path/dir:/path/file` parameter is implemented
>>>> to provide path to either a directory or a single certificate.
>>>>
>>>> Multiple paths can be delineated using a colon.
>>> How do users specify paths which contain a colon as a valid
>>> character ?
>>>
>> It was suggested to separate lists of directories and files with a
>> colon, following the convention used by the shell PATH variable. As the
>> colon serves as a delimiter, it’s expected that individual paths do not
>> contain any colon characters.
> 
> I'm not sure if I understand why this is needed.  Why would someone want 
> to have the certificates in two distinct locations, as opposed to all in 
> one directory or in sub-directories of a single main certificate 
> directory? Supporting only one path would simplify both the 
> implementation and the usage.  Could we just not allow multiple paths, 
> or is there a use case that requires it?
> 

We chose to support lists of directories and files to provide greater
flexibility in the CLI. One use case involves scenarios where some
certificates are shipped with the distro (e.g., /usr/path/cert/dir),
while additional certificates may be managed by the local admin in a
separate location, such as /etc/path/cert/dir.

If supporting multiple of directories and files is a concern, the design
could be simplified to allow a single directory containing all the
certificates required for secure boot, which should still cover typical
usage scenarios.

I'd appreciate any additional feedback on this design.

>> [snip..]
>>


