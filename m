Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D13C2E9A04C
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 03:39:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsusi-0005d5-9G; Wed, 18 Feb 2026 22:39:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vsusd-0005cH-7A
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 22:39:08 -0500
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vsusb-00027h-OP
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 22:39:06 -0500
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-c47ee987401so288514a12.1
 for <qemu-devel@nongnu.org>; Wed, 18 Feb 2026 19:39:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771472344; x=1772077144; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2kMJJp1Ay+vZ6BV9uMuIB+sg9ZroJe3b/ivrbyxfHXg=;
 b=lCN15oDA00Qdf0HxoxOTY8u62nEJKNFgs54jLhkNPS6ijAty2C5A9Y+BsCjmNXjDZ7
 FbT0mwBbXa3c18paMLevhoff9qgR/canr0uVtLbWBddDjj839jpcds3h+4jEBK1/HBMV
 X5JB18gzzqk2aWJ4+X8LsR5E8eEpl8Pb/Wps3vC4XRUe99ydHW/bdRXDzZoS/sWSnTf5
 OD/+HwpynYF3lH8mCI2y4Wq1wbNA9inrz4gzsx9m/rEJ56ririhPdForUFf/64PwNwsU
 ReKv6wToJ0zUgKD8PkCdGTslLJNlALiEfosiuy5wLOZcjSJWNj3cUG2Eo+KetN0hWzZ+
 jOxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771472344; x=1772077144;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2kMJJp1Ay+vZ6BV9uMuIB+sg9ZroJe3b/ivrbyxfHXg=;
 b=OAcIuw+JeNLdVRsnHDlz9mN5UhZNZkgi6Fjny1fexHU7H+4McGz+PiNjYfxWmsFxNZ
 ugxYKNIlYPDMkXTUwQ1pRUQaSKMaGetD6yGjWvlDJe45WA4zJIGKehdNt/vs3N/OWLh/
 4l/c5wFhsgdSjcWpz8kGpSQ5XpD2ZNepi905RQDa0NeUxgOxT3NS1J2FhSXSBqZmklSG
 cXKBx0eukHzlWjZ4m1f1sCYedmic8AL622g6m8IJRuWiQJ6A1fwNIrJPp0Ab3jL5Bm0K
 UCvRA98fWIGBYc98kP4mCpMWkRZiwWaDZ6Xer2RmTHA0rxnt+DKBrMAVb1zTHGh3lBjA
 EB9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUqWUdtbIhqJQqpfdTMrDopUqdO8tZxc4c0r7FtLTpYH1i3F7GbLBElQO7C2eiKKM3GRAV/hgx+Yxp4@nongnu.org
X-Gm-Message-State: AOJu0YyodZbQ0uoj7INPrO3Mp9JQ8YR1IQLKYhYhlHDYqXtsmoYATpdw
 QJKZ0gBUDoQcw+qrWEUtCzl+xBOfdp4l3vOMwt3ccWJr+GqR+muckxSSqpdArpu6u5OxKM3X52v
 BBJRei7g=
X-Gm-Gg: AZuq6aL+M6sRmEp4TpH06csi476DxfGicBwilJF5DPvbbArttwvFvSnJP2aoIi0JUOB
 D/hOIMyef7FylIa0LXAh84QKIi/rqAq+ehUB275SsntLJOAjT4+AdVBzCR712ChEQw9w3j142ac
 bhydrHIhXW8Eu06Q1pbWyyN/d4d1Q1WMtIwI8kXjhId3kiPzG7ACSylNxoqG5x0Nx5mHIsx689N
 0SIcSA5tftvokxrfXXackiDAtrhhr0yg/deoKt+US7nmGIDFZ1agY1wmkJjekQP+InrPB4M1Hi0
 AjN0z36pyy5sZ3sXrBvIJVD1kcyPajG8bkU2yXQvsduiIvTgnUkqUcQyWN6dkDn5s4/rUBzxo9H
 3N9d9DQI4pl9SAOzbQhQytfkhkvdqfR6xmU2HedxLVR4iWCxS2iu0CVKJzvVo15FQe4l/5gQVsB
 f+R3F3wzH/R9ewjEfQ7mxk+c6cxvUXlzU+NrZflNwF+t6oH24soBCOv+azj4ZvQONMZM6d2hOCR
 +0n51tU7Gpe2qwieLtB8LrUTchrLQLhz8jhjYYF7pNp9yoc0WF1D7bpdeXEAV3Xk4AH
X-Received: by 2002:a05:6a21:489:b0:38d:ec17:180 with SMTP id
 adf61e73a8af0-39517c6e7fbmr508415637.5.1771472344159; 
 Wed, 18 Feb 2026 19:39:04 -0800 (PST)
Received: from ?IPV6:2403:580b:742d:0:a224:e0c2:669c:b307?
 (2403-580b-742d-0-a224-e0c2-669c-b307.ip6.aussiebb.net.
 [2403:580b:742d:0:a224:e0c2:669c:b307])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c6e52fe2e75sm13803232a12.10.2026.02.18.19.39.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Feb 2026 19:39:03 -0800 (PST)
Message-ID: <118306d2-8c7f-4b8d-bba7-bf4529c3cc9b@linaro.org>
Date: Thu, 19 Feb 2026 13:38:57 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] rust: use checked_div to make clippy happy
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org, Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
References: <20260218192444.658046-1-jsnow@redhat.com>
 <20260218192444.658046-2-jsnow@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260218192444.658046-2-jsnow@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52d.google.com
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

On 2/19/26 05:24, John Snow wrote:
> When upgrading from Fedora 41 to Fedora 43 for CI tests, clippy begins
> complaining about not using checked_div instead of manually checking
> divisors. Make clippy happy and use checked_div() instead.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   rust/hw/core/src/qdev.rs | 14 ++++++--------
>   1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/rust/hw/core/src/qdev.rs b/rust/hw/core/src/qdev.rs
> index 145e20a984f..c4a7312168f 100644
> --- a/rust/hw/core/src/qdev.rs
> +++ b/rust/hw/core/src/qdev.rs
> @@ -425,18 +425,16 @@ pub const fn period_from_ns(ns: u64) -> u64 {
>       }
>   
>       pub const fn period_from_hz(hz: u64) -> u64 {
> -        if hz == 0 {
> -            0
> -        } else {
> -            Self::PERIOD_1SEC / hz
> +        match Self::PERIOD_1SEC.checked_div(hz) {
> +            Some(value) => value,
> +            None => 0,
>           }
>       }
>   
>       pub const fn period_to_hz(period: u64) -> u64 {
> -        if period == 0 {
> -            0
> -        } else {
> -            Self::PERIOD_1SEC / period
> +        match period.checked_div(Self::PERIOD_1SEC) {
> +            Some(value) => value,
> +            None => 0,
>           }
>       }
>   

These conversions are inconsistent about the placement of divisor and dividend.

r~

