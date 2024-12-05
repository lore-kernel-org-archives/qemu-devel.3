Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06709E7716E
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 18:17:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJGOR-0002a7-Bi; Thu, 05 Dec 2024 13:16:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tJGOH-0002Yt-IT
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 13:15:57 -0500
Received: from mail-oo1-xc2d.google.com ([2607:f8b0:4864:20::c2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tJGOC-0002p1-1s
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 13:15:50 -0500
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-5ee645cf763so573807eaf.2
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 10:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733422546; x=1734027346; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SHjjLlepmFPlqgUV1bZkJJJczK0H4vjMNTKasxxRILY=;
 b=IGBT2VjsDHqBC4/Efg26lrTAUgEDV08Iu5i8QSItVTTuiBUvPCkcwdLgwhDBOvqvkk
 18eeMHC3AF16EcY5KglKX2efqeH7OdPhyrmu/46n4kAcDu78NHu3Y9f3KDD6ld5hOydS
 zb2IB5HUnj/6dy2b8dgIQCPkFvZlEFRMlcuNEtdSMD0jqMYwHC8R2KKTZjXsLgAhdk01
 1ibkkS3fXsXk9zbb0ZvWdscl7RDtEW+ensqRIlT9PgtMwcp2WteytgRtTQG5y81sIBwM
 9nXDjd/rlobJbsrnp3tCbmoCwbR4ggQDRCk3KKrYw712IhvxJB5lX40VDiS3LxBZn82m
 1wSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733422546; x=1734027346;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SHjjLlepmFPlqgUV1bZkJJJczK0H4vjMNTKasxxRILY=;
 b=SCvW9AFwoHF0S0WAcWuC4j0/eElGecBZiq+TBFs/So1eX5l4Q72yXG6ZTWR5cPNXxl
 8Rwyw3bD4zPEs86w5pGea75WopXt8Cf2KNRkbXSdPiIFH0Z4UPTQkzSoxZwRAoixdf5Z
 F09GaaD9Kii1rf3cel7ONwbNOvqJJ3jsH2wT5e1c+Hp6ZABBT79matgjvgWVjEBrL3b/
 qDRdIKaO/hm4m4PANfDGIjy9zCSeaaacl4CnP1dSJR0xSoUcGZJ6X6cI+f7HGl8bWDt3
 R4z632K0X6KEr+SsXf5fh75ZzLXOXdfNlwDq+AuBg3y03FrPwoX/CW0CV9azyDgBXibR
 ak6w==
X-Gm-Message-State: AOJu0YyAJNBGbDPGUWU1erWIKA+DVnciks6Y241cYaTIq26hFPTQwmha
 NJLDC3wKHPlcM3Du47WLdrITWpOs+DEXx232YWYzakUjforVGKDiGqHjVRLO53w=
X-Gm-Gg: ASbGncubLc2vsqxRxW2aZLOMjytk/tx3gs0gc5BIcq286pPVcOlrEqvbSTpf2ZKQDim
 ycymzz4Pe59aZg6zqyEHtuW3bYqnvYy1ohVt3JnY9Z1BdOXWXMptCqQCWYH76SCmufz7U4xcBEs
 eIt4+6e4MaqRTlgBvcBqJqPLvqizBW8Mq1pU2Tm44z59IU+21UbPVAHPC67Wr/hLT+DjWcf1fAq
 zQX6s6rAPSDrYs8/mmhfN1wzS1M3UpgaGVV8/Z4O32Kfuqlelsiw6I5k9Z0u/NK/Fz6CzVp6cnN
 JpmKMWEn3e3MIeNK/VfMyxEo52te
X-Google-Smtp-Source: AGHT+IHn6uECCm06Ili+zpjwjp1TZtrBY1gTxaUHlioMf7glfagV3dIBLBiaj1N60i2dR0gUtr4cug==
X-Received: by 2002:a05:6808:16a3:b0:3ea:4e71:1cfa with SMTP id
 5614622812f47-3eaf0425452mr5191670b6e.36.1733422546237; 
 Thu, 05 Dec 2024 10:15:46 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3eb0767432fsm399620b6e.1.2024.12.05.10.15.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Dec 2024 10:15:45 -0800 (PST)
Message-ID: <b34733f3-1525-4e35-8c07-f84ad56b01e0@linaro.org>
Date: Thu, 5 Dec 2024 12:15:42 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 06/13] rust: add bindings for memattrs
To: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
References: <20241205060714.256270-1-zhao1.liu@intel.com>
 <20241205060714.256270-7-zhao1.liu@intel.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241205060714.256270-7-zhao1.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2d;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2d.google.com
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

On 12/5/24 00:07, Zhao Liu wrote:
> The MemTxAttrs structure is composed of bitfield members, and bindgen is
> unable to generate an equivalent macro definition for
> MEMTXATTRS_UNSPECIFIED.

I'm happy to move away from bit fields to uint32_t or suchlike to enable 
MEMTXATTRS_UNSPECIFIED be a compile-time constant.


r~

