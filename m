Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FF22C43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 17:51:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfi2c-0007F6-OA; Fri, 03 Jul 2026 13:51:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wfi2b-0007Ej-S1
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 13:51:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wfi2a-0007JE-7G
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 13:51:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783101060;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YJ50Xpg8KaWdrB20he/p9oQnBmilZze5lI/aVbghq3k=;
 b=S7seGbW8srrn7QASUDsKN08kvJ/fFK7w1FZv/DOyn/Nppw/yovuD34Glrv6cVehM59xpHu
 SVN3Q+PF2pYWhj98GsQACT0a20+SSXzU0vyqgZBulvSLtqgNJyDrgXokgd8NZ0VLBxEZHC
 gMnpUEKdK/sN7OkJIY1joXipjIq6M0M=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-440-JJBo0zyVMPaZjNuwSG1yrg-1; Fri, 03 Jul 2026 13:50:57 -0400
X-MC-Unique: JJBo0zyVMPaZjNuwSG1yrg-1
X-Mimecast-MFC-AGG-ID: JJBo0zyVMPaZjNuwSG1yrg_1783101056
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-493c1bc7a70so7339215e9.1
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 10:50:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783101056; cv=none;
 d=google.com; s=arc-20260327;
 b=qIMV8iVtaRYagDL2/+TMDFRmo+2N+itlWmKY6AvMR7Iev7ahRAEbf/zziKyqlTutpy
 WIoyVRmr3D9chpAb6ISXMbuUIRBFt/CiED/Z3Lr9U1bbYmkD9NJVo/4PU+Y6/DFSkTej
 KrBmjSs/x1kccXpqU8r1365Kl71F+RvP7a/SxGo7tjnov8hg0/RqGTnHMcQYkFICR/tG
 fK/JyuRunOPIihE0EvzrIBASiYqGqkCaRkHj5K0k+O4ts/qp14xkCpP2NKIEETCg6wmx
 7q+x38iZAaVk37Ms/919cUiyEEBPJrshPsP98rnc74qsYu9cwj/JhMtsEdgEnjSUOHSy
 OipA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=YJ50Xpg8KaWdrB20he/p9oQnBmilZze5lI/aVbghq3k=;
 fh=Y6ZVa2DAQ7N99Yz30qJegDSPM58qw0hum3KbRozMzY4=;
 b=WaegIkXWRIqhQZr6SDBQdgTJ+IDJV5OF/Utj6GPOwstyPsYF4zu2Y5/BgFo54jH4ti
 kzI6SBf+8EdhqDDemUJhcM8fQ2RO7+xkK2xtgN/YRbxVKyDYJayfuKddZIsF+2MREgrj
 4jpYc6caYjuDOf1MnrNFRP/yzgYsQl6reFcvBq/wp+NSFCwz2L1maJlx/5sEGxlKb6mq
 OyAYfsHQ6YL7JATirINIj6kqAI3+tyXfvihKC9YRuY+LXM4cSd2/1ZnWad1U6R0PJOTU
 HuWvTsidcI+ApfbGZ2PWxbAe7LYZxkaN8EbPEVx470kRtWUOmihUeJrdAP1YNi8DPzyL
 sA+g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783101056; x=1783705856; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YJ50Xpg8KaWdrB20he/p9oQnBmilZze5lI/aVbghq3k=;
 b=nyck+KmW9zzn/6s1ZfjUJT12BpXnq6iAhLW0aN38TshBFjsQrqjB6FkC+kgmDKYnKo
 M3mVOlX/MNz+QMski/KJMNm6xVs2hAPdGhQBPxr/J3Rpa5ktVyLViDDJykNfHxsaEU2Y
 aRRsKLTqwlNrHEGX/6YuyL3NnUt2m8Q4S6gCFAHmGgm7QA/sQh4kDyxhxzuslI+2NQWw
 jo9aikS+qPwYZDE35/yEJzpJL3n11T2xjFFrr/DiAkFAPmJHh9JepmL4uH9Vu8LNqLAK
 gM3bBcDp/BOOSsXzOmp+N3lBoSg6H3wlmCm1m2nEtWkerKLyzrw4SbTHQEcmMjqhDhCq
 Fltg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783101056; x=1783705856;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YJ50Xpg8KaWdrB20he/p9oQnBmilZze5lI/aVbghq3k=;
 b=lF3KQ8fA03RVd/OhmhSPIXcHBmxinAHVzE+jDb1AKUoWt30UeTS8ZWIh2mmSP1Gb1e
 KJlv/frhrUUYNbnR9Zy/JOAJLSYKd8P5gm4O+6u1nzLDRZALjSvlr3Q61B8SW0QL4GIv
 8J1j7q2iqkAn8C65qekr6MmcER5V0Id3mGKW1I5ymH5Itp1IBeu6g1/1DvhX7As44FL/
 8zUkG+ADWbk8Kkbeqli8KTG8vXBvVvBpZEa3SHlPq052j3yKaW+KHGI/wIIuRz64muq8
 FBVeJd4vl2LF2mowFUcdTsnKmyR3fua5O6ViBJCc6XkmqSpjkzUyz5Y9ugZ4H8f2H+jp
 Bt2Q==
