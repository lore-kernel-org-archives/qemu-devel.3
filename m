Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C940CCFA04
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 15:02:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGIY3-0001Cu-5B; Tue, 04 Nov 2025 10:02:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vGIXz-0001C4-AX
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 10:02:11 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vGIXx-00005i-Mh
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 10:02:11 -0500
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-63bdfd73e6eso12216201a12.0
 for <qemu-devel@nongnu.org>; Tue, 04 Nov 2025 07:02:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762268527; x=1762873327; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8YrPqtB0uXKz1t9IvP+s95mIq963aJoroAXuyt+ap5A=;
 b=IpRi8VwPB9tklUwwUn7KeSnDuUCKmCeQiq5egJc9xFIGaDxotrBLAszXP0BOshT9Yj
 a8mFkB8mMnrUZXEY2FanMn5hVDbMJEnfhM4zuqEZVZ1grdqpYdACsWfPILmRWsfhDSwz
 JN1S8WcIPkKbpxxE7X8lGPW7DrHFayNYlbz5KjwXP2SYlxlslcxZxfva0DSjUuXsCXxz
 7EODdHHrP4GeZgTRnzx/mBAgeWMNYZWCu0Ej5jdnYjPENCcOQi82kqmu2RCBX7mzJacx
 67bbzfhpSFxYRxMfifUwlPJdJbRP21F80r+toeG+PvT6y3gUNjB8rWY0O4feEDrVdUOX
 E1UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762268527; x=1762873327;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8YrPqtB0uXKz1t9IvP+s95mIq963aJoroAXuyt+ap5A=;
 b=tguHMOvlimJQTmDfQwn45yHi1vHBK7GtMMQSvOAFhyMQPn2OGo0j0b0HGzJGrjEKHg
 EOD39sQP4fW/Zw5nIPAYROhXFm6SrQO+fmmSYZ7E12V7OqhkEhtYduHGUnG5UDbayKGh
 1IbXdT/qxl9YvDWEm+Cgiy/aS4jsiFdJE3yOSi+e/PKte+kPmQwxLpGxOVTFlZWuGn/T
 FxUKi+wTf+ggQuKxvxa++lVfprUxMP3jQlZCwWHpwWZ5bm6GKC+PMO19KgWFCWPq9UY0
 e2ajxv8+7/Hrp53VrY5wjztN/+yxNICKy9xdcSRYBTP+0SfLi4BpnEeD9MazfdlWsz/p
 E1ow==
X-Forwarded-Encrypted: i=1;
 AJvYcCXekwbqXzpkqi0Mat34F1UYLyfohe9yK6mULYceAYgPrdibsL5fMdzMCWc3WXVz+ruNY2vy6zwaNJyF@nongnu.org
X-Gm-Message-State: AOJu0Ywv6qo0Ar9Rb4FFDIyZap1tH+WKDOyWQGI7XDe4sXJP4chtEuRR
 kGMq7EEv8xxh+en1dfIx5fbiqIXXkE367fhuKOmI0gaDBUNYO4il1iIDfamjDXKSLxU=
X-Gm-Gg: ASbGncubiS0jC7kdF57cIaYojQHuxL0cc/J9tfQEsSI6CXvhLX+gs7URmFMOlSSnR4g
 KOKz8IZFA2jBp+9NhY1ThkccE1EJgte3kHUq9cF9ddShmeJ9oS8c8Upc4o9bgDrQnHWqnTQK0dR
 lJVIvg7xK6McSZJdG3plWy/GIHMgnnhDhFW9wRdzScE26BqziW4FQ2QZByRTdcErr5jKubxjGRF
 e9WnZ5slN5wbjEFSKpcDpT5sFiiTtYRk9fczgvpb/eL6Ye2vnLVoFb98zlSWp+7srvZBJsQ0TTc
 /Aqp3eeYd64b10zUsZ6jQy2wZOR6GX6uJKRAhXxDsWa6ZYaEX8bRbQOFXLJxuLuAw0ZXTtSTiUc
 tYl/rXcYoCoBGHTaqVn96XmN+l4DmxNfdKxYwI+vJI18nmyZOqyYJ1iVe7p0KgQvd+QULCuAb+Q
 3HVDOQ6WPtSEPGoPvvvTY=
X-Google-Smtp-Source: AGHT+IFNaobdt41g2d6MEuuU1HeZfeRFUQElLUAAZ6R5W4EjNt1tML/13Iy1X/8HqbZrp2YZru3mHA==
X-Received: by 2002:a17:907:868d:b0:b6d:6026:9f1d with SMTP id
 a640c23a62f3a-b72156a13f6mr370306566b.1.1762268527365; 
 Tue, 04 Nov 2025 07:02:07 -0800 (PST)
Received: from [172.20.148.75] ([87.213.113.147])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b723f6e2231sm231169666b.34.2025.11.04.07.02.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Nov 2025 07:02:06 -0800 (PST)
Message-ID: <5dfe6daf-b8d6-4371-a4a4-6cf98977349f@linaro.org>
Date: Tue, 4 Nov 2025 16:02:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/functional/mips64el: Silence issues reported by
 pylint
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>, Paolo Bonzini
 <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, qemu-trivial@nongnu.org
References: <20251103192430.63278-1-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251103192430.63278-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52e.google.com
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

On 3/11/25 20:24, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> Drop unused imports, annotate imports that are not at the top, but done
> on purpose in other locations, use f-strings where it makes sense, etc.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/functional/mips64el/test_malta.py  | 15 ++++++++-------
>   tests/functional/mips64el/test_replay.py |  4 ++--
>   2 files changed, 10 insertions(+), 9 deletions(-)


> -    def test_mips64el_malta_5KEc_cpio(self):
> +    def test_mips64el_malta_5kec_cpio(self):

I don't see how helpful this warning is... Can't we disable it too?

Otherwise:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


