Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28444D0D14B
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 18:06:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdXut-0000aG-9g; Wed, 07 Jan 2026 13:05:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1vdXtc-00006R-DV; Wed, 07 Jan 2026 13:04:40 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1vdXta-00019H-MH; Wed, 07 Jan 2026 13:04:36 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 6078I1bL022403;
 Wed, 7 Jan 2026 18:04:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=97eWPKBR0yzobe0YrSurqBSbPCZc9mlmQEHnr5sWks8=; b=T2vpZAOyUzMS
 y7DA3NbOl6Tx/aRhFcEZE1JYPArCuqMKtS4+WioM+JL1dIlfgnUMcpcMi5/jli3i
 xOVNOs4breo09EdcSq91mxxLTCeAZIZT/QZ6ROhk4ltFDdzwjOTcz0kDens/djYc
 irb2nL7qdjF8wRk6aLF7Kd+IXi/qtRFezp/mkaXkYMOExEnGpzKhpw+/mKB61HGh
 qKJWenRzW+j4MhWhUhdKHnMmvGGM9DO9jmHsesHriHKpaiCWAGyYUXm0Ymq+F1e+
 7eacFUpnr1J9nvt+1o1jonSD05VbnZGP2xx7DIafLL7poRmSiNaSLEBhEd/6dILq
 PUqjhtvzvw==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4betrts8yx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 07 Jan 2026 18:04:31 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 607HwCnX021093;
 Wed, 7 Jan 2026 18:04:31 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4betrts8yw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 07 Jan 2026 18:04:31 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 607HsR82014523;
 Wed, 7 Jan 2026 18:04:30 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bfeen2knx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 07 Jan 2026 18:04:30 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 607I4TgZ5112510
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 7 Jan 2026 18:04:29 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 572325805D;
 Wed,  7 Jan 2026 18:04:29 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EEB9F58043;
 Wed,  7 Jan 2026 18:04:28 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  7 Jan 2026 18:04:28 +0000 (GMT)
Message-ID: <6ef45b8e11cf23582ae44e31cec7438fde9234ea.camel@linux.ibm.com>
Subject: Re: [PATCH 1/4] ppc/pnv: Suppress some "pnv_chiptod unimplemented
 register" messages
From: Miles Glenn <milesg@linux.ibm.com>
To: Caleb Schlossin <calebs@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, npiggin@gmail.com, adityag@linux.ibm.com,
 chalapathi.v@linux.ibm.com
Date: Wed, 07 Jan 2026 12:04:28 -0600
In-Reply-To: <5e13f2c3-2075-4d31-bddc-06dcc31f6eae@linux.ibm.com>
References: <20251218200353.301866-1-calebs@linux.ibm.com>
 <20251218200353.301866-2-calebs@linux.ibm.com>
 <1fa38659565cf4dc1dfe24cc365d685554faecf0.camel@linux.ibm.com>
 <5e13f2c3-2075-4d31-bddc-06dcc31f6eae@linux.ibm.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=aaJsXBot c=1 sm=1 tr=0 ts=695ea02f cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=geCvSiIGcsAKCeZvhHgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: aela2Lw7en7eZtXPsvpaT51PqEZ1Is7C
X-Proofpoint-ORIG-GUID: 9tePUnW4z2HdIg9KfcNE3qukwlVOFl6F
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA3MDE0MCBTYWx0ZWRfX6U+Z87Hw6oCs
 +aXFO9Q02R7GijoqSvHO4iq207HXtzeDezuIVqoqXLdhl3ctcizoJtW06tvy9zAnCvSgu0Yodrg
 UTrwdA71znjBTSVrrXxF4zy82s2AcW95cPlfCrIfGv/s7mu5oXeeetvNRT455p/e100sKlGj8X8
 eAuzBfVberKl9gP8ptvVfuTciH+XWdwIA81A8CX8Z9QDpNl+MQVBOBlPniZ9bRLMuEDE74Tgnyp
 Y8fwFfE7F2sZUO91yDJswbAoP5GSUEAaud1P+2nluvjP8oCGe6enaopSOX/8fcqoThDhMJbHEdX
 l+FR4WrzOvCd0JdVI+mbbugBoF8jxr0boXSC3CF0dh0zUaPG40yPNHaB+B7ldgy5B56iJBM3OIp
 rh3m30uS6e4hswKKV501FkpvX0HPUefpRBHTXQzw1zHqpSv1G+KQP5MKmd0fmq1T/Ina8seXzfQ
 8f/DK/iOHJKifCFwv+g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-07_03,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 clxscore=1015 phishscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2601070140
Received-SPF: pass client-ip=148.163.158.5; envelope-from=milesg@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: milesg@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Ok, I can't say I have a strong opinion on this either way, so...