X-Gm-Message-State: AOJu0Yxeg6CB6EWxjKXo9Gr44/DJWA9fC4PfJSBEQ4hHInT6xbYwVv5P
 Ji0o2TmDEu2Ld5CqqEuFmdE7y5cTZZA3DpF7+wxypH6wuUSeJ1JooxXMdMH0pvEzx2vPwrKktQr
 MZ/wifOz1Zh6JxT7e/K/PDFWa69NGrfbE7gGir5XrZkL2PtLsTBi+wFeKGDEHO8lW3WSKitVD2Q
 SREo9C8u4M77FnKjJG0QAjpjq6XpFCVsk=
X-Gm-Gg: AfdE7clAfc+lTQOzsgcWlJQ2F/uHKFSiypc2iOhhb2D248B2B9C3XLO8TrH0VgIfDoc
 /L0uiegiOH8/+Rwy88XKxRIEKnDt/UBP/AuVgi9yKgSa04KRizK5nNkJy7igdKgSj+yFoufc/09
 YGfdpSs9IVQleZsViK11ryXNkPMQUqsYLHnwdR2pHwRT5dJUQhdqftS06xv7HBqZ88gjdfcdiB8
 Ql0T9t0MMKkrNGso4rdxhHNvvIyY3ShK9eLxEP+dG36WPz3L2FYjI2lh+Ewc5lj2FbMNZE=
X-Received: by 2002:a05:600c:154b:b0:493:b6c2:cd96 with SMTP id
 5b1f17b1804b1-493d11d9d42mr3114125e9.12.1783101056184; 
 Fri, 03 Jul 2026 10:50:56 -0700 (PDT)
X-Received: by 2002:a05:600c:154b:b0:493:b6c2:cd96 with SMTP id
 5b1f17b1804b1-493d11d9d42mr3113915e9.12.1783101055836; Fri, 03 Jul 2026
 10:50:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260417105618.3621-1-magnuskulke@linux.microsoft.com>
 <20260417105618.3621-27-magnuskulke@linux.microsoft.com>
 <CABgObfbS988oSPNOV4qLMcT1CPLAyu-NigwYPgZSgZq1ZY7fxA@mail.gmail.com>
 <akfvt0nTdVKZFOmJ@example.com>
In-Reply-To: <akfvt0nTdVKZFOmJ@example.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 3 Jul 2026 19:50:43 +0200
X-Gm-Features: AVVi8Cc2ACvz9Ph4hCnMyq-PQo0PFOCu_awdNl7m7EQ8YKw-fQIeEH6Q5TpoBDY
Message-ID: <CABgObfagW4TRZ5YcB-8SHizsjd2BafrcvTnu2fAkyV3_4_GT2A@mail.gmail.com>
Subject: Re: [PATCH 26/34] accel/mshv: introduce SaveVMHandler
To: Magnus Kulke <magnuskulke@linux.microsoft.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, kvm <kvm@vger.kernel.org>, 
 Magnus Kulke <magnuskulke@microsoft.com>, Wei Liu <liuwe@microsoft.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Wei Liu <wei.liu@kernel.org>, Alex Williamson <alex@shazbot.org>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Marcelo Tosatti <mtosatti@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000000847c10655b89132"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
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

--0000000000000847c10655b89132
Content-Type: text/plain; charset="UTF-8"

Il ven 3 lug 2026, 19:22 Magnus Kulke <magnuskulke@linux.microsoft.com> ha
scritto:

> On Thu, Jul 02, 2026 at 10:50:17AM +0200, Paolo Bonzini wrote:
> > Sorry, I forgot to reply about this one.
> >
> > It is not clear why you need to pause, since this is handled by common
> > code. Are you not handling live migration yet? That should be handled at
> > levels above QEMU, because users expect migration to be performed while
> the
> > VM runs, and the SaveVMHandler should just fail migration of the VM is
> > running.
> >
> > Paolo
> >
>
> Hey Paolo,
>
> I spent some time looking at this. it's a bit twisted. The un/pause()
> calls are unfortunately named, they are merely freezing the progress of
> the reference timer, which for any real-world workload is in fact
> pausing the guest b/c if the timer doesn't progress an os would mostly
> stall, waiting for ticks.
>

