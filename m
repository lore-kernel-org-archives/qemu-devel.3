Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 344E6C5CFCF
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 10:56:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtk85-0008AQ-NK; Tue, 11 Aug 2026 06:54:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wtk83-000880-RT
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 06:54:43 -0400
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wtk82-00007l-5w
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 06:54:43 -0400
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-80bb41f7f3cso30538687b3.2
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 03:54:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786445680; cv=none;
 d=google.com; s=arc-20260327;
 b=jNXuRkYKOnGTsATEIxgd/5RFvCam28AwvSYkVRIvuYUZ2TUAJvhskN0WftQmWdgSHe
 z3giu/miq/OyAeNjG30lhuo/lBpYyvxCsX+9UB6TbIhlq4JEriLqzGlSqapoEAG8fYVF
 i0KWY/xmiQsifJ+s4l0QZFXh6W/Rky92C7wWOKzO6xjN63znziqgL8X/Hm2f6O3s8eXO
 nFVA7Lit+FvOMqgJJRDQULed90w43T9xrTSZBWAEKpr9XLO+Rl3Dfv+UsuTB7brfS/SM
 GXi2miltCL7jA29u/fiRIC53TtJ4OH+ZLnTHj2PKG/dzXo6wARuFJq10h9yAb//oK6ii
 EkTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=EptJn//rGb7jHcwj96jCJeU0R+HpApyeTrP752eDwEY=;
 fh=iwudhItC4xSGmiIeYfsKWTWy7D/x/N0NDyvs//gGYeA=;
 b=cAoFL0p4JtuIZnLBwYmT0j5xyfrUMawtIqkPpU1Bv05h9KmO2IZPAHwiqyzE0LdonB
 ZD9L60aYis6rqhhT3L0JtTCYirH55YpY2pXZ5Y+Uu2p4JdLPCB73Hysdh/aCrlrI6qTS
 UrXVG9UH0SkQwE0CA5EwkP1ppbMt1nWAsAh2ydhUszZmLTjXv/XL/eZaOQ69d9Exfm9A
 C4NKdTD4hwWphNvZN4DlGOvdV4nqwYihGcYuPIatFORnzNlLUTg29TKYMDLH1hRg0tiE
 OAGdiGpfGH2cV5PW77CDXd4Wal2Kfu+QhpL8X5Irrz3HWIOjMF83Iqxn45/bnjqUD0nq
 upKw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786445680; x=1787050480; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=EptJn//rGb7jHcwj96jCJeU0R+HpApyeTrP752eDwEY=;
 b=BxZgtv/lHqmfZ0/ZvlMKJvtpHp7JPkFTIYgov4Jeq7Z8nCN5nJn9XUnAZt9e6RFWGu
 tlt/ndLFrmjiExkvWnYPCc4VRer4VIe1DTuuz5MwvUTruWndWC35SrhSNRTZiwy/f/Qm
 6u4na/3dtGCe7dy1A7XKZ+0IUH8cftdQxliK7Amxyh+xUAB+9lucY5yJkXLBAuskTtQ8
 X+gkr1C/SfC7jJFcL/JWT9T4oehzl1ZpupNbxKqpDRmybX9dxiyf4TrJpbKWeHWgklrp
 HXBOwLLDXczyxw8OXxjfVY8iOvljZaPsbpS8rsdC0Coo+lBj+oS2Z/1zPSlPN7l6zjDU
 7Hsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786445680; x=1787050480;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=EptJn//rGb7jHcwj96jCJeU0R+HpApyeTrP752eDwEY=;
 b=YfdhWvupvg8Zw2n2y3vUnLPRazkyczG3/RDCgwRgoapEbplKXNfJ2bwwgG6BgIOrB+
 nkGgV4AdB5BLZXj8R8NwkSGvMi8P1+pIJUhSW7eQYuJEA1HB3rbRNKBUwgQ8/prDH3RJ
 nN1pi54nf+8DFxlUPNq4FEyXAWuXlUb2meJCIE6GUSXL68FtpZAS+T6MDSRDXVl33oia
 Ry1B7NQ0Q0D6ygf81tTouWw+8bTl+dGLsOilrTPVrBY3kbcKpuQMGtCKXYE7vKaDpdW5
 NzTk280jyBAo/m+ei2wtGHPifjQlEknuYKPhe4PdtyZPpXI3zalp88mLB6djFa2Bxv0A
 jxrA==
X-Gm-Message-State: AOJu0YwZy7h9qVDr+Mejajh4NzPUpk7p44WW/j1FxgSQ09229zqJw8br
 ct+ctlxrIiSoEnQGJBKk+KkvwTPMwaM5VhW+Sh3rKOpiEYXZ4UYMCQ+YnEP/zUeAL6nE3da7yT9
 m2I6B4X9S7SgoZh3Fs7KmsQ3pw7NnwAhxWi6X6PRvnw==
