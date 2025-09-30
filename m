Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A05CBCCA470
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 21:11:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3hcI-0001Ll-K3; Tue, 30 Sep 2025 17:10:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v3hcF-0001Jw-KW
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 17:10:31 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v3hc8-0006UM-Ff
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 17:10:29 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-33274fcf5c1so6201110a91.1
 for <qemu-devel@nongnu.org>; Tue, 30 Sep 2025 14:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759266612; x=1759871412; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ki4hjHXvWIGTemztjFIekOjMlPQpfsqVdh70e1IeqS0=;
 b=oaCcbmw0ddV2V+F3QsJRtqOHyfvbizMRIZ/Bn5aiZvBshr0whz2SNwvQ1B8H2owEgv
 cvsxxaFQNd7abOgxnIrjGNuiK9DWgry6L8kC1cGfWKNOPDX00q9GpNFvL9eXX4Pilqby
 I5EcHjSeU0mdhtrX4pNMl9IlGm4AKqU/GhR7gHRGdVykHzxBjxK8LNElAqccibXAqBcD
 6cxjUy+mM/GnJuXtG+hur0sAxVTXw1wK6cSAunELdBCz0xHfdGoi0FINYRRD4WMnOFg9
 5m4AfKFsPWr6NU+LXDO+ACtoGGj1P6wmL0LGpTunhnLVG2Bj4NL3sVf0Cer9bQGprMhV
 PbWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759266612; x=1759871412;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ki4hjHXvWIGTemztjFIekOjMlPQpfsqVdh70e1IeqS0=;
 b=A/lYsN70IQ9/pECex15K7PcJ9E/hno6iU6kE+ZmnfIclxzTZ8Vp34qCSBGRkKuZmVS
 gwG4cLF0iDFZRcynnAu/Pz7xSqUdpbn9qv8OD2G2xVjFoxjiPChmcUqdVnvJyBUH4R7Y
 Vk7lQyz1wtKKgqqpdcFTu6JjfPasTMkxf+gk4wcrbElF1489zkGUba9ivdSHD9Kati6F
 1cLv6SwkXqwIMkzo/o9aZzGFaicU9sYGZvgTspSoq2pUZxFJ7XBM4IRPY5URmeHdXF1U
 Y+bYUHR6Nfmaa4xuR2ITkAgRO+4ZbJnkzxK39loO/OXecuQT+K3IDLy8T5YgMJE4x+f9
 ezwA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVv1AJTEePw8kFw6dUfaLp7jTH9ZA+/HRmL36npAd3jfnFFCHf2++tzmgJlLpRUjJI8HxBf//odTxvC@nongnu.org
X-Gm-Message-State: AOJu0YwAjHCxeB0h7/HyLMiCu7pX/qg75tlcIqMyXlsZaJcZPl7IuQqA
 6DZI5KOWgmnwnzYGHjV+kq/TiRbL04o3YyiDxj76BLxXnxtEomXUTF2KeiHcx3cE9Y8=
X-Gm-Gg: ASbGncvhWVrtI8xkQv1VQnjS8QH/8jd9p18hpW0MjqEj+8ZmO8TWunO5jk/WRfUKDXm
 Wa2ULDC7G5ECv877295mW94m8zj7fXzhEosDk7lyF2ij9iAoHhiwpACF98z5rHRl5oDsegMOkxI
 1x67YR/h1du6kKE+gkw0l3R0COY0mNNycJJq+It0Geg0I+3ClGYOS0qZdQUXwJyU5a3Bt42RIJW
 2OTLaDKkp9+7NbzoWlGWlsi3jPUVwOJfMK8Pt+1rxOxRsVVlqT+CcOyorEQHyybtvIxv511XXHj
 raFzcuPM7CUnxAuoQqhM0vvqzM5Z/sWq9YI6i1x5sRsREze1A9VZ1eqJkdZI2uJ0h3zdggOPTjI
 XCmPi8fl6HWlM7ZAtmhY8YeeSIwt004z4ASAL6m6BQy0trV0DcxVUfifvQg+r
X-Google-Smtp-Source: AGHT+IHdMcmajy+W2XeSQ8eHSfCcOIDq4F1qs8/V5sFWQBsDArTnGhnKDjaub67v2yfHtQGIa7N+Bw==
X-Received: by 2002:a17:90b:4f47:b0:32e:5b07:15dd with SMTP id
 98e67ed59e1d1-339a6e80007mr954840a91.1.1759266612009; 
 Tue, 30 Sep 2025 14:10:12 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-339a6ee9c3bsm496318a91.15.2025.09.30.14.10.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Sep 2025 14:10:11 -0700 (PDT)
Message-ID: <fa0b24ea-0f44-48a9-9833-749a15d34c9e@linaro.org>
Date: Tue, 30 Sep 2025 14:10:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 18/18] hw/virtio/virtio: Replace legacy
 cpu_physical_memory_map() call
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
References: <20250930082126.28618-1-philmd@linaro.org>
 <20250930082126.28618-19-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250930082126.28618-19-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
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

On 9/30/25 01:21, Philippe Mathieu-Daudé wrote:
> Propagate VirtIODevice::dma_as to virtqueue_undo_map_desc()
> in order to replace the legacy cpu_physical_memory_unmap()
> call by address_space_unmap().
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/virtio/virtio.c | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

