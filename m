Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3837EEF070B
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 05:17:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpJdd-0004yz-Cy; Mon, 09 Feb 2026 00:16:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vpJdb-0004xu-Io
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 00:16:43 -0500
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vpJda-0000pp-3D
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 00:16:43 -0500
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-c613161b489so984134a12.0
 for <qemu-devel@nongnu.org>; Sun, 08 Feb 2026 21:16:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770614200; x=1771219000; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XEInEsbtA7C5c3ggAOe0PCoEv583kqmg82QgOAs7IVM=;
 b=MqYzgQve7mai3QfVTtB7ghmYlaXnv+Ddyg8f3hw7zziqfphnLueKtMBUeN1Tt/30Ey
 F6A5B9y3yXzMO4BtgEEDT/knN4tS8kqzBrbisN9hto/+eP/BxpwQtQMDSqUeNPdOsXwg
 L9hrihwicsvcViGBt/NF3Snng+zljof7YeFNuw8cxUKHguBKgHENbWKeYESK4WKpWROF
 ng4PUKnD0ZyGVgHZMcFitsTI2W+KkwCzInUd8Fpo8tXLDJCVMYJViF70cBYXEbAE29m6
 dA7pgpGAvTxjEmXAWFWshFVmuEjsyapAdL1P0ycGmfP9XS6ahNYED5430onb/XlI1DNF
 CiWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770614200; x=1771219000;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XEInEsbtA7C5c3ggAOe0PCoEv583kqmg82QgOAs7IVM=;
 b=I51a7D95Hu+XEMCcGTtaSaSzhfBwqBA8L9KbFpgms8o0x43huKtOAmJSGPZDaydwx0
 OPPHmD9Y+zD6Rg7ySCiJvK+Ri9z9YAJlJ+y6+JvBTrajgd400JaqRRJjbO6sdwRDJVTH
 eHwCYI2DzF8hH7SQlrhDxSo9ZAI1W71UMW0fBwHtKj6wcJAepJ7BpjNv060Uu8pEX0+G
 K8Kj++e4xBqUY0CNkJW3q0eyyIPxv0G8EGQOHeg+Q4vbIaiL9KaUOSVY8WQwYKR/aJDg
 gnLlM+uCke74Nst4nE3gv8qxDEPwAOYbpp1aWpuW+9FQkoKE7h+PCBWhD0RgZy5f1tAB
 lSkg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWsSYAxCIAcCMDkHYsevSKXIkWK2OMsTOCbjOeYS79ohKFKGhH+WIzI/PQhBYl4pgDIf0f/YxEWt2ZQ@nongnu.org
X-Gm-Message-State: AOJu0YxGFCVZAciQgdiCrhS72L4ROxAww55XC5D3bswO8+LFY3NkFhji
 K/mFXyhcz0DH7JI17gZLGXpaYOPJnUc0YaSgvu4Cjc+5zvtztj1dHz6KzkkTvyhUOuI=
X-Gm-Gg: AZuq6aJGj4o0Vjs86ZkZCeajzcTtd+w+HRjFC2IxQK7nQF7r9fy9QyLChag7YVW4996
 XYBzyau3f8dInrhxNJdHAWH2rJwDz868miXUNMcQp2A9qgbkOh5PEQbGkCc2GxCNIoWzCDUeuaS
 E6UynR/Fxf3HsGDlbh74gxQAMnOelH1Q17nVys2zEz+iOxz2cIT6URij2j36rLBQS/kIzMDcvFm
 2he4XWmOKT6Kq7IL+0nabkqEkgRlL3bLIR7K1BBIly4k5kvuAAAPUi4vK/s2ro2xigbUkaYgeSx
 WKzk0fC1eyBinM+TXsfmuaYSNS0Z5VF1JDFNhS0F2X4xRuxvgv1YeUKWMxUO0mLS929ulQydP7H
 KA7DGDzngt8lE9MhYkLGXsdVDWMEFNE0umxv+ViYQ0brNtIJLAtAXG0zVEnlFblNliTmM+OHRhc
 PpCFqKlO8siRM+HDTrJF1RnYbAPG37I9x25bMD4nBh746kv2R6cxnjLzW5tPkQEUU=
X-Received: by 2002:a17:90b:4c09:b0:356:24f0:af08 with SMTP id
 98e67ed59e1d1-35624f0b490mr4159125a91.1.1770614200444; 
 Sun, 08 Feb 2026 21:16:40 -0800 (PST)
Received: from ?IPV6:2001:8003:e109:dd00:9c4:a3d:914:f9b?
 ([2001:8003:e109:dd00:9c4:a3d:914:f9b])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-824416d62edsm10976119b3a.29.2026.02.08.21.16.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 08 Feb 2026 21:16:40 -0800 (PST)
Message-ID: <1c1ce443-26a9-43f9-b5d0-a22d1eb51e26@linaro.org>
Date: Mon, 9 Feb 2026 15:16:33 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/9] hw/virtio: Use VirtIODevice::access_is_big_endian
 field
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>, Nicholas Piggin
 <npiggin@gmail.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, stefanha@redhat.com,
 qemu-ppc@nongnu.org
References: <20260206221908.1451528-1-pierrick.bouvier@linaro.org>
 <20260206221908.1451528-4-pierrick.bouvier@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260206221908.1451528-4-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x532.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2/7/26 08:19, Pierrick Bouvier wrote:
> From: Philippe Mathieu-Daudé<philmd@linaro.org>
> 
> Endianness access is constant between device resets.
> Use the field instead of calling the same function.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> ---
>   include/hw/virtio/virtio-access.h | 24 ++++++++++++------------
>   hw/virtio/virtio.c                |  4 ++--
>   2 files changed, 14 insertions(+), 14 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

