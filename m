Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48BEECA0EF8
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Aug 2025 09:11:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoeqk-0000Us-US; Wed, 20 Aug 2025 05:11:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christian.ehrhardt@canonical.com>)
 id 1uoeqj-0000Ua-6M
 for qemu-devel@nongnu.org; Wed, 20 Aug 2025 05:11:17 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christian.ehrhardt@canonical.com>)
 id 1uoeqf-0007Xr-Rc
 for qemu-devel@nongnu.org; Wed, 20 Aug 2025 05:11:16 -0400
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 978A13F73B
 for <qemu-devel@nongnu.org>; Wed, 20 Aug 2025 09:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1755681070;
 bh=U66KeYcBtzapQnSu9DY+IoWA1H1YxqgyZrPEFwtNh0Q=;
 h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
 To:Cc:Content-Type;
 b=ABHRmxLATtxZCACMyit2KTcBIVYqVtW7oXCc44r08aclaOnfVlVw3dKAoQ5wy/r+o
 Sw1yk/Piuf4bLwf/pcpzRAFBTLPfY0tXQzKLmX7k+pT7KJKEFFsnx+UkPTAJPdjAET
 H6dt5mLSeiFUbDpP4n9bv3XnLx7wvg25TyR7JxUdohNSS2xmizGtIGGzvaHdfcTmPX
 Gpl+UwftbRFnpU9EEF6uirt0KTnUEAMVKygeTzl5+K6qy5yPnPK4ygYQeOoR6VEAJX
 PYJINrpZBdtFuRlWtVKVeKs9bVxGVuW6a02d7LvP4ubMvSgnaTxQRZQcrNuYotcXEd
 wBMjimgx+fPHA==
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-afcb7a3a160so583281466b.2
 for <qemu-devel@nongnu.org>; Wed, 20 Aug 2025 02:11:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755681070; x=1756285870;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U66KeYcBtzapQnSu9DY+IoWA1H1YxqgyZrPEFwtNh0Q=;
 b=tczzfyyZEfTgVx0mvM7MDsfN1giOqMcpMcALT7Bg6K9tnmcx1kYsNWuelpLmlhmNih
 G7aVWXEw/4uH6WFA7ina3OlymAo5ecPx5KSGEgG95kc/YT0Q6iQauTJd8voH7KIGjG29
 3zcmf6NPO++7YEuBmpA+nlxrtAo7An+AfJnAsO+/3B2GhlMh8WBuUtkw5cXdHtAdKlxo
 KAmrgo7yNZeHppGfu7LF/yxXyloL074cU8t2kInAjmb8EjBJawEAqs38oG+WNIw3MWqa
 24CDxS/xYZgbew9250/+FXDkay2E/R/e3Tbf8mTTMUMw5LOY79P+VfQiH/1+Hs3bzL19
 cmlA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXmSAP5I4i47ByjEdUoGtbTk6lvO2vInzfUukS/aBORGC1nAaPizm/Fzwc29FNUX55PDoPtD4XLSt/I@nongnu.org
X-Gm-Message-State: AOJu0Yw7r/4WdUtgJ2Zq5VNyHHZGGyLol5dDdxkaFnekQaWdSa88Z7MI
 F0BALrFEz2q4SSjJG9MCBEezAxpiFuMmbXrfnCJka+Xj9XhCshk7Ar3AOyO1CjCEi5+5CDL8jJE
 v6YMcgJJPqN8dZfl5pR+mFs96LMI7YCpLljzEvWX+vdMTzxqaPYfPpzyWrBtYWJO/qS4dlhJXk3
 XFrhs0OgWCPLcS9jVdfgm8W7jDzsR8ZsuPWAdrUs6z50mbLmM=
X-Gm-Gg: ASbGnctOk+4Hx64l1Nv3ock0UlyEBrA58ghEJMAqsufyjATOoXrVmHKe2nSoV16F/KZ
 k1dKqr3i5Yt5MoHkrQ1yESw7iyrWfXu4HuNjJZRDV69+SzWn2g4SUDFQQ3E68+kS21N51HZeGaR
 dUvl+FwL8KI9o01gJ7kYz9
