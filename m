Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3466DC3ABD8
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 15:11:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFDkv-0004D7-MY; Wed, 14 May 2025 11:10:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1uFD57-0005xY-Od; Wed, 14 May 2025 10:27:38 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1uFD55-0005tD-MI; Wed, 14 May 2025 10:27:37 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54E8pNDA029463;
 Wed, 14 May 2025 14:27:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=6i01Ao
 HdAB5zzEIH4EzF2pPzG8YaMm/yBwZ37MS1NBQ=; b=VmJgiauipakXIFa3BywGYZ
 hCuJszogEyPUZrp0aoMQeeNFfhZd6hSvtLDAAmGGzvXOCwKN7T+hGBv6dd84S3NU
 emhxG+sFEwUko5vQTDWSMxp1S7RoqqK6a4f65z20/mOvsizG50YpYAWlgwefmyfT
 PgiCsRY+8x3kHhJKfwzyF5Epq5z72TkLWNlVzBbvcLPbiqD5CuOIkXscs8660wKh
 yrljJhqdSDdfx0E4i+j8864JMTVxk1hxnxpyKhE4kixsDdRJ7UJIqy3chmdeHwz3
 O0YrABKTGf2xA0r4p7+TXEpWNQmJO3D9bHFADhhH/smYBc4ORT6l4uGwsjoDWgAg
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46mr1ghn61-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 14:27:33 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54EEJYJe012846;
 Wed, 14 May 2025 14:27:33 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46mr1ghn5w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 14:27:33 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54EDW94d019436;
 Wed, 14 May 2025 14:27:32 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 46mbfrmn3w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 14:27:32 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 54EERV5r32572072
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 14 May 2025 14:27:31 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 766065806A;
 Wed, 14 May 2025 14:27:31 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 200E258069;
 Wed, 14 May 2025 14:27:31 +0000 (GMT)
Received: from [9.10.255.115] (unknown [9.10.255.115])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 14 May 2025 14:27:31 +0000 (GMT)
Message-ID: <add19fcd-da3e-4af2-acbf-010a82911aec@linux.ibm.com>
Date: Wed, 14 May 2025 09:27:30 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/50] ppc/xive2: Fix calculation of END queue sizes
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?=
 <fbarrat@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Michael Kowal <kowal@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.vnet.ibm.com>
References: <20250512031100.439842-1-npiggin@gmail.com>
 <20250512031100.439842-4-npiggin@gmail.com>
Content-Language: en-US
From: Caleb Schlossin <calebs@linux.ibm.com>
In-Reply-To: <20250512031100.439842-4-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: H7llsEZk7VqpJzSvtVTs4AGO23_scLZr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE0MDEyNSBTYWx0ZWRfXwBZhedEK085n
 ggOfKNV4XaohjH9GGz/RnUKOZ/pjou/dgKVd+lp1LmCALLUd0IhImHTLXJCvyGH16HxLIVsmN1q
 WR0WveBmNc7j4IVj1SeSE6biJIPwOLTYjS7waMVCgrJNASGSEOJ776zAFoNCcPyo02GO6dVsU4Y
 vU/XF0Sby9yEx+IDMNOLnFa/dPp2HZfgGmoWrrKwiTNHWmbFwke41UoBcjPonXqTe0k2qhm70Vb
 PINEdnuycHhrA+4kWUnVGU2Mlmxd+BKODo2p+DVFVPIJx4FlJxTKERSks8JsQfj/GPVrdUqORG+
 YN0Eg1OLDw6b5xOiR3188xe5hcAEY+qrUGJbps4L6nlq8h2qjPdPupkcvcr4lHyuxGeBcLN76XA
 3JnDXXdi3lLkXUszhHdtS/Ec9HywPUhVuhyFWMFP0VuqLqP+Bb6iMWvD/NEq4hIfCjvi2MwU
X-Proofpoint-GUID: A11kr9w19GXD8Rmjve6zu2yQLl5fjtJs
X-Authority-Analysis: v=2.4 cv=QOxoRhLL c=1 sm=1 tr=0 ts=6824a855 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=ywi1dbFa605tUpZk3tQA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-14_04,2025-05-14_03,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0
 phishscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0
 clxscore=1011 mlxscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=999
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505140125
Received-SPF: pass client-ip=148.163.156.1; envelope-from=calebs@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 14 May 2025 11:10:33 -0400
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

Looks good.

Reviewed-by: Caleb Schlossin <calebs@linux.ibm.com>

