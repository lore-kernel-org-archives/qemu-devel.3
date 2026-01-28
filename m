Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E1E3D35668
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Jan 2026 03:35:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkwKr-0007UM-Dv; Tue, 27 Jan 2026 22:35:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vkwKp-0007Rg-Kt
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 22:35:15 -0500
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vkwKn-0005E0-St
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 22:35:15 -0500
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-81dbc0a99d2so3202894b3a.1
 for <qemu-devel@nongnu.org>; Tue, 27 Jan 2026 19:35:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769571312; x=1770176112; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9qpaZSRAwTnr16Gw4yfV8KXLbrwvYAE9mZVYy8k2oI8=;
 b=ZzduZCrBCtxvzwPzU0keRwi4fY0J/lw5PXJL0pb2AuzGQOIxYnbgObO98YOe23PiQp
 Ac1xlGsE/Tx+Ev1jZoqmI4RPi4aTJ6LZTgyzTNV0Qeao5HqOO8l803tZke0cnqwOxy8+
 AwoEwZegULecAFNG/BLOJhYu04e+s9GywBFS/hM8IlILLIb34I0M4+2FPz9ERFCYfB4n
 Fxwbils5U21NBjQOID7JlqFKx44+JP9UA29iFQ42YUR7zfD/yHC0qmPrzSG8NwkFrYMH
 4kHf/Si9oHdzhRIXDL+8AaWoFJIK3+1CcDnMka68wZ5v+HA5ZDTLqdOq4kxgQrOmRkxR
 K8Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769571312; x=1770176112;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9qpaZSRAwTnr16Gw4yfV8KXLbrwvYAE9mZVYy8k2oI8=;
 b=FaZPcl69ndYL1rCBN93RS3DWM6mm1ZLrTe++p1jHlYNMWB5qRtZBEAFCuD31gRdECj
 Hi4nEV4DGArG+Ebp8mEN6GzR60ItwHSd4DkF2i6sRRGa7v6x5i7rlonp16YSSYobUkxU
 B36dUzgLY0ry1Ok6s7l8Gxxr8KHJI9d3B3UxR+OaIYALrn35OVVjoWBmX5L61/MCbHX3
 KKrGNHLGVfkmF6vxQakmVmNfiKrg4/3nkD7fwkzPJkJlEPnRCctDOyJDdnkw2dbxVGT5
 6O3cmfw+AiLCxMc0tx8kFCzovrQHFBBj+nI74Z1qJxUJYBlNc7FfxOTlTXcsXLXHq4H4
 PB9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWGIQgrvarfdOlP3ScD3HMmXUnsDQGNad5ct3KcG9dAlM7iJ+Tw6VACE5f6BXYjAv9n51piORlf+KXE@nongnu.org
X-Gm-Message-State: AOJu0YzusQ6Fu3UXhUXhZm940rJk2V7M97Lqel8/8dkUdQA0OE/pRRcb
 z/Lc+tjLLzXGZSTH9gW/A8NyoOb4sip2ZvOCZRvisQB8puUSqNMveMK/SnbYHzJd3eA=
X-Gm-Gg: AZuq6aJe9V8Qh6uKnnzWnkQIdJlhPJH9IzK7tUegGtdmaK/wo4YXN7F6e6g/Re/eQcp
 LhesLiH6izIGQ0xl7/NxT0Q6HsknIB6+jQY5sVyFrXE9vaNgSqJRI1+U6TN/+9bhUBgBgH/Fa9Y
 mX8sqCU9MJGQm9/jAxpnIbSTuHuOTMcIy4h03N3EWgHqOkm5WRUCvd5UZrBAOqvqx11aM3fNTZz
 F2lsy2+wb9xjXUHfmcC5N+AIO2rO/7lWhAtVD22nByjETfozATnum4MmTeAN1tRePb76o1XS9P/
 UckqN7Izeas5gUEvJhczzqrV89l9sGo9j1Dgq5RGgAIjMzesOCkodqL2JbAYySu8CmO/J9v+71l
 u88p5LkNGjLICdukWU4MutM14G5EGN+BIHm9GFMZDg3US1RVbA2/z1M4avlcLcqNiiepQDDI3kY
 smfB/tgSkfQbGeanPSe3wBum3hI5CA8A==
X-Received: by 2002:a05:6a00:2402:b0:81f:40e5:34be with SMTP id
 d2e1a72fcca58-823692cb695mr2845356b3a.46.1769571312351; 
 Tue, 27 Jan 2026 19:35:12 -0800 (PST)
Received: from [192.168.10.140] ([180.233.125.201])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82379c1fc6esm938945b3a.47.2026.01.27.19.35.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Jan 2026 19:35:11 -0800 (PST)
Message-ID: <e392e879-a194-4af5-b6b4-8efec9f7366f@linaro.org>
Date: Wed, 28 Jan 2026 14:35:08 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/9] tests patches
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20260127142710.131904-1-thuth@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260127142710.131904-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

On 1/28/26 01:27, Thomas Huth wrote:
>   Hi Richard!
> 
> The following changes since commit f26976b9d30496d28bd4fd045f4300706e567a29:
> 
>    Merge tag 'pull-vfio-20260126' ofhttps://github.com/legoater/qemu into staging (2026-01-27 07:14:11 +1100)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/thuth/qemu.git tags/pull-request-2026-01-27
> 
> for you to fetch changes up to 161ea5a63413dd5efc07205483c1070a6e859785:
> 
>    tests/functional: Enforce sha256 as hashsum algorithm for all tests (2026-01-27 15:20:43 +0100)
> 
> ----------------------------------------------------------------
> * gitlab: preserve base rules for container template
> * Fix some issues to make QEMU compilable on non-mainstream distros again
> * Enforce sha256 as hashsum algorithm for all functional tests

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/11.0 as appropriate.

r~

