Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75A07E77188
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 11:43:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVUSW-0003z6-CV; Wed, 08 Jan 2025 06:42:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVUSU-0003ye-82
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 06:42:46 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVUSS-0007Jy-QU
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 06:42:45 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4361c705434so120315735e9.3
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2025 03:42:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736336563; x=1736941363; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KyFSHBm7SCMs3Jw2kdpZkPKR3bppZgg7QLw3NnDpcjM=;
 b=flYzHlJbDrzBwKhbVWlUikuanpMM0crcZvKXiWemb8U3SBbuoH+gQJ55OeyZGfaTr8
 oij/KDUj+5ZznWLJ3gUQOMTzJJgAy7NKfWSN97/wqjPwt5RMwiMR1eiQTR5e0C5M5bCt
 GhbyAxKig892AgNzHX73EBeuXbgOOo7TFQApnZKGvuxlxS/pNIPKJp0IIVSzmSRxFPjo
 C+UY6RafwGe0dzn3Qk2XGsx6dvoi1hTTbYCDFf09bZQGamCHX/H7I81PodoxMPT9oZZS
 Z7qKLjoZxRZc/T3bf4uZFP0CzL4iJ4BFVGfCplxGrc0X7YIQ0c/vnQRO6InB80iXxW8I
 SlWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736336563; x=1736941363;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KyFSHBm7SCMs3Jw2kdpZkPKR3bppZgg7QLw3NnDpcjM=;
 b=t5obWdMUVs/VPyL+CJRywQDFEtzD5MoY9jnn9siNsqu0v2e/R8nCe0F2p9VttK5wPt
 DIv1i4FK3kza4wl2xZvvh6m0Mngc/M/KYY/TKCtMZ/9Q0y5uQn7Nbkmc2I0WNaOpHJFd
 5Ue1N6MwUmuvmquhVpeHJgWwhO8POD0jZCSrgGMnpoz+Sa+JQqinMPKzpnwKhqF+qT+k
 o6qiNktb/wTTHBbZLa/3CZ/OgcFPlpsX8MW5dSlUEi5lxEC6S9TWaOgxqybe8ghB94Hl
 XGDtTGRdaATy+SlqTXK07H1yg32f2e/kaduCsioIP0vLNeHSQ+GE7oXZMHjrPt19oYAt
 Hfuw==
X-Gm-Message-State: AOJu0YzoV7OUv5lRgysZhhsK/7hECWBZyFuHaOASdlj8saQ++p43KmwD
 PXqr1BNf8nQnTbuFSxr8g5E3/+2Y2AcggtFMnKRoj0oLGW42hi7aj0ztjmXMQQU=
X-Gm-Gg: ASbGncsqoHQUGsv9jZ3WGlBy1y5Bl68eTL9W5Wb/9HudZFtDgox3Ou+WKnqAQsSRNLM
 iy/YhYgQ56p9Z6GXmGyl15gRubnabsjDvkPpbV6QDVCmuPTAD+dDXiNZvUzDD2+nzOEJm4Bfx5b
 6+f9GG7ZU/9i4QKiUGTrZemUlwpfjXN3DL1vRYMiJ7comxQJpb/Lqz1NLhxths37vkQLaSbS15x
 mKFm/DDylB7bVLaN3QU3akB4Ml56dLTtOD5zqHyKGpas2ewZNGP+iDTsHY2jaY9QPUgEeB1HcPT
 x61a/vFyRXmYX9kEYvhncZDS
X-Google-Smtp-Source: AGHT+IH9AuVa7axJDkaCALKgNUEPy6yN85oWALO8+poeYK9/GrHTHGRF/rDubNFg0irS2kKn1jlWAA==
X-Received: by 2002:a05:600c:5486:b0:434:f131:1e64 with SMTP id
 5b1f17b1804b1-436e2696d1fmr19831495e9.9.1736336562687; 
 Wed, 08 Jan 2025 03:42:42 -0800 (PST)
Received: from [192.168.69.132] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e2e8bea5sm17760845e9.31.2025.01.08.03.42.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jan 2025 03:42:42 -0800 (PST)
Message-ID: <6584dfa3-8afe-4f38-b328-82bbe315a960@linaro.org>
Date: Wed, 8 Jan 2025 12:42:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/xen: Check if len is 0 before memcpy()
To: Akihiko Odaki <akihiko.odaki@daynix.com>,
 David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Cc: qemu-devel@nongnu.org, devel@daynix.com
References: <20250108-xen-v1-1-3f95cd358eed@daynix.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250108-xen-v1-1-3f95cd358eed@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 8/1/25 12:31, Akihiko Odaki wrote:
> data->data can be NULL when len is 0. Strictly speaking, the behavior
> of memcpy() in such a scenario is undefined so UBSan complaints.
> 
> Satisfy UBSan by checking if len is 0 before memcpy().
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>   hw/i386/kvm/xen_xenstore.c | 4 ++++
>   1 file changed, 4 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


