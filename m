Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CD8AD29FFA
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 07:56:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgIDX-0004i6-Cz; Thu, 15 Jan 2026 02:56:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vgIDV-0004g3-QS
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 02:56:29 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vgIDU-0002pX-5L
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 02:56:29 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2a07f8dd9cdso4438555ad.1
 for <qemu-devel@nongnu.org>; Wed, 14 Jan 2026 23:56:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768463786; x=1769068586; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iv38R0w0UhtZUHCNYDFYJNpVgQoPsUcJBlhNKE+1IGg=;
 b=VStGHpfee51ta7+Xxe+eVcjVpZJcuRFfl4O1ZUx6/XhHA9iTlPhgzj61cyndljB+9j
 ytfnBaItoTGnLI1di1K8Ka31AZVGk1VBsdUuRj0SAb72M+txk4NP4Gs9K4+1KblDHZxC
 5OxMX/b0QQnb6dzrxBsCyoqJWy3Fcu+/mjMheAx/F4d7ZcJMSDuS10XQ2hUOnk92YOhJ
 IG7x89n+GYaQT31VPlyIA7TwlrhN4Z1E3zQb3jeh1RQCj3vAk1DjfydzTeVJNs7jMHjb
 a4kUPC+JpwO3DM/T5ChYrTWgf0vWVpA9eXvrCpkUNF9NncGQrhtBW5Rm/S6PcYGoGzQw
 w3Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768463786; x=1769068586;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iv38R0w0UhtZUHCNYDFYJNpVgQoPsUcJBlhNKE+1IGg=;
 b=FFoOaorzXLfF/Uw/yhhm6IAgUL8/a4YqeLTesloOg5sQGn0+sUnugju+qC8dpqzaN9
 YEqq292AlWOx/tzLmXf+AL2Xp2gex0fkgIiOlP4l2b99MUooINZNxhRGsjFmWLvLm+AG
 lzvhKiiUTUZVivbpDCgIFNfXirjrn3ilB7xdYG7BWTpkMEPd/rZaPe2A+IG4gB4XfzCK
 QGpfiNekrNCnyiqnqhTlii+T6Ud2V7OEfyrPGZQbuGYlZfQp6E5hBiz89zfgbrNgEi3n
 n+5gtUB/bd7Zb0ctkIRbK+St/Ka0OqqJNMM10iuxVZuozkDUFeVOFtOkLZMNJRxXk6fd
 Og8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJSv6yimOOgbj0Hic3L5Jcv8CN8+DF9gBKwXP/ymlqJXwJx51FSZ0EhdSyrfhboOoHOxd+Zk5OPb+1@nongnu.org
X-Gm-Message-State: AOJu0YxD9kh86LzvJiozyblMZ3ITIA0AFNLnQgIyYvLbF+Mvk7Lfm8UA
 5cdb9x/LlL6jRIUywVwO1Yilh/a3russt919QBGZVxYZj9mVFw4cVBP/+S2GDjHt/pl6qqGuX7D
 7XJW3jXF1pw==
X-Gm-Gg: AY/fxX5YReB9L+BHwMrbzkWsQ1HLyX2E9v7tf6Vwd5SlaQj46xEFPpibesmX8U02NIt
 /AoGZUwLQi7mAIPYNhxcNMVc2o7FuupnNA03cpXg6LzdZ6Zf/oAwsPksUYXEw1mCIPjxt3qDfFN
 5+WwRLHSwB04Jh9N7RteiEO9OzuiDF40/jOE63QiP3fOYEUX+MwL6StgzhQ7hV+hDeCQJiB6+kn
 pKa2pnSWHG/duwnzsRwVnkV74N9jSXs55bLVpdyEDvElsqescGFDyG4ztnZLPOInlaRtSvLyCsp
 y07UwtIV9EDf5kW+T+90DdVwpfVgxJKr7wUd4Zw09Svq/lmVVdfuA9qSE9w1hIDcnL+neRpWgwx
 CaRNs3C9Med+nnabWmiaiEOw/kEfgJniuptpAt9EAbLV1WVL5jnshZTpJkqL7gV4zYLM3TBg0tY
 GtzctZt3ygJl6EaM/L7/WR8H8fInl+wQ==
X-Received: by 2002:a17:902:cec3:b0:246:7a43:3f66 with SMTP id
 d9443c01a7336-2a599d81c70mr63025785ad.7.1768463786394; 
 Wed, 14 Jan 2026 23:56:26 -0800 (PST)
Received: from [192.168.10.140] ([180.233.125.201])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3cd2954sm79703625ad.86.2026.01.14.23.56.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Jan 2026 23:56:25 -0800 (PST)
Message-ID: <42588c0e-91ed-4a6c-8a1d-777bb42d8927@linaro.org>
Date: Thu, 15 Jan 2026 18:56:23 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/7] Mostly x86 fixes for 2025-01-13
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20260113111333.1138160-1-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260113111333.1138160-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 1/13/26 22:13, Paolo Bonzini wrote:
> The following changes since commit cf3e71d8fc8ba681266759bb6cb2e45a45983e3e:
> 
>    Merge tag 'single-binary-20260112' ofhttps://github.com/philmd/qemu into staging (2026-01-13 11:51:18 +1100)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/bonzini/qemu.git tags/for-upstream
> 
> for you to fetch changes up to a24f045228271391b5c5064ebf049e1f50b6d712:
> 
>    rust: Update Cargo.lock (2026-01-13 10:54:28 +0100)
> 
> ----------------------------------------------------------------
> * target/i386/tcg fixes
> * hw/i386/kvm: fix PIRQ bounds check in xen_physdev_map_pirq()

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/11.0 as appropriate.

r~

