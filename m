Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEFF8C79F9E
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 14:57:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3xGG-00015d-57; Tue, 08 Sep 2026 10:57:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x3xG8-0000zG-0n
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 10:57:16 -0400
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x3xG6-00062G-Gz
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 10:57:15 -0400
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-836c4474028so43126157b3.0
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2026 07:57:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788879433; cv=none;
 d=google.com; s=arc-20260327;
 b=Q3XC9GClFP4NEKcpyrrYqOlLCvnNx5Y8O4IFP7YMfAitUDsXRd4/X7j2s5feUCYQJD
 DjSHZsN3GAHIQKYv5RQse/5bPLQN5zkRgpm1WCnTrK4cPcIVY2t0IFb8iK8rRXYuxv9F
 lhpxkiOy1Tgp8aEeXGdnfUdMamszhaVP3NsF9wNpyMNMeuw7NJxXAsRB2oOTwOxkaNJ8
 GqCpqKhZAXo9bsqseB7TXcLjUn8l788cuMGMAs7/boHCDyWslPRA0DHkvBfYzVDExe4g
 hJ1P0Kz89x9w4TUCNHBGW7UF6DL1JjWwGakIzJ62N8pELChssald0qV0NiqtmVy3o1Ma
 8HCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=K502AstubGpzuMkVuzpf2cJqRo/TEiK7/6dVIYv68OM=;
 fh=ieLaz7e/0RpAqfE5XLQ1RcBHWjTUv1z6arE2SouQh04=;
 b=mZnV2zbvlMAkLbb5fr5uHxDe4KsnErkGmyS7bD3+KyvDDREiS42daQQqL6q6Omzo1E
 IS66a7cK3DRmmQlFRFxvGxoe8BTW5rwWDkWNiWajCJu9dVXXSJUi3yzCGeV3OVPmWqTL
 bZmLBfsaku2UAKV22F1rhn5v5UWP+9SjPrjrRDk3Ql4GS3dunRm8Ym5sfJMxp6p/G4mF
 qD9rRCgHMdFJ+4QndxiYtgNUwmxbqOlidwas725JWlEpNpTqwMOLRU0nNo8yFhHvOTO0
 IBKf0VlcD+0JiHV9dnq6oIDE/sbN454qbE6j39L5urpM16yz/pmOCB0gbhIdf3H7lHT0
 59WA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788879433; x=1789484233; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=K502AstubGpzuMkVuzpf2cJqRo/TEiK7/6dVIYv68OM=;
 b=tZMuG/CV1vEuHjaiAu18cPJF1k+8xVMvU+ZeqhkfzmDyYXJE8HsKgw7HZQSE89c3xM
 qkszb+6OMlRBIBEC4DNsn74I10UzZlirk1uJJAgBBETS3Ktbrf40Z+cF9PErha3tXkRL
 wlsxht14W+fzoC7g8fJ3kOnowQnCPTZhd3RPKSgAY1mTmdNeScdndXacMrLd75lZT3hF
 iWNQZpHK+DECkxuXvsr8Kn0dMkVgpgs93vJe/aZsKm8T7h0udDL49vMo9lIJi6eXsuOc
 /VzYQYNMV64EhhObBuu90lN0J6bpGAl/wDZkEsGVkBfrl3Lh5cnovThlpbu36l01GBSW
 rkrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788879433; x=1789484233;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=K502AstubGpzuMkVuzpf2cJqRo/TEiK7/6dVIYv68OM=;
 b=l3DFX23gO1QGVhArfSX7lKbV7VvGgFN3glswoBilnnZVjRj6qhJXUHfLpuUfRJryq9
 wIQp9HKs90DOgvNXzGKfLz5+y3P7Valg8Ew+XeSc6KniVyNHZT70/K2zuua3dHUFRr7s
 lYreHUwwOSamxQjV28wg+2h8UNt+zLHLJ8bmCVz0usyebI4DHGP67HsTZbpnQqYXLQKo
 y+rB6pMeQFIAmRZeLJD5nxSEPCU3ZZAu1HZg5MrIL2Zfvd+w+cHVYCNA6wBhH/xhYMNz
 0Ewx9USrHchifPk7QNtcCXZ0Cc1JLZVttjQyJerNUmQ8Z39sRzP4tOeAi1hcfPEkUYXX
 0n/g==
