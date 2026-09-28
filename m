Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C980CA5FA3
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 19:20:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBGsc-0001vq-RR; Mon, 28 Sep 2026 15:19:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xBGsU-0001r6-RJ
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 15:19:07 -0400
Received: from mail-ed2-x0f.google.com ([2a00:1450:4864:33::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xBGsQ-0002EH-J9
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 15:19:04 -0400
Received: by mail-ed2-x0f.google.com with SMTP id
 4fb4d7f45d1cf-6aaeeacce15so4940444a12.1
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 12:19:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790623141; cv=none;
 d=google.com; s=arc-20260327;
 b=BMWIIbw2gu0xZumqWtJOueOBvUxi3HMYNdpWueAeH4rGO+sa+cDuyBnxfD0A8/li5v
 D21DUiVhIwzjlUwqXd47u3cLc4lQ74AtQQox8kt0BKdDopUar6fYMSkfYzfdD/R6VHkK
 pwI2A0JIg1N2ijjFhRg7TrCgIXICyXgKm0HRvNZNAsed0Rzeiebtg/1U5G3FasRbVIFK
 CUf0mnQXbb/HnGrz2rAM2rVxb8gZ1NcevZAm3XDjUfpop+xXAKlRrvTg725fZorP0nGH
 Cvjr4GpgD8ZTbxMU3n0eCEEjAcYMrtwB8GfM+giAOoRftbBMakI1EKaGnfuQKnfFYSgY
 Wrzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=sYv4OegR8GqzCvAtnvT8UGGBWoOzF0nsQRUN1o16Udw=;
 fh=L5DxBuLrDJrdA59IsArJEicmi2vC0sNFLDzwGjUWysM=;
 b=Tph0TztcyExfBlHHjrcy0iqF0w9Aku7ZZcpdtoqQ/5xmik3WOfz6aMIR8VkIXGek1R
 EjD/+DpdarcX1w3HapHJz94VSHPkLL3/tQbFcZbUM+/qLmTXNv2TyZLyBi6Uor7Oimem
 R7r0G+lH8pO/4XI7ykPWGc5LjshZ5I5a/Taa+SicszlRM7NSz3YC4kP9u1jX0ahnJuLB
 g9cbDMTv8+XaizT/+D48TWiCeIuJdBeaP7dlws7iwuagl3PRB6Y5BYYDCq0h8MZlk73Y
 lOrc/4c7gPgL5FWdSmrOVCs11GRwCWa8EYvD0IhOP/B3YESRvXbbAREjojJ9I19AuTa/
 cA8Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790623141; x=1791227941; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=sYv4OegR8GqzCvAtnvT8UGGBWoOzF0nsQRUN1o16Udw=;
 b=sd2AfIQVrGsPK9v+Op4wqRsH4CwAqs81eV9d+SlmxowSqaTkqhRUIrjp00BjJhsjTE
 T21zDWGrn/2sgDC8Qujy4VP++bFMYVIvKSzV/5J2sd5AeEZyMsye0EwI5loxvRXZfZgy
 MzJvRMPfnwAChKElOyzcn+aeEmaysgvesCCYxqDmPfzBR5A3Nw2upliu5R7zRvT4nH4M
 s+5oH43KECMsweeQ/lqQ8YZ3u39oQfCFvW/WqkaOqpnWiZd+Wi7tY7X00tNxHry8QyHM
 iZWgd3A65/QUAwdXEiFTBA5QqjnVwxzvyntXc+olLB5gxoLduiL6ovSCFqiL7gDoTIU5
 Xw4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790623141; x=1791227941;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=sYv4OegR8GqzCvAtnvT8UGGBWoOzF0nsQRUN1o16Udw=;
 b=XYDtp394LPVCi0nYVx3nWttqd3R5BhRW1MuqgCZzT+2MuDL9tjZBlhibW357imDyhN
 61wpzvzqIR7jbT4ddSqOKKjpkqzPxIfh8w8zZnOWT1C3WE4nc5ZwcvOtldpdpSpHDIih
 LiPgL9pWsMEWm+jKQqFfa73MuDzyWdw+D1c8jJ07UOXNM3UTUASOhkNdUNa14lsqu9Dk
 ObwuC6K+UlcmAq9k98VC2bbVXrp37F3Q/3nk7z5wqRNygj9MS3tzhgL3qaXD8lMNRcvk
 AplaYX1mHWkWO8eLYXU7pIZjJEo7Z5e46hY7+GCeQmoqWUor620CZWk+djaX+3aJ787s
 9LsQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzEiC2ZkkgM18MBQGjUxJqz0AwjzaMwkgFV5G3sc67lk1Jl5zdgTaU630GxqOJVA0b9yWQtnFoMorBS@nongnu.org
X-Gm-Message-State: AFq9FYL0WIwpWl0bv/TOylmpULU7/sk8iiRdqBIG14dZPKld9S+rcSEi
 xAnM8e+hF4KRe4/EQCzqWSBlE5B4aLhZpQbiCwOfjNaWr1YJz0sKxq/mCwEHUme9kumMfAMZiYp
 aNe91KlAKGqlHmDxsVEDZ9DY5YuIlW2g=
X-Gm-Gg: AYBFou2I55iSQXSSmGJW1PMPeaB9cciH0RYiTnf7GUZIOQZoN08KNwWImVqptvs8Gn3
 z9eu4zimU9v1daVlutWpS70wUZx9zx/1WzwXJqTY0zugzrpWE6vqgQ2Te7nsx5fhnPl+wYPbkZm
 qScTW9HFooT6DLGuOkvWb/74txhRXPZCUiiAi8BT+UiMfJ1ZbGo2HGppZVivOqPOUhDX2dUP+Jh
 0uh8vsHWm7x6TCFzb0iorzRT6gSsSyOng/rDbjWrQPWdp3H8Uehw01ZAISvE5+dROyDHnWIA1gM
 d7m8f/O3CPFI6jJ4wVQt+Y40LPvfCzhh5gBD7Eync7GwFEOg+h2/+T4=
X-Received: by 2002:a05:6402:5356:20b0:6ac:70ce:ba2 with SMTP id
 4fb4d7f45d1cf-6ac70ce0e36mr2537042a12.39.1790623140222; Mon, 28 Sep 2026
 12:19:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260926070057.1234-1-luoyonggang@gmail.com>
 <20260926070057.1234-47-luoyonggang@gmail.com>
 <aro93NuZBXYGbD33@redhat.com>
 <87e7c5ae-c78c-4a47-b9ba-9851ce5757d9@oss.qualcomm.com>
 <CAE2XoE8Fp8w4m0WBjEXF3LceFXUqKDcXhdSmhCThgkAM3wRVaQ@mail.gmail.com>
 <1f46d3a3-1275-4ae0-be07-717c643cf0ae@oss.qualcomm.com>
In-Reply-To: <1f46d3a3-1275-4ae0-be07-717c643cf0ae@oss.qualcomm.com>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Tue, 29 Sep 2026 03:18:47 +0800
X-Gm-Features: AclHuK89rkx8dUCUIYddhlG0R2D4NPzT6encjJAYmGIfANm--plpg3p1dBox5j8
Message-ID: <CAE2XoE_0P5M_WNXcREVL+5h0JOVnGiiE+-bPve5dX-q1f_5uZA@mail.gmail.com>
Subject: Re: [PATCH v4 46/55] qapi: add query-targets
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 qemu-arm@nongnu.org, kvm@vger.kernel.org, Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:33::f;
 envelope-from=luoyonggang@gmail.com; helo=mail-ed2-x0f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Reply-To: luoyonggang@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Sep 29, 2026 at 3:11=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
>
> On 28/9/26 20:34, Yonggang Luo wrote:
> > On Mon, Sep 28, 2026 at 6:39=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <
> > philmd@oss.qualcomm.com> wrote:
> >>
> >> On 28/9/26 12:13, Daniel P. Berrang=C3=83=C2=A9 wrote:
> >>> On Sat, Sep 26, 2026 at 03:00:45PM +0800, Yonggang Luo wrote:
> >>>> query-targets lists each linked target, including none, with its
> >>>> arch, endianness, and the machines that target accepts.
> >>>>
> >>>> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> >>>> ---
> >>>>    hw/core/machine-qmp-cmds.c | 30 ++++++++++++++++++++++++++++++
> >>>>    qapi/machine.json          | 35 +++++++++++++++++++++++++++++++++=
++
> >>>>    2 files changed, 65 insertions(+)
> >>>
> >>>
> >>>> diff --git a/qapi/machine.json b/qapi/machine.json
> >>>> index 6aaa2af709a..d8cdea6203e 100644
> >>>> --- a/qapi/machine.json
> >>>> +++ b/qapi/machine.json
> >>>> @@ -307,6 +307,41 @@
> >>>>    ##
> >>>>    { 'command': 'query-target', 'returns': 'QemuTargetInfo' }
> >>>>
> >>>> +##
> >>>> +# @TargetMachines:
> >>>> +#
> >>>> +# One registered system target and the machines that can run on it.
> >>>> +#
> >>>> +# @arch: the target architecture
> >>>> +#
> >>>> +# @endianness: the target endianness
> >>>> +#
> >>>> +# @machines: machine type names, not aliases
> >>>> +#
> >>>> +# Since: 11.2
> >>>> +##
> >>>> +{ 'struct': 'TargetMachines',
> >>>> +  'data': { 'arch': 'SysEmuTarget',
> >>>> +            'endianness': 'EndianMode',
> >>>> +            'machines': ['str'] } }
> >>>
> >>> We already have  'QemuTargetInfo' struct which is used
> >>> with 'query-target', that should also be used with the
> >>> new 'query-targets' command.
> >>>
> >>> We need to add the 'endianness' field to QemuTargetInfo.
> >>
> >> Why do we want to expose endianness, and what endianness to
> >> expose? Endianness is a runtime bit state of CPUs. Sometime
> >> this bit is hardwired but that is an implementation detail.
> >>
> >> See commit 0e2c5647d92 and surrounding for MicroBlaze for
> >> example.
> >
> > Please take a look at
> > https://gitlab.com/lygstate-qemu/qemu/-/pipelines/2890507627
> >
> > I do not have clue to fixes it properly
>
> What are you asking here? I'm seeing failures on targets supporting
> dual endianness. I can not try to help you until I understand what
> your goal is (I asked it multiple times but you don't reply explaining).
>

MM, let me try to explain it.
The machine list of mips64 and mips64el is different as follows
mips64_machines/mips64el_machines,
and the two lists are generated from original qemu-system-mips64 and
qemu-system-mips64el respectively.
But TargetInfo::target_arch =3D glue(SYS_EMU_TARGET_, TARGET_ARCH), so
qemu-system-mips64 qemu-system-mips64el
are sharing the same SYS_EMU_TARGET_MIPS64 for the function
target_arch(), and it's returned for
query-target/query-targets. so we can not distinguish them.

And I want to deal with this issue, here is one of my try:
+#ifdef CONFIG_SOFTMMU
+    .target_arch =3D glue(SYS_EMU_TARGET_, TARGET_SYS_EMU),
+#else
     .target_arch =3D glue(SYS_EMU_TARGET_, TARGET_ARCH),
+#endif

Is this proper?

static const char * const mips64_machines[] =3D {
    "magnum",
    "malta",
    "none",
    "pica61",
};

static const char * const mips64el_machines[] =3D {
    "boston",
    "fuloong2e",
    "loongson3-virt",
    "magnum",
    "malta",
    "none",
    "pica61",
};


--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

