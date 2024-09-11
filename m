Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8444EEE01F3
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 05:51:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soGFg-0001f7-Qy; Wed, 11 Sep 2024 01:50:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1soGFR-0001WY-Ct
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 01:50:40 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1soGFL-0006KH-PX
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 01:50:34 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5c3d87dd4c3so3238617a12.3
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 22:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726033829; x=1726638629; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JRpJ0yC+pw08bpum2VqRCaGzVKgHygWh66dJBO5C4+I=;
 b=EJbvcjWsaPi7ahzwJ1q3JwErIFxLGtrFW7BrkXnlwXc6orFdtAu8bnWXhRXeRW4jgu
 2eTCzJx+0gG80wYd8CeDfSIFcducqb2y+OQDSaSnQDP3Tz6kq0k64c/ld0lXyrbOj+/q
 DO5I1vbVrX4zN7YQmQfHX9yPRUUfkbqN/LNomeEmEP+uOBykVTBlJt0eLpMmJ/0lqx2A
 DqSGNfx/WbP0dBDiO1+8AWBCH3bXMKIeqPB1lADC4JX8LhjvZ6jkPlOdaN8sncaqu1aZ
 5kCyo3oLYSDqHx8Q8foCcw2LoRaeWXINplQuaZdJG8A5T6Z+GlHlQxYIOBO3fhO/BX1o
 ZfWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726033829; x=1726638629;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JRpJ0yC+pw08bpum2VqRCaGzVKgHygWh66dJBO5C4+I=;
 b=JsF+A07WsR6tVCdCKZathrxW1sgjINUSZZ6sv355zrQjNfAqNCGA/4bUWOcxdcGKzy
 2Ia5vmutauklOn2kA+IowcE84oWvzrZOzb9ZKTURvFuOI2lHsSd7eemvfirTn99F8IYf
 IG0cpy8Ka6WzVwIHhKizFQtv1gRwXEsuQVcf73BbMbY9SPRDRlHsdJCyIqLvK8jDmrin
 BgxlS41atKvUej6croKBRT5LmBkzRKtqeJk0Yei4YcS12JP/IOEby4Rx9myzScXKhPKl
 YGoTMdXOTT1F6dCAM92DJJIG70YkvN9s+u7/mYaNOkEbIZ+ROkVmxJFhGvg7E4sAoZtF
 j8xQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUiNHAERJnKn5aBO6nEX4QPs5jkSAKaA0wRLJAZDrNSXRCRTDiOIaDA8/IWOFE44QXvHm43nEAWgZqQ@nongnu.org
X-Gm-Message-State: AOJu0YwJPL7C9Ln+n8SD4CFGDJ3co6Ag3ytuuJW6caRSMUCxp+q03o8j
 /SyqZHZbHh/KjiHcFri73teavVBVD9edZlRyZU6Txfu+XFcZdYHyhUBX+Jf5JUw=
X-Google-Smtp-Source: AGHT+IHtNdz3JGktS1H6wUw6Ej9fupOVxu56YnjbGwav8RYfVLrdhTufWQK43MuqJkz8VsNhlc+DKQ==
X-Received: by 2002:a05:6402:35d5:b0:5c2:70a2:9418 with SMTP id
 4fb4d7f45d1cf-5c3dc77adc4mr16028699a12.6.1726033829158; 
 Tue, 10 Sep 2024 22:50:29 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.196.107])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c3ebd8cc1dsm5033853a12.94.2024.09.10.22.50.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Sep 2024 22:50:28 -0700 (PDT)
Message-ID: <3a7fc1f2-1468-46a8-9075-7b1bf1bd6149@linaro.org>
Date: Wed, 11 Sep 2024 07:50:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 19/39] hw/pci: replace assert(false) with
 g_assert_not_reached()
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, "Richard W.M. Jones" <rjones@redhat.com>, 
 Joel Stanley <joel@jms.id.au>, Kevin Wolf <kwolf@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Corey Minyard <minyard@acm.org>, Eric Farman <farman@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, Keith Busch <kbusch@kernel.org>,
 WANG Xuerui <git@xen0n.name>, Hyman Huang <yong.huang@smartx.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Michael Rolnik <mrolnik@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-riscv@nongnu.org,
 Ani Sinha <anisinha@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Jesper Devantier <foss@defmacro.it>, Laurent Vivier <laurent@vivier.eu>,
 Peter Maydell <peter.maydell@linaro.org>, Igor Mammedov
 <imammedo@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, Fam Zheng
 <fam@euphon.net>, qemu-s390x@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, Eduardo Habkost <eduardo@habkost.net>,
 Laurent Vivier <lvivier@redhat.com>, Rob Herring <robh@kernel.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-block@nongnu.org,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Helge Deller <deller@gmx.de>, Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Yanan Wang <wangyanan55@huawei.com>, Peter Xu <peterx@redhat.com>,
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>,
 Klaus Jensen <its@irrelevant.dk>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Jason Wang <jasowang@redhat.com>
References: <20240910221606.1817478-1-pierrick.bouvier@linaro.org>
 <20240910221606.1817478-20-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240910221606.1817478-20-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x529.google.com
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

Hi Pierrick,

On 11/9/24 00:15, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   hw/pci/pci-stub.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/pci/pci-stub.c b/hw/pci/pci-stub.c
> index f0508682d2b..c6950e21bd4 100644
> --- a/hw/pci/pci-stub.c
> +++ b/hw/pci/pci-stub.c
> @@ -46,13 +46,13 @@ void hmp_pcie_aer_inject_error(Monitor *mon, const QDict *qdict)
>   /* kvm-all wants this */
>   MSIMessage pci_get_msi_message(PCIDevice *dev, int vector)
>   {
> -    g_assert(false);
> +    g_assert_not_reached();
>       return (MSIMessage){};

The tail of this series remove the unreachable 'break' lines.
Why 'return' lines aren't problematic? Is that a GCC TSan bug?

>   }
>   
>   uint16_t pci_requester_id(PCIDevice *dev)
>   {
> -    g_assert(false);
> +    g_assert_not_reached();
>       return 0;
>   }
>   


