Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67A54CA1015
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Sep 2025 14:38:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uuB4o-0003oz-45; Thu, 04 Sep 2025 10:36:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hector.cao@canonical.com>)
 id 1uuB4g-0003mL-8D
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 10:36:30 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hector.cao@canonical.com>)
 id 1uuB4Z-0007iX-4L
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 10:36:29 -0400
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id F24EE3F7BC
 for <qemu-devel@nongnu.org>; Thu,  4 Sep 2025 14:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1756996573;
 bh=Kr7b+CTEQi9rXf075z3S8PjfHZKY1Q5DMa/+EARVhRE=;
 h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
 To:Cc:Content-Type;
 b=L9olHm2RxrXjaZ/vEFZl0sln+Iq3karMTVBdZksylkTKNW5izIZnzHHKKR86tuCS2
 j9QhYh0LGlLYj4gTcJvxgiglOgFNMNQrtwucXgC6y7jY+S/HucR7k2DTWkptx5dJtE
 SgmB5aE0QFwKC/x+xagq5e52kifQACTCsl9cph6BXCNsQNdGajuD7mO/zug3TQgm11
 FpHs1tbtOAz/NH8H7xfFNQbdFam1owmDcwInKGj10M3YXkclvB8vOGYZMvEOGmy6du
 GEd1ewC0BOA0/mpV+EjuauRylWDhMXIsvGQooz3KjOxKha1jKtqyaYEzVvujQ7bP73
 KE3yshznSV7KA==
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-61d2adb3258so1066938a12.0
 for <qemu-devel@nongnu.org>; Thu, 04 Sep 2025 07:36:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756996571; x=1757601371;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Kr7b+CTEQi9rXf075z3S8PjfHZKY1Q5DMa/+EARVhRE=;
 b=TgVxFbVctpqXdL6ajESOky66EFH0l4edlWddp0+TdF9e0mOaDtjn1eyAUEx8/FFRZA
 EGhK/tudXfOq4NIFscwtobdeYwFImzRCwgzz1WbbPFVu4NBmsOa/ygSIzCbyOOlSPd9n
 ZMxTU6ek57MIb0u76gryL01/zs+UtwHFEUuxyxP7OhM+Lr+hjyjhBPIP03OcT2pThgRS
 dZ8oUZapKv++E7k/lMTAkF1sCjmcGBzfjJyUqB2N8AtqZZNNjro6udCffKxFFcrnEcF0
 ERVqYnwPOnEOgg06BCyjMlIdgmHZYYG7uX6GtbG2UVopI0gyuCFFLfKVVUjhHw+pU+zV
 Tj8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8ka57HPHx0mpyDjqnhaZTHP4b7Ox4k8UWjXqvH2GXmfPxjfavLSe1DbYGiEHHzurdVkHjphxSqBnK@nongnu.org
X-Gm-Message-State: AOJu0YwPzoE3VYxoRyN4jq6oV/FSPlCK3Ju9dRY+eU8ChLSWwNzZaV4c
 gf5qG3R9AsrTPB5wwF7eD+0fIsQGXmH0QjkdzilB0vUEd9cljLJJxMN8Rt/R7DSoRCOnI/0xCwB
 e6jgsVXlbJo0vW5Azg45C7zo4aLNuA8UgrDoddCq1aMMzygPRZBZnCh6In9fC44bhuGgFKtJg+3
 08oLD1wO6vYOwTjwv+Z+MbBT9x4FxvQ8YCuxFcyjVFO29R8H0=
X-Gm-Gg: ASbGncvRFHPCL9guAhx3weXSN9pKdlHDODOnRU+xjwlpO+2o3jFbIrjwqchrb1sQUU+
 sfL8Zx7dhegIjzwAt6zEoTwnxTQFRg9Hi3uXkpJjPae8KshYN+mZ8GS+7p4ZrhCB2USDd3XAPpk
 YTwUyA14HAGwSnG4Hfertdv+K8INd8lcTFMlT/1ENj
X-Received: by 2002:a05:6402:2693:b0:61c:6fc9:daa with SMTP id
 4fb4d7f45d1cf-61d26d84b23mr15331129a12.20.1756996570539; 
 Thu, 04 Sep 2025 07:36:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQNUmyEc0VDtW0a591G9WEEtYJZhvlnAqVfPXYOFgXePArvu3TlES6aCivpgFX1cWeD+0EHRB8nwcHtk8CtbM=
