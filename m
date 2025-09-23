Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 527ECCAC5A5
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 08:34:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0yTO-0006rG-Sl; Tue, 23 Sep 2025 04:34:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v0yTM-0006pb-Kb
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 04:34:04 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v0yTC-0003dW-MS
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 04:34:03 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-46b303f7469so19294855e9.1
 for <qemu-devel@nongnu.org>; Tue, 23 Sep 2025 01:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758616427; x=1759221227; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kCEehApnESw9tw5gjLsKS1FR9eypfDJNpu9hkS7gvaw=;
 b=zjHStsa/OnrSuNyxnOndS7Iha/nwugmEn1DCI/n+NF6eJ46sEd/bBGuWqJ9DITzmem
 hwJIh83xLZOJlO68f3+M6Glj1ooCubLlYQnNZBCIp5xx3ThY6hNRyEy5NfltAcZcUzmo
 cC4nvR2sYZf6JV38pi7mnbl+A+TPpMkoJA6JI2TFp7A9ni7xWtovcbbx+JkIIMaxAdFB
 qrPJe3zZhrgIWK8aUEeyWwLaGjFgYL/AXPWeVLIGALFRsUvHt80lWHHsh20j6pkD1wn+
 frh5pCNier/hm+M64S4Tl4V/6GgkcVSZenBXw5NCWK57OpAVEuCEMDm2Rg7aoHb1VOjL
 V6SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758616427; x=1759221227;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kCEehApnESw9tw5gjLsKS1FR9eypfDJNpu9hkS7gvaw=;
 b=tpSVOcMV6jwhyVVwfaEte7X/6NUgNLKRtCizZUQU5szKFZDTnN3BJhJElu6hySs/j9
 I/Vzls/OELHc9AI3/HUeT09Jo+OnzNN1lPziAoEdTBx48KYeZiB8gWgYb790nEY72Fic
 /hXrJoUtw4b8VAipxl2SXZRG9mpZuiPfURU1IRx4XzYzoCwTpUwUHblO1R6bs4RccIRT
 nlCSNVrDQqcu+9x3dldYw80oqMCeYmjMaOim3cHX8VbbzZaeEA5A3GVAa+Rl/g313kXB
 vDxzYgnNdDXk8qSoPZXr0rQbmCTJ8t+Kd3yvskqT8wx8a70xq/l5WsLdMjShK05ontBm
 07Ow==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQf8pUA8Fqico5h6FkJ2S2p2G9ZlzHOqmxxf/O/c+C4rarnC4iYiTiF+Ct2vKQMwrkZt7akQkaV4Br@nongnu.org
X-Gm-Message-State: AOJu0Yx5Mr2jiyq6ZF4at16nRmfEZFSUz77Tc9Aj1hz3qDnP71nWUylP
 hDj8q2uBGcvz83KGRLWpC6QQP+VhMquKI/4Tre8VcAn45JT+rH3WxUvhyqWC9PupAa4=
X-Gm-Gg: ASbGnctpDxBv16Bbvu9Xblk7qN89g/mqeeHXkLS0ULzQXAtOyYrrquQKGd3Hg78BaIb
 Mfjs0VjQNpg6mNT/3f7bSSqWKFJT6QyGnLnPiCsBu11DeW1APcNHUd0z/qxeiwAz+3XiOJUnuu0
 BAGeL1Eb1tEktonsjcwFwuY29BQKNp0qHYLfOZ3RIlg9CPf/VvnKUxoEFK6hKrH8BXcuKaHK648
 q1+AhNVorDqtRgU5qvIIV8BwPPuj8pd0vsbdA3O4Na2w3XxWCrLxOZD5C5B+322YCrKj/Nu/ImN
 Hb/Xp5vSbG9jYkHdPGMQpgB/xnY1TSx0eaQg99ia1jZjZ91EZxwjfKP7E7QLPbTZmNaVbJmvV4N
 j3c/LH+TZ9KHIvLmvBejXBrYuXSI9nYPwW9ThhMK1/n7IrZ6bspceTa12EOHp8MbUpRNcPY+/3g
 Kh
X-Google-Smtp-Source: AGHT+IHQGhFfbIwBt8AaW15PY9xWmBAWNmAKi4O6W18WdcV9upYpqN9yuU1YLsxP7eUbgtABM5fy6Q==
X-Received: by 2002:a05:600c:3ba9:b0:46e:1f86:aeba with SMTP id
 5b1f17b1804b1-46e1f86b296mr15645375e9.17.1758616426896; 
 Tue, 23 Sep 2025 01:33:46 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e1cf8fb6esm9710245e9.3.2025.09.23.01.33.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Sep 2025 01:33:46 -0700 (PDT)
Message-ID: <58af9543-97ab-4eb1-9b86-098009bb8f97@linaro.org>
Date: Tue, 23 Sep 2025 10:33:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] vhost: use virtio_config_get_guest_notifier()
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Fam Zheng <fam@euphon.net>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
References: <20250922220149.498967-1-stefanha@redhat.com>
 <20250922220149.498967-2-stefanha@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250922220149.498967-2-stefanha@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 23/9/25 00:01, Stefan Hajnoczi wrote:
> There is a getter function so avoid accessing the ->config_notifier
> field directly.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>   hw/virtio/vhost.c | 11 +++++++----
>   1 file changed, 7 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


