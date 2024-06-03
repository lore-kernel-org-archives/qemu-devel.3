Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07C91C25B76
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 11:49:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE6Bc-0003mp-7u; Mon, 03 Jun 2024 07:49:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sE6BW-0003je-2Q
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 07:49:07 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sE6BT-0004s5-SQ
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 07:49:05 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3550134ef25so3968331f8f.1
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 04:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717415342; x=1718020142; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YwQ/Pdf4Y3EmNBto/siemVD2L186u3Gcst2+RqrCCHU=;
 b=Dyh1SnrvFJdZ4oWWzf2XOEu2AbzUhhKYkKcQnNC4CYjnOs2s+AUISEQ6tpLg6zwd+x
 HkIqJ5Ic0c8oLFCtsRrFUrkXWn8GD/6xwOrRpKhcCPT40cbulUf8oLQzQclPC6GlO03L
 UltBAKYhGFi/ahx4ySzNpZIk4nymPWqEGSq9qFABiFRPKzSdB/EotjDBKhT9nnKIrlez
 Z8Eiv/NFxodItDnUNvXJo7EPReQO73UkjytLkRbXgdoJDg1wZVi02iWp7+uVl3VTQphr
 LY+BKozwiHTgp4NWBcW2GF6dnZv27ZdXNhN08GAr1dDWhIGveDSewZIKELkNaNsyS9tE
 xmIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717415342; x=1718020142;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YwQ/Pdf4Y3EmNBto/siemVD2L186u3Gcst2+RqrCCHU=;
 b=NemTDNshEB7Z9HtYEzIUGgTWt+IKMi3Xfabtl5YF1lpd00Is1r6cQGX3QDdULxN0tT
 QaBinCtpCuTxxSg4IcTHbJWmq18tFYwOIviyO59qht30C8SIQfOZm0vEZpJAU4bIBdt9
 ooXdjcmtifhdvqoC7uV+gxELVOG85QiH5gdU+8HVQ+d7QJKWXuP//2MIoveP4AKQUCC8
 1APbL1A5twL+X/FeRiCroC4OCIXj4C3vFuBeKoSFgXgV80/IFejcx90dzf7oRGIBUyad
 ZpKus+2wffRjqVuN16rJFZ4DmjfcGM+31PIPfLnynC6dsVsdENzjBscW/3S9TNvrJEs9
 /Zhg==
X-Gm-Message-State: AOJu0YxbyfMmuVgKFZM2n0IJvpF3iGUKgsnANz4wJipAflIYyDr6SNFM
 7y3S8ZG1j3xraIIm5MDAjfV/E1vZ2WWc8AUGuSOm6lRC0tzfiyNMjdGXwQz2wVw2aSIpavxYxq5
 T
X-Google-Smtp-Source: AGHT+IEFOw08szT4GXwub1/2CwBP2HURKztzGBZQBQKhd0OivMVk9XKNPsjeqx+sYrMmKpqVgkG8sQ==
X-Received: by 2002:adf:f852:0:b0:355:25d:a5b0 with SMTP id
 ffacd0b85a97d-35e0f273304mr6089349f8f.15.1717415341805; 
 Mon, 03 Jun 2024 04:49:01 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.177.241])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35dd04ca9bbsm8651496f8f.31.2024.06.03.04.49.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Jun 2024 04:49:01 -0700 (PDT)
Message-ID: <ba6a62b7-46a6-4e2a-a4c0-ee42a5e63fbb@linaro.org>
Date: Mon, 3 Jun 2024 13:48:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] hw/xen: Simplify legacy backends handling
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Paul Durrant <paul@xen.org>
Cc: Anthony PERARD <anthony@xenproject.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 xen-devel@lists.xenproject.org, Stefano Stabellini <sstabellini@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>
References: <20240510104908.76908-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240510104908.76908-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 10/5/24 12:49, Philippe Mathieu-Daudé wrote:
> Respin of Paolo's Xen patches from
> https://lore.kernel.org/qemu-devel/20240509170044.190795-1-pbonzini@redhat.com/
> rebased on one of my cleanup branches making backend
> structures const. Treat xenfb as other backends.
> 
> Paolo Bonzini (2):
>    hw/xen: initialize legacy backends from xen_bus_init()
>    hw/xen: register legacy backends via xen_backend_init
> 
> Philippe Mathieu-Daudé (5):
>    hw/xen: Remove declarations left over in 'xen-legacy-backend.h'
>    hw/xen: Constify XenLegacyDevice::XenDevOps
>    hw/xen: Constify xenstore_be::XenDevOps
>    hw/xen: Make XenDevOps structures const
>    hw/xen: Register framebuffer backend via xen_backend_init()

Thanks Paul for the review, unfortunately Paulo missed this and
merged v1 as single commit 88f5ed7017 ("xen: register legacy
backends via xen_backend_init") :(

Regards,

Phil.


