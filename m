Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51115D729E9
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2024 15:45:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tH3B1-00018s-K3; Fri, 29 Nov 2024 10:45:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tH3Az-00012C-Uc
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 10:45:02 -0500
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tH3Ay-00020k-3s
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 10:45:01 -0500
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-aa55171d73cso556315266b.0
 for <qemu-devel@nongnu.org>; Fri, 29 Nov 2024 07:44:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732895098; x=1733499898; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FyXhT4C6mfn2KYnw2Ureva8wj44IdfMGj0GUEmeQu1E=;
 b=PXvdpTs5b2zhxEIIgn5r10VLlqIYspcxD1wWX6KD0zaXbm3KwyzizIGHTEnVXVwDZ0
 cq2HN16oZasJMfxeTvD02ZFdASbi4VzKzxeAQyX32bHOJ3nvcW2BS9AwnkREzyk1a5/S
 Z0d5zTXn0rTTHGAjf8fTEHnjnxa2f2VpgHMrAnmNMmPcNbtbT/yBHHM5J8niohTi87FY
 myYF4gJZQphBGQikpob1lLSR5q5GQdjAw/CZeMjnx/my99pFzOnaDvUJMM/wRlz7vz3x
 pC/yqh3oky5ijSPMpW0BrKpoCM1uTAlQZDufO+3WqGVRDSwVAMvDZAdfJ9YXlOlCwBB7
 ZxbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732895098; x=1733499898;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FyXhT4C6mfn2KYnw2Ureva8wj44IdfMGj0GUEmeQu1E=;
 b=OlsaGvEuVIS9JrI2rduPDNuZQD6+Q2V5qrwW3S/ZejwjJ0VCR9caj6CF9DoOE2s2wj
 6k3JHk/e0M6gjUGM6wJ/gUfyrYLAh/tuNS6oKrTs3wFZqFL7FQMi1Dg47YDq+Jh7d6wQ
 C2ZDZ+CWJCIUSprqcAJeU+xzny7Tfq0GBDMn4KPN8yjpfGSossnefLvRE66Mtmo+FwQo
 eqB6K7uFSqjKCB9sDp7ozPAyCXSudKyJSxvmTsp0lke3bg58NjuPi89pQ3Bkv/Qc4K+h
 sjuDHLzI1vmyZKza0C08HaBmdE7HOBGXS5YnMNgLQYkZ+lW3KcLg0LguKE8HkUCiamO8
 gj5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCU43ehPKQDN5f6qF6oeL+3/1q2cFgAHJ3ZVdsO9esU79sB/1cuqDm3NYbyhRn1NfJVVlK2GzdOGkMop@nongnu.org
X-Gm-Message-State: AOJu0YyNQABb1JKWjgAVc/6ea7htz8MGg7JmbH5DcKuD5Uf8UluaG9WI
 wMu5GBMY5nF4XTOgc7NxsnlE8WPDlj6Pi6C0OWz0eY5XXMalzSvLtn0ajbrohTCNyQ4BYrOQQJJ
 y
X-Gm-Gg: ASbGncul/B/+DgnvgFJubpMuHIABe6bOgUWwodQ3gi8tX7ygVKJ0jCOhWG66dmLmyBY
 BIeTeYX4zJ/BkGnO+IFp7RICmUMOh347GO3HjV/PlDjH+pE+aijzMYlOWPC1GZL8uwYQ7hOPHEC
 HQbN8G1dQbF3ecp01qoMJ/8137o4BMy1VEj6wCJNGcEbZ78II/KCzLKzBEqLrfM45pd2hOYz3MN
 lutSEFoJn+P9e+iv3i3NFFuzv8vrB8cMOQPFJrpOj8UdDTLDloNXACbI4tG2hyU5A==
X-Google-Smtp-Source: AGHT+IGsHFMOy/pmy5zCf+UL3aD+tb5RBGtXq+R+w147f96OlSThRovxgKtZAF4fQkotCohTD+iblA==
X-Received: by 2002:a17:906:2189:b0:aa5:3663:64c5 with SMTP id
 a640c23a62f3a-aa5946690damr781265066b.22.1732895098177; 
 Fri, 29 Nov 2024 07:44:58 -0800 (PST)
Received: from [192.168.69.100] ([176.176.147.124])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa5998e6f99sm185479066b.131.2024.11.29.07.44.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Nov 2024 07:44:57 -0800 (PST)
Message-ID: <6a8bb7d5-2aad-4f26-9d9c-933695f5600f@linaro.org>
Date: Fri, 29 Nov 2024 16:44:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3 for 9.2] tests/qtest: drop 'fuzz-' prefix from
 virtio-balloon test
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 David Hildenbrand <david@redhat.com>, Martin Pitt <mpitt@redhat.com>,
 "Richard W . M . Jones" <rjones@redhat.com>, Fabiano Rosas
 <farosas@suse.de>, "Michael S. Tsirkin" <mst@redhat.com>
References: <20241129135507.699030-1-berrange@redhat.com>
 <20241129135507.699030-3-berrange@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241129135507.699030-3-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62b.google.com
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

On 29/11/24 14:55, Daniel P. Berrangé wrote:
> This test file is expected to be extended for arbitrary virtio-balloon
> related tests, not merely those discovered by fuzzing.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   tests/qtest/meson.build                                       | 2 +-
>   .../{fuzz-virtio-balloon-test.c => virtio-balloon-test.c}     | 4 ++--
>   2 files changed, 3 insertions(+), 3 deletions(-)
>   rename tests/qtest/{fuzz-virtio-balloon-test.c => virtio-balloon-test.c} (84%)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


