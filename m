Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C86ACE9D7B
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Jan 2026 16:50:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdAFw-0006oD-Di; Tue, 06 Jan 2026 11:50:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1vdAFe-0006mK-SF; Tue, 06 Jan 2026 11:49:47 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1vdAFd-00019E-Ag; Tue, 06 Jan 2026 11:49:46 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 606FbdI7014492;
 Tue, 6 Jan 2026 16:49:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=HAQDruIQG50MDb/0eeir+YYjMQxAaAvVkoAEnzPBK1c=; b=LIk0mzi8CqjD
 C5siak0KZtH37U3T0ZPeOTF1qyV54kEmHnwenkrZx70+tLABMZ4JoHPKP9f1NLLJ
 mqr/oSiZFyNJYQrkzZ+gwXt0ZJyMffO1A1O9TqlDr1bianu5cdoMqUM9gT8ukzA8
 AXkdlQ1Vjg6L2lso9PptG0T1YTuwMvh1YjhzM4pv1hA7qozyom70dTg36zGTw/p8
 cUyr6J8Wm6IdDeOL74jMoTnkLuXZYlRkGGS9oapcD5cCwrp1E41PiEfUkJ9kHR2f
 tyQ47nQlYvsBORW6QRkOElkqqdzNQ2v1Dg3SR4iK4MaOeTT7ZarRa6xaVyeKQMH0
 PYOGEA/eRg==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4beshev467-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 06 Jan 2026 16:49:43 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 606GjELS007034;
 Tue, 6 Jan 2026 16:49:42 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4beshev465-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 06 Jan 2026 16:49:42 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 606FXLnR015202;
 Tue, 6 Jan 2026 16:49:41 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bfdescn6y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 06 Jan 2026 16:49:41 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 606GneZv30868030
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 6 Jan 2026 16:49:40 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1262D58052;
 Tue,  6 Jan 2026 16:49:40 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9FE2758056;
 Tue,  6 Jan 2026 16:49:39 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  6 Jan 2026 16:49:39 +0000 (GMT)
Message-ID: <1fa38659565cf4dc1dfe24cc365d685554faecf0.camel@linux.ibm.com>
Subject: Re: [PATCH 1/4] ppc/pnv: Suppress some "pnv_chiptod unimplemented
 register" messages
From: Miles Glenn <milesg@linux.ibm.com>
To: Caleb Schlossin <calebs@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, npiggin@gmail.com, adityag@linux.ibm.com,
 chalapathi.v@linux.ibm.com
Date: Tue, 06 Jan 2026 10:49:39 -0600
In-Reply-To: <20251218200353.301866-2-calebs@linux.ibm.com>
References: <20251218200353.301866-1-calebs@linux.ibm.com>
 <20251218200353.301866-2-calebs@linux.ibm.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA2MDE0NiBTYWx0ZWRfX1U8Xt9YlxDcV
 TnGoJV5+L9+QN3oa9qZ3UCxn6C0dioIWAFmi1MSAmQ4QYG/sItp8BMDC6CoLnBqSFAHQZGmlL4x
 kIf1MDkB0l/dwPCIj9aGua1O5L5W3QCOhJCbwBthgtrFuLXkLglnPw9adj0VNIxkuFvLsaEf4Bd
 urfvdv0JOUQ9m9GBUmGuOYdYcFff+xi9JfJ0DDAEwakaNPydxVgryhGYOt+YajKx0OR2frDrHJn
 Dy6ClBC3eVS67vTFuxIGZw51yGBx8U8HUyD0e2rs2aOX+jBCb+QkcOeRCrSvnavGDfdmV2Aw1wg
 U8NojC6B7cONMdqDyr82Uqlpbrzi5WXEzZr2TdHr+IlhlGWLAkpBDBjEALxVQdcX7QHyZXBYPxr
 Roa4Mz2VqGLIVdOxagWp0j+xNsmEuO4Glt1xBPfgw/8HWOB14M3QZndvf6qLjyvyfM5J/HzmCHC
 1fTIy4eriDIKdeNYxEQ==
