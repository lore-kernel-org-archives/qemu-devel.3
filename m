Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82D06CA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 16:47:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usOgi-0003Lr-RG; Sat, 30 Aug 2025 12:44:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urkM2-0005zV-0Q
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 17:40:22 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urkLw-0002gL-82
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 17:40:21 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-b4c72e4f1b6so503993a12.1
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 14:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756417214; x=1757022014; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ay2n/ErcuY46MCZAy0IA0tKtQOTzAXi63Q447dJ5KP0=;
 b=mmM99PAsPRtzXtKwZER1mwC6/V8uh99+ZBYcf3PN+lL0JY3qnU73vGffCBWYJgE2pk
 aaabS6OaU0bDlQz4vxsPKTrScKNQ2mr1De+qxMjm3F9Jhtk19aQWdXu7rp8waL7JGb18
 IupZfhZul2bRZvkBlQ4oddmFEc6+6DOkNBMIQQumWDYeEzPs1tod4NCxhhKw9D9EJeIo
 MVjH/Sc6TobeRzWZYxJiC+HhS+Mb+OvCkiI8Dxq07vEdBUbKQz2SJd/ura/RiXKlRh1z
 yfSXbF1BnRpovI9ExaRlZTwxMI6tiSncebibBGCjIw2DADnp0BQvKlhyMgeO+aX/zudv
 GYRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756417214; x=1757022014;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ay2n/ErcuY46MCZAy0IA0tKtQOTzAXi63Q447dJ5KP0=;
 b=dkWazJ+eylqp4IOXCy5wvCs9+qwgK4hjE7R9noLhrNbkoKkr2dooyUc9HpmtSRuja9
 g6WkYRaRNwkGvnDeDOhKJUbl1bY+GlwBzJFF1YO66IfZFTyD7AGLp+i0OQEXUyTlVklk
 WSmnh1ry1+zVgXX45MqJ2n2iC2nV+hmoXRP3THGuYQsPW6fLE+kJ5NSPN25rXXma2IZ6
 4ivjigywhPMH2hgMDVXXwn1SOAT/5Mjh5qEsCIu+qTAJ23madoiuXS5Wa8Nh0pJNNM3k
 55cAAll5MdBnIKTHRfefHsG7ulKGjKf3/r/iVDzY++Te0CwQOJGdxeN6QcBSbzmRqx9j
 2n2g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWcX9bjMuzyrBPBCnO/r+HRT0GQnxiRv8WNBYLAAIR1N9Tv8QiBSwM8a6xYT7A1m1KwXmOxSxQGoBvp@nongnu.org
X-Gm-Message-State: AOJu0YxCqFVAu4pUAdximvJwwC+lWlvzxq3VfsZW/sFsm7m4JeOKVlj2
 bLTcaNP+7RMzyH7gi5z97mEQrzGOS90CMI9Is3Bi5BPegUCmfT6KLjnJdwa2C9gTuq0=
X-Gm-Gg: ASbGnctUC8pWVz72SlXmxyImp5xw6s+whm5e8SpJOM/boWQ24icoJGhepJZHeIwJMT6
 +8/XOB90ypwt5+D14v8ToTin8JYwa8REGk3qehBFeO4wGbMxIgSw6bUegj6sM5VQUJL67XE75Hi
 XMriyc9qfNUh7bp9/W1AOtwVBVh0139mHEk9lnqDPK7TfoliC+zGkXnWgAFr13JwpuJQTPrpWWR
 7RM/4bVCfgwyTwQDTGgMrv4JgIw6uyj7K1AC1igucYjmuLevKoYIZkmxeJ2txKbYKld/hmGM61v
 wseaIfhUO92X2Qr0h83VM1UhmwI2qMPLZdCS/TBC5GO8cehhc+LehwGxFkdgXyIa2kdxK4Zq1IM
 WjTMXBBw9hoAPVc2fDT9BIYNAmuybvibiQo4d
X-Google-Smtp-Source: AGHT+IGJrx9+YhOKjiYQghrRQ/wt0yyvuVmZ2/iLa7x1aYep/YelULCkXIF3PvDNGm2/j+Q15xM0/A==
X-Received: by 2002:a17:903:22d1:b0:240:86fa:a058 with SMTP id
 d9443c01a7336-248753a24c4mr148365365ad.7.1756417213862; 
 Thu, 28 Aug 2025 14:40:13 -0700 (PDT)
Received: from [192.168.0.195] ([144.6.121.55])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-249065ad59fsm4834865ad.123.2025.08.28.14.40.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Aug 2025 14:40:13 -0700 (PDT)
Message-ID: <a86dfb54-35c5-48d9-b8e7-e4a5a8f857aa@linaro.org>
Date: Fri, 29 Aug 2025 07:40:06 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user: Drop deprecated -p option
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 Laurent Vivier <laurent@vivier.eu>
References: <20250828162012.3307647-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250828162012.3307647-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x535.google.com
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

On 8/29/25 02:20, Peter Maydell wrote:
> The user-mode '-p' option has been deprecated since 9.0 and
> doesn't do anything except emit a warning. We are well past
> our minimum deprecation period, so drop the option.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   docs/about/deprecated.rst       | 10 ----------
>   docs/about/removed-features.rst |  8 ++++++++
>   bsd-user/main.c                 |  8 --------
>   linux-user/main.c               | 12 ------------
>   4 files changed, 8 insertions(+), 30 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

