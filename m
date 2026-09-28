Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FBBBCA5FA5
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 12:21:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBALx-0001Em-I8; Mon, 28 Sep 2026 08:21:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xBALu-0001EJ-Vi
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 08:21:02 -0400
Received: from mail-ed2-x0d.google.com ([2a00:1450:4864:33::d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xBALt-0007bQ-9V
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 08:21:02 -0400
Received: by mail-ed2-x0d.google.com with SMTP id
 4fb4d7f45d1cf-6ab06778bdfso2193463a12.1
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 05:21:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790598060; cv=none;
 d=google.com; s=arc-20260327;
 b=dtMqSmicTK4y4eObXHjjGbAfwJGDR2FcA2kBi98WtA4ojtiuwlcoHZ3SI5sExjwvAs
 nXtu/BdiJ+TBzVNPA7uldkYBrLDAXqSO+GUBDCyr+TORnCkHSLM5PaDFPSa+Yxrb8TWN
 K2T7Ff2mZiP6c3zP8wRgWMc4Vgx+RvOMJAZlPowKviAKDPPW8BdwPI5HvTmFmb7bAtsm
 Oj5Vy2wfsCBeBC7FmKOPyRzyJbBmfa+vaNV42Lr7Q/IHI4wnFTpJawL7+ClY8LlXFdUW
 AJpiBZGXdcBSZpasKbKM3K3rSRHUTggkeOXkcMFt2LhrAB/kegUGO6znKE/5ot10gZXM
 nBXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
 :mime-version:dkim-signature;
 bh=pd/w+IYrhtO8nDIhhhTCrDHiriJrkkAbVUGpwUfls8o=;
 fh=6jdXT6b4cnfDza0iCJZs0pGSp8j3wtI2284GwcwH8j8=;
 b=Xqsgckjfye5Q4tkXse8y0Nx/ZTdL2VYDkyBkdvuCxDrzcpXsFLLpGE40ezwWDANHnJ
 1lOHv9cyeoLydEm6W3LZamt5ErbYmFcKTQcYbBQ7DCvqF9cZLK1pMCmQn3mT2jxJ+9i5
 qWrnf+hdBYaxIpa4fzTOtqw77ZNZNLO5LQVjhYPqeKcuDHKPVxnmqbfetUn9gszql0aB
 CEd2icoD8JN0HIgmiYGssnC/250HkICzQ4v8+C0EKL6G5owQjzM2G3PZUm9e7TH4lytl
 4vDYQW0GQ+1a2QdJYHZxSTap7wyjxb7Eg54ancyzsoleIzAXHS+rTPpiIayFloEz2r53
 JYjQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790598060; x=1791202860; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:reply-to
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pd/w+IYrhtO8nDIhhhTCrDHiriJrkkAbVUGpwUfls8o=;
 b=ksEr9LR8qa3qyi3HXHZTY9JRii+NqL0qllZOPu8VWXsyruQVpj1Mqx8Xndgd01K4sH
 UINr4p6G2JGUsltSb4Y7OeqI+44LMEwo2FqWcOwALopHbAaCmsJPbgPJx1v3KeOB8us7
 MNdLsIgLCl9miP3nMNTzLvnk5r0rlSWZAKSnww0tS6+akiIGZ6EoZQcdegxz1lc1Q9u2
 mvTmO3Ued6qDPGKlNXp72ki21IUG+g1RKrIB85ujSKFmHAKCQA0q9p9JPB6v50T7+wME
 mixce3UgvQMTE+z4/DCn6D721QXnbfLQN6vJyc//ruNWUJkZE5QUni3nflZePFeEIb9B
 SyVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790598060; x=1791202860;
 h=content-type:cc:to:subject:message-id:date:from:reply-to
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=pd/w+IYrhtO8nDIhhhTCrDHiriJrkkAbVUGpwUfls8o=;
 b=aBqCG7Kdm7CznrgzVxzHv8+frNBbR/QPH7rneW6JClACeDW9PNOw//mcbmdnvc38hv
 YAtwOy5VthixFS1UM7DOEqg5HkHA8qi35iRW4/YJb+YtvSzydYLiBSijRlM88hPprHY4
 tqdbgE+/ghqVrorIgha48EnEWT4zMvNvWbE1oTgGpmO4JzTD1syNZm3hOIzWXcCX9wOO
 f+gFGWsGCLiIvwU74Nc3reRBdGu5RxKBvZBenZJnVt0HA4bZn+k9W16WA7YcT3pxTc+i
 cevPBF0UV1+Fv1gDvFQrpNQ4OmNvT8ZWODrjCYhUhWA1lg4H9ZiferlVpypa1pU9UWDd
 tQYg==
X-Gm-Message-State: AFq9FYJG0AJzMpwutM3FYmln2NJVT3G7O3DKGRraw1Rx5b0XCHoLq7zN
 lvoEzCSOK40gbyylpzBFoOYLA5W7JcKMbAGaaXtoOCB6GTGOo4Fn/+8T+HnY9pL7qDVGyt+5Ux0
 HvvstqWDZ6jKTTHtnR6zn9Y3sN+3WW46MGg0qbkE=
X-Gm-Gg: AYBFou21Agre7D18EKABR/pQPlDRTc+CzawXkMZFj6HcIDxxSVwhsVXcx1IkcrQYLNa
 nm7ZL9NCnm5nQFGMtkAg6jMHnVW+fOrEHs9EUkjg++wBdeHOTPxBm5JUaccGjWOM6BEdXTlbpX9
 52b8yiNqrr4QfYZ4XsZAmNGayL3Yn/UJmSYXqzJpv3Mk/0zVmHUy+OWpJV082+wPLnEvsyub5WW
 0KKkqwMrpgz9srARHqZtlhZuYrF5HWSBi0csbJzwF8Cl3c57Xs7uZjTuX7eGT/tfjsqyHlfUQb3
 EQTCtvjFSq5qfWULRxOJHR/E18AB/bPpdviaW3DJ/IWQpTDn9pFeTSc=
X-Received: by 2002:a05:6402:518c:b0:6ab:e30:c9d3 with SMTP id
 4fb4d7f45d1cf-6ab0e30cd41mr3619551a12.16.1790598059459; Mon, 28 Sep 2026
 05:20:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260926070057.1234-1-luoyonggang@gmail.com>
 <20260926070057.1234-42-luoyonggang@gmail.com>
 <87zex1fvh4.fsf@pond.sub.org>
 <CAE2XoE_QozVhBix251nyUQkFMi6p_4idGXpVOT0LSP7VYK8ddw@mail.gmail.com>
 <87ik3pfu2x.fsf@pond.sub.org>
In-Reply-To: <87ik3pfu2x.fsf@pond.sub.org>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Mon, 28 Sep 2026 20:20:46 +0800
X-Gm-Features: AclHuK9CBaivFUi-QTsLsXYGlMViwFl_oPAu9FsPjPtcurpCcEH-nNae4Mdp-OQ
Message-ID: <CAE2XoE88wDu5dYzqVd4gvwNV=bf8qcztLos0xx3iMFnWB+=Nvw@mail.gmail.com>
Subject: Re: [PATCH v4 41/55] target-info: add SysEmuTarget none
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 qemu-arm@nongnu.org, kvm@vger.kernel.org
Content-Type: multipart/alternative; boundary="000000000000450763065c8a192b"
Received-SPF: pass client-ip=2a00:1450:4864:33::d;
 envelope-from=luoyonggang@gmail.com; helo=mail-ed2-x0d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, SPF_HELO_NONE=0.001,
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
Reply-To: luoyonggang@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--000000000000450763065c8a192b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 8:18=E2=80=AFPM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> Yonggang Luo <luoyonggang@gmail.com> writes:
>
> > On Mon, Sep 28, 2026 at 7:48=E2=80=AFPM Markus Armbruster <armbru@redha=
t.com>
wrote:
> >>
> >> Yonggang Luo <luoyonggang@gmail.com> writes:
> >>
> >> > Add a none target for when no TargetInfo is selected. It is last
> >> > so existing SYS_EMU_TARGET_* values stay put, and it is not a
> >> > qemu-system- executable name. target_is_none() and target_none()
> >> > report that state.
> >>
> >> Why does it matter that existing SYS_EMU_TARGET_* stay put?
> >
> > We need a state that not a real CPU target is selected( I called it
none),
> > then we can use it to list all targets. for example, do query-targets.
> > query-machines(all machines for all targets).
> > Any better ways to handle it would be appreciated, I am not choosing to
set
> > it to NULL because
> > that would cause too much NULL-check error, as the pre-existing code
> > presume there is always a
> > CPU target present.
>
> Doesn't answer my question, so let me try again :)
>
> In your commit message, you explain "it is last so existing
> SYS_EMU_TARGET_* values stay put".  They do, but why is that useful?

Just to keep the pre-existing enum value not changed, yeap, not that useful=
.
I'll drop this misleading comment. Another choice is keep none
as the first enum value, so it's always "0", maybe that's better?

>


--
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--000000000000450763065c8a192b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br>On Mon, Sep 28, 2026 at 8:18=E2=80=AFPM Markus Arm=
bruster &lt;<a href=3D"mailto:armbru@redhat.com">armbru@redhat.com</a>&gt; =
wrote:<br>&gt;<br>&gt; Yonggang Luo &lt;<a href=3D"mailto:luoyonggang@gmail=
.com">luoyonggang@gmail.com</a>&gt; writes:<br>&gt;<br>&gt; &gt; On Mon, Se=
p 28, 2026 at 7:48=E2=80=AFPM Markus Armbruster &lt;<a href=3D"mailto:armbr=
u@redhat.com">armbru@redhat.com</a>&gt; wrote:<br>&gt; &gt;&gt;<br>&gt; &gt=
;&gt; Yonggang Luo &lt;<a href=3D"mailto:luoyonggang@gmail.com">luoyonggang=
@gmail.com</a>&gt; writes:<br>&gt; &gt;&gt;<br>&gt; &gt;&gt; &gt; Add a non=
e target for when no TargetInfo is selected. It is last<br>&gt; &gt;&gt; &g=
t; so existing SYS_EMU_TARGET_* values stay put, and it is not a<br>&gt; &g=
t;&gt; &gt; qemu-system- executable name. target_is_none() and target_none(=
)<br>&gt; &gt;&gt; &gt; report that state.<br>&gt; &gt;&gt;<br>&gt; &gt;&gt=
; Why does it matter that existing SYS_EMU_TARGET_* stay put?<br>&gt; &gt;<=
br>&gt; &gt; We need a state that not a real CPU target is selected( I call=
ed it none),<br>&gt; &gt; then we can use it to list all targets. for examp=
le, do query-targets.<br>&gt; &gt; query-machines(all machines for all targ=
ets).<br>&gt; &gt; Any better ways to handle it would be appreciated, I am =
not choosing to set<br>&gt; &gt; it to NULL because<br>&gt; &gt; that would=
 cause too much NULL-check error, as the pre-existing code<br>&gt; &gt; pre=
sume there is always a<br>&gt; &gt; CPU target present.<br>&gt;<br>&gt; Doe=
sn&#39;t answer my question, so let me try again :)<br>&gt;<br>&gt; In your=
 commit message, you explain &quot;it is last so existing<br>&gt; SYS_EMU_T=
ARGET_* values stay put&quot;.=C2=A0 They do, but why is that useful?<br><b=
r>Just to keep the pre-existing enum value not changed, yeap, not that usef=
ul.<br>I&#39;ll drop this misleading comment. Another choice is keep none<b=
r>as the first enum value, so it&#39;s always &quot;0&quot;, maybe that&#39=
;s better?<br><br>&gt;<br><br><br>--<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
=E6=AD=A4=E8=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=
=C2=A0 =C2=A0 sincerely,<br>Yonggang Luo</div>

--000000000000450763065c8a192b--

