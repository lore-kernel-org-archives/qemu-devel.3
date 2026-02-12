Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6ED2EE369E
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 15:51:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqYxe-0001UK-FQ; Thu, 12 Feb 2026 10:50:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vqYxc-0001Qr-4j
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 10:50:32 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vqYxa-000615-GN
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 10:50:31 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-482f454be5bso21022345e9.0
 for <qemu-devel@nongnu.org>; Thu, 12 Feb 2026 07:50:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770911429; x=1771516229; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lJ+PmxEhsOKLifTQZzcj06fuOboFrNOSSiEDVwsSnlo=;
 b=ejpGU3xPPIfeD/msatAX+5Jx1C4FrRoRldWgggAsdo+fGm3TKTeYfghWZJGvV/f+/W
 uOIn3ZbVFkfSN/UP+rNabe06QzuJMT00hSB2yjuG7r194wf0dk3XMVDPbMmmuzeYzBbf
 noaQVSYbZsOpJnnZ0t3pGrVgFPujyEG+BnvVFgQH8opzl2XN04ONkXPiDNNZ5Dp4w2YL
 A2zWerxryIvNgWFwCpwvnHtmgzGKb9FZVzrwUw+/N9uh7qM6RyaPRroZe9VoFTpui5M3
 Uoo/o6ukKkulE7B1f37Fs9wqe8r5uvctiE6VqBJMpdBxzhKig49RoT8jtRQB8bsNkTYG
 csPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770911429; x=1771516229;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lJ+PmxEhsOKLifTQZzcj06fuOboFrNOSSiEDVwsSnlo=;
 b=moSkeNdP7fTPKJ3sgyyILnVcKIAE6uPLDSvBMjqqf72wAs4gkNZBlN8T/qCyHnBT0N
 iRkaX5RbEIGtCXEIQwtnOKoCCPTw1+o8ZICixrbXY9SDcnB6+Gd/rmu7a44w9e763+h8
 qz8Y0bnTC4Zd+Jec7e3002N+aicB7pYDB81RXCO9aI3nl47cx0AWthpcGKpZdnwn5Omc
 kVcDjJbLJlfqqT4y0LwOQU3my6/dlkNcaVLVYl24op+oCWhpa+hsDQfQwZEKjzmV8Ojm
 KE55yHmgCzWwGn0kJJj4fb3CJ9mb/QSgaaBE6JF91yo3IrLQFq9Gp3AoIeY1qAnTFcq4
 /m7g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVICDi+PMCswGmpQbx8ad0DwHc3lPls4aL/jWzJMR3+KcWF4T1xjLrCVxP25eJZ8K+yJj5KUw8pZyFu@nongnu.org
X-Gm-Message-State: AOJu0YzIGC9uGEiUBw5Ie43cuz+CkX57MY75S5qxyOxWUxs7YHSnO70O
 1zF9D2Ymm5hqMYZ06cJw6IajsxfZ3kXfGq6yBrU/SQGOxoMWTcbNF4gqBcn4hBn3o75aYEIOVcn
 Y9UfJHk0=
X-Gm-Gg: AZuq6aIXHuqFdrHTStzixp0Qi+VNpiVTWs641QG3Q/lZPE2rPsyp+g27Gsrah4jX7IF
 GAwBB6nhjijIKxeO/QBmCWM4SnR8P5BIcBXvtxVaQQKLh2zOKiyTbUyxrySkeaz0mkIcRuNzcOe
 bxM1NuSuHQ23+lwRK/6+qtPvgXZcmsORQ02CQm81/olDttcFi57SlNXjAOlyI/qNIgjGFOdpD+b
 yhhLoUSKhCxdKVNDKNwmOeYGNlTXyyptmPiBvMu0aAhayR2870aA38W8GAxCTDN0PyWTcV0rGcu
 jPwmZ74UdrbFwJvMsAidFHlRyjCijmOg9HB6Jc1jA2ABLyU04gZ1J9CFP8bVNi5+09BXbiV6O8M
 zkoUtZol3z9M9RH4mD7YXUys8JoLrieWYFnNrJj40XunRpn66lS0FVY7JH2sLWhnqvCpka+agdV
 Aiozges+X8vwYETO9UrqqyM9CWWv+R8pZkuzZeBa4ZxFFeBfYTZOss9d933C4m0He74w==
X-Received: by 2002:a05:600c:a14:b0:47e:e97e:11aa with SMTP id
 5b1f17b1804b1-48365fdec4amr45712035e9.4.1770911428883; 
 Thu, 12 Feb 2026 07:50:28 -0800 (PST)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4834d930902sm176590905e9.15.2026.02.12.07.50.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Feb 2026 07:50:28 -0800 (PST)
Message-ID: <242d98a7-c567-4307-87cd-55db91329a51@linaro.org>
Date: Thu, 12 Feb 2026 16:50:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] net: mark struct tcp_header as QEMU_PACKED
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Jiri Pirko <jiri@resnulli.us>, Jason Wang <jasowang@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Patrick Venture <venture@google.com>
References: <20260212140917.1443253-1-peter.maydell@linaro.org>
 <20260212140917.1443253-6-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260212140917.1443253-6-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 12/2/26 15:09, Peter Maydell wrote:
> The eth_header is not actually guaranteed to be aligned.  We attempt
> to deal with this in some places such as net_checksum_calculate() by
> using lduw_be_p() and so on to access the fields, but this is not
> sufficient to be correct, because even accessing a byte member within
> a misaligned struct is undefined behaviour.  The clang sanitizer will
> emit an error like this if you run the sifive_u_mmc functional test
> with sanitizers enabled:
> 
> ../../net/checksum.c:144:24: runtime error: member access within misaligned address 0x619a74c32033 for type 'tcp_header' (aka 'struct tcp_header'), which requires 4 byte alignment
> 0x619a74c32033: note: pointer points here
>   0a  00 02 02 86 aa 00 16 52  c1 d3 70 00 00 00 00 a0  02 fa f0 00 00 00 00 02  04 05 b4 04 02 08 0a
>                ^
>      #0 0x619a6ba84794 in net_checksum_calculate /home/pm215/qemu/build/clang/../../net/checksum.c:144:24
>      #1 0x619a6b5940da in gem_transmit /home/pm215/qemu/build/clang/../../hw/net/cadence_gem.c:1386:21
>      #2 0x619a6b592141 in gem_write /home/pm215/qemu/build/clang/../../hw/net/cadence_gem.c:1650:13
> 
> Fix this by marking the tcp_header struct as QEMU_PACKED.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   include/net/eth.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

