Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9218ECD6E69
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 08:33:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUh1t-0005S6-Pg; Wed, 03 Jun 2026 04:32:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1wUh1s-0005RK-2C; Wed, 03 Jun 2026 04:32:48 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1wUh1q-0005KV-Cj; Wed, 03 Jun 2026 04:32:47 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6538D3s22665536; Wed, 3 Jun 2026 08:32:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=aWeOdXte+7V4UGQNzVktrfC4+JG0Kk
 v/R+yRalWMpbI=; b=nef+FZD+0nC3TldrXAFX+UOUoWT1chv4SiztNjj9zANlHh
 4UT7m2+6X3LjCj9sDyY3WxDPZvmKaR5uc+yGm1PwIZc2zQFr71DBZbrtWJKE6qxx
 XR3yi+W7LTy0+YppLML14TdK+tm0KLlMGze6wxWwQIeEZRF7SvdBihSSE4C36dLp
 6LJVjQV57aPOlslLITqQamhxsCHXqlfqMij3rBi70KjvDNo4rd+LBjQ/6iYemFJ5
 k3VvpzJyV3XHYfmWjPsV+QyhdtBZC1PnPInhqx5s28KPEnJnkLCEMRp7GGPAkDDV
 wxXHGUKtUVEDQ3RUgXg5japKcN2DcQzcGToOxo6A==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqht9d01-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 03 Jun 2026 08:32:44 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6538OAGo018790;
 Wed, 3 Jun 2026 08:32:43 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4egb7k7b6d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 03 Jun 2026 08:32:43 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6538WdCr45941032
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 3 Jun 2026 08:32:39 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8194A20043;
 Wed,  3 Jun 2026 08:32:39 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 439522004B;
 Wed,  3 Jun 2026 08:32:38 +0000 (GMT)
Received: from fedora (unknown [9.5.7.39])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Wed,  3 Jun 2026 08:32:38 +0000 (GMT)
Date: Wed, 3 Jun 2026 14:02:36 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Vaibhav Jain <vaibhav@linux.ibm.com>
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>, qemu-ppc@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 1/3] hw/ppc/spapr: Do not fallback to raw mode when
 KVM rejects compat
Message-ID: <20260603135251.3afb2400-31-amachhiw@linux.ibm.com>
Mail-Followup-To: Vaibhav Jain <vaibhav@linux.ibm.com>, 
 qemu-ppc@nongnu.org, Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 qemu-devel@nongnu.org, Nicholas Piggin <npiggin@gmail.com>
References: <20260502140021.69712-2-amachhiw@linux.ibm.com>
 <87h5nkyuuk.fsf@vajain21.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h5nkyuuk.fsf@vajain21.in.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: loMO82FXeE-yoZyDOyxYTWa15XNMSrle
X-Authority-Analysis: v=2.4 cv=fv/sol4f c=1 sm=1 tr=0 ts=6a1fe6ac cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=YO5uScavU021D0lB2Q4A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDA3NiBTYWx0ZWRfX64pBAM/x+gLd
 r9y84eM1NuXfVFZChpGDlnuApkyM8ZmdoAUZuiumPhTBWe/Fbxd8LQFwjUvI+Ln2vzbAndmpXM6
 35O3Ji59SLzxWS5GGyXBIrsVoy07mtSrGeMrW5O7UfrksbUR2oSQsqriMdOlztQCzcYRYXMbTJt
 FrRUTJ8FQBwN1nV+Zv6hvMdVOWYCHu4z66RoqRQH8pzco5H9jsb4zl2ftiAwd7iyjlYvit7UfzA
 HXx/bLcvOVR/8CQ3aDxmkctjl03FyggWceI+k9RbcSJmxezoF0CLZnU2sF1Us15jYjl4VTdWKl6
 crr+5cJJLJVrPr/dwjDgTjA/YyR6jv/8ypyemiuFcfNVLWhrAUppRGpKPYhz6Lw//V8xu7KmR6P
 m3IPCFTBP3pqrh14qzLIQXmoBR62QbuXHiY2VbMLzAZazwLmMRorexOV/oCgXwWUJ4RpMzgQePF
 C32mJtwbUeFjmRrDoAQ==
X-Proofpoint-ORIG-GUID: rlTRTWyLURacScKP6BhZCa1cZaIhKKMj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0 clxscore=1015
 impostorscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606030076
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=amachhiw@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Vaibhav,

