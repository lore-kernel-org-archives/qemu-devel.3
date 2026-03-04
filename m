Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A812EB7EA3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 08:25:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxhXf-0003CM-CM; Wed, 04 Mar 2026 03:25:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ganeshgr@linux.ibm.com>)
 id 1vxhXc-00038y-Hf; Wed, 04 Mar 2026 03:25:12 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ganeshgr@linux.ibm.com>)
 id 1vxhXa-0003It-Uk; Wed, 04 Mar 2026 03:25:12 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 623Ixw9d2161919; Wed, 4 Mar 2026 08:25:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=EdmO/z
 d4Efc6gEZeTJNjKqjq/jq9pH+nKnQHND6o8NI=; b=Q1nYCG0qjh+nyjkdx+35NG
 BURQ4I7ivc9L1qug2smbF5s3NT0Zhge496BqgZWB8P8mNDCr3rHRNJ8K0PECngHN
 7RQH9akmBI0vzt8K5LBk0sBFCbyLSTKnpctVNrxWGTXvqIqt71uLW46mv6AXGK0F
 XLkx/dyWnIDzG3flV+2PKn7rIxXDtlceEFTue0ONXmgarsCqYJX9tiBXtsLKLoNv
 WtvJok/CjIdfbVba7vPgczmCjoh+RrwOmGuBpnbKGEsrDOPyus7/doLBVapgk0bO
 SDr5sdKT7A145KnsQWg1AJlapPqk38/OG04xHivhmwui6Vh/Ed5Tnge49rAZArkQ
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ckskbx3b9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Mar 2026 08:25:07 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 624781OR027725;
 Wed, 4 Mar 2026 08:25:06 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cmcwjdkm6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Mar 2026 08:25:06 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6248P3JP33030558
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 4 Mar 2026 08:25:03 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2B28820043;
 Wed,  4 Mar 2026 08:25:03 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E876F20040;
 Wed,  4 Mar 2026 08:25:01 +0000 (GMT)
Received: from [9.98.111.182] (unknown [9.98.111.182])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  4 Mar 2026 08:25:01 +0000 (GMT)
Message-ID: <f9dcadd2-b4b8-4f9f-a66d-2f438de11b96@linux.ibm.com>
Date: Wed, 4 Mar 2026 13:55:00 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/4] ppc/spapr: Add support for RTAS PCI error injection on
 pseries
To: Narayana Murty N <nnmlinux@linux.ibm.com>, npiggin@gmail.com,
 harshpb@linux.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: mahesh@linux.ibm.com
References: <20251029150618.186803-1-nnmlinux@linux.ibm.com>
Content-Language: en-US
From: Ganesh G R <ganeshgr@linux.ibm.com>
In-Reply-To: <20251029150618.186803-1-nnmlinux@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: jOO7rEo3m-WuUqV9MlMc5EBpjRI_8nT8
X-Authority-Analysis: v=2.4 cv=b66/I9Gx c=1 sm=1 tr=0 ts=69a7ec64 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=i4Ubzu5d0fLcHI9DJ4kA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA0MDA2MyBTYWx0ZWRfXzNPAFVQ9Hn0C
 Em3U8Me37/QINFIojLydWRZc4xJBTp6U/1JK7XBn0E0Q4YI5epZQq7YW8ijRghSOkTkqInhNzXF
 pvBJX++4DZCfS9dk2IQfl4CHhfAwt6kYKV2ACmeSDz4FJV3LUlZTvYiqeHIL7ZAtfpgRW6TUnRa
 EizNeBsA4ZMAfeL/jMSPDtC6sCw+7vl0MO+Q25WkzACircXvs7WT+wmBlQc/ufIiJAJ77CQTNk/
 HqIL8uIK7Z397/igVUsK3WiUfVbB3q/DwHsHrf3iP1VB8Vp9w9wfCooSa8LVXp+OAfW1UIZil2n
 NW/R7Dm3vS0rZ8dKVWRHyvUASA7JY88VKSfWOARQsAjZtu6d7e6iNbHMzkYQKAJF9nV5RVt6moO
 h2WA/grYHaH/kA88EOM/Hps7Pz7cN31yGPeGxHRGTgkTMVfwio8rc5qUePSzDWQ5NuOARpjSrwE
 Ie+C4nfJfHLbdwjLSIg==
X-Proofpoint-GUID: HdUu6MMucLC2R2SjxTOQccdtys3H5ckv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-04_04,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 clxscore=1011 adultscore=0
 bulkscore=0 impostorscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603040063
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=ganeshgr@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141,
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

On 10/29/25 8:36 PM, Narayana Murty N wrote:
> This patch series introduces RTAS-based PCI error injection infrastructure
> for the QEMU pseries (sPAPR) platform. The goal is to enable QEMU to simulate
> enhanced error handling (EEH) behavior for PCI devices using RTAS interfaces,
> aligned with existing firmware (OPAL/RTAS) conventions on IBM Power systems.
> 
> The proposed implementation supports:
> 
>    - Backend error injection via VFIO for passthrough PCI devices
>    - RTAS calls for injecting specific PCI errors (e.g., cache/TLB/bus errors)
>    - Controlled access to error injection via open/close RTAS calls
>    - Device Tree (DT) updates to advertise supported error injection tokens
> 
> This series tested on pseries host with kernel version v6.16.0-rc7
> 
> This series has been split into four self-contained patches for clarity:
> 
> Patch 1 introduces the VFIO error injection backend:
>    - Adds 'spapr_phb_vfio_errinjct()' which injects EEH-like faults
>    - Includes minimal enum definitions ('rtas_err_type', 'EEH_ERR_FUNC_...')
>    - Introduces stub and headers to integrate with the PHB VFIO path
> 
> Patch 2 implements the 'ibm,errinjct' RTAS call handler:
>    - Adds 'rtas_ibm_errinjct()' in spapr_pci.c
>    - Handles parameter parsing, validation, and backend call dispatch
>    - Registers the token in 'spapr_pci_rtas_init()'
> 
> Patch 3 adds support for session control:
>    - Introduces 'ibm,open-errinjct' and 'ibm,close-errinjct' handlers
>    - Tracks exclusive access using 'SpaprMachineState'
>    - Provides useful RTAS return codes for access errors
> 
> Patch 4 updates the device tree:
>    - Adds 'ibm,errinjct-tokens' under each PHB node
>    - Lists supported tokens for guest firmware/userspace to query
>    - Adds fallback blob support for token discovery
> 
> 
> Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
> ---
> Narayana Murty N (4):
>    ppc/spapr: Add VFIO EEH error injection backend
>    ppc/spapr: Add ibm,errinjct RTAS call handler
>    ppc/spapr: Add support for 'ibm,open-errinjct' and
>      'ibm,close-errinjct'
>    ppc/spapr: Advertise RTAS error injection call support via FDT
>      property
> 
>   include/hw/pci-host/spapr.h |   7 ++
>   include/hw/ppc/spapr.h      |  56 ++++++++-
>   hw/ppc/spapr.c              | 106 +++++++++++++++++
>   hw/ppc/spapr_pci.c          | 220 ++++++++++++++++++++++++++++++++++++
>   hw/ppc/spapr_pci_vfio.c     |  53 +++++++++
>   5 files changed, 441 insertions(+), 1 deletion(-)
> 
Thanks for working on this, looks good to me.

