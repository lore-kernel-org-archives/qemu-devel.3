Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 749CEC87FCA
	for <qemu-devel@archiver.kernel.org>; Sun, 10 Aug 2025 13:09:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ul5mf-0000ep-FP; Sun, 10 Aug 2025 09:08:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christian.ehrhardt@canonical.com>)
 id 1ul5mc-0000dg-MM
 for qemu-devel@nongnu.org; Sun, 10 Aug 2025 09:08:18 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christian.ehrhardt@canonical.com>)
 id 1ul5mZ-0001Sg-Op
 for qemu-devel@nongnu.org; Sun, 10 Aug 2025 09:08:18 -0400
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id AB2A53F078
 for <qemu-devel@nongnu.org>; Sun, 10 Aug 2025 13:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1754831290;
 bh=JrvAH2k1r/PunODBbwYSqmsSLUXYFkYk7DSuCc1d3YU=;
 h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
 To:Cc:Content-Type;
 b=LOchLLMk5bbe1QNylPgwxGAGrqPexYk8nkairSxtkQYeDRRjbrpo05R9KKVjRrh9I
 mHuHmysSAmUFTZ4zjvxs6T8SYTgv6Ib1lhNjuS6pFy2D5vjqWiUp2SaoYw/hZ10GyN
 BGyTQs+3YEzG1WuV4EpBc+Gf5pP9Lw5QcjMZzv9SoSW1JXDwrb+Hxv3jO44tKxJJKD
 24oUn9WDoEh8piTodHZP75xdjhf2oDwRuJ1Mt8MpukehaT8BFfJw4zotkj2QL36JB8
 RWE5eLe+8ANsZrRb4blhjWAuD4+ibUx6lC3LLTk972Wn+8FyBJsQ+Gj8jyzWTAu9vY
 NZFqamBfERy+A==
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-60c9d8a169cso3680527a12.0
 for <qemu-devel@nongnu.org>; Sun, 10 Aug 2025 06:08:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754831290; x=1755436090;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JrvAH2k1r/PunODBbwYSqmsSLUXYFkYk7DSuCc1d3YU=;
 b=pGs0ka59nWFGK/zVFQWHy4lddY1PEFEuem2tJs7fSgmpXnqyBWyMqIhgl6HA1t7YCL
 XIeWPbYtBoPDcKi9qJgt79XMCi/R02aqGxiRKgitX8jNY7GvF1lC5/erxcn9h2gb7QiW
 mlGLVWPVJTasjs/guOdmIT1+gyaCUck4V/4OWL8p8hmsFbN00fAVpgisPgGD/idfBa8F
 Ih4fU7Vg1sZj+XQPCs1eV/qqL5PnqjDAXh1+FhoyUpSWvBc52Q+VSAYs314GyUdgXySB
 eWehFNQRRbEaSnwaxLj86B4wfXtLAGh0HoLFosyTK1+qCx848/8hIqRD+Ifb9AKe5sD7
 RYNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXMIYn9+asel6L1sgWT6oOIZN9J61mo0gYxU5AN2zOFpCRbvzOHPx3q6DU5nyAWSrHhoWcXscVDDj4@nongnu.org
X-Gm-Message-State: AOJu0YzS7SH1AfixQCfZ/ptu6fWo+Vo5EmPWalTwpJVyQQ1K3tYLTNE9
 plLnlGjB2ennKnF03drdtV8REZ5daJTRzUdxx/lekjLLzNeeo/pIVAoVBqAeGXbaXLl7adLUVM2
 JT/7BdYc5XxaXsg/507nvyEq/Ins2UAy6NLfoG8xK+o5dTDiCXSSFHWV+Q8KwYeRNzl2rYukr4m
 2MMXQPFVOAEkJ26G3ioD/DvgwvgQkGxgjSqNDLmteQhvsnGLg=
X-Gm-Gg: ASbGnctUMyNvF8Uh19cXIbQAhk9lz5JzIYiy4T1WW/qKBAMXuf8YFsl4x9ciBUxEa1A
 okGMuSrV/u5RSnC77aeKn1nnq0YnbC+QNc+ZxlyE29fX3r2adg3GgB4zf4Y5I2EOiSImtqqM2x5
 Kt/wvfX70Up4TZPzsv3ONy
X-Received: by 2002:a05:6402:2745:b0:615:6482:7498 with SMTP id
 4fb4d7f45d1cf-617e2e9295cmr7153077a12.31.1754831290016; 
 Sun, 10 Aug 2025 06:08:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGCfxJ4kO1C1zc6Pmu8U3Ri3GLFt/Bq8oGbKEGyhzA4FzNs0DeGlDbaBt7Qyqzp35IF5sQ2BF82gWBDhCQbndg=
X-Received: by 2002:a05:6402:2745:b0:615:6482:7498 with SMTP id
 4fb4d7f45d1cf-617e2e9295cmr7153059a12.31.1754831289527; Sun, 10 Aug 2025
 06:08:09 -0700 (PDT)