X-Received: by 2002:a05:6402:2693:b0:61c:6fc9:daa with SMTP id
 4fb4d7f45d1cf-61d26d84b23mr15331094a12.20.1756996570027; Thu, 04 Sep 2025
 07:36:10 -0700 (PDT)
MIME-Version: 1.0
References: <CAATJJ0+Qq3ksRmNRDrGQLVHQ=XnsnFHxCNxUhjJfNfgwUKkDPQ@mail.gmail.com>
 <aJNDxxjeqkOLAO2r@redhat.com>
 <CAATJJ0L-E=JsKOX_E=jqraeK__jLF851DDbEx5psVkTMSppKXw@mail.gmail.com>
 <aJOqmxTimJ_mFCqp@redhat.com>
 <ccabd72c-6f48-4be2-8bbd-44f28eb2cfd1@redhat.com>
 <CAATJJ0KZDHqMHmpmfFySJjreqPMTHDiJLJM_zBdcr5CrzOL2tg@mail.gmail.com>
 <CAATJJ0Kz7Sdv-Dq0r0pGBXYgZbTbaC0fSQiVXoQides4pF=zXg@mail.gmail.com>
In-Reply-To: <CAATJJ0Kz7Sdv-Dq0r0pGBXYgZbTbaC0fSQiVXoQides4pF=zXg@mail.gmail.com>
From: Hector Cao <hector.cao@canonical.com>
Date: Thu, 4 Sep 2025 16:35:58 +0200
X-Gm-Features: Ac12FXxyqsPnjgDpLJwfAZ7JcyPOOHTGeDT--7gv7P4pJ9dHEGLUwHMCEAW-9-E
Message-ID: <CABjvBV7wgfSv-OjGf_L2t9ranXfzTQTSBdRAFODpHH-nFcLFig@mail.gmail.com>
Subject: Re: Issues with pdcm in qemu 10.1-rc on migration and save/restore
To: Christian Ehrhardt <christian.ehrhardt@canonical.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Xiaoyao Li <xiaoyao.li@intel.com>, Zhao Liu <zhao1.liu@intel.com>, 
 qemu-devel <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="0000000000006dacbd063dfaa446"
Received-SPF: pass client-ip=185.125.188.123;
 envelope-from=hector.cao@canonical.com;
 helo=smtp-relay-internal-1.canonical.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_REMOTE_IMAGE=0.01 autolearn=ham autolearn_force=no
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

--0000000000006dacbd063dfaa446
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

In addition to my previous mail describing the issue on different
Ubuntu releases,

I went further by testing directly qemu upstream at HEAD
(baa79455fa92984ff0f4b9ae94bed66823177a27)

As the start version for the migration, I take quite recent release
v10.0.x to make the version gap smaller.

I can reproduce the following migration failures:

v10.0.2 -> HEAD:
error: operation failed: guest CPU doesn't match specification:
missing features: pdcm,arch-capabilities

v10.0.3 -> HEAD:
error: operation failed: guest CPU doesn't match specification:
missing features: pdcm
The error arch-capabilities is no longer present because v10.0.3 also
has [2] like HEAD.

If I revert the two commits [1] and [2] in HEAD, the migration works fine:

v10.0.2 -> HEAD (+reverts):
OK

[1] Revert "i386/cpu: Move adjustment of CPUID_EXT_PDCM before
feature_dependencies[] check"
    This reverts commit e68ec2980901c8e7f948f3305770962806c53f0b.

[2] Revert "target/i386: do not expose ARCH_CAPABILITIES on AMD CPU"
    This reverts commit d3a24134e37d57abd3e7445842cda2717f49e96d.

Since this issue is blocking us for the Ubuntu 25.10 release, can you
please provide
feedback on the best path going forward ?


On Wed, Sep 3, 2025 at 10:38=E2=80=AFAM Christian Ehrhardt <
christian.ehrhardt@canonical.com> wrote:

