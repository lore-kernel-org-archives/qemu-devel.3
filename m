Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78C4BD59D7F
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 22:24:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFhUn-0000F6-9w; Mon, 25 Nov 2024 17:23:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1tFhUl-0000EX-Il; Mon, 25 Nov 2024 17:23:51 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1tFhUk-0001cU-0i; Mon, 25 Nov 2024 17:23:51 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4APCZFD4021731;
 Mon, 25 Nov 2024 22:23:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=hl0W97
 p6w9FgWuDPAhRVlfOd/xrJ2KPqIH65Bh1c3pM=; b=FgkwZSzkwHkOIFtKkNx+Ta
 b5saTIR4TQ/avYgyAajk+nj/suiJ0Qi3P9IXXT9/9jrO7h1DJQ6dPsVKuajFoxZ/
 88TH6ljcgiJu08kD8s5Q+CuZ879i3O9epd8YVpxyMPURol9x7rC595Rn5KIFMmRn
 nX8oMbjf+QPshoCDjkNKv+bDy7lSquCCjQYEzhHzKp9o7WDx6/IRRsl9nsfCwkp5
 AubHyEP0/8uH+MOC75IlOf+LNuY0CKBUXjqCfo5OBd888H2M8rIz8F8RtXg/wM+P
 IEYuQLdvXJ0FRG857zQm7P8OXRPk/gehvgbbJMSJ0J4o2b5AD1fbDQwxMA5tc/ww
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43386jthr4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 25 Nov 2024 22:23:47 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4APIkeeq023983;
 Mon, 25 Nov 2024 22:23:46 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 433scrub7n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 25 Nov 2024 22:23:46 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4APMNjDd25232032
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 25 Nov 2024 22:23:45 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 823285805A;
 Mon, 25 Nov 2024 22:23:45 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0548A58052;
 Mon, 25 Nov 2024 22:23:45 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 25 Nov 2024 22:23:44 +0000 (GMT)
Message-ID: <02b90518-2996-4231-bee9-43ce313669b0@linux.ibm.com>
Date: Mon, 25 Nov 2024 17:23:44 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 25/26] target/arm/kvm-rme: Add measurement log
To: Jean-Philippe Brucker <jean-philippe@linaro.org>, peter.maydell@linaro.org
Cc: richard.henderson@linaro.org, philmd@linaro.org, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, alex.bennee@linaro.org,
 Stefan Berger <stefanb@linux.vnet.ibm.com>
References: <20241125195626.856992-2-jean-philippe@linaro.org>
 <20241125195626.856992-27-jean-philippe@linaro.org>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20241125195626.856992-27-jean-philippe@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: wP5AzLSAVRPk9PJbLWf9gHULLnygDy-2
X-Proofpoint-GUID: wP5AzLSAVRPk9PJbLWf9gHULLnygDy-2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0
 mlxlogscore=707 spamscore=0 suspectscore=0 phishscore=0 clxscore=1011
 mlxscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411250183
Received-SPF: pass client-ip=148.163.158.5; envelope-from=stefanb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.93, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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



On 11/25/24 2:56 PM, Jean-Philippe Brucker wrote:
> Create an event log, in the format defined by Trusted Computing Group
> for TPM2. It contains information about the VMM, the Realm parameters,
> any data loaded into guest memory before boot and the initial vCPU
> state.
> 
> The guest can access this log from RAM and send it to a verifier, to
> help the verifier independently compute the Realm Initial Measurement,
> and check that the data we load into guest RAM is known-good images.
 > Without this log, the verifier has to guess where everything is 
loaded> and in what order.

Typically these logs are backed by extensions of TPM PCRs and when you 
send a log to a verifier you send a TPM quote along with it for the 
verifer to replay the log and check the TPM quote. Also, early code in 
the firmware is typically serving as a root of trust that starts the 
chain of measurements of code and data, first measuring itself and then 
other parts of the firmware before it jumps into the other parts. Now 
here you seem to just have a log and no PCR extensions and therefore no 
quote over PCRs can be used. Then what prevents anyone from faking this 
log and presenting a completely fake log to the verifier?



