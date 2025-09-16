Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4465BCAC592
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 19:22:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uybFC-0006iU-Fk; Tue, 16 Sep 2025 15:21:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uybFA-0006hS-0V
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 15:21:36 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uybF8-0003mG-66
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 15:21:35 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-266914a33e5so22261185ad.2
 for <qemu-devel@nongnu.org>; Tue, 16 Sep 2025 12:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758050492; x=1758655292; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=plRSIGgjwvgmUsGo+HA22cOMxrAFXqTMAcZ2V7eSrrA=;
 b=dEehC/bVv6A4FGYdFzayBSFtYdTAsC5i2sLeMK27xIn7dSSJTCna0hK28T3g4i3OPX
 3mKRTuhoAk0CZah4nKgvJ9VS8mLGn24WcmibiKv8Zkw+BjnNIw1Xdg4Iv02Sok54aF6J
 6aqIQMJPD4VVnU8erfwMdONdPTMAL70qjnu/0O0ORyyjb3Jy92ZFHTGh5Tkz6bmIPnHZ
 Pn1Y4i/skk+rzLxkIvtN4EDR+yiFiSX94NWOmTV00e9zgVAiSV1Z7WLG0gH7yXbJ/Aoi
 HMoUsUSCTNxPFEygERlpzjMBLlZw7hpBfg+K5L/u1/KmTI98wn9hEO1LE17hhQrtaFn9
 /EKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758050492; x=1758655292;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=plRSIGgjwvgmUsGo+HA22cOMxrAFXqTMAcZ2V7eSrrA=;
 b=h0G0sIzZRi3ZzEuZx1qT8C5QHo9LmxMiasuca6X5vLwjCLzrI9LidNyPJK3yE75VOh
 rLBMkEd/NbkqIub4XWQBZuNI+LupTMHWFDYEclPFFIHD72rolButsbwop2CXKK9pVs2y
 1KQ7H10Cts/BSRa+V6iAXmpSfhaaTINBVaS74se0Bpo+2hDbCo/VIimOyBqommCPAIa5
 l1KkH8cTNCyw8gB6dWy6QAzH1w+qbnFtLmoRZ8+TKXGREbsa85bH4creGR43gAzhsSWF
 tDK53XCUVJa/VCaqV7ol5qtHozpHSpbg5vC2VE/2xy1xmPcc0LooGx0OurspBUSujwk4
 L7Tg==
X-Gm-Message-State: AOJu0YyV3NnNT6iQ7XcTa9Q+0ZOV68+EDFtj5x5S+x/aJVSoiBFFhGdK
 W6DJolDPeQKygT026MuTXqR2oAQOFhEzcHBR1/24b87C+1zlsh2U+jWG+IGJkKD0qifvq44U5L4
 OjC82
X-Gm-Gg: ASbGnctLjd0BNzGc2qTvSqf3U6tMzyixV23QF7stFXDu4iV0KaRDGnRYN3u/Pv7qoZt
 yv6TsKOXXnFXcLkoj71OST8dzETYQGoSXAsYc2Y+tLaJkP/fvF/BUlU/yhmNSCSJDWSM+RirCgh
 bQK9AjjioVNNTnyhHfCJ5wqqVWb7ZVzvyg9Q0k8vcdlxdkJo2ch5Bco6oQwUmrK3VSHfBQTlzo1
 uv0paPSzrShI6m9+WCFjqL5DSCtcM5GLM125Fkpn2PY+l9wbvtl5yADPNs79d07dVqw5c347LlR
 zs78aXqopMsU1O7Rmfc39ctUtW+vOxSMcimVGRys2u7xhrWXExVF0/fdcsMQszng5rXOWEMjXiH
 RNTL71jfOwSuP7cZsiNM/XbI/hUdpbJ/56GJu
X-Google-Smtp-Source: AGHT+IFRqTkxd1JC4OdPn1037/1NdTI7mLh3Qq2FQPgiq1YrC5VQlB+LDc0LFIOrvoaHsGt9Fjb6bg==
X-Received: by 2002:a17:903:287:b0:25c:d4b6:f117 with SMTP id
 d9443c01a7336-25d276242femr223062625ad.35.1758050492319; 
 Tue, 16 Sep 2025 12:21:32 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-32ea0f94005sm1456397a91.1.2025.09.16.12.21.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Sep 2025 12:21:31 -0700 (PDT)
Message-ID: <9e0f49d2-e0e4-40de-8615-f4cf1ac1a975@linaro.org>
Date: Tue, 16 Sep 2025 12:21:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/2] Mem staging patches
To: qemu-devel@nongnu.org
References: <20250915160328.2080723-1-peterx@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250915160328.2080723-1-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

On 9/15/25 09:03, Peter Xu wrote:
> The following changes since commit 190d5d7fd725ff754f94e8e0cbfb69f279c82b5d:
> 
>    Merge tag 'pull-request-2025-09-09' of https://gitlab.com/thuth/qemu into staging (2025-09-11 12:41:01 +0100)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/peterx/qemu.git tags/mem-staging-pull-request
> 
> for you to fetch changes up to ac7a892fd37ce4427d390ca8556203c9a2eb9d38:
> 
>    memory: Fix leaks due to owner-shared MRs circular references (2025-09-15 12:00:12 -0400)
> 
> ----------------------------------------------------------------
> Memory pull for 10.2
> 
> - Peter's fix on flatview_access_allowed()
> - Peter's fix on MR circular ref
> 
> ----------------------------------------------------------------
> 
> Peter Xu (2):
>    memory: Fix addr/len for flatview_access_allowed()
>    memory: Fix leaks due to owner-shared MRs circular references
> 
>   docs/devel/memory.rst |  7 +++++--
>   system/memory.c       | 46 ++++++++++++++++++++++++++++++++++---------
>   system/physmem.c      |  4 ++--
>   3 files changed, 44 insertions(+), 13 deletions(-)
> 


Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/10.2 as appropriate.

r~

