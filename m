Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E889CC282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 05:29:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tq3nc-0001hQ-1n; Thu, 06 Mar 2025 00:29:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tq3nW-0001gc-2k; Thu, 06 Mar 2025 00:29:30 -0500
Received: from mail-ua1-x92e.google.com ([2607:f8b0:4864:20::92e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tq3nU-0006i2-5z; Thu, 06 Mar 2025 00:29:29 -0500
Received: by mail-ua1-x92e.google.com with SMTP id
 a1e0cc1a2514c-86d2fba8647so234782241.0; 
 Wed, 05 Mar 2025 21:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741238966; x=1741843766; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KaB6rGB5gEbShao80tHZ3Iu2QrvpBVQpim6kGrMH9Fw=;
 b=O7yhhc3j1VBxz6c7SyTdoEZ5Dwp2k14V9+GhvbI4GHwA491EjoEu9SnVn5+g6lJD9N
 0xbGQyftackMZsU1KSvPV0Ao4cRO22io3jF4D7gun4yCKg5SaT8pY+0TSIRgC4bzbjdQ
 DVY4sGkAR5gNbIb27b6Q2SObDKlKvezKDCG6FBqHv+Z61p23ruQ8jWifMWgya8xTgrp4
 C5k35NPGAWAE5mwZA4uDCkJzBGFL4y37cnuvvEK9oHgmmZZUXTlSWiUNQgEaIednnTNy
 4HymMeiLKhAY8M3azWP/7+uHA+PHDAm2fyRNoIcvAdRGpBtqdfp9qjWDI6CzuOh3MwKr
 jAyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741238966; x=1741843766;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KaB6rGB5gEbShao80tHZ3Iu2QrvpBVQpim6kGrMH9Fw=;
 b=LGitl5+xnA5fgoSIJUKqotIBxLYKIhjzPXwHwfpdKBHKjqPfFuGZPeJ95APOqagpt8
 Km5Urinpz5rh0jb2yWkAA3IO7K/8VYMRZyCsQhzjQy6fF9IlsxXpunwqCg0azQ3KXfug
 Guhdy3+EnHczcwu5ds9np5d0O93K5LC/ekZnpsGTcINv56sPVMd0Ac8QBnqjyizbvn8v
 O16YQo8QqpfgwBYgKrQF6Jzxsg3Ip2h4WMdx8TGBz17o2Zxwe7tmf+1VP/H9yWX9VMH1
 khQCFv0CpRM5eIBekCXukJjYnPSnTgDPncI0dcAVbZCYV9QOC0HScSeZWXAg1fAFH4/S
 755w==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2B44Y8MksFkhTndtV+WaH5OWqKI113wEx0VrfRSLAeY46Mz5h/b6TxReVA6ZJs/6FFw+PinJbEZiG@nongnu.org
X-Gm-Message-State: AOJu0YwIrHtPBlT0zv8DpUIZFZ9X4BP4y67V0gWPRXPxh5KH3fkyf8Ma
 IQklU06qLLsmU0v+6MFO6ZVxzJ+HXT4gB7AR8BKbErfZ+Q1hmOKH5Jr/TXXBA3zn6vRugwhylOs
 u30Cmp9uYB7rdVBoeYtKXGmEky3k=
X-Gm-Gg: ASbGncsidJYCZ9GrCcr9T7hVDoXc8SsaASkIIUcycoR+pwOni/1duk0YqnBMDcB1TgW
 vaIhajop1NbCYVR+Zkn3hUNJp7XeDAQYVf9HjQKputmKwQJ/6kMKgAq+EP10qyVRHJx1Y+8JbP+
 +eKgkWb8XGAHEOEu9L34NMdI+RSuP+VV1hpxTfEM5PbMUa3vEP9/aWWYbO
X-Google-Smtp-Source: AGHT+IHYH1GFahdFuw3bQuT4Kf3Q6FVnOAU/Spp9SFh2IoqnxLSFUNrPiMNVIvr+f4Df9FvbOBa8C8bRoNX7tvoLT5I=
X-Received: by 2002:a05:6102:2925:b0:4c1:b227:1144 with SMTP id
 ada2fe7eead31-4c2e27ffc03mr3571014137.12.1741238966640; Wed, 05 Mar 2025
 21:29:26 -0800 (PST)
MIME-Version: 1.0
References: <20250218025446.2452254-1-debug@rivosinc.com>
 <20250218025446.2452254-2-debug@rivosinc.com>
In-Reply-To: <20250218025446.2452254-2-debug@rivosinc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 6 Mar 2025 15:29:00 +1000
X-Gm-Features: AQ5f1JrCCwGwdk24wFfMbFPMy68SelbGt08vRv1AyhJQBurFql4qALeJuv7MuZE
Message-ID: <CAKmqyKMip2t-QyEvFFvnsMkXV1Wokt0dXAqpe4MAzyCHpUm--A@mail.gmail.com>
Subject: Re: [PATCH 2/2] target/riscv: fixes a bug against `ssamoswap`
 behavior in M-mode
To: Deepak Gupta <debug@rivosinc.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, palmer@dabbelt.com, 
 alistair.francis@wdc.com, bmeng.cn@gmail.com, liwei1518@gmail.com, 
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, 
 Ved Shanbhogue <ved@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92e;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92e.google.com
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

On Tue, Feb 18, 2025 at 12:57=E2=80=AFPM Deepak Gupta <debug@rivosinc.com> =
wrote:
>
> Commit f06bfe3dc38c ("target/riscv: implement zicfiss instructions") adds
> `ssamoswap` instruction. `ssamoswap` takes the code-point from existing
> reserved encoding (and not a zimop like other shadow stack instructions).
> If shadow stack is not enabled (via xenvcfg.SSE), then `ssamoswap` must
> result in an illegal instruction exception. However there is a slightly
> modified behavior for M-mode.
>
> Shadow stack are not available in M-mode and all shadow stack instruction=
s
> in M-mode exhibit zimop behavior. However, `ssamoswap` can still succeed
> if MPRV=3D1 and MPP is non-zero (see section 2.7 of zicfiss specification=
).
> This patch corrects that behavior for `ssamoswap`.

Section "22.2.3. Shadow Stack Memory Protection " of the latest priv
spec [1] seems to say: "When the effective privilege mode is M, any
memory access by an SSAMOSWAP.W/D
instruction will result in a store/AMO access-fault exception."

1: https://github.com/riscv/riscv-isa-manual/releases/tag/riscv-isa-release=
-9cfaf37-2025-03-06

Alistair

>
> Fixes: f06bfe3dc38c ("target/riscv: implement zicfiss instructions")
>
> Reported-by: Ved Shanbhogue <ved@rivosinc.com>
> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> ---
>  target/riscv/insn_trans/trans_rvzicfiss.c.inc | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/target/riscv/insn_trans/trans_rvzicfiss.c.inc b/target/riscv=
/insn_trans/trans_rvzicfiss.c.inc
> index e3ebc4977c..ec016cd70f 100644
> --- a/target/riscv/insn_trans/trans_rvzicfiss.c.inc
> +++ b/target/riscv/insn_trans/trans_rvzicfiss.c.inc
> @@ -15,6 +15,13 @@
>   * You should have received a copy of the GNU General Public License alo=
ng with
>   * this program.  If not, see <http://www.gnu.org/licenses/>.
>   */
> +
> + #define REQUIRE_ZICFISS(ctx) do {       \
> +    if (!ctx->cfg_ptr->ext_zicfiss) {    \
> +        return false;                    \
> +    }                                    \
> +} while (0)
> +
>  static bool trans_sspopchk(DisasContext *ctx, arg_sspopchk *a)
>  {
>      if (!ctx->bcfi_enabled) {
> @@ -77,7 +84,8 @@ static bool trans_ssrdp(DisasContext *ctx, arg_ssrdp *a=
)
>  static bool trans_ssamoswap_w(DisasContext *ctx, arg_amoswap_w *a)
>  {
>      REQUIRE_A_OR_ZAAMO(ctx);
> -    if (!ctx->bcfi_enabled) {
> +    REQUIRE_ZICFISS(ctx);
> +    if ((ctx->priv !=3D PRV_M) && !ctx->bcfi_enabled) {
>          return false;
>      }
>
> @@ -97,7 +105,8 @@ static bool trans_ssamoswap_d(DisasContext *ctx, arg_a=
moswap_w *a)
>  {
>      REQUIRE_64BIT(ctx);
>      REQUIRE_A_OR_ZAAMO(ctx);
> -    if (!ctx->bcfi_enabled) {
> +    REQUIRE_ZICFISS(ctx);
> +    if ((ctx->priv !=3D PRV_M) && !ctx->bcfi_enabled) {
>          return false;
>      }
>
> --
> 2.34.1
>
>

