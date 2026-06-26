Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2222ACDE008
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 01:42:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcvaP-0004qM-Rs; Thu, 25 Jun 2026 21:42:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wcvaN-0004pv-IM
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 21:42:27 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wcvaH-0003BB-OJ
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 21:42:23 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-697764213d6so716578a12.1
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 18:42:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782438140; cv=none;
 d=google.com; s=arc-20260327;
 b=TTP41A4g8bFNNTTrIaP2knEumT8RhrzmC8VKKeKiDdfiGd/jmbuuw2aYI9PxAhxiX/
 HXoBpOFKpxagPu40MmpBG7QbR/+AEEA4Kdmm2SM48P9Kx8LpjldyaDaXDOMN3xGm1gWn
 h23mAPIdUwTFuDFsPu84a9ezQlKvlX0LlOVJpQuTUWMVXtz3aycko/mqMFtZh43cUZvA
 4SiQUTRjfhqWqSGUgtR/aEUVd+fnW+p/tDLA0pMwjVyhAd8EQTDrWVt6QbOPsticfF79
 5kcefaSU+1F8UiVrpXNACGlCzJnxyF2ugWcds86C3lO4dKxvTLK3+tL/dFKYi/QSoW2W
 SU3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=xTWb5xhqXKwHUgzuaUekT+uRCWkP2D/TuEgj4NFRxEY=;
 fh=31kmA3YpaeSGikJp9dOPxVYBLvmEqVR4hdl99TcKH0M=;
 b=k5+gl0WlCFNU7AobS4Jjna1Djfw4ftAC7MkstE0Bzf2T0uV/Ya/a3nEBFBeZg4tODg
 bEBYBuVKZlbtXhAn3junMJ6y/xSmIpLYSfn8nwl5zmZOjrdnf9fUtr1z817RdwUrNwWM
 PNoyo6+HRnmoJZ0JgOEFUBaAIqHsndTywFNG8Y/kY2wiiEMVslPqXzOfSQv7+C5o0Fi3
 jyy14ptkHCrMdqLbwaHSVHM4bBgr2GrU0eK67kLvZi6PvamgEcv/+FESfGWYmWKqG6MP
 i5xhZKvb+ftjaicdR0ZUy4u5uyGa+5oOlxXnDPzWMfyEi9EIxWeYcOCWTEJzYsBLC4om
 bFfQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782438139; x=1783042939; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xTWb5xhqXKwHUgzuaUekT+uRCWkP2D/TuEgj4NFRxEY=;
 b=Tv8r3sOT6PBquRrIa1cXeliqCjWgo85T8Jnc0Itna7KsMy+mhAB4aeON255CM3cfrN
 iq06EHboMC3DdeSv6UGpAFccnKxg4kHlmVJiCaO7ovi6Wc0sHiBwrssFPJSM3iaGEecb
 EOKMotXqnDwYW0W/kV6HEFi8i64vrKiUEWrBsSoIFndY30lx2mVlBTQdNJFkSQcwWR0K
 237TTrKv/071akwzfo2fWeDxtiFC19CXFsym8LXhRwSU1QbUfIMPAexybzLEQs27g2A9
 znH/srCS+3w/1D2AeBriOQo3SGXUfuQO8G7mkIP5R7M8zC9mY1l4vfxQMwKwR171hnG/
 MweA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782438140; x=1783042940;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xTWb5xhqXKwHUgzuaUekT+uRCWkP2D/TuEgj4NFRxEY=;
 b=Jq7O+A3FDPeZAwY6ZlDhvQI6CwrtONCTdUNANwgeRFp73XgVQwf/2M+p8DqteLH1ht
 z+vvFle0nA2A32Odni4g4eIKuDjih0ncvLPYGrkxL+KUH//xAEUQeHgjd+F/NGtldGWu
 eduoz8gbvMu6J+22hSBebqWy5zFEcNuBDvDqakz97IA6YUQvBXSlCfSx/dLuOGCmLz4u
 897qz0Hwh4lztGtjzUMmrazIZZWl37YePaPD+ekt0XWIehXIzcnI1MZqEAYCpQ11iKOO
 oxtHCWMldoW7cR6Cg/+210hQU5xb43D19yw0R7lp4wCVUcLEyASfdj16LvOjOgjOgZRP
 a6tQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrjshptz+xkN7VzkLBOLkyAwI5aBI/SX8Lje4qO4RPcdKQ8JwTCHjc2oKnw6pWjxaL4VFh2kULGblHz@nongnu.org
