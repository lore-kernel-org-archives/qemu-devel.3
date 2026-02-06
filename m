Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA826ECD9BF
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 03:35:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voCcl-0004eG-Qd; Thu, 05 Feb 2026 22:35:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1voCcj-0004ds-Uk
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 22:35:14 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1voCci-00051p-Bp
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 22:35:13 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2a9296b3926so13015765ad.1
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 19:35:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770348910; x=1770953710; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=y+pB7M6C+Pi+dUxO5wPh0mjCgoVZ0PsV0VZ+zshKNtI=;
 b=jNEq5PlKx+xqpdxi1V3pN43s0gtROjEQ+yeSc+j+HJy+68OWacHvZpLcmSGUYlLCUW
 Ce0jqHttqYPGE5La4Y5qAFWNyMeljvS3Z4MWihucR+XnMant71kOZgMeFWP7t9DdWmAF
 EmpuXsm8EtfYshCQrpDtM2ZlNJI3jBQJDugkGDZ83wkju8CBemtQUUv953p3jgKIHW1J
 XQZ9WxZ/LsiTLdgTnf521agnO/DCzDM49EO5sK/GtUL97H8/WweqLmtv7nAO5qCWM7uj
 1E3ABB34qjxZckcSlCJ0tGRGiiiVD+Tv/ZJSrxHCPACoiRH8yasrwhkmDSkRL3TklJnx
 +f4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770348910; x=1770953710;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=y+pB7M6C+Pi+dUxO5wPh0mjCgoVZ0PsV0VZ+zshKNtI=;
 b=ccoHauy2F8PfSs/OM2bYaDYTVMMwn4TGta6ePqq9vInCxXxxl6va01KxXPOLml+E5z
 6mr1/ml+/sSd/t9Qo5IkB325N0W/89mC8CmMfd3/6ZGZIY48qOFo/h3iDwuJh2QavcJB
 i7zl1N2Pf+O9b6CNQFvmH9aSaqqjwXLE8BqFPMieGdkzAvSIiBFdTvtaH6TgDjHXCY9a
 MUVhsI0xzL2rI9uYlQK75PEneVvcNp7f3mZ1foa1h0kXaZSQHiYeSKMKsjXcUOVIdoRM
 jbaScYx3E2PKa6TPrlUacF5uX94ojV8K2XFRDN0gM7ogWzSn+MGPIm4pRo7FbhFrxgg5
 92qA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWuWWumclVTOGPl/j9SiquFJvEZyYjjjkSYd/5sDbtnW/DonSjfUe+HiTbMOZvFEQnPcRgFMg6Lv36F@nongnu.org
X-Gm-Message-State: AOJu0YwY7m3WDCTAMPgRCc0xD3gEa37h5wHV/3sxjC8SoctuG1nyiAHR
 BNNtHDfliDHGs7TPDDmiPLM3t+T75hm4gWnuJQUVJo0hXjRx6acVR/9W5ePINZTF4pcDAYYPoov
 AQb1gECaIEw==
X-Gm-Gg: AZuq6aIjwtuxMhPmvI+nGouwx948e4nK3vMWMBsQMxq0G+io3T5GOdV/yKD1ptCEfRe
 SCyusIQPP5joONC/Xnz5xKivIq6oWTC1cSJBO52MaJBVvqg1OBjv1oUDWv5deP6M9oZZ/hCky3U
 wgcoJb+mV921JdZ8IdCAKZktgXxPjYdbh6DGlBVs/d41oR9K3iPDzJF+QWDCT9UER2jwRYdzzK6
 P3LsPfA5p1gYuxYXxC9q2IEO86iZwgtioWcKycefjwrMyDRq8EmHIWezG3/aAWvtWRcfa0eN6oZ
 WWUNBfKR/+/bYFQ0EN+jF126GVg97S206oktiz6GmgMLV0Y1xBC/fa1nQqTu5aW9Tq5FDQj0+oe
 +xFcqosBWt4w18wg+vkQffKB3//z3bAOFxTlhm0scY1pBQhPV5oCBbd3laco8RqxG3/U27qp3pw
 R6tIRqJKPAUt3frjw9wK8m/EGREg6amoxgGh/AdEjG5mlzY8o2hY8npvSvPHjxcqzTj7SuMXr4r
 aVF+ztmzU5rp7i9jZRy3bIhL/94gbenSGb0JioknbQ=
X-Received: by 2002:a17:903:1b04:b0:2a0:d05c:7de3 with SMTP id
 d9443c01a7336-2a9516369f8mr14589665ad.15.1770348910478; 
 Thu, 05 Feb 2026 19:35:10 -0800 (PST)
Received: from ?IPV6:2401:d002:dc0f:2100:1ced:e57b:71bf:567a?
 (bg30dhzpdc341w7g29yn.ip6.superloop.au.
 [2401:d002:dc0f:2100:1ced:e57b:71bf:567a])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-824418b31c2sm726852b3a.50.2026.02.05.19.35.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Feb 2026 19:35:09 -0800 (PST)
Message-ID: <cad94913-b719-4c78-bc5d-073f454a8510@linaro.org>
Date: Fri, 6 Feb 2026 13:35:03 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 23/24] bsd-user: Add System V message queue syscalls
To: Warner Losh <imp@bsdimp.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>, Stacey Son <sson@FreeBSD.org>
References: <20260205-bsd-user-claude-v1-0-8d8ff0035372@bsdimp.com>
 <20260205-bsd-user-claude-v1-23-8d8ff0035372@bsdimp.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260205-bsd-user-claude-v1-23-8d8ff0035372@bsdimp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

On 2/6/26 03:26, Warner Losh wrote:
> From: Stacey Son <sson@FreeBSD.org>
> 
> Connect the System V IPC message queue syscalls:
> - msgctl(2): Message queue control
> - msgget(2): Get message queue identifier
> - msgsnd(2): Send message to queue
> - msgrcv(2): Receive message from queue
> 
> Signed-off-by: Stacey Son <sson@FreeBSD.org>
> Signed-off-by: Warner Losh <imp@bsdimp.com>
> ---
>   bsd-user/freebsd/os-syscall.c | 20 ++++++++++++++++++++
>   1 file changed, 20 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

