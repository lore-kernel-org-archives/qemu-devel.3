Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F26FE7719A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 23:03:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tW1Yk-0002Ue-Re; Thu, 09 Jan 2025 18:03:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tW1Yh-0002UI-Qp
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 18:03:24 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tW1Yf-0000B4-EA
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 18:03:22 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-38a34e8410bso826272f8f.2
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 15:03:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736463799; x=1737068599; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fZPs+rbMSkui2cyodmstRuwdNu4QOG0EFEv+L6Ad0BE=;
 b=YrAf2edJTCir7ivI0Lh33SMLPZQEIV0KhcSe+59ENYgvz3Fc6OVho9XR+ya/PX8wnt
 plly9ypiT1bzEz0OzmOaXmE4VEDdgpaMhrCKcPWhukD2MJcFN4FvVQm8XUXHG7mXyQUe
 UVFBS61C/FgOwm+HTf0V8GjkmdGM+s7lBWkxU3v48W12sE7gZNcMSC/qgMsofvswVbfp
 FAjtDobSF3etIerj+Py+gkhbZAegiL9wEIghAV279OKrf9ZRjA+5M+BLWKadbvbNJcc8
 v7aW4Ah41Iu1BG9nqZ75tmyr8y8PgobxLbXrAkDlDZn8e52uSk7Tse4XixCSU7lDBDsM
 t+zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736463799; x=1737068599;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fZPs+rbMSkui2cyodmstRuwdNu4QOG0EFEv+L6Ad0BE=;
 b=jh2e4jWI5FswqJ/lpk92R/YXlc82BDPgNpUakbaBp4XcvaOULE9p9Hc4T6BouNnIiy
 mY4FHtyEwtN9N73DMzler2swrrDh5tdptNm8Ffhslu5aEfFRxYqccYVq5583jYZIJqDB
 r11kpJxY6ybuqP5tvz8KhWnqRxT8jEbMcZL88U2q5Ig/ochhJYlHx6IMYyGYLoXDLQX/
 3rqvXOzhtbWz4i7eK9iwjjVmeEmUKNelJP5DXiVRGsxgHA2pN8Q5gA42Rx8QJTuSQXwN
 O5zzl7HcRcwVEj2eI44eo+kf5sYUgmaRis1Bq94HeWQJ9BFq1Qln6uKHXf8RvSjV/M0M
 Hi1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVKkNz2gjj08iW+evIlWYuMEPwX3bZePBnOqzuceGG1h54dyko/UiQT3VE1nbj7nk/4wvGvzfZyU1r+@nongnu.org
X-Gm-Message-State: AOJu0YztjuhhLfemZV2Vu3CktzXvQPT5UvOmh6qPCOEstQdyMfjDyW5M
 wdpFoVXwRdROoDZ7MD02nOD42EpQNrPxsQDPA0w216KN+EuCaRJIgrK0+Wf0QFdnP0TBCJhRR8P
 wWls=
X-Gm-Gg: ASbGnctwf/CwyOSOowoSoXSPDA5ubsQYdvYdrwCOBHeXplncJzVWLPaNaJm1z0F8OhE
 uuvci5Gx7eR6WZYZ2RgAIqAlucvu0JL1aFBPGjI7RAgPxhk+odZqPn2yhKOzHbOmq2aw+PG52Fp
 0xCd6O+4j7SQM8Ix2z0tcYf5c7URlQ8pAl17hhFaPoWoyKJHGHe5m2BDD0tbZusq9uDBtIu0bqT
 o42F/9j7XAfWLnX8fI/xOmaD6wvndFOTf3mQhkuxN+5UxnbQb609/EOI8q8cXmZczkdNJE70bvm
 cjZ28EIGQQdEY2dWdurnacr+D/8=
X-Google-Smtp-Source: AGHT+IE12V5OFZxLXOeSOnaoZdeGzNSUOF0clFegcfR7hRiMSO3Y1bXRdyosR7fv1oUqq5pLmVihbQ==
X-Received: by 2002:a5d:5f52:0:b0:385:fcfb:8d4f with SMTP id
 ffacd0b85a97d-38a872deb1amr9296529f8f.21.1736463799597; 
 Thu, 09 Jan 2025 15:03:19 -0800 (PST)
Received: from [192.168.1.74] (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e9e62126sm33776105e9.34.2025.01.09.15.03.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jan 2025 15:03:19 -0800 (PST)
Message-ID: <94021642-00c0-4072-a8f4-eb25c6583f84@linaro.org>
Date: Fri, 10 Jan 2025 00:03:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 45/81] tcg/tci: Provide TCG_TARGET_{s}extract_valid
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org
References: <20250107080112.1175095-1-richard.henderson@linaro.org>
 <20250107080112.1175095-46-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250107080112.1175095-46-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

On 7/1/25 09:00, Richard Henderson wrote:
> Trivially mirrors TCG_TARGET_HAS_{s}extract_*.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/tci/tcg-target-has.h | 3 +++
>   1 file changed, 3 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


