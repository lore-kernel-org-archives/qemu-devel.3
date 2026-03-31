Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D14BF10F92E0
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 16:56:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7cNn-0001lj-35; Tue, 31 Mar 2026 12:56:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w7cNl-0001lM-Cg
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 12:56:01 -0400
Received: from mail-yx1-xb129.google.com ([2607:f8b0:4864:20::b129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w7cNj-0001oJ-Mo
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 12:56:01 -0400
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-64eaf8aa893so8099823d50.3
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2026 09:55:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774976158; cv=none;
 d=google.com; s=arc-20240605;
 b=J6UTGLgDH1mmBuYvIfEYGVqvL46o/UAeOIg7IgK0nZuaW+nr9z8Tqcqeydva99g2V5
 eCkzCvxRvktlSCEYrp/Af3CZbCoQHEef3BRJx7jHfr0WPqzPJ6EpmnHZk5V8GMsy36FD
 gK9ZDB76OF3FrqnuMLzB05VHkBslE6CdGMNRWo8AhGRmAI1OwROSLnx39zXbD682aWgl
 n4kw8gfCDdRxGnB4r4SJUmZ2RqeVYe9UZ79V/dxt8a5SCcY8PxjfvFKTjuARApWoiJRz
 5VMJRS9oCoL5dTSmDfuxg2HQeOAfBJ3tGP+vssEstm0X+Qbak/9iHXMcbXhdCXTf5aib
 lrxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=r30PW/vpTEB5JhBFy+HoE0iTIU2BVdLxLZWWG0cRwho=;
 fh=evrtiTOpvKWHw+YOJsogrRLGrJRLilGjxlOe6ADeHns=;
 b=ZpNO2i+7qHH0HKcpEFACBH5piRMoOg91eya3lVI7W2+YauIsS9gT1EcgI1/+5YuUu/
 6n7TTxjgFqLc0CQ/nvC1lJ9MYT4PhxtHC2NqdJOuJcFWYFiIobXGZvuvoJfIAneNBa0O
 BPZSAaT3r727p870J3NrSHKHioh4f8nKoe072aEQ7VF6aA7989mLFXxSNdGjUkRgFKmC
 25KprCygVNWNCI1HptNRCDX6d31MI+rQC9g1Y+HiaWlpXhBnPHDbjG+7av5dZWkfXm3k
 hSzxdE9gcT8uOhmsHx/Ez/VQiXwLPs0jKLLn4rKfP+EP7Vs9cxWTo847I//fzyuc+5Db
 ZmBg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774976158; x=1775580958; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=r30PW/vpTEB5JhBFy+HoE0iTIU2BVdLxLZWWG0cRwho=;
 b=US2+euA8pRxy6Rwqz0zB4RnKCIK9DkuBCWyKBVTmlWU1xeotQFUpvJQxhanpRfY6KW
 1e4PSfs/mUbs/U4glWAD20w+1nJ5guVjlDPLcR7/jMFaYb8lGw/TyXd+z1ZFTKjkplvT
 oHuZL7Fn4wH8e870+tBS7CGgjx1FjvIzipI850kcw8QAB70sMUqs4cpxWXKxPVeF70WE
 uvBOQB26/6VPaGFenSLCBgrROYya60uvof/jtb5Ex2hzFFH3QD169vUzoC7zA/ruQg0e
 VEtuyb/hBzkHWKWGjp2z7KeLdc0VTHg91mh6zYOF4HUl7R/RmwXgBjlIuSKG3CWX854j
 fRSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774976158; x=1775580958;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r30PW/vpTEB5JhBFy+HoE0iTIU2BVdLxLZWWG0cRwho=;
 b=TaDpAFvJYa7c7sNP9KDFMkNyuQKWmALZXVR1v7OFjpP3v8SFzJGO7cZw/pMlyiq8ME
 8fkvxM21DYIc1QM20chyQmA8wA9Na+B4lVlyipwKmsQNq7EtwlMpsXt16CPdEKcbByj6
 F8Xr25mfIiARdkvztd7WxjpXKUWgryeOuiPt2yQeg6sVn68azzSOBTDYM2rsMvFeDZzc
 gskm/waI1tAQbGYAWcY9WaOgzLWaeghiABVs7gQ2biRktNgez/NPPGm6aZlFIqF4ew7q
 a0cASd3g5ahfMgWnRnpeDMOpInwYGRC/6UiDma096UxdtbGd70Tys7NA663mZd9jDChD
 TSow==
X-Gm-Message-State: AOJu0YyFcT0BcVFMjhHdO3v/AaG9X4UKYFCrCb1n28Y8bUt1brLUZTtH
 89ynQIUlTPPn3jEcGL67WICINa/w6I8LYpPxZpNAbbb0DpQmZBmdp8aIkzk3o33YkFAHz4O4/dJ
 YiVkK8g/gaaFGjZAfQk3agtc8jtc1f7cv3vNWqe4Xln/B4VrqHrpIS5w=
X-Gm-Gg: ATEYQzwI0Udy3tVVnMB88JVtvNT0uXwHS3f0kmGU1SpYCkpa6Ygc3nYyKx4qLblX8RQ
 gh6hprppbjFxSCvzRdsgWH3JmzP5QhpnqD4LxxHoMBMzJvQiTVnyLpTxZqSZbQ0E92YY1LJSzD2
 yKRy1mJuVx5Ab716lw28gjjeeNnAwTEkCHvRJFn+to/VchLgrTXxgNhdrFUIhqY9JewhF0n1fE8
 VWKuOhI7EZ8DmyifCT5+9o5bDGB6PlW5oS3UBYgMStdxn+NadRfddJegX2xEzE7q5SapRtlOoRF
 aJu8ma5tjMUr0HuLN5X5BmDikgXxFniVxBA6aUz1gEAPlCoE/LyBHrmbfp/YRoj4zdccyXl92eh
 JxQ==
X-Received: by 2002:a53:e8c9:0:b0:64c:9f31:e33 with SMTP id
 956f58d0204a3-64ff7414876mr12474719d50.65.1774976158321; Tue, 31 Mar 2026
 09:55:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260330143123.1685142-1-peter.maydell@linaro.org>
In-Reply-To: <20260330143123.1685142-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 31 Mar 2026 17:55:44 +0100
X-Gm-Features: AQROBzDZk6nYvl4bGsmXlGMU3Un8cLKFydxeVEiqtY_nCzLIFXZeuW6f8NWfRHs
Message-ID: <CAFEAcA-mF1E6k8S+3wokNu+0FeHuvNw948M38od8VmaT9nXuQA@mail.gmail.com>
Subject: Re: [PATCH 0/2] linux-user: Fix incorrect sign-extension of guest
 addresses
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 Laurent Vivier <laurent@vivier.eu>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb129.google.com
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

On Mon, 30 Mar 2026 at 15:31, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> In commit 7804c84a ("include/user: Use vaddr in guest-host.h") we
> changed all the functions in guest-host.h that took or returned their
> guest address argument in type abi_ptr to instead use vaddr.
>
> This introduced regressions for the case of a 32-bit guest and an
> address above 2GB for the common situation where the address is a
> syscall argument stored in a variable of type 'abi_long'.  With
> abi_ptr (which will be an unsigned 32-bit type for 32-bit guests),
> the address is cast to unsigned 32-bit, and then zero-extended to
> 64-bits in g2h_untagged_vaddr().  With the switch to vaddr (which is
> always a 64-bit unsigned type), the guest address will instead be
> sign-extended to 64 bits, which gives the wrong answer.

I'm going to pick these up for a pullreq I'm putting together
for this and some other recent linux-user bug fixes, because
I think it's better to have the fix in rc2 than delayed into rc3.
I know this has only been on the list a day or so, but I think
tweaking it in rc3 if needed is better than definitely slipping it
into rc3.

thanks
-- PMM