X-Received: by 2002:a17:907:6d16:b0:af1:d32f:3e89 with SMTP id
 a640c23a62f3a-afdf01d5c03mr201974066b.31.1755681069768; 
 Wed, 20 Aug 2025 02:11:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHsm+cparstbM738AdXxZ/F6vH8v/gX6QDYfNwcTOD7pJYskB6oIUXEsOf95l3lN04vOlk1ut+dmc0xdkXhOw4=
X-Received: by 2002:a17:907:6d16:b0:af1:d32f:3e89 with SMTP id
 a640c23a62f3a-afdf01d5c03mr201970766b.31.1755681069212; Wed, 20 Aug 2025
 02:11:09 -0700 (PDT)
MIME-Version: 1.0
References: <CAATJJ0+Qq3ksRmNRDrGQLVHQ=XnsnFHxCNxUhjJfNfgwUKkDPQ@mail.gmail.com>
 <aJNDxxjeqkOLAO2r@redhat.com>
 <CAATJJ0L-E=JsKOX_E=jqraeK__jLF851DDbEx5psVkTMSppKXw@mail.gmail.com>
 <aJOqmxTimJ_mFCqp@redhat.com>
 <ccabd72c-6f48-4be2-8bbd-44f28eb2cfd1@redhat.com>
 <CAATJJ0KZDHqMHmpmfFySJjreqPMTHDiJLJM_zBdcr5CrzOL2tg@mail.gmail.com>
In-Reply-To: <CAATJJ0KZDHqMHmpmfFySJjreqPMTHDiJLJM_zBdcr5CrzOL2tg@mail.gmail.com>
From: Christian Ehrhardt <christian.ehrhardt@canonical.com>
Date: Wed, 20 Aug 2025 11:10:42 +0200
X-Gm-Features: Ac12FXx0y6mFUSBOsNYOBxn2fNpEdos0rW1yxUkc-f3lLW7CH8rLLj4fyrc2vuY
Message-ID: <CAATJJ0JYss-VCA6k3Zq4m63uRTpcew_QXJXTWTg8BfVv=MtfxA@mail.gmail.com>
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

On Wed, Aug 20, 2025 at 7:11=E2=80=AFAM Christian Ehrhardt
<christian.ehrhardt@canonical.com> wrote:
>
> On Tue, Aug 19, 2025 at 4:51=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.co=
m> wrote:
> >
> > On 8/6/25 21:18, Daniel P. Berrang=C3=A9 wrote:
> > > On Wed, Aug 06, 2025 at 07:57:34PM +0200, Christian Ehrhardt wrote:
> > >> On Wed, Aug 6, 2025 at 2:00=E2=80=AFPM Daniel P. Berrang=C3=A9 <berr=
ange@redhat.com> wrote:
> > >>>
> > >>> On Wed, Aug 06, 2025 at 01:52:17PM +0200, Christian Ehrhardt wrote:
> > >>>> Hi,
> > >>>> I was unsure if this would be better sent to libvirt or qemu - the
> > >>>> issue is somewhere between libvirt modelling CPUs and qemu 10.1
> > >>>> behaving differently. I did not want to double post and gladly mos=
t of
> > >>>> the people are on both lists - since the switch in/out of the prob=
lem
> > >>>> is qemu 10.0 <-> 10.1 let me start here. I beg your pardon for not=
 yet
> > >>>> having all the answers, I'm sure I could find more with debugging,=
 but
