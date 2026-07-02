Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C79B0C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 00:48:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wf5aE-0004dI-Gu; Wed, 01 Jul 2026 20:47:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wf5aB-0004cg-8W; Wed, 01 Jul 2026 20:47:11 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1wf5a9-0002IM-9p; Wed, 01 Jul 2026 20:47:10 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 661LmKmM2088542; Thu, 2 Jul 2026 00:47:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=CKeNkG
 RzGo1gdp8iFixpR29n1AB3EI9tedPI29nKG5I=; b=bglamQsevjk4LOWRzKZonL
 lXhAhYR+OYFK0eVrus3C+ekEDwFG7MfwXM9zqubxOxoEhiu9q29As2t3HSH3R22q
 AIukYQZgsDmIAWxQ2yjVIie6QsV1udJcgv5Bjk3eTiCuIpigHHH3olWdr7wOPrWm
 RqJM63LB27hgGC6KYgtaQC+8zRVmBTlGO4KDuKjwAcLN1VnJMpqEK3lM9IrkBQDb
 0qx55DVELoDEuyco8/C0Ma8h8EbfVJH6uxNpKlesHcIzwk4mLAugsHa/YQe7jHq9
 MYQBNH0VtWOhYf2U17SOJU40AnxsZe3MJqbsxQ50L0xRX1F7a4Rf6OpMqeVha0Ig
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26pe7e7t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Jul 2026 00:47:05 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6620Yra6007367;
 Thu, 2 Jul 2026 00:47:04 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2uhyhhk1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Jul 2026 00:47:04 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6620l2LB13566622
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 2 Jul 2026 00:47:02 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 97A5B5805D;
 Thu,  2 Jul 2026 00:47:02 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A7D0B58043;
 Thu,  2 Jul 2026 00:47:00 +0000 (GMT)
Received: from [9.61.65.1] (unknown [9.61.65.1])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  2 Jul 2026 00:47:00 +0000 (GMT)
Message-ID: <510adb4f-6386-4c59-947a-aa48f6120e9e@linux.ibm.com>
Date: Wed, 1 Jul 2026 20:47:00 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 01/35] Add boot-certs to s390-ccw-virtio machine type
 option
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
From: Matthew Rosato <mjrosato@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <dbd14a70-ec58-4286-9ff3-a7687ab48f3c@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 6rN7UuRWy_jOZMhOnB6eM_oJ8NH3dN0d
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDAwMSBTYWx0ZWRfX9QK0JInzl2lQ
 PZqp/aG+bggARrdwsEIFC7FnMDypXKOF4AdPjJiFK3XE8b3w8QDICpPOKfCGmJZC8gEQXGKabDl
 q1p0YMIzCDsM//KQbkq6ru53uRa2ezU=
X-Authority-Analysis: v=2.4 cv=edsNubEH c=1 sm=1 tr=0 ts=6a45b509 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=rasLI7M-oKIyvpGd2tcA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDAwMSBTYWx0ZWRfX41B+/9NBSpCO
 Bzpe+AdvSjrMf88g/gE2PSX1PnGQGc7YYJ5qBPn/7FKHs6xwds9fX0NbLA8Q64SCUBY72A5KU8a
 o5AJ/RTdsLhBlncM/vz9NXhILOTYQR2mN6y88Yvbg24l6Ix2ppceS9UP/6lsVD2C8EjTXi8ykqV
 816hXJc4nesN33p/mu3A8sj1epj1lVxoQmFuaTABWUGa0nJjnTBk2tV6dLbh60I+cqQ8++SHPNS
 AGVDzNUPPBTik8w3XEPu/PMQaysHYTwN+eoGXCmAYAFJF8yS3tuoJxzbxQ2ASzAIHGhZ/7RzKhQ
 AFG3ya+TVXysCztFN2HNqvvOgKqJyTW2Rm1cytkgu0maG1HiUZrr04WSILpS0arLpOu2yQTsSYw
 zI8mykVd/WJuK+RzecUL9hLtqLEG26nBaqsmMtr0A6yCrjccppCHyl/wktl954LcTXkMmcASeko
 d+tTwBJjIYxw07jimnw==
X-Proofpoint-ORIG-GUID: 6rN7UuRWy_jOZMhOnB6eM_oJ8NH3dN0d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_05,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=0 bulkscore=0
 spamscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020001
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

On 7/1/26 7:30 PM, Jared Rossi wrote:
> 
> 
> On 7/1/26 4:48 PM, Zhuoying Cai wrote:
>> Introduce a new `boot-certs` machine type option for the s390-ccw-virtio
>> machine. This allows users to specify one or more certificate file paths
>> or directories to be used during secure boot.
> The new boot-certs option is able to handle complex certificate
> organization across multiple directories, but it seems to reject the
> most basic case of passing a single directory path.
> 
> E.g. using: -machine s390-ccw-virtio,accel=kvm,boot-certs=/root/certs
> 
> produces the error: "Invalid parameter type for 'boot-certs', expected:
> array"
> 
> I understand that this can be fixed by expanding "boot-certs" to "boot-
> certs.0.path" however this does not seem intuitive to me. Is this the
> expected behavior by design?

smp-cache exhibits the same behavior e.g.

'smp-cache.cache=l1d,smp-cache.topology=cluster' does not work

'smp-cache.0.cache=l1d,smp-cache.0.topology=cluster' does

So I believe it is a common shortcoming.  If you only want a single
certificate directory, it will be boot-certs.0.path.

The rationale for wanting to be able to specify multiple paths was
provided by Daniel here:

https://lore.kernel.org/qemu-devel/aMvE7Phd7sLvgj-J@redhat.com/

> 
> Regards,
> Jared Rossi
> 
>> Each entry is specified using the syntax:
>>     boot-certs.<index>.path=/path/to/cert.pem
>>
>> Multiple paths can be specify using array properties:

Nit: s/specify/specified/

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>



