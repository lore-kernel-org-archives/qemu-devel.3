Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B050E91297
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 03:28:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voCWA-00039J-EY; Thu, 05 Feb 2026 22:28:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1voCW9-00038v-8Q
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 22:28:25 -0500
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1voCW7-0003XV-N8
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 22:28:25 -0500
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-81f5381d168so1847371b3a.2
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 19:28:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770348502; x=1770953302; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9yYtGnX/CWNdZTGI03s9FtfddMn097cFw6gzNbDz+iE=;
 b=vjxxo3jMUVApG85lY/I8e4mT4bMXZKyWHEL1ia1TQte0gW3NalqfNPKUSJsiUo9mhV
 OS1raDJYLzsYfyBYf8dA72Q3Z6ij/rstdgqQ+dBpOCHdvyy30Z1MY2k7GuMAxjPwlX/D
 UDRw5+vghPnYib4758EoQQ0xNByYGxNRkY0FD2GBDBk5ElXnuYf57UGAeFBr1W1gXXvE
 RvLbAp6y+I499g37InrPJbfwH8exb3FNsdaoPcG5Z4ahH3mzFTn0a/jkqY2+o2qaTrb/
 uVFJO6Izusbq1A00hE202tbdPIMmVFRtn9F4TvAaLQtqnuVXwOcfLISazo5vcM41Ow+s
 rqDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770348502; x=1770953302;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9yYtGnX/CWNdZTGI03s9FtfddMn097cFw6gzNbDz+iE=;
 b=whxl+PJbf7cjXDkP5jsfpLBsRyGYMkk+iwveTWxXGlQMIAj9WQe02s39DSikJ+rSZZ
 yLBgCm9ylvj92BPYo/zUjPl0QMGngVuFKkBQlHF7NNd2yrnRqrXNbrta2PALHdLmiJpD
 HdPABP9gMoApgT9pBonyFHls9aawGaG43zd36e1JhoOe3EHBF8WfAQzcQ+xKuslGd+MC
 MyDvGRvXgTFKHE4GKPJUBoUj5I7IvlqMVYq8Wgbr/ujlTq9/2CAn3x5iwwr4fd1j3i0O
 8FN/qYvgrKU4lGCYvmbsbJjMJHbj0w4Yr6t57ZmcwCEYbRtlEthWNKDQu+WFr3IMP8K5
 P7Mg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYZqozg3S+kaK57ifey6a/lw2xoIelWbI9AnqrneJtxTatF3azuS9tHrUy2SPLJGWrIGCqPDO4Fhbn@nongnu.org
X-Gm-Message-State: AOJu0YxX1HLzWD5ZCLH/mNc0MnA1ulJOKrzDIbL4prMa5YW+QpNsrKum
 4XPjnjXk51x+v/jSZSsFlwzPsPbMpWuoVFnsXU1G8FiHOeA0eWLGb0Ga5uoWmgafW/g=
X-Gm-Gg: AZuq6aI3NguqopQYckpYGcETEcHeJ6/0w2TRR+Ge+7BUCkcE5TAn4893ZtpMZJNnrRC
 mzmNWp7EKJznUbp8y4f+L7Lj53zUbqnlxB2sNQOjZx6XZOSh93oG0gCOMUX0Ewr21YsMD0M6IOW
 DbAi2xLZ2DeimWBmlhqXfxGtqggybw7+29PAixCFPiZtnA/Qi9seqcw8YDLBD/QJK1b0IR7CzAE
 IyJGPV8TwztQzfLngKOpF7W7dScNsi6Fyl3ctTDhbFg7iEWYCCxuagaGznUB5cYvsSgbE8+Z8I/
 Z2X6Rp+juRmkGWEithMjF8eDIFd4jody1i3Gp1X6HW96EjiFVysxtUQ2G4ZnaIO7ddi6eVTUZqq
 nKEPD2E0wlAqD3Ka6ufKQ3nOdGy9PXDIWmk7e5yTJGsOjhK06DaUMf/DwLZWLDC1OPFIiJaTdHU
 tRj4eAjkA8grH1kFfHtxpWMrEfomnzRJhGp2U8o6jq85n9arixh3+xnHcv4IcJwaaJFicWTOM38
 kQUFj+IqP7xgdzge3fVL4kqxVONy1JL/TyRdQeWRGI=
X-Received: by 2002:a05:6a00:1a06:b0:81f:3c34:fa78 with SMTP id
 d2e1a72fcca58-824416350cbmr1144765b3a.25.1770348501948; 
 Thu, 05 Feb 2026 19:28:21 -0800 (PST)
Received: from ?IPV6:2401:d002:dc0f:2100:1ced:e57b:71bf:567a?
 (bg30dhzpdc341w7g29yn.ip6.superloop.au.
 [2401:d002:dc0f:2100:1ced:e57b:71bf:567a])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82441674f53sm685068b3a.1.2026.02.05.19.28.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Feb 2026 19:28:21 -0800 (PST)
Message-ID: <8a42b85a-9fa0-4053-a4d1-dd6c6d046c03@linaro.org>
Date: Fri, 6 Feb 2026 13:28:14 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 21/24] bsd-user: Add bsd-misc.c to build
To: Warner Losh <imp@bsdimp.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>, Stacey Son <sson@FreeBSD.org>
References: <20260205-bsd-user-claude-v1-0-8d8ff0035372@bsdimp.com>
 <20260205-bsd-user-claude-v1-21-8d8ff0035372@bsdimp.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260205-bsd-user-claude-v1-21-8d8ff0035372@bsdimp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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
> Build bsd-misc.c for routines to support System V IPC, UUID, quotactl,
> reboot and getdtablesize.
> 
> Signed-off-by: Stacey Son <sson@FreeBSD.org>
> Signed-off-by: Warner Losh <imp@bsdimp.com>
> ---
>   bsd-user/meson.build | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/bsd-user/meson.build b/bsd-user/meson.build
> index 37b7cd6de8..00428fc2f8 100644
> --- a/bsd-user/meson.build
> +++ b/bsd-user/meson.build
> @@ -8,6 +8,7 @@ common_user_inc += include_directories('include')
>   
>   bsd_user_ss.add(files(
>     'bsd-mem.c',
> +  'bsd-misc.c',
>     'bsd-proc.c',
>     'bsdload.c',
>     'elfload.c',
> 

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