X-Proofpoint-GUID: BIYX7HO8aVmZFzdw1C1D2V-HVg018kGW
X-Proofpoint-ORIG-GUID: zh_vrevsFoncoyAvbnQIf80yJwldy7Tc
X-Authority-Analysis: v=2.4 cv=AOkvhdoa c=1 sm=1 tr=0 ts=695d3d27 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=uM3lmRkaaUgqgqTTx18A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-06_01,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0 impostorscore=0
 clxscore=1015 suspectscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2601060146
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

Hi Caleb.  I wonder if it makes sense to upstream this commit since I
suspect that most upstream users will not have the "unimp" log messages
enabled unless they are debugging a problem and in that case, we would
be erroneously masking these unimplemented registers from the logged
output.

Thanks,

Glenn

On Thu, 2025-12-18 at 14:03 -0600, Caleb Schlossin wrote:
> This commit suppresses the following informational messages
> regarding unimplemented pnv_chiptod registers:
> 
> pnv_chiptod: unimplemented register: Ox0
> pnv_chiptod: unimplemented register: Ox1
> pnv_chiptod: unimplemented register: Ox2
> pnv_chiptod: unimplemented register: Ox3
> pnv_chiptod: unimplemented register: Ox4
> pnv_chiptod: unimplemented register: Ox5
> pnv_chiptod: unimplemented register: Ox13
> 
> Signed-off-by: Glenn Miles <milesg@linux.ibm.com>
> Signed-off-by: Caleb Schlossin <calebs@linux.ibm.com>
> ---
>  hw/ppc/pnv_chiptod.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/hw/ppc/pnv_chiptod.c b/hw/ppc/pnv_chiptod.c
> index f887a18cde..cd9b8ee348 100644
> --- a/hw/ppc/pnv_chiptod.c
> +++ b/hw/ppc/pnv_chiptod.c
> @@ -145,6 +145,15 @@ static uint64_t pnv_chiptod_xscom_read(void *opaque, hwaddr addr,
>              val |= PPC_BIT(4);
>          }
>          break;
> +    case TOD_M_PATH_CTRL_REG:
> +    case TOD_PRI_PORT_0_CTRL_REG:
> +    case TOD_PRI_PORT_1_CTRL_REG:
> +    case TOD_SEC_PORT_0_CTRL_REG:
> +    case TOD_SEC_PORT_1_CTRL_REG:
> +    case TOD_S_PATH_CTRL_REG:
> +    case TOD_TX_TTYPE_2_REG:
> +        /* unimplemented, but suppressing logging for now */
> +        break;
>      default:
>          qemu_log_mask(LOG_UNIMP, "pnv_chiptod: unimplemented register: Ox%"
>                        HWADDR_PRIx "\n", addr >> 3);
> @@ -420,6 +429,15 @@ static void pnv_chiptod_xscom_write(void *opaque, hwaddr addr,
>      case TOD_TX_TTYPE_5_REG:
>          pctc->broadcast_ttype(chiptod, offset);
>          break;
> +    case TOD_M_PATH_CTRL_REG:
> +    case TOD_PRI_PORT_0_CTRL_REG:
> +    case TOD_PRI_PORT_1_CTRL_REG:
> +    case TOD_SEC_PORT_0_CTRL_REG:
> +    case TOD_SEC_PORT_1_CTRL_REG:
> +    case TOD_S_PATH_CTRL_REG:
> +    case TOD_TX_TTYPE_2_REG:
> +        /* unimplemented, but suppressing logging for now */
> +        break;
>      default:
>          qemu_log_mask(LOG_UNIMP, "pnv_chiptod: unimplemented register: Ox%"
>                        HWADDR_PRIx "\n", addr >> 3);


