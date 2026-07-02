Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9913EC43327
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 17:12:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfKxl-00010O-Nq; Thu, 02 Jul 2026 13:12:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wfKxh-0000zL-N5; Thu, 02 Jul 2026 13:12:29 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wfKxf-0002uF-Uv; Thu, 02 Jul 2026 13:12:29 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 662EIKTU4074595; Thu, 2 Jul 2026 17:12:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=QhbO97
 Z5btYiFxmIMxgM6Z6hdZbYpSJLX9Hyf0ZJvzw=; b=bMzAvtCJu2l/IxgM0w3g8f
 t0MMKDv5EUqp1w0lEw1HDalWyz/xejeD73YO9nVzU2te/Pmi7B4G3A9s5/Yp9T/H
 x0pmS01Ks/d79SbJiN95VBL+sDK1blz3DulHTnDTAR3fObK9N4ybYB8rie+kWovw
 GDeE4xgZS/ibN+T0ngIqUdvvitAdRhQfWVtEHn4RynFoMhkTUPbPMM9N6Fybvuk8
 ue0KStnyUQ2lV99JLb1Iw2eAuIDcVceYmWrpP/lxzeJ25x5JNWcb25HTm1BVeKyP
 Z12CQ6721bhHg5rwnh9b9KyapQUkMRD88RuRtJWsM32yDwzICfs3tMe+ZStHMXKw
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26n63685-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Jul 2026 17:12:23 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 662H4hG8018401;
 Thu, 2 Jul 2026 17:12:22 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2ruqn7pq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Jul 2026 17:12:22 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 662HCLUr61014462
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 2 Jul 2026 17:12:21 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 460575803F;
 Thu,  2 Jul 2026 17:12:21 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3D37E5804E;
 Thu,  2 Jul 2026 17:12:19 +0000 (GMT)
Received: from [9.61.65.1] (unknown [9.61.65.1])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  2 Jul 2026 17:12:19 +0000 (GMT)
Message-ID: <72eb3ae0-2781-4bc7-9329-80063053ee65@linux.ibm.com>
Date: Thu, 2 Jul 2026 13:12:18 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 01/35] Add boot-certs to s390-ccw-virtio machine type
 option
From: Matthew Rosato <mjrosato@linux.ibm.com>
To: Jared Rossi <jrossi@linux.ibm.com>, Zhuoying Cai <zycai@linux.ibm.com>,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: cohuck@redhat.com, berrange@redhat.com, richard.henderson@linaro.org,
 david@kernel.org, walling@linux.ibm.com, jjherne@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
 iii@linux.ibm.com, eblake@redhat.com, armbru@redhat.com,
 alifm@linux.ibm.com, brueckner@linux.ibm.com,
 pierrick.bouvier@oss.qualcomm.com, jdaley@linux.ibm.com
References: <20260701204922.1320349-1-zycai@linux.ibm.com>
 <20260701204922.1320349-2-zycai@linux.ibm.com>
 <dbd14a70-ec58-4286-9ff3-a7687ab48f3c@linux.ibm.com>
 <510adb4f-6386-4c59-947a-aa48f6120e9e@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <510adb4f-6386-4c59-947a-aa48f6120e9e@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDE3NyBTYWx0ZWRfX++p54sbeddJR
 85o7fShFdO6GdS0BFzJCYMWLKSq9vfUAOpUTRGoD70AbWHA+HcyyN/+4bviLPjw3uFqs8YP11a3
 wHnhVb5zKCDqLrv94wbU6f544ARW0HlEAQRVAtMtlq76xF3ioDn8CiAfJS5O0EB91urSFZK8slx
 J+O/2Wt815/6UphjQROcC1ub8vrpCazLiRl8rHNIPGAht4mJwjoQ6tWnP8dJxqBiEtZ8BTaymaQ
 GJaY/bLpul+eB2IW8HA9p62GEWnlHZU4wLHE15HunMjwA3oANxrjaSicHhU+9oSGaBZrExaDL3M
 J68KRGoiHW3XgvnptRpg7vfY90mVErUTdvIdz47Gnkn+0ATvn+R3zupk9Ih83+0jzF/s115apXB
 2jN82efZw7rpcSGUxUh4WMjQf37zv/KrdAvLU3pXYYJS60xUl7z4P9fSTIz2zYkFU+sLZWCaBgE
 U9fjxMHPlwLsRV8jjcw==
X-Authority-Analysis: v=2.4 cv=V45NF+ni c=1 sm=1 tr=0 ts=6a469bf7 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=TRs3a9Ngzka44zH3UT0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: NjYeTfb8ENu_C9m8vOpzrZJr5fHm3g23
X-Proofpoint-GUID: NjYeTfb8ENu_C9m8vOpzrZJr5fHm3g23
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDE3NyBTYWx0ZWRfX/zQwZE8vi1yI
 +AWL/YoYbYFJXmPsdTsudmqwoebMr+fP9cly/2YatdOKkNeNFPUrCR5pWOHy89WgowKXFIHe0Tk
 cldnyZRt7Wgf81sply8UpF00zMA+IRM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 impostorscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020177
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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

On 7/1/26 8:47 PM, Matthew Rosato wrote:
> On 7/1/26 7:30 PM, Jared Rossi wrote:
>>
>>
>> On 7/1/26 4:48 PM, Zhuoying Cai wrote:
>>> Introduce a new `boot-certs` machine type option for the s390-ccw-virtio
>>> machine. This allows users to specify one or more certificate file paths
>>> or directories to be used during secure boot.
>> The new boot-certs option is able to handle complex certificate
>> organization across multiple directories, but it seems to reject the
>> most basic case of passing a single directory path.
>>
>> E.g. using: -machine s390-ccw-virtio,accel=kvm,boot-certs=/root/certs
>>
>> produces the error: "Invalid parameter type for 'boot-certs', expected:
>> array"
>>
>> I understand that this can be fixed by expanding "boot-certs" to "boot-
>> certs.0.path" however this does not seem intuitive to me. Is this the
>> expected behavior by design?
> 
> smp-cache exhibits the same behavior e.g.
> 
> 'smp-cache.cache=l1d,smp-cache.topology=cluster' does not work
> 
> 'smp-cache.0.cache=l1d,smp-cache.0.topology=cluster' does
> 
> So I believe it is a common shortcoming.  If you only want a single
> certificate directory, it will be boot-certs.0.path.
> 
> The rationale for wanting to be able to specify multiple paths was
> provided by Daniel here:
> 
> https://lore.kernel.org/qemu-devel/aMvE7Phd7sLvgj-J@redhat.com/
> 
>>
>> Regards,
>> Jared Rossi
>>
>>> Each entry is specified using the syntax:
>>>     boot-certs.<index>.path=/path/to/cert.pem
>>>
>>> Multiple paths can be specify using array properties:
> 
> Nit: s/specify/specified/
> 
> Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
> 
> 

Hrm, actually...   Shouldn't this be fenced for older machines?

qemu-system-s390x -machine s390-ccw-virtio-10.0,accel=kvm,boot-certs.0.path=/root/certs

Appears to accept the path (I did not try to actually boot),
which clearly would not work if I migrated this guest to an
older QEMU release that has the 10.0 machine but does not
include your code.  There, you would see an error like:

qemu-system-s390x: Property 's390-ccw-virtio-10.0-machine.boot-certs' not found

You can use the compat machine properties to disable it for
older machine versions.