X-Gm-Message-State: AOJu0YwrE2n044orngQ0xv2UJg4hARlmVqBmsO8fdWUFwiLHtCsFxVDH
 XvCdRjPlhc4dqOsEsd1wx8Ete829e/X8rUfT4gZ1pp+hDzU23dsKdHrM6VypXqdMcrP00cFHi45
 X/tGi8qbk04J+TjhNYAHgYrQvqEcgAn4=
X-Gm-Gg: AfdE7cmg4hgdPPvJ6b0uM1yYZGoc2jJXBqABfI+AUivXPxPHAzJL3doC3rwLsgUp/rM
 216SAHRRksjK4hA8fpWd7KXA8PGBW287Rg1CMDLPOAJUzhTx3uksVJmjIbDCQmuVsWuNqk2E/dU
 87ywJv+hfecjJZjJKGhHd18Gn2A4BQvBY3qVCJGe6BjCaqg0q26Whv4AqZRcdQIz+8hckzBQdxB
 R53BkM4nvdP4g/KntFxtv2/79LTBvzVwA4Z4WwAt3CkeHlhAEc/+qU4kKtNudaEq0U/ZQ0lPKFi
 Mx2Kqo71uqFBbMTfQz+72URaCBM=
X-Received: by 2002:a05:6402:a294:20b0:698:1973:1daa with SMTP id
 4fb4d7f45d1cf-698197327camr577561a12.18.1782438139487; Thu, 25 Jun 2026
 18:42:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260622193141.1449724-1-daniel.barboza@oss.qualcomm.com>
 <52c3605c-345f-43d2-8cc6-794980c805fa@oss.qualcomm.com>
 <50ce1e98-2c1f-4cbd-b191-1eac324b71b6@oss.qualcomm.com>
 <704cfba3-e92a-498d-928b-877f7f7641fe@oss.qualcomm.com>
 <9d2737e3-34f0-4f68-813b-37059615bced@oss.qualcomm.com>
 <CAFEAcA8660BZOmX_KXeF7JJaJwgKO3zSRDEmJURg27FK=tqbZg@mail.gmail.com>
 <df4a5857-ec4f-4d4f-bc08-1a9c5caae100@oss.qualcomm.com>
 <0f2205d0-06b5-40ad-9952-e18a6a951078@oss.qualcomm.com>
 <fe77f7a1-1a31-457c-9dec-e1b49cd35371@oss.qualcomm.com>
 <d83a2e21-403f-4146-b129-4d9ee264282a@oss.qualcomm.com>
