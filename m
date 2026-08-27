Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6901AC5DF9D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 04:58:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzSBp-0003Rt-Ba; Thu, 27 Aug 2026 00:58:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wzSBo-0003Rl-F1
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 00:58:12 -0400
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1wzSBm-0000vv-4n
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 00:58:12 -0400
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-3a12ffc112cso5580951fa.0
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 21:58:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787806688; cv=none;
 d=google.com; s=arc-20260327;
 b=FDqOpT8qhKXYLLOxXdFK2UCgazxEahsddcP0kLODksZY80Y1bYvUk2nK9FpYO9Qjhe
 WHZrvdv4I3Uw4Huzs0SjpuMhTM4W+nuCcAKAMoWz3vKr3tC1aVzsYBeHRsIIzQ9Tm3bL
 rerDQMGinflCF2W7YrpefR87yWuTu7qS1Ook1yU4b3Yq3MfQpKrPXE+TcvbmRv8l+Iu9
 88mDUCDNVZmheh5nzV6H5m67vzKm31gvehe/BD25Fg0BWxg5hsZfzw65AT+Xy3FXfO3j
 Uzs1IJXoKVJrmQx9IFcFcPCNpS+0an/W5R9Na0oBtMu6U0lrGsdc8aqeGPLcDftudzsd
 DUXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=CnupKhdJcINkIfV0lifxag4jkVxr0ComsL81cMCk+f8=;
 fh=JPyNvPMIwCrkCRfC7AfOHa3V7KQSEuSbWu8g6CBWLw8=;
 b=BKV55iwb1fyjnkqNSjEt5JPEroJuvawNDa+S3mnVwhFgpfTwzReuck3NK6T3ubPRFx
 JOx2WAkkAy43Lz/IKgUtdFQQZATkce85/5JrkTJ02k22oHHBM5cY1qouiK4Bs1UvrwKE
 ajIos3R42RR7OJQILIj6HrTnqFc/PFe3tGfIBPoXp+x/wem79rANtzuQZmnq758A8ZN4
 Ua9EShEg8EDUfJ+gdQvvhsFH1nRQNNhjJcPzL4yiKIa5D483J58C9ivSTAB8ro0iF1WU
 oc+Oij4i8V2+wQulBw23h81fhYMpcVMhihTNcqxAG+huYVLOjrw1NU22HJNgbGUK+QhV
 IyRw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787806688; x=1788411488; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=CnupKhdJcINkIfV0lifxag4jkVxr0ComsL81cMCk+f8=;
 b=g0isRkKEMlnkZlZqnY2K0C3ngYpQOMgvBtXpri+NgbBYBTbs7ziIJP4LyxG4eA2Obl
 IccL195yEIa4SkM881w4OHrWmFIJt4bH2rOYCl2OpIApOj7MPF8FDCYD5xbj6rS7M6/K
 gATz+TaMFIVSzLW+QsPL3oZo/yfTfg0GAFNEY0dPjphnlmVasFaaJEnRtnf8AQZkS+5P
 clx6Lg7aRh0VIt2+L9wn5o8+nxhDm4HwU4rYTfvOejK+fbv2vrTOJ0zO4fnrmaQOT5m6
 PiXk1kWZPWEhyN89c4jj2L9SqjQ0ptfuJ+pcOYLmusW3+Z1BCTAygAV110QfPCCNZcwO
 cMmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787806688; x=1788411488;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CnupKhdJcINkIfV0lifxag4jkVxr0ComsL81cMCk+f8=;
 b=hVqzTUxKpkZEnQUUyiHH7hF18bmoXPbHGNXcD3OL2LqmsAZRgj+2gY+Rh4yNXjpsyC
 jDXQ9Z7SFGewxi/AehIArRQtIunVxXqOBhl+X9sBM9eo8BoUW8jzS5AwqUMgiMkWJyl0
 TySygNnQpoLgrxK74y3Htj72j08xuw5yMER3xT7qDQUCkVEG6akk3oYBIprRwVR0q8jc
 Grax18uJlcLl12JrkMe1bUdSgl44p4OHUV8/4m47T7311RmINDr/Nt0YsPN5d3EAWfqj
 XdzFJfVLosVeQgx/goubjQQ+NHAPDH5+XvVyn3UJ5+hM/L0FUHqBOVcuTvpjsLedqB2k
 IGCw==
X-Gm-Message-State: AFuF++ngdM277OM7LnlBPvQAkvePwMA8dVhcXAJZjcUYeJ5YD6+6lH6c
 UTxjdaBGX3iogs+hgicsdJwPT64w5+lMjvPuD8yS2Z/NBfKxqgHulypvKZ3Uv0Q0JAOBUgmcMMW
 9TxNnDqo9+2vhwHqii71t1x+HVoFQd08=
