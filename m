Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9686AC282D1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 02:01:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqN0q-0004UL-BY; Thu, 06 Mar 2025 21:00:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tqN0i-0004MR-Hs; Thu, 06 Mar 2025 21:00:29 -0500
Received: from mail-ua1-x934.google.com ([2607:f8b0:4864:20::934])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tqN0g-0003sb-Ps; Thu, 06 Mar 2025 21:00:24 -0500
Received: by mail-ua1-x934.google.com with SMTP id
 a1e0cc1a2514c-868da0af0fcso575437241.2; 
 Thu, 06 Mar 2025 18:00:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741312820; x=1741917620; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zYEL2pXV+T7nMD+cfiS4n1iC6E44CYyDoqUQRD7vAdk=;
 b=IZEXzOi/CaqrxZsg1shouU9nSxC9PzZYhGhREsMIyranL0oIPzvUWqANvrenK2G4YN
 09RPFdieAWNck3VPI14gvkhXxUdVyxcPDIpilV4CjqS4ScNlRAVI4iRClFwMS/2nyH4A
 D6wZTGOzS9hGhsgA7SBL2jj4zcH0AxAjyszhWHeVgbkvD+R8F/pfmugbwhb3XUUYfYDk
 IAbZYSHILpDks8gLmlx1ZOwP8xb3+r1HHpgbdri2SgEW7AIldgXjOZrHyMz6fhpoyyGm
 iTl0PGGJ1C8uvJ2jqzUrvGWVFzvNkWpLoxVnxw9iA6v+Eq3XtSegOcg1F14XHDp46jVj
 8udQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741312820; x=1741917620;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zYEL2pXV+T7nMD+cfiS4n1iC6E44CYyDoqUQRD7vAdk=;
 b=uec+pDvbTFJ5P5ONZlM+/DM9eGWM1nyygN67t9GN255bNJUsR1sd2B3VHeuvrSqqIj
 2xpU3Pye7olaApgG6GGZEcBy1CEs91+a4oxetITmAkSpPQ5IqQvmrBPF1k9Jzs6+0FDn
 0tAzBBOX9JldvkiGTa/Xr5KwNN1kpzZYxj9bunfr+IYdE80YQtB28vQ9sYTRxAW6tHDI
 tfxyjeg7/PFJZC3bJ5hmajUYAPMTheTW+kanRr7B/O2OxaddK9mfSLLFjZ7xkYX4OeDJ
 G1kgJ2hDhlwQAScz82MMjHz6bY8Gz/IF/Zjj/FI4wi66ZpA+srkK/SSeSPsUqHEk8C9u
 pCCQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGSvPdGZqhE+WLiEHgXULrSRT+1EQ+sR9jzoMawacLvOs1QSqHbyj4c1dlE2j4uGotljNOarLmcPFI@nongnu.org
X-Gm-Message-State: AOJu0YyqSIw23VMmYgQB4qux1Ohd5iZbSMWHf8/RIY4dxfwXO38c/ehI
 Zl6W82wsQRf8tA4ksjNiJ/lLGj6mtZeCAX7a9v01Px+AbMSrSlvHb1suxivmyIYbdrVRHoz543d
 Xg+Ny+8iqUi1GfKoLlMyG01TG6W4pNxXPAzE=
X-Gm-Gg: ASbGncvPnN4IzVOLXEj1jTCx1YutRAZGn/UwhdBybrGnYDlwOo0269abxfjSX0s8Whn
 /XO2KUs0FSyMvznAytGZSlsFJtZtGKGXEc99vrKM+bEqDSEHwPiNM4kkhmyXAzlNkqS7RQzX4hS
 Ekb7KMnMrR+BeCx4XRluOJ8DeSkTP3odpelYIi/cB0gK/cQSTSM7AgyyG5
X-Google-Smtp-Source: AGHT+IHAOBk0CYVlEcQDtY1xwXA28LOqDsgc09kP7TysSBe0eWPQOc0G4Eie2HF8hD2haBQXeyyap0EzK5v0wn8CDzk=
X-Received: by 2002:a05:6102:41a8:b0:4ba:974c:891e with SMTP id
 ada2fe7eead31-4c30a67bb0dmr1073423137.17.1741312820424; Thu, 06 Mar 2025
 18:00:20 -0800 (PST)
