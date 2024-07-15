Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD449C3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 09:46:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTIHh-0003Ag-N2; Mon, 15 Jul 2024 05:46:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sTIHb-0002XM-9O
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 05:46:11 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sTIHZ-0005to-Nu
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 05:46:10 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-42726d6eca5so29327375e9.1
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2024 02:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721036767; x=1721641567; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Xj6bwdqhiWQ3fLyuzN05WrRvckrSIMS6gCDDt+KD8Xs=;
 b=IugAecbu/ypNAyM3/diVeGeUZlhSBhWdsFebuof67AQtPPv9D994inJdGCSR8hgEsY
 YCHQcFm4yuItRVos3Zs1iML8Pyrs90wGz1M1Jslo1xAobdE1gmhNwCgImkrWH9YVaPG+
 bdquFLSYW5ivcQ9oyXpQeO3b7S+/76j13pbSAkwDAgKz/4lEkRhqZuRXE1DBIHirzfvW
 MIl+l44UFl+ZE+JaSKiGhmZtxNO24aWH97vZBRBmxDfSFMGt7i0WiXvB7XStTBoTb7hk
 YskoftYCFHUrSZLakcZH0jUfwUZU6FzhYwc4MHfyeO0grHifCKZF7MAb6KEx/hc9rP/Y
 EVZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721036767; x=1721641567;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Xj6bwdqhiWQ3fLyuzN05WrRvckrSIMS6gCDDt+KD8Xs=;
 b=Vouncd4sNFHdLHN1ECOjIjgNdgelJT4Ar62mAIVbzNKohlaVbhX3UZnBsY30TxkWuI
 HD/KGlDCvHeZYsbSXpsdnYXiHjWthUAlfA1rjOdNY1BE48cCtpMXKwcjZY5idU2HHzbO
 4b+fnW/adHHRnV8gm8/Y/cUP/TL/TnR7wSIdn6nBPfPrYGcm3RODSxFbaFtb9ZGObTzt
 NPZcZ0srGtM662C5sl/FdDRr6+2vPuEz4nNIg/1fiP9MBzoI7o0HIk2ReDGmB47on2FV
 30p3kdE2Re5/1WZLFj2oD9msGc8XCO4eIjtVLmu/1+BG9V9MDQbdGccujR6s8NFtT0D8
 NToA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV9npzekkoh6GIkslvSeKgyHdOB7LyKdlF0jDfcTxpuEc1qbThtoUAhoc34b6sAvyvj8a/5i93+77mKFgrdfohTwIoR7bc=
X-Gm-Message-State: AOJu0Yxf8ttRW4ROACqn6i0Cw4ojs/ENMC6LbvPklEXk5Z40nOkaEfur
 ezAKiNb8denDtx5wRO3QqOMU6J9GnF6YS/J/QbzXv7yrBcC0G1rinz4d+9Fw550=
X-Google-Smtp-Source: AGHT+IFz7dahbhDJ90FO3e7533XXW+WxiJt+FVfX0PK8SbUachVHVzIXezK4VyZ+0mTpIWIpOJAxtg==
X-Received: by 2002:a05:600c:6d4:b0:426:6b85:bafb with SMTP id
 5b1f17b1804b1-426707db6e7mr106982815e9.20.1721036765608; 
 Mon, 15 Jul 2024 02:46:05 -0700 (PDT)
Received: from [192.168.121.175] (91.red-95-127-43.staticip.rima-tde.net.
 [95.127.43.91]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3680db048b3sm5809576f8f.109.2024.07.15.02.46.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jul 2024 02:46:05 -0700 (PDT)
Message-ID: <7312c610-0640-4d95-b9cc-8262106f0c20@linaro.org>
Date: Mon, 15 Jul 2024 11:46:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] hw/vfio/container: Get rid of qemu_open_old()
To: Zhao Liu <zhao1.liu@intel.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Laurent Vivier <laurent@vivier.eu>
Cc: =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 qemu-trivial@nongnu.org, qemu-devel@nongnu.org,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
References: <20240715082155.28771-1-zhao1.liu@intel.com>
 <20240715082155.28771-5-zhao1.liu@intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240715082155.28771-5-zhao1.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 15/7/24 10:21, Zhao Liu wrote:
> For qemu_open_old(), osdep.h said:
> 
>> Don't introduce new usage of this function, prefer the following
>> qemu_open/qemu_create that take an "Error **errp".
> 
> So replace qemu_open_old() with qemu_open().
> 
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Cc: "Cédric Le Goater" <clg@redhat.com>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
>   hw/vfio/container.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


