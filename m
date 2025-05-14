Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91945C3ABD8
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 15:14:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFDl4-0004Jw-3D; Wed, 14 May 2025 11:10:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1uFD4i-0005o1-QE; Wed, 14 May 2025 10:27:12 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1uFD4h-0005rE-0K; Wed, 14 May 2025 10:27:12 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54E9Eu62012689;
 Wed, 14 May 2025 14:27:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=0cYcDn
 0+AFV9niEQtHUpri2swwTTx4sb6oXXHKaNoSI=; b=P9KcvS6v9i5kG3rS7FjUCX
 xFfQMgsP1MgP2a16iB4d9aLxjH6B1ah9YgTTOktlAy+v5wj3EtcThGjS6ztE2jEG
 8rSjkC4ACr7meklx6LUHBg1kmCxOK1jBPCHQ9mAf6M8GLwiI5zs3EGmm2nwcBEwQ
 zfGgQnHYWX4Y10j9j2OaoK4PzY7XgCO9703wyG6VxbH4RQ9ZzlKTKjacrKuKOWK8
 sc/cr9ZiYggTzbVnM8JMkFhZ3M5xcJnW9KD644tQhIfNO2oZPL/sVK2ySeLkNdD9
 f3fr9wFa3LmVYYhs6IW773fFVM7oaFiwXow4B3o1Hy+DbBr2VH+KQS54aZ+ErI7w
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46mrcj9h10-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 14:27:09 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54EEMQW5014666;
 Wed, 14 May 2025 14:27:08 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46mrcj9h0x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 14:27:08 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54EDPJkf024309;
 Wed, 14 May 2025 14:27:08 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46mbfs4mx4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 14:27:08 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 54EER7UB20316728
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 14 May 2025 14:27:07 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E7ED25805A;
 Wed, 14 May 2025 14:27:06 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8BB9058052;
 Wed, 14 May 2025 14:27:06 +0000 (GMT)
Received: from [9.10.255.115] (unknown [9.10.255.115])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 14 May 2025 14:27:06 +0000 (GMT)
Message-ID: <63f48f0b-0e82-4a5a-ba09-5643f0365b8e@linux.ibm.com>
Date: Wed, 14 May 2025 09:27:06 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/50] ppc/xive: Report access size in XIVE TM operation
 error logs
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?=
 <fbarrat@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Michael Kowal <kowal@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.vnet.ibm.com>
References: <20250512031100.439842-1-npiggin@gmail.com>
 <20250512031100.439842-3-npiggin@gmail.com>
Content-Language: en-US
From: Caleb Schlossin <calebs@linux.ibm.com>
In-Reply-To: <20250512031100.439842-3-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=ZYgdNtVA c=1 sm=1 tr=0 ts=6824a83d cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8
 a=Zpbkz3vmn3wpaXutFjwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: BfzD4GVxnxEu_DsHmq2a-kVX1_qDkTBC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE0MDEyNSBTYWx0ZWRfX9pfogkZ1abMs
 Kkw28aHtOaIpf1n/8+rqUuD5pVs3pBKVggj1W5rKBXVjVYe+U45dBXYOSClEee2uqvGmA4CJlmN
 WJnXYTQp18TzEirl0vZVsqLgFSYTHSzYIlc4MP1DDguljuT7KjBdV6Y05W6YeqO0cjutI1dG8ml
 mW9BnzBEFZy1pFHOYoqM4eOhJOvRkdfJp9qszdZbm65QAoxoj/IT6TyjhRuE7Qpqo1SalNDJDgr
 9G9ofzGjcOu9BLyDFsGYDQJGCQTaDixMxoOsTTSPkdHTx/aiw8N6xtZ7Vki2mrPorpOpP4hp4yd
 c8CFO1K4NcptOMM4LlB0bFrCZluQy9FOIerOBkMtiKsgZ4pBThHk29I0KltdMLSJ5aXwNBRBqP+
 /bpZwtO5qVaVPkQie5WSa21zGj3A3NOfCcG9Of3Ws1T9ZIlPb3bIOIIEKOLX4l8/kVr+5xob
X-Proofpoint-GUID: i8e55pRliv7hiAnLizFtvWnW_8IAdoxS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-14_04,2025-05-14_03,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0
 clxscore=1011 lowpriorityscore=0 priorityscore=1501 mlxscore=0 spamscore=0
 suspectscore=0 bulkscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505140125
Received-SPF: pass client-ip=148.163.158.5; envelope-from=calebs@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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
> Report access size in XIVE TM operation error logs.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  hw/intc/xive.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index 3eb28c2265..80b07a0afe 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -326,7 +326,7 @@ static void xive_tm_raw_write(XiveTCTX *tctx, hwaddr offset, uint64_t value,
>       */
>      if (size < 4 || !mask || ring_offset == TM_QW0_USER) {
>          qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid write access at TIMA @%"
> -                      HWADDR_PRIx"\n", offset);
> +                      HWADDR_PRIx" size %d\n", offset, size);
>          return;
>      }
> 
> @@ -357,7 +357,7 @@ static uint64_t xive_tm_raw_read(XiveTCTX *tctx, hwaddr offset, unsigned size)
>       */
>      if (size < 4 || !mask || ring_offset == TM_QW0_USER) {
>          qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid read access at TIMA @%"
> -                      HWADDR_PRIx"\n", offset);
> +                      HWADDR_PRIx" size %d\n", offset, size);
>          return -1;
>      }
> 
> @@ -688,7 +688,7 @@ void xive_tctx_tm_write(XivePresenter *xptr, XiveTCTX *tctx, hwaddr offset,
>          xto = xive_tm_find_op(tctx->xptr, offset, size, true);
>          if (!xto) {
>              qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid write access at TIMA "
> -                          "@%"HWADDR_PRIx"\n", offset);
> +                          "@%"HWADDR_PRIx" size %d\n", offset, size);
>          } else {
>              xto->write_handler(xptr, tctx, offset, value, size);
>          }
> @@ -727,7 +727,7 @@ uint64_t xive_tctx_tm_read(XivePresenter *xptr, XiveTCTX *tctx, hwaddr offset,
>          xto = xive_tm_find_op(tctx->xptr, offset, size, false);
>          if (!xto) {
>              qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid read access to TIMA"
> -                          "@%"HWADDR_PRIx"\n", offset);
> +                          "@%"HWADDR_PRIx" size %d\n", offset, size);
>              return -1;
>          }
>          ret = xto->read_handler(xptr, tctx, offset, size);