> On Wed, Aug 20, 2025 at 7:11=E2=80=AFAM Christian Ehrhardt
> <christian.ehrhardt@canonical.com> wrote:
> >
> > On Tue, Aug 19, 2025 at 4:51=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.=
com>
> wrote:
> > >
> > > On 8/6/25 21:18, Daniel P. Berrang=C3=A9 wrote:
> > > > On Wed, Aug 06, 2025 at 07:57:34PM +0200, Christian Ehrhardt wrote:
> > > >> On Wed, Aug 6, 2025 at 2:00=E2=80=AFPM Daniel P. Berrang=C3=A9 <
> berrange@redhat.com> wrote:
> > > >>>
> > > >>> On Wed, Aug 06, 2025 at 01:52:17PM +0200, Christian Ehrhardt wrot=
e:
> > > >>>> Hi,
> > > >>>> I was unsure if this would be better sent to libvirt or qemu - t=
he
> > > >>>> issue is somewhere between libvirt modelling CPUs and qemu 10.1
> > > >>>> behaving differently. I did not want to double post and gladly
> most of
> > > >>>> the people are on both lists - since the switch in/out of the
> problem
> > > >>>> is qemu 10.0 <-> 10.1 let me start here. I beg your pardon for
> not yet
> > > >>>> having all the answers, I'm sure I could find more with
> debugging, but
> > > >>>> I also wanted to report early for your awareness while we are
> still in
> > > >>>> the RC phase.
> > > >>>>
> > > >>>>
> > > >>>> # Problem
> > > >>>>
> > > >>>> What I found when testing migrations in Ubuntu with qemu 10.1-rc=
1
> was:
> > > >>>>    error: operation failed: guest CPU doesn't match specificatio=
n:
> > > >>>> missing features: pdcm
> > > >>>>
> > > >>>> This is behaving the same with libvirt 11.4 or the more recent
> 11.6.
> > > >>>> But switching back to qemu 10.0 confirmed that this behavior is
> new
> > > >>>> with qemu 10.1-rc.
> > > >>>
> > > >>>
> > > >>>> Without yet having any hard evidence against them I found a few
> pdcm
> > > >>>> related commits between 10.0 and 10.1-rc1:
> > > >>>>    7ff24fb65 i386/tdx: Don't mask off CPUID_EXT_PDCM
> > > >>>>    00268e000 i386/cpu: Warn about why CPUID_EXT_PDCM is not
> available
> > > >>>>    e68ec2980 i386/cpu: Move adjustment of CPUID_EXT_PDCM before
> > > >>>> feature_dependencies[] check
> > > >>>>    0ba06e46d i386/tdx: Add TDX fixed1 bits to supported CPUIDs
> > > >>>>
> > > >>>>
> > > >>>> # Caveat
> > > >>>>
> > > >>>> My test environment is in LXD system containers, that gives me
> issues
> > > >>>> in the power management detection
> > > >>>>    libvirtd[406]: error from service:
> GDBus.Error:System.Error.EROFS:
> > > >>>> Read-only file system
> > > >>>>    libvirtd[406]: Failed to get host power management capabiliti=
es
> > > >>>
> > > >>> That's harmless.
> > > >>
> > > >> Yeah, it always was for me - thanks for confirming.
> > > >>
> > > >>>> And the resulting host-model on a  rather old test server will
> therefore have:
> > > >>>>    <cpu mode=3D'custom' match=3D'exact' check=3D'full'>
> > > >>>>      <model fallback=3D'forbid'>Haswell-noTSX-IBRS</model>
> > > >>>>      <vendor>Intel</vendor>
> > > >>>>      <feature policy=3D'require' name=3D'vmx'/>
> > > >>>>      <feature policy=3D'disable' name=3D'pdcm'/>
> > > >>>>       ...
> > > >>>>
> > > >>>> But that was fine in the past, and the behavior started to break
> > > >>>> save/restore or migrations just now with the new qemu 10.1-rc.
> > > >>>>
> > > >>>> # Next steps
> > > >>>>
> > > >>>> I'm soon overwhelmed by meetings for the rest of the day, but
> would be
> > > >>>> curious if one has a suggestion about what to look at next for
> > > >>>> debugging or a theory about what might go wrong. If nothing else
> comes
> > > >>>> up I'll try to set up a bisect run tomorrow.
> > > >>>
> > > >>> Yeah, git bisect is what I'd start with.
> > > >>
> > > >> Bisect complete, identified this commit
> > > >>
> > > >> commit 00268e00027459abede448662f8794d78eb4b0a4
> > > >> Author: Xiaoyao Li <xiaoyao.li@intel.com>
> > > >> Date:   Tue Mar 4 00:24:50 2025 -0500
> > > >>
> > > >>      i386/cpu: Warn about why CPUID_EXT_PDCM is not available
> > > >>
> > > >>      When user requests PDCM explicitly via "+pdcm" without PMU
> enabled, emit
> > > >>      a warning to inform the user.
> > > >>
> > > >>      Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> > > >>      Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
> > > >>      Link:
> https://lore.kernel.org/r/20250304052450.465445-3-xiaoyao.li@intel.com
> > > >>      Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > > >>
> > > >>   target/i386/cpu.c | 3 +++
> > > >>   1 file changed, 3 insertions(+)
> > > >>
> > > >>
> > > >>
> > > >> Which is odd as it should only add a warning right?
> > > >
> > > > No, that commit message is misleading.
> > > >
> > > > IIUC mark_unavailable_features() actively blocks usage of the
> feature,
> > > > so it is a functional change, not merely a emitting warning.
> > > >
> > > > It makes me wonder if that commit was actually intended to block th=
e
> > > > feature or not, vs merely warning ?  CC'ing those involved in the
> > > > commit.
> > > We can revert the commit.  I'll send the revert to Stefan and let him
> > > decide whether to include it in 10.1-rc4 or delay to 10.2 and 10.1.1.
> >
> > Thanks Paolo for considering that.
> >
> > My steps to reproduce seemed really clear and are 100% reproducible
> > for me, but no one so far said "yeah they see it too", so I'm getting
> > unsure if it was not tried by anyone else or if there is more to it
> > than we yet know.
> > Further I tested more with the commit reverted, and found that at
> > least cross version migrations (9.2 -> 10.1) still have issues that
> > seem related - complaining about pdcm as missing feature.
> > But that was in a log of a test system that went away and ... you know
> > how these things can sometimes be, that new result is not yet very
> > reliable.
> >
> > I intended to check the following matrix more deeply again with and
> > without the reverted change and then come back to this thread:
> >
> > #1 Compare platforms
> > - Migrating between non containerized hosts to verify if they are
> > affected as well
> > - Power management explicitly switched off/on (vs the auto detect of
> > host-model) in the guest XML
> > #2 Retest the different Use-cases I've seen this pop up
> > - 10.1 managed save (broken unless reverting the commit that was
> identified)
> > - 9.2 -> 10.1 migration (seems broken even with the revert)
>
> I need to come back to this aspect of it - the cross release or cross
> qemu version migrations.
>
> Hector (on CC) helps me on that now - sadly we were able to confirm
> that migrations from older qemu versions no longer work.
> Yep 10.1 is released by now so it might end up as "The problem is what
> happens when we detect after we have done a release that something has
> gone wrong" from [2].
> But I still can't believe only we see this and therefore for now want
> to believe I messed up on our side when merging 10.1 :-)
>
> For now this is a call if others have also seen any older release
> migrating to 10.1 to throw:
>   error: operation failed: guest CPU doesn't match specification:
> missing features: pdcm,arch-capabilities
>
> Hector will later today reply here with a summary of what we found so
> far, to provide you a more complete picture to think about, without
> having to read through all the messy interim steps in the Ubuntu bug.
>
> [1]: https://bugs.launchpad.net/ubuntu/+source/qemu/+bug/2121787
> [2]:
> https://gitlab.com/qemu-project/qemu/-/blob/master/docs/devel/migration/c=
ompatibility.rst?plain=3D1#L322
>
> > The hope was that these will help to further identify what is going
> > on, but despite the urgency of the release being imminent I have not
> > yet managed to find the time in the last two days :-/
> >
> > > Sorry for the delay in answering (and thanks Daniel for bringing this
> to
> > > my attention).
> > >
> > > Thanks,
> > >
> > > Paolo
> > >
> >
> >
> > --
> > Christian Ehrhardt
> > Director of Engineering, Ubuntu Server
> > Canonical Ltd
>
>
>
> --
> Christian Ehrhardt
> Director of Engineering, Ubuntu Server
> Canonical Ltd
>