X-Gm-Gg: AR+sD10JCorLrNAMyuN9trN9O6W+Z6rZS/1HP3Rzvmoo/o+2r0hacBCgNAdhZD7mUwc
 To5GUNb+uWQ0qpAWD5pkmx6exzGzPnD5/JLJoLRusrt9sjAhbysbpnTArUF/lnp4Z5CRLuRf/H3
 y3OQJeKexn5eMJ/5/BREXDmZc9+Td0MFAK0/0ulRVlYtTmkAheZQJ3WkWN2dLH8KFc1pnhXrIsP
 Iq9Pv4VMj6suGx1pLLZp90vqImBWrUONGbGYdKtpVRR41IpaBrVNxHV+Q8n5DysZuRqsKbkhQMm
 rLwgMCIQuEIm3S+EL721Yige3w9HowS2uATfRrwZDcDOPrqSpG9/o59MVC5vxp3IYsMeuXL52Ly
 9QHuxtxsQzmWl0Ml0Apw9OAensnHqFIOIEL+AW4c=
X-Received: by 2002:a05:690c:e3d0:b0:812:be92:6ea6 with SMTP id
 00721157ae682-82f2e45d7dfmr13705907b3.28.1786445680503; Tue, 11 Aug 2026
 03:54:40 -0700 (PDT)
MIME-Version: 1.0
References: <20260725231142.61663-1-marcelomanzo@gmail.com>
 <20260725231142.61663-2-marcelomanzo@gmail.com>
In-Reply-To: <20260725231142.61663-2-marcelomanzo@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 11 Aug 2026 11:54:28 +0100
X-Gm-Features: AUfX_mwuv4V2wO_Cip_DwAQPojC7cBBZED8tYp9UBzi1OWq1bPkCjT7m0VqvncM
Message-ID: <CAFEAcA_Ge+V6+Dm5WQqVzF-On6yfGSdAmP0wSQhHfSxqWSb9Yg@mail.gmail.com>
Subject: Re: [PATCH 1/2] hw/misc/bcm2835_powermgt: implement a real watchdog
 timer
To: Marcelo Manzo <marcelomanzo@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 Jason Wang <jasowangio@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112e.google.com
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

On Sun, 26 Jul 2026 at 00:11, Marcelo Manzo <marcelomanzo@gmail.com> wrote:
>
> The RSTC register's write-config bits (0x30) being set to the
> "full reset" value (0x20) does not mean "reset now" -- it arms the
> hardware watchdog so that a reset happens if the WDOG countdown
> register is not refreshed before it expires. The previous
> implementation treated any such RSTC write as an immediate reset,
> regardless of the WDOG value.
>
> This is dormant on older/lighter userspace (nothing in Bullseye's
> default boot touches these registers this way), but modern systemd
> (observed with Debian 13/Trixie's systemd 257) writes to RSTC as part
> of routine early-boot watchdog probing. With the old code, this fires
> an immediate reset a few seconds into boot; combined with -no-reboot
> this looks exactly like a QEMU crash (clean exit, no panic, no guest
> reboot message) with the last log line being the RSTC/WDOG write.
>
> Fix this by actually implementing the watchdog as a QEMUTimer: writes
> to RSTC/WDOG (re)compute the timeout from the WDOG register (in units
> of 1/65536 s, per the real hardware) and arm a timer for that many
> nanoseconds out; only when the timer actually fires do we request a
> system reset or shutdown, matching real hardware behavior. Clearing
> the write-config bits or the WDOG value disarms the timer, and reset
> disarms it too.
>
> Verified against real Raspberry Pi OS images under the patched
> raspi4b machine: Bullseye (5.15) and Bookworm (6.12) never exercised
> this path either way; Trixie (6.18, systemd 257) no longer crashes at
> boot and reaches a working login/SSH state.
>
> Signed-off-by: Marcelo Manzo <marcelomanzo@gmail.com>

> @@ -113,6 +136,7 @@ static const VMStateDescription vmstate_bcm2835_powermgt = {
>          VMSTATE_UINT32(rstc, BCM2835PowerMgtState),
>          VMSTATE_UINT32(rsts, BCM2835PowerMgtState),
>          VMSTATE_UINT32(wdog, BCM2835PowerMgtState),
> +        VMSTATE_TIMER_PTR(wdog_timer, BCM2835PowerMgtState),
>          VMSTATE_END_OF_LIST()

If we add a field to the vmstate we should also increment the
version_id and minimum_version_id, and note in the commit message
that this is a migration break for the affected machine types.
(We're OK to break migration compat for raspi because it's not
a versioned machine type.)

I couldn't find any h/w docs for the watchdog (is it one of
the undocumented devices on this SoC?), but this all looks
right and matches how the Linux driver uses this register.

Since the version bump was the only issue here, I've applied
this patch to target-arm.next ready for when we re-open
development for 11.2, with that tweak made.

thanks
-- PMM