On 5/11/25 10:10 PM, Nicholas Piggin wrote:
> From: Glenn Miles <milesg@linux.ibm.com>
> 
> The queue size of an Event Notification Descriptor (END)
> is determined by the 'cl' and QsZ fields of the END.
> If the cl field is 1, then the queue size (in bytes) will
> be the size of a cache line 128B * 2^QsZ and QsZ is limited
> to 4.  Otherwise, it will be 4096B * 2^QsZ with QsZ limited
> to 12.
> 
> Fixes: f8a233dedf2 ("ppc/xive2: Introduce a XIVE2 core framework")
> Signed-off-by: Glenn Miles <milesg@linux.ibm.com>
> ---
>  hw/intc/xive2.c             | 25 +++++++++++++++++++------
>  include/hw/ppc/xive2_regs.h |  1 +
>  2 files changed, 20 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
> index 7d584dfafa..790152a2a6 100644
> --- a/hw/intc/xive2.c
> +++ b/hw/intc/xive2.c
> @@ -188,12 +188,27 @@ void xive2_eas_pic_print_info(Xive2Eas *eas, uint32_t lisn, GString *buf)
>                             (uint32_t) xive_get_field64(EAS2_END_DATA, eas->w));
>  }
> 
> +#define XIVE2_QSIZE_CHUNK_CL    128
> +#define XIVE2_QSIZE_CHUNK_4k   4096
> +/* Calculate max number of queue entries for an END */
> +static uint32_t xive2_end_get_qentries(Xive2End *end)
> +{
> +    uint32_t w3 = end->w3;
> +    uint32_t qsize = xive_get_field32(END2_W3_QSIZE, w3);
> +    if (xive_get_field32(END2_W3_CL, w3)) {
> +        g_assert(qsize <= 4);
> +        return (XIVE2_QSIZE_CHUNK_CL << qsize) / sizeof(uint32_t);
> +    } else {
> +        g_assert(qsize <= 12);
> +        return (XIVE2_QSIZE_CHUNK_4k << qsize) / sizeof(uint32_t);
> +    }
> +}
> +
>  void xive2_end_queue_pic_print_info(Xive2End *end, uint32_t width, GString *buf)
>  {
>      uint64_t qaddr_base = xive2_end_qaddr(end);
> -    uint32_t qsize = xive_get_field32(END2_W3_QSIZE, end->w3);
>      uint32_t qindex = xive_get_field32(END2_W1_PAGE_OFF, end->w1);
> -    uint32_t qentries = 1 << (qsize + 10);
> +    uint32_t qentries = xive2_end_get_qentries(end);
>      int i;
> 
>      /*
> @@ -223,8 +238,7 @@ void xive2_end_pic_print_info(Xive2End *end, uint32_t end_idx, GString *buf)
>      uint64_t qaddr_base = xive2_end_qaddr(end);
>      uint32_t qindex = xive_get_field32(END2_W1_PAGE_OFF, end->w1);
>      uint32_t qgen = xive_get_field32(END2_W1_GENERATION, end->w1);
> -    uint32_t qsize = xive_get_field32(END2_W3_QSIZE, end->w3);
> -    uint32_t qentries = 1 << (qsize + 10);
> +    uint32_t qentries = xive2_end_get_qentries(end);
> 
>      uint32_t nvx_blk = xive_get_field32(END2_W6_VP_BLOCK, end->w6);
>      uint32_t nvx_idx = xive_get_field32(END2_W6_VP_OFFSET, end->w6);
> @@ -341,13 +355,12 @@ void xive2_nvgc_pic_print_info(Xive2Nvgc *nvgc, uint32_t nvgc_idx, GString *buf)
>  static void xive2_end_enqueue(Xive2End *end, uint32_t data)
>  {
>      uint64_t qaddr_base = xive2_end_qaddr(end);
> -    uint32_t qsize = xive_get_field32(END2_W3_QSIZE, end->w3);
>      uint32_t qindex = xive_get_field32(END2_W1_PAGE_OFF, end->w1);
>      uint32_t qgen = xive_get_field32(END2_W1_GENERATION, end->w1);
> 
>      uint64_t qaddr = qaddr_base + (qindex << 2);
>      uint32_t qdata = cpu_to_be32((qgen << 31) | (data & 0x7fffffff));
> -    uint32_t qentries = 1 << (qsize + 10);
> +    uint32_t qentries = xive2_end_get_qentries(end);
> 
>      if (dma_memory_write(&address_space_memory, qaddr, &qdata, sizeof(qdata),
>                           MEMTXATTRS_UNSPECIFIED)) {
> diff --git a/include/hw/ppc/xive2_regs.h b/include/hw/ppc/xive2_regs.h
> index b11395c563..3c28de8a30 100644
> --- a/include/hw/ppc/xive2_regs.h
> +++ b/include/hw/ppc/xive2_regs.h
> @@ -87,6 +87,7 @@ typedef struct Xive2End {
>  #define END2_W2_EQ_ADDR_HI         PPC_BITMASK32(8, 31)
>          uint32_t       w3;
>  #define END2_W3_EQ_ADDR_LO         PPC_BITMASK32(0, 24)
> +#define END2_W3_CL                 PPC_BIT32(27)
>  #define END2_W3_QSIZE              PPC_BITMASK32(28, 31)
>          uint32_t       w4;
>  #define END2_W4_END_BLOCK          PPC_BITMASK32(4, 7)


