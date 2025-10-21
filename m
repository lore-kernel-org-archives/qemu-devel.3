Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB43BCCD1A7
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 18:18:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBGvb-00049x-GQ; Tue, 21 Oct 2025 14:17:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBGvY-00049p-O2
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 14:17:44 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBGvW-0001FE-G4
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 14:17:44 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3ed20bdfdffso5451281f8f.2
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 11:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761070659; x=1761675459; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3By8Kfq8PqUAkjy9XCGQQ4sbeJUGg88Lrj9uzfNivJA=;
 b=Tykjiq+faTCnF1dRLq1d81TMWBPa3QkSCK+6sp2jwfs2hZOZFjOeSSVWIuQVjuyndQ
 NN9yt+HTggLSPZk73UoDDKo5aNtKPv+MxEOe9709oB2A+wTxryi81tm+H+5pLsrblsZF
 ae1FdOLItje6M6u/FOOlqeC7cbETv9MQKNSV+nYodPb1ZFMUz2fckJqyeWIwJREXMLO/
 x4Tcv7M9vrq/oTMGVm+AlgYe+//LlRaY0CN9EbL9ZS6HOqj9/9KrbZTEhJMmYoclQU9s
 LA/6wyoluXT8BGlhcgjwRx2xbKc+o8fbTqAaLtnl0GsYJt2QotfLN8s7hym3bNcRMS8O
 Gdzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761070659; x=1761675459;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3By8Kfq8PqUAkjy9XCGQQ4sbeJUGg88Lrj9uzfNivJA=;
 b=SV23VsUx+l8iX7VDalM2bSG5tUAutsM5bmjmr8kO+Ya3Hl5xgCxEhgE62L6bDQZh9c
 hloRBE4Jeglh4cgWxYt+HnFIpePwT3Nd73VzaeHy1N6GZaV/xq+OaB5bP8adRgeZig+a
 W3q/sco1hjUW+HCR0q5OXjJQpWmeQbzS7QL35Bok2bK0jqzLCNcHuM2oKcArferfPFQz
 LC8j8kv2HreVuj8fRVMApu4b4QoqnVQJKK3oTWwvrF2I+XHwdy8T035M0N969+qQaOZf
 fR5npvPQ370K7ASvUIES0e9DTp8n/B9GZo7SLo6Regw9HA8FXaEd/IWaHYiye2ZqOMge
 hzig==
X-Forwarded-Encrypted: i=1;
 AJvYcCXAjoO1SWUrg8bJPbvMtO0RhucP1o4E04ZOPa5KSkHI7XOuQsnqB358rw1mj9OCHSm8PAbPwYv0yDbj@nongnu.org
X-Gm-Message-State: AOJu0YxZnCfPFlDSDqbE6PL3KsItJJ8sd0ZDF/YIbsQHW0VTLSafh4p3
 Dd87f0MFn/PadOEzu+IpmC5MC8uVpMf1lmQK1ZvyxprSOr2UNcgnB/M97XYKlGd0HoM=
X-Gm-Gg: ASbGncuxfzXH3oBVxgVXV9z5mIuOHsbauuCZpmDbkAj8wV1K6SBClORllPNa0uEjO8J
 l3zaMwLM8YsGR0PZ4kvij80wmNB1ZG4gm+KYQhFGBtXZma9GJslD7T2HbnbCc4mYn/6/NdUaGgj
 uXBJ6Nys0um+GSPIbeiLQ9xAh7i29u2EDBiIB03w4ncYgRk7yuITHz9NxA//L+lak8Ift0Ilx/t
 Ck6ZHk1XWLEn/Gm1vqEgbgX9rfJNSXCeNv5c8/dQKfTeWAPclPr29fE6F2GTVEzLAh8wkyglEGA
 1/E7sFeROVKrlcd3gQnpc16T7RnXd248/NPvKORcsWcbErv32CS1JfsRf0CDVQe2GaJA5gJuUuQ
 s+nZ/PhTw8cQk4xJCwZyT+r5nvtvlR5a4rs0JHrrc+ieiY6NNhZJENHNPfP83K6WvaYUcqS2kQS
 O/4nSSGaZ5LiOP4TEmTd79WrzW7fSIAKAAg//ZsLMV6cQ=
X-Google-Smtp-Source: AGHT+IFYvono0+s4yexjoDgBI8G1uVs124bbeyNjyszamDItzmgYjRHhATdxny95FDdp2D2tr30L9Q==
X-Received: by 2002:a05:6000:2404:b0:427:5e5:a09c with SMTP id
 ffacd0b85a97d-42705e5a09fmr10995058f8f.37.1761070659110; 
 Tue, 21 Oct 2025 11:17:39 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47494aa0336sm23611425e9.1.2025.10.21.11.17.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Oct 2025 11:17:38 -0700 (PDT)
Message-ID: <d4bb9b02-5cdc-4da5-926b-7bb17f78bcfc@linaro.org>
Date: Tue, 21 Oct 2025 20:17:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/xen: pass PCI domain to xc_physdev_map_pirq_msi()
Content-Language: en-US
To: Roger Pau Monne <roger.pau@citrix.com>, qemu-devel@nongnu.org
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 xen-devel@lists.xenproject.org
References: <20251017155136.16540-1-roger.pau@citrix.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251017155136.16540-1-roger.pau@citrix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 17/10/25 17:51, Roger Pau Monne wrote:
> It's currently impossible for passthrough devices on segment different than
> 0 to work correctly, as the PCI domain is not provided to
> xc_physdev_map_pirq_msi(), and hence it's unconditionally assumed that all
> devices are on segment 0.
> 
> Adjust the call to xc_physdev_map_pirq_msi() to pass the PCI domain in the
> high 16bits of the bus parameter.  On versions of Xen where this is not
> supported the passed segment will be ignored and assume to be 0, no worse
> than the current state.
> 
> Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
> ---
> Cc: Stefano Stabellini <sstabellini@kernel.org>
> Cc: Anthony PERARD <anthony@xenproject.org>
> Cc: Paul Durrant <paul@xen.org>
> Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
> Cc: xen-devel@lists.xenproject.org
> ---
>   hw/xen/xen_pt_msi.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/hw/xen/xen_pt_msi.c b/hw/xen/xen_pt_msi.c
> index e9ba17317aba..df15ccf0d030 100644
> --- a/hw/xen/xen_pt_msi.c
> +++ b/hw/xen/xen_pt_msi.c
> @@ -138,6 +138,7 @@ static int msi_msix_setup(XenPCIPassthroughState *s,
>           rc = xc_physdev_map_pirq_msi(xen_xc, xen_domid, XEN_PT_AUTO_ASSIGN,
>                                        ppirq, PCI_DEVFN(s->real_device.dev,
>                                                         s->real_device.func),
> +                                     ((uint32_t)s->real_device.domain << 16) |
>                                        s->real_device.bus,

Alternatively:

   deposit32(s->real_device.bus, 16, 16, s->real_device.domain)

>                                        msix_entry, table_base);
>           if (rc) {
Patch queued, thanks!


