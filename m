Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09586C9830D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 06:46:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9zh2-0006rW-Q9; Fri, 25 Sep 2026 02:46:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <uverma@linux.ibm.com>)
 id 1x9zh0-0006rG-Cm; Fri, 25 Sep 2026 02:45:58 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <uverma@linux.ibm.com>)
 id 1x9zgu-0002kg-UR; Fri, 25 Sep 2026 02:45:54 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68P4ZvC9102254; Fri, 25 Sep 2026 06:45:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=wEjOFr
 q33wF8YHGvNACp1URYgScet9nBvJNRPEAg3Dc=; b=TIql31QKQ3raVAIGrkgo+Q
 zVjGFCkB0Ecyo1oW8F+X1dIzAEewS2o20gNuGs44HPzLdRoE2Z7cd2HIJd0CKujk
 0DAHrfk2/PpYpqhRrrZ0nXE4ND5xil1SQ9a140xR7QNLun4Cf7wZx/iLRQTAOQ17
 oHZ/zFqaSVxIN6B3HVl6TTX5czMSxscwdummFRXVi+MTOM7OVrZ3pmIGntb/Qc+q
 6kPD3nBcO2LEpeJb0FZi/svrJrU1rKdMn7aYqSfz50Nqs5/T9iaA3YyNgSWrozJZ
 3RCFXNOOblet5oAXK180igZC+fMV/Yo3WW2sXGGboMaXZwgAgypEoHhyPyz2gVtw
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskdvmq4y-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 25 Sep 2026 06:45:44 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68P4lXTO3248862; Fri, 25 Sep 2026 06:45:44 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gvbt319tt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 25 Sep 2026 06:45:44 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68P6jgXo43188646
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 25 Sep 2026 06:45:43 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AD6D058061;
 Fri, 25 Sep 2026 06:45:42 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 61CF758053;
 Fri, 25 Sep 2026 06:45:35 +0000 (GMT)
Received: from [9.43.103.81] (unknown [9.43.103.81])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 25 Sep 2026 06:45:34 +0000 (GMT)
Message-ID: <83d76390-8216-411c-a13f-5765a2ec205a@linux.ibm.com>
Date: Fri, 25 Sep 2026 12:15:33 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 7/8] ppc/spapr: strip OF path argument suffix in
 path_offset
To: Narayana Murty N <nnmlinux@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, aik@ozlabs.ru
Cc: pbonzini@redhat.com, th.huth@posteo.eu, sbhat@linux.ibm.com,
 harshpb@linux.ibm.com, amachhiw@linux.ibm.com, rathc@linux.ibm.com,
 balaton@eik.bme.hu, philmd@oss.qualcomm.com, npiggin@gmail.com,
 marcandre.lureau@redhat.com, fam@euphon.net, avnish@linux.ibm.com
References: <20260817102733.605346-1-uverma@linux.ibm.com>
 <20260817102733.605346-8-uverma@linux.ibm.com>
 <faa52670-30fb-480d-bad5-d2962aec9f0d@linux.ibm.com>
Content-Language: en-US, en-ZM
From: Utkarsh Verma <uverma@linux.ibm.com>
In-Reply-To: <faa52670-30fb-480d-bad5-d2962aec9f0d@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: FvM0yDB_wzri0tLd-_vSrnmW_O6pWwfd
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDAyNiBTYWx0ZWRfX7ZcyhIYlRvGg
 v23L3ovKy3OFaGaPEkqQqN+gMWMgh7c9bW5kFuTIH12tvV/z4M08vtWEMmU0q8FzUdNkWgjcBf+
 pG3kz6VOIl3lY6oKcYIjQiu26m2/gwk=
