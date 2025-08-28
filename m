Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46B7BCA0FF2
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 06:12:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urVrR-00068A-AO; Thu, 28 Aug 2025 02:11:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1urVrP-00065k-F5
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 02:11:47 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1urVrN-0002nE-Ha
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 02:11:46 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3c79f0a5c5fso449408f8f.1
 for <qemu-devel@nongnu.org>; Wed, 27 Aug 2025 23:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756361503; x=1756966303; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FG2v3dyTw+thImh3QoOsHjYaksgpyuZ9jsr4lassa6Q=;
 b=fbhHY4WRr7tBocmkC7Ad3kdBMfhHi82/33d4oBWJm43ERuAL9E/lXLBq+4w0AOvjRL
 bnezT/tJzpE2h8YHzwWTi5jD7VdNihN8oN33RYIXcFqLSzkIrHbhWTJ5Df/g/y9vtiW4
 5rpJkwUdZqMgHmtgY09nvbOTb/wMt69MxUVKJ4PNBjleo7u6yjqYFyBK6urE5O06CoMl
 YuK45TjXkC9XfRQf8HkOq3VBs8KnGteP0uytwTCY+fwCb6VPoFBioM9+IdD8tuQslxSF
 PveaK8IbRnTgep0eLCBy68j1pWdbLySGmkaHHNWPOSulHDLZmHBow1wPl0yPpGfEFNkm
 kMaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756361503; x=1756966303;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FG2v3dyTw+thImh3QoOsHjYaksgpyuZ9jsr4lassa6Q=;
 b=iSIIAC6I+5I4RdD0rUZT/JNqWv1/WrwSRvDPgW4/HdibdDLB2lMsKVLowRv3iIrIYf
 wxaZ68BljyeYGa3ZWrNWSCtyb3vC4J8Ml4oN9nJeX//2ZkbAuqRLswnpWFKzqxq2zaez
 LMsX4j+hTVaahNJt2ehooNY/q18qZ+dLtWjvmx/72YRzMak0GjH6HWI7gQDfQQSl7BO9
 d1Hel/VDo0t+BN5R6HrHCDFrAcyGlx7+ZmQipt+Y6yx43txVbeTrENFdPd57arT0MndK
 dyum7ZE3eQS1dphV2fgjdMrl9uxu4lZuUXTAqnrILXqPszoPySNVG13kwg7Fhj9pET1l
 evzw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWbJYtNNj1b9wLttqatTXANUEct8RBaeiL32gswy8ARHvxthc6V26M/h2qvYAolFOuYjkuo15JKOEZI@nongnu.org
X-Gm-Message-State: AOJu0Yy5SKuXE0kREFb/XbaK9GUij+y8+LLEfdue547ql9ldbKqEf3BF
 Y39DTBykcBYeAwfvjzU5S6RpFp73iMDexU0DIE7+9LTktx5xztH35UMWdgBJa7XsSy/AoxGDZoo
 Daav78FY=
X-Gm-Gg: ASbGncv+Rk1Eeiri5oKkCwoUCm+ISZlOwO/rf2eOmsp5FciAAZA5h2Udsx+1ArNMjHj
 uhTpYVBH8I3Es06WLU3F/qOGG2qcemim0ayrVnJR6iYTZIEGkoZcIR1ANxNd4azrzQ+XTB7k/CY
 Su37HFUDHIGD+6qzh6tSRGd+9240/GdcW4CwX2+b0N1Qz9F2gPKua8e8P7Mday35eAB1szLmG3F
 sHmYt0Wa349jN9EDQjL50fa7j3p5gDP37/lxRnUtHWwxNO6XNwzqhiRLNc0Iwl50xWxBMH3uFay
 lhMpzfuXRvQxZ8Elz4Zvw4iGfabSrFdtq+VcEfevyr57vIBfe7rQIteDEizuPjWkno+0qeMXVO6
 1OEU1HZnwFy3e99Yb6NdRzU43TTx8g2nKoFmuiT7ZxTT4fxn18Tr5+5wRoGkVjZGj1RLOpXrW1V
 yC
X-Google-Smtp-Source: AGHT+IH1DFB6CtPs5szeSJZohQjaYhixZIh6rtp2oTMlSEIq+hEAuIqaD/to/EsnJq61dSH60B8l3A==
X-Received: by 2002:a5d:64e6:0:b0:3cb:2fbb:cbef with SMTP id
 ffacd0b85a97d-3cb2fbbd09cmr6945014f8f.12.1756361502671; 
 Wed, 27 Aug 2025 23:11:42 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c70ea81d38sm24030112f8f.17.2025.08.27.23.11.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Aug 2025 23:11:42 -0700 (PDT)
Message-ID: <49755333-5344-4a01-9806-eadcfbab12a1@linaro.org>
Date: Thu, 28 Aug 2025 08:11:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user: do not print IP socket options by default
To: =?UTF-8?Q?=C5=81ukasz_Stelmach?= <l.stelmach@samsung.com>,
 qemu-devel@nongnu.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
References: <CGME20250827095429eucas1p2b685855e7dd423a83b039824e723c6ee@eucas1p2.samsung.com>
 <20250827095412.2348821-1-l.stelmach@samsung.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250827095412.2348821-1-l.stelmach@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

On 27/8/25 11:54, Łukasz Stelmach wrote:
> IP protocols should not be printed unless the socket is an IPv4 or
> IPv6 one. Current arrangement erroneously prints IPPROTO_IP for Unix
> domain sockets.
> 
> Signed-off-by: Łukasz Stelmach <l.stelmach@samsung.com>
> ---
>   linux-user/strace.c | 36 ++++++++++++++++++++----------------
>   1 file changed, 20 insertions(+), 16 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


