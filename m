Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CDEACD5BAB
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 20:23:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ9vJ-0006mX-9x; Thu, 21 May 2026 16:23:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu-daude@linaro.org>)
 id 1wQ9vH-0006m7-6a
 for qemu-devel@nongnu.org; Thu, 21 May 2026 16:23:15 -0400
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu-daude@linaro.org>)
 id 1wQ9vF-0006Vr-DV
 for qemu-devel@nongnu.org; Thu, 21 May 2026 16:23:14 -0400
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7de4a9cb8eeso6321075a34.0
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 13:23:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779394991; cv=none;
 d=google.com; s=arc-20240605;
 b=P7eTg+w7TZF+/EGC97MarYXvRiEPGNq1knks5JAuIUXmyFcrREuaWhK90S0xHVdXAw
 opoUvnQLSyM0wWcDWVAap16xlFjj6tjsKewtu9SbjETLPUKhcXvvghUE6/im8pOw75t0
 SoBLROMgGYgUe6De7iPtwNkQXeM5OoIzVyb2eYzt90fPVv/kIMexIsMm/zIzNn8ivdt/
 dnlh/7onrA9TUV4Ldq+DfejiJfA+pRHHPKDF6vTIBBHJUsKv29rNBm0F4nxEdOruTKpj
 DOOHDl3A3cc6e2/8R3G3EkFpwNAN5XluoGOLI+wpFzAQzrwjwPfgPwyj3bSIdn7m28tG
 G1Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=1gIl/RWVDwaEROFkXowJ1p0hgsmAtHIDo7Wuzc/63u4=;
 fh=6ffLQ+J6wy7DbiFgE6+6JtPfptxxW3nmANMA0IjZSm0=;
 b=BrZKlfCeAYjByD9PG8I2W3B24cU6N4a0B6Sxpli6WPmtXyXzMS9gsOSM0NoNGdje/3
 Z2IJxW7VwKizqW5swDvudQYTjxwx7ld0d5A0P8Ga+S3BFlUOdAHYW422sPzM4wEf4Pnm
 EXoydEbLCuvsiz91EmWt0E7r4Kp7vkWf0k+DpqpTnzas6GxTbety3UFkceoVNN8aLQNA
 8x4wuRlRzBuZf8LhdFVX/COCJcZD4VnWxRxcp3oRoCdOOEQKSRtXpqE+P2mTkLx8chGw
 5qRFXLeaA7Kwkt0LS/KtviQBDl+feaMIxw3vL8a26eptj7xY90MyKM5DdcEbKMQqZiQa
 nrTw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779394991; x=1779999791; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1gIl/RWVDwaEROFkXowJ1p0hgsmAtHIDo7Wuzc/63u4=;
 b=YSdK2swSEqGLN6CwvO8D4ENQ364uZncWmFKpn72vhkT43G8xN8oe6OzSAC3FZaz6OW
 8kN59HZgR4atNgRY+EsDuqJHt6yr4QUxnik5Vxt9qtA/IZTxxOdnFsRu3r6nnU24fDwA
 IJ9j5aPsRNuzG9fbBApelXxB7omLMG605dYoRhcHX48cgOS7QUr2t5HzrCsrl9JoI55l
 wHWApeS59zADKtiJpqKUnFNMaGekuGyPqxrZPgo4jptdpKVz4bJsMdPp39xXHRw+OpEN
 C7xk7wbNVO5sHDnlNZhRcAscjYChuTx8GZOSzyyV8KyvddcMO69GHmFDEFb3hnBpBfDW
 5CJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779394991; x=1779999791;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1gIl/RWVDwaEROFkXowJ1p0hgsmAtHIDo7Wuzc/63u4=;
 b=bLTz5z3vh0B45Xcn9NGfHkdhShAjX+0lqi7YERMeHTP5sUhtJ432MMsyscEOsAvYzc
 pjlgqc7AoC6h6j90vMHjkmflMSdYe0sV7pNknJ0oF2vqMq7toYXsg/2aP3gtq11AaB75
 bAwdaGZ1YWhU/lBcZJM+ZKPX5+jA5hg2e2W4ziC/0d/7nxclI5Tj6YIa/uhqS/iq3KMm
 6qZnsB5T0puPrvdEOKtRDcdnEwjWwGsJHLVJlVhCoCVxPBl+uvBFD4lIHnUp6GEG8bho
 2koiClJp8JRhbewmj2tNGlVHkvq6TGsNix9eXnFxvXtou+SkCDr233n5x6jP2IvpbNy5
 fz9A==
X-Forwarded-Encrypted: i=1;
 AFNElJ/5TkmZwPnmVBrS+PGraZYH3twlVnNX5ozK/knlPL2VEl88kv3mTF2G4xmcViR4L5kAS6SZMgRgNXPM@nongnu.org
X-Gm-Message-State: AOJu0Yyqt+70g0t5VlcnqPWi9LYLll8doI2VySw8Vi9FmCHDnoxV5WG8
 H9oUid4PLvCdzbHeXUglQCTwRyPqOBd+V2zjU7/BpBrs4w1VvdAjnxS9bCYKWJucMaatOz2WqNi
 7gRuR6hSv6TSIv+TT/+cVDYpRRVtgcw6/TddSLtF6wg==
