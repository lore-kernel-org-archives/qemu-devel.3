Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B21FCC5CFCF
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 16:40:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuYTM-0004ys-1t; Thu, 13 Aug 2026 12:40:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nikhilks@linux.ibm.com>)
 id 1wuYTK-0004yb-HO
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 12:40:02 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nikhilks@linux.ibm.com>)
 id 1wuYTH-0004Yf-5Y
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 12:40:02 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67DFX2AY2641714
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 16:39:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=sclMDQ
 L0KaKiLchKWvf6jI9R4l0THet36G61B0Ip9II=; b=pUBryUHTshwhU9IZ3sOx+Q
 twny9RCnQnGQTUF39eOSoZa9H7ciZzKiiBQXMcVOZ3ECEVd2hoUHeYSC87tXxg4i
 ThgMaYaOh8L4sm8QJn5+zcCc97f4Rs2kMZyLoICCuqO4Q1jQRJNA5evKdL30UD8G
 +/OH4U1vb6BSgNO9VbYaWQO/dFyEjnSRdBIlyqsMdhWqZJMDmYRl37fyQsOJg5Y2
 0ZtVkKcXsTv/u4uJo8XhQV9zy5AuNDQTHJdJLUDwSVc/6UuC0r/QYDug3wUFAYB+
 RP93ZZku5teH+5C7Vjs324wmPcMrgbN/RrkUdBj/Ky0s5+KEZ9wu3vPEMPF6fpUw
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvp37w1f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 16:39:57 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67DGQJkL006618
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 16:39:56 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxhfybka6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 16:39:56 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67DGdtfh52232664
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 16:39:55 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E4E662004B
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 16:39:54 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4DDEB20043
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 16:39:54 +0000 (GMT)
Received: from [9.43.103.247] (unknown [9.43.103.247])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 16:39:54 +0000 (GMT)
Message-ID: <35096a1a-6fab-4a2d-8690-2dbdf4e55e41@linux.ibm.com>
Date: Thu, 13 Aug 2026 22:09:53 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/6] ppc/spapr: Add support for 'ibm, open-errinjct'
 and 'ibm, close-errinjct'
To: qemu-devel@nongnu.org
References: <20260520095446.64206-1-nnmlinux@linux.ibm.com>
 <20260520095446.64206-4-nnmlinux@linux.ibm.com>
Content-Language: en-US
From: Nikhil Kumar Singh <nikhilks@linux.ibm.com>
In-Reply-To: <20260520095446.64206-4-nnmlinux@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=AMtp2X5w c=1 sm=1 tr=0 ts=6a7df35d cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=z27-1JofBHpxt0W0GYAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: ts8WZmCXD9dXjzM2oR7qWX50y8TD7DTT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDExOSBTYWx0ZWRfX6sEOCtqb4dUt
 gvotcUGtaQ58F0w5Wp8awfl8OJw4V64NWKWdcAcpSxRNea5FUGDpOlUlEpvQ4MUo8ymJJS8qWOF
 2dm4S0HDRQueMEW2lj4Dv+37VRO3QA6BZbslFYCKziL6dhXW0YvDAL0difBWKDI8hFgC5Sw0c9I
 ftU5fsJcwGHT9ihSWWe9I1tp8X0kBwx8x9bKEbt9zZr1X7ZmRUBLokC25pvEFj5SERRTsLP4ywh
 T9hyt4hK//4nMSLyJWjvGUPUsP4vbY1NtjopZQ9/HO2qbDlewq5AG/VS2WfRP2sdnn5uVF2Xn+l
 7r/UXymEQRSPRsJwVRwHnx6dB0LJvHtPvM3sk1+BW5jORGEvzb6uMCiBU7nx4/dguD5hDt3xg4e
 8T1fUCzB/ZzS5RSqV0h7X25wxsPC6Y/zBC0fa7y/hZZrxkXUlU089nqhbgdraQL1GH+L6wo3+A6
 KZ3UCwJ4GQPRnFQxQhg==
X-Proofpoint-ORIG-GUID: ts8WZmCXD9dXjzM2oR7qWX50y8TD7DTT
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDExOSBTYWx0ZWRfX6mRMfLGrzebK
 yK9XwX4pWXIyXBJ1DilsgHM9O+K95KqDcYIBDgzjEugprp/FOIiKONgY7dQ7lASZWE7j4+v5vVp
 YHrwylzT4U7l06VvyybkAZFxTzCvDMw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_05,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608130119
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=nikhilks@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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

Hi Narayana,

This patch looks good to me.
Reviewed-by: Nikhil Kumar Singh <nikhilks@linux.ibm.com>

Thanks,
~ Nikhil

