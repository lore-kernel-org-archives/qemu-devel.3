Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED0CFFF8875
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 04:49:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIJLL-0004GA-4u; Thu, 30 Apr 2026 00:49:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wIJLG-0004EG-32
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 00:49:38 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wIJLE-0000hL-CD
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 00:49:37 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-48a3e9862f0so2336995e9.1
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 21:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777524575; x=1778129375; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=720Bx1bKlVjFNst/T9lTike7WOGhI8gorlmW7itupxU=;
 b=K2MAed6XC7Z9buonn1HbtNzpW1mkWTOs8zFHWiB4L6AfzUKnAtWvnrh7l+WVUbIcpE
 XnKL1A/xBoOG/sV76NZtbm3oVbrgtQOy9CnNd6fVaR+AHPmAr7LrFkd2shl74x3PK37u
 Alw6idpJRgC7Qw0hjncQlebe5cwe9L9CJzY9eHwOcCXcMI3Lc/Berp8Fo21Aim0scikZ
 htoIGlPC+UkVML4D6y0P6iWzYeNxF6sISGFAih87L24d//ZtXGK3BbL9wxWk/XhPhe6p
 RteRmlykkT0sScpfsUDK0DZYcry6oU10i+eGHf12tQF46vVP1oGWQBUjNo0jIjT4gwey
 4rCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777524575; x=1778129375;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=720Bx1bKlVjFNst/T9lTike7WOGhI8gorlmW7itupxU=;
 b=BX30ohn8wm0Aq1hl1iQcjpdofS4tbSYZD8opbln0fyFc+50R1FO81oRnSLjOhXfoGH
 dx9r3v+vdZWzyVFjVAO9XFlS+gF1LaTvjQ74SXraszlam7NuYz8HU2oIGtdtHeNqqhmF
 JEfCv6iJq0OwqBFiBhwSGmaBgn1Z2BEwd8WS1LyEgWO6r2A1g9XeThx8EUdMAuvJ3AIC
 8UYIm3EL4hF99FQrxa2l0Jr3KS1g1bgI0jYTg61xTEPYb5F9ZoH3cSW0wkR05i+XEonk
 k2qFhq8MJrq2bq0gnKN0FKnoMpYKe+T9dvljW8dkSHR75qm6UdQBmf9EnCxoCCEqfCsR
 cWIQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+uWBN0vGVOaSSIwzbEr5xoWHmrzQdKc7yW45GijzLvAD+uyGGf2rJG80PdJfy+6CN8T79FhVuubFCn@nongnu.org
X-Gm-Message-State: AOJu0YzAzC2/pP5r09feC2FWd10/eVnhaNYQSYb+69/SNLoRonxfEL4M
 CRWrvPML5N60CIE+9TqW7op8DwF+de4SqOfqqBOBnMn+fDS9/MTabh3Lrv7ySnzDlz4=
X-Gm-Gg: AeBDieusoz3mOAUoQIED2NqpukxnDVAVA+4uKlQZO/tcjNhOUe6ZpJd/L4aneorzgky
 gXbiN03r+CllJ/uvaSdCcC+mTouZ7OsZ0AlyIa0IV2+WtQnsNihi0MZkSMdbkuCJxLFKLmA4n58
 up98V0ZeQEa8s3EJCgCyDSyGSXUphu1EFZ1Zfavxfo97X4B5zNqDyzLJQ1N0mlHOMgeeXN9HTPU
 kh8EY6pq0gejibCyLQE9hWc0NnXvgWNosWYpDhiozIOnBLuyZdmc/Bfl/4NbkX9Uhu7m694wavP
 9JfUB8j+QSgnM93nC1glroKw5hFo+5JsO2IcNMh9lrFlDWMsqtJhfkApq/S1iVbC8Bh/m16CJHh
 uVmHX3LbrXaBbKkjGrJCdm/5x0HZ8sAcHENfpb7h+STjyqBXY98Tj71pRHi/Hc0jfucVnfPj3Op
 VA++QmfvEeUtXnXcgovMBBai5Flpw6byMA1XFuS0lNM/u/LI1631UZLpywTc9ZNLYZmnGnzDUDs
 vH5
X-Received: by 2002:a05:600c:8b62:b0:48a:53cb:8604 with SMTP id
 5b1f17b1804b1-48a8609bebdmr13745475e9.14.1777524574731; 
 Wed, 29 Apr 2026 21:49:34 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a7b912ee3sm56403145e9.2.2026.04.29.21.49.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Apr 2026 21:49:33 -0700 (PDT)
Message-ID: <d425d96f-cd89-4808-8833-9a89010c2da9@linaro.org>
Date: Thu, 30 Apr 2026 06:49:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/40] fpu: Inline float16_pack_raw into callers
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260430000524.56046-1-richard.henderson@linaro.org>
 <20260430000524.56046-4-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260430000524.56046-4-richard.henderson@linaro.org>
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

On 30/4/26 02:04, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   fpu/softfloat.c | 13 ++++---------
>   1 file changed, 4 insertions(+), 9 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