In-Reply-To: <d83a2e21-403f-4146-b129-4d9ee264282a@oss.qualcomm.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 26 Jun 2026 11:41:53 +1000
X-Gm-Features: AVVi8CelTTp35t-8uVYriSDwDMItGZ7RpdLBC4dNgA8zr9VbY5b5theqYTzQ9EI
Message-ID: <CAKmqyKOXPCWPFP7Htr5BByp=7jsDDp6kYXRhyn6Ycre0pjofCg@mail.gmail.com>
Subject: Re: [PATCH 00/24] target/riscv: move TCG files and fix --disable-tcg
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x535.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Wed, Jun 24, 2026 at 5:18=E2=80=AFAM Pierrick Bouvier
<pierrick.bouvier@oss.qualcomm.com> wrote:
>
> On 6/23/2026 12:01 PM, Daniel Henrique Barboza wrote:
> >
> >
> > On 6/23/2026 1:10 PM, Pierrick Bouvier wrote:
> >> On 6/23/2026 4:38 AM, Daniel Henrique Barboza wrote:
> >>>
> >>>
> >>> On 6/23/2026 6:58 AM, Peter Maydell wrote:
> >>>> On Tue, 23 Jun 2026 at 10:49, Daniel Henrique Barboza
> >>>> <daniel.barboza@oss.qualcomm.com> wrote:
> >>>>>
> >>>>>
> >>>>>
> >>>>> On 6/22/2026 6:34 PM, Pierrick Bouvier wrote:
> >>>>>> On 6/22/2026 2:23 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> >>>>>>> On 22/6/26 22:52, Pierrick Bouvier wrote:
> >>>>>>>> On 6/22/2026 12:31 PM, Daniel Henrique Barboza wrote:
> >>>>>>>>> Hello,
> >>>>>>>>>
> >>>>>>>>> This series looks scary but it's mostly trivial and mechanical
> >>>>>>>>> work.
> >>>>>>>>>
> >>>>>>>>> It is yet another attempt at fixing --disable-tcg.  We have a
> >>>>>>>>> recent
> >>>>>>>>> work sent to the ML [1] and we had Phil's attempt back in 2023
> >>>>>>>>> [2].
> >>>>>>>>> Phil's work didn't get merged and it's now too hard to rebase a=
nd
> >>>>>>>>> revive, the most recent attempt got misled into the 'what is
> >>>>>>>>> common code
> >>>>>>>>> between TCG and KVM' dungeon.
> >>>>>>>
> >>>>>>>
> >>>>>>>> It seems like series does not apply on top of master, would that=
 be
> >>>>>>>> possible to rebase it?
> >>>>>>>
> >>>>>>> For some reason the RISC-V series are handled distinctly than the
> >>>>>>> rest of QEMU, Alistair queues work on his repository and develope=
rs
> >>>>>>> are custome to base their series on top of it (otherwise Alistair
> >>>>>>> can not apply them on his tree and asks for reposts), see the
> >>>>>>> riscv-to-apply.next branch on https://github.com/alistair23/qemu.
> >>>>>>
> >>>>>> Unfortunately, it makes it hard to run any kind of automated testi=
ng,
> >>>>>> especially for series like this that target specific configs.
> >>>>>
> >>>>> Don't we have ways of saying in the commit message "these patches
> >>>>> applies
> >>>>> on top of these other patches" and then the tooling would deal with
> >>>>> it?
> >>>>> I remember patchew doing stuff like that with that "Based-on:
> >>>>> <message-id>"
> >>>>> tag.
> >>>>
> >>>> Yes, Based-on: is our convention for marking "this patchset needs so=
me
> >>>> other one to be applied first". But that should be the exception rat=
her
> >>>> than a common case -- if patchsets regularly need to be based on
> >>>> something other than head-of-git, this is I think a sign that
> >>>> maintainers are not sending out pull requests frequently enough.
> >>>>
> >>>> I would prefer it if QEMU didn't develop kernel-style "subsystems
> >>>> have their own particular workflows" fragmentation -- I don't
> >>>> think we're big enough or that sub-parts of QEMU are sufficiently
> >>>> well separated for it to work out well.
> >>>
> >>> I agree that rebasing things on master is better than rebasing it on =
the
> >>> maintainer's tree.  And we could make a better job at informing
> >>> developers that
> >>> submitting a patch for qemu-riscv, vfio or any particular subtree, me=
ans
> >>> that
> >>> the patch should be based on a maintainer tree X.
> >>>
> >>> The thing is that sending patches on master only works if master is
> >>> always up
> >>> to date, and that's not feasible with our current style of merging PR=
s.
> >>> This
> >>> series we're commenting on is an example: it doesn't apply to master
> >>> because
> >>> there are pre-approved RISC-V patches in the maintainer's tree from 2
> >>> days ago
> >>> (also my patches, I might add) that caused conflicts that I wasn't aw=
are
> >>> that
> >>> would happen.  This conflict would have to be dealt with at some poin=
t
> >>> by myself
> >>> or the maintainer, and it's not like 2 days is too much time without
> >>> a PR.
> >>>
> >>> We can argue "this is an exception that doesn't happen that often, we
> >>> should
> >>> stick with using master as a base", and to a certain extend that's
> >>> true.  But
> >>> then this sort of conflict happens again, then again, then again, it
> >>> comes to
> >>> a point where it's easier to tell developers to use the maintainer's
> >>> tree instead
> >>> of master.
> >>>
> >>> Maybe I'm downplaying the problem because I've been sending stuff bas=
ed
> >>> on the
> >>> maintainer's tree since forever and got used to it.  IMO, unless we
> >>> decide to be
> >>> like libvirt and create the "committer" role to allow trustworthy dev=
s
> >>> to push
> >>> stuff to master after acks, making it more feasible to expect master =
to
> >>> be up to
> >>> date, I'm afraid we're closer to a kernel-style workflow.  For better=
 or
