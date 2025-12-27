Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B786E92704
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 15:42:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZWQR-0001tu-LC; Sat, 27 Dec 2025 10:41:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vZWQP-0001s3-3G
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 10:41:49 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vZWQM-0004W9-WD
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 10:41:48 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4775895d69cso33194825e9.0
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 07:41:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766850105; x=1767454905; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gWrBhlZ9U3CH8tbukp0mChJencQLpTKDcbLkgs8C3MQ=;
 b=Tw+kXBT2eJIidMIem5LHKDo+6C9IlZnmzFLb6EgqC1fEyd/kTQOCgQgJtBLSKOPOm0
 C9OTnjlGVFJE4hjTcVknUIGSwVnK7C/tWE0WMvzmbJntauUvcPVaTfC+dt6LhluELJ22
 ngtcxDHf2uhQx3qeLwRPWOllvrCvPZSPknytPkBLdFhoUjywD8bBjxraxRW6R30Va1dE
 VGtrguAmu5B1bfsb7qv2JWyzhpwad4mN9HMZ43UGqlQbH5sv9a1ci/G3g0+SuCD/d0Dx
 pLSfkwOfSVmVjYg7mJBnhStufvELuBeT4xXmhDrD5owhLT0+qBQOJucIid9aZ1A2gbp1
 VUkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766850105; x=1767454905;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gWrBhlZ9U3CH8tbukp0mChJencQLpTKDcbLkgs8C3MQ=;
 b=G9Y0W4D7KQ3kdAmyCPUOtFrkQczkdUUWVCNhBxXMhannMVfXIDtMvFdzJpMAcLyzBd
 XZgyzeD0bcpd8NzOn+Ewk2bl0ZcQ11HPDUpz9QdEiJr/Vj3ehBvKQBqT520piHAyl2ay
 RZvX01Gv5BFWW/3ocGEkXZfcgF/Sm8kovZFTKFBsY6QRZVQGeWADMPRU4yW605nOt32s
 SHEVI04urNJ2X9y/zcIqwLxPT/U+nowa1cpdjRvz0MO5n3f73r62WdTt02f+fcxNLjOi
 HZMTXfAmclx4u5caMqftFVBJqEqgkem1aFSjrXrt8j/NU6eprNwLYWziR+i87tCgwl4U
 if2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdWkhZdO8C7l3g+lNpaoj+2RfbvLNo6n5IIV9bS9uqY2mt7oIo8pbP6SK0XUkgCOKopP04CoeHGNaG@nongnu.org
X-Gm-Message-State: AOJu0Yy6zpUqOG+qRVE+2rLaqml8Y0qOvFw/o4xW1U68ykkfQYkQ2P0k
 lb/wwoQAVTVuzm5KZmQAI+UBdr8gQbUXp/+p92M0oXjVvKTxqUTx2nNnswZThv5Luk8=
X-Gm-Gg: AY/fxX7paUV/FQ9NuIvSG/amPusBN745LNMYDPSrgrpaGci1EWTCkpsdjrF+gxiwMt3
 xLO97RwiK/aOKAv5YnUmnk5AQYkewKiFnjJUBmsyIh5MUs++wkpbUlTaHQQVzb2ULWLNQRtEtc5
 QdH+gbnQ00p5ew5Ib112H3onYYYWzjwNfDM3d2gYHMMtOX5f+yFN7uIHgBgB7s37dNKkrd6R18s
 xgM6N8L1xu7w8H7bSGnk1N+XTd23H8MdFDzYX2794Q4rONppBF3v0JXTb3k1qE1G0nnntazUDVW
 iMlwU5HxTDHQkAMqma1aBiYpveQmeVHms8SmE/MOkY4hJhr+xhvZf0FnL42JV4fkcPIQCs7Q5rb
 PvaZR3UgqC6XG+g5i4Jgg+35DazHyY8QDumGfVIy0XpNZVp09dGZ+bva+kDGtG7Fb5Ino6686Bd
 hK4rNQoqCDh4n+om6ZQBTolCCAu3/QJgOpycOYuZLquTSH8SAVclO7ddjgUCqI3aoCVEwSu3m+
