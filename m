Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33203CD37BE
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 13:09:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMQ9M-00036I-PO; Mon, 11 May 2026 08:54:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jishnuvw@linux.ibm.com>)
 id 1wMNHZ-0000Bn-2Q; Mon, 11 May 2026 05:50:48 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jishnuvw@linux.ibm.com>)
 id 1wMNHX-0004Dh-9L; Mon, 11 May 2026 05:50:36 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64AFKaLM151140; Mon, 11 May 2026 07:24:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=pPzJ3z
 Xceq9elkTxjaBguiiyGS2BZSIuP/m9G8whSW0=; b=DRtN/2mAyexpl7dJJ5VJXm
 HxUcc1vnwVxnq1qLuySxi17vFxnKboRF2U1QNG0JfjDR1jhs8DGiLouvgWEk88Jz
 QDuwJlbPF7KAMEYjGxlWcIwx8lrkU/3IghPk+Brg5KPjPDpMaowhBtJzshfGdigD
 gaylFo8b/s6Vy4Pyhb+yb4+/Xg+tbTo71CjLbhTgT7POTta/ut4/YSXQcTtD5nFM
 mhr7hC/1u9r2jwoGROgy2AkyP5nZ6cQPRoHBbsHyLrzpIfumnsWtvxSG2P2CZiE0
 3VWMYaHwIJtYKDR/KtE5BvcYa8PoOJIVjYfB+dngOnYHXo3Jm99kQVmau5lX6u4w
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e1ubdpq26-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 11 May 2026 07:24:34 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64B7ONaD026101;
 Mon, 11 May 2026 07:24:34 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e2hxy3y0j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 11 May 2026 07:24:33 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 64B7OU0952166970
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 11 May 2026 07:24:30 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 47A0320043;
 Mon, 11 May 2026 07:24:30 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7423120040;
 Mon, 11 May 2026 07:24:26 +0000 (GMT)
Received: from li-0bf05b4c-28e4-11b2-a85c-ce7af937d338.ibm.com (unknown
 [9.123.4.46]) by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Mon, 11 May 2026 07:24:26 +0000 (GMT)
Date: Mon, 11 May 2026 12:54:19 +0530
From: Jishnu Warrier <jishnuvw@linux.ibm.com>
To: Saif Abrar <saif.abrar@linux.vnet.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, clg@kaod.org,
 npiggin@gmail.com, fbarrat@linux.ibm.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com, cohuck@redhat.com, pbonzini@redhat.com,
 thuth@redhat.com, lvivier@redhat.com, danielhb413@gmail.com,
 harshpb@linux.ibm.com, adityag@linux.ibm.com
Subject: Re: [PATCH v4 8/9] pnv/phb4: Implement IODA PCT table
Message-ID: <wphhqba6a5d73fcvxsfk47gonvxobpn2ba6v4zj7xshhlp3msi@zvm2luq7gv2g>
References: <20260210134110.1515322-1-saif.abrar@linux.vnet.ibm.com>
 <20260305060923.3753402-1-saif.abrar@linux.vnet.ibm.com>
 <20260305060923.3753402-9-saif.abrar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260305060923.3753402-9-saif.abrar@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=BezoFLt2 c=1 sm=1 tr=0 ts=6a018433 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=8nJEP1OIZ-IA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=aow-egSQAAAA:8 a=ZHIH-Mn1CJ9f4S4TJ0wA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
 a=gFNbaldVC-z-bsjSTzMo:22
X-Proofpoint-GUID: cuH4mY3urI88Bx5R0HWQU6--h7hTIrWE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDA3NyBTYWx0ZWRfX2Fal/iEnLf8J
 2sadZvIztIoOQuO7s63ZiUcGdbFNJ5WZrHUX0VTU5GA467FTahja17tgSg6qjU7kmYd6DF3t8ZV
 FBqZj/zqIS0kaib+ShMCI2XXQuc7FJA31j0qdduCgsBVIcpC8sIOPNOaCcwwemKyyRK9TZRjJph
 fX1D5mo0hM/m9zu8gdPSUMTcMTIGGYmMpmY2o7OXMwlQ1f0Ls54DrRKpWz2nYkEQggSMLG3YZ/5
 zXCWbk+QwjRgk4U9HrAmQHjT0kb6G9SGXIrv9jNG/Ny+xyuMex6rMibvQMiWMFoQ0U+oJfKdfVW
 amr6Apf3Vxsgh1YvXO9aYDDz2UMF30Lxwr4yBpcM2zBu1JOF3VjxakoncfX6cau6cNriNFYHB/I
 Etc4zGMTproATX7Muc8MXUJkiI2tmAGpGZpR4AHXBEylCOz2e2495azmgU7Irbc1nRUetSyi0dL
 YgrV1EniWd9r8pVbKnQ==
