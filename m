Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF350D74951
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Dec 2025 04:31:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWS8W-0002eM-PT; Thu, 18 Dec 2025 23:30:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWS8U-0002de-22
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 23:30:38 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWS8S-0006cP-Lw
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 23:30:37 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-477770019e4so11081805e9.3
 for <qemu-devel@nongnu.org>; Thu, 18 Dec 2025 20:30:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766118635; x=1766723435; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uOGkQKJDPEXf6PFJaeFStUO7lI6JNOsbak9cvPTy+Jk=;
 b=qEDkO2xzoDI5n+lm6cahyMTiV7I7Nc56pbfGnN3COoysYp3q2wIcNGgLkTiT/FVbpy
 OD9H4EAGDlxWmf6Oyck+n2u8rWiXnfxHC/OTDGQ+cKpVS3up5ymRRFDU3joZabVNvdgq
 Wpl6qfhY9VwqzOptEHmFmj9SvaOUy/0bmxkocK1CuQoV4GYujFQFGL6+O+PvdwQF2tU/
 AChtEFDhVBp5ITYagAIGKL1Qp5Rndo3+5RDaYByI8WNnYKrL1yPtCnv3u4k5hyqIxQA6
 jNRhES+9u9gVgfmSLLYqJ/nqVbiMhYEYIULZr5fFFAyBcY2A14078UOeFzzoAen74s7B
 L0+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766118635; x=1766723435;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uOGkQKJDPEXf6PFJaeFStUO7lI6JNOsbak9cvPTy+Jk=;
 b=hx5pa3+5rn3nH/KYOHB3AVW4+jB0RyEl+At81/G2F2J3S18vBmLHzXkgZSbCKhVLNp
 9Sp+wlRM/Qde3I9lQW3gz+gsvMU5STasTc52+fyhQXCU0fR9ZNtAlFkUGPSKSYylW4FJ
 UkCCjXO0yOsaQJSh1TJ4Aagq5XVT6IW0nQgaDHAhDqxqFJVD6hdOj6tBdUmrAA+s0Gli
 B5dJuchuuYZdt7uGKqy7v46aditZPlmpFZxNw3n1fItYo/WUnOsUOS8X/23Z9hFDUw3G
 leUF0fLXngjGOhppcE8agSHLJvWEUQ8gga2BDiTHi3TscvfMn34oRCH839XBcUYfnlUK
 74Dg==
X-Gm-Message-State: AOJu0YyylE55O6gdTZo9khtrAvMCsQQQe7L6hmA+l53/GUqhMXN/Wi2W
 TmQgCXqEYmWmc/oVtfayYG9YVQEUXXIV5FOgk4z2ECFTzH8TR8dxJFdtKcVK3vKvfeLMOJJOqDj
 NvekOwR4=
X-Gm-Gg: AY/fxX7K2IdiFzccYSztF3t8p3oehjGJmgK981PUNrVU2H6gm8bv8KmXmCw6JjdcUaU
 /2k0qHTATwSl1GSURcBAdDqivJPkFXIp3DpFaZAS4YN7KoYSEniwH9eDdMT+qKoqKg+X3eJBygt
 T/B7VvIVJl68VW8W0utffa70z/ygidfY7c1rCFkY1M8PeLwdUu+YaM17p8rn1sI9dUawTS5alJX
 hR9SrKgAC+sQ2En/b6bnnJ4gukrwLcdRA7TPd/pnewj836DlHKXqNWA745vogMJGUgqVZ86cjUG
 LTBLVXJli4z6fOk8EpFbSHN1wbqaw0Dd7bphkUvZ/5eb1XduyyR1EHnUbWckQpzgTKzeKMQ7pYD
 6mS8ySx+rd2rs/+YDTeCSOo7f30GLizlS5KzdD4FB0iRgUxJ22QPOtHrWTDx4nRxLVXuih5p4ma
 gu76c9apNsBjOtbOwTRP/NaNBnnLMGZ2S7n0B6xoKuWSllVf6c+Fh+Rw==
X-Google-Smtp-Source: AGHT+IGxfe7r4aQJXeK30iBUwp82V+jfQpYHuo8s2+oUBRFXl7C78vu7xcXBgLucLb//Zldp1x4qLA==
X-Received: by 2002:a05:600c:8287:b0:477:76bf:e1fb with SMTP id
 5b1f17b1804b1-47d1955578bmr12473905e9.16.1766118635110; 
 Thu, 18 Dec 2025 20:30:35 -0800 (PST)
Received: from [192.168.69.202] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be395d9cfsm28260575e9.0.2025.12.18.20.30.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Dec 2025 20:30:34 -0800 (PST)
Message-ID: <0a55b26f-5c84-4bf9-9193-85dc40f91293@linaro.org>
Date: Fri, 19 Dec 2025 05:30:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Add configs/targets/s390x-softmmu.mak to the
 S390 general section
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org
References: <20251218194714.174897-1-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251218194714.174897-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 18/12/25 20:47, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> Make sure that configs/targets/s390x-softmmu.mak is covered by
> MAINTAINERS - the "S390 general architecture support" section seems
> to be a good place for this.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


