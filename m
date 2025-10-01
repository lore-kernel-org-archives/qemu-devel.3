Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D31CCCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 13:31:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3wuK-0000yp-3f; Wed, 01 Oct 2025 09:30:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v3wuF-0000wg-Nm
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 09:30:08 -0400
Received: from mail-qk1-x734.google.com ([2607:f8b0:4864:20::734])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v3wu8-00081s-Px
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 09:30:07 -0400
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-85630d17586so978976685a.1
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 06:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759325393; x=1759930193; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xBolGonv+ycL9uEP1rZTH1ZIE3XHVJ+twISiule58Qo=;
 b=mTWozw6VGBOEY18oRSfgV6D0EuCxqOJtT90KlZOlWrWscpQb3wr0BBrJyBJ2Sh1P9q
 i82I9L+mIKPSY7OR57RUN3Bztf41pdfa9sIK18LiaNtCRyceP3Q8lu45f8gME+ZtsrO5
 8gXboJt0r2OrHfpXicMGb2K1ilAhBDFWt3NboRpVvfLqAD3swdURNNdkBzvsnWpf+354
 M28BEiqMa7/QgOsnNKnQfVk0WJwoUtVtyrJ4LTkFdaYbCRcv7LHA1Di9HIj0Dg0gjtaH
 2DWV6/ESn7ujnekd6We/FBvtVvNBTqzckkmoM+kGkqeLvnVkWIPU6v/rX4NpkhBPctl8
 Wepg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759325393; x=1759930193;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xBolGonv+ycL9uEP1rZTH1ZIE3XHVJ+twISiule58Qo=;
 b=bZJkZehpoyMTXxKYOWl57SOs2fCarzozC/r4TpgwP7IDauouitxeHw0+Nb+FcFL4WS
 hdnOmHutURTwtZOICdtMGn4yYxYVvCCY4TMC/GMhCc72T2kjgUfjUUB0CrsgQSie0zGE
 Qo+5FOlyRwl6wiGdMhqPEIXFKZ2NQkoqJWl55CHbsE7+jEhBNpuuhnmZGoI6Jk2+rxg0
 +8/Y8NsZD+vCt3jJI+KBU/ckdhoA2V8b1QFsdZlBdSvqyDW2nA4EA0AqcxBhgKIEUyLj
 pI/dPQEdZ73iLhX6BFex4WCDodxvfM5PNlkhvVnSv5n3twvbIi7N+nN/88MIer1SnkSX
 xNrw==
X-Gm-Message-State: AOJu0YyPBrt7DDxXQ+E0Lo72hiaRrdORzCyXMhNVIaYPl+Phwu4tv3jU
 pKZT0b9t06w/RUOb9sQ09BPgxQxAEor+vWZdJ+ybRrzjoBvQmwjZT7Bvevm6OqBoqc/oXNWruj2
 jq4nO
X-Gm-Gg: ASbGncsca9ICT+GtlsH5mmwWXHmWlJbw6BqNQz3//8WqHhYNaTHwMREHoWuUQzqdXmU
 1p7JpgLO+q9IdrSFOLNeELTd0Sw1xyk6CoY0tAepzhN0Z1VhgkzBVZ1Er0PvyPhfNzh6WKflk9W
 6+12Gk0RFBL6OpXHVc6vzy8mfE1v2cBkVMtaQ94g14vjLncV0T//ZPdVaexbZeBfcIrvhlO40Ri
 0SKeOGM8V3bhcv7HqvLWFATK/GJwbyyiWA6Eac0BTR8P2gcDsD+S76nYdODeb0tMPaVjA9zc/ks
 nhEyUV/KWIh3jIzNIldWMwdzCZaV/4ARaeYDRB4Mrz8+J6OgPBe4zF14IGUDv6IrwhWqqf/Vn+N
 VJ4pC8Tdqp2eB3m+/Az6AOWyXNNY6WWd8yLPOZzPZ86yXC4LWsINPDCpNv4Ycs8W047DL4a4iZW
 tGi/yhlZRgMqjkzZq6K7x2OTPBhlHIuQ8=
X-Google-Smtp-Source: AGHT+IHVA+8gdPP1URAW1arMuS40ZON5szvLkOnBVm0h8wUieTspmMtRmA9oJ+cQjj5UQnG164/x+w==
X-Received: by 2002:a05:620a:4112:b0:856:95cc:705a with SMTP id
 af79cd13be357-8736ff3c7a0mr470012785a.9.1759325389963; 
 Wed, 01 Oct 2025 06:29:49 -0700 (PDT)
Received: from ?IPV6:2607:fb91:1ec5:27b9:1bec:2e21:cc45:2345?
 ([2607:fb91:1ec5:27b9:1bec:2e21:cc45:2345])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8756643def8sm76164385a.16.2025.10.01.06.29.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Oct 2025 06:29:49 -0700 (PDT)
Message-ID: <3993cd1b-6179-48e7-88c1-c161bb448c5a@linaro.org>
Date: Wed, 1 Oct 2025 06:29:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/23] Rust ci patches
To: qemu-devel@nongnu.org
References: <20250930153746.573875-1-marcandre.lureau@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250930153746.573875-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::734;
 envelope-from=richard.henderson@linaro.org; helo=mail-qk1-x734.google.com
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

On 9/30/25 08:37, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau<marcandre.lureau@redhat.com>
> 
> The following changes since commit 85a3fd1c4cb3ba7a9eb291c1e222f935e922d1f7:
> 
>    Merge tag 'pull-aspeed-20250929' ofhttps://github.com/legoater/qemu into staging (2025-09-29 10:52:48 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/marcandre.lureau/qemu.git tags/rust-ci-pull-request
> 
> for you to fetch changes up to 582a39beea414c092dbd8c178f3eff3a718eee77:
> 
>    build-sys: pass -fvisibility=default for wasm bindgen (2025-09-30 19:33:25 +0400)
> 
> ----------------------------------------------------------------
> CI/build-sys fixes for Rust
> 
> Collect CI/build-sys patches related to Rust.


Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/10.2 as appropriate.

r~

