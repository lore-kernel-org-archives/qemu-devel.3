Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AFFDCD4F5E
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 08:14:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPyXh-0006Po-Dl; Thu, 21 May 2026 04:14:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wPyXg-0006PY-20
 for qemu-devel@nongnu.org; Thu, 21 May 2026 04:14:08 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wPyXe-0002K2-HL
 for qemu-devel@nongnu.org; Thu, 21 May 2026 04:14:07 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-44ce78ab5feso4906442f8f.0
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 01:14:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779351245; cv=none;
 d=google.com; s=arc-20240605;
 b=DhIW4wIMgXrum0ntTeSl//ocWLIwI+E0nlo1feQnQ33tFOknSoUxSzMftU+/Tqd/AZ
 9CfntDEw/CX7GMjP7fJA7EaOLaMaNCExkgy7Hzut0UneZ9orH/pOB6l9iiohfKwsB5Uw
 kX+7jBQDFhqRPuo7S0YWYpYGTjKAbDeDQCAsr2uK4RpjUjt89nDjSako/XTXP/DAci0i
 cfrJZcXBHeM8PXwwY1ODJ2oXXR/7COPMi+L4NUruJVhZ1o/OO929OJmXBYYBZi8kfmC3
 xqKiHPo/SUPwBbXj/XI29xa2Qf8dVW4u/RWKH+SbRkm7NHpRZFFFD8U7zabHFB2UVGP5
 spWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=p/TCRy35TvWV/lCDHNFSokU/PgzHXtZrUZsZ7z0Wzt0=;
 fh=6yoHKQ+J4IWbVW4TtorKqeEBQM5jf2p36zhlEdF+Ssw=;
 b=VR1Z1u8xl0Jpv+70vk2ksitfc1sGxCFPinM45JxrvzL/SDCtOg7Um2q5YOHeC2BRUU
 p+yH6hNUQCq1TC0+PYxOw9/bST26FlH1RWYFSvoQXme4CeIqPur3KEJ8EbwDpQiqthMS
 Syxx+FgUSgFa0p8LNa9RbmjZ7MxDb3UgNQ/ihnY4m4Pk79gF4jXHuSKL2/k2odeIArHS
 k7Ev7wGrS3Z9xuYW6OsfjpsgB5CLbvHaW2PXEy1j3ZeDz5KnsS2O9wfI9bnrOBJBpohO
 zwlLc7i23nuY1mSsqc4jx4JYUm00IwcfE6cgr0s8cqgSDVjSaW2wsiPwyPQJbFB0A0GC
 Pc6g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779351245; x=1779956045; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p/TCRy35TvWV/lCDHNFSokU/PgzHXtZrUZsZ7z0Wzt0=;
 b=sGNPq/lI/iTYWm16cQOd9BafJNUQdOK3S64mFJ6zgWx64YbuNx2aBdDG3otbOzF4CQ
 YVJVCTQLbRLPeDeL39lfqYbH65jyZcmIpPDftEgScsN85lE6lRGv9x/1ZIjOwctXFI9z
 NAjnptyMwxx3Xadt0iiD6fXm84SnNP2XRyYHHreH9p+gEQETZn5wZ+Ff0P7Ln4vWj2V0
 4IpU1HoFI02xlX5akVLhOUzzAX6Ej5M2U5cFdD/iJo7IPLCFQWbvIZYQFCnJTZX1/eWx
 yKNuBtPL/b7yEeRZ9i6RjqwBEx90Qz1AhLX8zJmBmMfqaVThI64QB1AhtbSPuQEijYql
 3VCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779351245; x=1779956045;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=p/TCRy35TvWV/lCDHNFSokU/PgzHXtZrUZsZ7z0Wzt0=;
 b=WlEXb7bn6M4DRuVofBfOUWnwLbSy8UePVijwgS7p4p05Bu8Ol9rlaWlpxC3n8Go8Lj
 1ZeFRVedsbDZw9qytVZ1HleR1X3eS6yiG018iCRi4xYAB8SmsFNyLWtXB0FmA4PXDBxl
 okVjZZryAzsuXnhSishyDz+aAZEu2NlE711F8esOo5QycHQi+0f7mfD3P1/hayVAf70i
 J837zzv1Le+1ctrZ7M+3hWpFpS4kzxXA6U9YPWrkNw13muoU8S7nmhvIiOLnefphi4rl
 0sTo73XzvoJmgF5u9pnePxc4uxfE9Fv0LjGy3sk7sleEQMicUO67veeUQNMuleVNPcwj
 RxUg==