X-Proofpoint-ORIG-GUID: X-J0uCXiaAzZrPefrtbMQb5TpuPyqq1Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_02,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 priorityscore=1501 bulkscore=0 phishscore=0 malwarescore=0
 adultscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605110077
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=jishnuvw@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 11 May 2026 08:54:09 -0400
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

On Thu, Mar 05, 2026 at 12:09:10AM -0600, Saif Abrar wrote:
> IODA PCT table (#3) is implemented
> without any functionality, being a debug table.
> 
> Signed-off-by: Saif Abrar <saif.abrar@linux.vnet.ibm.com>
> Reviewed-by: Cédric Le Goater <clg@kaod.org>
> ---
> v3: Updates for coding guidelines.
> 
>  hw/pci-host/pnv_phb4.c              | 6 ++++++
>  include/hw/pci-host/pnv_phb4.h      | 2 ++
>  include/hw/pci-host/pnv_phb4_regs.h | 1 +
>  3 files changed, 9 insertions(+)
> 
> diff --git a/hw/pci-host/pnv_phb4.c b/hw/pci-host/pnv_phb4.c
> index a6fa578e85..254bbe4089 100644
> --- a/hw/pci-host/pnv_phb4.c
> +++ b/hw/pci-host/pnv_phb4.c
> @@ -264,6 +264,10 @@ static uint64_t *pnv_phb4_ioda_access(PnvPHB4 *phb,
>          mask = phb->big_phb ? PNV_PHB4_MAX_MIST : (PNV_PHB4_MAX_MIST >> 1);
>          mask -= 1;
>          break;
> +    case IODA3_TBL_PCT:
> +        tptr = phb->ioda_PCT;
> +        mask = 7;

According to PHB5 spec (lines 13568-13580):
- Small PHB: 64 entries (mask should be 63)
- Big PHB: 128 entries (mask should be 127)
- Each entry has 2 parts, so total is 128/256

> +        break;
>      case IODA3_TBL_RCAM:
>          mask = phb->big_phb ? 127 : 63;
>          break;
> @@ -362,6 +366,8 @@ static void pnv_phb4_ioda_write(PnvPHB4 *phb, uint64_t val)
>      /* Handle side effects */
>      switch (table) {
>      case IODA3_TBL_LIST:
> +    case IODA3_TBL_PCT:
> +        /* No action for debug tables */
>          break;
>      case IODA3_TBL_MIST: {
>          /* Special mask for MIST partial write */
> diff --git a/include/hw/pci-host/pnv_phb4.h b/include/hw/pci-host/pnv_phb4.h
> index bea0684724..6bb75edeef 100644
> --- a/include/hw/pci-host/pnv_phb4.h
> +++ b/include/hw/pci-host/pnv_phb4.h
> @@ -65,6 +65,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(PnvPHB4RootBus, PNV_PHB4_ROOT_BUS)
>  #define PNV_PHB4_MAX_LSIs          8
>  #define PNV_PHB4_MAX_INTs          4096
>  #define PNV_PHB4_MAX_MIST          (PNV_PHB4_MAX_INTs >> 2)
> +#define PNV_PHB4_MAX_PCT           128

Question: Is PCT table 8 or 128 entries? Check PHB5 spec.
- If 8 entries: mask=7 is correct
- If 128 entries: mask should be 127

Thanks, 
Jishnu

>  #define PNV_PHB4_MAX_MMIO_WINDOWS  32
>  #define PNV_PHB4_MIN_MMIO_WINDOWS  16
>  #define PNV_PHB4_NUM_REGS          (0x3000 >> 3)
> @@ -138,6 +139,7 @@ struct PnvPHB4 {
>      /* On-chip IODA tables */
>      uint64_t ioda_LIST[PNV_PHB4_MAX_LSIs];
>      uint64_t ioda_MIST[PNV_PHB4_MAX_MIST];
> +    uint64_t ioda_PCT[PNV_PHB4_MAX_PCT];
>      uint64_t ioda_TVT[PNV_PHB4_MAX_TVEs];
>      uint64_t ioda_MBT[PNV_PHB4_MAX_MBEs];
>      uint64_t ioda_MDT[PNV_PHB4_MAX_PEs];
> diff --git a/include/hw/pci-host/pnv_phb4_regs.h b/include/hw/pci-host/pnv_phb4_regs.h
> index c1d5a83271..e30adff7b2 100644
> --- a/include/hw/pci-host/pnv_phb4_regs.h
> +++ b/include/hw/pci-host/pnv_phb4_regs.h
> @@ -486,6 +486,7 @@
>  
>  #define IODA3_TBL_LIST          1
>  #define IODA3_TBL_MIST          2
> +#define IODA3_TBL_PCT           3
>  #define IODA3_TBL_RCAM          5
>  #define IODA3_TBL_MRT           6
>  #define IODA3_TBL_PESTA         7
> -- 
> 2.47.3
> 
>