MIME-Version: 1.0
References: <20250306064636.452396-1-debug@rivosinc.com>
 <20250306064636.452396-2-debug@rivosinc.com>
In-Reply-To: <20250306064636.452396-2-debug@rivosinc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 7 Mar 2025 11:59:54 +1000
X-Gm-Features: AQ5f1Jo36Th0cy0Tg2BRelfKuUjn21yLncyUhsYp21WjuhyhN8G3O8eM4Eo9bbA
Message-ID: <CAKmqyKMUKeVPv__QSnti=XzVmxqkjYk9ZNE8twcN9nztRksUTg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] target/riscv: fixes a bug against `ssamoswap`
 behavior in M-mode
To: Deepak Gupta <debug@rivosinc.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, palmer@dabbelt.com, 
 alistair.francis@wdc.com, bmeng.cn@gmail.com, liwei1518@gmail.com, 
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, 
 Ved Shanbhogue <ved@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::934;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x934.google.com
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

On Thu, Mar 6, 2025 at 4:47=E2=80=AFPM Deepak Gupta <debug@rivosinc.com> wr=
ote:
>
> Commit f06bfe3dc38c ("target/riscv: implement zicfiss instructions") adds
> `ssamoswap` instruction. `ssamoswap` takes the code-point from existing
> reserved encoding (and not a zimop like other shadow stack instructions).
> If shadow stack is not enabled (via xenvcfg.SSE) and effective priv is
> less than M then `ssamoswap` must result in an illegal instruction
> exception. However if effective priv is M, then `ssamoswap` results in
> store/AMO access fault. See Section "22.2.3. Shadow Stack Memory
> Protection" of priv spec.
>
> Fixes: f06bfe3dc38c ("target/riscv: implement zicfiss instructions")
>
> Reported-by: Ved Shanbhogue <ved@rivosinc.com>
> Signed-off-by: Deepak Gupta <debug@rivosinc.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/insn_trans/trans_rvzicfiss.c.inc | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/target/riscv/insn_trans/trans_rvzicfiss.c.inc b/target/riscv=
/insn_trans/trans_rvzicfiss.c.inc
> index e3ebc4977c..b0096adcd0 100644
> --- a/target/riscv/insn_trans/trans_rvzicfiss.c.inc
> +++ b/target/riscv/insn_trans/trans_rvzicfiss.c.inc
> @@ -15,6 +15,13 @@
>   * You should have received a copy of the GNU General Public License alo=
ng with
>   * this program.  If not, see <http://www.gnu.org/licenses/>.
>   */
> +
> +#define REQUIRE_ZICFISS(ctx) do {        \
> +    if (!ctx->cfg_ptr->ext_zicfiss) {    \
> +        return false;                    \
> +    }                                    \
> +} while (0)
> +
>  static bool trans_sspopchk(DisasContext *ctx, arg_sspopchk *a)
>  {
>      if (!ctx->bcfi_enabled) {
> @@ -77,6 +84,11 @@ static bool trans_ssrdp(DisasContext *ctx, arg_ssrdp *=
a)
>  static bool trans_ssamoswap_w(DisasContext *ctx, arg_amoswap_w *a)
>  {
>      REQUIRE_A_OR_ZAAMO(ctx);
> +    REQUIRE_ZICFISS(ctx);
> +    if (ctx->priv =3D=3D PRV_M) {
> +        generate_exception(ctx, RISCV_EXCP_STORE_AMO_ACCESS_FAULT);
> +    }
> +
>      if (!ctx->bcfi_enabled) {
>          return false;
>      }
> @@ -97,6 +109,11 @@ static bool trans_ssamoswap_d(DisasContext *ctx, arg_=
amoswap_w *a)
>  {
>      REQUIRE_64BIT(ctx);
>      REQUIRE_A_OR_ZAAMO(ctx);
> +    REQUIRE_ZICFISS(ctx);
> +    if (ctx->priv =3D=3D PRV_M) {
> +        generate_exception(ctx, RISCV_EXCP_STORE_AMO_ACCESS_FAULT);
> +    }
> +
>      if (!ctx->bcfi_enabled) {
>          return false;
>      }
> --
> 2.34.1
>
>

