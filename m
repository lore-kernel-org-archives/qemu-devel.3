Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F19D8CCA464
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 08:06:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHcwt-0002fr-5j; Fri, 16 Oct 2026 04:05:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xHcwr-0002fX-F4
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 04:05:54 -0400
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xHcwp-0005lT-QC
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 04:05:53 -0400
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-8198a3a54d7so854713a34.1
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 01:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792137947; x=1792742747; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Yl2o6oH9pgHW5w4EQt8urPqJ5vJjKlljPMIDWG8380M=;
 b=GF3VqMtreJEGsvO30eRLbdV7/PBnLO0GRpPR24ig+Htl9oi+1BfGPXNjgGaU4MvnZf
 T9j1dZoRD8K8AaJayhl6Al6qfGvjS9HUV+R/GWhihgzDRAlTHzLcjmHQTmn02otdpdu9
 pNedGL9jhICU81Yh5fIRdNIMScMhOl0czyMYW6QEbBD37wrwjjVfLj7lO9ncc9VCqDEh
 XGDh9T+EUO5WDbwlkGzipSPdZaPXPXxAbThUlRhP/W01XQDmo5W0zK7UwXlTQJifXMkC
 OQfMEuc6B6AHyneJy9DgdmYLnQvtB7wEH5UozSix3HRuR5REVDoY6MGRLwtFJtBMi/l9
 +Q3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792137947; x=1792742747;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Yl2o6oH9pgHW5w4EQt8urPqJ5vJjKlljPMIDWG8380M=;
 b=2K+y22mDF4tproU8kJAw6i543RwjzoZKBoiqifA7jHZ5vpUD9Oatedy5UvRhFaJTRr
 VAfxf/wNOF9XOu1nso4f/n4ADISLmUDEVfKs4w2OnhFfkkvP8ew0Rfynj9qFbOnV0IY1
 8eHUbkjALjY29tIcsDc90aknsTqgCUy9JiAsUhS/9oC2lm7GYu4YhmCOuNANFc/sySlb
 USpWjEvuqz7tBHVbDrRDgtOMTcUP4kyvJJddck/kZUnV6zAuoWGfZbBY+A5UJvHxmPWW
 jz+G9MU3qgA10Nk9NQ9QvjMLO0HAazaDGoopI4WOpb+wQrq0zTWWFb9BGDoy6OVp5MNO
 MzXA==
X-Forwarded-Encrypted: i=1;
 AKwUvBy+QNY9A0gvLc4BQDThZv3fzSh5g+5YP/bT4r406d0J8iF9Y2J3xynO5nMA7KbFbqLkMtn9s0eIRxs3@nongnu.org
X-Gm-Message-State: AFq9FYIyqgezIEGeB63QWvA671GuLTCLHEACVm7LeOD0KiTI4N+YFzRs
 LrMwzkSwsmTtp9zjnc9GZ5sp7ZOjkrJW2hf1Caz/mus+XCyBC3nnWPXWFJd28SAwKQ4=
X-Gm-Gg: AYBFou0ObNoijwqicdaLGP/hN4twAg3mWwnr/taRmDFn+0mhWvVVyTDFLvLIgfGD0TI
 4lIDQ9fdsgt+5O1lW9CnxfOGfMHbtnTjpDdSXeU/aSPV2Jxue+Yiy7KbnFZss8AwWwwC/IvM7Y4
 4SXamvBSslxqkeqad4nAP6HQbdrAXciHuOd/hbCWk8Nem2TaSKVzj87DS0POjpTIpXnRYytsvlB
 HeboQG5/FYK+5hJErJkl6HOt3lIT6+ukvl92i/339he0IcxQ4zmwfHT6QIeqhc7WXTuyZTbwcuv
 RB0Vjeqbqyh0BopZ0/SJOQR48MdEem2kA8Fndng2K9240z5mMdZCX/v7JMfkEgFznOr+2FZQs36
 xBBQKsXDZvAmHLFtNDA9zYmIN9vTkXhRx86VEclBr1FGo+a6Ao4BFtVw+GD6nAjdgSWZLSpvuNM
 zbbApErlPIyzThALXH3goE6CfGYKvfdqXT+InZeL4TUs8b5EjwObtw1jDVzm1agZyhb684z4EW6
 W8vQAN1F0gSHZCejbi+SmjdxegFxxxjY7vRuDzX
X-Received: by 2002:a05:6808:11c8:b0:4f1:a3ac:a637 with SMTP id
 5614622812f47-536f85181a7mr1561799b6e.27.1792137946834; 
 Fri, 16 Oct 2026 01:05:46 -0700 (PDT)
Received: from [10.233.235.227] ([172.56.182.215])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-5397b4ac6c6sm594423b6e.14.2026.10.16.01.05.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Oct 2026 01:05:46 -0700 (PDT)
Message-ID: <04a53751-2ca0-46db-a597-032d38a41388@linaro.org>
Date: Fri, 16 Oct 2026 10:05:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/9] hex queue
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org,
 peter.maydell@linaro.org
References: <20261015200306.1602540-1-brian.cain@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261015200306.1602540-1-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32f;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32f.google.com
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

On 10/15/26 22:02, Brian Cain wrote:
> The following changes since commit 7e8d3c7fc460fe7cd28a3e423d7466fa292bc269:
> 
>    Merge tag 'pull-aspeed-20261015' ofhttps://github.com/legoater/qemu into staging (2026-10-15 14:58:28 +0200)
> 
> are available in the Git repository at:
> 
>    https://github.com/qualcomm/qemu tags/pull-hex-20261015
> 
> for you to fetch changes up to 34c91feed0817d3aae6c6beddc9446ccd2f78602:
> 
>    tests/functional/hexagon: add MiniVM, lock tests (2026-10-15 13:01:32 -0700)
> 
> ----------------------------------------------------------------
> Hexagon: bugfixes + pcycle support

Applied, thanks.

r~

