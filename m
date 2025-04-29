Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B7C9C369CB
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 07:22:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9fHp-0000pu-G0; Tue, 29 Apr 2025 03:21:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u9fHA-0000UR-FE
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 03:21:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1u9fH6-0005Jf-80
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 03:21:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745911262;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=vVB8XvINZofjJqBGrpVShbu6NmcVGWfCcaCZ4U88jho=;
 b=eNG01FpyaAi26jtbpArAI5sxGFwIzj4BAElMUtDPlNXdD3rcokixxJkem8A2YfH3MAjCIm
 PdSP7JJBYDCKjl+8nOm7g5vdnfIkFcAYCwY4hACFgBxEH5HO88QKfejtf024rCbFMWS7et
 0CXE7CdQVcZBWaXsXFuVPsZUSnrm9nI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-dbLQt3lCO9iTZVfA379q-w-1; Tue, 29 Apr 2025 03:21:00 -0400
X-MC-Unique: dbLQt3lCO9iTZVfA379q-w-1
X-Mimecast-MFC-AGG-ID: dbLQt3lCO9iTZVfA379q-w_1745911259
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-39ee57e254aso2598430f8f.1
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 00:20:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745911259; x=1746516059;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vVB8XvINZofjJqBGrpVShbu6NmcVGWfCcaCZ4U88jho=;
 b=w+LEw5AfdAHc6FRNwixiFGsyTPF6AZk4NU95Y6oxUHc+FhiP7w9+bHq8iDyxdJFDsv
 JVPmXRcJRKz8AY6n7F8rRJsz42dTqei2XCaqbBDuM6qOx07psum2ZHDst6iANkA5lWNV
 /sp7tOfxCQD4+TQeAERN4J+ULccQt3ASKc6dU3xI4XkXJQ38VKRp9tPOaGxfeqCXanf3
 4IY6YHFr/m/Mv6aCggMCOqBeJUeGUn+zLzM5kIqSWyPsKPorRx4aH5sgRaWL/+LDVk3q
 Mrk7AovUrCtndcqjKVQUefXMPpyyXfPlv5qOqaBHUjFbitoQybQWmWMcuAeyGSw9mqB7
 RzFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXKKhivw7SLu4zBoAryVPkZ3T1lIWtQvxRsbGlv0vlXHpry0/HO0T7HQdIDxGCPSFZJa0GFu+sVkL6w@nongnu.org
X-Gm-Message-State: AOJu0Yypr3o1HNz3oaEmPyize5WkK3xSXykiYuSIr1Y7Z+ymSIh79ZDh
 2Przi3z5O1JLltPwkP4hfY0sMLiq3p5pXiSTNfTplYTB1ZDo4s5skmnlbzk8PPNZD1qHx3eUYXE
 v5PNP9zr2CBaV33a0AnP1bmyISEo9Tnk+LbtkEU98a6TRpK9R9LHm
X-Gm-Gg: ASbGncvz/QmFdRSPNa3OQgMacShca8pCmZzwk+h77cPRFmLtzwvB4tdDqYfxqlHj+QO
 8Q0OqWD5FrQWaybPWjZU592voqTt7hV759W81FXtsCrKuyO3QRbEugPT2mUNnHXa05Q87BIbaNn
 LDrvSCPHxo6+vC4LF6c4ZwxsgnGLfI+JA4CzRvSinxEE6FFY1axRBryQZDHXqOqL8uzW/zv7xVi
 kw0J6nV8PUTJsvpyCuner8eatRWce18BtlrOTy+ersxPWiXdg+oH8bqDpDYTOsCJsgj2ZC6CPN5
 WDUA4RMi6KwkOAqZ7ACDFjmWz5GI2SexppZlNGnYWIwfV0VhQA==
X-Received: by 2002:a05:6000:2507:b0:39f:6d3b:f136 with SMTP id
 ffacd0b85a97d-3a08ad77999mr1017137f8f.41.1745911258805; 
 Tue, 29 Apr 2025 00:20:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHIV8PPuv5sZvkPXU92fr1+s07fh8SGclwE8NENjZ5h+F47VuIGqecS1qtMJqNVnjSXDEyTg==
X-Received: by 2002:a05:6000:2507:b0:39f:6d3b:f136 with SMTP id
 ffacd0b85a97d-3a08ad77999mr1017104f8f.41.1745911258355; 
 Tue, 29 Apr 2025 00:20:58 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:3f78:514a:4f03:fdc0?
 ([2a01:e0a:280:24f0:3f78:514a:4f03:fdc0])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073ccb8e1sm13277230f8f.59.2025.04.29.00.20.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Apr 2025 00:20:57 -0700 (PDT)
Message-ID: <35bd9838-070a-4fbd-834c-a8faef38a21a@redhat.com>
Date: Tue, 29 Apr 2025 09:20:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/1] pc-bios: Add AST27x0 vBootrom
To: Jamin Lin <jamin_lin@aspeedtech.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 Hao Wu <wuhaotsh@google.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Sunil V L <sunilvl@ventanamicro.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: troy_lee@aspeedtech.com, nabihestefan@google.com
References: <20250429062822.1184920-1-jamin_lin@aspeedtech.com>
 <20250429062822.1184920-2-jamin_lin@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250429062822.1184920-2-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.484,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 4/29/25 08:28, Jamin Lin wrote:
> The boot ROM is a minimal implementation designed to load an AST27x0 boot image.
> Its source code is available at:
> https://github.com/google/vbootrom
> Commit id: d6e3386709b3e49322a94ffadc2aaab9944ab77b
> Build Information:
> ```
> Build Date : Apr 29 2025 01:23:18
> FW Version : git-d6e3386
> ```
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> Reviewed-by: Nabih Estefan <nabihestefan@google.com>
> Reviewed-by: Cédric Le Goater <clg@redhat.com>
> Tested-by: Nabih Estefan <nabihestefan@google.com>
> ---
>   MAINTAINERS                 |   1 +
>   pc-bios/README              |   6 ++++++
>   pc-bios/ast27x0_bootrom.bin | Bin 0 -> 15552 bytes
>   pc-bios/meson.build         |   1 +
>   4 files changed, 8 insertions(+)
>   create mode 100644 pc-bios/ast27x0_bootrom.bin

Applied to aspeed-next.

Thanks,

C.



