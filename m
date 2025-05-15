Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 760F8C3ABC9
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 15:53:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFarV-00075R-3h; Thu, 15 May 2025 11:51:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1uFaqw-0006qo-2d; Thu, 15 May 2025 11:50:38 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1uFaqt-00072G-PM; Thu, 15 May 2025 11:50:33 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54FCgDgn004946;
 Thu, 15 May 2025 15:50:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=k9nKrOkxp7ZTlujMhHAne0iJ9Bn80doduWHVec5I3Mo=; b=bT/tzVoWR3Ag
 gws/BWX5qDU9nwn0q8aDoo9f+ZCuYypPDL26AZv9dZ8X3U7m6AjSlPUhRf+xlCP1
 LjsDNJRMb1xqO5Ipf6gjKKfNAEhkMvotYTtLsaT+mdiRdHJk8exzPyrfm0fsBjJZ
 TZ4ymhCu64ArEDfEnnFjrGAqKtec8UPSvHhKoBlBJut7Hr0z8TnljbQs34DRYtik
 Xtx1VVRqQ45M9/5Lm43aEZPZAA2qAol3fOG/NZfX5EbtrrOdn3W+w9urEKRjqfDE
 wvvkVAL/RaZU5T4omKiikjF2TNnQaRnjgbs1OZGGoVopqOxa/F7GoCF0WdU0ix13
 oWpNxMqJMQ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46ndfjt37m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 15:50:29 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54FFS8NR014645;
 Thu, 15 May 2025 15:50:29 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46ndfjt37k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 15:50:29 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54FE042f024309;
 Thu, 15 May 2025 15:50:28 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46mbfsb223-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 15:50:28 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 54FFoOoK26608238
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 15 May 2025 15:50:24 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8BBA658055;
 Thu, 15 May 2025 15:50:27 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 002875804B;
 Thu, 15 May 2025 15:50:27 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 15 May 2025 15:50:26 +0000 (GMT)
Message-ID: <176d45210713399adb4a41909eaf93653fd603c0.camel@linux.ibm.com>
Subject: Re: [PATCH 18/50] pnv/xive2: Print value in invalid register write
 logging
From: Miles Glenn <milesg@linux.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, =?ISO-8859-1?Q?Fr=E9d=E9ric?= Barrat
 <fbarrat@linux.ibm.com>, Michael Kowal <kowal@linux.ibm.com>, Caleb
 Schlossin <calebs@linux.vnet.ibm.com>
Date: Thu, 15 May 2025 10:50:26 -0500
In-Reply-To: <20250512031100.439842-19-npiggin@gmail.com>
References: <20250512031100.439842-1-npiggin@gmail.com>
 <20250512031100.439842-19-npiggin@gmail.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: OL7ZfVB-6XGxJ-hdkr9QE_-4aJXjdERC
