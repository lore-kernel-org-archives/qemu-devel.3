Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 120F9C531D0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 17:11:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woOqr-0003kN-Os; Mon, 27 Jul 2026 13:10:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1woOqp-0003kA-OC
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 13:10:51 -0400
Received: from mail-oa1-x31.google.com ([2001:4860:4864:20::31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1woOqo-0008C3-7u
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 13:10:51 -0400
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-4472500e25fso1624566fac.1
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 10:10:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785172248; cv=none;
 d=google.com; s=arc-20260327;
 b=q0bFpnTyvEdGLj1uOmEEEYHTxJnNlkSBTN5kG1NKpin+Rk5XF1rQvS0cnoKrUl/riu
 X887+rZOWF6nWRZ0KNlcc4Gevqs6H3JW2aFFS6NT3iuKHE6mEv2tc13L1OgvbyC8721h
 aymW1EWUzmD+0qbXy8E9EqUPx1hCUaNYLSKMF+sKu92yYmpLm4t5+UTGrtE8hR2Fflao
 fUD7/gbHBejT9Ep0DXdK3lCHv8EKmAFtFYK+eml12dBu7b6M+/ooGOpGTRBZkYcRAfvO
 VvLPx5jmIGGoJx1ijfRTn1aXUefECAoffytb2OfGnYpxZeooS1VjC9M0ddTTCL7Ds002
 m/jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=c6tYtRd5W/WpmVBYpvp88DVHskXrw9MyHKVchjuCJGk=;
 fh=n4B6iknmVoQUFWAXgCoFXmsXmOwC+osat1mGKYTxzm8=;
 b=rBOjPJvudDMRuTSFhdrXlw91nHSqx5k4WaeS/vX9FAYHSSZ0c7rTKjBwUs7EqVl8H2
 Qqzm4+W49C/E86SqdgxSka0z+ByOVqyQfiWZ2gK5AhwFIryZ8wzP/CPtrIcDSWPkYdtn
 boV57yVTCqwkMaV4Z1QRgDJWVsorjObQTzw1KJ4cFKv9yukxEB93JXv24OB/SWXHQh24
 ROLj5jW5EsW4KO1ioRbs0w97SJEgpAtFLeJF91lrdAtRKNQQybPKIOC4OXVW4l8YeWOB
 b6Qa+pCqdOBla8U5/gr8IDwNBXdSjIzOnFL6vjYqFFsF6ExJ/v1m+ssdeGEonOmIZKV5
 Bwkg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785172248; x=1785777048; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=c6tYtRd5W/WpmVBYpvp88DVHskXrw9MyHKVchjuCJGk=;
 b=F308L56Il3UYJKo0jXTHYYsMyxJz1bEf6ZPQpDv5Y98U6ZEKTMNLplSmQWbgf4pIOa
 k4EdwAjBBl700mgoStobn/DMEYF1kJ3x4wKYzZh4lGcUcaAuAV3uctCMj4pluDkcRCD2
 AXeC+GFkezowYzuRBrQGl6L2RkjSdo0i1CpPbQeqnk31huvloXI0QZ1pjx2iewbAROY3
 /956QUued9PJhgtTTOWwwI6WKVIFMitmm/uEvIWzuAiGF5pUM7R+uVfWOe9e2H7ihjlB
 bqR6ZvJ4LU4WtARVMz2x26CuzPLv6FCRsQOyQKFP0MYaho/Kk/wri+xQUsqAj64s3mDm
 CylA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785172248; x=1785777048;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=c6tYtRd5W/WpmVBYpvp88DVHskXrw9MyHKVchjuCJGk=;
 b=rEfehyaWR6i/K+gtDgk547xPEt0fiHPrg4pCk78q/brlVCYVG3dyPXBLzU9IMoflGj
 1gipPK3tWJ8WVxHGbMuwOhXThP/BiAgYVtCM/kVyFhr3Yaozlx9ersrxMqigBfjKRCuA
 gGL6NILXjTU5TPr4c72n/FZYVhsXCIUgfGskMNdEHV7uKaJYTZg9ISS1hGRYu7Hq6OdD
 RIK+uuPugxCMAWr2IgFgzz/gz3pAZ1NWZphERUkxLuduAfXizhVycCELfGL824hgxCN/
 lbsF3ohz7IshFy/CMKljCjCkmtdBOgd1BE+X8YnsRD102+8fb7l+9gBXweTLNi/zlkcG
 84Zg==
X-Gm-Message-State: AOJu0YytivQuBT4inTzsp7coxT6StKgNjDOhapzzOp3InLr6ZdLCPNbi
 mR5wgNrNsVYWZnlGrhS8EQtK6ZEOLlc+NYyIFVvnQXgM+6jBkViEx/GAzNbK18pYdkrrbv31n/X
 yiEt6KzZqiDnd7LilErM6qHeLBVEX9AE=
X-Gm-Gg: AR+sD130GCClum+Z0gu9qYbx5Uf1RGR0F3Fh0231awXr6P7E1lYwzTD3gyip3+LsDck
 ciaCvHdHiCJoDJdYs4R/JV1UTNY0yhLP6HAQ9PES53xUg4Z6lBrOLbtEuKOUBAnPJTY2O8gYTPh
 VrSMR5SYeLvCSKIDsVF/dv0qwQ/02zSMPUcrB+2IU0Z6VMIPU5shShF2hhMt1Ni00/nSBMTGL/S
 7fcGGI7JBImLVTfmiszAzwQQh/42aHY9klpKHVKuffAciLyKPyyPponk60voNTBbrFxbZyVImlJ
 p6KvYZvb3gSMVypLLQ/vp0PXahBdi0JyetuJrDu4gsUUV33Pr3RHd18AV5BE7S7ZcjpoMcNusx8
 RgNnI
X-Received: by 2002:a05:6808:f91:b0:4a4:ddde:5207 with SMTP id
 5614622812f47-4ad55bab581mr130608b6e.8.1785172248339; Mon, 27 Jul 2026
 10:10:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260727114848.1041856-1-laurent@vivier.eu>
 <877be8fd-af97-4f68-b4a4-31201334c96c@linaro.org>
In-Reply-To: <877be8fd-af97-4f68-b4a4-31201334c96c@linaro.org>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Mon, 27 Jul 2026 10:10:35 -0700
X-Gm-Features: AUfX_mzv0z1H5hu7ODYShJOVV7vYoh3EPDgL3qk-ax7tqHrQnW7r6PIdsQoATqg
Message-ID: <CAMo8BfJezXWP6i5_uuozTZ3iyzHQy61ystP4jUmp1erpa9zZyg@mail.gmail.com>
Subject: Re: [PATCH] linux-user/sh4: allow full 32-bit address space
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2001:4860:4864:20::31;
 envelope-from=jcmvbkbc@gmail.com; helo=mail-oa1-x31.google.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_LOCAL_NOVOWEL=0.5, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Mon, Jul 27, 2026 at 9:52=E2=80=AFAM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 7/27/26 04:48, Laurent Vivier wrote:
> > On real SH4 hardware, the address space is split between user mode
> > (U0, 0x00000000-0x7fffffff) and kernel mode (P1-P4, 0x80000000-0xffffff=
ff),
> > so TARGET_VIRT_ADDR_SPACE_BITS was set to 31 for CONFIG_USER_ONLY.
> >
> > However, qemu-user does not emulate the MMU, so this limit is not neede=
d.
> > The only effect is to restrict reserved_va to 2 GB, causing OOM failure=
s
> > for memory-intensive builds (e.g. webkit2gtk on Debian sh4 buildds).
> >
> > Set TARGET_VIRT_ADDR_SPACE_BITS to 32 unconditionally, like most other
> > 32-bit targets. Also fix the TASK_UNMAPPED_BASE macro to use 1ull inste=
ad
> > of 1u to avoid undefined behavior when shifting by 32.
> >
> > Reported-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> > Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> > ---
> >   linux-user/sh4/target_mman.h | 2 +-
> >   target/sh4/cpu-param.h       | 6 +-----
> >   2 files changed, 2 insertions(+), 6 deletions(-)
>
> So, the goal is to run things under qemu-linux-user that can't run on har=
dware?
>
> I'm not necessarily opposed, though there have been software systems that=
 know that the
> upper bit is unused and reuse it for tagged pointers.  Emacs did so, some=
time last
> century.  I'm sure there were others.  Anyway that's the reason we curren=
tly limit
> qemu-linux-user like the hardware does.
>
> If you're going to drop that, you might do this for all targets:
>
> mips/cpu-param.h:#  define TARGET_VIRT_ADDR_SPACE_BITS 31
> sh4/cpu-param.h:# define TARGET_VIRT_ADDR_SPACE_BITS 31
> xtensa/cpu-param.h:#define TARGET_VIRT_ADDR_SPACE_BITS 30

Xtensa has it for the different reason: with the windowed call ABI it canno=
t
have calls between regions that have addresses with different two topmost
bits. call0 ABI doesn't have this limitation.

--=20
Thanks.
-- Max

