Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0E17ECD9BF
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 02:57:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voC1i-0005A2-Da; Thu, 05 Feb 2026 21:56:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1voC1g-00059r-Uh
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 21:56:56 -0500
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1voC1e-0006cX-LE
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 21:56:56 -0500
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-34c868b197eso1205893a91.2
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 18:56:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770346613; x=1770951413; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1ppvAZhEFrgFsUzJHqgMf3NCM0+FYWWmKJC7LF4CeuY=;
 b=DMr6cimjN8EPESIXTMSmSr4JoARVegS6RQ2mqoClDZw63hvr1gWNUZ/2rPsHgRRoSy
 84ME7IwQQlCdanWhm9CiK+BcWNFUkZUHqJXBEsywie7bgEEAgZu8AoeqKhVBwudSr4m8
 w+CILhXICiOeaUeRukuSz7s+Yo//qMMreBTqbxkaOQvXt8UBDTYWYjMI03yamlADd50w
 du3ZkICyrkY5Za4hAreX4G70qFYMmja5FVxeYICJHBTh2r00OC8Dirig7Ho7FhH7zgrZ
 XIB4XjeTZ4XMpHhe0JaSQuAYNIhVdWk6d3z+D3m3Ss/KNLSO8LAQ/P0C3YjZabELkviL
 T3yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770346613; x=1770951413;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1ppvAZhEFrgFsUzJHqgMf3NCM0+FYWWmKJC7LF4CeuY=;
 b=knkR65M4dYprWdlPRn03nMY/ubRUzOWFVIT+7FMie/U0aEpICCIIGQwywK2c8rNnU1
 SSGV7Bl3CVe2HAEeF5nnhGDLzOQX8g7kGl4KCedjprzAlWX7TELks9CFNQUx9TuorCnE
 p0PskmaI6C4o/Lb9AYn/a40MztNaOxnaoOFE3Et0hc78iLmL71bq9uHGUuVcTGkxoUY7
 n5Z+6On7EbfV4UNxjPQ+UL6wpF5VMSqBiZ3rocwf8dccAdfiD+WVI/asFNB4Cw8/QbJ0
 SmAUDrQRApm/PdO8yeN0aygGNA9a+w5VeFexTs+PkLCZlXxWskGoK3tQQw8HMZX3lJfd
 8WkQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDcck1WhQpl5DQAfO2rQM7pHBNzGFCa6qE+URFkfsKi0Nz17g2qFobzdH1VDRCeY3TmlqgGm6AtBg7@nongnu.org
X-Gm-Message-State: AOJu0Yygn7yq50YdfSH+j+1++woDTgxwZeaIq7qxLCN0UO+/TJ+rAWrQ
 ocA7/zR/U4p06CR3KSrlNpyJhT8IMmU+WHYVCG5l7l5JkSe7uES0ASTJan4CD9Mb3Q4=
X-Gm-Gg: AZuq6aKMn12T/hcLWkB1w7WcjK2w0PvB5pjx1n+/1u6o+BfUhwi7X4Qmkhx346t//2r
 2Z6wlLSwZ4XsAAQGebegDabXm7oSUlUnnDY6yKoebQ/uNeKRMNdkbyB9Uer6sKCAzpZGoPtbdcl
 jLPRD5fYrftFTWCEVdaPpQp+ZWi0FFIQ4nYqLhyXJRrBo+gX6QSYS2eK6FFphigh/ZbkBm/wy0o
 vkiIhrERe74pyORJ7ztaL/X34ccSgGvSQ9vXlSmTVvxIryoQQkOvKK8zf4ielyZ8lUe8HdUB7Ox
 mXYPpGgkjrwy1DcV5QbzLfkWY7CaOy1w+SKDnbz3Er37aS9WBa0+0o6XfISxAt0WiGFNoOl4Tsa
 Y2eA/UvKQiucO2gn3pJqXO/+cCSrl+hUEBupctJLPC1PmBFVqkT3g/LjYk3P1dKU9LAX2kcD6ZS
 wDcpY3vXmFlOPXQ5Xaoiqq4Cx8fG2mHo0zFrKIY3NTXBlBB0e5dtdTZeXoaDcCJaaw7ccyrJ4qi
 Q0uxXD571tgN8tX5WlnObR4OmUzBD97C+lTwGI39H8=
X-Received: by 2002:a17:90b:4a83:b0:353:41e:1f51 with SMTP id
 98e67ed59e1d1-354b3ce907bmr861590a91.32.1770346612914; 
 Thu, 05 Feb 2026 18:56:52 -0800 (PST)
Received: from ?IPV6:2401:d002:dc0f:2100:1ced:e57b:71bf:567a?
 (bg30dhzpdc341w7g29yn.ip6.superloop.au.
 [2401:d002:dc0f:2100:1ced:e57b:71bf:567a])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-354b2253c70sm914235a91.17.2026.02.05.18.56.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Feb 2026 18:56:52 -0800 (PST)
Message-ID: <56609d1e-4d71-41cb-bbcc-2cea4e8544c3@linaro.org>
Date: Fri, 6 Feb 2026 12:56:46 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/24] bsd-user: Add do_bsd_quotactl, do_bsd_reboot and
 do_bsd_getdtablesize
To: Warner Losh <imp@bsdimp.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>, Stacey Son <sson@FreeBSD.org>
References: <20260205-bsd-user-claude-v1-0-8d8ff0035372@bsdimp.com>
 <20260205-bsd-user-claude-v1-14-8d8ff0035372@bsdimp.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260205-bsd-user-claude-v1-14-8d8ff0035372@bsdimp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
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
> Add some trivial misc system calls: stub implementations for quotactl(2)
> and reboot(2) syscall; a trivial do_bsd_getdtablesize that calls
> getdtablesize(2).
> 
> Signed-off-by: Stacey Son <sson@FreeBSD.org>
> Signed-off-by: Warner Losh <imp@bsdimp.com>
> ---
>   bsd-user/bsd-misc.h | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 52 insertions(+)
> 
> diff --git a/bsd-user/bsd-misc.h b/bsd-user/bsd-misc.h
> new file mode 100644
> index 0000000000..d81b4fbaef
> --- /dev/null
> +++ b/bsd-user/bsd-misc.h
> @@ -0,0 +1,52 @@
> +/*
> + *  miscellaneous BSD system call shims
> + *
> + *  Copyright (c) 2013 Stacey D. Son
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License as published by
> + *  the Free Software Foundation; either version 2 of the License, or
> + *  (at your option) any later version.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License
> + *  along with this program; if not, see <http://www.gnu.org/licenses/>.
> + */

We now want SPDX-License-Identifier on all new files, and to *not* include the 
boilerplate.  Should be diagnosed by checkpatch.pl now too.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

