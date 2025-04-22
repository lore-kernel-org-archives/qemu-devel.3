Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33DDEC369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 06:54:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u77Vo-0001UG-MN; Tue, 22 Apr 2025 02:53:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u77Vm-0001Sg-80
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 02:53:42 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u77Vi-0000cf-TC
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 02:53:41 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-39149bccb69so1602906f8f.2
 for <qemu-devel@nongnu.org>; Mon, 21 Apr 2025 23:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745304816; x=1745909616; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=p8/DFEQVigL7bEPSBBfEB+aegBcmSUE0EBD6KX0VzE0=;
 b=Z4C1uU44ySAElOucMnRNgu0V7LK/ULpeYM3gPOy80htxngb6rLfBn4l+afJBjT3uTW
 fYYtxYLX9FvZibuoq+j4lxEl93YM2fwvXFtJNyUDRSSlKnDHZcbbKZDbH3R4Ygcm5/6u
 Ohw/febMMYk7x5SnjgyAUiJrqE7Sw2GjePryqw1lSC5USAt5HXNJD6u9+Qw4uNoNGDrn
 BDJZ8A3PqAFysnHi2xOFzhbSpW7uLJXKU1oWw+Tslk/8C/7x2361PkN41ND1Wth/TSKc
 8yqBCWj9pDTRGSq03hq56QYHMIKNLMGCTkQpvZ+TNlmIY+xBGviS5ovfNex2rEfaFg8m
 ZlHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745304816; x=1745909616;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=p8/DFEQVigL7bEPSBBfEB+aegBcmSUE0EBD6KX0VzE0=;
 b=g9791/cVpr0wQYJNsfTVeDCSB+g05argHkHl9aeexDUCxkMJrx5geR9BY4g/onplb8
 qVPqqLZNgpA2WFR16Aq83CoOus1inhQ7k6dek0uxM7tVgNFTogY4GqgcRoIYA5OpX6kx
 0ZjrOfFdPsIXHtadzeYLG7N4ungQFUB8Kskm8DrG3Y7V6snAdTlGNjat3bo9t3A8f4Ls
 WbOrLjR9zUn2ucABM9z75kDnmbVDMyoJ6S6BiH/FjAGvn2fY+8rM7yaihbjowDXxEEDG
 pQ6CANZ9qwEH7QB2X8WrcIolAzRi565/yCo7BgHdpgqiNhv/kdPJQXuHScdHrF0bHuMh
 XEBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpp8Q3Qg+7E06Uzg7KgExr/E+f/GAkDeTXKY/bPXcK46GAYcpwP5a6ke7kvCTFueXMLiiI1Fq7oT1l@nongnu.org
X-Gm-Message-State: AOJu0Yy6TqSsgfCdhKuH3a+DSYvqynrS26JSxDCnaJr1biab8S6erlR/
 /S0Klich9XvLnAYcmxUezyzCEjRZaJEhpM8WSfylaH+ufrooWCT+hYt551w1Mc8=
X-Gm-Gg: ASbGncuKLG0pKYYshaZES08ENxX9sjlVnvEt9fXNv0eVTSSMk+Gil400fj5RUV+xQHQ
 9I4hlE27E8oCZqkuGyK4zCdfm0YYV4AaK9A+r3HHX95MoXfXKUm6OntkQeLy4y3ZhuhHV1ZzKZk
 o+vPwxlkaygi7zM4FCieMFDnz2lKa6XDUg+b/O4x49cDcow2cKqNp5HtBEhpynEeob/cbdP3K0x
 hYZtd5ZkfD6cqvHmDJLOj4340wlsYvX/k5SrX/AsND09hRd0jzkvVb6kNYwHz013blpOvLA7Tyr
 j2uZb/HRRbVbabejh/BOsNasjHfUHzhIWlsjScMc8EYn2t/4qnJpMRkBVYIAXeJjtHfgZNd9Lsz
 H8aSw/Tld
X-Google-Smtp-Source: AGHT+IFHm4z4XLQFoFlL3LAnRZ+9+Qxccq+e4FR3FlQ0PcvclWNi0JaweXe1qi87hHe1hfJchphRBg==
X-Received: by 2002:a05:6000:188e:b0:39c:1258:7e1a with SMTP id
 ffacd0b85a97d-39efbb0c199mr10113743f8f.59.1745304816534; 
 Mon, 21 Apr 2025 23:53:36 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4406d5acca9sm161588715e9.12.2025.04.21.23.53.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Apr 2025 23:53:35 -0700 (PDT)
Message-ID: <13e4270b-0028-486f-a0c6-c053f0ffd197@linaro.org>
Date: Tue, 22 Apr 2025 08:53:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 15/20] Disable options unsupported on Emscripten
To: Kohei Tokunaga <ktokunaga.mail@gmail.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour
 <ma.mandourr@gmail.com>, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Pavel Pisa <pisa@cmp.felk.cvut.cz>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Vikram Garhwal <vikram.garhwal@bytedance.com>,
 Jason Wang <jasowang@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-block@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org
References: <cover.1745295397.git.ktokunaga.mail@gmail.com>
 <047b22618137ad1fa0abbfa061726ba08605c4d9.1745295397.git.ktokunaga.mail@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <047b22618137ad1fa0abbfa061726ba08605c4d9.1745295397.git.ktokunaga.mail@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 22/4/25 07:27, Kohei Tokunaga wrote:
> Daemonizing and run-with aren't supported on Emscripten so disable these
> flags.
> 
> Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
> ---
>   qemu-options.hx | 4 ++--
>   system/vl.c     | 4 ++--
>   2 files changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


