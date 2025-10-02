Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7675CAC5B0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 07:57:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4E9W-0006d0-Fe; Thu, 02 Oct 2025 03:55:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1v4E9Q-0006by-QK; Thu, 02 Oct 2025 03:54:56 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1v4E96-0004lu-BJ; Thu, 02 Oct 2025 03:54:53 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5922bGXd024892;
 Thu, 2 Oct 2025 07:54:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=0qJh+1
 TSiELVMolweI219tJAYnBK3QIXqO0r3zg6Khs=; b=dx0lTQQVu+dXfWKysVf5iT
 20zFq18EgQ54AWNxTXEVA1xEd1zPgV9JPTjUW0HvczxusCYTD3MSoWJRz52GNPHU
 fOfZ5JpwusCHJMLfeF0QgNJi3e7hEIqX7HNAyFalDVdpOJrrDcCzI9l/UPuX5Bh0
 48O1qQLXHtJWqIh67l9CTUITLGBTH7KuEE3ydZEbDEwBI7NdpVtYCB5Nk7N2xLTH
 Jyynz+43RH+h4PcaJX33C5h9+PNOAfbWC8QvY9yONe3oT4pBygU6jYIOLr7ouN5g
 4A3SXxVLjKZ/T1Hf4+1ndYXFwctbkiMFVWa5yL4N7j5MDIbVYlKGX/A4r0vazsnA
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49e7e7m8y6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Oct 2025 07:54:06 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5923wqdC007321;
 Thu, 2 Oct 2025 07:54:05 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49eurk4xnr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Oct 2025 07:54:05 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5927s1p159703586
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 2 Oct 2025 07:54:01 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 65BEB2004D;
 Thu,  2 Oct 2025 07:54:01 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2DB5720040;
 Thu,  2 Oct 2025 07:54:01 +0000 (GMT)
Received: from [9.155.199.94] (unknown [9.155.199.94])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  2 Oct 2025 07:54:01 +0000 (GMT)
Message-ID: <ae47a0c8-1b39-481e-a25b-5d94b689d7d7@linux.ibm.com>
Date: Thu, 2 Oct 2025 09:54:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] s390x/pci: fix interrupt blocking by returning only
 the device's summary bit
To: Jaehoon Kim <jhkim@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: mjrosato@linux.ibm.com, farman@linux.ibm.com, pasic@linux.ibm.com,
 thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 iii@linux.ibm.com
References: <20251001154004.71917-1-jhkim@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20251001154004.71917-1-jhkim@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: XCZpKqRB8ZCaCBmUKGv70iZOWCwhferi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAyMCBTYWx0ZWRfX1uXAKZOpTY+D
 06YuVxNWPDtHxO/SMcx3vHOSRpQvFM9fIKBn/FWIbmzWs9FDYYyGESZQ8t7RSubTIvexH+HiipP
 MATzZBfymTRf4EJIxnlA5sU/N/c143qbszmSJ0lQSn88hdwArUAod7Vzb4ujqHiNzFQqCrxiQIQ
 KyH/2s3SRDCC87NN9JZkKGjcwXwmj33GLKUYLSMIv6f8KYhM/0Aa9JPPwl7h8Xax9XtuKq91ZSM
 bJFIWs7/sMkxmpL+29a5mjKYYHct1Ro5LTAh04CeBwehvKdKAXviPqlB6Ls5t9JpkmNq+R/RCDa
 GtXc7VnLQ8x+biqUcBF5yPF4iuORimulM5G/uGnltVRV0FFMsX3rFHG/0fy/8UMOTr5DXAyXjql
 FOO5Z3FYTSH6ejj/luJ7k/mXKWHkWQ==
X-Proofpoint-GUID: XCZpKqRB8ZCaCBmUKGv70iZOWCwhferi
X-Authority-Analysis: v=2.4 cv=Jvj8bc4C c=1 sm=1 tr=0 ts=68de2f9e cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VnNF1IyMAAAA:8 a=-O3EFT1qt8p55MFw648A:9
 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-02_03,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 suspectscore=0 phishscore=0 bulkscore=0 clxscore=1011 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509270020
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=borntraeger@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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


Am 01.10.25 um 17:39 schrieb Jaehoon Kim:
> Previously, set_ind_atomic() returned the entire byte containing
> multiple summary bits. This meant that if any other summary bit in the
> byte was set, interrupt injection could be incorrectly blocked, even
> when the current device's summary bit was not set. As a result, the
> guest could remain blocked after I/O completion during FIO tests.
> 
> This patch replaces set_ind_atomic() with set_ind_bit_atomic(), which
> returns true if the bit was set by this function, and false if it was
> already set or mapping failed. Interrupts are now blocked only when
> the device's own summary bit was not previously set, avoiding
> unintended blocking when multiple PCI summary bits exist within the
> same byte.
> 
> Signed-off-by: Jaehoon Kim <jhkim@linux.ibm.com>
[...]
> -static uint8_t set_ind_atomic(uint64_t ind_loc, uint8_t to_be_set)
[...]

Not changing the name would have made the patch smaller, but it is probably a better name name.

Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>

