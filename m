Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0571108B8E9
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 10:13:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3WrQ-0004Bf-TW; Fri, 20 Mar 2026 06:13:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w3WrP-0004BW-7N
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 06:13:43 -0400
Received: from mail-yx1-xb12e.google.com ([2607:f8b0:4864:20::b12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w3WrN-0004y7-O1
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 06:13:42 -0400
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-64acd19e1dfso1619283d50.0
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2026 03:13:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774001621; cv=none;
 d=google.com; s=arc-20240605;
 b=WNXEqTSoWxdcUmXtS5m3GhrqyNpn6lOu+zAwUPqZqb9WaAEHxL3dw/VAVTcFRKR+EV
 8BzuJmjrrZyiay3788UWhohiwQvgRy04VJZGOPrdkV5FevRrhullp9seUeqC8nlxZhji
 AjCiOls28Ka1bU9ttnmxKX+lf47KtISYj77tYz6o+MQz7WNU5plqHHJ31aIpv5GGUmjW
 wBWWHSrNAWALb6hb3Nib9zfoJ7W9y1H4HWN0weHKtLuamZ1kH24Ymyk/Gjw/2q8Glx7L
 wbP7yfI7JEHwBihVfTCY33vB1mmLjO/qHdveTLl+OIdcFpSlYH8GT+8ZM+IZQ+h/w+33
 mLyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=RKc6H6eLstuOYpUk6bvUHyN2AoUUhlx9rQG3SS+jUM0=;
 fh=C6nSCE5LKC5RuqcGtrq9dsN9XQcZIV+WhX4ZNDyo0OM=;
 b=VqvO68qNHKdJYo6cC42ETTAdnFEpvpnjdyB0r7VBuxoWq3Z7oQdgx0wLhPs2vJu2kg
 L8fdNdhCINkWVPueeGwFGS9ZCpYDGQLhW0Hvj7tGTm3h3NCT0ddL8MumxkYJ0DI2xaAJ
 2Coy06xXcIDd1n9r8MhAluq7vEYeR8vsBgVPr3DSZrI/vTIDl38x+60GXg3mnxrWkBeZ
 7QKs76yn0n1T6qzk1sY9pn5yMa2XtsDPBq3qwCUtxNaCNXn2DWW0zi9m+d254erI5235
 m3Fw9Rq86zzEdJWd7djLLfazoF2QSCumF4KAhNW1Tn6S5bOjgWLcPInBnGw5ekNF9lro
 MXkw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774001621; x=1774606421; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RKc6H6eLstuOYpUk6bvUHyN2AoUUhlx9rQG3SS+jUM0=;
 b=U0Eg2MTQB6Lf9rickgxPdBCl1i6Bjjcd0/7ImqAV2FlzF7XgPkNLnYAoNYNstBz119
 vbnD4NASFwxmFJasuKRhMEbK12yIGV6g7rDbhMIEuSiT/gJH/ohtNSBIo9p0p32yy3WF
 yTrc/pqUXwDP1xN42Yv4+3rQIE2Sh+XPulXwOa7um61BXQSDM6Z4DR55zLI9ViKWqRrQ
 ZGrqk8xCmGCpIIGYRzFzchMRmyHswtEZMNWM+jjBunanF198QfK2TaZqz3Ahq6Wxv8HY
 M6bel4aSNtA4hC9iG2TOJN+dJiQFQp7VNM/7DJstXTl+1C/5TaeWlZmAaV6L3oUwwlB2
 iXcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774001621; x=1774606421;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RKc6H6eLstuOYpUk6bvUHyN2AoUUhlx9rQG3SS+jUM0=;
 b=NBKgb6D03lPrOaTTSlFibC+nVciltmW7MAFPGtv1Gq8KJyH9+zUjpEEdQ5RDAW4HVg
 qvPLHBU5c9ZQkBnU+6nNs9FeX5rvYJyBmEis9uD4JseTs1KFvkN+w+cu3JvpTsJMRFfX
 SY843PmEc8Lp/JstZ5zgp+ZsnNzfyNjJsZibT6DrUN9iQqWumvroL+BPOGHAMHyaiUih
 WKJkjQiuh6+HmjxGnonP9tFeHJKMMZ3X87qYW5l5KFd18/a2c+za8eiffTjBfOCw2oq8
 4XywAtpntrrO7OLXtp//fetryzf0I2+o4hT6jS0K43iaKTwWttdv6e+aSH3PZHRu6GGd
 iPFg==
X-Gm-Message-State: AOJu0YxjkV/hfAWeU665O/n1v8qzDWdUCEvNRcM6F7JJg7YtIE1giB4T
 aaDN73oSTY2aHgMt+ureAnJ7KeaXXxn5+AzcTZjLH8gSnk6pt/3N8BWTBptmGquSG1dbUe5v39z
 fijovy6A4gagSDMNerNccmh5rD0JQdz8+OOiLN0X6hfTmWaFt1XyX
X-Gm-Gg: ATEYQzynpWVrykQGVEmATOZiyx92gIG1XXJKtZykN2HBi3mnWh9LDzUBDIjp4fqywU2
 BDtzGM0QxErvMcGZwDmaYQRMIyIUvx+z9TyEnO71Mk+6GBUQVx8/ZeNFyUrnoncLlU3vRdBi+r4
 dlLyB5A8Wkcc0cbMWt22zHo1DeCdxbqy1TZuDAl0zaI8mSOLQZu6/0IcQ0k6NL5H8Qu0JjstlNK
 jR30PmBz34LOW9VyrBOgcbRjsu9TYwhkmhPPMJb1ieQbAF04E88DWOUhIFHEzh1m+WnYAFDy7Gl
 t/nAhok0tcxhf7c11GPGC8JB/Twp0DdtLmBOW4IzP906ni/DaQFqcKr3B33ZjJMrcUk=
X-Received: by 2002:a53:ac8a:0:b0:64e:b09f:e859 with SMTP id
 956f58d0204a3-64eb09fe966mr790585d50.7.1774001620566; Fri, 20 Mar 2026
 03:13:40 -0700 (PDT)
MIME-Version: 1.0
References: <20260317053827.25051-1-shyliuli@aosc.io>
In-Reply-To: <20260317053827.25051-1-shyliuli@aosc.io>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 20 Mar 2026 10:13:28 +0000
X-Gm-Features: AaiRm53hopoAzfr5ypzBrJj_0PNKC-8F8kmZVk9-B3Z1VAadBdf-59AnQcwdSdc
Message-ID: <CAFEAcA8OHsqAfbU-C90VdtVineOHhKKZYg+7H1dTcqNeyKcGOQ@mail.gmail.com>
Subject: Re: [PATCH] linux-user: Make openat2() use -L for absolute paths
To: Sun Haoyu <shyliuli@aosc.io>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12e.google.com
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

On Tue, 17 Mar 2026 at 05:38, Sun Haoyu <shyliuli@aosc.io> wrote:
>
> openat2() ignored the -L prefix and opened host files directly.
> For example, openat2("/tmp/file") opened /tmp/file on the host, not
> QEMU_LD_PREFIX/tmp/file like openat() does.
>
> Fix this by using path() to rewrite absolute paths. Skip this
> when RESOLVE_BENEATH or RESOLVE_IN_ROOT is set:
> - RESOLVE_BENEATH rejects absolute paths anyway
> - RESOLVE_IN_ROOT resolves relative to dirfd
>
> Now openat() and openat2() work in the same way.
>
> Link: https://gitlab.com/qemu-project/qemu/-/work_items/3341
>
> Signed-off-by: Sun Haoyu <shyliuli@aosc.io>
> ---
>  linux-user/syscall.c      | 11 ++++++++++-
>  linux-user/syscall_defs.h |  7 ++++++-
>  2 files changed, 16 insertions(+), 2 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

