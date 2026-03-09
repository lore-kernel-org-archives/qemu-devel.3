Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D134EF3C260
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 13:30:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzagR-0005E0-Bp; Mon, 09 Mar 2026 09:30:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1vzagJ-0005Ck-7i; Mon, 09 Mar 2026 09:30:00 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1vzagH-0002uC-7x; Mon, 09 Mar 2026 09:29:59 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 628KQSfV1636098; Mon, 9 Mar 2026 13:29:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=5512S3
 xaUdgEK0/0HwWB6QPCwkLdmMAg/wHWpmO4/Xg=; b=AfzZVfj6i5J5qDywvFwrEE
 z5Kb8f3IE9AS1T6Mqc6OYTj3fitONSrZYXLfBChzOnqaF8DQUnIc2/sics7T+FDr
 DsAlpPzGs2JdrKFRPDks3dPRUli4xmY4w6pt3RrH68knzhvWh190C/t98B8B+fsv
 8s8FlZTHMf/P8F/Yfnb1N+i3yYZRdf74sbVau3mCtfImkC2YlUFpMpl3XmEYi6jP
 31Hbny6EZGOttdFlesrodzHShdloUSj7bjBVJlySPGt5RzPOyvTg7dGRtpN3H1xF
 /CiHzV91wd4CJZusQBQz/9a0VmczUkoXPt3SyIJ8EBwhiE5GSsBTeemQwsyeo43A
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crcvm6qj2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Mar 2026 13:29:54 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 629AKH0J025064;
 Mon, 9 Mar 2026 13:29:53 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cs0jjvwv3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Mar 2026 13:29:53 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 629DTpOw53412138
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 9 Mar 2026 13:29:51 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4CBFA5805A;
 Mon,  9 Mar 2026 13:29:51 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9F46258056;
 Mon,  9 Mar 2026 13:29:50 +0000 (GMT)
Received: from [9.61.138.24] (unknown [9.61.138.24])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  9 Mar 2026 13:29:50 +0000 (GMT)
Message-ID: <68ba3b99-9b0c-43c3-8a8f-ca32135747f4@linux.ibm.com>
Date: Mon, 9 Mar 2026 09:29:50 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 10/15] pc-bios/s390-ccw: Introduce PCI device
To: jrossi@linux.ibm.com, qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 thuth@redhat.com, mst@redhat.com
Cc: jjherne@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
 zycai@linux.ibm.com
References: <20260309003601.242634-1-jrossi@linux.ibm.com>
 <20260309003601.242634-11-jrossi@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260309003601.242634-11-jrossi@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: _wGOcgSCzQYBb5Se6lfsMYLU2RxnTpH7
X-Proofpoint-ORIG-GUID: _wGOcgSCzQYBb5Se6lfsMYLU2RxnTpH7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDExOSBTYWx0ZWRfX3YVDnJlQU0Ur
 2eQJU3u2JmsylDT7gDyD4L1oHczOupC0QUW8nqEoVni3CRu0sKuy16WTSTZ0W/cVWBnjHCVbqKq
 8Gy2h793WBkYTsxI6S/QCuH5s6Gt+gHNGgsi+2006L6VCfwwbXZL+Y0xA0+30ummGU8di9PsQCc
 AkLTyxXfZR0deusz2MTkBUpG3dYSWv+R3h7crd/KmE8DOYrsIjxWGvpeXTLDTWLxS3AqkfEo6kO
 GRbPjGHvdGhRh0A75nZYpupa7VQmBnL3Daz4H5VCdzkf/5FQ/FI0vwEJ3bUrHwhJ6zCkLKCKime
 SzRk0/EbZbAbo2QGMqHQNX/XGhHt58/SLnXT7Esf8paRQOEsw4UBE4fmtlTTLJL9Y6CHQXVlivF
 flvfv7Ded2pXSmLaYk/Kxw5QDciSneVkK6ZDdHaVCTn+mEXGgMfrUdNQH17JQTzaBxzOB9FgdyA
 xI1loO1pA6pb6sDGjCg==
X-Authority-Analysis: v=2.4 cv=B5q0EetM c=1 sm=1 tr=0 ts=69aecb52 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=TVlGNPTruMzivAiionsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_03,2026-03-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603090119
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 3/8/26 8:35 PM, jrossi@linux.ibm.com wrote:
> From: Jared Rossi <jrossi@linux.ibm.com>
> 
> Define selected s390x PCI instructions.
> 
> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>