> > >>>> I also wanted to report early for your awareness while we are stil=
l in
> > >>>> the RC phase.
> > >>>>
> > >>>>
> > >>>> # Problem
> > >>>>
> > >>>> What I found when testing migrations in Ubuntu with qemu 10.1-rc1 =
was:
> > >>>>    error: operation failed: guest CPU doesn't match specification:
> > >>>> missing features: pdcm
> > >>>>
> > >>>> This is behaving the same with libvirt 11.4 or the more recent 11.=
6.
> > >>>> But switching back to qemu 10.0 confirmed that this behavior is ne=
w
> > >>>> with qemu 10.1-rc.
> > >>>
> > >>>
> > >>>> Without yet having any hard evidence against them I found a few pd=
cm
> > >>>> related commits between 10.0 and 10.1-rc1:
> > >>>>    7ff24fb65 i386/tdx: Don't mask off CPUID_EXT_PDCM
> > >>>>    00268e000 i386/cpu: Warn about why CPUID_EXT_PDCM is not availa=
ble
> > >>>>    e68ec2980 i386/cpu: Move adjustment of CPUID_EXT_PDCM before
> > >>>> feature_dependencies[] check
> > >>>>    0ba06e46d i386/tdx: Add TDX fixed1 bits to supported CPUIDs
> > >>>>
> > >>>>
> > >>>> # Caveat
> > >>>>
> > >>>> My test environment is in LXD system containers, that gives me iss=
ues
> > >>>> in the power management detection
> > >>>>    libvirtd[406]: error from service: GDBus.Error:System.Error.ERO=
FS:
> > >>>> Read-only file system
> > >>>>    libvirtd[406]: Failed to get host power management capabilities
> > >>>
> > >>> That's harmless.
> > >>
> > >> Yeah, it always was for me - thanks for confirming.
> > >>
> > >>>> And the resulting host-model on a  rather old test server will the=
refore have:
> > >>>>    <cpu mode=3D'custom' match=3D'exact' check=3D'full'>
> > >>>>      <model fallback=3D'forbid'>Haswell-noTSX-IBRS</model>
> > >>>>      <vendor>Intel</vendor>
> > >>>>      <feature policy=3D'require' name=3D'vmx'/>
> > >>>>      <feature policy=3D'disable' name=3D'pdcm'/>
> > >>>>       ...
> > >>>>
> > >>>> But that was fine in the past, and the behavior started to break
> > >>>> save/restore or migrations just now with the new qemu 10.1-rc.
> > >>>>
> > >>>> # Next steps
> > >>>>
> > >>>> I'm soon overwhelmed by meetings for the rest of the day, but woul=
d be
> > >>>> curious if one has a suggestion about what to look at next for
> > >>>> debugging or a theory about what might go wrong. If nothing else c=
omes
> > >>>> up I'll try to set up a bisect run tomorrow.
> > >>>
> > >>> Yeah, git bisect is what I'd start with.
> > >>
> > >> Bisect complete, identified this commit
> > >>
> > >> commit 00268e00027459abede448662f8794d78eb4b0a4
> > >> Author: Xiaoyao Li <xiaoyao.li@intel.com>
> > >> Date:   Tue Mar 4 00:24:50 2025 -0500
> > >>
> > >>      i386/cpu: Warn about why CPUID_EXT_PDCM is not available
> > >>
> > >>      When user requests PDCM explicitly via "+pdcm" without PMU enab=
led, emit
> > >>      a warning to inform the user.
> > >>
> > >>      Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> > >>      Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
> > >>      Link: https://lore.kernel.org/r/20250304052450.465445-3-xiaoyao=
.li@intel.com
> > >>      Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > >>
> > >>   target/i386/cpu.c | 3 +++
> > >>   1 file changed, 3 insertions(+)
> > >>
> > >>
> > >>
> > >> Which is odd as it should only add a warning right?
> > >
> > > No, that commit message is misleading.
> > >
> > > IIUC mark_unavailable_features() actively blocks usage of the feature=
,
> > > so it is a functional change, not merely a emitting warning.
> > >
> > > It makes me wonder if that commit was actually intended to block the
> > > feature or not, vs merely warning ?  CC'ing those involved in the
> > > commit.
> > We can revert the commit.  I'll send the revert to Stefan and let him
> > decide whether to include it in 10.1-rc4 or delay to 10.2 and 10.1.1.
>
> Thanks Paolo for considering that.
>
> My steps to reproduce seemed really clear and are 100% reproducible
> for me, but no one so far said "yeah they see it too", so I'm getting
> unsure if it was not tried by anyone else or if there is more to it
> than we yet know.
> Further I tested more with the commit reverted, and found that at
> least cross version migrations (9.2 -> 10.1) still have issues that
> seem related - complaining about pdcm as missing feature.
> But that was in a log of a test system that went away and ... you know
> how these things can sometimes be, that new result is not yet very
> reliable.
>
> I intended to check the following matrix more deeply again with and
> without the reverted change and then come back to this thread:
>
> #1 Compare platforms
> - Migrating between non containerized hosts to verify if they are
> affected as well
> - Power management explicitly switched off/on (vs the auto detect of
> host-model) in the guest XML
> #2 Retest the different Use-cases I've seen this pop up
> - 10.1 managed save (broken unless reverting the commit that was identifi=
ed)
> - 9.2 -> 10.1 migration (seems broken even with the revert)

