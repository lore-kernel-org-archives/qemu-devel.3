Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05292CA0EF5
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Aug 2025 05:12:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uob74-0007K6-1o; Wed, 20 Aug 2025 01:11:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christian.ehrhardt@canonical.com>)
 id 1uob6t-0007In-2A
 for qemu-devel@nongnu.org; Wed, 20 Aug 2025 01:11:43 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christian.ehrhardt@canonical.com>)
 id 1uob6q-0001MO-NB
 for qemu-devel@nongnu.org; Wed, 20 Aug 2025 01:11:42 -0400
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id B50C63F717
 for <qemu-devel@nongnu.org>; Wed, 20 Aug 2025 05:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1755666694;
 bh=QwTFEpm4P4dCmD9wR1yT5/c4y/9enMIXxCUes5ENVC4=;
 h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
 To:Cc:Content-Type;
 b=dCMzCKIt32c4GYd7z+dnpdT67Hjng2rydhqU3mKJEggpV2CHoRc3ZsRKem7JF8Td9
 emTxqFYxQKdU8FvxV4zNIVPwOnSsacDz+OZQq5t8FZue00MDX/x1XxUf4ZSvBcas2h
 eaLBpn5jL35joX5jlrWkmdp7I290e5qETx6zG7WyXE7kZUadaohyFC2xDUCLXK3UJw
 joboXknpE1ZwjU+EK6SIFfG/mdAV4Gw7XHZlS/COxzJZlGH586cw7FiUqKTZgJztFT
 D/IsFhxoxfaS08iHqAmJ5m2cuNvZpcYw+zGJkzLd7XqVUdcGY9pZkrOL2ae5tYR4wJ
 3MJ9nTGCEzVZA==
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-618b3c750baso4470593a12.1
 for <qemu-devel@nongnu.org>; Tue, 19 Aug 2025 22:11:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755666694; x=1756271494;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QwTFEpm4P4dCmD9wR1yT5/c4y/9enMIXxCUes5ENVC4=;
 b=PRROqFiyLupviQHUajQh2Ne6Zs0JHIDgsje2B6l5UzuMw5Oe7d7/aCUCtkytMuvXc/
 kHb1oJH0vLbBDN0EXk1K/nImXSz4YXw2gxG75R5qBdgF1b3te31uo6PJI/r0XJ04Z6mB
 Hrk3L3bbvdUct7AmpgHC4JvPfui1avUQ/e8lO7CsQiMLSQQKBnMAdVzo2MhlHvrMMHEy
 om78GJVxUSc/6pbUu/7NrSlzKnPS9A41Kx+hqzgWtSKIXCCVS2DisGM2IzdK5tv4YS+I
 fI7rHQE7Xe0TR8Y+2Snyz6HzbJb6LGZB/7ZNzg30S6ONbLt+x3QWPGvpxH+dGqT5/JOJ
 TWtw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNSYUdgBBvfTFdidaomX8b907FmyP2srkWf1cdkn/o59MmbbBvyF8uFXmpF0yNatH7cq9By5pE2vI3@nongnu.org
X-Gm-Message-State: AOJu0Yw9OdxK+YkoLq2M/9JempHholCtEE1jd5g3HG+Y/2sBTL0zRXZH
 PYKT3zXV7zw8M+sU0gMAarkd3Z1lubzYc9wX+Qm7N547rV8ENgRLpatOKIr1F3ViL1cz3MLiPcF
 cre2aHBJVlv/tQPvpUnAeUug6eJXdBOtMlDrTvVYXQQC7p16aid6VpkSv9tr+zOXwKSzOOD8M/H
 n41xEUKfllrQ6zTipEKfQXzn2bZ2Wo6T++rMmwlsxZ+cuaKME=
X-Gm-Gg: ASbGnct1ziG4+X/Bq2ZHtUNbYjC7TIKJMF6noHTbjlkSD3323nlmCzF1plaGr9G1mMl
 jrpsHRJJnD1UeCa6zWfbTTfouVFG5Qg2PDb5/Cdpr30k0hr8G1+833mg1MhuNFviP0lcjl40d4p
 EI0tj7kp7VC59Uu6xFSVM0