MIME-Version: 1.0
References: <CAATJJ0+Qq3ksRmNRDrGQLVHQ=XnsnFHxCNxUhjJfNfgwUKkDPQ@mail.gmail.com>
 <aJNDxxjeqkOLAO2r@redhat.com>
 <CAATJJ0L-E=JsKOX_E=jqraeK__jLF851DDbEx5psVkTMSppKXw@mail.gmail.com>
 <aJOqmxTimJ_mFCqp@redhat.com> <2dbe2da9-895a-45ca-9f41-7ec273e0bb80@intel.com>
 <CAATJJ0Jpn8VMRDOFuk7VaV5jC3tj0V1817OiRa6tH3x1OtYFSQ@mail.gmail.com>
 <da824dc2-c241-4858-a233-6253b6b62926@intel.com>
In-Reply-To: <da824dc2-c241-4858-a233-6253b6b62926@intel.com>
From: Christian Ehrhardt <christian.ehrhardt@canonical.com>
Date: Sun, 10 Aug 2025 15:07:43 +0200
X-Gm-Features: Ac12FXy3FODRjkr0UFS8aqkiCww1PDoM5TFdK-oNekltN0ncLpB3qgQ6LsKkx7o
Message-ID: <CAATJJ0KRFuJHt6-Cc7t9CJ5Fzr9v-GYODJH+27ibsHOjd1215A@mail.gmail.com>
Subject: Re: Issues with pdcm in qemu 10.1-rc on migration and save/restore
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=185.125.188.122;
 envelope-from=christian.ehrhardt@canonical.com;
 helo=smtp-relay-internal-0.canonical.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Aug 7, 2025 at 10:09=E2=80=AFAM Xiaoyao Li <xiaoyao.li@intel.com> w=
rote:
>
> On 8/7/2025 2:37 PM, Christian Ehrhardt wrote:
> > On Thu, Aug 7, 2025 at 5:38=E2=80=AFAM Xiaoyao Li <xiaoyao.li@intel.com=
> wrote:
> >>
> >> On 8/7/2025 3:18 AM, Daniel P. Berrang=C3=A9 wrote:
> >>> On Wed, Aug 06, 2025 at 07:57:34PM +0200, Christian Ehrhardt wrote:
> >>>> On Wed, Aug 6, 2025 at 2:00=E2=80=AFPM Daniel P. Berrang=C3=A9 <berr=
ange@redhat.com> wrote:
> >>>>>
> >>>>> On Wed, Aug 06, 2025 at 01:52:17PM +0200, Christian Ehrhardt wrote:
> >>>>>> Hi,
> >>>>>> I was unsure if this would be better sent to libvirt or qemu - the
> >>>>>> issue is somewhere between libvirt modelling CPUs and qemu 10.1
> >>>>>> behaving differently. I did not want to double post and gladly mos=
t of
> >>>>>> the people are on both lists - since the switch in/out of the prob=
lem
> >>>>>> is qemu 10.0 <-> 10.1 let me start here. I beg your pardon for not=
 yet
> >>>>>> having all the answers, I'm sure I could find more with debugging,=
 but