I'll report back as i can squeeze tests between meetings (there also
is an issue with riscv emulation that I try to identify at the same
time)

For now I managed to eliminate some of my concerns, which was that it
might be my system container based setup.
But I was testing different builds on bare metal x86 this morning and
it looks the same to me.

### ### ###

1:10.0.2+ds-1ubuntu2 (this is what is in the current Ubuntu, until I
started on 10.1)

=3D> On start maps host-model to:
  <model fallback=3D'forbid'>Cascadelake-Server</model>
  <vendor>Intel</vendor>
  <feature policy=3D'require' name=3D'vmx'/>
  <feature policy=3D'require' name=3D'pdcm'/>
...
=3D> Can do managedsave + start without problems

### ### ###

1:10.1.0~rc2+ds-1ubuntu1 (which has 00268e0 "i386/cpu: Warn about why
CPUID_EXT_PDCM is not available" reverted)

=3D> On start maps host-model to:
  <model fallback=3D'forbid'>Cascadelake-Server</model>
  <vendor>Intel</vendor>
  <feature policy=3D'require' name=3D'vmx'/>
  <feature policy=3D'disable' name=3D'pdcm'/>
               ^^ this detection is already different due to using
10.1 even with the revert
...
=3D> Can do managedsave + start without problems
               ^^ with the revert it works

### ### ###

1:10.1.0~rc3+ds-2ubuntu1~questingppa1 (which is WITHOUT the revert,
more like the normal RC3)

=3D> On start maps host-model to:
  <model fallback=3D'forbid'>Cascadelake-Server</model>
  <vendor>Intel</vendor>
  <feature policy=3D'require' name=3D'vmx'/>
  <feature policy=3D'disable' name=3D'pdcm'/>
                       ^^ same detection as with the revert, but
different than 10.0 formerly did
...
=3D> Fails to do save and restore just as I had it in my container based te=
sts

$ virsh start testguest
error: Failed to start domain 'testguest'
error: operation failed: guest CPU doesn't match specification:
missing features: pdcm

### ### ###

While I was concerned if my test environment might have been part of
this, it seems it is generally applicable and a problem on bare metal
too.
This is on 6.16.0-13-generic on a Intel Xeon Gold 5222, libvirt 11.6,
only qemu changes between the tests.
With that confirmed, I'd indeed suggest reverting it for now, even
more if someone else could reproduce the same on other platforms and
builds.


On Thu, Aug 7, 2025 at 10:09=E2=80=AFAM Xiaoyao Li <xiaoyao.li@intel.com> w=
rote:
>
> So libvirt must first request with "-cpu xxx,pdcm=3Don" without "pmu=3Don=
"
> and gets the result that PDCM is filtered (set in cpu->filtered_features[=
]).

I wanted to also double down on that former comment, trying to check
logs what they say about pdcm and pmu exactly.
pmu is easy - not mentioned ever in cmdline or configs, but pdcm is
more interesting than I expected.

This is with:
1:10.1.0~rc3+ds-2ubuntu1~questingppa1 (which is WITHOUT the revert,
more like the normal RC3)

The guest gets started at first with this full cpu definition

-cpu Cascadelake-Server,vmx=3Don,pdcm=3Don,hypervisor=3Don,ss=3Don,tsc-adju=
st=3Don,fdp-excptn-only=3Don,zero-fcs-fds=3Don,mpx=3Don,umip=3Don,pku=3Don,=
md-clear=3Don,stibp=3Don,flush-l1d=3Don,arch-capabilities=3Don,xsaves=3Don,=
ibpb=3Don,ibrs=3Don,amd-stibp=3Don,amd-ssbd=3Don,rdctl-no=3Don,ibrs-all=3Do=
n,skip-l1dfl-vmentry=3Don,mds-no=3Don,pschange-mc-no=3Don,tsx-ctrl=3Don,sbd=
r-ssdp-no=3Don,psdp-no=3Don,fb-clear=3Don,rfds-no=3Don,vmx-ins-outs=3Don,vm=
x-true-ctls=3Don,vmx-store-lma=3Don,vmx-activity-hlt=3Don,vmx-activity-wait=
-sipi=3Don,vmx-vmwrite-vmexit-fields=3Don,vmx-apicv-xapic=3Don,vmx-ept=3Don=
,vmx-desc-exit=3Don,vmx-rdtscp-exit=3Don,vmx-apicv-x2apic=3Don,vmx-vpid=3Do=
n,vmx-wbinvd-exit=3Don,vmx-unrestricted-guest=3Don,vmx-apicv-register=3Don,=
vmx-apicv-vid=3Don,vmx-rdrand-exit=3Don,vmx-invpcid-exit=3Don,vmx-vmfunc=3D=
on,vmx-shadow-vmcs=3Don,vmx-rdseed-exit=3Don,vmx-pml=3Don,vmx-xsaves=3Don,v=
mx-tsc-scaling=3Don,vmx-ept-execonly=3Don,vmx-page-walk-4=3Don,vmx-ept-2mb=
=3Don,vmx-ept-1gb=3Don,vmx-invept=3Don,vmx-eptad=3Don,vmx-invept-single-con=
text=3Don,vmx-invept-all-context=3Don,vmx-invvpid=3Don,vmx-invvpid-single-a=
ddr=3Don,vmx-invvpid-all-context=3Don,vmx-invept-single-context-noglobals=
=3Don,vmx-intr-exit=3Don,vmx-nmi-exit=3Don,vmx-vnmi=3Don,vmx-preemption-tim=
er=3Don,vmx-posted-intr=3Don,vmx-vintr-pending=3Don,vmx-tsc-offset=3Don,vmx=
-hlt-exit=3Don,vmx-invlpg-exit=3Don,vmx-mwait-exit=3Don,vmx-rdpmc-exit=3Don=
,vmx-rdtsc-exit=3Don,vmx-cr3-load-noexit=3Don,vmx-cr3-store-noexit=3Don,vmx=
-cr8-load-exit=3Don,vmx-cr8-store-exit=3Don,vmx-flexpriority=3Don,vmx-vnmi-=
pending=3Don,vmx-movdr-exit=3Don,vmx-io-exit=3Don,vmx-io-bitmap=3Don,vmx-mt=
f=3Don,vmx-msr-bitmap=3Don,vmx-monitor-exit=3Don,vmx-pause-exit=3Don,vmx-se=
condary-ctls=3Don,vmx-exit-nosave-debugctl=3Don,vmx-exit-load-perf-global-c=
trl=3Don,vmx-exit-ack-intr=3Don,vmx-exit-save-pat=3Don,vmx-exit-load-pat=3D=
on,vmx-exit-save-efer=3Don,vmx-exit-load-efer=3Don,vmx-exit-save-preemption=
-timer=3Don,vmx-exit-clear-bndcfgs=3Don,vmx-entry-noload-debugctl=3Don,vmx-=
entry-ia32e-mode=3Don,vmx-entry-load-perf-global-ctrl=3Don,vmx-entry-load-p=
at=3Don,vmx-entry-load-efer=3Don,vmx-entry-load-bndcfgs=3Don,vmx-eptp-switc=
hing=3Don,hle=3Doff,rtm=3Doff

which has "pdcm=3Don" but does not mention pmu either way.

But once qemu starts we see it emit

2025-08-20T08:53:00.514650Z qemu-system-x86_64: warning: This feature
is not available due to PMU being disabled: CPUID[eax=3D01h].ECX.pdcm
[bit 15]

When I do "virsh start" after "managedsave" I see this:

-cpu Cascadelake-Server,vmx=3Don,pdcm=3Doff,hypervisor=3Don,ss=3Don,tsc-adj=
ust=3Don,fdp-excptn-only=3Don,zero-fcs-fds=3Don,mpx=3Don,umip=3Don,pku=3Don=
,md-clear=3Don,stibp=3Don,flush-l1d=3Don,arch-capabilities=3Don,xsaves=3Don=
,ibpb=3Don,ibrs=3Don,amd-stibp=3Don,amd-ssbd=3Don,rdctl-no=3Don,ibrs-all=3D=
on,skip-l1dfl-vmentry=3Don,mds-no=3Don,pschange-mc-no=3Don,tsx-ctrl=3Don,sb=
dr-ssdp-no=3Don,psdp-no=3Don,fb-clear=3Don,rfds-no=3Don,vmx-ins-outs=3Don,v=
mx-true-ctls=3Don,vmx-store-lma=3Don,vmx-activity-hlt=3Don,vmx-activity-wai=
t-sipi=3Don,vmx-vmwrite-vmexit-fields=3Don,vmx-apicv-xapic=3Don,vmx-ept=3Do=
n,vmx-desc-exit=3Don,vmx-rdtscp-exit=3Don,vmx-apicv-x2apic=3Don,vmx-vpid=3D=
on,vmx-wbinvd-exit=3Don,vmx-unrestricted-guest=3Don,vmx-apicv-register=3Don=
,vmx-apicv-vid=3Don,vmx-rdrand-exit=3Don,vmx-invpcid-exit=3Don,vmx-vmfunc=
=3Don,vmx-shadow-vmcs=3Don,vmx-rdseed-exit=3Don,vmx-pml=3Don,vmx-xsaves=3Do=
n,vmx-tsc-scaling=3Don,vmx-ept-execonly=3Don,vmx-page-walk-4=3Don,vmx-ept-2=
mb=3Don,vmx-ept-1gb=3Don,vmx-invept=3Don,vmx-eptad=3Don,vmx-invept-single-c=
ontext=3Don,vmx-invept-all-context=3Don,vmx-invvpid=3Don,vmx-invvpid-single=
-addr=3Don,vmx-invvpid-all-context=3Don,vmx-invept-single-context-noglobals=
=3Don,vmx-intr-exit=3Don,vmx-nmi-exit=3Don,vmx-vnmi=3Don,vmx-preemption-tim=
er=3Don,vmx-posted-intr=3Don,vmx-vintr-pending=3Don,vmx-tsc-offset=3Don,vmx=
-hlt-exit=3Don,vmx-invlpg-exit=3Don,vmx-mwait-exit=3Don,vmx-rdpmc-exit=3Don=
,vmx-rdtsc-exit=3Don,vmx-cr3-load-noexit=3Don,vmx-cr3-store-noexit=3Don,vmx=
-cr8-load-exit=3Don,vmx-cr8-store-exit=3Don,vmx-flexpriority=3Don,vmx-vnmi-=
pending=3Don,vmx-movdr-exit=3Don,vmx-io-exit=3Don,vmx-io-bitmap=3Don,vmx-mt=
f=3Don,vmx-msr-bitmap=3Don,vmx-monitor-exit=3Don,vmx-pause-exit=3Don,vmx-se=
condary-ctls=3Don,vmx-exit-nosave-debugctl=3Don,vmx-exit-load-perf-global-c=
trl=3Don,vmx-exit-ack-intr=3Don,vmx-exit-save-pat=3Don,vmx-exit-load-pat=3D=
on,vmx-exit-save-efer=3Don,vmx-exit-load-efer=3Don,vmx-exit-save-preemption=
-timer=3Don,vmx-exit-clear-bndcfgs=3Don,vmx-entry-noload-debugctl=3Don,vmx-=
entry-ia32e-mode=3Don,vmx-entry-load-perf-global-ctrl=3Don,vmx-entry-load-p=
at=3Don,vmx-entry-load-efer=3Don,vmx-entry-load-bndcfgs=3Don,vmx-eptp-switc=
hing=3Don,hle=3Doff,rtm=3Doff

I still get this warning
2025-08-20T08:54:54.477469Z qemu-system-x86_64: warning: This feature
is not available due to PMU being disabled: CPUID[eax=3D01h].ECX.pdcm
[bit 15]

But more interestingly - in this second start, the one with a managed
save present, we see libvirt call the guest with
   pdcm=3Doff

So for a yet unknown reason this second start is setting pdcm=3Doff and
therefore all that follows is expected.
And yep, then we will get
  error: operation failed: guest CPU doesn't match specification:
missing features: pdcm

So we are partially back to my original suspicion that is is somewhere
in between qemu and libvirt, it is neither alone but their interaction
that is breaking this AFAICS.

> The hope was that these will help to further identify what is going
> on, but despite the urgency of the release being imminent I have not
> yet managed to find the time in the last two days :-/
>
> > Sorry for the delay in answering (and thanks Daniel for bringing this t=
o
> > my attention).
> >
> > Thanks,
> >
> > Paolo
> >
>
>
> --
> Christian Ehrhardt
> Director of Engineering, Ubuntu Server
> Canonical Ltd



--=20
Christian Ehrhardt
Director of Engineering, Ubuntu Server
Canonical Ltd

