Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F66BC25B74
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2024 10:52:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5Nrk-00069q-Lo; Fri, 10 May 2024 06:52:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s5Nrg-000652-94
 for qemu-devel@nongnu.org; Fri, 10 May 2024 06:52:36 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s5NrY-0002GO-FS
 for qemu-devel@nongnu.org; Fri, 10 May 2024 06:52:29 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-34e0d47bd98so1592315f8f.0
 for <qemu-devel@nongnu.org>; Fri, 10 May 2024 03:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715338347; x=1715943147; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hYW14JKjymgirB2SYDe9Ipif/DTEKSTl78ojtDDTuVM=;
 b=W62gSmQr2QBUz67eUin2QwnphMS4BOb/i7u1zpyOBhLVle4KWB7oFI0cnkPI5gdH5p
 YemiFwqPvmg+p4ZwTRAWMoqBFMTAU/SPs1nvOfjt+STZAHh5sS5NufAuASycDxTx9DvG
 TXTn/VOPIhItkzChUEz1unNHIPhDgZa213hOnDYXD+fTRg3iSOn/TYUza1wpG1agslqE
 fceuHyXDodq1Fd9uOFiHdovn5MF1G/Zf3oA4LzgKp6gWL+dynJAP9xmr4385W3yql+E6
 3EEsVpygFgXFZFIogRPJBhGNGarnylIiafi7dxa+jhdMEKyc6pVJkG6YMnKm8CyVpCeE
 7SMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715338347; x=1715943147;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hYW14JKjymgirB2SYDe9Ipif/DTEKSTl78ojtDDTuVM=;
 b=Sg8qAw4TuerVrp4bzoUiuyBVeRD6YjtwW3ea6GszgW5BwTIPO+b4r/OsQqb570zsnh
 imEEAixjroDbaQPvQEtVt87Cbjvw4cxPdbFWnIma1g4AEPy6asa9XlgCphhk+TnU2u5w
 oqdKwXN7WlJYegjns43UD6nZpskVaYTpsFY+ZWL8lSmgOrdbZSaU5ypfpWNPWK1k6qnk
 8uMcDhoKe1XHiFsLHX2Tc/Ed5bkNe9jTN6De102rQeT6T0/1KSMZUD/PHxXZcr0xvZYN
 GNkdn/lIp/KkN/y6qcl+kZjxs4eHNV/nZBGqtq2eq2ddfSWUFLuG6n2+5srWxETWmXkN
 VQHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNJaPqmytUnEQBcfycBWOBW7zG20kj6UDrvWTWwYIpBsnRMdiLVRrPToO4h/dYd4OpJPOJ1ec+lHpK+O7f4ggxh4MhYy4=
X-Gm-Message-State: AOJu0YzvQ/PEHVWhBL85wjK9/eSAIuZYxI+hnuFcSvjAuMUB/cwKvqAo
 tdspx9WoOGKbF27baZ8efcoH1lRfDH/xdKsNlK7I7H/jalUnsXESQYXWJ7MfsmE=
X-Google-Smtp-Source: AGHT+IFU3u/y2UrHmABw1XdsbGyFwKkZqq96+1CpELjvr9yJ5KGhppRHGPxd2IXYiyT+8aO2lwBBFA==
X-Received: by 2002:a05:6000:a88:b0:34d:a19b:56b2 with SMTP id
 ffacd0b85a97d-3504979cef4mr2294183f8f.3.1715338346862; 
 Fri, 10 May 2024 03:52:26 -0700 (PDT)
Received: from [192.168.69.100] (sev93-h02-176-184-17-152.dsl.sta.abo.bbox.fr.
 [176.184.17.152]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502bbbbf9esm4219585f8f.91.2024.05.10.03.52.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 May 2024 03:52:26 -0700 (PDT)
Message-ID: <dee02518-bee9-4f92-bda1-df67f7d07f04@linaro.org>
Date: Fri, 10 May 2024 12:52:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/13] xen: register legacy backends via xen_backend_init
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: thuth@redhat.com
References: <20240509170044.190795-1-pbonzini@redhat.com>
 <20240509170044.190795-8-pbonzini@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240509170044.190795-8-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

On 9/5/24 19:00, Paolo Bonzini wrote:
> It is okay to register legacy backends in the middle of xen_bus_init().
> All that the registration does is record the existence of the backend
> in xenstore.
> 
> This makes it possible to remove them from the build without introducing
> undefined symbols in xen_be_init().  It also removes the need for the
> backend_register callback, whose only purpose is to avoid registering
> nonfunctional backends.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   include/hw/xen/xen-legacy-backend.h | 14 ++------------
>   include/hw/xen/xen_pvdev.h          |  1 -
>   hw/9pfs/xen-9p-backend.c            |  8 +++++++-
>   hw/display/xenfb.c                  |  8 +++++++-
>   hw/usb/xen-usb.c                    | 14 ++++----------
>   hw/xen/xen-legacy-backend.c         | 16 ----------------
>   6 files changed, 20 insertions(+), 41 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