X-Gm-Message-State: AOJu0Yz6rIRQQ4gPLixdW/BNTd7EkrLHtcq+souiWYTQA9B8QatZDYBm
 KA24vjGJhzHKgX6jshjB6B3Yne/6xKPDrbxhskquKE4IoZJcaJnIzDWOjsresGRKf/LZcX6Y/Ri
 KHBQRPYkHZhvYu+ECgnt2Sz/oogZUCSBeBkfUw6B5xjEtBrL8svK0Twg=
X-Gm-Gg: Acq92OFEspgQkTHWKNaunbcjSy8IpwE+JaH6OgDCc4myTFy4hZkpq43kPi/yEVSSbqo
 6cgYr+CxVfH8KLXfkdKCg06hxAqkcw7aW4NeFAuvpDvPjqlmo7dmwdRK9G4HY776gvsS7Sioqep
 z+5hLlVr7dNIEFCKZs5FyMLkXub0gd8pMOUcm3bmFGnbnCJDns0f3j1tgVnIdKRLv2M2ep83iCP
 hm/c3b+u8igDpSgxyP+Rka6A/5c7fLWIBFECLXIehDNZldxVcjS/71IWrbFg9HFhSlPbF+0lPRg
 cF0hOT+3gn+m5oxmMJjG+wsm0DsMMlum7PZsiftboH8aZYQiNg==
X-Received: by 2002:a5d:6f14:0:b0:43d:69ff:6898 with SMTP id
 ffacd0b85a97d-45ea35aeacamr2638259f8f.9.1779351244627; Thu, 21 May 2026
 01:14:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260521080511.999266-1-armbru@redhat.com>
 <20260521080511.999266-40-armbru@redhat.com>
In-Reply-To: <20260521080511.999266-40-armbru@redhat.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Thu, 21 May 2026 11:13:38 +0300
X-Gm-Features: AVHnY4J2Bm7-2MflEQ0xRHmd-fEzE6g3jrUg-ZCUqMUo8kObE3bGZvXIYAJ_MfI
Message-ID: <CAAjaMXZsUD7Dbe6Jbte=avD4-1o3vrt6Q4GFbTSULO-S4wRPyw@mail.gmail.com>
Subject: Re: [PATCH 39/39] MAINTAINERS: Fix F: in "Rust build system
 integration"
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, 
 pierrick.bouvier@oss.qualcomm.com, qemu-rust@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x431.google.com
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

On Thu, May 21, 2026 at 11:05=E2=80=AFAM Markus Armbruster <armbru@redhat.c=
om> wrote:
>
> We neglected to update MAINTAINERS when we moved rust/wrapper.h, and
> again when we split it up.  Update it now.
>
> Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> Cc: qemu-rust@nongnu.org
> Fixes: 1ae4ca0463 (rust: move rust.bindgen to qemu-api crate, 2025-06-13)
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

Thanks,

>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b7fe4fa58a..37bc1bab06 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4629,7 +4629,7 @@ F: scripts/rust/
>  F: rust/.gitignore
>  F: rust/Kconfig
>  F: rust/meson.build
> -F: rust/wrapper.h
> +F: rust/bindings/*/wrapper.h
>
>  Miscellaneous
>  -------------
> --
> 2.54.0
>

