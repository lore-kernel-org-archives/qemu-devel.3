Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39AB6D2A521
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2024 14:32:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t153o-0003Cc-33; Wed, 16 Oct 2024 10:31:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1t153l-0003CF-0L
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 10:31:33 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1t153i-0002xi-UF
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 10:31:32 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49GBt8Wn026295
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2024 14:31:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=IVz4iA
 egbtPdmMrOsexJIon1JZfz9ZAPS+d6J1M8gJY=; b=GRdtxBmzk/GFdOuQkjl7rL
 pftgyIyfPPc2c7Ynzl0MB0fxum7QA6eQf6JE7GuyIapbAW4nectfK0HpCDzteuu5
 xQ6IlbT3yF133KIcZXCzbt627O6DS1+1Ey8hpGXOSWVXYDDimz3wNElB+YlkXyTF
 Od3HPK7Xlcc/70E4S0PIrqdgAJdZgqOLbtJHM/59KJV2GmGRnHEgVypZ7accz6UW
 si8LuwFHmqnpX+Th+XPN7xd2BpjBoaoOyV098BkOxNrSToXw3hpLfAe01AUlOLcE
 yf9oUHR+/vV5oQec9+81T19srTDOFtiCN50HsArPKllELdd93EyFu6jkaXnXwaBw
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42ad1j0tgt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2024 14:31:29 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49GEVS1d004717;
 Wed, 16 Oct 2024 14:31:28 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42ad1j0tgq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 16 Oct 2024 14:31:28 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49GCl49m006674;
 Wed, 16 Oct 2024 14:31:28 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4283es242c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 16 Oct 2024 14:31:28 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 49GEVRAt39452992
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 16 Oct 2024 14:31:27 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C1C195803F;
 Wed, 16 Oct 2024 14:31:27 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5605258060;
 Wed, 16 Oct 2024 14:31:27 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 16 Oct 2024 14:31:27 +0000 (GMT)
Message-ID: <2b6333e0-3088-43f7-8120-424477d2d429@linux.ibm.com>
Date: Wed, 16 Oct 2024 10:31:26 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] tpm: Resolve potential blocking-forever issue
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, marcandre.lureau@gmail.com
References: <20241016133450.1071197-1-stefanb@linux.ibm.com>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20241016133450.1071197-1-stefanb@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: MZy8dfKmJ24jTtGO64gs0DF8WkhOKg7J
X-Proofpoint-ORIG-GUID: AjW70ow433OMaOR95N72xzvyMdM_jWVG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0
 priorityscore=1501 mlxscore=0 clxscore=1015 spamscore=0 bulkscore=0
 mlxlogscore=476 phishscore=0 adultscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410160089
Received-SPF: pass client-ip=148.163.158.5; envelope-from=stefanb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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



On 10/16/24 9:34 AM, Stefan Berger wrote:
> In case swtpm was to return a control channel message with an error code it
> would only return 4 bytes. However, some of the commands expect a response
> with more bytes and QEMU would get stuck in qemu_chr_fe_read_all() waiting
> for bytes following the error code. Therefore, read the response in 2
> passes stopping if an error code is received in the first 4 bytes to avoid
> getting stuck. Implement an exception for CMD_GET_STATEBLOB that has always
> been sending the header in case of error.
> 
>     Stefan
> 
> v2:
>    -

Please disregard v2. v3 coming shortly.
> 
> 
> Stefan Berger (2):
>    tpm: Use new ptm_cap_n structure for PTM_GET_CAPABILITY
>    tpm_emulator: Read control channel response in 2 passes
> 
>   backends/tpm/tpm_emulator.c | 45 ++++++++++++++++++++++++++++++-------
>   backends/tpm/tpm_ioctl.h    | 13 ++++++++++-
>   backends/tpm/trace-events   |  2 +-
>   3 files changed, 50 insertions(+), 10 deletions(-)
> 

