Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9286DCD37BE
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 14:27:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMRau-0005be-OX; Mon, 11 May 2026 10:26:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wMRaS-0005Uy-GU
 for qemu-devel@nongnu.org; Mon, 11 May 2026 10:26:24 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wMRaQ-0004FM-5t
 for qemu-devel@nongnu.org; Mon, 11 May 2026 10:26:24 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-bd124546379so100325966b.3
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 07:26:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778509580; cv=none;
 d=google.com; s=arc-20240605;
 b=dy0TmGB0jxRre95iIO6QOefde1YB3rg9IUUN5VxMtmeqy9ffd3SSdnuamUz0NVqGsd
 wCz41UzqyRqtgxfD51w1DFO39nlB8tZ2+WuptEo5/fDvJEiQwkY4oET+xVOG/RtT6F0Z
 cdU4IzF4IYzSReJuh0CPBDp8oE05uCYPxgqzHsJFvEHwuBN4HDJ7Pd+CdguBEHhsYjM0
 p6bTYYdJ2mxXPpkdBk6+IIiIo/ceok7pMJv5fP+C1dyQToaz0j0of16PztVry/otYdHF
 DRnniZrQ8YZt9D6K7Ga5SCmDeS8tz8T6vW/2GEOKs3vBuTCKvzWgLKukmv7PWj01zqRW
 9dXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=VScJPRn7kUHiCGsfov1RINMympbLnS85EsQwYRBChRo=;
 fh=8jLQ9BF8TzoH/ErGnlkH4vSIZ9SpUVgmQkqZ4x0ADis=;
 b=BaRZJTV0za+ckPr2Zw1ONqpnVX61GiAfpDyycQsCtyM+OSrTHt+Q+hYl/CJSndaqF8
 1KYEPil/E+FPe0zHuNyjFC4B8S03033z+xjZ8UZ1K+85T440JXiRLgaHlEslwABushgN
 2KJJq1CcI0MAHq8XkK9NguPLR1ERFSAiXNGvXCBaxZjE/jnrBczANUGlDUEX1qmT7nK9
 nJ7B5U03KgQIf6ko8VdukqY5ZBI5+c7FI1IJbx+vRxcCofTFAJtmrkF+j5leWQ/+nfPU
 XJyqjtZrC32A1bcMRD805k1SEnJFo9yyA18YAD5CO6M17lPDIa4arZM7hBlKhaoSOhCY
 46HA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778509580; x=1779114380; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VScJPRn7kUHiCGsfov1RINMympbLnS85EsQwYRBChRo=;
 b=LYzUul32V/wL2FUJullTxYir1E1ma8ahF+Vm9Q3ufdUv1QPNrihaH05+vUPaPHRuOA
 g8eOyB/Vd6Q7NSVu8bG2v8qN1mdSb5TECpJz009UgZINcUu9SMU0OvJq5iUyyANVKZ7b
 Jv+49Awe8kS3zY7heAhwnOIHu58+kw92l+TDf2wKxoHgFY8IpShSxbV7ThUbN/l6gGJw
 VWept/5BPGFN8u7DZhfAHZT4BczE1n6XhyGxHCxiqzMRf/T+qRkEIh1dwXjHiM6lXlxW
 EZRoYIlzdzMy14F3bSxGXj2N99Fj10QCLn3PS+4c597tEq/56DRB4QSG4VXk3gtSBGSa
 yg8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778509580; x=1779114380;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VScJPRn7kUHiCGsfov1RINMympbLnS85EsQwYRBChRo=;
 b=aHbDQyC0Z3+PMUhnCedWiHdYx23V8oVvJcMqLUTBDft9+3i9ZXpcE9qn4T7yvj81RP
 4hnorlloIGiAm3+OiQMMaODowz3iiQJ2vqF0SPkg5dov+Kz5tdg1hF7Prmg/LNfUwPp2
 CeHbkluO16sWQ2K+j3PMhnGHWSVdC1lb3HVwzv7ar/tDSW5YB9zyCNilDJYtgvjkC7WD
 keXebbiAtRAL2XVpAZSyofriBtFEH1w+rVkoxXuy7gmc9K6BQuoZU7XFFQVfOcPXyVn+
 GoJTiewY5qvJHKNfcyq1lpn4VHNibLdo9/0lBIKDNNXR2mXsQ6IDnJIjaAmPWWswMYsI
 zTeA==