Reviewed-by: Glenn Miles <milesg@linux.ibm.com>

Thanks,

Glenn

On Tue, 2026-01-06 at 11:07 -0600, Caleb Schlossin wrote:
> 
> On 1/6/26 10:49 AM, Miles Glenn wrote:
> > Hi Caleb.  I wonder if it makes sense to upstream this commit since I
> > suspect that most upstream users will not have the "unimp" log messages
> > enabled unless they are debugging a problem and in that case, we would
> > be erroneously masking these unimplemented registers from the logged
> > output.
> > 
> > Thanks,
> > 
> > Glenn
> 
> I understand your point. Here are my thoughts:
> - Cleaning up these logs for valid accesses (PowerVM bringup and development) reduces the overall log output and helps find real errors
> - In the future, there may be a customer that wants to run PowerVM with upstream QEMU. The more we upstream, the easier that will be.
> - In the future, we are going to have a number of cases like this where we accept accesses and don't log for every unimp access (to clean up log output). If we choose to keep those patches private and don't upstream them it's going to increase the number of private patches we keep, making future rebasing more difficult.
> - I'd prefer to upstream more patches, and focus on keeping only the patches we need to private (for confidentiality or other reasons). To make future rebasing easier.
> 
> Feel free to contact me offline, if you'd like to discuss this further.
> 
> Thanks,
> Caleb
> 
> > On Thu, 2025-12-18 at 14:03 -0600, Caleb Schlossin wrote:
> > > This commit suppresses the following informational messages
> > > regarding unimplemented pnv_chiptod registers:
> > > 
> > > pnv_chiptod: unimplemented register: Ox0
> > > pnv_chiptod: unimplemented register: Ox1
> > > pnv_chiptod: unimplemented register: Ox2
> > > pnv_chiptod: unimplemented register: Ox3
> > > pnv_chiptod: unimplemented register: Ox4
> > > pnv_chiptod: unimplemented register: Ox5
> > > pnv_chiptod: unimplemented register: Ox13
> > > 
> > > Signed-off-by: Glenn Miles <milesg@linux.ibm.com>
> > > Signed-off-by: Caleb Schlossin <calebs@linux.ibm.com>
> > > ---
> > >  hw/ppc/pnv_chiptod.c | 18 ++++++++++++++++++
> > >  1 file changed, 18 insertions(+)
> > > 
> > > diff --git a/hw/ppc/pnv_chiptod.c b/hw/ppc/pnv_chiptod.c
> > > index f887a18cde..cd9b8ee348 100644
> > > --- a/hw/ppc/pnv_chiptod.c
> > > +++ b/hw/ppc/pnv_chiptod.c
> > > @@ -145,6 +145,15 @@ static uint64_t pnv_chiptod_xscom_read(void *opaque, hwaddr addr,
> > >              val |= PPC_BIT(4);
> > >          }
> > >          break;
> > > +    case TOD_M_PATH_CTRL_REG:
> > > +    case TOD_PRI_PORT_0_CTRL_REG:
> > > +    case TOD_PRI_PORT_1_CTRL_REG:
> > > +    case TOD_SEC_PORT_0_CTRL_REG:
> > > +    case TOD_SEC_PORT_1_CTRL_REG:
> > > +    case TOD_S_PATH_CTRL_REG:
> > > +    case TOD_TX_TTYPE_2_REG:
> > > +        /* unimplemented, but suppressing logging for now */
> > > +        break;
> > >      default:
> > >          qemu_log_mask(LOG_UNIMP, "pnv_chiptod: unimplemented register: Ox%"
> > >                        HWADDR_PRIx "\n", addr >> 3);
> > > @@ -420,6 +429,15 @@ static void pnv_chiptod_xscom_write(void *opaque, hwaddr addr,
> > >      case TOD_TX_TTYPE_5_REG:
> > >          pctc->broadcast_ttype(chiptod, offset);
> > >          break;
> > > +    case TOD_M_PATH_CTRL_REG:
> > > +    case TOD_PRI_PORT_0_CTRL_REG:
> > > +    case TOD_PRI_PORT_1_CTRL_REG:
> > > +    case TOD_SEC_PORT_0_CTRL_REG:
> > > +    case TOD_SEC_PORT_1_CTRL_REG:
> > > +    case TOD_S_PATH_CTRL_REG:
> > > +    case TOD_TX_TTYPE_2_REG:
> > > +        /* unimplemented, but suppressing logging for now */
> > > +        break;
> > >      default:
> > >          qemu_log_mask(LOG_UNIMP, "pnv_chiptod: unimplemented register: Ox%"
> > >                        HWADDR_PRIx "\n", addr >> 3);


