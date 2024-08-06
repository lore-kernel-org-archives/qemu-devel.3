Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B428C3DA64
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 07:51:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbEyS-0000lt-Iu; Tue, 06 Aug 2024 03:51:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbEyO-0000kR-UW
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 03:51:13 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbEyN-0006l4-EJ
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 03:51:12 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5b8c2a6117aso184411a12.0
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2024 00:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722930669; x=1723535469; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PDEmx7+f3t0QGTVu5Xz3O1FYdsZF3VVU6EkHY0mMfIA=;
 b=G0poGqMRGw/xFW2Zaio+64fJPnlH42J13Rmzt97kINqvOv32Mg9ZQQujGOtOqzaTcz
 MZWELuW8dD9OdcfBzvnAUMsQ4xqH7jfzCzgXSSMVpGtjtXWfdkrJFiSM6haUvP8kBM/z
 w3FD6ohMMHboJWpWb2iV2ImY78LcH7glXZ+ti40hBp+no+PZkMPxkqZLQI79sflfcMdL
 A3tzKAMCFQC/YFZvcQNgvd3bML2t8qsHOlNIMO00iu5Ieddk0O5/tB7PJ5MZKaz4Yq60
 gQCVP7rZpLpO+j+G0UtyATy5AstInpVMIUK8NPYAr+zw5MDPMBeoLhy0+CRWLlAR5i3d
 bJMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722930669; x=1723535469;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PDEmx7+f3t0QGTVu5Xz3O1FYdsZF3VVU6EkHY0mMfIA=;
 b=XEVn3plf94hnDQfa4M5aDMJ365lSnYlv1MBZz45qxDoeQ9Zc44Qht+WzO0fMiBqpbe
 h5sk/bZGMbTkduIJga9YAb8feKGZaYv/JuNFkThsjZIJObIsjmxWxfdPbF7HXZb0bdoB
 Qs4+krtb2S2xIav23Jt6QgWi9uR6ftPMb26rMKcaB+X4ogigxVHsxDcF8bdQzMC49g+x
 j8ptKxeoGdebsFOkdqqs70FI3cTuBnBZsh7lAzEJ3IG3tCmR2IZG1/Q6YJxcJSrQ+1Wj
 8W8J/aEO8V5NFl+r5/NN3GVZ9b1EaXRWI0BFXH0ChIlcrSEeNRZJfHxBTvPfBjPUjwa+
 fsXg==
X-Gm-Message-State: AOJu0YwSknLiaz52rxR2hOc02lggulDnM+epDQ3oU+/I1zzysTSFyDnO
 jUrZ6dxp4qCuI6B9v+ipFxwcmOWmUODBhjTfw4z9TVM6F27WD2s2E7e03glsYkExiNKdOM1mgBf
 R
X-Google-Smtp-Source: AGHT+IFaqSk9fexwAHp+ly+fymWf3/8cEW+vgKr5w4lT05WBpMKUnjNp3jM1fSfO4YHlStS7yQUipg==
X-Received: by 2002:a50:ff0b:0:b0:58b:1a5e:c0e7 with SMTP id
 4fb4d7f45d1cf-5b7f56fcbe3mr11041536a12.35.1722930669095; 
 Tue, 06 Aug 2024 00:51:09 -0700 (PDT)
Received: from [192.168.69.100] (cor91-h02-176-184-30-206.dsl.sta.abo.bbox.fr.
 [176.184.30.206]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5bb5117ffa0sm2770302a12.41.2024.08.06.00.51.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Aug 2024 00:51:08 -0700 (PDT)
Message-ID: <ab1e7ae0-626f-4195-b77c-2dbd7a12766c@linaro.org>
Date: Tue, 6 Aug 2024 09:51:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.1 v5 0/2] hw/pci-host/gt64120: Set PCI base address
 register write mask
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>, "Michael S . Tsirkin"
 <mst@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
References: <20240802213122.86852-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240802213122.86852-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x535.google.com
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

On 2/8/24 23:31, Philippe Mathieu-Daudé wrote:

> Philippe Mathieu-Daudé (2):
>    hw/pci-host/gt64120: Set PCI base address register write mask
>    hw/pci-host/gt64120: Reset config registers during RESET phase

Series queued.