> >>> worse.
> >>>
> >>>
> >>> Thanks,
> >>> Daniel
> >>>
> >>>
> >>>>
> >>>> thanks
> >>>> -- PMM
> >>>
> >>
> >> In this very specific case, where base patches are needed, maybe it
> >> would be better to make the required commits appear in this series, an=
d
> >> mention in cover letter that patches 1-N are just coming from another
> >> series and are already reviewed/approved. IMHO it doesn't hurt, and
> >> reviewers are free to skip commits already reviewed.
> >
> > That's fair enough but I wonder if that won't scare people away with
> > even bigger series :D  in this case here I would need to either send al=
l
> > the queued patches, making the series go to 40+, or I would need to tri=
age
> > which patches from the queue creates a conflict with this work and send
> > only those.
> >
> > Now, as for qemu-ci ...  How farfetched it is to make it read a specifi=
c
> > tag
> > in the cover-letter, e.g. "branch-id", that can point to a gitlab/githu=
b
> > repo with the patches, and use that code base instead of applying the
> > patches to the master branch?  Then for the next version of this work
> > I could do
> >
> > "branch-id: https://gitlab.com/danielhb/qemu/-/tree/riscv_disabletcg_v2=
"
> >
>
> Based-on: is a QEMU specific tag, that is only understood by patchew,
> and no other tool to my knowledge.
> b4 has base_commit, which allows to give a specific base, but not a
> specific repository. I'm not aware of any b4 tag that allows to mention
> a base series. It makes sense, series are not branches, and stacking
> them comes with a lot of problems.
>
> So it seems like email workflow is quite limited in this regard, and the
> only way to deal with it properly is to wait for base patches to be
> merged, or include them in the series.
>
> From another perspective, the same problem would exist if we would use a
> forge like GitHub or GitLab. It's not possible to stack PR on top of
> others, and only solution is to wait, or duplicate patches. IMHO, it's a
> sane default, as it forces correct ordering instead of allowing chaotic
> development.
>
> > and the tool would still work.  If there's no "branch-id" then it assum=
es
> > that the patches are to be applied on master.
> >
> >
> > And yeah, in an ideal world the problem goes away if we just do more PR=
s
> > and
> > strive to keep 'master' updated.  I'm just thinking out loud about poss=
ible
> > alternatives until we reach that point.

When you sent v2 of this series it had been one week since the last
RISC-V PR. Are we really aiming for more than one PR a week?

> >
> >
> > Cheers,
> > Daniel
> >
> >>
> >> Or, a solution I'm not fond of but I ended up adopting most of the tim=
e,
> >> just wait for required patches to be merged on master before posting t=
he
> >> series, and work on something else meanwhile.

I do feel that a few people do that, just not Daniel :)

Alistair

> >>
> >> Ideally, yes, it would be better if maintainers could send PR more
> >> frequently to avoid creating those intermediate staging trees. The
> >> faster we merge, the less conflicts we'll have.
> >>
> >> Regards,
> >> Pierrick
> >
>
>