There are different "schools of thought" for that. Freezing introduces an
incorrect timing on the destination, not freezing introduces a jump.

If you choose to freeze that's fine, QEMU does the same for KVM even though
KVM has alternative ioctls that allow not freezing.

But currently it's the wrong
> place. I'll find some more fitting place to perform this ceremony.
>

KVM uses a device for that, see kvnclock.c.

Curiously the time-frozen source was obscuring another potentially more
> serious bug. The mshv vcpu dispatch loop currently does not honor a
> cpu->exit_request


Was that related to the other patch that was touching the vcpu thread loop?

Paolo

like it is currently set after precopy:
>
> migration_completion_precopy()
>   migration_stop_vm()
>     vm_stop_force_state()
>       vm_stop()
>         do_vm_stop()
>           pause_all_vcpus()
>             cpu_pause()
>               cpu_exit()
>                 qatomic_store_release(&cpu->exit_request, true)
>
> The two bugs were sort of cancelling each other out. Since the source
> guest was not busy, migrations were still succeeding, even though the
> the vcpus were not actually "stopped" on the vcpu.
>
> I'll rework this a bit, and submit a revised version.
>
> best,
>
> magnus
>
>

--0000000000000847c10655b89132
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il ven 3 lug 2026, 19:22 Magnus =
Kulke &lt;<a href=3D"mailto:magnuskulke@linux.microsoft.com">magnuskulke@li=
nux.microsoft.com</a>&gt; ha scritto:<br></div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,2=
04);padding-left:1ex">On Thu, Jul 02, 2026 at 10:50:17AM +0200, Paolo Bonzi=
ni wrote:<br>
&gt; Sorry, I forgot to reply about this one.<br>
&gt; <br>
&gt; It is not clear why you need to pause, since this is handled by common=
<br>
&gt; code. Are you not handling live migration yet? That should be handled =
at<br>
&gt; levels above QEMU, because users expect migration to be performed whil=
e the<br>
&gt; VM runs, and the SaveVMHandler should just fail migration of the VM is=
<br>
&gt; running.<br>
&gt; <br>
&gt; Paolo<br>
&gt; <br>
<br>
Hey Paolo,<br>
<br>
I spent some time looking at this. it&#39;s a bit twisted. The un/pause()<b=
r>
calls are unfortunately named, they are merely freezing the progress of<br>
the reference timer, which for any real-world workload is in fact<br>
pausing the guest b/c if the timer doesn&#39;t progress an os would mostly<=
br>
stall, waiting for ticks.<br></blockquote></div></div><div dir=3D"auto"><br=
></div><div dir=3D"auto">There are different &quot;schools of thought&quot;=
 for that. Freezing introduces an incorrect timing on the destination, not =
freezing introduces a jump.</div><div dir=3D"auto"><br></div><div dir=3D"au=
to">If you choose to freeze that&#39;s fine, QEMU does the same for KVM eve=
n though KVM has alternative ioctls that allow not freezing.</div><div dir=
=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote gmail_quote=
_container"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">But currently=
 it&#39;s the wrong<br>
place. I&#39;ll find some more fitting place to perform this ceremony.<br><=
/blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">KVM u=
ses a device for that, see kvnclock.c.</div><div dir=3D"auto"><br></div><di=
v dir=3D"auto"><div class=3D"gmail_quote gmail_quote_container"><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex">
Curiously the time-frozen source was obscuring another potentially more<br>
serious bug. The mshv vcpu dispatch loop currently does not honor a<br>
cpu-&gt;exit_request</blockquote></div></div><div dir=3D"auto"><br></div><d=
iv dir=3D"auto">Was that related to the other patch that was touching the v=
cpu thread loop?</div><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo</=
div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote=
 gmail_quote_container"><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"> =
like it is currently set after precopy:<br>
<br>
migration_completion_precopy()<br>
=C2=A0 migration_stop_vm()<br>
=C2=A0 =C2=A0 vm_stop_force_state()<br>
=C2=A0 =C2=A0 =C2=A0 vm_stop()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 do_vm_stop()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pause_all_vcpus()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_pause()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_exit()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qatomic_store_relea=
se(&amp;cpu-&gt;exit_request, true)<br>
<br>
The two bugs were sort of cancelling each other out. Since the source<br>
guest was not busy, migrations were still succeeding, even though the<br>
the vcpus were not actually &quot;stopped&quot; on the vcpu.<br>
<br>
I&#39;ll rework this a bit, and submit a revised version.<br>
<br>
best,<br>
<br>
magnus<br>
<br>
</blockquote></div></div></div>

--0000000000000847c10655b89132--


