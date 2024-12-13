Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86A59E7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 18:41:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMAae-0003Dx-PV; Fri, 13 Dec 2024 13:40:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tMAad-0003Da-8c
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 13:40:39 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tMAaa-0007tK-3h
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 13:40:37 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-385ddcfc97bso1597513f8f.1
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 10:40:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734115233; x=1734720033; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IyBP9SBndSjS5MWUWE3VIDT8hS8lKPhnWXsHiJwPW04=;
 b=ASjKvhsVdDFkHgmh1eUbC53ioh5Y35xNDjwVlnWk/TTAhOMSRc8SJpS6i0zzlpUSb6
 wgdf1WEwAR5bJKY+EqUTackMF/kZgZKXuNwSpumNXaljmEr97X1BM0JAtpORXCDsvYVB
 0W/xz6r5h/rtDU+UmeEfo3mZDdHNRvxZrPtmiq6A+3ib/EX0OtQ0hLSKmySGEWaIL7wg
 HD0Yrwf+HT1cU2hI/T9gZtwcjcsYjW+NpJio8zGpRYZR31NONAOXW5TvrJG4I8AW4LSL
 puJLC5bmfirBoqWj3r8b5eXJkLv8zRCQpW0pYgdGt4LX86qHfQ6QX8xSPyJrb+lHn8xH
 ho+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734115233; x=1734720033;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IyBP9SBndSjS5MWUWE3VIDT8hS8lKPhnWXsHiJwPW04=;
 b=KvaqjpbzCTCg4IsX7iSyVsP/PDTr0oQt1LXc6fwM+4p0/hW9Qe410mFYyVLEhVgP5N
 ka3PLe6gA6UtKv2f4tYJQnXRh6f8R8nFmR6CenCCG0qkiimz4fhFbSCfVmn31KYiDuml
 CNuDrbsAHeObO2RKGTw2DJI8YO793kTfzKJ15CSfvFQ6sB56u3POSmOacAX4V0MQdhcO
 RQKFcExQUkQ/zhUNJ0XNp3hkwU4f5RBC6F8/wWj+xqwcyFxBC0g1z7ZZZkZyi0NLwrCK
 VCBdwb1biLGdYmYjIDxaPdZXb37YYlq4x4POUv/hLnV0ZYEo8A9AJer1n4bwVDFmt32J
 d7wA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXN+FGBQHdA1cVr0fkz5EHib6bv1VG3eNQ/raV4TlyI2K9kiUuekZcaHjez7Jim7J9UhDNIZYpB5wS@nongnu.org
X-Gm-Message-State: AOJu0Yy5MKMbowBR4FPM5HOLvbXTmtqs+dwKDBculwvYQK6TKxvtExAq
 77F2qyBf62ONi8reVQoxBRVmu6wS6hyrT0UXU5fvlmfZyDgNk2G9HzTFnnqIWyg=
X-Gm-Gg: ASbGncuAH2PjknMa6ZZ5ngwFlVSMZGz9LTlmcItiNG5wkfT1f8dx8UmUBbaHxwaUJG/
 JHKCpCBqdBD4GBbJEU/Py/dAq0Tm1kVWY3m3uMQrvtFksKHem1z3xuGinkwER+vcNk092nY1K9I
 U6wKAaDU+JH3LLx2zVAEnlTTlqeqLWGNxwa6HrMrRSYjTug5A4AVJCWe9Ue1cYafUrd5DfzJvhC
 7geswn421uy1Tazgdcmu8ZU0rXKlw2qyiY8zw58qSMK4Z3GajKtcqT2AhYqT9BIQSLd5wpUzXKB
 qcJquuS/HvXsw5OasDcCs2vLJy6SEXP2jZrz75+B
X-Google-Smtp-Source: AGHT+IFQLpZTpUy91g3WVwjpkcehKd/eau06m8y9wsJXLfL1mLXwMmas2duxMWlzjLY+BCtP4vweeQ==
X-Received: by 2002:a05:6000:481e:b0:385:e9c0:c069 with SMTP id
 ffacd0b85a97d-3889ad37dc4mr2871542f8f.57.1734115232785; 
 Fri, 13 Dec 2024 10:40:32 -0800 (PST)
Received: from [192.168.224.213] (183.red-95-127-61.dynamicip.rima-tde.net.
 [95.127.61.183]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4362557c502sm57334265e9.11.2024.12.13.10.40.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Dec 2024 10:40:32 -0800 (PST)
Message-ID: <b1cffea1-9365-45f9-b567-b1952be66b20@linaro.org>
Date: Fri, 13 Dec 2024 19:40:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] hw/usb/hcd-xhci-pci: Move msi/msix properties from
 NEC to superclass
To: Phil Dennis-Jordan <phil@philjordan.eu>, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, thuth@redhat.com, zhao1.liu@intel.com,
 imammedo@redhat.com, akihiko.odaki@daynix.com
References: <20241213160619.66509-1-phil@philjordan.eu>
 <20241213160619.66509-3-phil@philjordan.eu>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241213160619.66509-3-phil@philjordan.eu>
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

On 13/12/24 17:06, Phil Dennis-Jordan wrote:
> The NEC XHCI controller exposes the underlying PCI device's msi and
> msix properties, but the superclass and thus the qemu-xhci device do
> not. There does not seem to be any obvious reason for this limitation.
> This change moves these properties to the superclass so they are
> exposed by both PCI XHCI device variants.
> 
> Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
> ---
>   hw/usb/hcd-xhci-nec.c | 2 --
>   hw/usb/hcd-xhci-pci.c | 7 +++++++
>   2 files changed, 7 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


