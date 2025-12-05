Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13420D37496
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Dec 2025 20:03:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRc0a-00032G-RA; Fri, 05 Dec 2025 15:02:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vRc0S-0002zR-BG
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 15:02:21 -0500
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vRc0Q-0003aw-4L
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 15:02:20 -0500
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7c6d3676455so1238024a34.2
 for <qemu-devel@nongnu.org>; Fri, 05 Dec 2025 12:02:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764964934; x=1765569734; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GI3vGAx0xMr6zMmXIPU8cIHON1TcYa/RfgyPJ8EMn+w=;
 b=E9exaKvoRuHJmgX3Uz0sky2yNrksA8IvnPEh+kRYqt4BLYfQheEHnyp9eXjbs+Jp2X
 L30bCHsQAQ7JSLaB9ecRYz//fZOA1FgaqMZqGZ7jdHsSUpDWzx/OUaNu8EuwvhNmh8+u
 jn8Wz/p/TlsQZeXf2Ua0MBkVXXnOUu5isWRmVQxA0QWtSKftPOCsHvsllifdVyxUV1Th
 hDF8twZnHbaUPDB1AQnRe89bMxrzygGeYxE9MJ8f0uTCHvFmeoeq0x87SELms49JMWWZ
 e0VR5ij/Ia0ekmHkQysSQMODH3KuAbzRxi7219xPv3DwRo0THMwRFSRadXRucNjQnfjX
 Iluw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764964934; x=1765569734;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GI3vGAx0xMr6zMmXIPU8cIHON1TcYa/RfgyPJ8EMn+w=;
 b=Pt2uWHiREwR3XlmfC6Dv7roLdsPj6olFekAyUfkHOgFj0DLElvt06TrmqTRF3z1jIj
 z4VbOU3ATjrucNGlEE7d7mFcU6g8G+/0DUr1PAb6+sQKVgf0L+9lxRsS784QM2IgwbiL
 GYMWtV4Pj8t24yb+Yh9JMufPYDHSRCTuWPHWjMGlsjxZ5z0c+XYtUTdylKY7gbc1xRYw
 gjpU4RuKFOwzXtpVtkd7WbM47OFmqAxKvl2WxA4hmDvTsAXV2TUqk+AFizvMLRbKwXQk
 RwZCH/cxWjCc76SrjttVjR5ThYtSBdpYVuM0N+z/xN2F2NZAWUEYhh0lwWH03UWyg0lg
 kquw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUACVqL7psIpUqWIHx17NlXc7uhAiXhJI8F1SR0C5Ve+88U0v2TykZJvVrGJWs5qiKel+Og6pv89c9s@nongnu.org
X-Gm-Message-State: AOJu0YwwJEgNluFinzTjUzGFNic77z7rdUT3wQGBJoDY19dfQ//X2C9m
 n6efRD5IM5WheSplXi4o8Z7p22YfjRJw+5P0q+sUcflumat/eRJNZSQHW5q/OIyskrU=
X-Gm-Gg: ASbGnctK0g38PSmXDzaWaWrfPrgwhS/dmT5lBGOId1DGbg9xt0AyUpugEJxEzOYaIEw
 Cp1YqJ7sq5A8KHTJwflLjkERAXbaaS9bB4mHIvU+4Kt40amqqs+JUX0VUacOtMtlpjJpUGUoXgM
 k5/nywowGY46XIYe+t2uC7D0YZKJcm9/GORDt3/C2pai4JhqoCId3AswzmIG5+6baIwStRaGdzA
 5epLuyx1P52Z1GhPKtF9FZuiZY4da+fVC+vG2V7sDoIFSqRo0w5MxlfkcDiGa0zDNLlU5EbGzmd
 H8IzKnNPC/K0RIVc435raJUNGUw3gHHQQ6N4qXH9012DpF1Y3VAw8yd4BrZfKTuntHnTvj8xmK0
 cq0OpkCxXfSXsNZwk/AEYjeiN4+OijZHJvDKWZlgRxta4jb/DjLQcPJ8jDMCaJPdwIwNv2DuhsA
 f4oiPL8WhjCTUNZngzMLq75Oc055Y94gRHwcGlCM9gidzOsRzS7/dzAAVtA4f+fQ/Z
X-Google-Smtp-Source: AGHT+IEO2HiBtzlWxHWgDwWaAHDMh4VW6Rgf7ZtMlJ9MSPP0Pxkk0nSfz4c4zsuywoMirN8gcBkOVg==
X-Received: by 2002:a05:6830:440f:b0:745:a41d:22c8 with SMTP id
 46e09a7af769-7c97078bd54mr162048a34.1.1764964934041; 
 Fri, 05 Dec 2025 12:02:14 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c95a93f050sm4778872a34.12.2025.12.05.12.02.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Dec 2025 12:02:13 -0800 (PST)
Message-ID: <3d088159-6477-479b-ad75-d307a01be807@linaro.org>
Date: Fri, 5 Dec 2025 14:02:11 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-11.0 v3 07/22] target/m68k: Use big-endian variant of
 cpu_ld/st_data*()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>
References: <20251126202200.23100-1-philmd@linaro.org>
 <20251126202200.23100-8-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251126202200.23100-8-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32b;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32b.google.com
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

On 11/26/25 14:21, Philippe Mathieu-Daudé wrote:
> We only build the M68k target using big endianness order,
> therefore the cpu_ld/st_data*() definitions expand to the
> big endian declarations. Use the explicit big-endian variants.
> 
> Mechanical change running:
> 
>    $ tgt=m68k; \
>      end=be; \
>      for op in data mmuidx_ra; do \
>        for ac in uw sw l q; do \
>          sed -i -e "s/cpu_ld${ac}_${op}/cpu_ld${ac}_${end}_${op}/" \
>                    $(git grep -l cpu_ target/${tgt}/); \
>        done;
>        for ac in w l q; do \
>          sed -i -e "s/cpu_st${ac}_${op}/cpu_st${ac}_${end}_${op}/" \
>                    $(git grep -l cpu_ target/${tgt}/); \
>        done;
>      done
> 
> Then adapting indentation in do_stack_frame() to pass checkpatch.pl.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/m68k/fpu_helper.c | 12 +++---
>   target/m68k/op_helper.c  | 91 ++++++++++++++++++++--------------------
>   2 files changed, 52 insertions(+), 51 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

