Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70134FD3773
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 16:59:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvIE4-0007U7-G7; Wed, 25 Feb 2026 11:59:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvIDz-0007TY-Ms
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 11:59:00 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvIDy-0004tj-AI
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 11:58:59 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-4398d1f06caso1497489f8f.0
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 08:58:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772038736; x=1772643536; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VFK6sLlF2XSCQ+r8R/LXiYEhC8f1Oid2t9jg1lRs+Bo=;
 b=SZ2CL8NX9vt0qUKFrsWgJtH10h4y/gspgA+6wfcodOal1755vQE6NWXmXmThNCbeAq
 WK7US/cbuIRAf2sK9tvuTP5nfdaHmPIJphFsNMpNhwGgWjN2ihuw9c6qo5o1hMUs7nJ6
 2FUS/vRwfo1hoJSTH0jxded7CrjV9SYGHopZE6atlwBQRHMsFQ1qQT2uPU0XdCD1US9t
 tGQu5fDjfsQb8rH1pfGrNY6Bt+S1DvfGt9qM7Rw5nkyK6pcScenvXLQs8RkiVfcDnhoy
 0ZWdcFLoDMUUj98uxsjZXe/syI1bCNZKkG0Ktd51fmHoKOj260fQzMXaTIRrngNpUgo1
 25Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772038736; x=1772643536;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VFK6sLlF2XSCQ+r8R/LXiYEhC8f1Oid2t9jg1lRs+Bo=;
 b=VsbEJoohVm47eRFV03s0YECaOOzk1tsDHbhNCb3Eih4nDXWLFP7Qwf7tkfFzFzusbA
 KKnx488Qb9sxXHRkdaT1wobwTW+KF5PCHHMYJzCNNKOSp/XCT5kCR2vPzWLTL3kWrdMO
 EbtSZkleufkoTebZzTmDawM7weYOP7khzcHi4Z6cIgrLPYeaq7wjSiLrV8smO9HEpIIF
 gjObHRBIO2NeC1B0KwlbrxgpIOBGOIG4Js2c+hLiG+FQAYUg635HSzpd4q/EJmYGl2xR
 7mgGHMWbMlNeNz2xl21Vl6impLbhDU17aVqHQzptWw7Md36HS3LBrnJuYXexwv2WaztW
 k5xg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVKAt2EolMZslp1ojDTHTFooubpcx9K1x9a+Vo87n7Y16bgoHxwrRQ7uY0+4FsvdHObILyapPZcNBb5@nongnu.org
X-Gm-Message-State: AOJu0Yygoj0Ng6yIZLhALSJY8GEhHpDHlRTSDBIZ8K5+V7AXfRGL5jBH
 KP/tLuwUIqkE257X54jWD6ZvhYSjItfY05QLJugldyYpI+96goKJyRIwzrvtwPbnQnA=
X-Gm-Gg: ATEYQzxnIjuOS4swhCsnqR/oH3rcodKCOaYZCNdpvP7vq4UEKq+eOmIU+L7ZlDZAcwW
 LzS1mKqlEE+ENXhC2pZ0PlNI8c1eMhBe6OLP7DGD821OYS0qH3oRk+IyCLngTFjekyObw7+YSDJ
 eQzJXb+5VZGXDg1XKW+2ZWTnge0OnziTB3hU+rdRB4X4SIGbNNDWlx9HJ0IrNOEj8nKjgElGpTY
 kKGIDSUG12YxbStFusxpvtNUQ+6E7MQ2yf9vPgX1JY+NKn/Rw/Gt2rweu2VkE7D2RlzXpuamUkW
 C5CaubyQUP2i+HLNFLO/6Jkj1BFl5ErdutkruXbfF1BHsgnGnlPKUF4/4XWqRq0JM1mqUqU6hRt
 jIiC6u1j2wDFrFqk3O1SGaL024gfVouEb0J6pgzaMsdr1VE4vUxZpE2rwmgoIAPPf96IlTkNg6s
 gwAEQiRqpXrzaoGB8CNRbG8GaHoXBfSTBd4SsM8fz0vbrz1wA7R1KBE4kR5wSNLNkSkg==
X-Received: by 2002:a05:6000:1867:b0:435:930a:658e with SMTP id
 ffacd0b85a97d-439942fdd59mr2139081f8f.53.1772038735578; 
 Wed, 25 Feb 2026 08:58:55 -0800 (PST)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439927c3e01sm3668951f8f.11.2026.02.25.08.58.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Feb 2026 08:58:54 -0800 (PST)
Message-ID: <285e6eda-fc6c-4eb9-b238-47918dd611b1@linaro.org>
Date: Wed, 25 Feb 2026 17:58:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/i386: drop unused PC_CPU_MODEL_IDS macro
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20260225165400.605941-1-berrange@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260225165400.605941-1-berrange@redhat.com>
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

On 25/2/26 17:54, Daniel P. Berrangé wrote:
> This is redundant since the 2.4 machine types were dropped.
> 
> Fixes: 4c82e7b34b1bf35d97e026196f5bf10ea916512c
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   hw/i386/pc.c | 9 ---------
>   1 file changed, 9 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