X-Gm-Message-State: AFuF++kJLn1/8hWBGu5GmXZKx6FPiFeVCLLN4hYkhdsq4dG8ytghY87M
 kI5ZkRHeqaL2QbtXK/ADlRfoJBNrXnAGSsDszLQL2eB/H1lAndQ2lpHRfR49gX8l5qdKGzlcTzn
 g+efEr5ElqIW9sONLJ7kou0SHzF9wLE56lhYUVNlSng==
X-Gm-Gg: AYBFou3Dl5kU+s5l36CnipYbP0N0TRJjmqb4ganl1pHDgXL9y07YrkPhJEjYaGiIeYp
 MFVer/PMhA/ofazvwo4PYZajLA5BxbPRBc2OqFJF+KBb8UDzL7mm/P76POt+lU77PxO3FvAvbG1
 jxA4XEWkMnL7KrkxCYg/f9YOnKq+bLso9z4Z1j76l1sJ3w/04yAR5LgmYOHc7sHaZ7+G+598G1V
 Ge5PHbZEsqrP+TpUCYYH88Y4kmqR5ifxMmd8v/yZBtlSbZvfaHzTtZkAGc5MUruOzQwLh863btm
 2V13YCYgGISDXFNoNyLrQyYp3eciPG4kSRCK4gazB8mSLa5PPADm3PmJMaNMh9pHNCG7Y/pcojU
 oM2l1wQsK9s/54CpjsVzWYdJ8yhlJfg==
X-Received: by 2002:a05:690c:dd3:b0:874:894:9a52 with SMTP id
 00721157ae682-87408949e85mr61995617b3.40.1788879432869; Tue, 08 Sep 2026
 07:57:12 -0700 (PDT)
MIME-Version: 1.0
References: <20260902122646.2848464-1-imammedo@redhat.com>
 <20260902122646.2848464-6-imammedo@redhat.com>
In-Reply-To: <20260902122646.2848464-6-imammedo@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 8 Sep 2026 15:57:01 +0100
X-Gm-Features: AcwNN1VvIRkc1Pif0A-rgioUQYAgPl5jr-bBNyrTUrh1Co6y_S1-zQzP20U1_lk
Message-ID: <CAFEAcA8-e8FGfBkgWjvv6CsaM4ft+0sXK+1bCWziu5RmS=NSbA@mail.gmail.com>
Subject: Re: [PATCH 5/6] sbsa-gwdt: don't arm timer for compare values above
 INT64_MAX
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, leif.lindholm@oss.qualcomm.com, eauger@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112b.google.com
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

On Wed, 2 Sept 2026 at 13:27, Igor Mammedov <imammedo@redhat.com> wrote:
>
> QEMU timer subsystem uses int64_t, so a WCV value with bit 63 set
> would overflow and cause the timer to fire immediately. The SBSA
> spec defines WCV as an unsigned 64-bit compare value, so such
> values are valid per spec and represent far-future deadlines
> (however unpractical).
>
> The current code is not affected: WCV writes don't reschedule the
> timer yet, so a guest-supplied compare value never reaches the
> timer API. The follow-up patch ("sbsa-gwdt: reschedule timer on
> direct WCV load") changes that, at which point an out-of-range WCV
> would overflow the timer. For example, Windows in GTDT mode writes
> WCV in two 32-bit halves while the watchdog is running:
>
>  sbsa-gwdt_control_write [0x8]  <- 0xffffffff    # WOR (~4 sec)
>  sbsa-gwdt_control_write [0x0]  <- 0x1           # WCS enable
>  sbsa-gwdt_control_write [0x14] <- 0xffffffff    # WCVU (intermediate)
>  sbsa-gwdt_control_write [0x10] <- 0xa906ca28    # WCVL
>  sbsa-gwdt_control_write [0x14] <- 0xecb1        # WCVU (final)
>
> The intermediate WCVU write (0xffffffff) yields a WCV above
> INT64_MAX; once WCV writes arm the timer, this overflows QEMU's
> signed timer and fires immediately -- triggering WS0 => WS1 =>
> reboot before the final WCVU write lands.
>
> Add the guard first, before the WCV rescheduling patch, so the
> tree stays bisectable. Instead of arming the timer with an
> unsupported deadline, leave it disarmed. This reuses
> hw/timer/sse-timer.c:sse_set_timer() (commit 0b8ceee822
> "hw/timer/sse-timer: Model the SSE Subsystem System Timer").
>
> Introduce a sbsa_gwdt_set_timer() helper for this and route the
> WOR-based timeout through it.
>
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

