Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2B46C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 08:58:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whkaR-00062p-5j; Thu, 09 Jul 2026 04:58:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1whkaP-00062A-0m
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 04:58:25 -0400
Received: from mail-yx1-xb12e.google.com ([2607:f8b0:4864:20::b12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1whkaN-000093-86
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 04:58:24 -0400
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-664bb15d05dso2180718d50.3
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 01:58:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783587502; cv=none;
 d=google.com; s=arc-20260327;
 b=SoAO/pQZHuITJKvd7Pz2e+a7QVYf2kZw/9Nrae2DtrR6px93Efy5qfxk1qobwt7ScR
 SXWpsIniinOBo57aaj2Bcut4c/XDrM7GS6C7Dq3OVv4tqMrW2or3LAwL+8bqVmltO11w
 yvxBOmOZn5vCNLD3cGm27UqSfwq07b9kFWAlfG2F+Eno/nKR2orQpITGw8OfJwpqm/Ax
 +m4e0Yym5x5SXQ3zBMLNjtO4i4LQsjAqIpsJeU3NMeVOiZUYTqxc+2lK2SDmJl2A2I3q
 Ob4lCWeGBOSQNSBo+SLtroaZov7Gqcrv+G1QNIA/Ch/gtiPsZjUkAHkCL5eTtZU11Ijb
 /zTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=T/A7W7rXmiyZ10RfAv9r/GSHlz9Q8q4wrqQ80ea83kk=;
 fh=seLqzMn7RwRMOH4iMqxCA+O9B+H3gFtOjt3FsBQPmzw=;
 b=Cqnv52aJAww8Fw9CkbrrtHZ5gDjyeSzdk27qBkQoLXIYAau2ADkeebRvSBHsprut84
 ZIr8+ydyJM3f6ULoSTYoS9UXXUVpzdP647xh5Lfz68SoPTqIFjgqY/POBnO6xuy1s2Nn
 5SS4naXcjjpRzImuWrZvH3sHsEZTMobsUaueiJM/Drh8UhhzQEgFAUnxJph37lY/IKUE
 WHxq7LCuibtmUx0iDK/D7S1WpLfrATMex2Zx/cPSLL1CEi/Z7OSdhuSIqjMLmR+Ade/d
 qrpG0MqFifp2Evscz89KLmxBjpwNyK+G3JmBzDYVCtcg2KM99NigX+2GRWofGyWkTI3M
 e+GA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783587502; x=1784192302; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=T/A7W7rXmiyZ10RfAv9r/GSHlz9Q8q4wrqQ80ea83kk=;
 b=Ect3VuDK/8Ygt4pEyDHVlopodCdrApXnP0u3eeKC8ZbzDUF8XdS2Ct7kw8OinZ7nFH
 gp3F7ESfgv+mLy3ynsG8jA0v5orM4XKDlEMmPypPXxE6VNEkZVXfXoYb2IK4YPMFS6Eg
 unn6NNr7de7tsjX8T+lMdIXV+g5BRU3kGftM1WkUja2+t3MbW/0B1Nsx5lfU/FllOxSA
 DW9SiGdp14Lnqa891kmu/BClfvE4YtVCZGz9eUROmZcf5lOa+XvUBy+XEIsUHqibebln
 Xi6tTZkh42I565JSuGJ5Qai0v2MM7glGgE4qn3VSDn5CayTK87UolwosoKB9VITxeqZc
 jCow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783587502; x=1784192302;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=T/A7W7rXmiyZ10RfAv9r/GSHlz9Q8q4wrqQ80ea83kk=;
 b=sRxlG2BechsmSk2uJFQWLqqe/MVlg2TEjLWd6Cr4xXxnvfsv7YRuvyudFnvESYtfXv
 1m1OJZzF6tL/hPeV3BsZUAV4lAWLmOsqdtoNQZWn741zLd0iCnA/JF02Ami2K3LZmIva
 BGA0KRKdF/A7QVAG/4DEnjOUmXFNiGCJdols/Fu7/OvJRFa0QtqqE8kVjwaqvvAFPN5v
 8dWb4Oc9FEBCY+jMDc65HWeyavvgEbZbQY4TLQmH/YAsfeuvwY3tFCyPVuIaAybru2ON
 C7VgT8191CUN1Ss5Ewy8lBe7vEyAxZ751M7afEo9Pl4REEqLm+DxgKwfE0wrrK/YR5IU
 8KQQ==
X-Gm-Message-State: AOJu0YwLWi3suitIiXcMoR5SM8bLpfm8Ra4ihyquUg/cTlvZrsX4XoFm
 iWCkOlHed4umiCBWMC0WfuIT/j/1Nwl3WJvvPy7BwjEdlFrqlfFWlKHMUpv5VsdC+ZONGLjM3h6
 gT/Iknk+Om/PVVklUTOAc1iHmopK65GRJFATGC2FgrQ==
X-Gm-Gg: AfdE7cmykGT4mAULMOujR6HVW4LxQYVuoH6GoMkA0YNmBBg+E6jQ23V8KEWKxcjrgqg
 5vFGfSOXjbm2HWgzU4nB8nLlZszDfKU8Kq+SuUCojHOJE+yeC4WAzskOk9zNxEnWXf39h9YlZjo
 vq8hvTMz7U0wE4Coj3d2SQsgDkuOY+x+HbGdxVzbZEnk3UlEh63SvskEKUcleD9BAbKMOtxuNTp
 C8vh1IuZ6ElVa33IOKUsRUCsiPXNMpwQpKrPQy7O/R2ZV9knxLbrAIABnvWq3tAZj+VXM6Kb/IS
 bLNwqT+ameQe1KQG+12RWqKHcWEHuBLjUkeWBunqnM41Mgdr1kjWAB55
X-Received: by 2002:a53:d0c8:0:b0:667:8b9c:e6c2 with SMTP id
 956f58d0204a3-6679f2d2ab9mr3565985d50.102.1783587501672; Thu, 09 Jul 2026
 01:58:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260709084728.92862-1-alexander@mihalicyn.com>
 <CAFEAcA82Ps8EDcjpoYVBxf5VAmiSJNvE1dvuKWokPKbp7OpWjw@mail.gmail.com>
 <CAJqdLroRKpD0B2KXbwG61DY=Uff_DZyxE-XB_AQmEnQt6ViyHg@mail.gmail.com>
In-Reply-To: <CAJqdLroRKpD0B2KXbwG61DY=Uff_DZyxE-XB_AQmEnQt6ViyHg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 9 Jul 2026 09:58:10 +0100
X-Gm-Features: AVVi8CfLc3TgdpAzFGquRQCO5GJAPRW7c8Bg5Fmp987Ad47wA1oWHTol4bhjCAA
Message-ID: <CAFEAcA_gZmVZr5ixHgf9EmPHb2kBgOdenF=3JTNEzs71v+gM=w@mail.gmail.com>
Subject: Re: [PATCH] hw/nvme: use GPtrArray for blocker_features
To: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Klaus Jensen <its@irrelevant.dk>, Keith Busch <kbusch@kernel.org>, 
 Jesper Devantier <foss@defmacro.it>, 
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Thu, 9 Jul 2026 at 09:53, Alexander Mikhalitsyn
<alexander@mihalicyn.com> wrote:
>
> Am Do., 9. Juli 2026 um 10:51 Uhr schrieb Peter Maydell
> <peter.maydell@linaro.org>:
> >
> > On Thu, 9 Jul 2026 at 09:47, Alexander Mikhalitsyn
> > <alexander@mihalicyn.com> wrote:
> > >
> > > From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
> > >
> > > Let's use GPtrArray to build a list of blocker features and then
> > > g_strjoinv() to build a final comma-delimited string.
> > >
> > > While previous approach was technically correct, it is fragile
> > > (because we need to take care of static buffer size choice) and
> > > Coverity dislikes it too.
> > >
> > > Note, that we use g_ptr_array_new() to allocate array which means
> > > that GDestroyNotify callback is not set, so we can pass pointers to
> > > a static memory like g_ptr_array_add(..., (gpointer) "SR-IOV") without
> > > any problems as there won't be any attempt to free that memory.
> > >
> > > Resolves: Coverity CID 1663673
> > > Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> > > Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
> > > ---

> > > @@ -9416,15 +9405,15 @@ static bool nvme_set_migration_blockers(NvmeCtrl *n, PCIDevice *pci_dev,
> > >              }
> > >
> > >              if (namespaces_num > 1) {
> > > -                nvme_add_blocker_feature(blocker_features,
> > > -                                         "Namespace Attachment");
> > > +                g_ptr_array_add(blocker_features,
> > > +                                         (gpointer) "Namespace Attachment");
> >
>
> Hi Peter,
>
> > Is the cast here because we're dropping the const property of the
> > literal string?
>
> yep.

Mmm. Unfortunate but unavoidable I guess.

The glib docs recommend using "void *" instead of "gpointer" in
new code: https://docs.gtk.org/glib/types.html#gpointer
but either way

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

-- PMM