X-Gm-Gg: Acq92OGwp0ZHk7xY/6X+7RHcAewVHfpyQNP91ecBr8CeqJJCSrx7glhhQpZvgQKIfJA
 8OXK37kfLLfZOcSgGKVSF1uEHOLsajUFBl+aBksFiHJmynXRjP9K4sYGsaHOOtNoIvlN5Gh8W4v
 sc2G+nSVQGKGqH//6plghCAIBhFXfWsQkgQUuAvoCl7xmzt5oQpgjf+VCSKTCI+tmadA3cmFZYu
 8RtGf6IUOxBxw9PsAEioiilEgje2GbiAObm2vQTmwS7VFfF55uYPK8fPzsfR17igPCMhK5hHDRl
 a1ciZVlYXL4guSoqXA==
X-Received: by 2002:a05:6820:151b:b0:69d:6bbf:3feb with SMTP id
 006d021491bc7-69d7ec8358fmr369708eaf.42.1779394991075; Thu, 21 May 2026
 13:23:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260519-mips-octeon-missing-insns-v2-v10-0-306f9edfe15b@gmail.com>
 <52b9ca7a-9ac2-4e0b-8394-3e1f167560e0@linaro.org>
In-Reply-To: <52b9ca7a-9ac2-4e0b-8394-3e1f167560e0@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Date: Thu, 21 May 2026 22:22:58 +0200
X-Gm-Features: AVHnY4ImVF_4msCCKLDvdI5yoRTeGCx5o3RWg_RDLfJdhx6KTSfvUoYR4bM32pA
Message-ID: <CAPMQPELA36GSuFhEfvgONzNYMcNQUzP6_m0FXbLjp2ZUeu-maQ@mail.gmail.com>
Subject: Re: [PATCH v10 00/45] target/mips: add missing Octeon user-mode
 support
To: James Hilliard <james.hilliard1@gmail.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Aleksandar Rikalo <arikalo@gmail.com>, 
 Huacai Chen <chenhuacai@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::336;
 envelope-from=philippe.mathieu-daude@linaro.org; helo=mail-ot1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Wed, 20 May 2026 at 12:00, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> Hi James,
>
> On 20/5/26 06:36, James Hilliard wrote:
> > This series updates MIPS linux-user unaligned-access behavior and fills
> > in missing Octeon user-mode instruction support used by existing Octeon
> > binaries.
> >
> > The first patches model the Linux/MIPS sysmips ABI pieces needed by
> > linux-user, including MIPS_FLUSH_CACHE, MIPS_ATOMIC_SET, and the
> > MIPS_FIXADE policy used to control unaligned scalar access fixups.
> > User-mode unaligned scalar accesses default to software fixups and
> > sysmips(MIPS_FIXADE) can toggle SIGBUS/BUS_ADRALN behavior.
> >
> > Richard Henderson's v7.5 multiplier/QMAC rework is incorporated directl=
y
> > as nine patches: two TCG preparatory patches and seven Octeon
> > multiplier/QMAC patches. The Octeon multiplier and QMAC translations no=
w
> > expand inline in TCG.
> >
> > The remaining Octeon patches add integer, indexed memory, atomic, COP2
> > crypto, CHORD, LLM, and CvmCount RDHWR support. The COP2 work is split
> > into state, helper plumbing, per-engine helper patches, explicit
> > selector decode, CHORD/LLM, and smoke-test coverage, with each
> > functional block isolated. The series also adds a small
> > mips64/mips64el TCG guest test covering representative Octeon integer,
> > fixed-point, multiplier, RDHWR, and COP2 selector paths. The final patc=
h
> > corrects the Octeon68XX CP1 feature bits and FCR defaults.
>
> Thanks for this series, I really appreciate your dedication and the
> quality of your patches. I have been trying to queue it since v7 but
> you keep respinning :) Since the first half is stable and reviewed,
> I'll queue that first and send in my next MIPS pull request; less for
> you to carry over.

Now merged as commits e83a42cbf72...006d624b948.

Rebasing the rest shouldn't be too hard (changes are
obvious, I also moved the TRANS_LX block around).
Tell me if you have an issue rebasing your work and I'll
repost the remaining patches.

Regards,

Phil.

> > ---
> > James Hilliard (43):
> >        linux-user/mips: implement sysmips(MIPS_FLUSH_CACHE)
> >        linux-user/mips: implement sysmips(MIPS_ATOMIC_SET)
> >        linux-user/mips, target/mips: honor MIPS_FIXADE for unaligned ac=
cesses
> >        target/mips: fix Octeon arithmetic destination handling
> >        target/mips: drop Octeon zero-register fast paths
> >        target/mips: split Octeon SEQ/SNE decode
> >        target/mips: add Octeon LBX instruction
> >        target/mips: add Octeon LHUX instruction
> >        target/mips: add Octeon LWUX instruction
> >        target/mips: add Octeon SAA instruction
> >        target/mips: add Octeon SAAD instruction
> >        target/mips: add Octeon ZCB and ZCBT instructions
> >        target/mips: add Octeon multiplier state
> >        target/mips: add Octeon MTM instructions
> >        target/mips: add Octeon MTP instructions
> >        target/mips: add Octeon VMULU instruction
> >        target/mips: add Octeon VMM0 instruction
> >        target/mips: add Octeon V3MULU instruction
> >        target/mips: add Octeon QMAC instructions
> >        tests/tcg/mips: add Octeon instruction smoke test
> >        target/mips: add Octeon LA* atomic instructions