X-Received: by 2002:a05:6402:27ce:b0:612:bd30:d326 with SMTP id
 4fb4d7f45d1cf-61a976285a5mr1218330a12.22.1755666694180; 
 Tue, 19 Aug 2025 22:11:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGRdRiG9OJr8Ar2767yiqw2hcEAHZiJ3JLlUAf2lbIOPD1RvsElgDnP43/4jFeFjPpTkn52MBMF7Re9axRg03o=
X-Received: by 2002:a05:6402:27ce:b0:612:bd30:d326 with SMTP id
 4fb4d7f45d1cf-61a976285a5mr1218315a12.22.1755666693734; Tue, 19 Aug 2025
 22:11:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAATJJ0+Qq3ksRmNRDrGQLVHQ=XnsnFHxCNxUhjJfNfgwUKkDPQ@mail.gmail.com>
 <aJNDxxjeqkOLAO2r@redhat.com>
 <CAATJJ0L-E=JsKOX_E=jqraeK__jLF851DDbEx5psVkTMSppKXw@mail.gmail.com>
 <aJOqmxTimJ_mFCqp@redhat.com>
 <ccabd72c-6f48-4be2-8bbd-44f28eb2cfd1@redhat.com>
In-Reply-To: <ccabd72c-6f48-4be2-8bbd-44f28eb2cfd1@redhat.com>
From: Christian Ehrhardt <christian.ehrhardt@canonical.com>
Date: Wed, 20 Aug 2025 07:11:07 +0200
X-Gm-Features: Ac12FXzoef3wnW5LXqOK3Nr3rz_Dvnut5kgqtjidsWqho30l3xvDWV7FrFEE9-Q
Message-ID: <CAATJJ0KZDHqMHmpmfFySJjreqPMTHDiJLJM_zBdcr5CrzOL2tg@mail.gmail.com>
Subject: Re: Issues with pdcm in qemu 10.1-rc on migration and save/restore
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Xiaoyao Li <xiaoyao.li@intel.com>, Zhao Liu <zhao1.liu@intel.com>, 
 qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=185.125.188.123;
 envelope-from=christian.ehrhardt@canonical.com;
 helo=smtp-relay-internal-1.canonical.com
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

