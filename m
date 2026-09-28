Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52227CA5FA1
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 16:21:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBE6H-0000Zf-Sq; Mon, 28 Sep 2026 12:21:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xBE69-0000Yd-KR
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 12:21:02 -0400
Received: from mail-yx2-x0f.google.com ([2607:f8b0:4864:41::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xBE66-0000Vc-Lu
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 12:21:01 -0400
Received: by mail-yx2-x0f.google.com with SMTP id
 956f58d0204a3-67109935888so2936170d50.3
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 09:20:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790612455; cv=none;
 d=google.com; s=arc-20260327;
 b=mfBuX3LvqBuq7pdMnHiD1yXvUROxjqGU50bBHijUFc1voZJxjXfwHFA5bgvhEqCEiX
 rh6lkmoJ8T+5Dw0dAfqKFM514hrZte1QxhhVwgLZJOJN60Rfi/o5NRLKzsBDhVuJAZ9n
 35tAhOKXBpNXIqJ7u2fkI8nwxRN1kEM/t5PghpO5O+8hSQLhGeF0ePQIcvT9nzmQwAYP
 rRm08q4CehKtP0NZuZ7ZTLC//Cj+5Yp5eps1Tl20sZjWJbHEWb72YHYFtiJXIu0N9xLe
 KGBw4iBXW6sehOR0dN02NIe3nj6a7Db3xIRWem4HiBisp7H48W3b+r4lzRsHO6gkcGVc
 BODQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=RTJw5B+x6lAXCJ7HOWk4IWp5t8cNWalFlhNq0MyZNBM=;
 fh=DXpb0F5JBlALc+L/z9mpuM1jxP/ZmBTVfj775a/6Kt0=;
 b=o8aivFUtRUfBin5XiQicStn+dAD5TNRcnihADQuacMAqBp4uISOr+ccZS1rvHMjqXX
 EKijBpsidpB7UfUA+JIixbkhK3BxtvOsPFz6Li4X0zrGLgRqb9m68R93n5BnD5ESBGWC
 GL2HQeo6mBYBOFeJ8sdNKOlv2TMRq32xdfnwDYTOa8msOTG2EZAt9AU2p1G3UGiom/iY
 uAFsHlv91k7PgclxwWfkQGZvZo6Yv9Dhvwja/uQDaoy6ZQjEbGzIJoFf99gpMHYFBqby
 psRjlYRPgn+uAf/tK5dYJvsQDrxPXMNLZgn3w0hHMfLigftV6pf4pKa9cohwmj2li3Wu
 oQ6w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790612455; x=1791217255; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=RTJw5B+x6lAXCJ7HOWk4IWp5t8cNWalFlhNq0MyZNBM=;
 b=rtjyEi57dvmieELzIO85EF0stECWwFzBxau4iW89ROU+Wf9jtfWcpzJJ4mpWGNng7v
 LnngiarWGC2JLstulfoAXNSUMt5J/BgUtrVj2wXrjGSvF1jWbJ2DlXhpT/LShP9Ge2uY
 3NvTXiNvVvIF12Ugq9dyQS8Z8cS1eUg66ideQf+puWmk3G7Qx5hJYZLKpt5BU1BU9ArL
 Zslq8PFbHuyY2NGLYvTHLBiDnTpCNUWPWKwivO9eg0gIpmXaQoDFKHAtr8i5G31ozeWD
 8h1vMG0CasvY1DQ3K7vxeT/Hux8xzVp8ohAIrCig1EmimqS3rARx5E3GYLQfx/Tlbikq
 FrUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790612455; x=1791217255;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=RTJw5B+x6lAXCJ7HOWk4IWp5t8cNWalFlhNq0MyZNBM=;
 b=YzXVRz/A7yXWgWESmZ1GsWBpNXTN2cLan25+AqiVPv4lxDvmeD5iMtah0CX8LuiNAT
 WIG2gwapU5XLAn/XnxtCZui0QpSMj0urze6mrie6xY6wqVBivn3r3xrFvEGv6CKMZWbt
 Q6F7COUzgijzKyqIiyhQ0IfpyqgSdzFq8zosiI31CVc2ZaUrP+cZoHTYJczMWnIFGuVH
 JZ//fxC8A0QQcnApf1TiqIRKJE5mY0NQYZHcIpg+oS8CQFDowr2Bne4WEvY02EEP8zex
 kkQ6O6FlbtuoQknziccbsx3FhhKyLtuO9NSWsCakiOjfSfDDT+GBfTSXc773/at07Rts
 9qhQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwNWuAs0AUsnhPDvgqhK4ZMNYvXlhszqxf/Kczr6MLkI1OmAlMp856rr2Ols+qqGozLRm+N3Mf919QW@nongnu.org
X-Gm-Message-State: AFq9FYJMVSGI3hrXkyBjCVAYP9/LMffZyELmnkvWDA4I6k7YQ7fV89Lj
 A4IWdTdme34ZiErM7yQQ8+jXIBGxYBcwezbMTsxc8pUr1qrnYLvoG46xcYpcKDMRvHIW0//Cmii
 TxvoK/MjFKS2Sw/ey83+5hNFiGK+udjEVQdEJ6AckVg==
X-Gm-Gg: AYBFou3WC0YoRnvhvHB+cDg5+dW2giKUTKII56v2VciTV1ypIYeEhnHcLJawGIQj4/t
 iiww6qtrqMvdteux2OucDmDOtpw77yhAbR/qw5KejzPP0sy1v1f7EBue4SPiA89y8sZbQCPSHgt
 exrl4M4YWLx5wrRvH0hs2VZPGlYltsvHCU6gCA5T2tPqiFvVXXpHjUQ5j7Bl/hyJz1KRQf9q3NV
 xZ493FKyh5FoOG+Oup1RYfWPB0JHr/he14jgcHP/SzP7R2vMO+RBcQ9ixR9scKMMYjOLe1ZOUTG
 unUDnDfJWcwI9fXxmCPx3wa9oLfN6bDipVWL29PltwhTADn2YGSdoaWfOynuYJ4izllxfwgc3Cv
 H2jSmULn5NUXXxJRDsL7/A1moGCyhjdGGVnYqjh8=
X-Received: by 2002:a05:690e:1444:b0:674:1489:803a with SMTP id
 956f58d0204a3-6741489979cmr4308610d50.75.1790612455025; Mon, 28 Sep 2026
 09:20:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260921074451.3158645-1-fuad.tabba@linux.dev>
In-Reply-To: <20260921074451.3158645-1-fuad.tabba@linux.dev>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 28 Sep 2026 17:20:43 +0100
X-Gm-Features: AclHuK9YAy-iVlwEpYQck3puycnc-ZFlLIiHFWJfBWMV9JbzEXzS41YIVLEVF4k
Message-ID: <CAFEAcA8fWgG3xcQbQy4nt798kaM5RZPdhGhWvt9FYMunrEuHKA@mail.gmail.com>
Subject: Re: [PATCH 0/2] target/arm: Fix timer deadlines when the offset puts
 the count ahead
To: Fuad Tabba <fuad.tabba@linux.dev>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, qemu-stable@nongnu.org, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, Will Deacon <will@kernel.org>,
 Fuad Tabba <tabba@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:41::f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx2-x0f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, 21 Sept 2026 at 08:44, Fuad Tabba <fuad.tabba@linux.dev> wrote:
>
> Hi folks,
>
> Two fixes for the same bug in three places: the next-tick calculation
> for the generic timers, WFIT and WFET each treat a 64-bit overflow of
> cval + offset (or timeout + offset) as a deadline beyond the counter's
> wrap. Once CNTVOFF_EL2 (or CNTPOFF_EL2 for the physical timer) puts
> the timer's view of the counter ahead of the physical count, that sum
> overflows for every deadline still in the future and QEMU arms the
> timer at INT64_MAX. The first site regressed in 8.2 (8d37a1425b99).
> The WFxT sites have the same overflow test.
>
> The KVM arch_timer_edge_cases selftest, which sets the guest counter
> to 2^59 - 1, hangs in every host mode on QEMU 11.0.0 and passes on
> hardware under an nVHE host. With patch 1 it completes under nVHE and
> pKVM hosts. Under a VHE host its physical-timer half still stops, on a
> KVM bug in the same arithmetic (KVM programs cval + offset where the
> timer compares unsigned). That fix goes to kvmarm separately.
>
> Each patch adds a tcg system test that fails before it and passes
> after.
>
> Based on master (3b5d71cc36).
>
> Cheers,
> /fuad
>
> Fuad Tabba (2):
>   target/arm: Fix next timer tick when the offset puts the count ahead
>   target/arm: Fix WFxT timeouts when the offset puts the count ahead

Thanks for the bugfixes and the clear explanation.

Applied to target-arm.next, thanks.

-- PMM

