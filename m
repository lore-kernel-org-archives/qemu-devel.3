Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0C66C61DD3
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 06:33:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2NUR-0003OH-1t; Fri, 04 Sep 2026 02:33:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1x2NUO-0003NL-Ti
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 02:33:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1x2NUN-00066n-5J
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 02:33:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788503606;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0etOM5cmtLfobpD3sxypOnezlH2FeQeFpM+jUDcAInM=;
 b=KO37/eisnE9ptF2nashNxaHOrqHNaTdXjkzKjwyF7BWCscuBRe0gA1IPt7tKhzeaZ6Hqel
 f/58GdAKKI1GEtaexpHwNjXxkUIyqx0jGheSLGnLmVgC8EO73kccRp/1jvmNI+Id4HRYfP
 D2YW5EWh8glRATVpAOpCP5LHlXX1pSY=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-538-tsmQa7nxOyO4yxXKIPQNWA-1; Fri, 04 Sep 2026 02:33:24 -0400
X-MC-Unique: tsmQa7nxOyO4yxXKIPQNWA-1
X-Mimecast-MFC-AGG-ID: tsmQa7nxOyO4yxXKIPQNWA_1788503604
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-396b9ef3070so1055857a91.3
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 23:33:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788503603; cv=none;
 d=google.com; s=arc-20260327;
 b=SW07YpUpxGd1M/Rc4/UEBitClJBBmPjhC3/653j18Xycz8Qa+ABtdzhjPL9ndmUKca
 F0QNpS3Pb4euvKp+pSGFo5dox6rKSi1CDQb7db1U4j4JJNfPB9nGPbXMQb9Fd5qrhwYz
 sQj1XuCjNzsjme1XjQIIo7xF7cni6H88rJViOICQJeTmX41TNBnjemM87sPsgDyGlari
 er06U/6iyFmdyoXbig+JNooPE7eUOIqrQmAznL9pxGB2fRfsiAUBSVvwwr25eQGYKC1X
 lpZ3fbunfPt68nPJxAbA4MDuygdV90xcYcGXBf5w0GjNKAQR6UZvR8BCtsuXY0AiKi4x
 LYgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=0etOM5cmtLfobpD3sxypOnezlH2FeQeFpM+jUDcAInM=;
 fh=7DPSRw6g5GamiGdaMXlv5gCdYZJVBtsLbfvJNmgTYnc=;
 b=g/6IHEaLtA0n5+9M6bWyTfSN4EMq6TPPAyZYuJPjKnycY7AlXlUIKJjEcPl0o9jQCN
 leBSWW6ND5NLfMcBHtrJwxV9/TRc+jfg9w+52hh2WWJLTEgFOXzRIQ+p5AsHBz0MGRrP
 PPlKj6pRwkEw60WSX12WKSZynCWt0+e5k/FadLT07azZPFzA8QxBW/pbMknZbxAW7uRo
 kwwyYwa/0ujIEmrxiglnRWDk35AC57zW3h3lZwKvM3VnVtsrFM9lJjaFDVydDDMW+iK3
 kcK6P+zsTJ99ozsrzm0ugAUHan26Yj5S1u4KpyuneVGzGR22iDzsx7sMdn7U/NXM8xH2
 ymdA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788503603; x=1789108403; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=0etOM5cmtLfobpD3sxypOnezlH2FeQeFpM+jUDcAInM=;
 b=L1fsi3RSotZw8psaHQ8NAptzw+g2sNx/OxsOGBDGjIib+J0a14X3nAXmCmTFI7bcD6
 kw76xQYwIq3p+32MCR7Eo3bfC5u8dpAL4fXbr8wcARJsFdPLCR++NRSG3fv8nXWvSOUo
 3K0UEras3lmA0tWLJfC9xlhXXYXzQJWl05kyh5izsu9dIh1eJUobov7wOG9UMPQxqVB3
 /y8Atw0hRW3xJBQ519L/MuQK1Wi/UnKX5F3xu/icHjFIrBlwPrLlWxOp3FHU6VOXEJJh
 W1VK+Enyop8PJH26wItvRl79LcUq1PWoEUlrlNDycNr1DiQ/EejCEBQsVQKno8ithpmd
 gOxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788503603; x=1789108403;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0etOM5cmtLfobpD3sxypOnezlH2FeQeFpM+jUDcAInM=;
 b=NdxFU1Z37P0m4ZLIHnuQUUe4cwWMtICwG49UzUQj7sR4E0UZ85yn2au8ARdLSGnRYP
 UaBWC9rQG/kapJcNBDtPl2tv1oPpiWtUhb98AxYMFqljLu2p0iPMoLy8PXO/gcQrPV/L
 sJbQmFXMiSUDwWMqaMz/4m/KVqQluBcN0KkpoD9bBJd5eVAn29Rnx+sZianjM65OBmr3
 tySKFM4+gp2KVnISJ0oZbfwUTkuCRxDVllwvIpDpoePyYsVYJdoWVjYXYhQxKodulRE+
 QegKg3YztvgxgBRSa+pmz50dp3qGUoKMA5h3B/Vk1sq6dW0kT9/l/RrmM5EPtHUKL4Ip
 +VYw==
