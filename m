Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FB33D30006
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 13:01:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1mb2-0003PJ-9J; Fri, 18 Oct 2024 09:00:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1t1mam-0003Md-8S; Fri, 18 Oct 2024 09:00:33 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1t1maj-000336-UJ; Fri, 18 Oct 2024 09:00:31 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49I5ZCGx011790;
 Fri, 18 Oct 2024 13:00:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=2ky6dB
 mWG+VnUwgX3/Oe+esSbAjNj+F9CbQpqyRONXc=; b=RWr4ieaLy+0ayg2x1Ue3Hc
 lfvi/BPgKv2QdU6ZE0/AsbFjG135IeT4o6EvyXt6vRs2y2Fffuhlb4HgyWjRACys
 SpcthJbMRfnxHWzo+fMnB6/GybX49q+V3zKOp66KvAqDeqqpCr3R2KRwmUUz/+DQ
 aAQ9bbZShTTIeHc6xck6tkWDq0yt+BVBLcLlHrDIm0POmEhGpp1N6XxEOwp9QGRr
 h/71LRoPPnBfml/aQhTTh6Dl2O7OeGqfHi3E0FsfIRausrSQsLZgzEyVVRtg+NTv
 ms4KT5Pe6me5Yh3vBXkblyEucnDLO5y+cCmQ7FdysnDqB+L0nGO0NV0GIhgDoZFw
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42bhnfa8rk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 18 Oct 2024 13:00:22 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49ID0MCP014243;
 Fri, 18 Oct 2024 13:00:22 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42bhnfa8r9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 18 Oct 2024 13:00:22 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49IBh1Wc006401;
 Fri, 18 Oct 2024 13:00:21 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4284xkmgf9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 18 Oct 2024 13:00:21 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 49ID0H8D49414490
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 18 Oct 2024 13:00:17 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7F9FE20043;
 Fri, 18 Oct 2024 13:00:17 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7D57620040;
 Fri, 18 Oct 2024 13:00:15 +0000 (GMT)
Received: from li-e7e2bd4c-2dae-11b2-a85c-bfd29497117c.ibm.com (unknown
 [9.124.218.176])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Fri, 18 Oct 2024 13:00:15 +0000 (GMT)
Date: Fri, 18 Oct 2024 18:30:10 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Vaibhav Jain <vaibhav@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH] spapr: nested: Add support for DPDES SPR in GSB for TCG L0
Message-ID: <20241018142059.c417f28d-c2-amachhiw@linux.ibm.com>
Mail-Followup-To: Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Vaibhav Jain <vaibhav@linux.ibm.com>, 
 David Gibson <david@gibson.dropbear.id.au>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 qemu-devel@nongnu.org
References: <20241017110033.3929988-1-amachhiw@linux.ibm.com>
 <07af4e02-aa2a-494c-9279-cd70389fc97e@linux.ibm.com>
 <952fc526-03a5-4965-9bba-f3aa30147370@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <952fc526-03a5-4965-9bba-f3aa30147370@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 6qTGRSU7U3BRWQIkSe5K-i0k1cEib8aj
X-Proofpoint-ORIG-GUID: yWsfPFL81KPbl_JuhQUFQZF1T5vGCull
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_spam_definite policy=outbound
 score=100 priorityscore=1501
 suspectscore=0 lowpriorityscore=0 impostorscore=0 mlxlogscore=-999
 malwarescore=0 bulkscore=0 adultscore=0 spamscore=100 phishscore=0
 clxscore=1015 mlxscore=100 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410180080
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=amachhiw@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Harsh,

Thanks for looking into this patch. My comments are below:

