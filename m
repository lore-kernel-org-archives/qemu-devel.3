Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D3A6CCD1A7
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 16:53:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBFbR-0006jU-Ko; Tue, 21 Oct 2025 12:52:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vBFbP-0006jB-TA
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 12:52:51 -0400
Received: from mail-yw1-x1135.google.com ([2607:f8b0:4864:20::1135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vBFbN-00070A-Ub
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 12:52:51 -0400
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-784807fa38dso47334467b3.2
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 09:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761065568; x=1761670368; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ej5Wc3z6jYDOXutJ8EdHhInBUwZALfgz7dgjLcehjuc=;
 b=QxSgi6CDJ/sO8VAJSs9L3/rsjYEW5z/Ko+vOgM3pOhV9MzDmR6UgHatMyaIcgfEFLX
 f8zkxQtG1TAVu8MUZxevDvgmPxR2tbPXVm37ZW2Ivyy+kgfRxl+DzI5p/nqJT2TdgItX
 6UOVmeen8c/c38Tfz1EslAWxAblSczKWLAk/p9dFEbqiG9EXLgKoyQSjapCkUtrd6UD5
 s07tBLeSVgqY7xMzZ+uHOG+pVSiZqVRX65oxMqQxUuQjO36Bm2LGi42RYHqPe1yoRd4D
 eYq7la3turcdRuCy1vyxfXglTD5+SdGDOslBmyo0E5vgf5sFKRznUxotpAoNpN6i9a7Q
 mbNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761065568; x=1761670368;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ej5Wc3z6jYDOXutJ8EdHhInBUwZALfgz7dgjLcehjuc=;
 b=kfXVNpcTy2SJGIkANi3vnkrPU7uSiVpAKtbEH7auZqD8YG3F90lN7iHgPz1MJovavL
 VPdgoVoJgJGEJY9GqWBDFWYSQ+KSlkJeTvjhCj63l9K1yYTlKCuvqSJprbBZxwJKQO8b
 Lap9DEbUnqdRLYLDwkFxEWwBAJFtr5xHkvuz4LZgqdKGz2/JO9BvYB9eATUVIhDz3tG7
 jLX8YytxxyPCyq1n/8CQ8KclCYgPvMTEr7UHE/B8TbJYSmmQ/ZF69rbNtwI0Pob6LHkE
 Ep5RHYyT/Elz0XYRyYUOXDj/0yY3CTJvjbe2ESdjup11W3F5wN/DVuTLYL0ggCF6sq2O
 dbfg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVo7fq78NlJ52gPNP/9SIPi085lqhI2OqYLbi7snvA285+uvGlb8ywVkgdKvKSJ+frvxaFriG3j+xbk@nongnu.org
X-Gm-Message-State: AOJu0YyHVZps3wEUiKq+sNbkna+kZbRzKsw8UwxkYqeo/HHIJvrrAr/z
 9LzKfxBmQY32do/YxpvYoLRftFFKT/QYSCi0c/QdPqBgvZIaG5BQVml4Ushy/bYsUo+K8gzxA6O
 SxjX/qS0=
X-Gm-Gg: ASbGncvKVGHgzOlfeGkRodxBmNQpytDCeD0WL72Yqkr21EryRcUU60SQx4HzWy6erQG
 I6BbihjaAYi6VBmbIdQzUsgaphUa3EzHqYz3hHGSfxlLiiXxPIvf9ygh1Z6k4B2CSlgjdawu2QW
 gZFrz1igv2GDwZ3HjC2Ya0jCVW9QkiU/7RpbKB21mmuIjL05L6hmMzvE8sTSKlUyzTmpQcvGcDT
 Fm4XJFyH17p7O2++lFpbNaCfpm36FQ1LtekVwjF3+UAHpKtG8ZO5YwHSzgRSuYa3m5u9n+cgMbr
 RpQ9UVRBqZrGQlcAPO+pxc7FEG8zL7Y9DN9wObE5t8oPcG4e3ZbHY/lABtBEhDUieNnyNquNzq5
 CBv6E4in3GsWEqeuq+zUFQtNrlXlj4EzLnRDXHb2nhGhWzA4dVIyXX1JZONpgy1Sy6igHoUg9DO
 +arV3vA1XrjXv6O/nvVgp1n+Q1teLcgiLyr88Vi6ljB41NVsYsEgi2MiOq+Gjv+ODGupdw
X-Google-Smtp-Source: AGHT+IHod+xIVRdgEJxWFKI2I08/+RwavYpLlggy6un0RZLC3Gvj2aIZ6Z3bnoBN/sXKzXQv+q2Afw==
X-Received: by 2002:a05:690e:11c4:b0:63e:2059:cb80 with SMTP id
 956f58d0204a3-63e2059cd40mr12223569d50.33.1761065568348; 
 Tue, 21 Oct 2025 09:52:48 -0700 (PDT)
Received: from ?IPV6:2607:fb90:5ef2:c582:739c:d109:1083:110?
 ([2607:fb90:5ef2:c582:739c:d109:1083:110])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-63e26408456sm3384303d50.0.2025.10.21.09.52.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Oct 2025 09:52:48 -0700 (PDT)
Message-ID: <31f4a5b4-545e-4109-9ae7-fb0d7ee56c78@linaro.org>
Date: Tue, 21 Oct 2025 11:52:46 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/1] Error reporting patches for 2025-10-21
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20251021094943.3585876-1-armbru@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251021094943.3585876-1-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1135;
 envelope-from=richard.henderson@linaro.org; helo=mail-yw1-x1135.google.com
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

On 10/21/25 04:49, Markus Armbruster wrote:
> The following changes since commit 3a2d5612a7422732b648b46d4b934e2e54622fd6:
> 
>    .gitlab-ci.d/buildtest.yml: Install 'file' for the Coverity job (2025-10-19 11:49:36 -0700)
> 
> are available in the Git repository at:
> 
>    https://repo.or.cz/qemu/armbru.git tags/pull-error-2025-10-21
> 
> for you to fetch changes up to 1a5319e26797404a5f7738111ba788b593483af6:
> 
>    ui/pixman: Fix crash in qemu_pixman_shareable_free() (2025-10-21 09:54:48 +0200)
> 
> ----------------------------------------------------------------
> Error reporting patches for 2025-10-21


Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/10.2 as appropriate.

r~

