Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64982CC6B38
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 15:57:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHkJS-0007Tz-Ck; Fri, 16 Oct 2026 11:57:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xHkJP-0007Ti-6N
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 11:57:40 -0400
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xHkJN-0008UY-JG
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 11:57:38 -0400
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-8ac4806e210so786777b3.1
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 08:57:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792166256; cv=none;
 d=google.com; s=arc-20260327;
 b=NUfW3oI52k1h6OhZn66cxr6j2ac30N0Jv36XiluPZzYi7p/bkNwOY5HTJLpef95TBe
 FRVrvKtbC8jrrplZ/jyaOdXRTBQQNnKsppZodO7OaY9o+unEtcBfgjKkHSCIdLZM5c1N
 qSK1jRqOOwvpFVAHM9xS4lQbd1fwbKcK1sls/Bbl7IKWsERdntmJv+DrTF9bVN85CByB
 SE3JfR7pP8Pw9RqfzqHsWlHW/L26YBiGgush8h3FnxcXs28cjbZATgkD03A6Y7w3C7O8
 z0hLEbftp/FxFf9ewYFeTYDmJv9jO+zCiq6NTl72p/Uo3G8uMuPVawiK2bQtlbeiGm5W
 QuSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ijQiaZDakXdT2nqzYp4RwRt0IgGN4obLqR6a+at83Q0=;
 fh=Y8yZPeDkTzAf42drgt3qLTKNBItAnTTfCeqbzUAFe9o=;
 b=XiVUYWQjb8v/EXdPFaSy9DufJMXdkYPbUe/qGMDIxa6JG3mKu/Nw88Lmd/aZ4gGZy4
 v3q5PtE03OxPNsFFPMS3G4A46uJC18cLVALPGIPBasqfR/glw9RnBg92npOyrtyF1RA+
 jaCIRMl2gx/9M5xOnt9nW50ouUjy87YCe9MmsTfGhAd3f+hJS6PO8kKvAZ2pxx+yDnGq
 BLdERh/VsQpaXnZUyRXawcGsVhBvit4jiNXiXgG4TAKnWOdva/JcKlVED0SjHdCKSWN2
 WjVZmdWKp7GkDdL93+kngHJBMTAzwswlNHBJgU4qxz+PpuEnJ7Qy7CpbPScrtSy1zfaN
 irew==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792166256; x=1792771056; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ijQiaZDakXdT2nqzYp4RwRt0IgGN4obLqR6a+at83Q0=;
 b=k3K1PaYfppIMZkImgm5O8mnT4ZcjZ/arU/oYYPIjiH1zugFZ01i9KShG/Y0L/Q3lCk
 2iPZ67SzbBtygoXNhkcKS97wgADd1e0BE6Ue7j7adFmR2RgRCvgCf0eLJ/oQeWLJmLoN
 krQP+IdKFl2eE31eFW8aXAnjeqatxIv8fMwjKSu1GR3H4+bJ5drMva+o1dLJr1Y48wcJ
 7MbdFZu4Au6WW7xW/OR8Mu/iXxFf+g+8nQ/j0CG903DsUrU2pJPIKQ9jmyzfFdI0GG2/
 HQrdNCuav+XBD85su8D3LLP/jCpE72o294l/xkzvlNqPx4eBZqyymzLLBNwVuGto46VM
 swcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792166256; x=1792771056;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ijQiaZDakXdT2nqzYp4RwRt0IgGN4obLqR6a+at83Q0=;
 b=mJpan0SSY1rdOk6OeZXUg3HGxi9WzFwxnGtiMeUcGbX2qaY0afx/XmI2Ok16AxjcZg
 TWSa74zx7lwdgFAxyvPyfJuGopFXsUQgKunXbt8/uHyKJIzdTpq+y+ij6pU86iIJuT9l
 v5SGJiUMN1F+mmD4Dff035F9I9CC5KjWpWFdYVD3W7mJo93qLCoTXFTUnxdIVXD6Ykqq
 6RWmj4HMTrKErFP4dcDHXpYVLlQHJ6quvarqGtLF8xOmg6xY32vcbChptU3AkcUH6LTj
 0Jdu962pYJ80ELrB/IjBwBUpAHB9SxTHw9QYQSdinPRrNG0HOPhm+4nw7x9LgnlCY49V
 c6qQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByYFI8WKARogs//4GQutegjvBLCFtUZz8OhBeuIoWf3jJmX/GVsCpyZIuOcrLKcNOIevl85hBZG5XUC@nongnu.org
X-Gm-Message-State: AFq9FYLab+rPx0rtGo7DRvRU5TKkEAcoLWvyzcloKl7WULRuEV6/W+sl
 pp4xEEDdSITdbacVvgyRkLnSCGVZl9OGkggL3dDNChOJi4SNkWM7BtFFZMy/RXx9Jfs+7XSlXWf
 Fawv5EgRMn2fOQEqe+7rfa8nx1OxTb3ju8DjP/eITrWphWTzsMVaFFsY=
X-Gm-Gg: AYBFou0it3QxfuNK9LCuHFK/KvZPsn5a2gC3rDqxEIsqvgcbhMbU88ru7BbEXMfxnUC
 XJG8zGtV+GHOXcHkyZgy2+dkGkLWnYL2jO6qQdTLj4hF5lK6r+yQKBLBZip6SFMtJYwTthEtL5A
 O4r8+PSUC5aJizA1SxuvGpUtJkF9Gq0GZOehiRwsgfIRlbS0VDqv0kIjDyc5/iXv7xw4rFIGNVs
 NCQGipW5h3nbCRR07WvMqO0PiXC0DO2UNKWygasToWfTisL519om3TdPKf/XDxXS2nTmp3Z95W2
 CQz0IHAXIiKcilOw3BJ/iKXLXeW4RM+eWRXPbUUc9wHQaIpBzxnIfHv+GWoVULqBuTP9EPW2Vk7
 5yc9KITJtJ71uaSB26icYZaVb0NzElCscUHYJWkY=
X-Received: by 2002:a05:690c:4:b0:8b0:e238:2719 with SMTP id
 00721157ae682-8b0f2173795mr1870627b3.31.1792166256124; Fri, 16 Oct 2026
 08:57:36 -0700 (PDT)
MIME-Version: 1.0
References: <20261016142031.1204281-1-mark.caveayland@nutanix.com>
 <20261016142031.1204281-10-mark.caveayland@nutanix.com>
In-Reply-To: <20261016142031.1204281-10-mark.caveayland@nutanix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 16 Oct 2026 16:57:23 +0100
X-Gm-Features: AclHuK8uTdNG5Nsg_B8uIt7lUn78Aqvgarp82YPLfA_9V-E9zJtGNCs06m_Br8g
Message-ID: <CAFEAcA_=JJcOq-DtkuMOurB2cD9tfzfn4t5LR1JZnXNBJpP11g@mail.gmail.com>
Subject: Re: [PATCH v2 09/27] kvm/i8259.c: introduce TYPE_KVM_I8259 device
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com, 
 sstabellini@kernel.org, anthony@xenproject.org, edgar.iglesias@gmail.com, 
 qemu-devel@nongnu.org, xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1133.google.com
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

On Fri, 16 Oct 2026 at 15:23, Mark Cave-Ayland
<mark.caveayland@nutanix.com> wrote:
>
> This device represents a single KVM 8259 PIC and its associated class and
> ensures that we can safely embed the device within a container device.
>
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> ---
>  hw/i386/kvm/i8259.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

