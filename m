Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAA43CCD18E
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 19:39:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8krf-0005Fq-F5; Tue, 14 Oct 2025 15:39:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v8krd-0005Fd-TA
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 15:39:17 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v8kra-0001TG-Ae
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 15:39:17 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-46fcf9f63b6so10118095e9.2
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 12:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760470750; x=1761075550; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vAdPt0D2j0EBdZVpBFQen4/6PrJWvwHUpjRFJ7qVSyw=;
 b=YEOl3TPEP88l9IRBW1ze86i5MN9wYlJfqLghKm/R2BcsU7SCDsTYjtH2H9T3csxFD7
 Arxvpy0A1LR4Q3bUL2UEHuisdHmdA/r0ZTrDK/ABkUQVHFrX43Yz+Snwkdl5jg8UDZ4S
 R6ysja18pTf+NDSNY3rer+J0xhIyZSl4W/LACNqHXeL2FkWwE4g2TkE+5nZbe8MO4QTc
 pYymGiJREFdyI/b6YTuw1G7R0a/HFmTbcZLub7Y7qvb/18arcdb818iD9Yv71246gyBN
 6FXGjX+OPrMbeMdujXnanadg/WE7n4OFGqaMOtvbnk0egRLllKNs37bzH7luQCB17b2s
 /UVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760470750; x=1761075550;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vAdPt0D2j0EBdZVpBFQen4/6PrJWvwHUpjRFJ7qVSyw=;
 b=gsut1VEOu3rI8BDYNxabpjc+iQ+/A9xWGHeUnpsslI7RnuTzRn7CDlRbLvy8HwIsb8
 bOARp5OBz8fdj41cjNo8p1nzf4NIQw+cNV6n9NTAjEpKf2GppiKwrNGAKTbsGmnrzkaO
 xPjBSjjZmJKOEJaE0q1pA7709aKxvy8zGaRcO15P6l4BPZG+Cngo447Y519U/FVvU2T2
 /nHEDjapnmwtDUT5IrZ9cabmvEKroknf3dWHeMqrncuVFGDQWKWK2sUGl54zqVB3S/7i
 mdvx5oKDS2yEIjS8VnkXASWCpCeBw83u6hEWfEhO16gTuzb5sUiiNa7/86789QzLYSkL
 GMUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVBTZxBP4is6jiNNpIZX/av/VPe9+r0+2os98h4titNJV1lPZSMB4P2bER6YJRDCyo0fITIuznitEY9@nongnu.org
X-Gm-Message-State: AOJu0YxG/W5F4jutXrnpK1Zw6mHcrmThaO69/you0S7Z3yHgVxZn23l7
 bKw8pcA2k5+T+xx8ysgv5jpd0Yi7zcVmRIZvbuPlaHhqYnfw+adO0qfbUckcS4zrU1w=
X-Gm-Gg: ASbGncsm6VnodvnG9qZEFfKI+tkmOBfBZ42GK8a1AlBTZB7X2kO2CEkc6yvbaK3Ke7s
 4RST1NocfBUh09ZWbg40GHqcXYewZ1m6KisAVtF2RBeceKSzzar/auGLjtSfxB63BlaSbe3NLxx
 mIdSrK9uW+PRWYgjpRB8wGdAhlP257lLruAkKGx8ljXfwbZ2HTWr5CqhkTOb05DJm8O8v3rgS1u
 k3J1UzQLr3NHr2QVoL3Yd+TObhaGzj+btmTH1EtLJYWel7iHESIae9mkwcoDGhyLkC7ubiBC9Xz
 uvKdr/Vfghu3Hg70FebAIXM6+NKLyXx3+aKFNKrndQPMusaohKkXI3LRiG1ahPVHo9a11egtkDp
 rokVM3bfY+8VspJlmyT505zzLZg5JW89/JDNtpR0d9/Blis5FyAVh/2CaOLntZlnGDs+1opds/w
 8/fDK+SUNiVWgKpbOIAk20oXY=
X-Google-Smtp-Source: AGHT+IFRDJ4rAOc6VbfOh5fTRvV8Qd5XSTtWt+P51CsEIXERhgpwDb345Wkg7VzDEE/K4nt6i2kTTw==
X-Received: by 2002:a05:600c:1e87:b0:46f:a95d:e9e7 with SMTP id
 5b1f17b1804b1-46fa9a22e8cmr176436885e9.0.1760470750602; 
 Tue, 14 Oct 2025 12:39:10 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fb482b99fsm262743475e9.3.2025.10.14.12.39.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Oct 2025 12:39:10 -0700 (PDT)
Message-ID: <86247d80-183f-4484-a0ce-9bf175cee6fc@linaro.org>
Date: Tue, 14 Oct 2025 21:39:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] qht: Zero-initialize qht_map
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Richard Henderson <rth@twiddle.net>, "Emilio G . Cota" <cota@braap.org>
References: <20251014191944.2225735-1-peterx@redhat.com>
 <20251014191944.2225735-2-peterx@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251014191944.2225735-2-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 14/10/25 21:19, Peter Xu wrote:
> QEMU almost always do this across the tree except QHT.  This prepares for
> rcu to track double free.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   util/qht.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


