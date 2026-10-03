Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDBE9CA5FE3
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2026 08:13:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCurQ-0002U4-SH; Sat, 03 Oct 2026 04:12:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <scherer.simon89@gmail.com>)
 id 1xCurP-0002Tk-S4
 for qemu-devel@nongnu.org; Sat, 03 Oct 2026 04:12:48 -0400
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <scherer.simon89@gmail.com>)
 id 1xCurO-0003Ys-2d
 for qemu-devel@nongnu.org; Sat, 03 Oct 2026 04:12:47 -0400
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-8ac8a2ac52bso1084877b3.0
 for <qemu-devel@nongnu.org>; Sat, 03 Oct 2026 01:12:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791015165; cv=none;
 d=google.com; s=arc-20260327;
 b=R1eQlctyGbR1vtlrIZLFXtba2erBlsUt4Yz9nfYwOOAjDZFFvID6lYPhcgd3sjOmAL
 cc8utnu2uXQqPQkVoDnXoaER2ty3XqW9jgajGEUXg90jXudQ7LXsomEvNM39rFWICn7V
 bKKPTDT5xPYnYB7HJX/rpn3qVUg/qRnK39Y0ZlbVZS57EZ71Bba7K4NH8PtZxKlohgYA
 3uFJXfp1vICfVOx19AMQlcOqrvEVVMF1NutXKfs77QGaaPZCq33mIZr+wU8EtMt3qHzP
 AYjCGLAmCEwpqk2gCartZuXO8aoyX8NWud/pwRn2oSMVKPNgULMU3XoOArsFpi6sP9Dl
 OH+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=e6e5XAw+jSpn8T0cpU8hyi77lDq561nw/gbdHPWoBj0=;
 fh=qUOFTwWG+G+YmxTz+HxoQUPJX6AFWbaPYrnquSe1BBk=;
 b=nOLWI8K1BAp5NmCKRTR+sEnXsYzvY3IWlWZrZEGj30euY+ZBJzh282iED/3cymZJB9
 M5Lk+IzIOm4nxWedEd3KMvsGMxkPLRWLJeIpzNvsfkOG0Nl5t6jr2C+/KXiYQ+SM1Or5
 wKb/GORSKmiXE0PHDLPoLXj8jzphPPTW/VNzFMIYNCp8lRSBvBODUP6ueJtVAEVBZiGy
 FgDQYkdqDlLEf725FfbAaW5otBMxvYxHclO/l51yjCy7SjBac1aCybZfjIv59gI6NJ3b
 q6a++XjeYmK/zJhIR24CijQI7CGKlYE100amsi1wmb8wvvtKDqGlLKGV6YN+1BRJTk8k
 Qg1g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791015165; x=1791619965; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=e6e5XAw+jSpn8T0cpU8hyi77lDq561nw/gbdHPWoBj0=;
 b=dao7i1L4SPjyepYhUvg0OMbvve96FqxZ2MSV9MX6bIcC4oFSgdtEJ5EO1AShmRFm+x
 VeGt3D9B+XY+h/IOD059/j3fyuSJ+Wq9U4Msa8u4m2UgQkLeJ5fPBUovcl7aMvDfm7uk
 Te/sz+VUlxbQRjtEQwMfpupu1Rbc1YODYYAh+nYs/W5m5mpAwOhZhFT9yHQ0bUlKt1aS
 x2QWXORPQfcmVfjcVqDlm6By2IpFR1tYD0paAG79tkhOM0Ll0h2bTL1DnimaQ3P2f0vr
 EWiOQPUksFlW8jrkBI0IDcBbfiuUYtZ21dRfoC994E80yc4nk35UxEIQAMvuEOTIaSVR
 R/mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791015165; x=1791619965;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=e6e5XAw+jSpn8T0cpU8hyi77lDq561nw/gbdHPWoBj0=;
 b=E2Fjjs2ngCbU24svIFatiQ86pKo1X6GBYN8yLgqfd40u4XoMxyk95GOn++mHKsl1xH
 NJXvVg0x0OjXDcdwyc3560OV6cBl+ZN8j5h/IsECZNblkKfTX1G2uylSP43VsTtAfq7h
 fKeYJo/o+lJJN2UTfsTXsTSWbdp/lJJlgeDoloqeFJbIyvZbm6PHjOoREU3azmAyemH9
 BY5w7EFE73EhhhpfqFMqd01MBikgP3beBBDciCFbQ3K8cap9XronkmU/UF9ja89WqPbk
 2FLk2PmY98TSuu+gbTleaoqveNvS/c5pS6Nj1zbS58sAcfTWajYTRMYrVzpMmxToPEmr
 KT7g==