On Tue, Aug 19, 2025 at 4:51=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
>
> On 8/6/25 21:18, Daniel P. Berrang=C3=A9 wrote:
> > On Wed, Aug 06, 2025 at 07:57:34PM +0200, Christian Ehrhardt wrote:
> >> On Wed, Aug 6, 2025 at 2:00=E2=80=AFPM Daniel P. Berrang=C3=A9 <berran=
ge@redhat.com> wrote:
> >>>
> >>> On Wed, Aug 06, 2025 at 01:52:17PM +0200, Christian Ehrhardt wrote:
> >>>> Hi,
> >>>> I was unsure if this would be better sent to libvirt or qemu - the
> >>>> issue is somewhere between libvirt modelling CPUs and qemu 10.1
> >>>> behaving differently. I did not want to double post and gladly most =
of
> >>>> the people are on both lists - since the switch in/out of the proble=
m
> >>>> is qemu 10.0 <-> 10.1 let me start here. I beg your pardon for not y=
et
> >>>> having all the answers, I'm sure I could find more with debugging, b=
ut
> >>>> I also wanted to report early for your awareness while we are still =
in
> >>>> the RC phase.
> >>>>
> >>>>
> >>>> # Problem
> >>>>
> >>>> What I found when testing migrations in Ubuntu with qemu 10.1-rc1 wa=
s:
> >>>>    error: operation failed: guest CPU doesn't match specification:
> >>>> missing features: pdcm
> >>>>
> >>>> This is behaving the same with libvirt 11.4 or the more recent 11.6.
> >>>> But switching back to qemu 10.0 confirmed that this behavior is new
> >>>> with qemu 10.1-rc.
> >>>
> >>>
> >>>> Without yet having any hard evidence against them I found a few pdcm
> >>>> related commits between 10.0 and 10.1-rc1:
> >>>>    7ff24fb65 i386/tdx: Don't mask off CPUID_EXT_PDCM
> >>>>    00268e000 i386/cpu: Warn about why CPUID_EXT_PDCM is not availabl=
e
> >>>>    e68ec2980 i386/cpu: Move adjustment of CPUID_EXT_PDCM before
> >>>> feature_dependencies[] check
> >>>>    0ba06e46d i386/tdx: Add TDX fixed1 bits to supported CPUIDs
> >>>>
> >>>>
> >>>> # Caveat
> >>>>
> >>>> My test environment is in LXD system containers, that gives me issue=
s
> >>>> in the power management detection
> >>>>    libvirtd[406]: error from service: GDBus.Error:System.Error.EROFS=
:
> >>>> Read-only file system
> >>>>    libvirtd[406]: Failed to get host power management capabilities
> >>>
> >>> That's harmless.
> >>
> >> Yeah, it always was for me - thanks for confirming.
> >>
> >>>> And the resulting host-model on a  rather old test server will there=
fore have:
> >>>>    <cpu mode=3D'custom' match=3D'exact' check=3D'full'>
> >>>>      <model fallback=3D'forbid'>Haswell-noTSX-IBRS</model>
> >>>>      <vendor>Intel</vendor>
> >>>>      <feature policy=3D'require' name=3D'vmx'/>
> >>>>      <feature policy=3D'disable' name=3D'pdcm'/>
> >>>>       ...
> >>>>
> >>>> But that was fine in the past, and the behavior started to break
> >>>> save/restore or migrations just now with the new qemu 10.1-rc.
> >>>>
> >>>> # Next steps
> >>>>
> >>>> I'm soon overwhelmed by meetings for the rest of the day, but would =
be
> >>>> curious if one has a suggestion about what to look at next for
> >>>> debugging or a theory about what might go wrong. If nothing else com=
es
> >>>> up I'll try to set up a bisect run tomorrow.
> >>>
> >>> Yeah, git bisect is what I'd start with.
> >>
> >> Bisect complete, identified this commit
> >>
> >> commit 00268e00027459abede448662f8794d78eb4b0a4
> >> Author: Xiaoyao Li <xiaoyao.li@intel.com>
> >> Date:   Tue Mar 4 00:24:50 2025 -0500
> >>
> >>      i386/cpu: Warn about why CPUID_EXT_PDCM is not available
> >>
> >>      When user requests PDCM explicitly via "+pdcm" without PMU enable=
d, emit
> >>      a warning to inform the user.
> >>
> >>      Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> >>      Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
> >>      Link: https://lore.kernel.org/r/20250304052450.465445-3-xiaoyao.l=
i@intel.com
> >>      Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> >>
> >>   target/i386/cpu.c | 3 +++
> >>   1 file changed, 3 insertions(+)
> >>
> >>
> >>
> >> Which is odd as it should only add a warning right?
> >
> > No, that commit message is misleading.
> >
> > IIUC mark_unavailable_features() actively blocks usage of the feature,
> > so it is a functional change, not merely a emitting warning.
> >
> > It makes me wonder if that commit was actually intended to block the
> > feature or not, vs merely warning ?  CC'ing those involved in the
> > commit.
> We can revert the commit.  I'll send the revert to Stefan and let him
> decide whether to include it in 10.1-rc4 or delay to 10.2 and 10.1.1.

Thanks Paolo for considering that.

My steps to reproduce seemed really clear and are 100% reproducible
for me, but no one so far said "yeah they see it too", so I'm getting
unsure if it was not tried by anyone else or if there is more to it
than we yet know.
Further I tested more with the commit reverted, and found that at
least cross version migrations (9.2 -> 10.1) still have issues that
seem related - complaining about pdcm as missing feature.
But that was in a log of a test system that went away and ... you know
how these things can sometimes be, that new result is not yet very
reliable.

I intended to check the following matrix more deeply again with and
without the reverted change and then come back to this thread:

#1 Compare platforms
- Migrating between non containerized hosts to verify if they are
affected as well
- Power management explicitly switched off/on (vs the auto detect of
host-model) in the guest XML
#2 Retest the different Use-cases I've seen this pop up
- 10.1 managed save (broken unless reverting the commit that was identified=
)
- 9.2 -> 10.1 migration (seems broken even with the revert)

The hope was that these will help to further identify what is going
on, but despite the urgency of the release being imminent I have not
yet managed to find the time in the last two days :-/

> Sorry for the delay in answering (and thanks Daniel for bringing this to
> my attention).
>
> Thanks,
>
> Paolo
>


--=20
Christian Ehrhardt
Director of Engineering, Ubuntu Server
Canonical Ltd

