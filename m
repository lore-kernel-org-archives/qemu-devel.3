Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B493CC6B24
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 07:05:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGt2l-0004ZM-9k; Wed, 14 Oct 2026 03:04:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xGt2j-0004Vd-Um
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 03:04:53 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xGt2i-0002PN-Ab
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 03:04:53 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4a172eb31f0so30468705e9.1
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 00:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791961491; x=1792566291; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=H7AFSL+K8wQaRSv2VfthEg8E7a+enXg40FjamMKGW+Q=;
 b=fCizyPmEvaToMlHOgX7lGZlU0ZAbduMgnfPi6cy8+4z9QkcjHd3in/C9BIVgwktV8r
 RmPagBnEQpnlcLvOIBnwxJCysm7cMSFdWiMIOud8GHEZJsYf9E8V9M9zXYMDFAdRJfAD
 L3O0MI8nlMQpCdvpjKtCnD1TWzXDOcrZiAKKyWDpuEr4ZfeNxJUFjr/QF+v3+SXEn6XD
 +4a7J6qbvpEfCG99BhDGPvxw4YBatvRe/0HaN8eDONMHt/qIcUx+z84ilY5z35qpcdDV
 lQVdFrgcuEthi18+gXmMaZZFGQiCTTW1c577WAUdqoLpk2DvTaDgCnvWsQppy1tQIwG0
 nAew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791961491; x=1792566291;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=H7AFSL+K8wQaRSv2VfthEg8E7a+enXg40FjamMKGW+Q=;
 b=emwzez1Kcgu98fq7xeAFGnC/OO5mC9IYSosxEgHwV9OCnDucI6tR2ZUwbSc9I/lZqK
 Lhm4QSGPxujIMNkZ8Eh7fobbHlJ4j41U2moqgc0OPtNoiHD+dNN9yjGIdRKLpOvudfPN
 vSNSdji0XFtujS0VjhWy1iU746SOgcdOSvd/4W9rbQmzU5OX+DR2Mwwh3B8gL/0euTSF
 +sn0cMfY607GtQMs9IQgnCBBbfanlJkGryCfnEc4kyl/KTXQu4mTdMCYutWkmGhan9PS
 5tO5PQ7A8LS/N6JCaxMLk/7EihRu36C1eSKhXGXgx3bmTBDsDg7hynDiL3Z2YiQOP008
 8o/A==
X-Forwarded-Encrypted: i=1;
 AKwUvBwYEesrlQXnSosfoaC2p5b09rjoxUOpUCdwUVKKT+Aqef9qiBIsZCMm5e90pnk3BHNybH/hC6tcwivy@nongnu.org
X-Gm-Message-State: AFq9FYKlIWTobV6Du+vux8u7xr2hyohmuVUJoTFjKy3z6dMIr6Ge6doX
 1EU3LxtSCOTwDBgv6b4RgzrssU1Y1l+lXJB7YXbZ0ba6KRQVbvZs/5PiwwygEW/3lZKZstds1zU
 Y37b8oQ4=
X-Gm-Gg: AYBFou0hMfN9Wj+sPU+m66rcZWS4Cx/rE0dY8GZIQiOkQbayEexIdXHANcALCKq/hju
 WpUZyxtc1g9Hqi3v5a3rwimvbplce8Her91UlzgmYv+am9PGRKh2wPWq/CFuy1vbZTeORRKdfR1
 wSL3VxPRXLDlUwBG07VI+Te0M9J3XKdUzviF44s8pxdKH6SdQQoTgyuGnRllUAa3UL1Zq2SHShV
 MVqt9RTZCFRM74IJxrhdS/vP62dSLc1KVvG0qbvdjlJ1+enze/D12jgxErXr3awTUZDdXRiiB0E
 tdVyt/BcQk9W1KOeYxLAM+zABlokcbQpuEG9W7bY4ah4SmQ6QZ9wlwtx+P2XycTN7gTDX7KIe1i
 dpzYjg5Kx+VHYw0jse5FhPiz9qGOi6NBHGnO5/pRXQg7faVvYzbht4G/9AwV2rFNDX3yQkld/lC
 K2hugnpv0pn2jB3QEBwDN8haFLx7UQI2C+5KqW9Je76S5VU0k15vI6cCPeD0YTk5bco0Hffrdj7
 l7t6/kXoPmLSx4e762B6A8zaZCuVJD4biCQf1ch5g6YUnVS3q5jDj1Af4H6gJ5vQA==
X-Received: by 2002:a05:600c:4f14:b0:4a0:89:6727 with SMTP id
 5b1f17b1804b1-4a18e4adc5cmr304406275e9.16.1791961490559; 
 Wed, 14 Oct 2026 00:04:50 -0700 (PDT)
Received: from [10.86.151.227] (ip-109-091-152-129.um37.pools.vodafone-ip.de.
 [109.91.152.129]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18bf21276sm632682485e9.8.2026.10.14.00.04.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Oct 2026 00:04:46 -0700 (PDT)
Message-ID: <5b3f3350-abfb-4c1e-b1a1-34070072ed83@linaro.org>
Date: Wed, 14 Oct 2026 09:04:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/25] hex queue
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org,
 peter.maydell@linaro.org
References: <20261012041722.1159355-1-brian.cain@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261012041722.1159355-1-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32e.google.com
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

On 10/12/26 06:16, Brian Cain wrote:
> The following changes since commit 615ece3c406b262996e569f29ea6eed0d81c4d8d:
> 
>    Merge tag 'for-upstream' ofhttps://gitlab.com/bonzini/qemu into staging (2026-10-09 15:49:53 +0200)
> 
> are available in the Git repository at:
> 
>    https://github.com/qualcomm/qemu tags/pull-hex-20261011
> 
> for you to fetch changes up to 48166a6c9ed117fe35a5202acf8e49a9bc36f220:
> 
>    target/hexagon: implement nmi (2026-10-11 21:09:30 -0700)
> 
> ----------------------------------------------------------------
> Hexagon: HVX-floating point, gdbstub-sys, etc
> 
> * HVX floating point
> * gdbstub support for system registers
> * other: get rid of *next_PC, EXCP_YIELD for pause(), implement nmi,
> ll/sc+tlb fixes, barriers.

Applied, thanks.

r~

