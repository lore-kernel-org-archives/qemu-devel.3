Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E276CA5FD6
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 11:34:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCbWG-0002Is-4O; Fri, 02 Oct 2026 07:33:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xCbWE-0002Id-0T
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 07:33:38 -0400
Received: from mail-wr2-x0f.google.com ([2a00:1450:4864:30::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xCbWC-0004at-9B
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 07:33:37 -0400
Received: by mail-wr2-x0f.google.com with SMTP id
 ffacd0b85a97d-48b042e00f7so1502173f8f.0
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2026 04:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790940814; x=1791545614; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=8o8KMrBzucBjcBZoC5eWUqLut/W6D1yWARzwm00sd3I=;
 b=Froiv4LK+388xnV/mcYDLyNHd4P+dxx545tBjbrYuhoDx9RchR8I03JGw3zkFDqZE3
 vOdxdvn4I3/CNQHX0pIoB7Noqa7KrmElaiJpksdx5zPpXCa0BrJPZg/xPm3HiixfRels
 C6HZHxsLKTuGiVThMYkYc5jo/nTvoeHwYMZeIQZ6PUmaSCzIcBh6XqV7xz4hycxGHBIJ
 p7lvVg55PAnFFGYCQ6h1tljwdA1IRbSCaJa39vjYymZox9G/91h3ul9XQyIPqKzP7GRd
 /drcMSNP1PGEYoPjB+3vY+Ek28MhcxklTkgsIrql1WM3/w8C1ljWnvPK/RZknguee/Ss
 Uouw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790940814; x=1791545614;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=8o8KMrBzucBjcBZoC5eWUqLut/W6D1yWARzwm00sd3I=;
 b=X+jVJYfkLjss7rxh7M+3Qof0HHTgu0TEHEhpxMEScjFe8S+bsjiGiUGqMFoEwTCuon
 w4l0F/JgjUmKPOTMB67T102AUJgtXetXOhy9+M98yMHDHPivhVr5tN17/WadWFhvLdLB
 ZS9w8283R2N2dOefTY1A+yDmLxOn24t2PxiAlAL1P9mON4c/48aTBibBWKO7rjKJMPcG
 TjIfle+ZNGu9vFjUy4mP4NKOxLGucZ3qLzVIMls8MqLwBmO3nYkjWAhxb3P1PgXa+cFU
 DRHqz92APSWAf6M0Q8mz6a31VVIiEr7c6c2zHO/H+Sfe3+rw0ujS7KbFIKRTJNRpz3Ev
 dApw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxYtIqtwvkqX6XWhKm9m66htEhcFRgcA1Cwd+vfmfbT3pLUVxL3ecZx+6etGWrJTWoWLAwUP24fVUmE@nongnu.org
X-Gm-Message-State: AFq9FYLz/3q5vx7U0ILpAtnmEGXt6TLx6x0TLhAtERISXllQn6PJPDTV
 SQy2+CBV2sMjN9hACv3AH2Fxm8tGUWM/G1lINCGF4jYQ5U1WGZUG8aKuqfxAv3ejmcI=
X-Gm-Gg: AYBFou3892fQ7shRAVHVehQZ4M9lt2t5S/RVQc6rf0gHLncdFmacE/jkbHz+1snmJ5q
 l/Z3UdBJsrSBqV4eywYjO+FXPoljt2nW+bWMeOQ8H4D3SXrhd+3HDJCQeLcjwS/w08uhFnfemlp
 MT0gqDn89EzAQfwqNkInsw50gKYM1tQbDp4mZ4dWQ8wJ5/HijeCHcQ9TPlRqoeeoqqP/RS31xg5
 a8eK5e5+oCZfLJ2bnT4wN1mrOOUo5ktuAELmz8//w1/8xY9etTrAKRuSg1WYv7wreA6bcvZ4vHC
 Oka/p+1cCY9DhohhklrR9ICQnzMgXe+U9kx0KQZqDOnfVy+b7E1YxfJLV6PglTXcR4ABrepJIs4
 4kCfiL7q1eder2Ptxdg71OfxRDFfOd1T0MUQQ2HNHHa1xETWUQZPtcuY1UEh2ygQh4kzkQ6Yali
 DFMFD8LnlvvZos5HyFR9eoWuAOJz1BhOWLU010sSuMUURDu7YMwmhGygzrDiRIXCU716a4WmgBM
 yzS6gOONSsl3aOELGsq2eg4VVQLXQj7jKckh1QnaQ==
X-Received: by 2002:a05:6000:1a8b:b0:48a:f929:e140 with SMTP id
 ffacd0b85a97d-48b1270ff59mr4643011f8f.10.1790940814383; 
 Fri, 02 Oct 2026 04:33:34 -0700 (PDT)
Received: from [10.9.5.233] (vpn-konference.ms.mff.cuni.cz. [195.113.20.101])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b38104f89sm5628697f8f.30.2026.10.02.04.33.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Oct 2026 04:33:33 -0700 (PDT)
Message-ID: <c0261cb3-6040-496b-b822-11a5961b2015@linaro.org>
Date: Fri, 2 Oct 2026 13:33:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 000/105] QAPI patches for 2026-09-30
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20260930103910.3934848-1-armbru@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260930103910.3934848-1-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:30::f;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr2-x0f.google.com
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

On 9/30/26 12:37, Markus Armbruster wrote:
> The following changes since commit 81ce3a87737aa50716c42db8886082d12783e0a1:
> 
>    Merge tag 'hw-misc-20260927' ofhttps://github.com/philmd/qemu into staging (2026-09-27 02:02:29 -0700)
> 
> are available in the Git repository at:
> 
>    https://repo.or.cz/qemu/armbru.git tags/pull-qapi-2026-09-30
> 
> for you to fetch changes up to 55ee0bd2f50f7ad52840ec8942fc128a3822f917:
> 
>    qapi: split intro sections for inlinable structs (2026-09-30 07:51:00 +0200)
> 
> ----------------------------------------------------------------
> QAPI patches for 2026-09-30

Applied, thanks.

r~

