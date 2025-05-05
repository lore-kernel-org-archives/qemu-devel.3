Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DE27C369C2
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 07:09:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBpwH-0007ql-RN; Mon, 05 May 2025 03:08:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uBpwG-0007qY-D7
 for qemu-devel@nongnu.org; Mon, 05 May 2025 03:08:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uBpwE-0001cF-Of
 for qemu-devel@nongnu.org; Mon, 05 May 2025 03:08:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746428909;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VGUxwV8y8RRbGT/iyxVZZGeQk9RpPey1+C+CJYCet10=;
 b=i2an5SO1hyhDmZIshUJ8EpPyAzPhjMbzdaJYPAutfIgxFvMufoBsAbN1QUMMup5NmcrjCX
 6Etp+eC/dcrLDzF0va8g8auZ0EyZebM5tuN9RjErgvhpUo9b7i5ZZgEukKg4O9CXiCrWEY
 rdpVkRTUJ0EX6ppYSg46nrdRDaiqT0E=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-EWlS1LFiNZWzSag_1LqyIQ-1; Mon, 05 May 2025 03:08:28 -0400
X-MC-Unique: EWlS1LFiNZWzSag_1LqyIQ-1
X-Mimecast-MFC-AGG-ID: EWlS1LFiNZWzSag_1LqyIQ_1746428907
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43efa869b19so24151375e9.2
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 00:08:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746428907; x=1747033707;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VGUxwV8y8RRbGT/iyxVZZGeQk9RpPey1+C+CJYCet10=;
 b=T7gErfq6qXCfyznPkECZapnXdTFzWbD7NpgBuo6PwNvRwK58s2JT+58vPh/bgK1C4V
 kTnQR9e53na+1AYdGlRgB8Fu+fnJa+WiSBPF66yUozkecHahpBgO6YHDFf8SPE29Zl5o
 1lem9tRCc6qJDdHQnqyXTAJx/aIKcesxZ9eceDAdl8PMQ/M71rBTPRHgQS/sAIwFY5b4
 T8BhjLKN2wUGUjfKRPqGI11xMqHA/dpDgQaMo2h/LPaMAoQbaGXCo/CPN7TSRWNEbn32
 SxhFa/qXM9s1luYlElx5hHNkL8U9ba8MUuFTmuxjoH5K4wpR9WxMP9SEZPxBeQpEFC8d
 pqjQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1FiEa2pMaDY825Y8eIiZy1uA1nhTC9M0p8/AiAtdukAqxEAYJlHfhtksi5Ugp06ipOoRToz8l/4hL@nongnu.org
X-Gm-Message-State: AOJu0YwCGzZfnDiX7x7leUWxXmyXgFIgoZNnHAoj21YEH9V0WGtkm5Gd
 7/zTb4qQxRTuXBmtH04ZSi6RT9fzm5Ou1O4/MEuV67F/D8hzf5SYvdRi9GVflWxXlSDOp/pY6NI
 NEV99q3I5rR7M7DF/WxgzJ7dHEhSsOmQZXACgEKbdnfzT8cxhusF5
X-Gm-Gg: ASbGnctB3ZuxsWldOGl9hI5AEgGjE6bc4xgseSKvnPuoXwkH9SNoNsVe21yjifk/SRL
 g4+PCBozxZ746JWA6Idq8HGPX+RYgAL+sRbdEmtJbfKsUtXwWxXEQsa2jXcXNw8fmErxXkvDMXw
 cNN8hmMX3Th9tmXbgPLi/MJOIg5qqONs+owOW5bmzNwXcztqEUHbXLR9XGBEy+G96bQidX8h/6c
 db4lWXuGXNHUr3raYYudCOiq5n0ZcxAzP9ikEzk00nZ4scoVq+3jTtGCXS43t5W03xikqKN9Ajr
 yRxfK58iiuJitp+hx3oDQIc/QZcgInxIb/mA0oVmTSV5xMoHtRSVB5VaGh4=
X-Received: by 2002:a05:6000:40db:b0:39e:f89b:85ce with SMTP id
 ffacd0b85a97d-3a09fd82f5bmr4421104f8f.26.1746428906940; 
 Mon, 05 May 2025 00:08:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1JD/wNGesZh9SgZWIHRqazn3WQLTe3rtPiVRwm5jo1VxGMVfGWz3P1PO/OpnK9u+iIDY8sQ==
X-Received: by 2002:a05:6000:40db:b0:39e:f89b:85ce with SMTP id
 ffacd0b85a97d-3a09fd82f5bmr4421080f8f.26.1746428906594; 
 Mon, 05 May 2025 00:08:26 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b2b20aa6sm170652435e9.27.2025.05.05.00.08.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 May 2025 00:08:25 -0700 (PDT)
Message-ID: <676f19b8-8187-4b9a-b2f9-9a6fe839ebd1@redhat.com>
Date: Mon, 5 May 2025 09:08:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/i386/acpi-build: Fix typo in function name
Content-Language: en-US
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, philmd@linaro.org, alex.bennee@linaro.org
References: <20250504215639.54860-8-gustavo.romero@linaro.org>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250504215639.54860-8-gustavo.romero@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.411,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Gustavo,

On 5/4/25 11:56 PM, Gustavo Romero wrote:
> Fix missing "i" in the name of the function responsible for adding the call to
> the PCI notification method (PCNT) in the ACPI table.
>
> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
this is a dup of
https://lore.kernel.org/all/20250428102628.378046-4-eric.auger@redhat.com/
nevertheless
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Eric
> ---
>  hw/i386/acpi-build.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index b5836417a0..f40ad062f9 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -589,8 +589,8 @@ void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus)
>      }
>  }
>  
> -static bool build_append_notfication_callback(Aml *parent_scope,
> -                                              const PCIBus *bus)
> +static bool build_append_notification_callback(Aml *parent_scope,
> +                                               const PCIBus *bus)
>  {
>      Aml *method;
>      PCIBus *sec;
> @@ -604,7 +604,7 @@ static bool build_append_notfication_callback(Aml *parent_scope,
>              continue;
>          }
>          nr_notifiers = nr_notifiers +
> -                       build_append_notfication_callback(br_scope, sec);
> +                       build_append_notification_callback(br_scope, sec);
>          /*
>           * add new child scope to parent
>           * and keep track of bus that have PCNT,
> @@ -1773,7 +1773,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>          PCIBus *b = PCI_HOST_BRIDGE(pci_host)->bus;
>  
>          scope = aml_scope("\\_SB.PCI0");
> -        has_pcnt = build_append_notfication_callback(scope, b);
> +        has_pcnt = build_append_notification_callback(scope, b);
>          if (has_pcnt) {
>              aml_append(dsdt, scope);
>          }