X-Gm-Message-State: AOJu0Yz+baOLyX3WU5vgnE/mjlrIdfbF3lO7A7pNS3zp+bG7TxJ5iZWa
 DfvyLGgUFxxwfu+a3BsShXcqAGO2AFON/7qRmB3wboRzz9ZWFU4C0apiJNavlrLOnnMRLKPoZYN
 oFu3XBYWcBJzPuWfInUDwfrGfqkEkHOzrZ+xpDSY+Sg==
X-Gm-Gg: Acq92OFClJOLI5rnFEUANTKmG3wWtOa885oKtc5dl5mLMY1zGYbG52TEqCvb7DZft0W
 W+ZOWkUKmj6eglUZV4icL5JKXLUiG/a0yRmkMIChYLiZ2s0pwj9r3Kc1BirYbgZG5M89057Dwa9
 TkUYZajxMTAr4+AvkxZrW8kjTJ+JHjpnKuGzn1ttNwTIw5G01rwvYOpMG8Y9Ef7hh6LVnvdq+dt
 5H8Sh1LrnYUtX5VHqyCjlUsIG7wioO63Z3tBOrD8Qva/Jc2h8dJO2mDm5lVpmuOH4URfU/TY8hd
 vvwuTf61vsvhYmU1+8F9DV9AoLQeQ2WtsKzVjt+LQOSalVa42QNIXdKkMAXp+0XxtB4=
X-Received: by 2002:a17:906:ef08:b0:bab:d8e9:53a7 with SMTP id
 a640c23a62f3a-bc56cd297b4mr1537056266b.29.1778509579424; Mon, 11 May 2026
 07:26:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260511141049.1293449-1-peterx@redhat.com>
In-Reply-To: <20260511141049.1293449-1-peterx@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 11 May 2026 15:26:06 +0100
X-Gm-Features: AVHnY4JseARZ7mQGIXB9dRCxALimbPLtgXexhs3M5CWpblatB1hUhEy5KinJPA0
Message-ID: <CAFEAcA88Ui1tG0PEwbwSnSBMaywMJEy5bLLVwXvGdW_06pgJ0w@mail.gmail.com>
Subject: Re: [PATCH] migration: Fix possible division by zero on calc expected
 downtime
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Juraj Marcin <jmarcin@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x634.google.com
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

On Mon, 11 May 2026 at 15:10, Peter Xu <peterx@redhat.com> wrote:
>
> Commit dd4fe8844b changed the reporting of expected downtime behavior, so
> that the value will be calculated on-demand.  One side effect on the change
> is QEMU will allow the calculation to happen anytime even if there's no
> transfer happening for a short while.
>
> PeterM reported an ubsan report from clang when running migration-test with
> aarch64 binary on x86_64 hosts.  I can also reproduce if I run the test
> concurrently so some of the src QEMU may not get chance to push any data,
> causing mbps to be 0:
>
> ../migration/migration.c:1051:12: runtime error: -nan is outside the range of representable values of type 'long'
>
> Fix it by checking mbps non-zero before the devision.
>
> Link: https://lore.kernel.org/r/CAFEAcA-MYH6C39xO0OLx4-M5pKurJpurwRsMqZe9q=W-NShAbw@mail.gmail.com
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Fixes: dd4fe8844b ("migration: Calculate expected downtime on demand")
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/migration.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/migration/migration.c b/migration/migration.c
> index b6f78eb3ac..b06e577328 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1044,12 +1044,18 @@ static bool migrate_show_downtime(MigrationState *s)
>  /* Return expected downtime (unit: milliseconds) */
>  int64_t migration_downtime_calc_expected(MigrationState *s)
>  {
> +    double bw;
> +
>      if (mig_stats.dirty_sync_count <= 1) {
>          return migrate_downtime_limit();
>      }
>
> -    return mig_stats.dirty_bytes_last_sync /
> -        migration_get_switchover_bw(s) * 1000;
> +    bw = migration_get_switchover_bw(s) * 1000;
> +    if (!bw) {
> +        return INT64_MAX;
> +    }
> +
> +    return mig_stats.dirty_bytes_last_sync / bw;

I think this is still UB if bw is a value that's nonzero
but still small enough that mig_stats.dirty_bytes_last_sync / bw
is greater than INT64_MAX. It might be more robust to do
something like:

    double expected = mig_stats.dirty_bytes_last_sync /
        migration_get_switchover_bw(s) * 1000;

    if (expected >= (double)INT64_MAX) {
        return INT64_MAX;
    }
    return (int64_t)expected;

(which will also handle the infinity case, because
in IEEE fp infinity is larger than any finite value).

-- PMM