X-Authority-Analysis: v=2.4 cv=FLiOVOos c=1 sm=1 tr=0 ts=6ab61899 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=gEfo2CItAAAA:8
 a=VnNF1IyMAAAA:8 a=TlqdB3ZDSko0spCAaXkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-GUID: MsH0Q6V4P4aHA0DQigep-YBUyYmq1Ymu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDAyNiBTYWx0ZWRfX9z0QPFCjpYPY
 qY/2is3EpUqtdcHtJB4ogbXGAAgVMa2Tqe6HkWK6EFOMLuZGnpycAle/BJpH4590JrUmVStzbcl
 UDRZUnlIxE+G5HV3IzxDCSkZRnJ8hoyBAcORBu7zzHgmkHWOD3hIWKjgSbCfGfq730/qw9qiJbM
 fI13x+FyMXPIF/fuXMOHVJ1Wla6PR/IUMwDSUrP02nA3IHsSajl8ykUmKA7dgo7nCXkL7mRQ83r
 voLkFcP1b7tvwcJ12yp9eRVgVQixlzKpUCMZ90+mJyJoVo6qYWbUg/0VzrH2T1ZMjek6RVEKjUF
 cz87jZib48HqjhUAwHZGWxmr/3Sx3NsnCXmS4Zu8XLFpGd0PinuP/lMowDxl6V3szf6PkjdTlQL
 haWyaFNpCxqhPtKheXZdNHFaMiIOcUpSkljdv7IyBIVzHdhZWC+FD5wYTLaIGrr+f43BwiHBZ+J
 Tj+5269T2TuAQl6OI6A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 phishscore=0 spamscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609250026
Received-SPF: pass client-ip=148.163.158.5; envelope-from=uverma@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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



On 9/18/26 10:55 AM, Narayana Murty N wrote:
> Hi Utkarsh,
> 
> On 17/08/26 3:57 PM, uverma@linux.ibm.com wrote:
>> From: Utkarsh Verma <uverma@linux.ibm.com>
>>
>> OF paths can include a ":argument" suffix on the last component (e.g.
>> "disk@8000000000000000:0"), which is an OF path argument such as a
>> partition number.  This is not part of the FDT node name and causes
>> fdt_path_offset() to fail.
>>
>> Strip any ":<suffix>" from the last path component only, leaving
>> intermediate components untouched.
>>
>> AI-used-for: code
>> Signed-off-by: Utkarsh Verma <uverma@linux.ibm.com>
>> ---
>>   hw/ppc/vof.c | 16 ++++++++++++++++
>>   1 file changed, 16 insertions(+)
>>
>> diff --git a/hw/ppc/vof.c b/hw/ppc/vof.c
>> index b1c574aabf..d3b0df30e4 100644
>> --- a/hw/ppc/vof.c
>> +++ b/hw/ppc/vof.c
>> @@ -142,6 +142,8 @@ static int path_offset(const void *fdt, const char 
>> *path)
>>   {
>>       g_autofree char *p = NULL;
>>       char *at;
>> +    char *last_slash;
>> +    char *colon;
>>       /*
>>        * https://www.devicetree.org/open-firmware/bindings/ppc/ 
>> release/ppc-2_1.html#HDR16
>> @@ -151,6 +153,20 @@ static int path_offset(const void *fdt, const 
>> char *path)
>>        * suppressing leading zeros".
>>        */
>>       p = g_strdup(path);
>> +
>> +    /*
>> +     * Strip any ":argument" suffix from the last path component (e.g.
>> +     * "disk@8000000000000000:0") — it is an OF path argument, not 
>> part of
>> +     * the FDT node name.
>> +     */
>> +    last_slash = strrchr(p, '/');
>> +    if (last_slash) {
>> +        colon = strchr(last_slash, ':');
>> +        if (colon) {
>> +            *colon = '\0';
>> +        }
>> +    }
> Is path_offset() guaranteed to always receive an absolute path?
> 
> If not, paths without /, such as disk@8000000000000000:0, won't have the 
> suffix stripped. Either document the absolute-path requirement or handle 
> the no-slash case as well.
> 
path_offset() is called from the vof_open() and vof_finddevice() which 
is the implementation of OF client services, and GRUB calls these API's 
with paths constructed from FDT nodes, which are absolute paths.
All these call chains usually work on absolute path, so path_offset() 
should also be receiving absolute path only. Will add a comment here in 
v2 to address this.

> Thanks,
> Narayana Murty N
>> +
>>       for (at = strchr(p, '@'); at && *at; ) {
>>               if (*at == '/') {
>>                   at = strchr(at, '@');
> 
> 

Regards,
Utkarsh


