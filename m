Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75B28FED3C0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 13:04:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGGBp-0007vb-Mk; Fri, 24 Apr 2026 09:03:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wGGBo-0007vA-4J
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 09:03:24 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wGGBm-0001vd-6A
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 09:03:23 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-82f8bf96b46so3861001b3a.2
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 06:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777035800; x=1777640600; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8igzuTuhwAsoiTEWADFQW2EKBMxz8tignf3BrhVKEPA=;
 b=p0RYl03qVRRcAzoWpAR2RCiMDH0ihzmUR/WsO/LKLYkmUXJPgKu2l1cfYDATzvijC2
 ABRwU7f9/MNLUxNqs4lMjqx4G+ptExLgW5VGmY/PTTzP4ndv/fBOAEKppgZFinPd2N0r
 jn22/H66xj+xQ2Fbb+dP+GGLo+z2Hra2n9gUuZIGrP4kdvTYGgg06ByWsO54g9a9f4J8
 nzupzqUGKEcRFDzeuoOF+tD74BdAy3Soz1tfY5UuNKVxvDzEDvPKTo0SI72IrvseYX7A
 luPP4Yb2ACW6CXobFqc1xx1/Kk5UI5mkkBLIYYTj/hJsUJJTtMqfXfdBcP8ccdvcNtpi
 6txA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777035800; x=1777640600;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8igzuTuhwAsoiTEWADFQW2EKBMxz8tignf3BrhVKEPA=;
 b=R1QgkWo83j2oivtteQkjedoDn3rBBMcJfkiHcihX06qTUJfPX6AdBbhiChRHBZIgmf
 iJlyBouFWc7JTQCq+gbmcm94th5isT7UFqZO63hm0U4KKK3dKuz4Nj749cvBi8bPnaqh
 uklGHL/hSyKnfyEWeowi8f/B/zPvcTnost38kSeLW6YratzhGoz70iBdKX+feBGgZHMA
 W5g0afYT+u68Wd8nXdTwDAzVjZn071GHljxCRm4wgvOvsyLryaeyJxTfGJPS/zyFzOD7
 2YrIYZqSTR6xShA3Y4OuVivSAV5ruikjWWKHUXoIuSjU0PIcGQ3vovwk16cPC+KO/vBr
 w1kQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ90DJ+GODeBGdz9j0n5uNPbEja+mNUKtxgxdgfinxuwIdcxzjC/7FXHzzM9c4cFAoA/cxebqPASpLUn@nongnu.org
X-Gm-Message-State: AOJu0YxqgGK2hyszFt23wK/Yy2FeSWFm4YuuS7XqzyLj4Z+WF24cIAZl
 wmGmS+wsMsX1lu89y0zCPYguEpPF2EPNZ4Q646TWTFzdjMZN4OpvMB8Om69dQefZ4T4=
X-Gm-Gg: AeBDievydxgNO+IC75eYAM9N6n6t9pTP6WkjPSQ0L3ihr2wMCLENHifX368MBgmxK4s
 nGgIeO+83m6oZA7J1XcUWxKayNhfpOQpBKx9UXCXIYIrENYyUlC/ShCDXJbCk9JF8d+Dc+KgqyC
 ftoSVIglBjcgfufMpH4x0AvkBKJEMTzZimgYMpklozRtNnOXexy21r/nSNINf4tlJB6OV5KwCIf
 /ao2JLDiuqqcAdEgd0wirERrmPJwAdgCkm/lVQ1gCsgwqdtDw9EnyTjI1DkZQ9+07Nj4eKF8Tv5
 O0IISmGXctRlEz9NSi23EzLApk+MSwgrCcJurG9gW76b4kwO0APlThzmCFi+v0rW5tkrueu0Duv
 PAUUNJ+/AmM4LcyN1QzHXTBNg0npSDSKM/Cuv2T9O1TaqAbp0Pfd/2Q11OtVV4jQAL0V0DgoRzC
 X1UXM2QgP9KYAl+4Kj2SSxaO4EVUdBDRfZ3azvQoRQf/PTbmCG85mg
X-Received: by 2002:a05:6a00:368c:b0:82f:6bd2:eac5 with SMTP id
 d2e1a72fcca58-82f8c7eee6bmr30557196b3a.2.1777035800304; 
 Fri, 24 Apr 2026 06:03:20 -0700 (PDT)
Received: from [192.168.10.140] ([180.233.125.15])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f97eb5ce8sm21481834b3a.61.2026.04.24.06.03.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Apr 2026 06:03:19 -0700 (PDT)
Message-ID: <cdaca903-4a90-4b8e-ae9c-5b5be6a6a763@linaro.org>
Date: Fri, 24 Apr 2026 23:03:13 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] target/s390x: Leverage 128-bit vector type in V{L, ST}L
 opcodes
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Eric Farman <farman@linux.ibm.com>, qemu-s390x@nongnu.org,
 David Hildenbrand <david@kernel.org>, Matthew Rosato
 <mjrosato@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>
References: <20260424104325.81484-1-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260424104325.81484-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

On 4/24/26 20:43, Philippe Mathieu-Daudé wrote:
> The access is unaligned (MO_UNALN), we can easily replace the 2
> consecutive 64-bit calls by a single 128-bit one.
> Considering atomicity of the new 128-bit access, the both opcodes
> VLL (Vector Load with Length) and VSTL (Vector STore with Length)
> access byte granularity, so use MO_ATOM_NONE.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
> Based-on:<20260423135035.50126-1-philmd@linaro.org>
> 
> v3:
> - do not increase addr (Ilya)
> - MO_ATOM_NONE (Richard)
> ---
>   target/s390x/tcg/vec.h        | 12 ++++++++++++
>   target/s390x/tcg/vec_helper.c | 17 ++++++-----------
>   2 files changed, 18 insertions(+), 11 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

