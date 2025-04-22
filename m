Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E2ACC369CB
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 04:42:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u75SY-0006EU-IE; Tue, 22 Apr 2025 00:42:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1u75SQ-0006Dm-QT; Tue, 22 Apr 2025 00:42:08 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1u75SP-00033d-C6; Tue, 22 Apr 2025 00:42:06 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53LLgEp8028909;
 Tue, 22 Apr 2025 04:41:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=RENls+
 3slpPKJHYtBfFjw5OTlU/QYIfryMJUWvCM7+Q=; b=HgUaZcSdIWEyvJpK6bceNW
 x0/EoClMB65AvuoE46RnQyuWpBYu0i0NF98w3RrkyynbnAiUb/8df0cRWYH0UW2C
 5+RTtb9iZwWbcatARBnYxKNahDFDNV/4znXXm2EuQZEWIcbI6uYqvWMvo6aaIQT0
 /ouL3BorAhf/29zGh3ad1fsDnD/9Kc5LB0wJdmIeR0L3XpGg87qjNbugwCap/dRs
 qV76Vjx+JIeQ/40FG3DWRcP86JwHPh7MH542YD1FUVhRR2D2uFtapK5McwQ9NGh5
 3JHVLKj+/EsKy821+YMqci3JljPXNrhdUgTHV0CU8pItz9zBp6N2jVPFlxjEqjJg
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 465x5vs6b3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 22 Apr 2025 04:41:54 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 53M4fspe008252;
 Tue, 22 Apr 2025 04:41:54 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 465x5vs6b1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 22 Apr 2025 04:41:54 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53M1Qhwg002939;
 Tue, 22 Apr 2025 04:41:53 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 464q5nh9pk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 22 Apr 2025 04:41:53 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 53M4fnBt60358942
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 22 Apr 2025 04:41:50 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D822A20043;
 Tue, 22 Apr 2025 04:41:49 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EE2F320040;
 Tue, 22 Apr 2025 04:41:45 +0000 (GMT)
Received: from [9.124.215.117] (unknown [9.124.215.117])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 22 Apr 2025 04:41:45 +0000 (GMT)
Message-ID: <dc2e8b4b-8543-42b0-ae33-2558f7ec5737@linux.ibm.com>
Date: Tue, 22 Apr 2025 10:11:44 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/2] Deprecate Power8E and Power8NVL
From: Aditya Gupta <adityag@linux.ibm.com>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
References: <20250422043843.26115-1-adityag@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20250422043843.26115-1-adityag@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: axNYlquqIaxMNATgzxl_stFFBPoq0MjG
X-Proofpoint-ORIG-GUID: knvHr-X9d8JxH62DoTIshYD2TOwBWnJ7
X-Authority-Analysis: v=2.4 cv=CuO/cm4D c=1 sm=1 tr=0 ts=68071e12 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=YSZVx4PgvsBB8yYpSS8A:9
 a=QEXdDO2ut3YA:10 a=QYH75iMubAgA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-22_02,2025-04-21_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 bulkscore=0
 adultscore=0 impostorscore=0 malwarescore=0 phishscore=0 mlxlogscore=467
 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504220033
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
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

Please ignore this mail (only cover letter got sent). Resent another v5.

Sorry for posting this so late, had gone on a vacation.


Thanks,

- Aditya G