X-Gm-Message-State: AFuF++lBbawvmoBacpZUeG3Rxhd2YH5lI/hoL88T4zgYOYcPLkmDts5f
 7qDaQOWs2I91GYLAtxGsrw0AUm7r7u9t40TMW+GHrqUfALB86oerQns8uthCj3o0YmJs/qPZrnw
 6ReO5U+a1c+x+/yBDQw8XlVPNlkxdEBPyID2VnpoJrocH5IPts3IrX/IZcf1Z6GMn/s3/aS3Z35
 ZMG3rTr/XPTnIIpcrb/hdm2DvkGdXd9ovyDfVBb1XG8w==
X-Gm-Gg: AYBFou1cABQxy9VuKjal/yiTEMJSggKwENcJuo0ClZ+DvKlk8G7O74fsXWF0/cerBJt
 qG+qy5d7ee43dLA+T9rSBRp6meBNgXDkeb7KkY2tXF06nlMwzU6myppbLYoNdqIYfkxYI60LVmF
 7QDkQWz1g/slBU8T7n8YQ/1q+k69QkweKKggRGrs4eusaloP0Gdon2szEkjtLXgQ9wl95Qt2u7J
 7wt2eRuOFbv/weaAepOP9CYHRDGwPit5IEFnWPcOOSNKkp/qwzXoyWnF5bm2IcUOkvwktNPOdEE
 pA==
X-Received: by 2002:a17:90b:1a8f:b0:398:d2a0:87ff with SMTP id
 98e67ed59e1d1-39b26101029mr5847802a91.1.1788503603456; 
 Thu, 03 Sep 2026 23:33:23 -0700 (PDT)
X-Received: by 2002:a17:90b:1a8f:b0:398:d2a0:87ff with SMTP id
 98e67ed59e1d1-39b26101029mr5847723a91.1.1788503602752; Thu, 03 Sep 2026
 23:33:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260904033113.1194-1-getshell@seu.edu.cn>
In-Reply-To: <20260904033113.1194-1-getshell@seu.edu.cn>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Fri, 4 Sep 2026 10:33:11 +0400
X-Gm-Features: AcwNN1VU9DvLpZHKkndKplSmA3dxHLh4sJ1qv8h7ym3-7kEqP4PH5Z0QMWkItIU
Message-ID: <CAMxuvaxh53srhyS8MfKdr_GJCgaBv49AVczAkt4uk-GRnYzK0g@mail.gmail.com>
Subject: Re: [PATCH] dump: reset guest_note_size when the guest note is
 discarded
To: Hongyan Xu <getshell@seu.edu.cn>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Sep 4, 2026 at 7:36=E2=80=AFAM Hongyan Xu <getshell@seu.edu.cn> wro=
te:
>
> When dump_init() reads the guest VMCOREINFO note and decides the note
> header is invalid (oversized name/desc or note_size larger than the
> buffer read from the guest), it frees s->guest_note and sets it to NULL
> but leaves s->guest_note_size at its previous value.
>
> dump_process() later dispatches on the requested format.  For
> DUMP_GUEST_MEMORY_FORMAT_WIN_DMP it calls create_win_dump(), which in
> dump/win_dump-x86.c dereferences s->guest_note unconditionally:
>
>     WinDumpHeader *h =3D (void *)(s->guest_note + VMCOREINFO_ELF_NOTE_HDR=
_SIZE);
>
> so a NULL s->guest_note results in a NULL-pointer dereference (crash /
> host DoS) instead of the intended clean error.

I don't think this is a severe vulnerability (dos from malicious guest
kernel + host admin)

> guest_note is only ever non-NULL when guest_note_size was set together
> with it, so make the two consistent: whenever the note is freed and
> reset to NULL, also reset guest_note_size to 0, and harden
> create_win_dump() to reject a missing note before dereferencing it.
>
> Signed-off-by: Hongyan Xu <getshell@seu.edu.cn>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  dump/dump.c         | 1 +
>  dump/win_dump-x86.c | 5 +++++
>  2 files changed, 6 insertions(+)
>
> diff --git a/dump/dump.c b/dump/dump.c
> index 52be7258a5..a2073cea5d 100644
> --- a/dump/dump.c
> +++ b/dump/dump.c
> @@ -1906,6 +1906,7 @@ static void dump_init(DumpState *s, int fd, bool ha=
s_format,
>                  warn_report("Invalid guest note header");
>                  g_free(s->guest_note);
>                  s->guest_note =3D NULL;
> +                s->guest_note_size =3D 0;
>              } else {
>                  vmcoreinfo_update_phys_base(s);
>                  s->note_size +=3D s->guest_note_size;
> diff --git a/dump/win_dump-x86.c b/dump/win_dump-x86.c
> index 0dd0c503c5..97c5e3e0da 100644
> --- a/dump/win_dump-x86.c
> +++ b/dump/win_dump-x86.c
> @@ -445,6 +445,11 @@ bool win_dump_available(Error **errp)
>
>  void create_win_dump(DumpState *s, Error **errp)
>  {
> +    if (!s->guest_note) {
> +        error_setg(errp, "win-dump: no vmcoreinfo note available");
> +        return;
> +    }
> +
>      WinDumpHeader *h =3D (void *)(s->guest_note + VMCOREINFO_ELF_NOTE_HD=
R_SIZE);
>      X86CPU *first_x86_cpu =3D X86_CPU(first_cpu);
>      uint64_t saved_cr3 =3D first_x86_cpu->env.cr[3];
> --
> 2.50.1.windows.1
>