X-Authority-Analysis: v=2.4 cv=ecg9f6EH c=1 sm=1 tr=0 ts=68260d45 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=xSvcgLTIzuQBs9w0egYA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: DLsaSeiz0NWdeZGAwV2iiA0qn3mVH_Kv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDE1NSBTYWx0ZWRfX2hMqIUEJSgvI
 km3266vjff4R+Q4CzmGeHcPek35J8kvoo2twJws4FLGtDi4K7JtzFo3NRF7/nz7zBG7fWYCLIYi
 n0bLzm+rlBgMKxXWNLEq2RVwlz/AR5WBnGpXut9OIhfFjdwxMLCULKmxn2eEMzO3B/p7tM26NPp
 iIQf9yxkNPOdaLkbJlrNn4l6NQeUcEZopImMYiE+oIfsFB4HXiFrBkMZDGiL++uLsXlm3fw1Nv2
 hZ94Zs8gAZBe/PTioQvBLQQqN3FJH/KWsR8kQbpUhI/glLIjxsFssw6S5JxXmA3STrtj+UaQxHx
 xzORF815kPUAIa4WNn2OtXaNMLbH9z261PK21gWf82WSpokKErneSsJl+eZK1VeAAvfpVbupTlH
 Dtfy2uuhtFbu2BAiywAx+L5h0QA6190HMkhBnqtT6XA1NoLEMJTzJDu0uCOe7e6anWbFLqA8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_06,2025-05-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999
 impostorscore=0 spamscore=0 clxscore=1015 malwarescore=0 mlxscore=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 suspectscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
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
> From: Michael Kowal <kowal@linux.ibm.com>
> 
> This can make it easier to see what the target system is trying to
> do.
> 
> [npiggin: split from larger patch]
> Signed-off-by: Michael Kowal <kowal@linux.ibm.com>
> ---
>  hw/intc/pnv_xive2.c | 24 ++++++++++++++++--------
>  1 file changed, 16 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
> index d7ca97ecbb..fcf5b2e75c 100644
> --- a/hw/intc/pnv_xive2.c
> +++ b/hw/intc/pnv_xive2.c
> @@ -1197,7 +1197,8 @@ static void pnv_xive2_ic_cq_write(void *opaque, hwaddr offset,
>      case CQ_FIRMASK_OR: /* FIR error reporting */
>          break;
>      default:
> -        xive2_error(xive, "CQ: invalid write 0x%"HWADDR_PRIx, offset);
> +        xive2_error(xive, "CQ: invalid write 0x%"HWADDR_PRIx" value 0x%"PRIx64,
> +                    offset, val);
>          return;
>      }
>  
> @@ -1495,7 +1496,8 @@ static void pnv_xive2_ic_vc_write(void *opaque, hwaddr offset,
>          break;
>  
>      default:
> -        xive2_error(xive, "VC: invalid write @%"HWADDR_PRIx, offset);
> +        xive2_error(xive, "VC: invalid write @0x%"HWADDR_PRIx" value 0x%"PRIx64,
> +                    offset, val);
>          return;
>      }
>  
> @@ -1703,7 +1705,8 @@ static void pnv_xive2_ic_pc_write(void *opaque, hwaddr offset,
>          break;
>  
>      default:
> -        xive2_error(xive, "PC: invalid write @%"HWADDR_PRIx, offset);
> +        xive2_error(xive, "PC: invalid write @0x%"HWADDR_PRIx" value 0x%"PRIx64,
> +                    offset, val);
>          return;
>      }
>  
> @@ -1790,7 +1793,8 @@ static void pnv_xive2_ic_tctxt_write(void *opaque, hwaddr offset,
>          xive->tctxt_regs[reg] = val;
>          break;
>      default:
> -        xive2_error(xive, "TCTXT: invalid write @%"HWADDR_PRIx, offset);
> +        xive2_error(xive, "TCTXT: invalid write @0x%"HWADDR_PRIx
> +                    " data 0x%"PRIx64, offset, val);
>          return;
>      }
>  }
> @@ -1861,7 +1865,8 @@ static void pnv_xive2_xscom_write(void *opaque, hwaddr offset,
>          pnv_xive2_ic_tctxt_write(opaque, mmio_offset, val, size);
>          break;
>      default:
> -        xive2_error(xive, "XSCOM: invalid write @%"HWADDR_PRIx, offset);
> +        xive2_error(xive, "XSCOM: invalid write @%"HWADDR_PRIx
> +                    " value 0x%"PRIx64, offset, val);
>      }
>  }
>  
> @@ -1929,7 +1934,8 @@ static void pnv_xive2_ic_notify_write(void *opaque, hwaddr offset,
>          break;
>  
>      default:
> -        xive2_error(xive, "NOTIFY: invalid write @%"HWADDR_PRIx, offset);
> +        xive2_error(xive, "NOTIFY: invalid write @%"HWADDR_PRIx
> +                    " value 0x%"PRIx64, offset, val);
>      }
>  }
>  
> @@ -1971,7 +1977,8 @@ static void pnv_xive2_ic_lsi_write(void *opaque, hwaddr offset,
>  {
>      PnvXive2 *xive = PNV_XIVE2(opaque);
>  
> -    xive2_error(xive, "LSI: invalid write @%"HWADDR_PRIx, offset);
> +    xive2_error(xive, "LSI: invalid write @%"HWADDR_PRIx" value 0x%"PRIx64,
> +                offset, val);
>  }
>  
>  static const MemoryRegionOps pnv_xive2_ic_lsi_ops = {
> @@ -2074,7 +2081,8 @@ static void pnv_xive2_ic_sync_write(void *opaque, hwaddr offset,
>          inject_type = PNV_XIVE2_QUEUE_NXC_ST_RMT_CI;
>          break;
>      default:
> -        xive2_error(xive, "SYNC: invalid write @%"HWADDR_PRIx, offset);
> +        xive2_error(xive, "SYNC: invalid write @%"HWADDR_PRIx" value 0x%"PRIx64,
> +                    offset, val);
>          return;
>      }
>  