--=20
Hector CAO
Software Engineer =E2=80=93 Partner Engineering Team
hector.cao@canonical.com
https://launc <https://launchpad.net/~hectorcao>hpad.net/~hectorcao
<https://launchpad.net/~hectorcao>

<https://launchpad.net/~hectorcao>

--0000000000006dacbd063dfaa446
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><pre style=3D"color:rgb(0,0,0)">Hello,
<br></pre><pre style=3D"color:rgb(0,0,0)">In addition to my previous mail d=
escribing the issue on different Ubuntu releases,</pre><pre style=3D"color:=
rgb(0,0,0)">I went further by testing directly qemu upstream at HEAD (baa79=
455fa92984ff0f4b9ae94bed66823177a27)

As the start version for the migration, I take quite recent release v10.0.x=
 to make the version gap smaller.

I can reproduce the following migration failures:

v10.0.2 -&gt; HEAD:
error: operation failed: guest CPU doesn&#39;t match specification: missing=
 features: pdcm,arch-capabilities

v10.0.3 -&gt; HEAD:
error: operation failed: guest CPU doesn&#39;t match specification: missing=
 features: pdcm
The error arch-capabilities is no longer present because v10.0.3 also has [=
2] like HEAD.

If I revert the two commits [1] and [2] in HEAD, the migration works fine:

