Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FB79CA0FE7
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 05:32:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqmHD-0003Vp-Be; Tue, 26 Aug 2025 01:31:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1uqmH8-0003T3-75; Tue, 26 Aug 2025 01:31:19 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1uqmH0-00052q-Qe; Tue, 26 Aug 2025 01:31:16 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57PJJ9Wb032393;
 Tue, 26 Aug 2025 05:31:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=jneueb
 4z6SxKShCinPAZH4aleemwlEJUUyThJoxli+0=; b=L8VpXnD0AylOeKCygm+46S
 bs+XJ8Gj3dMVXsxQ1jh2925nu+rLNVb82/naaWSp4FW5oyla/ZmusX3Y7p7QueAY
 vE908MA07LVXRlr4/z6Rd2lWcz2Ibu5r/rmh5cdtdkvBDn48PZrsZAFFR4aruU6U
 k2iskmp89+2qKubg5CAyWVb/XiT87qeTLjqucNz/jWoOXQsmyTC/5w4ooydUTg1n
 tdo/CZR1xDx54ddjxvCcX7pjwZbucYaLlf8ShNlY8pigZ5zCyM0Vq4WCXxtGBFCC
 WoPMCFYeyctorfvCvvCG43gtFo66vPrXKTATYdH5VGTRNyNF+9HVX9+GvA1wLKtQ
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48q5avcnr5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 26 Aug 2025 05:31:03 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57Q5V3ir016920;
 Tue, 26 Aug 2025 05:31:03 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48q5avcnr4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 26 Aug 2025 05:31:03 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57Q31vjk029895;
 Tue, 26 Aug 2025 05:31:01 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48qsfmh5qd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 26 Aug 2025 05:31:01 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 57Q5V07529164160
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 26 Aug 2025 05:31:00 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A303F58056;
 Tue, 26 Aug 2025 05:31:00 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 553B95803F;
 Tue, 26 Aug 2025 05:30:58 +0000 (GMT)
Received: from [9.109.242.24] (unknown [9.109.242.24])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 26 Aug 2025 05:30:58 +0000 (GMT)
Message-ID: <b226f689-4a14-418b-9b60-72f4f5b38439@linux.ibm.com>
Date: Tue, 26 Aug 2025 11:00:56 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] target/ppc: Add IBM PPE42 family of processors
To: milesg@linux.ibm.com, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, clg@redhat.com, npiggin@gmail.com, thuth@redhat.com, 
 rathc@linux.ibm.com, richard.henderson@linaro.org
References: <20250819212856.219932-1-milesg@linux.ibm.com>
 <20250819212856.219932-2-milesg@linux.ibm.com>
 <0d2c9aa2-2dcc-4c22-8f33-e5ecac907cf4@linux.ibm.com>
 <b05363c1d72f93950f5872e59c1c4cf6c426b017.camel@linux.ibm.com>
Content-Language: en-US
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <b05363c1d72f93950f5872e59c1c4cf6c426b017.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: a3L7t3Cu0TjENRrMKBRLL3UGOdQRrZty
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAyMSBTYWx0ZWRfXxdLhwrZ2Ovck
 nC6/7mqE3DTLT8n2PTSawkUoCxvwv60KjWJMjQRDg08SPEU79ohAQGyhnhf5IqS++d1hDnCBuoG
 Ydr/y6aGNmuRg1wDIYMBiqlseqIG0Cnh5JuGlWU5+8308J53WdXx/3bno0ejzJ6IKXwX0SpZePR
 6WSfnslbpgGhEkfe3BKeUAL0G4nu8aW1NcqF7mtD5MFZX2am+EhYC9y5Rk0MfB16jBFvA2BmfL2
 heZxdch25vPZoKUIGBd/iEruV8N2J7JI8xo5W5DlSK6NBkvuBXhQ4yFnqHjWuyHFxR6ZfX0IvA4
 1Fh/kLahbpas8BF+o4KXj8AzKfxBbKpokVS6pf3v6f8V8phmAseoTx8g8VBFJTmQ2PwT3hqr+Jo
 hj6q2VlG
X-Proofpoint-ORIG-GUID: TrY-UXa-BuvvrgUTQgH0ZmhEkK7enqZZ
X-Authority-Analysis: v=2.4 cv=SNNCVPvH c=1 sm=1 tr=0 ts=68ad4697 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=f7IdgyKtn90A:10
 a=dIoP19eksFL2bOAxed0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_01,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 bulkscore=0 phishscore=0 clxscore=1015
 impostorscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230021
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
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



On 8/25/25 22:26, Miles Glenn wrote:
>>> @@ -186,6 +186,10 @@ static uint32_t hreg_compute_hflags_value(CPUPPCState *env)
>>>        if (env->spr[SPR_LPCR] & LPCR_HR) {
>>>            hflags |= 1 << HFLAGS_HR;
>>>        }
>>> +    if (ppc_flags & POWERPC_FLAG_PPE42) {
>>> +        /* PPE42 has a single address space and no problem state */
>>> +        msr = 0;
>>> +    }
>> We really dont want this to be checked on PPC64 machines, hence
>> !TARGET_PPC64 needed.
>>
> This is related to the issue of whether we want to continue supporting
> 32-bit CPUs inside the 64-bit executable.  It seems that the community
> is saying that we should continue to do that, so I'd like to keep this
> in even for PPC64 machines, but I will go ahead and add an 'unlikely'
> here in order to possibly lessen the impact.

Yeh, sure, that should suffice for now.

Thanks
Harsh

