Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F278C44500
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 09:51:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1virLa-00005X-5Z; Thu, 22 Jan 2026 04:51:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1virLU-0008PD-Nq
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 04:51:20 -0500
Received: from mail-yw1-x1131.google.com ([2607:f8b0:4864:20::1131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1virLT-0000eA-8k
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 04:51:20 -0500
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-7927b1620ddso11725957b3.0
 for <qemu-devel@nongnu.org>; Thu, 22 Jan 2026 01:51:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769075478; cv=none;
 d=google.com; s=arc-20240605;
 b=SsHuVgZchSt7Cj11Iuuw002d16nLYl2KdSFvMRLY8u0dER08lwuuvNvVT0AS+WB+0m
 VNfdTfirT5iYYyMf5Z6SfHckbUEroFGsWGyyGArZrJ8vM2yonVX8ZK/8uesfRAgHABN+
 lLSnKjMfXdRPYlW0bYZGZKKs6IWGghF4KQcFmtJEvtz3+a52eli2xSzqKAdcqk+XhRYw
 pVPnNhZ0lVRd6ZaJCSIPh2AyDsOYHv83wFZSYM7YKcBkYzNc2JwBfMSrp0rvWxoDBaAR
 EQ7Kq9Slf3jllCbe3cmScGET7eGNOI89VtoPFBnIEJA3QjXqOVniXZZRKXIaX3Xns9NC
 oUMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=dewmaZmaywvDdIwvZ0ISW+WK8+ioPOvWKQ4WEuh876M=;
 fh=c7OX6qx0Pf6pdKWJ5yG3GEuX5W55rBiSgcKo8ryp0eU=;
 b=NPO3fo7FmhISZEe5Q/eiP1DYpUvew5NXIzOoBoRMaOLYmPF50dXmGd+Z07zsENpxQr
 X+9FDoWDWI8xOL58BA9fpsa4RC5B/kN4N8toMHYpJqXP7mKVJcO/d+2Hx5edGr9DJYsG
 5nmlvt1jnpI7EBR5u/Wx6tBmoxm1x48rDCU/+J2oicyF7X2BuzdupON8e/jXa4xNnX89
 z4QG5M3VRwV+5MMskaSk+geFAMLCY/icoWQvq1lNrIqCOT6+vuG8nCYPTCEfm4QLfAp3
 XDzc9DEBJPP6NX6dF+CZs3t08k3SAPuK0gxr5g+/9XydrvYFEuSIPeokQdzfwsfHKtBX
 K/dA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769075478; x=1769680278; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dewmaZmaywvDdIwvZ0ISW+WK8+ioPOvWKQ4WEuh876M=;
 b=qE62eXxA64mgnb9bG6T9lnQDv7+UYkqECcHT506iEQDMHlkH+l7icZ2ba2RB7OUi3Y
 xQnvcAkRNLy5MV1Df2EYYWi2VW3E/+f4Uj6vKUmNoeE1YuKLPxTC6rLrj0FWN0gYNKw/
 3hmNlqQq7/gDoSIKjA2lbSmCSup8rjZnUrxCtsd6TcAy7wfy71+cnK/eHYm5qA4aflMt
 aa3My86SaYn0xGDWaUduKlzUnzKc0cYBzDL487MfWygFdIIyDZaFA6WpT5Aco+hGxOp/
 7hF1PJ/L4vWC5SG3PvtJZsGlhnlbBLBaz2/zYIdSJUZaa5ivTeb8emdISDhZjQsBiMwb
 LJ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769075478; x=1769680278;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dewmaZmaywvDdIwvZ0ISW+WK8+ioPOvWKQ4WEuh876M=;
 b=ZFwoWd/FUn9xRtIBriIYcqWyF/rUbGmhZnvsLXt1YpZspuriBh+SVUwn9kir5yf7ix
 iUadHKE0M/uXCzjJY2sytcyRHD2s2xi/40hyFUxFoxUJb5FWW0uwOSNBz3FyZXgr/Tew
 dUIwnbzUnY4I9CblxyoACSYMFToeLAamCzfSXvKO5YSjKrNLcrUlgV+uR+tV87rIjUsZ
 iM7yH1SjAVx4qe1F2nsg48X4bJtm2KGF9Paw1HcRKMcEh3xckrELmOq5eZzhh3KZRi9G
 W4onKSlF2lb7HMMU+sozwlqCKD+l5Rx34GQTg6UlogVcie/mmlVbsBFI1BhpactvVxHG
 LBVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV3AZkeuolTfITs/fTRMOC84EFwLhzCWfzdAO3p3u4zzXyoFRAG5fmJZ1X0FhBUf9bz7jXNp9AZNIhu@nongnu.org
X-Gm-Message-State: AOJu0Yy2U3Y71s1NUgBHmm64Fyaadl+C+GKpWq7mTdUw/uKA/s0oWmYg
 T7QcJXFqAm86fEQGgcWBaaSj9ndFmGQC35YIbZx4tpfLPISif5lVIioUGasZ4D2vRwYdmKpIehJ
 vz02ZMvpsHh44kt3cVx8CNCDwoQXPMisCcQjKdVZ/1Q==
X-Gm-Gg: AZuq6aJ80x4h7qHFNze5pv6+X/Tc2zj9poPqqMCNBPG3iQ/vP+CFxZ/1NkKpdwGenYr
 2uSAIgmDZ9wGTY8IAm2C6PQ8RaTW9+SI2Fzsy16sRbrAUQK9NswNmIOnJavFT2IIoWgv7peMvuv
 JOJFoy2Rpf+sxLVP5ZomGDnBpoL1gar8u32HIaBRraDLXMMUDBRmOqhIwYLulNnIwsPaZ4yd7lp
 KWt06gr/Ye0aVEyhVeijjQ1P0wHvlMpNJ91VITSIAnGe7TK6mC0OpqO/qoGvpmf+0qPLw==
X-Received: by 2002:a05:690c:22c8:b0:793:db35:6af2 with SMTP id
 00721157ae682-7942a719fd3mr20221547b3.3.1769075477705; Thu, 22 Jan 2026
 01:51:17 -0800 (PST)
MIME-Version: 1.0
References: <20260122090352.9901-1-thuth@redhat.com>
 <aXHtxBfuIRsJ3P_M@redhat.com>
 <CAFEAcA8QNKwmOndVbq3eTkihpKjD0t01mAJ7DJLOQA3JqkkmWw@mail.gmail.com>
 <aXHxWbvjB9Lz6dKO@redhat.com>
In-Reply-To: <aXHxWbvjB9Lz6dKO@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Jan 2026 09:51:05 +0000
X-Gm-Features: AZwV_Qixzc3Jf-keFI0Hb-TXBIo7I3zXReW9N6jwbmfQmWvLLN5eANolpc2WvB4
Message-ID: <CAFEAcA-RTp33346ybTeixVp5+iyUp4Nbme13Vs=24FWzNMG70w@mail.gmail.com>
Subject: Re: [PATCH] Replace CONFIG_WIN32 with CONFIG_WIN64
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-trivial@nongnu.org, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, Kostiantyn Kostiuk <kkostiuk@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1131.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, 22 Jan 2026 at 09:44, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> On Thu, Jan 22, 2026 at 09:37:37AM +0000, Peter Maydell wrote:
> > On Thu, 22 Jan 2026 at 09:30, Daniel P. Berrang=C3=A9 <berrange@redhat.=
com> wrote:
> > >
> > > On Thu, Jan 22, 2026 at 10:03:52AM +0100, Thomas Huth wrote:
> > > > From: Thomas Huth <thuth@redhat.com>
> > > >
> > > > We stopped supported 32-bit Windows hosts a while ago already, so
> > > > let's rename CONFIG_WIN32 to CONFIG_WIN64 now to make it clear
> > > > that this switch is not about 32-bit Windows anymore.
> > > >
> > > > The patch has been created with a simple sed statement:
> > > >
> > > >  sed -i s/CONFIG_WIN32/CONFIG_WIN64/g $(grep -rl CONFIG_WIN32 *)
> > > >
> > > > Signed-off-by: Thomas Huth <thuth@redhat.com>
> >
> > > > @@ -2422,7 +2422,7 @@ config_host_data.set('CONFIG_GCOV', get_optio=
n('b_coverage'))
> > > >  config_host_data.set('CONFIG_LIBUDEV', libudev.found())
> > > >  config_host_data.set('CONFIG_LINUX', host_os =3D=3D 'linux')
> > > >  config_host_data.set('CONFIG_POSIX', host_os !=3D 'windows')
> > > > -config_host_data.set('CONFIG_WIN32', host_os =3D=3D 'windows')
> > > > +config_host_data.set('CONFIG_WIN64', host_os =3D=3D 'windows')
> > >
> > > While relevant to qapi file conditions, from a C code pov all of thes=
e
> > > are redundant as the compiler has all these facts built-in
> > >
> > >   #ifdef CONFIG_LINUX =3D>    #ifdef __linux__
> > >   #ifdef CONFIG_POSIX =3D>    #if !defined(_WIN32)
> > >   #ifdef CONFIG_WIN32 =3D>    #ifdef _WIN32
> >
> > checkpatch will warn about use of __linux__, though, so
> > hopefully we don't get more of them in new code:
>
> I guess I'd ask why we consider __linux__ to be worse than CONFIG_LINUX ?
>
> Every contributor we know __linux__, but CONFIG_LINUX  needs QEMU specifi=
c
> knowledge. It feels like we should prefer the choice that everyone will k=
now
> *provided* they're both functionally equivalent.

I guess my take would be that part of the reason for the warning
is to nudge people away from "just make it #ifdef linux" and
towards "make meson do a check for the existence of whatever
function or feature I care about, and then ifdef on that".

Also, I know that e.g. CONFIG_WIN32 is definitely going to be
checking the right thing and will have abstracted away any
odd complications in what to check. I don't know that and would
have to look it up for the things the compiler defines.
(For instance, can we just look at __APPLE__ for macos specific
code, or do we need to check __APPLE__ && __MACH__ ? Currently
we have examples of both in different places.)

thanks
-- PMM