v10.0.2 -&gt; HEAD (+reverts):
OK

[1] Revert &quot;i386/cpu: Move adjustment of CPUID_EXT_PDCM before feature=
_dependencies[] check&quot;
    This reverts commit e68ec2980901c8e7f948f3305770962806c53f0b.

[2] Revert &quot;target/i386: do not expose ARCH_CAPABILITIES on AMD CPU&qu=
ot;
    This reverts commit d3a24134e37d57abd3e7445842cda2717f49e96d.

Since this issue is blocking us for the Ubuntu 25.10 release, can you pleas=
e provide
feedback on the best path going forward ?</pre></div><br><div class=3D"gmai=
l_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed=
, Sep 3, 2025 at 10:38=E2=80=AFAM Christian Ehrhardt &lt;<a href=3D"mailto:=
christian.ehrhardt@canonical.com">christian.ehrhardt@canonical.com</a>&gt; =
wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Wed, A=
ug 20, 2025 at 7:11=E2=80=AFAM Christian Ehrhardt<br>
&lt;<a href=3D"mailto:christian.ehrhardt@canonical.com" target=3D"_blank">c=
hristian.ehrhardt@canonical.com</a>&gt; wrote:<br>
&gt;<br>
&gt; On Tue, Aug 19, 2025 at 4:51=E2=80=AFPM Paolo Bonzini &lt;<a href=3D"m=
ailto:pbonzini@redhat.com" target=3D"_blank">pbonzini@redhat.com</a>&gt; wr=
ote:<br>
&gt; &gt;<br>
&gt; &gt; On 8/6/25 21:18, Daniel P. Berrang=C3=A9 wrote:<br>
&gt; &gt; &gt; On Wed, Aug 06, 2025 at 07:57:34PM +0200, Christian Ehrhardt=
 wrote:<br>
&gt; &gt; &gt;&gt; On Wed, Aug 6, 2025 at 2:00=E2=80=AFPM Daniel P. Berrang=
=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.com" target=3D"_blank">berrang=
e@redhat.com</a>&gt; wrote:<br>
&gt; &gt; &gt;&gt;&gt;<br>
&gt; &gt; &gt;&gt;&gt; On Wed, Aug 06, 2025 at 01:52:17PM +0200, Christian =
Ehrhardt wrote:<br>
&gt; &gt; &gt;&gt;&gt;&gt; Hi,<br>
&gt; &gt; &gt;&gt;&gt;&gt; I was unsure if this would be better sent to lib=
virt or qemu - the<br>
&gt; &gt; &gt;&gt;&gt;&gt; issue is somewhere between libvirt modelling CPU=
s and qemu 10.1<br>
&gt; &gt; &gt;&gt;&gt;&gt; behaving differently. I did not want to double p=
ost and gladly most of<br>
&gt; &gt; &gt;&gt;&gt;&gt; the people are on both lists - since the switch =
in/out of the problem<br>
&gt; &gt; &gt;&gt;&gt;&gt; is qemu 10.0 &lt;-&gt; 10.1 let me start here. I=
 beg your pardon for not yet<br>
&gt; &gt; &gt;&gt;&gt;&gt; having all the answers, I&#39;m sure I could fin=
d more with debugging, but<br>
&gt; &gt; &gt;&gt;&gt;&gt; I also wanted to report early for your awareness=
 while we are still in<br>
