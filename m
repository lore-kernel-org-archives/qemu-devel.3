Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C5BDCA0EEB
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Aug 2025 14:59:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upTE1-0007vk-SQ; Fri, 22 Aug 2025 10:58:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1upTDv-0007XT-JF
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 10:58:36 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1upTDn-0004K7-Kq
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 10:58:35 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-45b49f7aaf5so13695665e9.2
 for <qemu-devel@nongnu.org>; Fri, 22 Aug 2025 07:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755874702; x=1756479502; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5xM09G3reeJWiaOGJzecfWegAc7BW+1qlVXu0tK6q9w=;
 b=RFmmE/kzWV80il+fVmIskoipaQh0yoCLOndoT8rloTwmraV0XaLNRSLgGGP2RhXyIh
 sF1jmJmvDq6bDKoE/FTA9L6N0rCSB9tzenYYfwMJchZeuqY5ASg4jI1WaVUM3lBGjWDT
 RjqW/9Y36GuJD+hCOIC5Jz4IpyGL2GCWOQVllmCjmMbJERp7TssRocPKzNOclo9aS1Yv
 eJvkQnK9CKLyfWdquhXbB4BcdseVb/Nenbeq1k/sqXUt5R5kN+xlP9hL5bo7hScZ0Hvc
 KPHDVkFnzEXBwSPF8S5tYlzYj373bpsGVfzqry2W7UzMNHFt3NPufl+4BYghyJidCQKu
 n63g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755874702; x=1756479502;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5xM09G3reeJWiaOGJzecfWegAc7BW+1qlVXu0tK6q9w=;
 b=RlAF/CunaEQKs8MOqj1PAll+Gmh0YRINduM7KhIgQtjz8mN7PHS84plwW0Jb3bJi3S
 +HgEV3U63QWbrUZssxnXQAoFW8vemgcCVrVpU0+5yk4kVjDxQMAOswmNGk9Hv/4RdKcg
 tZRo98Wb7DyGM0sIh04Lemmlt0NOzrfueYU6Q873xtB5VthuTu6yAP3utFIQJ2IUG0C+
 ats7Cxk0aMGa+PCWnqFJpIt6nA2G3OGfna0OoRpBgU7xYtgQDPwNHclssdtKuPs9hUlT
 8Stypijw23y/+VOMaPmBwrsM2a6HXWa3YHasFaIwpf317eFROn7NHOh3GU6S7j3ym34B
 Yx+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNaQmo0zvOXJr4kipa95KZg/CoX8g++VRk8nb5JilEjM9iezHWFgavDmmrvOTB9hnTLoZZ0L+aiwjx@nongnu.org
X-Gm-Message-State: AOJu0YzVfvPKAGYly8elhWgHIEqxifRxkR3n00H8C8IRfIsStvqfVEOj
 /XgXGPEsAFnzbC2oRnDn9rDZ3wzxzI0q6AYBmGfH1mmb5yr++DY9XSm3LsSu0lW2QBM=
X-Gm-Gg: ASbGncuBw/2dbaNeDas/Hpl+3hvzBEP80vL/wbDNGwNOspQ3UjqT/DK29dJedzd81uY
 4DvPRZN3EdaF/Nfm324C1MNEAM1dFamLDPDi99jOkPjzVeqau2osQCSODjPMKIPm3rynrb8h9bK
 7M0X0tcJhXaFfVdU+KjoCjlLtWtQmXP9n4D6uAv3UyS1bH21PT2As6hHRboP8qHGdSomEdiCQWw
 xVXvYMTpxmxk0TtwnVptQCzBKFan0QSgO6gdIbEkV5MZdVenMWPctnJPoqK+4xhaBBPu+04ZM3d
 iatYc3sAOFT99BLrnlBEVLiUIAJBI3n8w7nNP0bxwh1BTMW5rjgn/YtI8SUD5jvGAL2OqydhLV1
 FnhprO9bcHOu/FCHJNMVh1nGqUql+54oT6MfcK6d9dYyby1wr9GN/e6zkDNUDAJQkLq+BsoI=
X-Google-Smtp-Source: AGHT+IFxUk5Mrj3QXWv0geGSn3821O9CLq6im5epjeW6hamjluEjg3VnUI90sHzLE/D8eKcq2qBeWA==
X-Received: by 2002:a05:600c:4695:b0:456:26a1:a0c1 with SMTP id
 5b1f17b1804b1-45b517cb8e5mr35837965e9.17.1755874701664; 
 Fri, 22 Aug 2025 07:58:21 -0700 (PDT)
Received: from [192.168.69.208] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b4e1cbd81sm39454375e9.0.2025.08.22.07.58.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Aug 2025 07:58:21 -0700 (PDT)
Message-ID: <a55b710e-9d0e-46ad-8048-6c1ccdd2b026@linaro.org>
Date: Fri, 22 Aug 2025 16:58:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 09/19] hw/i386/pc_piix.c: simplify RAM size logic in
 pc_init_isa()
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>, pbonzini@redhat.com,
 mst@redhat.com, marcel.apfelbaum@gmail.com, eduardo@habkost.net,
 imammedo@redhat.com, qemu-devel@nongnu.org
References: <20250822121342.894223-1-mark.caveayland@nutanix.com>
 <20250822121342.894223-10-mark.caveayland@nutanix.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250822121342.894223-10-mark.caveayland@nutanix.com>
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

On 22/8/25 14:11, Mark Cave-Ayland wrote:
> All isapc machines must have 32-bit CPUs and so the RAM split logic can be hardcoded
> accordingly.
> 
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> ---
>   hw/i386/pc_piix.c | 58 ++++-------------------------------------------
>   1 file changed, 4 insertions(+), 54 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


