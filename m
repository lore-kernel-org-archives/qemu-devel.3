Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDB8CC52D7D
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2024 09:22:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seWgK-0000nM-DN; Thu, 15 Aug 2024 05:22:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1seWfz-0000Xx-I3
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 05:21:53 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1seWfx-0004Zp-IQ
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 05:21:47 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5bb8e62570fso993539a12.1
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2024 02:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723713704; x=1724318504; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/XC00O8mHJaP2PFpA++QvM0IPgaX3SHsT829pcUcGZE=;
 b=plwr+MSGD1EvAaE+za3vba7u1rhwvJ6/pil17/4HxcwiiwKV1ALE5TdLWfZ25rIm2s
 GMrCXuZ3ebgV8b4yfxXPXnxSmifAdZplzzj/Mg8uTPUXOuIrvmaJr1rx3Burba/WNVl0
 LdWeylJsFjz1h5Mz+ob4rd9nY+qENAnuyZyc++Brekp9CVrZM19fKqTf8+jI0PzjRzU0
 TpDdVXPYB5oEb5Y2b91HcGW1qNFkRn1Bxu59oJ8Bp847ke6Xt2yXCiH5D3zJaXQuPxi+
 1zuDdrDvbaXmFyHPGvxE/cKm0BgFS3bTtfjWGsfDitfxOGc8glTjZQOHBe/BVB3TLnht
 12YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723713704; x=1724318504;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/XC00O8mHJaP2PFpA++QvM0IPgaX3SHsT829pcUcGZE=;
 b=TKPbF/oWB0NoahO5VG4/PpJHA80px1IiKN56uuM/DU5yPPOmEevHI0fwCdf3N06juY
 KkZoGdTm0qrAMQ44UVZG9dPiEboLkfmM460qUsK/Gz3zhHAx9TcAlJg7PH30W9qvMaJs
 8wQIX3e7JCM0ItOO2pSXcmVDdc0gTirZd4fOvWQlyx2oUhJkTDi8AYs/WsFpRqw6S8D7
 3mQRjnqJxUKYqQSX0Ru+xh8LXozyL35xHujQ50KUQ+tmS/OFT3TKNKc2OvvncjsFuRFH
 Lwm0QtegOL5kDvvWQjymAN6JIV+CVFgvvD97leElaisSiBo98V4QlUV1PcZwu198TQyw
 KlPA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUAgi426G9veU8fLGx4cHeIBLjxoARZ24KCmzJGZgdMoyatbO26DJkTx6IVyRcUT9KvnPH1Pi0MZF9x1MdUatQ1JXT06Jg=
X-Gm-Message-State: AOJu0YwgayCs7ic5wU2cblUJ3wmVX8cAfhn4ohI1IznI1Wr+AEfw/lOO
 KpdMu6D6UtnxUUc4DWBgBSdlokB09U/K88rZpO5fNUkKMMdyqnfs/oNc+UmeKu3/NytVzrIgqAS
 iUVA=
X-Google-Smtp-Source: AGHT+IHekcCMNCw17uEnoC/sPv658hIQ1jXVkSlnpEtHHcLImpGFQ1SQ55ptRhDzyDLAxMUtve5/pQ==
X-Received: by 2002:a05:6402:268f:b0:5b8:5851:66cd with SMTP id
 4fb4d7f45d1cf-5bea1c6ab89mr3531550a12.2.1723713703685; 
 Thu, 15 Aug 2024 02:21:43 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.202.43])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5bebc081cf5sm635471a12.90.2024.08.15.02.21.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Aug 2024 02:21:43 -0700 (PDT)
Message-ID: <8289dff0-2415-4538-8c86-1c4919458023@linaro.org>
Date: Thu, 15 Aug 2024 11:21:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] MIPS misc patches
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
Cc: Huacai Chen <chenhuacai@kernel.org>, Laurent Vivier <laurent@vivier.eu>,
 stable@vger.kernel.org
References: <20240621-loongson3-ipi-follow-v2-0-848eafcbb67e@flygoat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240621-loongson3-ipi-follow-v2-0-848eafcbb67e@flygoat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x534.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 21/6/24 15:11, Jiaxun Yang wrote:
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
> Changes in v2:
> - v1 was sent in mistake, b4 messed up with QEMU again
> - Link to v1: https://lore.kernel.org/r/20240621-loongson3-ipi-follow-v1-0-c6e73f2b2844@flygoat.com
> 
> ---
> Jiaxun Yang (3):
>        hw/mips/loongson3_virt: Store core_iocsr into LoongsonMachineState
>        hw/mips/loongson3_virt: Fix condition of IPI IOCSR connection

Patches 1 & 2 queued,

>        linux-user/mips64: Use MIPS64R2-generic as default CPU type

patch 3 superseded by
https://lore.kernel.org/qemu-devel/20240814133928.6746-4-philmd@linaro.org/

Thanks.

