Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60207C2BA18
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 14:00:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKIKa-0007Cb-2G; Thu, 20 Jun 2024 10:00:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sKIKX-00078a-Ty
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 10:00:01 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sKIKU-0000eZ-TZ
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 10:00:01 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a6fbe639a76so152576366b.1
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2024 06:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718891997; x=1719496797; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BGsxEaTNuC57O6z4vFE9ymtQjGIOPiXQJYO+Jd5DRaI=;
 b=WEDugNMpngrkelX2io24Y127O8SRT0s8wUSz24Yj1lwqZQBCQxUV2nsb47aoKsRvCy
 aFwizEaEzXRLsYa/iNZGDZXM6O1hiOkxihMmrtZKwR5/fKLYPDbFyrmdADnu6xOLV7C9
 U28ttHdOmVk0s4Yj7pFwYyOnMJAlgdsgpkG4TI2CUI2MLa5DIbIS1Xv3SqVC7Id1JtvV
 IxvP/wlx6K/uoB0DknvuwxqBJrJG7YU2ikAU+oyiBCrUxV60KVlWgUpwJgs7kC/ioqc+
 LxjAHjwbuLfAW7DsM+ydnm8oX2iEy8PHKhEMDFCU7WavLAd0JlksdS79BPgZ0DOVDDeW
 c3ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718891997; x=1719496797;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BGsxEaTNuC57O6z4vFE9ymtQjGIOPiXQJYO+Jd5DRaI=;
 b=Er2VAe4ZduF+TzoMrhuNcPbnYqmTi3T92CDQFCBU9tH/DjrsQ/eVXDU9M84El39oA3
 G4xuTEdFlNKcJQ/2PLRkaErWaJfeLJmKakkgoV7uypK4nPj1SqjMAhuXgUNs9S7wV98D
 H+oRnOxvci4bGJbmw+t49NYz20aWaVIizZa6Wo5/vw03U5qW+meliNJZwVpAf3FN3nY9
 UEHJz5lgBzugw+CQrzOoQVpvYn3xthdbHlISD8axHZ2Ochi70NZ3XdcmWbTHMqCEBQSq
 DLb+bRCE8Ki8Ixux8efuGhJwH2fakA0Sro2VLR//wTC/jEaeJlp4dgGT+FqDDX94jfQn
 voxw==
X-Gm-Message-State: AOJu0YyuAo+MleGCKj50T7FsWQ4Kpchr1dm8hOho7+OD0bMIz/UuCeRx
 VBQlyO8b4xEGBDNNnsmihQl8Xe3HIyMuw9F/81Zlrep7CAWDQjp9TMjiBgnW4lEkQ26OsxqGeuf
 n
X-Google-Smtp-Source: AGHT+IGq4DN0lEzyURfwXzJzwBbaryjq0aGqetHdfWd+2/sd2FXNqQ+5iSmykGs9VXgHKJmK3Gu84g==
X-Received: by 2002:a17:907:c5c3:b0:a6f:c24a:721e with SMTP id
 a640c23a62f3a-a6fc24a7479mr138545466b.30.1718891997020; 
 Thu, 20 Jun 2024 06:59:57 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.151.40])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f56fa674bsm774690866b.210.2024.06.20.06.59.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Jun 2024 06:59:56 -0700 (PDT)
Message-ID: <fb591600-31c3-44ad-a621-d14b6d84994e@linaro.org>
Date: Thu, 20 Jun 2024 15:59:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.0? 0/2] hw/sd/sdcard: Avoid OOB in sd_read_byte()
To: qemu-devel@nongnu.org
Cc: Bin Meng <bin.meng@windriver.com>, qemu-arm@nongnu.org,
 Alexander Bulekov <alxndr@bu.edu>, qemu-block@nongnu.org
References: <20240408141717.66154-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240408141717.66154-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 8/4/24 16:17, Philippe Mathieu-Daudé wrote:
> Since this is Fix day, I went over this old bug:
> https://gitlab.com/qemu-project/qemu/-/issues/487
> It happens to be a QEMU implementation detail not
> really related to the spec.
> 
> Philippe Mathieu-Daudé (2):
>    hw/sd/sdcard: Avoid OOB in sd_read_byte() during unexpected CMD switch

First patch queued.


