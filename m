Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F638CCF9F8
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 20:50:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEw3m-0002cI-Tk; Fri, 31 Oct 2025 16:49:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEw3j-0002ZN-8Z
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 16:49:19 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEw3b-0005k7-Uy
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 16:49:19 -0400
Received: by mail-wm1-x344.google.com with SMTP id
 5b1f17b1804b1-474975af41dso20414535e9.2
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 13:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761943747; x=1762548547; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=K4vzKiOpSEPLbPdX9g4kxHhPangU7MLtZcrVapfDmrw=;
 b=aDEWhpnzgefKUpnfWAWPY9eOVAk2Bpm9xxmD2ES9j8VhCMY6IP/EcYGGuYiNG1bAVD
 q+B7vNKNNokZycOvk5VvsWsQzRcFclGIPCqLBrqoPvjbk/LUTRDvUdDsNnc/NMKiEtKk
 NazsY0uzR9NW20UI177Bf1dBRtaSVgkW9WicmgII3f0C/abY8Ateduzbj7ZBbElu2+eU
 C9sQGrWr2SHatC6KGym88W1xWprnKleRHICAbP4hoBCI6KQpE/q/Dj5xuU/Dku6jfnZK
 CHQNrLgHPXXBwYNPdO01f8ozJibPy0k0OkH9kpraFG3HzJushu8sxXdqbVo2Wq+QrZig
 lJxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761943747; x=1762548547;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=K4vzKiOpSEPLbPdX9g4kxHhPangU7MLtZcrVapfDmrw=;
 b=JW03zVXk1vYxwjoDobt7VQG3+AXbIqdyLF5jZ6jfEtlaWfbkER6WS91DvW7FsHqMlb
 4rnPDDO6kAe7Okl7bigaqmXZUBNNWD+BZuF62Vl9X/341ItfEWuRXWp6d0OhOzJD3vR1
 g4/2tw99LFyD/ZeiQExlGKd+J6hHodQgNeo395SADttKbIJRxbphZipj8CAz+FdBbu3C
 4ixTGdk+HUby3/7OLcw3XU2TJHNmFFh06NVeuOyzodOxvId+M9sKlPW8uVpn4aoLJNnI
 Y8RFiBMroilWQJPzFk4d++jncQ0fsXIZCcJhq/2WKz0q3uzZaMiFEzllv0yMPHDmbaq3
 Lx0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCV9Yg6V2oJmT4fKPiDl6cf2cMEUH/3MdnYVKWHP/A6UxYx2PnKml7vudcDUJg8OPcnvuocClm3SoqwB@nongnu.org
X-Gm-Message-State: AOJu0Yy9UWEvrDNTXV2fFbjWbqTrBUkWhFryvCs3T4scH1SHoJufwzUv
 RyacM57up2zvIN/IZxjj4/wHF3yFP6kjUeIwSuJSTBGpLm5DH4ICTlItUVWWHoIXgXc=
X-Gm-Gg: ASbGncsvLN8e4Vn3gCH6FDLRCGA3yN+tJJot29JFqP1UQ1p02JBYVYzCJE8BBqXpMMJ
 4jPNuN15fqzWItUoNlSCyKNvntQQdNKFxbElcZD+cdWYSjARUSQajoeo31/zn/c2JhmHH8hx4A+
 RIeYrGKJnD0Xr+sSQxJwpVY/QqNPQqpuynsbu2H46ntJmnGSioqWB163FWNPuWDmG1t8SO5DvlS
 /8SqHjhtsoEIlr6ltp2HeKfYtg2Ge+w/5PTWXNsGEpO18x0EREUJqyiU4vdZ4eHvQ2+sNsXJSV6
 ME/zXIF/YwfrsbI5zz8jXqqV3ayig2UGyNz4VVanDZaef6yrXjNwzjP1VfWN9LHO8YUvmahi4Ts
 Vo/i9zT5vSxI5klw6JYcLfTfByPMqaK4JW1uTW9QbGp0JHSu37NEs/BCG227YSGfBmbAANqQw3m
 N3u47SeMFO1h+Kg5ZgNuFQaedtiiYbSZ9zBNO2fCiJijw9NVskXAi0cVHdv4PD71sflQ==
X-Google-Smtp-Source: AGHT+IGTm8J5MorjQnazo5DI+siLkW2PZYdFtm3Won7iNXGDYOMfmY2fBN8B3VXnbXdWMWJvW7g+fg==
X-Received: by 2002:a05:600d:6352:b0:45f:28d2:bd38 with SMTP id
 5b1f17b1804b1-4773163825dmr22363895e9.18.1761943746917; 
 Fri, 31 Oct 2025 13:49:06 -0700 (PDT)
Received: from [192.168.1.17] (adijon-656-1-155-31.w90-33.abo.wanadoo.fr.
 [90.33.190.31]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4773c394e6csm14053995e9.15.2025.10.31.13.49.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Oct 2025 13:49:06 -0700 (PDT)
Message-ID: <80c53cdb-45eb-48c5-978f-bcc30fe832bf@linaro.org>
Date: Fri, 31 Oct 2025 21:49:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/xen: Avoid non-inclusive language in params.h
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-trivial@nongnu.org
References: <20251013111152.25807-1-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251013111152.25807-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x344.google.com
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

On 13/10/25 13:11, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> Copy the latest version of Xen's params.h to the QEMU repository:
> 
> https://xenbits.xen.org/gitweb/?p=xen.git;a=commitdiff;h=0291089f6ea81690f37035a124d54c51fa7ba097#patch8
> 
> With this patch, we get rid of a non-inclusive word in the comment
> there.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   include/hw/xen/interface/hvm/params.h | 9 ++-------
>   1 file changed, 2 insertions(+), 7 deletions(-)

Merged as commit aba49488cb4.

