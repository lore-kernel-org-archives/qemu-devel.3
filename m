Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FA3BCD98D8
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2026 15:57:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYnCp-0004gV-TN; Sun, 14 Jun 2026 11:57:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wYnCo-0004gE-Vm
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 11:57:03 -0400
Received: from mail-yx1-xb12f.google.com ([2607:f8b0:4864:20::b12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wYnCn-0007ml-Hi
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 11:57:02 -0400
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-66039d3efcbso2389578d50.2
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2026 08:57:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781452620; cv=none;
 d=google.com; s=arc-20240605;
 b=ZPJdiRM/V/CpmBvpW3F2X6VYsdI5TvZyUhchr66q9Tm0ZaWmN/XWr8eqpIpx+OVoqM
 s6Se3gYAIh0Px90l5kX2ITrkM5JwtkQWQsXHgYdllIEOkfx62QzYPh/q/IKLbFa0XGTm
 DDwEC4o3ahf7Yf+njJh9DYLlXgSUu8AaLAl3L/j7OWNXZbbYnM2ScLv/5zrnR4KGEIR7
 hqnXzXWHlE5Q1dwDK/JnirehfzGykyaqX7kop6+vV/u79TVE/2w3C9v23nBy5wjJhbLX
 TC+xoYBaWCobaqdl4FEDoVnvQp0wjIq+fOFVBEtNkh+4kfMmQ+AidbrifVASspXyGhLL
 8yoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=UoEvRsUq0TzhUYRP5kdgXbAjyXcr4+aUqhWl54TZ6RQ=;
 fh=IXo+508+GfmMhKQgq1EsAwKVHqoJy9EFiQCWOmr/kXE=;
 b=KhKVO8c712hVJFOpBws1vvqo1aeH+m1ybBNU/G0tuJNBvWXfuSwpClDwXDfzjlNYsM
 OZf3KAreCj/+xM79/6B7eLhYIgXDoerkD5GMFMt5SH2GaHLm0ny9u1yLhgmFYMOIO5IK
 pq/KUbgN5OMtXocYa0oXLNRfS2dE97IVZCuFTYqiMn/Ssszmg/InqRvOiAwF/oRcfI9b
 EZiz9s3UJm9MW1bTIclf7/i6PvC4/Jp1U0pvcMwt3bppp8ZVVyvfocm/WuErl9QRpPxb
 1JiqhNSWq6JI9znPUp7+RBMxdc0JUKI0LA64n04dVZal3tHtrU4m9flPG31MVFm9joJO
 GZ7w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781452620; x=1782057420; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UoEvRsUq0TzhUYRP5kdgXbAjyXcr4+aUqhWl54TZ6RQ=;
 b=gLZoZPmOuZu1w5ETvfJniAwzzbEvUS8MFoKBw5uw8DNDQEAbI4aSpIOpCaDE4oZPfK
 2xQMsdqO78eK/9qoZ+2i6ojtXzQ3YImOwBLYILCud/gvj92g+zqItwrcoa3r1S3CJyif
 84hY3vEdZX9xBSWrc53ytYDmxI8X30r68ksbV8GWPReNtvhj1DBxU9m+ovdR3npdgmVA
 +O8oMnjft7XEf+2h8PTtc0pRduu2a0atERN9oNms/8JVBBVZ8im90Ahsw1fep+O3WvH4
 QjKKaV7rlldIozadFoul4Nq7CEab8js4OdoUrZMEBMzbkoM6E4vMV5w8SSEOrqrW3s+6
 L0Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781452620; x=1782057420;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UoEvRsUq0TzhUYRP5kdgXbAjyXcr4+aUqhWl54TZ6RQ=;
 b=CCW3FRXKqjQEXGdAEnuNrFRL2g2onM7BmH3Y9KfUM9GsgExAL382WPtRzIqQ189b/A
 ExVxjpcKA81vR5+VsnQ0JVMvBV0l4oN4Jx11uY6WHmbStCAWb9nOoGHQvq7l9uwcq7Sf
 Twz3CnE8cey8J7bc4alS2v/YDGNzQSksJDBFM3gEqAtHDCyfb1srXDc34kkc8HuvwsQN
 kl4zPhKzdnjfsou8TUlPPqBcSHoekb+UJabGbh/U4PmAQfPlx9Yvk03MRVHo8L/DhgJe
 1MM0yasjM8Iz0idDIapwcVjI8CfbUOpsrEVNEbx5kngQsVRyxb2VHnuEBfwqC9XJRX6X
 DsAg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+qOXbCOBgINNdhClxpSkbGfDnZ6KBNPx/t7ldFaU1B5M/n8Cs8cajcoysSqQBS/rISrjjGON2KALDl@nongnu.org
X-Gm-Message-State: AOJu0Ywfn8QNpOyvykjtPXebCkHxdki25gPkIJJvH5ZX5SKeu8ZSswoB
 ez4sJRF1T3AcOXNTt/7HUVzZMkuD7NmuNtnU388d4I43WUfiOgl/OsefbDHAIrivcQkjRONVt3E
 X6FrpXTAWi8c6ircZYyar1IgMLuP0RK901vVSOzgl1gp5dIyZCNSeWic=
X-Gm-Gg: Acq92OEH/8g7Do5CA/cxe6UzFI+dtmBOAMvA3wGX/blfE6o3lK6jCmHml2QLHNaAObh
 HCECSFolTIck1T/fYOmlZqIn7r3NOTeQL38tLOLDz0BdM78nO5dB5mCj08CNwLb2HISYJyCbDdJ
 sGcM0ZWRzlyui0wiPD0kNqMaIP20IiFOnTd6c5x9hFDhrAyhI+pbAlzF5tQ774Ox/evxD9UhHF7
 1jTzRNuRv9Zk+AgSDL/XySp7T+JUG9bSzzFiM7SZeFDnQvL3YMzPimWhWvNGEnrvnfyAUuBAh7u
 6wsbG1Gx8IrPDp+gkDU68RLajEB+yQ6MfstCUTueMNXE02OFPVhp+w3zsQivH7dfnAE=
X-Received: by 2002:a05:690e:b4b:b0:662:8a91:f034 with SMTP id
 956f58d0204a3-6628a91f075mr4771706d50.38.1781452620165; Sun, 14 Jun 2026
 08:57:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260605035012.2876664-1-kylefoxaustin.github@gmail.com>
 <CAFEAcA_JpBaHDucOfvc9NYkQhQBu0Py9hULTNcXajUo9gW6VGw@mail.gmail.com>
 <CANqqvPcJOA7vKYiq6gU9ai3DYCN0yiwW6S-o2xh2JGQNZtLZnA@mail.gmail.com>
In-Reply-To: <CANqqvPcJOA7vKYiq6gU9ai3DYCN0yiwW6S-o2xh2JGQNZtLZnA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 14 Jun 2026 16:56:48 +0100
X-Gm-Features: AVVi8Cftgr-sUXPsCueUs0EhT2I8c2SDBKH_xXwqpOJSoHI-4kDKk3lTMZbFifw
Message-ID: <CAFEAcA-1w9Z4PJnBmh+7MgFa2n+-dyuPKYDYCqM-r_hQphnRmQ@mail.gmail.com>
Subject: Re: [PATCH] target/arm: honour CCR.BFHFNMIGN for probed data BusFaults
To: kylefoxaustin <kylefoxaustin.github@gmail.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12f.google.com
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

On Sat, 13 Jun 2026 at 06:17, kylefoxaustin
<kylefoxaustin.github@gmail.com> wrote:
>
> Hi Peter!
> Thanks, great catch.  You're right that the SG stack-word load is an
> AccType_NORMAL access and should honour BFHFNMIGN.
>
> I'm working on v2 to incorporate.  Basically v2 adds the check in v7m_read_sg_stack_word():
> on the BusFault path it records BFSR/BFAR as before but, when BFHFNMIGN is set at negative
> execution priority, it completes the access returning UNKNOWN data and
> returns true, instead of pending ARMV7M_EXCP_BUS. I left the vector-table,
> stacking and unstacking EXCP_BUS sites untouched, per your note that those
> are AccType_VECTABLE/STACK/UNSTACK and are not required to honour it.
>
> One question on the register bank: I kept ccr[M_REG_NS] in the new check to
> match the expression in the transaction_failed hook from v1, but the nearby
> STKOFHFNMIGN code in this file uses ccr[is_secure]. Happy to switch both
> sites to [secure] if you think that's more correct here.

The CCR register has some bits which are banked (so have S and NS copies)
but some bits which are not banked (so S and NS see the same thing).
The way we implement that is that for the non-banked bits we store
them in one of the two entries in the v7m.ccr[] array, and code that
uses the bit has to check that one. BFHFNMIGN is one of the non-banked
bits, and we keep it in the NS array entry, and check ccr[M_REG_NS].
STKOFHFNMIGN is banked, so we check ccr[is_secure] to get the banked
bit corresponding to the right securite state.

thanks
-- PMM