On 2024/10/18 02:13 PM, Harsh Prateek Bora wrote:
> Hi Amit,
> 
> On 10/18/24 10:47, Harsh Prateek Bora wrote:
> > Hi Amit,
> > 
> > On 10/17/24 16:30, Amit Machhiwal wrote:
> > > The DPDES support for doorbell emulation and handling for KVM on PAPR
> > > guests was added in Linux via [1]. Subsequently, a new GSB element for
> > > DPDES was added in Linux; the same has been missing in QEMU L0. Add
> > 
> > s/QEMU L0/ TCG L0 implementation?
> > 
> > > support for DPDES register's APIv2 GSB element and required handling in
> > > `spapr_nested.c`.
> > > 
> > > Currently, booting a KVM guest inside a QEMU TCG guest fails with the
> > > below crash. The crash is encountered when GUEST_RUN_VCPU hcall made
> > > into QEMU TCG L0 fails because H_INVALID_ELEMENT_VALUE is returned as
> > > the mapping of the element ID corresponding to DPDES (unknown to QEMU
> > > TCG L0) in GSR (Guest State Request) of TCG guest's KVM to the GSB
> > > (Guest State Buffer) elements of QEMU TCG L0 fails.
> > 
> > GSB full form would be more appropriate along with first mention of GSB
> > in above text.
> > 
> > With that:
> > Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
> > 
> > > 
> 
> <snip>
> 
> > > diff --git a/hw/ppc/spapr_nested.c b/hw/ppc/spapr_nested.c
> > > index c02785756c1e..b696ad537a77 100644
> > > --- a/hw/ppc/spapr_nested.c
> > > +++ b/hw/ppc/spapr_nested.c
> > > @@ -194,6 +194,7 @@ static void nested_save_state(struct
> > > nested_ppc_state *save, PowerPCCPU *cpu)
> > >           save->fscr = env->spr[SPR_FSCR];
> > >           save->pspb = env->spr[SPR_PSPB];
> > >           save->ctrl = env->spr[SPR_CTRL];
> > > +        save->dpdes = env->spr[SPR_DPDES];
> > >           save->vrsave = env->spr[SPR_VRSAVE];
> > >           save->dar = env->spr[SPR_DAR];
> > >           save->dsisr = env->spr[SPR_DSISR];
> > > @@ -293,6 +294,7 @@ static void nested_load_state(PowerPCCPU *cpu,
> > > struct nested_ppc_state *load)
> > >           env->spr[SPR_FSCR] = load->fscr;
> > >           env->spr[SPR_PSPB] = load->pspb;
> > >           env->spr[SPR_CTRL] = load->ctrl;
> > > +        env->spr[SPR_DPDES] = load->dpdes;
> > >           env->spr[SPR_VRSAVE] = load->vrsave;
> > >           env->spr[SPR_DAR] = load->dar;
> > >           env->spr[SPR_DSISR] = load->dsisr;
> 
> Looks like we overlooked above inits already present in existing code.
> I just checked above inits in nested_{save,load}_state are already
> present as common code between apiv1 & apiv2. So, we only need the inits
> below for initializing the lookup table.

The common code already has that handled, indeed. I'll make this change and the
ones you posted in the other response and send out a V2. Thanks for pointing
this out.

Thanks,
Amit

> 
> regards,
> Harsh
> > > @@ -982,6 +984,7 @@ struct guest_state_element_type
> > > guest_state_element_types[] = {
> > >       GUEST_STATE_ELEMENT_ENV_DW(GSB_VCPU_SPR_FSCR,  fscr),
> > >       GUEST_STATE_ELEMENT_ENV_W(GSB_VCPU_SPR_PSPB,   pspb),
> > >       GUEST_STATE_ELEMENT_ENV_DW(GSB_VCPU_SPR_CTRL,  ctrl),
> > > +    GUEST_STATE_ELEMENT_ENV_DW(GSB_VCPU_SPR_DPDES, dpdes),
> > >       GUEST_STATE_ELEMENT_ENV_W(GSB_VCPU_SPR_VRSAVE, vrsave),
> > >       GUEST_STATE_ELEMENT_ENV_DW(GSB_VCPU_SPR_DAR,   dar),
> > >       GUEST_STATE_ELEMENT_ENV_W(GSB_VCPU_SPR_DSISR,  dsisr),
> > > diff --git a/include/hw/ppc/spapr_nested.h
> > > b/include/hw/ppc/spapr_nested.h
> > > index 93ef14adcc5e..3b5cd993c256 100644
> > > --- a/include/hw/ppc/spapr_nested.h
> > > +++ b/include/hw/ppc/spapr_nested.h
> > > @@ -99,7 +99,8 @@
> > >   #define GSB_VCPU_SPR_HASHKEYR   0x1050
> > >   #define GSB_VCPU_SPR_HASHPKEYR  0x1051
> > >   #define GSB_VCPU_SPR_CTRL       0x1052
> > > -                    /* RESERVED 0x1053 - 0x1FFF */
> > > +#define GSB_VCPU_SPR_DPDES      0x1053
> > > +                    /* RESERVED 0x1054 - 0x1FFF */
> > >   #define GSB_VCPU_SPR_CR         0x2000
> > >   #define GSB_VCPU_SPR_PIDR       0x2001
> > >   #define GSB_VCPU_SPR_DSISR      0x2002
> > > 
> > > base-commit: aa54f5be44be786636a5d51cc1612ad208a24849
> > 

