Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8716FB5EA8
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 03:18:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2KwA-0004fd-Au; Mon, 16 Mar 2026 23:17:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anirudh@anirudhrb.com>)
 id 1w2Kw9-0004fQ-MU; Mon, 16 Mar 2026 23:17:41 -0400
Received: from sender4-of-o54.zoho.com ([136.143.188.54])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anirudh@anirudhrb.com>)
 id 1w2Kw6-0007Be-SC; Mon, 16 Mar 2026 23:17:41 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1773717440; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=j6oMuKTgQZKmEyHv8vkCVjgYKHTwVKdKrVVGjNNmAfFaqys7TTb9oFjARE9kci6/C0jjJalmMJ5sWZVHQPnOBfQoTXwiQrEY0+7L0KJb8eL1lHmUXOKN2ldpTtIKhD0ioaTNaJ8cK31T29Fk0vM8A9Ah7N0bcXTcP2mWlOsD3dU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1773717440;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=BCTgZPbeuwCSIW0YwDR4f/hxrjvQulLTxikELw+DMTA=; 
 b=C/T3GyTaydCnefQTOKNcw+gOB+o3YoYnXCJnvalXp+W/Y1DOYS/kMgQvXyVOfWBecF5zONBCWuy3Q0RY04rSt2aO2hXkI/AmTKyiE8cHzkTfA9KI7bt6Huh/iOn0NSzplLmstWOy7gRmn7fS6GOQOLaFfeLvtaSasi+yWwpt/ok=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=anirudhrb.com;
 spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
 dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773717440; 
 s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Message-Id:Reply-To;
 bh=BCTgZPbeuwCSIW0YwDR4f/hxrjvQulLTxikELw+DMTA=;
 b=gPHXyUWpN0NdvZSD8/TRHjpu9ZoyhS+iLgeV1Oxe81eIiRVojLPOfeKmuk5xxBqy
 X8Jlz1izsDJ4MTMf/udEmp29Dm6I0HD2KecbYdJqNu5jcjGuoW/AxibMF7R0kSgaeFR
 8hPDxwAU/Tpqt4weagQfqskQ93hc9uRVfMGWHbFI=
Received: by mx.zohomail.com with SMTPS id 1773717437578911.6185304809283;
 Mon, 16 Mar 2026 20:17:17 -0700 (PDT)
Date: Tue, 17 Mar 2026 03:17:09 +0000
From: Anirudh Rayabharam <anirudh@anirudhrb.com>
To: Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: qemu-devel@nongnu.org, Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 =?iso-8859-1?Q?=22Daniel_P=2E_Berrang=E9=22?= <berrange@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Aastha Rawat <aastharawat@linux.microsoft.com>, qemu-arm@nongnu.org
Subject: Re: [PATCH 08/14] accel/mshv: Add access_vp_regs synthetic proc
 features
Message-ID: <20260317-mighty-toad-of-domination-af8e6e@anirudhrb>
References: <20260311-mshv_accel_arm64_supp-v1-0-c31699b7bc1f@anirudhrb.com>
 <20260311-mshv_accel_arm64_supp-v1-8-c31699b7bc1f@anirudhrb.com>
 <199EF957-0EBD-4E14-8453-1C5FA5B14063@unpredictable.fr>
 <20260312-lucky-cocky-whippet-2a5f3d@anirudhrb>
 <AA5B0DE1-CA87-43F6-9A52-2F9F91F3514D@unpredictable.fr>
 <20260313-quaint-educational-swallow-aac6e3@anirudhrb>
 <675BD854-D0C3-4942-B32D-2684078DC4D5@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <675BD854-D0C3-4942-B32D-2684078DC4D5@unpredictable.fr>
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.54;
 envelope-from=anirudh@anirudhrb.com; helo=sender4-of-o54.zoho.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Fri, Mar 13, 2026 at 12:29:32PM +0100, Mohamed Mediouni wrote:
> 
> 
> > On 13. Mar 2026, at 10:01, Anirudh Rayabharam <anirudh@anirudhrb.com> wrote:
> > 
> > On Thu, Mar 12, 2026 at 11:45:48AM +0100, Mohamed Mediouni wrote:
> >> 
> >> 
> >>> On 12. Mar 2026, at 11:32, Anirudh Rayabharam <anirudh@anirudhrb.com> wrote:
> >>> 
> >>> On Wed, Mar 11, 2026 at 04:35:31PM +0100, Mohamed Mediouni wrote:
> >>>> 
> >>>> 
> >>>>> On 11. Mar 2026, at 16:15, Anirudh Rayabharam <anirudh@anirudhrb.com> wrote:
> >>>>> 
> >>>>> From: Aastha Rawat <aastharawat@linux.microsoft.com>
> >>>>> 
> >>>>> Enable access_vp_regs feature for regs. In arm64, this feature bit
> >>>>> allows the guest to set VP registers using hypercall. This wasn't
> >>>>> required for x86 because such registers are set using wrmsr instead of
> >>>>> hypercall.
> >>>>> 
> >>>> Hello,
> >>>> 
> >>>> Could you split this into two patches? With the hvhdk.h changes in another patch.
> >>> 
> >>> Any reason why?
> >>> 
> >>> Throughout this series we're introducing hv*dk changes along with the
> >>> code using them. Isn't that a good idea?
> >>> 
> >> Hello,
> >> 
> >> I think that because of some of the content of header updates aren’t immediately related to the commits at hand, it’d be better to
> >> just have a single big commit at the beginning of the series for any GDK/HDK updates.
> > 
> > I think that in this series all the header updates are closely related
> > to the commits they're made in. Do you see a discrepancy?
> > 
> Hello,
> 
> As a random example https://lore.kernel.org/qemu-devel/20260312202209.GA124403@liuwe-devbox-debian-v2.local/T/#madb0f563a418a8fa1ebe35edd782aa4414893e5c ("accel/mshv: Add access_vp_regs synthetic proc features”) adds a bunch of other bits that aren’t that directly related to it.

Sure, there are some additional fields but they must be added along with
the commit to preserve the correct layout of the struct. So, I would
argue that in spite of the additional fields this header update belongs
in this commit.

In general, I do agree that if the header updates are completely
unrelated or if they're massive they should be in a commit of their own.
But IMO the updates in this patch series don't fall into either category

Thanks,
Anirudh.

> 
> It doesn’t mean that this info is not useful to have upstream - that’s great to have - but I think that a separate commit for the header updates at the beginning (combining them all) is best.
> 
> >> 
> >> 
> >> Oh also, preemptively adding some header definitions before they’re immediately needed could be simpler for everyone
> >> - especially given that WHP exists and is overlapping a lot.
> > 
> > Could you please elaborate? How would it be simpler? Do you mean simpler
> > for reviewing?
> > 
> Yes.
> 
> Thank you,
> -Mohamed
> > Thanks,
> > Anirudh.
> > 
> >> 
> >> Also makes me think of whether it could be better to share some code between WHPX and MSHV, but that’s a separate
> >> story…
> >> 
> >> Thanks,
> >> -Mohamed
> >> 
> >> 
> 
> 

