Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08836F31E51
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 15:56:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wArjh-0000qA-Fk; Thu, 09 Apr 2026 11:56:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wArje-0000p7-07
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 11:56:02 -0400
Received: from mail-yx1-xb131.google.com ([2607:f8b0:4864:20::b131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wArjc-00026U-Au
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 11:56:01 -0400
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-6501e465a8eso1145888d50.1
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2026 08:55:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775750159; cv=none;
 d=google.com; s=arc-20240605;
 b=BzS+jOw+0XIwrB+M04p7/XPKoPdwybjCrHYT4N38RlZGzkOohuToiH2RzcMGiAmEPh
 TQQUfbDuXLjKCh5HkGp7P8OMcr4jCkcf6hziiAuKNWsvDYffwARcYfFfdPTfHXqNzNn3
 0HprzslnhN5jzMIP5ZAEykrzkdMaPElYFpvJf/jsBZgSu3k6VEO/DiQSsmMAfcw9Np/K
 GwaAB1R91H5oiyAFu4eh3nY+QEaYI21UPUMJd1a7X8f31/BW6y5Yxou+oabfD0BJvuBd
 58AOvoG5Ow4v5gAKwAvgPkUaHBBo82XA4bPZ32I8firXPWVsQZmRCM7Ad6eKjVYNMcJP
 IckQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=MtCWA1T0xQbBhegHDKM+349gzPs0rzIjx+JTPgMFJbY=;
 fh=H+TldbW2axQkr6uYWghnIYIBrpPUnBf+NxQL4DmwQMs=;
 b=g8mmm+WDo9tlgE3t4AviH0LjZt3AP3OsNpAbMlVyVs6RjVgV4CbTVBDHIc6DDsfAC7
 4rl0uS07QLpwKo6jkvQIDqocLtIhN/APx2x2V/Nkwwq+5QldeZ1LW3smaQMQpSEPYE/N
 ykHcpSefeMXNetHInC8lUE2GGyhfP32dH4zHqymd7h3xXjSH5gYwPL/idfP+j2Ag91yQ
 tvRC4ENmU+utt/9afP+igmQBVRyE0aVgxlIeCau2pMZPFob3fs13uiHkzb7Ok5ddap8V
 Sge4VD35/IiAF4A9mw3UoAzrWveHdoRhl7d4JT0QIkYVcXbXicPB+mDRGc+dTwbYqoTi
 il7g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775750159; x=1776354959; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MtCWA1T0xQbBhegHDKM+349gzPs0rzIjx+JTPgMFJbY=;
 b=L+9d2ll1ku8UHVwWWrsGA8BgdLHDeBIitvql2d3qC9qcu3R4EzuhZ1GeHefUhcTEyd
 OcwkJOjhKeQb5ZBta9VyOctWwvbl6R7RxRK1B3yFG91DsGuzXylxi6N2PDmI6DcxqCoG
 4jadE7tWl70/eTuHhT/kuz2q0jTDpKjHcsO1/U8K4ay9UNCmCNmD2oJDIRBGrGYjllf9
 uThOT3YzzBRwZWWcEi90FUq8TCvOf7+yp0Fa+TIRvqPflqyMIRay4jPlurYBR/+HpElN
 XMg29z2EHOez+5V1uw+gPRS8I50y2SfeypeGc+Kq97oQl08jciSImaDGLb6qLqsN6l5c
 OoKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775750159; x=1776354959;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MtCWA1T0xQbBhegHDKM+349gzPs0rzIjx+JTPgMFJbY=;
 b=dGoziJU8LWeV3fja9hrcOgM07/G1sIyQ8LaLnaMxxtH2yGEgzEHFfND8v2hlKTdIaF
 Kw3iom5tisPYJ9wdKlLsASoYc0WiL+7BogGH2xiIZfAVI+0khWYC8aQ4+otLUqDnyZrQ
 DGswsfxij5HJ3e3uH3hoeN9ciU/68nABvedv7PIZ9ehXplRLtPPyhr+kwAGAfvwDijQ5
 zEl37NCGa1ltD1e/1/psZSOwcDZTqxTjuk95x1KvM0zXehc4v2/YF7QNc/CqPDNcfqx0
 fDVHKkVmhc0AnccgLbbhCGz5zvKJQcNKB7YaNtDJ3LuLnigKYYx0xClQbUPqmf76ksF1
 +8wQ==
X-Gm-Message-State: AOJu0YyZK2wCtBiF1nBmH44YifmdnAahOQvXmuoYEiBXKekLWk8pWhLh
 cniQYk9a43L1tGYT8p6MnMep6j1fkV3s3UO6iP8jRoVWjCYgeZpAxxQCxd4hOGBhkluZASdhNqw
 oZW1Tt8S71/8deub3mGpa2KrMk7neeLQup/oaOAJfXQ==
X-Gm-Gg: AeBDietClWq5xuhIKPSyVwZquPaPiFt5jXYVfiHHLrvTZWAPKZNJFCG27fiLROmXs42
 ADzbUAcX1WDEqwXbnP9oTYVh5yjGrSHp2nKX21iZa2rte7glV6WQxPUaNa8l2TyxToJjfXFrS2i
 3JjpF0uRqQ8CvreQ91pg2jHqXYXSAk/wZMalqQ/3mAVd+utQz9AieouDQ7MfzYMVFfFgMR6beXF
 /RkhXz+Yz6ZoD86GwKQ3p2V0C/VzVQuhBlTYC5ARGyO+bVr48km66OXgffqqEHT3ZZcEKn62dIw
 AhZ17RcjzfGHZf+wzmbBZ+GTIDg+coWhU+JDlhC9P24DITS7M8wChifEglokBEdoQv0=
X-Received: by 2002:a05:690e:d4b:b0:650:88ff:d73d with SMTP id
 956f58d0204a3-6518719f379mr3224885d50.16.1775750158750; Thu, 09 Apr 2026
 08:55:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260401143456.79843-1-philmd@linaro.org>
In-Reply-To: <20260401143456.79843-1-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 9 Apr 2026 16:55:46 +0100
X-Gm-Features: AQROBzCxCLHUW8TOGzGYfAPafHcKZQd36W7dBHN-zgV4NhGTMdpXAUbdirJIqQE
Message-ID: <CAFEAcA8yn9uAP4X=hh3Ch8JVhcO=byyTGZSLOWYU89iRUD5bAA@mail.gmail.com>
Subject: Re: [PATCH-for-11.1] target/arm: Replace target_ulong -> vaddr in
 guarded_page_br()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, Anton Johansson <anjo@rev.ng>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb131.google.com
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

On Wed, 1 Apr 2026 at 15:34, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org=
> wrote:
>
> Following commit 15500df3b3b ("target/arm/tcg/translate.h: replace
> target_ulong with vaddr") change, adapt guarded_page_br().
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
> I know this expands to uint64_t on Aarch64, but vaddr for $pc
> seems clearer, since this is the type used by callees, i.e.
> probe_access_full().
> ---
>  target/arm/tcg/helper-a64-defs.h | 2 +-
>  target/arm/tcg/helper-a64.c      | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)



Applied to target-arm.next for 11.1, thanks.

-- PMM

