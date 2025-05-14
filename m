Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 124C7C3ABCC
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 15:12:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFDl9-0004NY-He; Wed, 14 May 2025 11:11:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1uFDE0-0002Ed-CO; Wed, 14 May 2025 10:36:48 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@linux.ibm.com>)
 id 1uFDDy-0007Ny-FI; Wed, 14 May 2025 10:36:48 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54E8paMC029990;
 Wed, 14 May 2025 14:36:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=1HWLBA
 rP+vwVGeJ9Y7epIqNkMIJr5bdBBa3B31E0srk=; b=Xaw4ziYBl4+8R5jJoMlMyT
 tyUIlRTouDV9BmDaZTGcE+J9Fn63YxY2d1KPHKb6Ev2cS9BFN7ptd9VfPWtzv0tx
 IBttDhgl62F/2xKWOl9JoEnMfaEQd8rZR3EDA1IBwl15qFHS4/vqBtkLXs7K2EUb
 5w2fDtXDLfvBhOhdreGHOOFsHzk26BoMzF2owJnm40G7hZL0Uuu1oFzN+Nygbzw8
 t39KDxVMQ4Jxyz46J0GbchHs91aA2XPdkfHJcM+DRTc6o41N138dKSY6zGMZBlMR
 JpBPxZSp+aI78UHwKSKNcrXTWFZaU73zlRJJoJzyFWtPwLdYIZMzae/tJ1gjCTUg
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46mr1ghptn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 14:36:44 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54EEIHeH011042;
 Wed, 14 May 2025 14:36:44 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46mr1ghpth-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 14:36:44 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54EDTiDx021822;
 Wed, 14 May 2025 14:36:42 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46mbfpmpp2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 May 2025 14:36:42 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 54EEafCr10486464
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 14 May 2025 14:36:41 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 42B0D5805A;
 Wed, 14 May 2025 14:36:41 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E677E58056;
 Wed, 14 May 2025 14:36:40 +0000 (GMT)
Received: from [9.10.255.115] (unknown [9.10.255.115])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 14 May 2025 14:36:40 +0000 (GMT)
Message-ID: <f546eae7-dc50-4ac2-b13a-993c0f7dc98c@linux.ibm.com>
Date: Wed, 14 May 2025 09:36:40 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/50] pnv/xive2: Print value in invalid register write
 logging
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?=
 <fbarrat@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Michael Kowal <kowal@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.vnet.ibm.com>
References: <20250512031100.439842-1-npiggin@gmail.com>
 <20250512031100.439842-19-npiggin@gmail.com>
Content-Language: en-US
From: Caleb Schlossin <calebs@linux.ibm.com>
In-Reply-To: <20250512031100.439842-19-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: gaMSyJclgP5TouLXDprPlDWu400PuhED
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE0MDEzMCBTYWx0ZWRfX2RJUazQ2ysAW
 rrWpr1B/iK0f7OXF1mHoraDqi8GGH//0Lmq1uHESne601598TUC3ZQMhSeoYdaLRi+I2kosjYY8
 yGjHp/fTGDnJRCQpI3llvj+UJuZU4cIPnNjmI7dqN0s7qooC9IU+lYWmbUGB7Wy5KeonIgM2wIP
 ue079VSK8FH5tsuF1TKhe17ZWtmP9HSxJVLfW3sDtCgfHgstnc9o5kxvJpo/HZtijh649skqq/J
 IN5fNxKq2nyps19EXH9OJCAoBatFwFu0xJ5u3mEzow6Ikx88csq5hqEjjASVjUrWxtPjMqta+P7
 FbhDmYN4HBLGdKwhYcPsOLQdzjgzUiFerQKQymL5o/jwdB7k4dWSe/kSPc2du/Loa/G7sZ5fnj8
 6JXq3NE8Dkh9fLwANWDgBg1ttP4QqX3uJsY7CpIDyJQMezcDxeBd0oGy6iVJd/xSqbo30hhn
X-Proofpoint-GUID: KUkVfUpT5YaX3RA_AsEAe2iOEfF4EmKY
X-Authority-Analysis: v=2.4 cv=QOxoRhLL c=1 sm=1 tr=0 ts=6824aa7c cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=xSvcgLTIzuQBs9w0egYA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-14_04,2025-05-14_03,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0
 phishscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0
 clxscore=1015 mlxscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=999
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505070000
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


