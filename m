Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D5E2D0EE13
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 18:24:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNxhR-0006WD-LX; Tue, 25 Nov 2025 13:23:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vNxgo-0006G7-Bn
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 13:22:58 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vNxgm-00014z-N9
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 13:22:58 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-298287a26c3so67909225ad.0
 for <qemu-devel@nongnu.org>; Tue, 25 Nov 2025 10:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764094974; x=1764699774; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5z9CAUO2QbskFWs+52ej76mxCRsR2C/PF6TUrZdlCTU=;
 b=RQLCYf9pJvCxKvQnEfOuJYHRupkRHKa0GlNMKjF+befRU2jYnc+wBCRhJ7RBpPwBIA
 lM9IPw2TJtsGcPd2t3mhNhph22E54kHvNyPIRAW5B4WG8HgwbHid3w6MgW7ZuN5fng1A
 fAL9QuwOD09uxbNsPiLLosNrMLhh8ZyS56nlJdFQnf9xrDktga/qOfgg4z8XiUL2LArk
 q5CHdjuY6KaVrLy2jv3s6Eedo1KcYB9BqAY8Oknxp5Omo6BTrNB/RZ0BjNDCBpLDJ1gV
 xOcw/qJBw+3r2OtWpsBUbXj8zyo4FNdhc5Q1u/KTaApCwXkBs5iXAKUw9Adyp7HImkl6
 cMNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764094974; x=1764699774;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5z9CAUO2QbskFWs+52ej76mxCRsR2C/PF6TUrZdlCTU=;
 b=V83i4BfRxQj0ORGGgkY7JT8URys2F7q9EvMOzqJ7LihI6bPHRHq/37DOe0ZA0CMSfk
 mDd44A7yewUPvd7bV9ZFWjVQJ4xO9SIj/ZV4NESnnntqPdzNq5riHt3Rcp+sCK/UipI0
 we9gXRtHRlj5/jovsyPpGcdZ0KQvkBHUnmjls/X2SVbcu6WIkz/b3ZNPnfoErl4vFGDT
 XNpfYYfSm4y9pEg0hqKyA71NANZfkgNCQvimRSuhaX15rvf1lK2XBUD/t103DyVPhDf+
 b2ic1aXiY2nfy7YgFfhKBmujQJkochN/GnFStNU1l40fzqknVC5rLXzCzuxkXOksRNJk
 2fNw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZns2UiAruw9WabNR/TrL0ns3ySeFSJUYAM//kaEHr1CYIiI/Ehbf/H2+xdd0JpwGqwLUs+uNK4LkI@nongnu.org
X-Gm-Message-State: AOJu0YxJpUh0KdhYydzajPjico0jntZas2Wlu9iZWj3iNsSpybPPn+DX
 Jeg7yCq6Ua5ade4PglmJv0zLRHiSYFwFB08RdxDUZb3XMq5Qa77lTOK8WqPaPGTNhwY=
X-Gm-Gg: ASbGncv64SmKVsHi+zDX66W3N1HWxaD1ROB9q+AV/m/LkH0Lp/jHmz41nVfCImDIl+z
 2sjJB6yItIM5UVPqzYWLwLBR37/HPxpCW6+eeiYdGFyC75ZgsKrDRBZEvK2mM3t3Z5ovqf+5sEC
 3t5MYIuBLZaz54dbnmFYR1pn8KbB8BWPuqmj0N6Y5v5ESI2VSddWrGs5q2aCVTeD1/Ek+UesZz2
 8CPufqIeceSUDdM7dSpboUlECMdW2/ci+R8mufIzQtq8Hmtp+4W4oTMBxXYW/AbvlpPU7UXIzSL
 2dbFxEv5CoyEupEl9j72DGpbZkv6Nk+GLSCSKJqTvhqHyygPSxbIcHHlPwegu/PUISO3kUTxLro
 Tju7ratw2CBRvy7I+OYSDD8ytxBcKf0efYnIaczVr8HudVdflu9tsKKHh2F8FcXtCOXoPWhJOmt
 /bxLZRvpJhYLXvqkYHFzyvW3dsZyeDCSvOU06X8kI8FsXbHQ==
X-Google-Smtp-Source: AGHT+IEg9pWAN+Paidfe6pUKK4SlJrDg6iR84ru7Hjfa9KL3sXsUZBU5NE+K11zCRQ3bf44+F5/WdA==
X-Received: by 2002:a17:903:1212:b0:295:f47:75cb with SMTP id
 d9443c01a7336-29b6becc173mr178453405ad.23.1764094973704; 
 Tue, 25 Nov 2025 10:22:53 -0800 (PST)
Received: from [192.168.0.4] (174-21-76-60.tukw.qwest.net. [174.21.76.60])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-bd760ac62ecsm17264015a12.26.2025.11.25.10.22.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Nov 2025 10:22:53 -0800 (PST)
Message-ID: <ff72dcee-43c4-4a43-bd4b-063870f0f6af@linaro.org>
Date: Tue, 25 Nov 2025 10:22:51 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/4] ui/chardev patches
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
References: <20251125141726.1755276-1-marcandre.lureau@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251125141726.1755276-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

On 11/25/25 06:17, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> The following changes since commit de074358e99b8eb5076d3efa267e44c292c90e3e:
> 
>    Merge tag 'pull-target-arm-20251124' of https://gitlab.com/pm215/qemu into staging (2025-11-24 09:03:12 -0800)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/marcandre.lureau/qemu.git tags/fix-pull-request
> 
> for you to fetch changes up to 4c1646e23f761e3dc6d88c8995f13be8f668a012:
> 
>    ui/vnc: Fix qemu abort when query vnc info (2025-11-25 18:03:13 +0400)
> 
> ----------------------------------------------------------------
> ui/chardev fixes for v10.2
> 
> ----------------------------------------------------------------
> 
> AlanoSong@163.com (1):
>    ui/vnc: Fix qemu abort when query vnc info
> 
> Marc-André Lureau (1):
>    ui/vdagent: fix windows agent regression
> 
> Philippe Mathieu-Daudé (1):
>    chardev/char-pty: Do not ignore chr_write() failures
> 
> Vladimir Sementsov-Ogievskiy (1):
>    chardev/char-file: fix failure path
> 
>   chardev/char-file.c |  4 +++-
>   chardev/char-pty.c  |  2 +-
>   ui/vdagent.c        | 20 ++++++++++++++------
>   ui/vnc.c            |  9 ++++++---
>   4 files changed, 24 insertions(+), 11 deletions(-)
> 


Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/10.2 as appropriate.

r~

