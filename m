Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72A0AC3ABCB
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2024 19:22:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqHI8-0007WP-7g; Mon, 16 Sep 2024 15:21:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clegoate@redhat.com>)
 id 1sqHI6-0007Uf-GW
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 15:21:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clegoate@redhat.com>)
 id 1sqHI5-0005lf-2t
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 15:21:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726514499;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ig/shWFu4ibovLeUT7Donxk/G5o96XD3gaiI9ldl03E=;
 b=UDHAGGLgYEGici6zrP0DZfRXuffEJaOa7x5D76ITtTMri7KH1ZgOxU1rMr2EnHB2TpYULF
 XKXstgzUVj3mRWTgbOD6FLNlbtq3iC9jzUS8RSVn1xh8iU8tRbbCeQPkTFP+4OUU46/Ni+
 Y4L8Sy9QLSJUXZDd3JIi85iwsr1afc0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-T7n_HHSgNEejKZtvAZ2uMQ-1; Mon, 16 Sep 2024 15:21:36 -0400
X-MC-Unique: T7n_HHSgNEejKZtvAZ2uMQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-42cb998fd32so33546475e9.1
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2024 12:21:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726514495; x=1727119295;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ig/shWFu4ibovLeUT7Donxk/G5o96XD3gaiI9ldl03E=;
 b=Any5IUvsAPPeja1yzYmpFGQ8V5MQP78f9y0CkNqhD0b/1vpSy0Cq5PITXi+yEPmKRh
 +2FwSaoA4GrDL8z7xm58Tz1pO2iLj1FLObjZScRdigps4xcDvaBU7pvSi69UsdpcG+AU
 nqsiIzoNrv5lbwXvuiL7paqa68xbe7lC1/USMc9OqggxBW2CPDh+aTwzuvKSEfdWHFwQ
 agp4G37+HVR5ZxX4n1MMMgZYToA4pqL1621/fOOu6Bg83V0sg2A91r3U18pvAf0IrLUZ
 N+o/X1c9CtEhR/vYPZT3I2R/iDa3MAtahBmLT+o772JyvmJ84yYDclzyhyUreIpJ4sAf
 aNKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUuLT8vJd5OtQEWprXoOIJkhLdRC14CfBJeP8KZTwiEGOqu3tzago6fk3P7m3cBlCkSDrAh/joj2XLC@nongnu.org
X-Gm-Message-State: AOJu0YyORBeVDAEJMgS7Qe3jFlU00lluuIhCqSFfFCmveS6HMds3lSMP
 iIAOtC2HWmu/VWrsVaerLj9UUxPFFnnQBLwqPTueLW8cjxPxfKDQQARAL5CFtFMd1P8uXzcw9xS
 KJ16DKrF5gKZeSsxiqParAigqPrk9w+M456c0wuuRXVtxdvkuHhYD
X-Received: by 2002:a05:600c:470d:b0:42c:bb96:340e with SMTP id
 5b1f17b1804b1-42cdb56fa94mr108232035e9.31.1726514495425; 
 Mon, 16 Sep 2024 12:21:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEjaqYWmyhpUFktPM8HqQD1sxFd5Wju7AsiG/C5TkzkyXIsz00zZnhgxSowlQz6FNQ4axeoog==
X-Received: by 2002:a05:600c:470d:b0:42c:bb96:340e with SMTP id
 5b1f17b1804b1-42cdb56fa94mr108231895e9.31.1726514494937; 
 Mon, 16 Sep 2024 12:21:34 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:3f78:514a:4f03:fdc0?
 ([2a01:e0a:280:24f0:3f78:514a:4f03:fdc0])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42da24214bcsm84245805e9.31.2024.09.16.12.21.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Sep 2024 12:21:34 -0700 (PDT)
Message-ID: <3c4c2e49-2537-4017-b350-d25c310a60ca@redhat.com>
Date: Mon, 16 Sep 2024 21:21:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/pci-bridge: Add a Kconfig switch for the normal PCI
 bridge
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 qemu-s390x@nongnu.org
References: <20240913144844.427899-1-thuth@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clegoate@redhat.com>
In-Reply-To: <20240913144844.427899-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clegoate@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 9/13/24 16:48, Thomas Huth wrote:
> The pci-bridge device is not usable on s390x, so introduce a Kconfig
> switch that allows to disable it.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/pci-bridge/Kconfig     | 5 +++++
>   hw/pci-bridge/meson.build | 2 +-
>   2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/pci-bridge/Kconfig b/hw/pci-bridge/Kconfig
> index 67077366cc..449ec98643 100644
> --- a/hw/pci-bridge/Kconfig
> +++ b/hw/pci-bridge/Kconfig
> @@ -1,3 +1,8 @@
> +config PCI_BRIDGE
> +    bool
> +    default y if PCI_DEVICES
> +    depends on PCI
> +
>   config PCIE_PORT
>       bool
>       default y if PCI_DEVICES
> diff --git a/hw/pci-bridge/meson.build b/hw/pci-bridge/meson.build
> index f2a60434dd..2e0eb0d233 100644
> --- a/hw/pci-bridge/meson.build
> +++ b/hw/pci-bridge/meson.build
> @@ -1,5 +1,5 @@
>   pci_ss = ss.source_set()
> -pci_ss.add(files('pci_bridge_dev.c'))
> +pci_ss.add(when: 'CONFIG_PCI_BRIDGE', if_true: files('pci_bridge_dev.c'))
>   pci_ss.add(when: 'CONFIG_I82801B11', if_true: files('i82801b11.c'))
>   pci_ss.add(when: 'CONFIG_IOH3420', if_true: files('ioh3420.c'))
>   pci_ss.add(when: 'CONFIG_PCIE_PORT', if_true: files('pcie_root_port.c', 'gen_pcie_root_port.c'))