&gt; &gt; &gt;&gt;&gt;&gt; the RC phase.<br>
&gt; &gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt; &gt;&gt;&gt;&gt; # Problem<br>
&gt; &gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt; &gt;&gt;&gt;&gt; What I found when testing migrations in Ubuntu w=
ith qemu 10.1-rc1 was:<br>
&gt; &gt; &gt;&gt;&gt;&gt;=C2=A0 =C2=A0 error: operation failed: guest CPU =
doesn&#39;t match specification:<br>
&gt; &gt; &gt;&gt;&gt;&gt; missing features: pdcm<br>
&gt; &gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt; &gt;&gt;&gt;&gt; This is behaving the same with libvirt 11.4 or t=
he more recent 11.6.<br>
&gt; &gt; &gt;&gt;&gt;&gt; But switching back to qemu 10.0 confirmed that t=
his behavior is new<br>
&gt; &gt; &gt;&gt;&gt;&gt; with qemu 10.1-rc.<br>
&gt; &gt; &gt;&gt;&gt;<br>
&gt; &gt; &gt;&gt;&gt;<br>
&gt; &gt; &gt;&gt;&gt;&gt; Without yet having any hard evidence against the=
m I found a few pdcm<br>
&gt; &gt; &gt;&gt;&gt;&gt; related commits between 10.0 and 10.1-rc1:<br>
&gt; &gt; &gt;&gt;&gt;&gt;=C2=A0 =C2=A0 7ff24fb65 i386/tdx: Don&#39;t mask =
off CPUID_EXT_PDCM<br>
&gt; &gt; &gt;&gt;&gt;&gt;=C2=A0 =C2=A0 00268e000 i386/cpu: Warn about why =
CPUID_EXT_PDCM is not available<br>
&gt; &gt; &gt;&gt;&gt;&gt;=C2=A0 =C2=A0 e68ec2980 i386/cpu: Move adjustment=
 of CPUID_EXT_PDCM before<br>
&gt; &gt; &gt;&gt;&gt;&gt; feature_dependencies[] check<br>
&gt; &gt; &gt;&gt;&gt;&gt;=C2=A0 =C2=A0 0ba06e46d i386/tdx: Add TDX fixed1 =
bits to supported CPUIDs<br>
&gt; &gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt; &gt;&gt;&gt;&gt; # Caveat<br>
&gt; &gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt; &gt;&gt;&gt;&gt; My test environment is in LXD system containers,=
 that gives me issues<br>
&gt; &gt; &gt;&gt;&gt;&gt; in the power management detection<br>
&gt; &gt; &gt;&gt;&gt;&gt;=C2=A0 =C2=A0 libvirtd[406]: error from service: =
GDBus.Error:System.Error.EROFS:<br>
&gt; &gt; &gt;&gt;&gt;&gt; Read-only file system<br>
&gt; &gt; &gt;&gt;&gt;&gt;=C2=A0 =C2=A0 libvirtd[406]: Failed to get host p=
ower management capabilities<br>
&gt; &gt; &gt;&gt;&gt;<br>
&gt; &gt; &gt;&gt;&gt; That&#39;s harmless.<br>
&gt; &gt; &gt;&gt;<br>
&gt; &gt; &gt;&gt; Yeah, it always was for me - thanks for confirming.<br>
&gt; &gt; &gt;&gt;<br>
&gt; &gt; &gt;&gt;&gt;&gt; And the resulting host-model on a=C2=A0 rather o=
ld test server will therefore have:<br>
&gt; &gt; &gt;&gt;&gt;&gt;=C2=A0 =C2=A0 &lt;cpu mode=3D&#39;custom&#39; mat=
ch=3D&#39;exact&#39; check=3D&#39;full&#39;&gt;<br>
&gt; &gt; &gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &lt;model fallback=3D&#39;fo=
rbid&#39;&gt;Haswell-noTSX-IBRS&lt;/model&gt;<br>
&gt; &gt; &gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &lt;vendor&gt;Intel&lt;/vend=
or&gt;<br>
&gt; &gt; &gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &lt;feature policy=3D&#39;re=
quire&#39; name=3D&#39;vmx&#39;/&gt;<br>
&gt; &gt; &gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &lt;feature policy=3D&#39;di=
sable&#39; name=3D&#39;pdcm&#39;/&gt;<br>
&gt; &gt; &gt;&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0...<br>
&gt; &gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt; &gt;&gt;&gt;&gt; But that was fine in the past, and the behavior =
started to break<br>
&gt; &gt; &gt;&gt;&gt;&gt; save/restore or migrations just now with the new=
 qemu 10.1-rc.<br>
&gt; &gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt; &gt;&gt;&gt;&gt; # Next steps<br>
&gt; &gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt; &gt;&gt;&gt;&gt; I&#39;m soon overwhelmed by meetings for the res=
t of the day, but would be<br>
&gt; &gt; &gt;&gt;&gt;&gt; curious if one has a suggestion about what to lo=
ok at next for<br>
&gt; &gt; &gt;&gt;&gt;&gt; debugging or a theory about what might go wrong.=
 If nothing else comes<br>
