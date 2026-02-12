Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36E7FEE3698
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 17:00:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqa2V-0005na-7w; Thu, 12 Feb 2026 11:59:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vqa2T-0005n8-2w
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 11:59:37 -0500
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vqa2R-00070H-0m
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 11:59:36 -0500
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-79639c2d2b5so1044777b3.2
 for <qemu-devel@nongnu.org>; Thu, 12 Feb 2026 08:59:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770915574; cv=none;
 d=google.com; s=arc-20240605;
 b=RJKFobmXBxuUzPV0KWn/rjjYwSYcTf2JqUccbERvm1VFb7B5wRtScpcJwQjfQWGQIS
 4iEnhdh9U0RoVAGyTH7GJoZPc71iPEZwr6UgixMhst3sJYHRuOq6H74D5HmdwX6Nklhn
 E+oZBoJTcgPITEGGKh4qnp66r3NUBnpgYPCLujZdIumR9mFwPZZRUTv09A73yTkm9zLb
 NrFFa57t4XcuLREz94aiaDVS4InYkXK9xNzxJv4uMHIc4rooc88uwhaD37ZL9l8mqG2e
 3OPCvgrFzLHK2W2laqMQxCCTV1eUEbimQow0UibqbRy5E8w6jz+MSelT9ECi0KrFUh+k
 473Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=6ryfLjIT7fNXtUJmQgZ8rcsGiXr9fgihBYtj7Jh9L8g=;
 fh=K8hRS/vbP09WuEdhfaQpbk2R6Sio4smz7i6jmQ8QzBk=;
 b=H6T1vqQEmNeWbplE4Z/5jSRnKOe8mBHmZruIantbkXKlC8JghFMqrA8v6HtKxArls3
 Zbj480nEgXnNDTIAYYt43rBiG59AMD7VI9TflD/29/c6/2t9F8qw3R8Lf4U/fsbHIr7m
 ciuMb63YDmilgpwvKRjpjTwU8tT5nn/Q1qsKkVCmUEWYj5zZ/tmtP+mUtHL07/TS7HKN
 /s2iwxKAcCbb8hkUZj3bOG2FDHSzVnkpW7VTMfp+7afRwlg2llzlb9dESn+dSo0Dn9wO
 8AD964yTnzfubHLZhvMB5+0XCEPukAbfSjv2p8Z1jXWSKJajg9bhBdRGpU0ohWFw5WEg
 E53A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770915574; x=1771520374; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6ryfLjIT7fNXtUJmQgZ8rcsGiXr9fgihBYtj7Jh9L8g=;
 b=QZIabzFdoeyCj0SzUXdPqSyN56l3gMoFFZKNfk9b9aogLLEGhbXvaINPBaig5dTFhc
 jlkJkg676OJnshmyPQc43wsjjlarzIwlvSx7N3MQNXAU1G+yfCD1E/PUw86s+6hfaHSe
 Cts7dsjRlfFx+uo9kXZhDeCe33ithGZixAOAl+v0xODEcjQW/bPQSfLor0PVtoToisiT
 vi9YK3+3B5SzgOLmnDiTxatu1k2ybkxiKj6f7gOBgY0t3u38MeukqY2tZnKo3jD2IhVO
 /zfdCt8ljjuJnKAHw8lS8VwAHLrT50MHIW5s33Y3ilgIRxnEcATnPlXFyMXGjODHV/dY
 KuNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770915574; x=1771520374;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6ryfLjIT7fNXtUJmQgZ8rcsGiXr9fgihBYtj7Jh9L8g=;
 b=woEIjC7nOWYvcFtu+yG3K+Pa1ygG+SxPVLU1s3CAw08OFW1n0N8A54MHz/d1ybz+lL
 wzkZn/7hzaIg91rBBo8ASiidDpnEjNzI5sRuU00L5jK8I42Iw4gM1i5i5x08SEWWKSS5
 i9NFPCuc7Xt0W7jDsriSgUotyRp/CS1pZT8tWnbvavPoiDQICmGQPNoXasmwf5jTQm7W
 MeP7/nCUQRQ5xAgIuGjYfb+5B4bVS0/wrnXDXKOW/AvbdjF9PPLCbrQHMzat4KlNyHQ+
 e5NMiX/uK9Tm5waxzKFUjTdqJ6jd/P7Ic+KioWOrSXDcgFqh/14MeW5n9ahT/mdkwTy1
 PrQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0PaeVkVBLtWGIimcFzrmto1sulIXYeovT2I+pEFcPft5/t7CPeGpW9BNUxf2Q8WzoCekQWXtIOdys@nongnu.org
X-Gm-Message-State: AOJu0Yz3nXcGkelrJQdkXA884qGaFKcRM8V20asD3ltsXpNcRGef3G//
 hEqXvCN7bPzQggbeJ4xM8//on9PZ+dJcCGIYHrLRGI/AjLITprReAx+mNlpNLRFD6ogp4koXzUs
 N89R5QktEukD2EkWDPOko3RLmVbSbia1Wik3kUOGBoA==