X-Gm-Gg: AR+sD126lkZxOuffyGN9HrJ5zEk6bDKdnKj6YcdVArsPRvuZIOf84x4/HvhmXIwIpW0
 5RZuIBtNnVZafi0rekYWDRr57TQL8UxD6x2rdVjeKyViqrSyrjzNKXH+aMpvZVzE5aMQxP4qTJa
 3Knu+NSUiwQqhPskAttBnj87Io+Ze1THxDfHjLEB8oDk1vlaNX3up8xn+EwpyG+GNsp7LyOqBvp
 45ML+0rZAjtE2zEL08avshsjZ/nPImBZvYevgCnz6yhOMZhKtPXQZRucr2Lu6cOfk5uuEp1awog
 XkiP5oHkAGYEd4OBAdMuIsmwCACCflecbNUHIesX7S66X/w=
X-Received: by 2002:a05:651c:b0e:b0:3a1:fa0f:5d21 with SMTP id
 38308e7fff4ca-3a20d819aeemr6228851fa.3.1787806688167; Wed, 26 Aug 2026
 21:58:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260822190818.1829249-1-mattst88@gmail.com>
 <20260822190818.1829249-6-mattst88@gmail.com>
 <87wltdpbdy.fsf@draig.linaro.org>
In-Reply-To: <87wltdpbdy.fsf@draig.linaro.org>
From: Matt Turner <mattst88@gmail.com>
Date: Thu, 27 Aug 2026 00:57:52 -0400
X-Gm-Features: AcwNN1U0Wq4bNgKk0Zr8kfQBiDI2wkLj6tjZKouGU8WFWy-fzf4oqB_UEFDNA4M
Message-ID: <CAEdQ38FHj7qPpkJZx13kuKLyndagvFFv89Zn67mbXy=PQ76_iA@mail.gmail.com>
Subject: Re: [PATCH v3 5/7] RFC: accel/tcg: allow cross-page goto_tb chaining
 in user-only builds
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, pbonzini@redhat.com, 
 philmd@oss.qualcomm.com, zhao1.liu@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=mattst88@gmail.com; helo=mail-lj1-x233.google.com
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

On Wed, Aug 26, 2026 at 3:51=E2=80=AFAM Alex Benn=C3=A9e <alex.bennee@linar=
o.org> wrote:
>
> Matt Turner <mattst88@gmail.com> writes:
>
> > translator_use_goto_tb() refuses to chain unless the destination is on =
the
> > same page as the start of the TB. For guests whose text is much larger =
than
> > a page this is expensive: an emulated alpha gcc compiling a 255k line
> > translation unit takes the indirect dispatch path for 8.4 billion of it=
s
> > 34.2 billion TB exits, and a large share of those are ordinary direct
> > branches that simply crossed an 8 KiB page boundary.
> >
> > The restriction was made unconditional by d3a2a1d803 ("accel/tcg:
> > Introduce translator_use_goto_tb"), whose rationale was:
> >
> >     Various targets avoid the page crossing test for CONFIG_USER_ONLY,
> >     but that is wrong: mmap and mprotect can change page permissions.
> >
> > That is true, but in user-only builds the invalidation path already cov=
ers
> > it. There are no page tables: every mmap, mprotect and munmap reaches
> > page_set_flags(), which calls tb_invalidate_phys_range() whenever the f=
lags
> > actually change, and tb_phys_invalidate() calls tb_jmp_unlink() to rese=
t
> > incoming jumps. A chained cross-page jump is therefore broken whenever =
the
> > destination page's permissions change. This is not true in system mode,
> > where TBs are keyed by physical address and a page table change invalid=
ates
> > nothing, so the restriction is kept there.
> >  tests/tcg/alpha/Makefile.target     |  17 +++-
> >  tests/tcg/alpha/gdbstub/xpage-bp.py |  34 +++++++
> >  tests/tcg/alpha/test-xpage-chain.c  | 144 ++++++++++++++++++++++++++++
> <snip>
>
> Given alpha linux-user isn't widely built or used it would be better if
> we could make the xpage chaining tests multiarch so they are exercised
> on all *-user targets.

Done. The explicit branch is gone with the move: a fall-through off
the end of a page is a cross-page goto_tb just the same, so the test
writes the last instruction of page A and the first of page B, and
needs no per-arch branch encoding or displacement arithmetic -- just
"set the return value" and "return".

13 architectures supply those two, and the rest skip. I checked each
encoding against the cross assembler and ran the test under qemu-user
on aarch64, alpha, arm, hppa, loongarch64, m68k, mips, ppc, ppc64le,
riscv64, s390x, sh4, sparc64 and x86_64 (ppc64 ELFv1 skips). The
gdbstub half moved with it.

