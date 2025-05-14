Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72E01C3ABDE
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 15:13:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFDl4-0004KY-M2; Wed, 14 May 2025 11:10:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1uFDEO-0002XA-7g; Wed, 14 May 2025 10:37:13 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1uFDEM-0007Sk-Im; Wed, 14 May 2025 10:37:11 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54E6IORM026369;
 Wed, 14 May 2025 14:37:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=8QprLZ
 PhsvjDwhLwtBS9z4rQ5HwGpqMv2eQh0g4uSzA=; b=CODRudmP5Hcg/HoJn44JdT
 etq0e83syj+rzRs28Sj9+aRAY5pkEzhGshXD7ov93reQw0lcAV6zAu8gW7RJoQsQ
 IKHChXITLS9+qpsJSUdSxBtTz8luUVC3ZAyu9U9FrvMNU9h8twwop8dMMtBRui42
 LgkDVEiSez5s564/qXRokA8DmH6KMjfi/mAI1DxCosQav/7T140Dz5/KU80zERj+
 DfG9486r1Noff0CofO1nvUD/rPXKUFh2f7ptyE3BQjYcXo04vMOK7HAtc6LeIBRL
 j+gkFoIjVxSoneMdrmuq+4QnhkVgTMj71wNrp8C19oLBpIG+qOhhZbCRGl+FKSeg
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46mnst2c19-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 14:37:08 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54EEYM5c025168;
 Wed, 14 May 2025 14:37:08 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46mnst2c14-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 14:37:08 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54EDSdMt019466;
 Wed, 14 May 2025 14:37:07 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 46mbfrmpcx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 14:37:07 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 54EEb52g25362892
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 14 May 2025 14:37:05 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2BBEF58056;
 Wed, 14 May 2025 14:37:05 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C61D75805E;
 Wed, 14 May 2025 14:37:04 +0000 (GMT)
Received: from [9.10.255.115] (unknown [9.10.255.115])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 14 May 2025 14:37:04 +0000 (GMT)
Message-ID: <b71663ee-a4b0-442e-a304-c20097a2838e@linux.ibm.com>
Date: Wed, 14 May 2025 09:37:04 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 19/50] pnv/xive2: VC_ENDC_WATCH_SPEC regs should read back
 WATCH_FULL
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?=
 <fbarrat@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Michael Kowal <kowal@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.vnet.ibm.com>
References: <20250512031100.439842-1-npiggin@gmail.com>
 <20250512031100.439842-20-npiggin@gmail.com>
Content-Language: en-US
From: Caleb Schlossin <calebs@linux.ibm.com>
In-Reply-To: <20250512031100.439842-20-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: UB4xNkVJb_NhQDTUZNxqojzhjKRtk3Md
X-Authority-Analysis: v=2.4 cv=V+590fni c=1 sm=1 tr=0 ts=6824aa94 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8
 a=OIwot2dQPgAvwoVT6JIA:9 a=QEXdDO2ut3YA:10
 a=gZLHJPz4sbkA:10
X-Proofpoint-ORIG-GUID: As7kAhjD9ZQlCkxKBB1NjZmnGTu60kIi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE0MDEzMCBTYWx0ZWRfX/arWsACsM2h/
 UfougMkXx7c3qeFvto1RPPf6HyXkYLSMnulFvMPLE2mnWNUsEiGWn250vfrHQNAws3yWY18ySBs
 bd0aklE1Bmz2cz6G0Uemde9B4brODcIKlnvQfSht5eJnZaAChVsuCQBnpiJGkWIpBwFw04/o7ke
 ve/s+MLsSgetA0CpJpKhofGQzyhgXE5BT6tbk9d9Qxp+RhdTvPGByDg3VeftQd62DsYXi4vHT81
 htWqlxxg6FAhojHdYd0h+va9SR5mjUtSc24aawWHUCv6h/T5N8BSZFoTudwRZvhAG34t4ZcxFO/
 Edi893uZV89sllhEJGzACKhLDqDaWZXQgKHONfLoq7GljlMn1J2sheMY1fluTU/7mxdi3m6/XHt
 sAeve2cwpqdKt728ANjAydLcUv9kkRedrdtB5ZyI+x7URFRIOk7fLVmCRVwvTldvhvTHSWsp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-14_04,2025-05-14_03,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 priorityscore=1501
 mlxlogscore=888 lowpriorityscore=0 bulkscore=0 suspectscore=0
 impostorscore=0 malwarescore=0 phishscore=0 adultscore=0 clxscore=1015
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505140130
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
X-Mailman-Approved-At: Wed, 14 May 2025 11:10:35 -0400
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


Reviewed-by: Caleb Schlossin <calebs@linux.ibm.com>

On 5/11/25 10:10 PM, Nicholas Piggin wrote:
> Firmware expects to read back the WATCH_FULL bit from the VC_ENDC_WATCH_SPEC
> register, so don't clear it on read.
> 
> Don't bother clearing the reads-as-zero CONFLICT bit because it's masked
> at write already.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  hw/intc/pnv_xive2.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
> index fcf5b2e75c..3c26cd6b77 100644
> --- a/hw/intc/pnv_xive2.c
> +++ b/hw/intc/pnv_xive2.c
> @@ -1329,7 +1329,6 @@ static uint64_t pnv_xive2_ic_vc_read(void *opaque, hwaddr offset,
>      case VC_ENDC_WATCH2_SPEC:
>      case VC_ENDC_WATCH3_SPEC:
>          watch_engine = (offset - VC_ENDC_WATCH0_SPEC) >> 6;
> -        xive->vc_regs[reg] &= ~(VC_ENDC_WATCH_FULL | VC_ENDC_WATCH_CONFLICT);
>          pnv_xive2_endc_cache_watch_release(xive, watch_engine);
>          val = xive->vc_regs[reg];
>          break;


