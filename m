Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DD5AC021A9
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 18:37:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk5zo-0003yK-Ja; Mon, 17 Feb 2025 13:37:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tk5zm-0003xd-Gh
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 13:37:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tk5zk-0001LV-4w
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 13:37:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739817446;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=oVXJnC8X86YI5aM/O/tkT40enzmfObnRWllSOwZ2PcM=;
 b=SLZ4nSCwH+Wl1yil4yY5g8MNQqG4EsFaqPRC37C72Y4MPRyH8/sg4jSJUHc+xEiN6QbSV/
 maL+ITgpBg/B26i2cwLmjoi6jE6GmsEidx/2fyHkSWAAm3sUofcu8i4PEqSV8LhuW9hdI6
 c3/wn7me8yH+Vw++q9iy6nKDtt8l9ww=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-c6R4q6uUP8ysRQFhompIAA-1; Mon, 17 Feb 2025 13:37:24 -0500
X-MC-Unique: c6R4q6uUP8ysRQFhompIAA-1
X-Mimecast-MFC-AGG-ID: c6R4q6uUP8ysRQFhompIAA_1739817444
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-38f4e6e004fso898267f8f.1
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 10:37:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739817443; x=1740422243;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oVXJnC8X86YI5aM/O/tkT40enzmfObnRWllSOwZ2PcM=;
 b=eZ1SNPvk6RYDFsXkbm+G7qKSegOtNYQRYPLx+SbDN5vJZjN5o4KdCIrHEJt7Yg8CcC
 HsW+es0WbfYSUV0W6ahKXn5jnpNXSW/W9YV1BFTqB3T3XFWgY0lhiZvY6MbEmRITpkJE
 CUdkUuad+Rcfg/+KYnpf2DDd9cd7CeQyzxUS8UEBwvMV9Ze9rdHp4iwpvKHO3z7dnuUb
 mI7su6e6L01BKF0l7pGnuuhK6h4prggT/8vhyxQoY5JbBT7zAotLZU6v02bjNXdkvTIu
 PD68+fDDbjmxfKBoGb3CFvXiUWw2mwRP9AjqN5OrafK9+xb0hHYUUdbLlKx72UXPrfTm
 lKew==
X-Forwarded-Encrypted: i=1;
 AJvYcCXK3WccNbZ8j9//5pYxN7SVGqP39xuuW0hfR5nIJdcs4UAc0IQC8RbIYZNJqf2G8WeKNnkh4gMbWENU@nongnu.org
X-Gm-Message-State: AOJu0Yy5tTO+RGOxOSwiRM5zWbprzANV/Yq36NqFcCKLZDMEKDj6vLX4
 qjVm01JZKXHtmzF06kE4Y4eIsca7o5bha4UCazMDcPca71Yy+XNk09x7p0fxPs8s8AIOcTj28m3
 YAPQzlw2GhckrPCJIVwvTouIuEElemE2Gc5iENCtBcPdTDjAJMLBx
X-Gm-Gg: ASbGncvigbO+5uD4j+dg5iVH/PqdvIvUC+kXv6o/Pz4Tv6jNj/MvGmqyfIvMQqSFeOr
 lkrX4fkshwbHU1jDYvMJFhRcwYG5jWFtjCC7cW9DFQKegc+dPWwN/jk7beWfTTfzybjCglHS5nH
 pNZVYryjBJR6Bv6VXViJK2F+aEyrbpaEPX2LyLuLKi+yEq2GcweoKZWdhPBmDKxHQERPDFnvdd7
 hFndewUNjrc2K0RBQPo0eH4Gik70zTdmLe5BUwFda3WlNFOR8/Zco6W4oirZvyRrAUyx/M0bTK+
 ZjR7x5rmxXE=
X-Received: by 2002:a05:6000:d08:b0:38f:27e9:7918 with SMTP id
 ffacd0b85a97d-38f33f2d6aemr7010915f8f.26.1739817443491; 
 Mon, 17 Feb 2025 10:37:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGIr8MhtR51XACFIy1nCd75RuHUCKsHd/EuzzX08nUVO1ZbxUWzoKtNZEjjyCsO/6k6ZuwFvw==
X-Received: by 2002:a05:6000:d08:b0:38f:27e9:7918 with SMTP id
 ffacd0b85a97d-38f33f2d6aemr7010899f8f.26.1739817443054; 
 Mon, 17 Feb 2025 10:37:23 -0800 (PST)
Received: from [192.168.10.48] ([176.206.122.109])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-38f2580fe7dsm12961279f8f.0.2025.02.17.10.37.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2025 10:37:22 -0800 (PST)
Message-ID: <c33817a1-74d4-47b0-93d3-000cfd6200be@redhat.com>
Date: Mon, 17 Feb 2025 19:37:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] meson: Display summary of Darwin libraries detected
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Phil Dennis-Jordan <phil@philjordan.eu>
References: <20250212112958.38023-1-philmd@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20250212112958.38023-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 2/12/25 12:29, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   meson.build | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/meson.build b/meson.build
> index 18cf9e2913b..10f4c9fd30d 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -4826,6 +4826,13 @@ summary_info += {'libdw':             libdw}
>   if host_os == 'freebsd'
>     summary_info += {'libinotify-kqueue': inotify}
>   endif
> +if host_os == 'darwin'
> +  summary_info += {'Hypervisor support': hvf}
> +  summary_info += {'CoreFoundation support': coref}
> +  summary_info += {'IOKit support': iokit}
> +  summary_info += {'ParavirtualizedGraphics support': pvg}
> +  summary_info += {'Metal support': metal}
> +endif
I think all of these are going to be present anyway, because they're 
mandatory (except IOKit which _is_ going to be there, and HVF which is 
present elsewhere) and there's no version indication for Apple frameworks.

However, adding pvg and metal here makes sense if:

- "config PVG" is added to Kconfig.host with the corresponding 
assignment to host_kconfig

- "depends on PVG" is added to "config MAC_PVG"

- after which, host_os = "darwin" is not needed anymore in 
hw/display/meson.build

Also, it's not clear to me if PVG can also work with TCG, and therefore 
the MMIO version can be used on x86 Macs?  If so the 'if cpu = 
"aarch64"' in hw/display/meson.build seems wrong.

Either way, the Kconfig file does not need "depends on AARCH64" and it 
should have just

     depends on MAC_PVG

with an "imply" somewhere in hw/arm/Kconfig.

Paolo


