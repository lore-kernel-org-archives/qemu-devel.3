Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 081B2C83F1F
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 10:48:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZopF-0004oL-TM; Thu, 10 Jul 2025 06:48:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uZooq-0004cV-70
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 06:48:04 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uZooo-0007Ia-8l
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 06:47:59 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-453634d8609so4797245e9.3
 for <qemu-devel@nongnu.org>; Thu, 10 Jul 2025 03:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752144476; x=1752749276; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=R1Wbfv9zzaM19vcEk94DtVJb1wlNSMc4zrAE+IrDaRc=;
 b=YgXNLIzjPLPQIJsMsnaCkHEHek6pmMHojtZzQznnYgyGryv0H8CR6gH1gXJmiF3QjI
 akrBiPbpocTv1C72712/Ov+vbJqOkqzYEhI76nc/x5gK6w7HHRNF5LyZ2p8Hd5Vhrt2t
 EhhlcKWv0LkFdnSnU5jQRjG32xzpzvuuwSyUnLp/Mfd1YYbYxVGRwVoRJL1P7VB5UjvN
 VpYsGbvp83OeNiPZVnVu4FsyDcskDyvTqxOFJKkIC94hy+HOn+xzx0YiELJY67PbvBSU
 Yxh+d7MRjrulgJf2Hgv7+cSNjQikFtdf/bH/Rl5jf2U8eNRstA16cUYPDO+OvtCVS3pD
 ObCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752144476; x=1752749276;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=R1Wbfv9zzaM19vcEk94DtVJb1wlNSMc4zrAE+IrDaRc=;
 b=LAOkHut2fcHz9vH00V8aIOuMZZiIq7iDv+GwbgxEuG6cUEl9pcDJaa8XrYENJ7cIBa
 HJKA3rZ4NE/DDm8xnNdBEurGBNAzBsUBnnPNTN13gb40XOFCcrAe4BnsxCw6Twa8+ZPN
 NM0yuFN36Cn0cUmW4lvY0KiGfwXTIfJKSM56uFHKhyKtpFxAXnNFM2TNSum8+PTgD0Gv
 991j0zzXMHVEZ6pJCHbuEZ+0nvn6F9mw1JhlCCbh7ju83NqCmoU0yD5BDu0u/FJLZXg+
 oHuWBALGTvstkYBVxqtxea0is8WeCMpPyDfDbs0TZZoEOAfUD8U7bCWyvBLaiwtyA0TE
 zeDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVBcFlpUZWnSWXO//eMIPnoRFLUYHsWxWzPTleGHwZKYvlbev7n3mfaBm4FS2LrhNp6m0YJaB3gNDOe@nongnu.org
X-Gm-Message-State: AOJu0Yy2gPgegO2si88FEIuX7rFhdKrJ7zMNqxp/qXp2aDsEXO0GxsSd
 KRgEh2vgtFex7/hLovQnU04pLgaWKAkxqm/5Su+sMmiyf7gA+JJ7SadJTvx7sC+SNqQ=
X-Gm-Gg: ASbGncvRfzJ9d5eEC9GfSp9Zc/hato2b2x98fYCTntFBhaftCeXk1eSM3h55DB4/PpX
 IIcpOXISxbYjS8sSF/KHZrqvCowV78TPJxrN60PdV8Mjwpnr/ci/RwZ0XleTp3SIkUDLqwiSuns
 MyzgQj28F24MuwB02SC77d7Tn7PhKuu8/oqagHYINTDAMgpff9dO4g58TBfC2h/WLc5yP/sNqo3
 V/oWtG5cKME5tUZTLQ9jG3hI4bqGXrL2tTY70p5+4zmnoxZAWMkmaoEih+qqMgdJdgpvAfJSa2f
 c3NAQFdev2c8PWQJlFNPLBjhAO9izBdk/omnpQDTO2s23GTAb0k+FAOm41x0aiF5aCgh1O5A6o7
 WwiErapnoEBoYWzUQWK9q/Sibrw3XD4Nd4EJvRnGTkm0=
X-Google-Smtp-Source: AGHT+IFRhcctiOV9whMOXYMuVWhaecH8QQqblUzf2qF3eTZKl4C7qTDVhUxYHdt1qKuRTpOXnaespQ==
X-Received: by 2002:a05:600c:a45:b0:43b:c0fa:f9dd with SMTP id
 5b1f17b1804b1-454d538f677mr51131015e9.25.1752144475784; 
 Thu, 10 Jul 2025 03:47:55 -0700 (PDT)
Received: from [192.168.1.117] (lfbn-mon-1-970-120.w86-227.abo.wanadoo.fr.
 [86.227.5.120]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8dc21e7sm1547508f8f.36.2025.07.10.03.47.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Jul 2025 03:47:55 -0700 (PDT)
Message-ID: <e9227aef-97fb-4eb0-afb2-3aa8f1abd6b8@linaro.org>
Date: Thu, 10 Jul 2025 12:47:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/18] hw/i386/pc_piix.c: remove
 pc_system_flash_cleanup_unused() from pc_init_isa()
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>, pbonzini@redhat.com,
 mst@redhat.com, marcel.apfelbaum@gmail.com, eduardo@habkost.net,
 imammedo@redhat.com, qemu-devel@nongnu.org
References: <20250710085308.420774-1-mark.caveayland@nutanix.com>
 <20250710085308.420774-11-mark.caveayland@nutanix.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250710085308.420774-11-mark.caveayland@nutanix.com>
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

On 10/7/25 10:52, Mark Cave-Ayland wrote:
> This function contains 'assert(PC_MACHINE_GET_CLASS(pcms)->pci_enabled)' and so we can
> safely assume that it should never be used for the isapc machine.
> 
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> ---
>   hw/i386/pc_piix.c | 1 -
>   1 file changed, 1 deletion(-)

It would be nice to have parity with pc_system_flash_create() (only
call it on non-isapc machines).

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


