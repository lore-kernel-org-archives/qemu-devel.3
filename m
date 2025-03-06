Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BF9FC282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 06:23:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tq4dh-0008IF-Al; Thu, 06 Mar 2025 01:23:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tq4df-0008Hf-2Z; Thu, 06 Mar 2025 01:23:23 -0500
Received: from mail-ua1-x933.google.com ([2607:f8b0:4864:20::933])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tq4dc-0004Eh-T5; Thu, 06 Mar 2025 01:23:22 -0500
Received: by mail-ua1-x933.google.com with SMTP id
 a1e0cc1a2514c-86b31db3c3bso92287241.3; 
 Wed, 05 Mar 2025 22:23:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741242198; x=1741846998; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZybjbWGi0zUTNXb3Q9QlwhbluTwjDo8OZa6hiI0XHBY=;
 b=g75VPwXNeShEUJuzPxZ4yBCIAV8JUdCNiH3iIGMXuskjKXKsNXHKF2vt4zjk9Mhxpw
 bCDQZEFFEYVOg1AJvULfEshkzodU9qrTkQfLalIZT+TUap6C+igA49dseMMCfN8iE0wX
 x2GD2uV9i66JpbwzPZf2DnVnDDHL5GZICA8NpHcqkbN7gEz0rXw2MiL0yO3MjEfGBnnH
 zNhB3ICrCNj9JSWi7BPvGt9s4Ww43iVovfCcdPr/ry3HLwbG2voSLA1LeU2Ad3ly8xrt
 nxMbBBupOKqcLoZPeJxAaz4u7fBgMqIT2z/zicGbSQ/eCnH6z/A0RiVYy73do5vuHsOy
 M/3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741242198; x=1741846998;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZybjbWGi0zUTNXb3Q9QlwhbluTwjDo8OZa6hiI0XHBY=;
 b=bJblmsRn66fqpBP4riYNNLxEZBGHKUFW91bRYvihA3+7M+bXSyO6CAuR9IUhfRgqDP
 35wJXhGz7mIKnXZ2Ld1HVYuAixp5uIc5yjHDRkd1rkjdxs0hgi0EuVcvFT/siC4aI6eH
 cTg9giwqmFyXY0uo7ojaPX9Ozd86RthdhxuSSCqURkwhRtubVAQvtUFMQ/YDwMPn6hyJ
 vmYx0cqdBkxoniKgbHV2ITIkm03yhE187dOTV7Y1/9FITDdgDG9V8vz+OdD8tICYcu0w
 sUqgkwdtCPXlIjPbU254CdRmuqJg2wlixheuf3+ag25TnrzZH+afcNBood9MPlrjOOX9
 pUBQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWPMt9frsUTIsoqgTpi2IpxCSX6i7XuDp2UfsuYy1EuOhV4uTJocfogXW3iaq81W3XWhyn1M1Vh0liz@nongnu.org
X-Gm-Message-State: AOJu0YxmeRFdxALYoc03sWblVRHwIayUBk5uf9mRYPdCT0+kOT50043t
 3VzbvwJ4wJzosJ6L7c936NGqBmWfGdk+z52u/swecgV2E0S76M/YmoiNpVldk7eim6a/I9s3X5t
 H/RYBDDC+kOAfn3xVEqEST8rv9p0=
X-Gm-Gg: ASbGncvvtH8SEtbvtYESdzZgcXXuuTZI8BHJkqt/Vu5+M9ahsW7zIld76uFutjZw+ug
 D6uvtBVmBtjFrNLeas4QkJds3+qYEGQvEJ/FXfSTiYR2PWk6cMHahrearMwx997el9aE1ZMPVds
 CLHq6IBUkevtJu12AJjq2VqckMBdolny5NVxiRwWbUVlsb2JypMRvcwatD
X-Google-Smtp-Source: AGHT+IEfOzgX2LQ2eL8I/R7WLvB9pnurdFruZbptENa5Ttqf81PzuykpIEhvYLZEdLU8QXmnPCrJzPFKNvk0AqzTCAQ=
X-Received: by 2002:a05:6102:38cf:b0:4c1:8bea:d421 with SMTP id
 ada2fe7eead31-4c2e27fe02fmr3584917137.14.1741242198556; Wed, 05 Mar 2025
 22:23:18 -0800 (PST)
MIME-Version: 1.0
References: <20250218025446.2452254-1-debug@rivosinc.com>
 <20250218025446.2452254-2-debug@rivosinc.com>
 <CAKmqyKMip2t-QyEvFFvnsMkXV1Wokt0dXAqpe4MAzyCHpUm--A@mail.gmail.com>
 <Z8k8/rhi/COfv/vj@debug.ba.rivosinc.com>
In-Reply-To: <Z8k8/rhi/COfv/vj@debug.ba.rivosinc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 6 Mar 2025 16:22:52 +1000
X-Gm-Features: AQ5f1JpQ8QfGiL79reijAvTfQrZaQS76T3c_CaD8xSBrdh2lrnXAEhatlhTl45U
Message-ID: <CAKmqyKNd9HRX9vWBBihVn6EFhYHXTmFpKV4iNJpcgDmteJfhjA@mail.gmail.com>
Subject: Re: [PATCH 2/2] target/riscv: fixes a bug against `ssamoswap`
 behavior in M-mode