> >>>>>> I also wanted to report early for your awareness while we are stil=
l in
> >>>>>> the RC phase.
> >>>>>>
> >>>>>>
> >>>>>> # Problem
> >>>>>>
> >>>>>> What I found when testing migrations in Ubuntu with qemu 10.1-rc1 =
was:
> >>>>>>     error: operation failed: guest CPU doesn't match specification=
:
> >>>>>> missing features: pdcm
> >>>>>>
> >>>>>> This is behaving the same with libvirt 11.4 or the more recent 11.=
6.
> >>>>>> But switching back to qemu 10.0 confirmed that this behavior is ne=
w
> >>>>>> with qemu 10.1-rc.
> >>>>>
> >>>>>
> >>>>>> Without yet having any hard evidence against them I found a few pd=
cm
> >>>>>> related commits between 10.0 and 10.1-rc1:
> >>>>>>     7ff24fb65 i386/tdx: Don't mask off CPUID_EXT_PDCM
> >>>>>>     00268e000 i386/cpu: Warn about why CPUID_EXT_PDCM is not avail=
able
> >>>>>>     e68ec2980 i386/cpu: Move adjustment of CPUID_EXT_PDCM before
> >>>>>> feature_dependencies[] check
> >>>>>>     0ba06e46d i386/tdx: Add TDX fixed1 bits to supported CPUIDs
> >>>>>>
> >>>>>>
> >>>>>> # Caveat
> >>>>>>
> >>>>>> My test environment is in LXD system containers, that gives me iss=
ues
> >>>>>> in the power management detection
> >>>>>>     libvirtd[406]: error from service: GDBus.Error:System.Error.ER=
OFS:
> >>>>>> Read-only file system
> >>>>>>     libvirtd[406]: Failed to get host power management capabilitie=
s
> >>>>>
> >>>>> That's harmless.
> >>>>
> >>>> Yeah, it always was for me - thanks for confirming.
> >>>>
> >>>>>> And the resulting host-model on a  rather old test server will the=
refore have:
> >>>>>>     <cpu mode=3D'custom' match=3D'exact' check=3D'full'>
> >>>>>>       <model fallback=3D'forbid'>Haswell-noTSX-IBRS</model>
> >>>>>>       <vendor>Intel</vendor>
> >>>>>>       <feature policy=3D'require' name=3D'vmx'/>
> >>>>>>       <feature policy=3D'disable' name=3D'pdcm'/>
> >>>>>>        ...
> >>>>>>
> >>>>>> But that was fine in the past, and the behavior started to break
> >>>>>> save/restore or migrations just now with the new qemu 10.1-rc.
> >>>>>>
> >>>>>> # Next steps
> >>>>>>
> >>>>>> I'm soon overwhelmed by meetings for the rest of the day, but woul=
d be
> >>>>>> curious if one has a suggestion about what to look at next for
> >>>>>> debugging or a theory about what might go wrong. If nothing else c=
omes
> >>>>>> up I'll try to set up a bisect run tomorrow.
> >>>>>
> >>>>> Yeah, git bisect is what I'd start with.
> >>>>
> >>>> Bisect complete, identified this commit
> >>>>
> >>>> commit 00268e00027459abede448662f8794d78eb4b0a4
> >>>> Author: Xiaoyao Li <xiaoyao.li@intel.com>
> >>>> Date:   Tue Mar 4 00:24:50 2025 -0500
> >>>>
> >>>>       i386/cpu: Warn about why CPUID_EXT_PDCM is not available
> >>>>
> >>>>       When user requests PDCM explicitly via "+pdcm" without PMU ena=
bled, emit
> >>>>       a warning to inform the user.
> >>>>
> >>>>       Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> >>>>       Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
> >>>>       Link: https://lore.kernel.org/r/20250304052450.465445-3-xiaoya=
o.li@intel.com
> >>>>       Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> >>>>
> >>>>    target/i386/cpu.c | 3 +++
> >>>>    1 file changed, 3 insertions(+)
> >>>>
> >>>>
> >>>>
> >>>> Which is odd as it should only add a warning right?
> >>>
> >>> No, that commit message is misleading.
> >>>
> >>> IIUC mark_unavailable_features() actively blocks usage of the feature=
,
> >>> so it is a functional change, not merely a emitting warning.
> >>>
> >>> It makes me wonder if that commit was actually intended to block the
> >>> feature or not, vs merely warning ?  CC'ing those involved in the
> >>> commit.
> >>
> >> The intention was to print a warning to tell users PDCM cannot be
> >> enabled if pmu is not enabled. While mark_unavailable_features() does
> >> has the effect of setting the bit in cpu->filtered_features[].
> >>
> >> But the feature is masked off anyway
> >
> > Right - it was disabled right from the beginning.
> > As I reported libvirt detected it as not available and constructed the
> > CPU as with it disabled.
> > Which translated it into -cpu ...,pdcm=3Doff,...
> >
> > The new and bad aspect we need to overcome is that in these conditions
> > this now somehow breaks save/restore and migration operations.
>
> The commit 00268e0002 makes a difference only for the case "-cpu
> xxx,pdcm=3Don" without "pmu=3Don", and it emits a warning and sets the PD=
CM
> in cpu->filtered_features[].

But this is `pdcm=3Doff` as I said above, yet with/without the change it
breaks the mentioned migration and save/restors.
But since you mentioned pmu, that isn't mentioned in the qemu cmdline
arguments that libvirt used and the base type is Haswell-noTSX-IBRS.

> So libvirt must first request with "-cpu xxx,pdcm=3Don" without "pmu=3Don=
"
> and gets the result that PDCM is filtered (set in cpu->filtered_features[=
]).
>
> This indeed introduces the behavior change that before the commit, "-cpu
> xxx,pdcm=3Don" without "pmu=3Don" doesn't get warning nor PDCM is set in
> cpu->filtered_features[], but PDCM is just not set in guest's CPUID.
>
> I couldn't understand how the warning or PDCM is set in
> cpu->filtered_features[] breaks save/restore and migration.
>
> > As a cross-check I reverted just and only 00268e0002 on top of
> > 10.1-rc2 and these use cases work again.
> >
> >> even without the
> >> mark_unavailable_features():
> >>
> >>       env->features[FEAT_1_ECX] &=3D ~CPUID_EXT_PDCM;
> >>
> >> So is it that PDCM is set in cpu->filtered_features[] causing the prob=
lem?
> >>
> >>> With regards,
> >>> Daniel
> >>
> >
> >
>


--=20
Christian Ehrhardt
Director of Engineering, Ubuntu Server
Canonical Ltd

