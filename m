Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F62CFF8875
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 12:56:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wI4SH-0006Al-N2; Wed, 29 Apr 2026 08:55:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wI4SF-00069n-Fw
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 08:55:51 -0400
Received: from mail-yx1-xb12a.google.com ([2607:f8b0:4864:20::b12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wI4SD-0005VA-PR
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 08:55:51 -0400
Received: by mail-yx1-xb12a.google.com with SMTP id
 956f58d0204a3-651b4d09141so1386803d50.1
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 05:55:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777467348; cv=none;
 d=google.com; s=arc-20240605;
 b=KSG8g+o1xIJGdof+a70DvezcNV8azKapIqRH9OmPFjwCqivG4ksXA3BMawwkIMccv8
 oE0aNFGQw5Oi8KJnLthTlB6fhxTpoqnQ+7yrXbsFx/IwIEKqKBYdDxz/FVOMMEuQiGKS
 BcEQFfzt8uBQCpQ1B8j3oGVWMEMvJyZli+vXa2273UBe3npLyW7Cr9TB+W3EvCCam98P
 +u2A+bWxcGSpIwYcPgKywb9vrnf4LKCWKyXEN56aAGoXd2/vBYNa3XWcFS0PIYz+eiQX
 X/WceVoWzSgZQRfODSiQ+YeGjL4F19MIqnC0Ba9SNiyMvkar8bpNLlk7GkgBnJlf5/l9
 OEUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=fkMCORstw1q/GpjWOTwzVTaXdmkD/VRw81ImyyOInAk=;
 fh=Mz2y12wzJJW1Rmbmc0KL1Q2SaGBmA6oT2H9N5PtSfoA=;
 b=H5KsZ/Yx+Oc7E25Oipx42ykXbxen7hQDZotFS9/Q5oaH43hjLOj1mCbrjmLfl+bX4s
 zjkC92KunfZVTYp31KHDXg9QABJN4B1feRH4/f2+EE9OFBGZTmBPiKGxw/yjBkkulWE6
 N3YAQCDPadEGya1caTRBWjWvekmCdhCj1abMoOyfbhZV1IR4F591xY4LgTe6JxJgvigE
 K1GmmxHeBv787RK/lMcjXUpd8QzWoLhzNeA/8Uzy0puMGlvnrnN2y9n8aJQEb2Tub+3u
 hqDUlZIOlUgfqwWJKgYgUodfnvYCz/YPVH+9NS2ZTB2ust/zPinx6EZ18dOLcD2x/7G1
 IQPw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777467348; x=1778072148; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fkMCORstw1q/GpjWOTwzVTaXdmkD/VRw81ImyyOInAk=;
 b=wHlL5Y5pG4VOJRB7MG0hlevPWkQCFziQLudEZHfvvu6wC0VRNezM9ELtwOSHn8+1Wm
 LxklsKUpJvAmPsNTWeOMEieGk/EU3RVNWt4WKu0QyA+0BHoONBz/MNwiZ6Ivt4Ena4Em
 aKYk02bk7NqJgsW79utk1rxRbhZ6npM60FBxjQea9a9scau1iTWrMFpwv8UgsQk57YC5
 gcKwgv+kg0X1hLI3nrEMvkvc8CkvWs88oVETdk7HD999N3XbjPvmYljgarM2Ga2+qn4l
 xR3evBIeKTNfWEG9tXY30I2BIhLxZa9fQM8j6EFSa6QhBoEzsf5Blt8Q+m09UUfCZoLz
 91UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777467348; x=1778072148;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fkMCORstw1q/GpjWOTwzVTaXdmkD/VRw81ImyyOInAk=;
 b=diLrK3/XdV7JP4j83C8H7XOPBLUNc9+0F4Yd9nchq8WAwj/jIa4boMpSC4a4CtKUKf
 N9tWRq81KcJgdzUQtpcboJQeMKRfTvZsOEctaiL9B3I2Y6Fs7HmzPQzJ3B/EVEfW+GAr
 k5nVPr+5LOMM+M/wgiOC1fCTicvAkoYlxvDjLDFZf97LP28SeyWMpsU56jqqZZ+DLxMa
 4obhMlucQ0cO78uV0VpB09pvQU8Nierhboxr+VNOY4O2dwYwJ6HzZVmZsMeOAniWYfmI
 Z5s9i91nor0jjs5Hf5YvQGWmHZ+1/5DP+SxeRZpO8Qgrhute2DdOTbbBPq8TTKyFObBY
 IRPw==
X-Gm-Message-State: AOJu0Yx48U4RE3GBVzDz3gLniVoHV7D6LbjI1rTAG8FMh85xQrk0xYom
 Y37cNieIPyTHe+1MRQrX6u4eCJSCAPHzX2ru3At7Mut8JcmZg8oE2WkIts3CcoJ/Z8gQ7VRNSCq
 4rmWSzzw284PzOSCL7XDysNmFA6n5mdHlv5qjn/4ZPQ==
X-Gm-Gg: AeBDiet49Nutk6tYzcZL8jWAfPiMoGc+MfsKxVQuP7at0PRlx13CXUSRDJi1c02srOR
 3uj37Lkc3Nup/kAZe9coIgSrGeOQrhlp8E7DAUj8l8bHSwYzSgBjukI9KJJ/1fVhh6HbUA98itT
 iqdDOAwK/hTxKSoSOdQnwavpZuYPIQuN0sb+WLWcT3v3uwfr7QXx2OpvWbgUfIwNwNleUVO2T4q
 TvZFEhHU/3pj0xjVyP8By4oiDEFoyjBcR99qtAUg9XIrg+Le7iONUQUfX36dkdyLvNFOWHECFEO
 0Sz0IEJvBPJZnNvF0Cv/4RZTZcOHi+HYExGjMyZuP4QH3X3BFA1lSgD1Qy4JzDu/yliRYhdUVUN
 /rg==
X-Received: by 2002:a05:690e:4091:b0:657:a0f4:ac7b with SMTP id
 956f58d0204a3-65bff4263d9mr2028601d50.34.1777467347695; Wed, 29 Apr 2026
 05:55:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260429122845.2119072-1-physicalmtea@gmail.com>
In-Reply-To: <20260429122845.2119072-1-physicalmtea@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 29 Apr 2026 13:55:34 +0100
X-Gm-Features: AVHnY4KaeB9L-D9V76cFF0OT_CHNlLnwjglyxnEfzHvm20Q7xDJxEAcTxBwiNsw
Message-ID: <CAFEAcA_DnrvSCVY3f2q=3OnXt0+708BcwSJ=KhMn1t3sbbXQbg@mail.gmail.com>
Subject: Re: [PATCH] hw/cxl: bound remaining Set Feature writes
To: Jia Jia <physicalmtea@gmail.com>
Cc: qemu-devel@nongnu.org, jonathan.cameron@huawei.com, fan.ni@samsung.com, 
 farosas@suse.de, lvivier@redhat.com, pbonzini@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12a.google.com
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

On Wed, 29 Apr 2026 at 13:46, Jia Jia <physicalmtea@gmail.com> wrote:
>
> Commit c1c4d6b38b13 added offset + length checks for the
> patrol_scrub and ecs Set Feature branches, but the remaining
> branches still copy mailbox payload data into fixed-size
> write-attribute objects without the same validation.
>
> A full mailbox payload can still reach rank_sparing and overrun
> CXLMemSparingWriteAttrs on current master. With an ASan build
> this aborts the host process with:
>
>   ERROR: AddressSanitizer: heap-buffer-overflow
>   WRITE of size 2016
>       #0 __interceptor_memcpy
>       #1 cmd_features_set_feature ../hw/cxl/cxl-mailbox-utils.c:1908
>       #2 cxl_process_cci_message ../hw/cxl/cxl-mailbox-utils.c:4622
>       #3 mailbox_reg_write ../hw/cxl/cxl-device-utils.c:209
>
> Apply the same offset + length validation to soft_ppr,
> hard_ppr, cacheline_sparing, row_sparing, bank_sparing, and
> rank_sparing so oversized requests fail with
> CXL_MBOX_INVALID_PAYLOAD_LENGTH instead of overflowing the
> write-attribute buffers.
>
> Add a qtest covering the rank_sparing path.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3458
> Signed-off-by: Jia Jia <physicalmtea@gmail.com>

I don't think we should mix refactoring with this bug fix,
but I do notice there's a lot of very repetitive looking
code in this function, which is why the patch has to add a
length check in six different places, and any new feature
type will have to add another one. maybe there's a way to make
it less awkwardly repetitive...

thanks
-- PMM