X-Gm-Gg: AZuq6aKHzNzJmbYXytf4AuZQcSzn8doed8QMBKo84GiQI8EIjHj2t8DwXP5RjT1FHb4
 3FCVu0FRlZY33wR5wgPAKus/uVwyo5bgpG6ND2qYZTNGuZLqqCGnc+EdvMEOTKEMLaUEqv82jj2
 yiaCu+1V7HxoipBvMx1bBkP2ZI5zbKr6PNKCtct3IkkosaS8FNmGP3/L1vu6J3FmsaXyj/GFd6h
 6ad4Fazi6hCPIRkQ99UTD7a9Hqou4KpuZDsEz9iDQB4MHTJ0LGefcZtFdROTSuBZN97xNANIw4i
 pgQo8OkGPWbBnyIyrqA2pskW81k+bvtmDgtQBp0Y5ssYeDHqPgfhwaIQ1n/aSt46O3E=
X-Received: by 2002:a05:690c:6d13:b0:794:e85a:2b6a with SMTP id
 00721157ae682-797376b8eb9mr31255637b3.67.1770915573610; Thu, 12 Feb 2026
 08:59:33 -0800 (PST)
MIME-Version: 1.0
References: <7f6a6958-b72a-41fb-923d-09ed4ab3ab1c@linaro.org>
In-Reply-To: <7f6a6958-b72a-41fb-923d-09ed4ab3ab1c@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Feb 2026 16:59:21 +0000
X-Gm-Features: AZwV_QiJMTYqX4zoWLp9MyO0UlmYBnVxPjy66GhyETrFewldUe1xBecXYnioJ2I
Message-ID: <CAFEAcA9D3Wx2w7i2X93uX1H3GtrqdVKtGidG309XLb=AdGVOOA@mail.gmail.com>
Subject: Re: exec: On migration_legacy_page_bits() & TARGET_PAGE_BITS_LEGACY
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Peter Xu <peterx@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, QEMU Developers <qemu-devel@nongnu.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1136.google.com
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

On Thu, 12 Feb 2026 at 15:52, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> Hi,
>
> TARGET_PAGE_BITS_LEGACY (previously named TARGET_PAGE_BITS_MIN)
> was introduced in commit 59811a320d6 ("migration/savevm.c: migrate
> non-default page size"), released for v2.8.0.
>
> Consequent commit e97da98f117 ("target-arm: Make page size a runtime
> setting"), also released for v2.8.0, enabled TARGET_PAGE_BITS_VARY
> for ARM system targets.
>
> Last up-to-v2.8.0 versioned ARM machine has been removed in commit
> f54854f9841 ("hw/arm/virt: Remove deprecated virt-2.8 machine").
>
> As of today (v10.2.0), only ARM system targets:
> - define TARGET_PAGE_BITS_VARY
> - define TARGET_PAGE_BITS_LEGACY
> - have vmstate_target_page_bits_needed() return %true
>
> (See migration/savevm.c:)
>
>    static bool vmstate_target_page_bits_needed(void *opaque)
>    {
>        return qemu_target_page_bits() > migration_legacy_page_bits();
>    }
>
> Thus as of today (for migration, which is system emulation) ARM
> targets have a target-page-bits subsection, and all other targets don't.

If I'm reading the code correctly, Arm targets *may* have
a target-page-bits subsection, but don't necessarily.
If the Arm CPU decides that its target_page_bits is 10
(which is what migration_legacy_page_bits() will return)
then the needed function above will return false.
This will happen for any guest CPU which is one of:
 * M-profile
 * R-profile
 * v6 or earlier

None of those are accepted by the 'virt' board which is our
only versioned-migration board. However...

> So IIUC we can remove the configuration_pre_load() hook:
>
>    static int configuration_pre_load(void *opaque)
>    {
>        SaveState *state =3D opaque;
>
>        /* If there is no target-page-bits subsection it means the source
>         * predates the variable-target-page-bits support and is using the
>         * minimum possible value for this CPU.
>         */

(This comment is partially wrong if my analysis above is correct,
incidentally: the source is definitely using the minimum possible
value for the CPU, but it might be from a QEMU that post-dates
the variable-target-page-bits handling.)

>        state->target_page_bits =3D migration_legacy_page_bits();
>        return 0;
>    }

...even for a "same QEMU version" savevm/loadvm sequence, I
think that if we do not set target_page_bits here then we
will hit the "Received TARGET_PAGE_BITS is %d but local is %d"
error in configuration_post_load().

That error (i.e. diagnosing clearly "source and destination
disagree on the TARGET_PAGE_BITS") is the sole purpose of
this vmstate section, incidentally.

thanks
-- PMM

