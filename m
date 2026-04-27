Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08068FF8868
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 20:20:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHSR5-0000yd-SQ; Mon, 27 Apr 2026 16:20:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1wHSQe-0000w4-RK; Mon, 27 Apr 2026 16:19:45 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1wHSQb-000860-MJ; Mon, 27 Apr 2026 16:19:40 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63REMnhD2648672; Mon, 27 Apr 2026 20:19:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=RRkCyPPWZQc2UQa/7gd8crIYR71gGvfkIJcPEYFWZ+I=; b=iSPwiE/Q1AJD
 CGLecZR8HY9fEHqUuYpvrBEjni1J74NZC5XTft4zHpIKhYuEIW/5whqAF/O1RmN1
 SA4bwW+DEEp1VDLZrXT4sU08ioGw+IiOORgMIq+vRLiu81g7S/BQolh8/UBkeS3E
 48nkxJFnsDpfuz2NFxWNEZAA4p1r/f7tvOWvEy/aEDTPgmvRSNI1RhvxZ8Tiy9pb
 YQNjoNaTJlwRZERGJ2Y1tiHcGsD6pvpljwM3EIqWXgSzbPVu/U5HF8yRUvj77LeF
 o4KVC58v9yRR92+FaDjHkkwMlSRrIbQKCGA7x7GegqBpr5H7UAwdM5FekeN7S6kt
 h46R1gB9Uw==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drn8v9cjp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 Apr 2026 20:19:34 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63RK8kc0027686;
 Mon, 27 Apr 2026 20:19:34 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ds8avpvsp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 Apr 2026 20:19:33 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63RKJXjQ18612968
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 27 Apr 2026 20:19:33 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0887A58056;
 Mon, 27 Apr 2026 20:19:33 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 790DF5803F;
 Mon, 27 Apr 2026 20:19:32 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 27 Apr 2026 20:19:32 +0000 (GMT)
Message-ID: <9b37c70b975e5633c7532fd2fe278024b01cd604.camel@linux.ibm.com>
Subject: Re: [PATCH 30/41] hw/gpio/pca9552: fix state_str leak in
 pca955x_set_led
From: Miles Glenn <milesg@linux.ibm.com>
To: =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: armbru@redhat.com, qemu-ppc@nongnu.org, qemu-arm@nongnu.org
Date: Mon, 27 Apr 2026 15:19:32 -0500
In-Reply-To: <20260427-qom-tests-v1-30-c413f3605311@redhat.com>
References: <20260427-qom-tests-v1-0-c413f3605311@redhat.com>
 <20260427-qom-tests-v1-30-c413f3605311@redhat.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=CIIamxrD c=1 sm=1 tr=0 ts=69efc4d6 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=20KFwNOVAAAA:8 a=ecB0vJ_Esy-Zxr4yp7oA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: lLPY4Lw42v2eNeebUD1K9lCXOZIivERd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDIxNiBTYWx0ZWRfXywvXteG69D02
 JR5OpZrvOWlnF30qgmEBUhobiXmk85oFOYhJg4PDoXnxN+8LXOrL2zZ1GSkSz3vorvpzW8qfuKv
 qS7gflueCx2FRtEU/umYxgVmGeoMmgJ/ijaGRYViuhLtbrU003Ul/EVE815EIllDXL7cu4OZDSd
 HOgat7vzOV4VsMrM14JXS6s6jpTbM/saz5Z/VpTpht27Q1YPlI6hISOVu6nzPeQknmiA+Wty8OT
 rKpTcdBiovELG5w+4kgdib0cW02EXaTtLVWulvuGu2Yz6VjnhPpgPq2XsWGaRDWZ/srtfPmL23+
 3PgKB2bSUFpsaW7HjYXj+YWgcnnEqUumX7+51YCp0yARkldpdg0EgB+1Z09UKLVvvDWoFFUl2/4
 NbHCaqdoFg6Ho/epGMnUDtU3tRkam9lsYHxWx9529M7us++J8roW4ZOTUdSNqkGQOZczRgJR84Z
 3+2CDw743sciXMqVXaA==
X-Proofpoint-GUID: lLPY4Lw42v2eNeebUD1K9lCXOZIivERd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_04,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 malwarescore=0 suspectscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1011 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604270216
Received-SPF: pass client-ip=148.163.158.5; envelope-from=milesg@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Reply-To: milesg@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Reviewed-by: Glenn Miles <milesg@linux.ibm.com>

Thanks,

Glenn

On Mon, 2026-04-27 at 23:42 +0400, Marc-André Lureau wrote:
> visit_type_str() allocates state_str, but the function never frees it
> on any code path. Use g_autofree to ensure it is freed on return.
> 
> Fixes: a90d8f84674d ("misc/pca9552: Add qom set and get")
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  hw/gpio/pca9552.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/gpio/pca9552.c b/hw/gpio/pca9552.c
> index dd3f1536b65..472d8ad9571 100644
> --- a/hw/gpio/pca9552.c
> +++ b/hw/gpio/pca9552.c
> @@ -342,7 +342,7 @@ static void pca955x_set_led(Object *obj, Visitor *v, const char *name,
>      PCA955xState *s = PCA955X(obj);
>      int led, rc, reg, val;
>      uint8_t state;
> -    char *state_str;
> +    g_autofree char *state_str = NULL;
>  
>      if (!visit_type_str(v, name, &state_str, errp)) {
>          return;
> 