X-Gm-Message-State: AFq9FYIv09BK3E810ppAgVaTKbtqEYMwslQ3RDhirrzEgY9r5yGvCBvX
 0c6T3iv6q9pbCMbvvAy1ytiS2tMAyDjmMTvcbmEWA/J5oYhWDT+pZ3eqFsvriUb9VXEg68+WqSH
 hgYJT04NWUU5hli/RUTX6+qfQnaqrFyXBa2CybJY=
X-Gm-Gg: AYBFou3AFKqhmrIexkYZAA9xG5f8hOrwdNhduwPPP9GIF8I+ZVR4Eu1+iuUg1V2jkgN
 H5br3YTvveumaVdqaWiQf5LQ9IK6qDvZbbsA0XAg0oUozP1ahEpbWslwh5X1++Ehj/gzDA3ATCk
 sDAIemdiwv3FtpyI+xQKCMMdYJttuJXrPDukIQFnxH4jOXTuHXc4SU+2WQQoO0TUuadDHMRq4Me
 NABNBRCehTfwck3pTGECvQgtIdtUzTTHS3zblnRQ40sp9hT+4WvR9nPeu2JshMXm2KoMU8kQV11
 BxXriyxAYwb0NfqcgqFXVJY/S+D7wKXI5so3e81SCYbo+uIVWAHNgFTr9eoFSJ5Z79tcmzef8cE
 /jyVd/zCnHWevRtU/aE5brF8dQNJSW99KvmpDVcf4fG47E8ItkYw=
X-Received: by 2002:a05:690c:f06:b0:8ab:5f2a:3920 with SMTP id
 00721157ae682-8acdaeaa33amr43627887b3.17.1791015164851; Sat, 03 Oct 2026
 01:12:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260813052532.22833-1-scherer.simon89@gmail.com>
In-Reply-To: <20260813052532.22833-1-scherer.simon89@gmail.com>
From: Simon Scherer <scherer.simon89@gmail.com>
Date: Sat, 3 Oct 2026 10:12:34 +0200
X-Gm-Features: AclHuK_ZNvlw9nnuvDfWq2a6r7VvCrT1aLpGdAf50gaOMB5J2yShXSRmBe2usnk
Message-ID: <CAEQwQtLt8LoRyRXBaD_=gDYfKxrx9gYFrmwZJGTMxv9i5F6Xvw@mail.gmail.com>
Subject: Re: [PATCH v2] target/i386: Set aliased x87 exponent bits to all 1s
 for MMX register writes
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, richard.henderson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1132;
 envelope-from=scherer.simon89@gmail.com; helo=mail-yw1-x1132.google.com
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

Ping. Maybe the patch has been missed.

On Thu, Aug 13, 2026 at 7:25=E2=80=AFAM Simon Scherer <scherer.simon89@gmai=
l.com> wrote:
>
> Per the Intel SDM (Vol 3, 15.2), writing an MMX register also sets bits
> 64-79 of the aliased x87 register to all 1s. gen_writeback() never
> does this for X86_OP_MMX destinations, so those bits keep whatever
> the x87 side left there (e.g. 0 after finit/fldz). A later x87
> instruction such as fucomi/fucomip can then read a stale finite
> value where real hardware guarantees a NaN encoding, changing
> comparison results and flags.
>
> Set the high 16 bits to 0xffff when writing back to a MMX register (not
> memory).
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4105
> Signed-off-by: Simon Scherer <scherer.simon89@gmail.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> v2: use offsetof(CPUX86State, fpregs[op->n].d.high) directly instead of
>     reusing MMX_OFFSET() + offsetof(floatx80, high), per Richard's review=
.
>
>  target/i386/tcg/emit.c.inc | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
> index 473f415766..2c36e41303 100644
> --- a/target/i386/tcg/emit.c.inc
> +++ b/target/i386/tcg/emit.c.inc
> @@ -352,6 +352,10 @@ static void gen_writeback(DisasContext *s, X86Decode=
dInsn *decode, int opn, TCGv
>          }
>          break;
>      case X86_OP_MMX:
> +        if (!op->has_ea) {
> +            tcg_gen_st16_i32(tcg_constant_i32(0xffff), tcg_env,
> +                             offsetof(CPUX86State, fpregs[op->n].d.high)=
);
> +        }
>          break;
>      case X86_OP_SSE:
>          if (!op->has_ea && (s->prefix & PREFIX_VEX) && op->ot <=3D MO_12=
8) {
> --
> 2.53.0
>