&gt; &gt; &gt;&gt;&gt;&gt; up I&#39;ll try to set up a bisect run tomorrow.=
<br>
&gt; &gt; &gt;&gt;&gt;<br>
&gt; &gt; &gt;&gt;&gt; Yeah, git bisect is what I&#39;d start with.<br>
&gt; &gt; &gt;&gt;<br>
&gt; &gt; &gt;&gt; Bisect complete, identified this commit<br>
&gt; &gt; &gt;&gt;<br>
&gt; &gt; &gt;&gt; commit 00268e00027459abede448662f8794d78eb4b0a4<br>
&gt; &gt; &gt;&gt; Author: Xiaoyao Li &lt;<a href=3D"mailto:xiaoyao.li@inte=
l.com" target=3D"_blank">xiaoyao.li@intel.com</a>&gt;<br>
&gt; &gt; &gt;&gt; Date:=C2=A0 =C2=A0Tue Mar 4 00:24:50 2025 -0500<br>
&gt; &gt; &gt;&gt;<br>
&gt; &gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 i386/cpu: Warn about why CPUID_EXT_P=
DCM is not available<br>
&gt; &gt; &gt;&gt;<br>
&gt; &gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 When user requests PDCM explicitly v=
ia &quot;+pdcm&quot; without PMU enabled, emit<br>
&gt; &gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 a warning to inform the user.<br>
&gt; &gt; &gt;&gt;<br>
&gt; &gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 Signed-off-by: Xiaoyao Li &lt;<a hre=
f=3D"mailto:xiaoyao.li@intel.com" target=3D"_blank">xiaoyao.li@intel.com</a=
>&gt;<br>
&gt; &gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 Reviewed-by: Zhao Liu &lt;<a href=3D=
"mailto:zhao1.liu@intel.com" target=3D"_blank">zhao1.liu@intel.com</a>&gt;<=
br>
&gt; &gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 Link: <a href=3D"https://lore.kernel=
.org/r/20250304052450.465445-3-xiaoyao.li@intel.com" rel=3D"noreferrer" tar=
get=3D"_blank">https://lore.kernel.org/r/20250304052450.465445-3-xiaoyao.li=
@intel.com</a><br>
&gt; &gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 Signed-off-by: Paolo Bonzini &lt;<a =
href=3D"mailto:pbonzini@redhat.com" target=3D"_blank">pbonzini@redhat.com</=
a>&gt;<br>
&gt; &gt; &gt;&gt;<br>
&gt; &gt; &gt;&gt;=C2=A0 =C2=A0target/i386/cpu.c | 3 +++<br>
&gt; &gt; &gt;&gt;=C2=A0 =C2=A01 file changed, 3 insertions(+)<br>
&gt; &gt; &gt;&gt;<br>
&gt; &gt; &gt;&gt;<br>
&gt; &gt; &gt;&gt;<br>
&gt; &gt; &gt;&gt; Which is odd as it should only add a warning right?<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; No, that commit message is misleading.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; IIUC mark_unavailable_features() actively blocks usage of th=
e feature,<br>
&gt; &gt; &gt; so it is a functional change, not merely a emitting warning.=
<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; It makes me wonder if that commit was actually intended to b=
lock the<br>
&gt; &gt; &gt; feature or not, vs merely warning ?=C2=A0 CC&#39;ing those i=
nvolved in the<br>
&gt; &gt; &gt; commit.<br>
&gt; &gt; We can revert the commit.=C2=A0 I&#39;ll send the revert to Stefa=
n and let him<br>
&gt; &gt; decide whether to include it in 10.1-rc4 or delay to 10.2 and 10.=
1.1.<br>
&gt;<br>
&gt; Thanks Paolo for considering that.<br>
&gt;<br>
&gt; My steps to reproduce seemed really clear and are 100% reproducible<br=
>
&gt; for me, but no one so far said &quot;yeah they see it too&quot;, so I&=
#39;m getting<br>
&gt; unsure if it was not tried by anyone else or if there is more to it<br=
>
&gt; than we yet know.<br>
&gt; Further I tested more with the commit reverted, and found that at<br>
&gt; least cross version migrations (9.2 -&gt; 10.1) still have issues that=
<br>
&gt; seem related - complaining about pdcm as missing feature.<br>
&gt; But that was in a log of a test system that went away and ... you know=
<br>
&gt; how these things can sometimes be, that new result is not yet very<br>
&gt; reliable.<br>
&gt;<br>
&gt; I intended to check the following matrix more deeply again with and<br=
>
&gt; without the reverted change and then come back to this thread:<br>
&gt;<br>
&gt; #1 Compare platforms<br>
&gt; - Migrating between non containerized hosts to verify if they are<br>
&gt; affected as well<br>
&gt; - Power management explicitly switched off/on (vs the auto detect of<b=
r>
&gt; host-model) in the guest XML<br>
&gt; #2 Retest the different Use-cases I&#39;ve seen this pop up<br>
&gt; - 10.1 managed save (broken unless reverting the commit that was ident=
ified)<br>
&gt; - 9.2 -&gt; 10.1 migration (seems broken even with the revert)<br>
<br>
I need to come back to this aspect of it - the cross release or cross<br>
qemu version migrations.<br>
<br>
Hector (on CC) helps me on that now - sadly we were able to confirm<br>
that migrations from older qemu versions no longer work.<br>
Yep 10.1 is released by now so it might end up as &quot;The problem is what=
<br>
happens when we detect after we have done a release that something has<br>
gone wrong&quot; from [2].<br>
But I still can&#39;t believe only we see this and therefore for now want<b=
r>
to believe I messed up on our side when merging 10.1 :-)<br>
<br>
For now this is a call if others have also seen any older release<br>
migrating to 10.1 to throw:<br>
=C2=A0 error: operation failed: guest CPU doesn&#39;t match specification:<=
br>
missing features: pdcm,arch-capabilities<br>
<br>
Hector will later today reply here with a summary of what we found so<br>
far, to provide you a more complete picture to think about, without<br>
having to read through all the messy interim steps in the Ubuntu bug.<br>
<br>
[1]: <a href=3D"https://bugs.launchpad.net/ubuntu/+source/qemu/+bug/2121787=
" rel=3D"noreferrer" target=3D"_blank">https://bugs.launchpad.net/ubuntu/+s=
ource/qemu/+bug/2121787</a><br>
[2]: <a href=3D"https://gitlab.com/qemu-project/qemu/-/blob/master/docs/dev=
el/migration/compatibility.rst?plain=3D1#L322" rel=3D"noreferrer" target=3D=
"_blank">https://gitlab.com/qemu-project/qemu/-/blob/master/docs/devel/migr=
ation/compatibility.rst?plain=3D1#L322</a><br>
<br>
&gt; The hope was that these will help to further identify what is going<br=
>
&gt; on, but despite the urgency of the release being imminent I have not<b=
r>
&gt; yet managed to find the time in the last two days :-/<br>
&gt;<br>
&gt; &gt; Sorry for the delay in answering (and thanks Daniel for bringing =
this to<br>
&gt; &gt; my attention).<br>
&gt; &gt;<br>
&gt; &gt; Thanks,<br>
&gt; &gt;<br>
&gt; &gt; Paolo<br>
&gt; &gt;<br>
&gt;<br>
&gt;<br>
&gt; --<br>
&gt; Christian Ehrhardt<br>
&gt; Director of Engineering, Ubuntu Server<br>
&gt; Canonical Ltd<br>
<br>
<br>
<br>
-- <br>
Christian Ehrhardt<br>
Director of Engineering, Ubuntu Server<br>
Canonical Ltd<br>
</blockquote></div><div><br clear=3D"all"></div><div><br></div><span class=
=3D"gmail_signature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_s=
ignature"><div dir=3D"ltr"><div style=3D"text-align:left"></div><div style=
=3D"text-align:left">Hector CAO<br></div><div style=3D"text-align:left">Sof=
tware Engineer =E2=80=93 Partner Engineering Team</div><div style=3D"text-a=
lign:left"><a href=3D"mailto:hector.cao@canonical.com" target=3D"_blank">he=
ctor.cao@canonical.com</a></div><div style=3D"text-align:left"><a href=3D"h=
ttps://launchpad.net/~hectorcao" target=3D"_blank">https://launc</a><a href=
=3D"https://launchpad.net/~hectorcao" target=3D"_blank">hpad.net/~hectorcao=
</a></div><div style=3D"text-align:left">
<p style=3D"line-height:100%;margin-bottom:0in"> =20
<a href=3D"https://launchpad.net/~hectorcao" target=3D"_blank"><img width=
=3D"96" height=3D"81" src=3D"https://ci3.googleusercontent.com/mail-sig/AIo=
rK4z5yECcB4DOFqFQjPXjogBAVC5Vv1klgihEnAZXkqybF5lNxe9SeDqtm-9dmSwj3Sbw2kDL58=
U"></a></p>

</div></div></div>

--0000000000006dacbd063dfaa446--