Thanks for taking a look at this patch. My response is inline:

On 2026/06/03 12:27 PM, Vaibhav Jain wrote:
> Hi Amit,
> 
> Thanks for the patch. My review comments inline below:
> 
> Amit Machhiwal <amachhiw@linux.ibm.com> writes:
> 
> > During H_CLIENT_ARCHITECTURE_SUPPORT, QEMU attempts to set the requested
> > CPU compatibility mode via ppc_set_compat_all(). If this fails, the
> > existing code may fall back to raw mode when supported by the guest.
> >
> > The current logic treats all failures uniformly and tried to fall back
> > to raw mode whenever possible. As a result, errors from KVM (e.g.
> > kvmppc_set_compat() returning -EINVAL) are silently masked, making
> > debugging difficult and allowing the guest to proceed with an
> > unsupported or incompatible configuration.
> >
> > When running with KVM, such failures indicate that the requested
> > compatibility level is not supported by the host. Do not fallback in
> > this case; instead, report the error and fail the CAS negotiation.
> >
> > This makes the failure visible to the user and ensures that invalid
> > compatibility requests are rejected early rather than being hidden by
> > fallback behavior. For example, the following error is now reported:
> >
> >   qemu-system-ppc64: Unable to set CPU compatibility mode in KVM: Invalid argument
> >
> > Fixes: cc7b35b169e9 ("spapr: fallback to raw mode if best compat mode cannot be set during CAS")
> > Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> > Tested-by: Anushree Mathur <anushree.mathur@linux.ibm.com>
> > ---
> >  hw/ppc/spapr_hcall.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> > index 032805a8d0db..de2ea6f5e579 100644
> > --- a/hw/ppc/spapr_hcall.c
> > +++ b/hw/ppc/spapr_hcall.c
> > @@ -1204,6 +1204,15 @@ target_ulong do_client_architecture_support(PowerPCCPU *cpu,
> >          Error *local_err = NULL;
> >  
> >          if (ppc_set_compat_all(cas_pvr, &local_err) < 0) {
> > +            /*
> > +             * If KVM rejected the compat mode, do not fallback. This indicates
> > +             * the host cannot support the requested level.
> > +             */
> > +            if (kvm_enabled()) {
> > +                error_report_err(local_err);
> > +                return H_HARDWARE;
> > +            }
> > +
> 
> NAK on this change.
> 
> As per PAPR whether the guest can run in RAW mode needs to be negotiated
> between Guest and VMM. The existing code path via cas_check_pvr() and
> 'raw_mode_supported' already handles this case.
> 
> So I dont see a reason for this KVM specific changes needed. Can you
> please elaborate a bit more on the issue that gets fixed by this change.

I have mentioned the reason in the commit message. I'm quoting the part
of it below:

  The current logic treats all failures uniformly and tried to fall back
  to raw mode whenever possible. As a result, errors from KVM (e.g.
  kvmppc_set_compat() returning -EINVAL) are silently masked, making
  debugging difficult and allowing the guest to proceed with an
  unsupported or incompatible configuration.

The currently call chain is as below:

 do_client_architecture_support()
   -> ppc_set_compat_all()
     -> run_on_cpu()
       -> do_run_on_cpu()
         -> do_set_compat()
           -> ppc_set_compat()
             -> kvmppc_set_compat()  // returns error

Now when an error is returned via kvmppc_set_comapt(), its just ignored
in the current situation silently in do_client_architecture_support(),
while the caller is supposed to handle the error returned in an errp
object. This would make the guest try to continue with a raw mode when
the host was actually booted in a compatibility mode, while it shouldn't
be doing that.

Please let me know your further views on this.

Thanks,
Amit

> 
> If this change is related to your Linux kernel patch series titled
> "KVM: PPC: Handle CPU compatibility mode for nested guests" then the
> ideal place to put compat check would be in ppc_check_compat() and not in
> do_client_architecture_support()
> 
> >              /* We fail to set compat mode (likely because running with KVM PR),
> >               * but maybe we can fallback to raw mode if the guest supports it.
> >               */
> > -- 
> > 2.50.1 (Apple Git-155)
> >
> 
> -- 
> Cheers
> ~ Vaibhav
> 

