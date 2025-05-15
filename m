Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 775CDC2D0CD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 15:47:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFanc-0002ZC-BQ; Thu, 15 May 2025 11:47:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1uFan1-0000Fe-7e; Thu, 15 May 2025 11:46:31 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1uFamy-0006ZN-1Y; Thu, 15 May 2025 11:46:29 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54FCg4pJ002206;
 Thu, 15 May 2025 15:46:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=h5Q9UcGpE7TU9WV0kYHJCiZ8/ppQrA/juFgB/aIWaKY=; b=DyqiWfOozBlX
 g9oIuBBZCM4/gI6CWyfGhgx1uvHBIBHbatkdg9irBJF/3psvk2YZMaamp+QSyE1J
 qmy4IiRP8YzQdki3U8nj38aVtAeDakPfg36RDcBEpMAXHcErWm/rDSaqU4wbiAXb
 Y8JCKWhwRbEqBhUhB68vATEi+PNqnyRx1Rz0+4RW03rCvPXqyANF4sQQqGDyWuEl
 Z6XVhJG/RqgAXk1HPMd+fFOqvBeEK5Nc5zjO1QThfYgys2HJoeGipMhvDi8/OiKE
 bEwGJVVzloVILUZ7hdE/UNfjQH+Z/kR+/c2Uy6CxZpZ0EzTh3eO2bpdYI5xEH+Fv
 uxXUwSLYBQ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46n0v6ne1x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 15:46:25 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54FFgupJ010603;
 Thu, 15 May 2025 15:46:25 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46n0v6ne1v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 15:46:25 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54FDl6be021806;
 Thu, 15 May 2025 15:46:24 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46mbfpu1kn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 15:46:24 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 54FFkNiH30605978
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 15 May 2025 15:46:23 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 33E4A5805C;
 Thu, 15 May 2025 15:46:23 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A58285805D;
 Thu, 15 May 2025 15:46:22 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 15 May 2025 15:46:22 +0000 (GMT)
Message-ID: <e86c93a8a96d52e24563efa97e7d8d42b5576abc.camel@linux.ibm.com>
Subject: Re: [PATCH 13/50] ppc/xive: tctx_notify should clear the precluded
 interrupt
From: Miles Glenn <milesg@linux.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, =?ISO-8859-1?Q?Fr=E9d=E9ric?= Barrat
 <fbarrat@linux.ibm.com>, Michael Kowal <kowal@linux.ibm.com>, Caleb
 Schlossin <calebs@linux.vnet.ibm.com>
Date: Thu, 15 May 2025 10:46:22 -0500
In-Reply-To: <20250512031100.439842-14-npiggin@gmail.com>
References: <20250512031100.439842-1-npiggin@gmail.com>
 <20250512031100.439842-14-npiggin@gmail.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=IqAecK/g c=1 sm=1 tr=0 ts=68260c51 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8
 a=E6w-Va-w5m49zset5ocA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: pnolAIiUMu1712RzboYBNw5z00h5btrj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDE1NSBTYWx0ZWRfXw6+GE6eT8OoJ
 ydUkZ6z1VNCtW+nSbkqb0mrC1JBa9Rk66p/CN6NXagQLfHIxKtHH5A337r/ZZdBfY43ssEr52ES
 TVBUBNad9l2e9noAt76UcqzErqVJAfoTAOg6mZqYUNKGibpN86KPaHWrK32U1IBXaskyl2eH2g7
 OJHAZglQjG5Wcu10TGz4xA2S53hTqydZi7sB4Qz1nGDrvReU/wx4mlLs/oLWYd5sgHOlOgkPgCM
 hH42Hq5JbhEOZK43oyHyuax4oKx1DgFD2FYA2zIOoaH9HoDSF8w+GGEF1xz1P4F9bAKZrMs1OWx
 BQH0Sp5OS3TibL99pRYzmmX4u7b7PNusfS6ixmN8s12RcXnEplO5P0uJ+wQraZIkl08zqPMNvL1
 3AbwhhP1b0fYIih5NJmU/RISjBg/qRjYj2TkWVTRwZe292rgJ98lPV0u8omLRB+1JKWcC1N/
X-Proofpoint-GUID: Hp8FEgOauSRR3nZi8pfd5DgrPZSmiSxf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_06,2025-05-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 malwarescore=0
 adultscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0
 priorityscore=1501 clxscore=1015 spamscore=0 mlxlogscore=797 bulkscore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505150155
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
> If CPPR is lowered to preclude the pending interrupt, NSR should be
> cleared and the qemu_irq should be lowered. This avoids some cases
> of supurious interrupts.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  hw/intc/xive.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index cebe409a1a..6293ea4361 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -110,6 +110,9 @@ void xive_tctx_notify(XiveTCTX *tctx, uint8_t ring, uint8_t group_level)
>                                 regs[TM_IPB], alt_regs[TM_PIPR],
>                                 alt_regs[TM_CPPR], alt_regs[TM_NSR]);
>          qemu_irq_raise(xive_tctx_output(tctx, ring));
> +    } else {
> +        alt_regs[TM_NSR] = 0;
> +        qemu_irq_lower(xive_tctx_output(tctx, ring));
>      }
>  }
>  