To: Deepak Gupta <debug@rivosinc.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, palmer@dabbelt.com, 
 alistair.francis@wdc.com, bmeng.cn@gmail.com, liwei1518@gmail.com, 
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, 
 Ved Shanbhogue <ved@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::933;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x933.google.com
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

On Thu, Mar 6, 2025 at 4:13=E2=80=AFPM Deepak Gupta <debug@rivosinc.com> wr=
ote:
>
> On Thu, Mar 06, 2025 at 03:29:00PM +1000, Alistair Francis wrote:
> >On Tue, Feb 18, 2025 at 12:57=E2=80=AFPM Deepak Gupta <debug@rivosinc.co=
m> wrote:
> >>
> >> Commit f06bfe3dc38c ("target/riscv: implement zicfiss instructions") a=
dds
> >> `ssamoswap` instruction. `ssamoswap` takes the code-point from existin=
g
> >> reserved encoding (and not a zimop like other shadow stack instruction=
s).
> >> If shadow stack is not enabled (via xenvcfg.SSE), then `ssamoswap` mus=
t
> >> result in an illegal instruction exception. However there is a slightl=
y
> >> modified behavior for M-mode.
> >>
> >> Shadow stack are not available in M-mode and all shadow stack instruct=
ions
> >> in M-mode exhibit zimop behavior. However, `ssamoswap` can still succe=
ed
> >> if MPRV=3D1 and MPP is non-zero (see section 2.7 of zicfiss specificat=
ion).
> >> This patch corrects that behavior for `ssamoswap`.
> >
> >Section "22.2.3. Shadow Stack Memory Protection " of the latest priv
> >spec [1] seems to say: "When the effective privilege mode is M, any
> >memory access by an SSAMOSWAP.W/D
> >instruction will result in a store/AMO access-fault exception."
>
> Hmm I didn't look at priv spec. Let me fix this one.

I hope the two don't conflict, that will be a nightmare

Alistair

>
> >
> >1: https://github.com/riscv/riscv-isa-manual/releases/tag/riscv-isa-rele=
ase-9cfaf37-2025-03-06
> >
> >Alistair
> >
> >>
> >> Fixes: f06bfe3dc38c ("target/riscv: implement zicfiss instructions")
> >>
> >> Reported-by: Ved Shanbhogue <ved@rivosinc.com>
> >> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> >> ---
> >>  target/riscv/insn_trans/trans_rvzicfiss.c.inc | 13 +++++++++++--
> >>  1 file changed, 11 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/target/riscv/insn_trans/trans_rvzicfiss.c.inc b/target/ri=
scv/insn_trans/trans_rvzicfiss.c.inc
> >> index e3ebc4977c..ec016cd70f 100644
> >> --- a/target/riscv/insn_trans/trans_rvzicfiss.c.inc
> >> +++ b/target/riscv/insn_trans/trans_rvzicfiss.c.inc
> >> @@ -15,6 +15,13 @@
> >>   * You should have received a copy of the GNU General Public License =
along with
> >>   * this program.  If not, see <http://www.gnu.org/licenses/>.
> >>   */
> >> +
> >> + #define REQUIRE_ZICFISS(ctx) do {       \
> >> +    if (!ctx->cfg_ptr->ext_zicfiss) {    \
> >> +        return false;                    \
> >> +    }                                    \
> >> +} while (0)
> >> +
> >>  static bool trans_sspopchk(DisasContext *ctx, arg_sspopchk *a)
> >>  {
> >>      if (!ctx->bcfi_enabled) {
> >> @@ -77,7 +84,8 @@ static bool trans_ssrdp(DisasContext *ctx, arg_ssrdp=
 *a)
> >>  static bool trans_ssamoswap_w(DisasContext *ctx, arg_amoswap_w *a)
> >>  {
> >>      REQUIRE_A_OR_ZAAMO(ctx);
> >> -    if (!ctx->bcfi_enabled) {
> >> +    REQUIRE_ZICFISS(ctx);
> >> +    if ((ctx->priv !=3D PRV_M) && !ctx->bcfi_enabled) {
> >>          return false;
> >>      }
> >>
> >> @@ -97,7 +105,8 @@ static bool trans_ssamoswap_d(DisasContext *ctx, ar=
g_amoswap_w *a)
> >>  {
> >>      REQUIRE_64BIT(ctx);
> >>      REQUIRE_A_OR_ZAAMO(ctx);
> >> -    if (!ctx->bcfi_enabled) {
> >> +    REQUIRE_ZICFISS(ctx);
> >> +    if ((ctx->priv !=3D PRV_M) && !ctx->bcfi_enabled) {
> >>          return false;
> >>      }
> >>
> >> --
> >> 2.34.1
> >>
> >>

