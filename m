Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FB32C2D0CD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 15:32:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFaZF-0001Av-5q; Thu, 15 May 2025 11:32:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1uFaZ0-000123-3Y; Thu, 15 May 2025 11:32:08 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1uFaYx-0004Z6-Q0; Thu, 15 May 2025 11:32:01 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54FCgBeV004803;
 Thu, 15 May 2025 15:31:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=i8sf6xtI36nb8PWSRUheRFFZ0Tck7QNDTdPL92A2CQU=; b=RZX7A2idHRgV
 LRKsY9YkHdJ4aAhtQXv8zPDuIpDMq5VwX5kRAib3Qqwc7enBmnX21A1rXf38KTl7
 bWGHI1KJ7giDcsKoOh0mWeNHd2XQOtBtwKzk6Y42SVawML0WN8Hzaq9PlU30p3V+
 /dxihMx4Vadv+mSx2+hpSeUDmjlsVjOGI2eK0GZNAgnQAO6vB47NxB/KEZzBaAWy
 JjYpa0jkjzVI7DH2Xp44K0hgUr5Kn0Wf1tKxaywjpgrNEkVhaHAla2Aq79OiGguD
 ax7Utxj5LaTA0DIMw0yLyzbQ0N7iAUn2v5dha7o5L9ew+Sv9ZRCv9klO1SSwb38N
 AwNjKr8yOA==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46ndfjsymx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 15:31:57 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54FFKIIU026431;
 Thu, 15 May 2025 15:31:56 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46ndfjsymu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 15:31:56 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54FE58i6021459;
 Thu, 15 May 2025 15:31:56 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46mbfrtxk1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 15:31:56 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 54FFVsQi24117780
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 15 May 2025 15:31:54 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 775F658056;
 Thu, 15 May 2025 15:31:54 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 226C458052;
 Thu, 15 May 2025 15:31:54 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 15 May 2025 15:31:54 +0000 (GMT)
Message-ID: <46d134ff7332cb6b79d2e5ad6b4404d8ec2f4b10.camel@linux.ibm.com>
Subject: Re: [PATCH 02/50] ppc/xive: Report access size in XIVE TM operation
 error logs
From: Miles Glenn <milesg@linux.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, =?ISO-8859-1?Q?Fr=E9d=E9ric?= Barrat
 <fbarrat@linux.ibm.com>, Michael Kowal <kowal@linux.ibm.com>, Caleb
 Schlossin <calebs@linux.vnet.ibm.com>
Date: Thu, 15 May 2025 10:31:53 -0500
In-Reply-To: <20250512031100.439842-3-npiggin@gmail.com>
References: <20250512031100.439842-1-npiggin@gmail.com>
 <20250512031100.439842-3-npiggin@gmail.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: iut2U-IKJsgfsYdAKD3j7j8vVFx8xNdR
X-Authority-Analysis: v=2.4 cv=ecg9f6EH c=1 sm=1 tr=0 ts=682608ed cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8
 a=Zpbkz3vmn3wpaXutFjwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: iqRQfDXRvDiImYaDrhTn-s_E_X6tDBa8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDE1MCBTYWx0ZWRfXwB0PAoTyHyjB
 KuGCAQHQilLx3G9Tg4CjXbcxl0V4p8UYSVkuXM2qBkGRfPIyyCV3HNEZie/eHa8EKnp2U48usVr
 ujNfgzJ2z5q9kZny+CrxrtHkYqce6dzuAF/NjMLRKtioSLqTa5NubevEkANGrevevwbOx82Es75
 mNKtSVQJn+AGyQixC8ECPekmtoMFhBZGJ4q26p8P97nIL+nPAFyLPhk0UHdi1Gcy9UVtrJqy6yC
 G7BLqkUyhns7VgAnHczg0nrkdVOYSv6HZHOYEo+InRvqTT6WaTHlVsEQsvHSp3hSpeXAYmO9KMP
 RyBA8zIEriYQuMO0/iU9/uR5eLKAOSkLOFR9GH5cF9m1LtGAJu1KfwYNMv2deoT0765DU774SRI
 BWiqzYoCACPtaLRdUMs5NvBSpbKdIti8yx6DDPUag0MMmjOSdnJc26ZNAEWOGbQWW8h0D7k8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_06,2025-05-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999
 impostorscore=0 spamscore=0 clxscore=1011 malwarescore=0 mlxscore=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 suspectscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505150150
Received-SPF: pass client-ip=148.163.158.5; envelope-from=milesg@linux.ibm.com;
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
Reply-To: milesg@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Reviewed-by: Glenn Miles <milesg@linux.ibm.com>

On Mon, 2025-05-12 at 13:10 +1000, Nicholas Piggin wrote:
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