X-Google-Smtp-Source: AGHT+IFeMLAFLDZQ0P8Rf6fERCl2NOoGug/pLfIrOMpSm4WffhJFZw7xnhDRtuviDzuFvYdr5sXiqg==
X-Received: by 2002:a05:600c:3b2a:b0:477:b734:8c22 with SMTP id
 5b1f17b1804b1-47d1953bd29mr275628075e9.8.1766850105389; 
 Sat, 27 Dec 2025 07:41:45 -0800 (PST)
Received: from [192.168.1.15] (alyon-655-1-564-32.w80-9.abo.wanadoo.fr.
 [80.9.105.32]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324ea1aef7sm51739139f8f.7.2025.12.27.07.41.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 27 Dec 2025 07:41:44 -0800 (PST)
Message-ID: <d38e5c5e-35f5-45de-a1b8-2d96886bd974@linaro.org>
Date: Sat, 27 Dec 2025 16:41:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 005/153] include: move hw/usb.h to hw/usb/
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20251227091622.20725-1-pbonzini@redhat.com>
 <20251227091622.20725-6-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251227091622.20725-6-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

On 27/12/25 10:13, Paolo Bonzini wrote:
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   MAINTAINERS                   | 2 +-
>   hw/usb/hcd-dwc2.h             | 2 +-
>   hw/usb/hcd-ehci.h             | 2 +-
>   hw/usb/hcd-ohci.h             | 2 +-
>   hw/usb/hcd-uhci.h             | 2 +-
>   hw/usb/hcd-xhci-pci.h         | 2 +-
>   hw/usb/hcd-xhci-sysbus.h      | 2 +-
>   hw/usb/hcd-xhci.h             | 2 +-
>   include/hw/usb/msd.h          | 2 +-
>   include/hw/{ => usb}/usb.h    | 0
>   chardev/baum.c                | 2 +-
>   hw/arm/sbsa-ref.c             | 2 +-
>   hw/hppa/machine.c             | 2 +-
>   hw/i386/pc.c                  | 2 +-
>   hw/i386/pc_piix.c             | 2 +-
>   hw/i386/pc_q35.c              | 2 +-
>   hw/mips/loongson3_virt.c      | 2 +-
>   hw/ppc/mac_newworld.c         | 2 +-
>   hw/ppc/spapr.c                | 2 +-
>   hw/sh4/r2d.c                  | 2 +-
>   hw/usb/bus-stub.c             | 2 +-
>   hw/usb/bus.c                  | 2 +-
>   hw/usb/canokey.c              | 2 +-
>   hw/usb/combined-packet.c      | 2 +-
>   hw/usb/core.c                 | 2 +-
>   hw/usb/desc-msos.c            | 2 +-
>   hw/usb/desc.c                 | 2 +-
>   hw/usb/dev-audio.c            | 2 +-
>   hw/usb/dev-hid.c              | 2 +-
>   hw/usb/dev-hub.c              | 2 +-
>   hw/usb/dev-mtp.c              | 2 +-
>   hw/usb/dev-network.c          | 2 +-
>   hw/usb/dev-serial.c           | 2 +-
>   hw/usb/dev-smartcard-reader.c | 2 +-
>   hw/usb/dev-storage-bot.c      | 2 +-
>   hw/usb/dev-storage-classic.c  | 2 +-
>   hw/usb/dev-storage.c          | 2 +-
>   hw/usb/dev-uas.c              | 2 +-
>   hw/usb/dev-wacom.c            | 2 +-
>   hw/usb/hcd-ohci-pci.c         | 2 +-
>   hw/usb/hcd-ohci-sysbus.c      | 2 +-
>   hw/usb/hcd-ohci.c             | 2 +-
>   hw/usb/hcd-uhci.c             | 2 +-
>   hw/usb/hcd-xhci-nec.c         | 2 +-
>   hw/usb/host-libusb.c          | 2 +-
>   hw/usb/libhw.c                | 2 +-
>   hw/usb/pcap.c                 | 2 +-
>   hw/usb/quirks.c               | 2 +-
>   hw/usb/redirect.c             | 2 +-
>   hw/usb/u2f-emulated.c         | 2 +-
>   hw/usb/u2f-passthru.c         | 2 +-
>   hw/usb/u2f.c                  | 2 +-
>   hw/usb/xen-usb.c              | 2 +-
>   hw/vmapple/vmapple.c          | 2 +-
>   system/vl.c                   | 2 +-
>   55 files changed, 54 insertions(+), 54 deletions(-)
>   rename include/hw/{ => usb}/usb.h (100%)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


