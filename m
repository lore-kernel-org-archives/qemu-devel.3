Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBF11C7115B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Jun 2025 20:47:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSMAY-00051f-Dg; Thu, 19 Jun 2025 16:47:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSMAW-00051W-Oo
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 16:47:33 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSMAV-00064J-AW
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 16:47:32 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3a36748920cso1031517f8f.2
 for <qemu-devel@nongnu.org>; Thu, 19 Jun 2025 13:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750366049; x=1750970849; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hf/PHjelPWM2EOJd5P/m0TVK/TF+qeDuE2RW0PtBu40=;
 b=e3P7yk8zIN+nhLn2kJ96Tr7yAJBQoU+8vPFTE2kpeRoHI8eV70nkDMd1JYH8jOh4zU
 fOihIvteOyTRjZFY3m5OTBDKwXVEczdiHO8H6S2U15F5lXQ/snRIZGOGn2xoYLUi1QmP
 OuubvtYxSVrCptqkTjA785PVuRU6euAlMDAHl1MNwalQkxlgGtnq6RDTrP6m6zJEMv6F
 gA8CN5DKrF0Za0I0l9d64grN3y58nsRo94TN++ZaOPApjFPJ4aeEomuUX3MH1VmhaRHJ
 BlktZQdTvnK5CUhDb5UbXyIOzktj2HRFiAvI29VzTJqwy8tqFpH68awzkWHBIIZ59/co
 hZMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750366049; x=1750970849;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hf/PHjelPWM2EOJd5P/m0TVK/TF+qeDuE2RW0PtBu40=;
 b=akN573qZyGO5c5tW/RJGrSIJ0gbPMJJz6oFhZc/efTL93SdIzGh3EpEBH8kdXuwSm8
 xh7B3Fpn7fDAdH1f2pKxecLA3tOMXCTZTrB+jb1hlzMToDdzRSCEeepavVIqvQgcU7Gp
 e+RYKtX/D6UXnHM6Kh109gAvUPJPIHolLKoLQiH0Rs6rE/z0kulgRP3ftOPhrhpLPsAU
 BcOkAzou/XntpOKVPRxseNx8xIKpgrAeArwr+oOREwU0a3cZ3YwDsU+gGmtzOR+2IxB8
 5fj0rKkDX76qX0/J5CcNdDYOGQf5UYTwODPBqCcRv/uOrLUcif/DcCNX5I2By8r8IDHG
 KDtA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVPHIl31WbBXkD8shnGT98Zk1zzCMVzeNtJhR5Ztny03W/9jysfiuFs7G/CyzE5mDSZghtNe+cYy7jJ@nongnu.org
X-Gm-Message-State: AOJu0YzWCfyUrBiGBGVZOv7mHb29k/B2Eo2ZRO7BWECjPUHh7POoztg4
 L/ocOwJDZH7p3PUOvtddpqguSWAXQLnPFfdj+N7KabTuPKui6OoSCmgCz6Fbn5qqVGA=
X-Gm-Gg: ASbGncvGraynhC72wNEHOjdkDkXvIEs7JrrepHyQD0OM9ZLe6p9QLVR9wUXWB5iQbGq
 6WM/0CYpVH+BG1i1uEen2FI2Qowh+k+ZEiISXBk84N7P6W4lbB7sQM/4dv14zvZca8rTYTFOSV9
 +ebQA51Bf7mIpp7QBlRJMB6LnhU6QK/Jblg2Xzt35D6R0O5xKZ+0xkJobTprlG16Dp2ytj8QjDi
 plTxSCZXJL8EBC49KkIk95yCQDN4ZfjSYfNezrqrKC3GnJmeQPKGdYximagOEALGeTsCUQ6q8G9
 upaftr2yFNUxxVUIykl4rwXzren1uJZ20+x8dFm4Fn6r1RsHpzTFvLG0QK58Fj86l3tq+/YsdfM
 s1vUZoh1ZjN9buoIZHfLRsL9+zYpDXQ==
X-Google-Smtp-Source: AGHT+IFW1HDw3eBsdIGJhVvPnxOWPAMfjCS7GjOoEALn6HFu7XmGIf9S0mgQO+VMO+G1D14IBfQa8g==
X-Received: by 2002:a05:6000:2709:b0:3a4:dc32:6cbb with SMTP id
 ffacd0b85a97d-3a6d130710emr191253f8f.31.1750366049199; 
 Thu, 19 Jun 2025 13:47:29 -0700 (PDT)
Received: from [192.168.69.167] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4535ead2a5fsm38653275e9.34.2025.06.19.13.47.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Jun 2025 13:47:28 -0700 (PDT)
Message-ID: <86a666e2-9cd1-406b-ad50-3948167e1daa@linaro.org>
Date: Thu, 19 Jun 2025 22:47:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/12] hw/i386/pc_piix.c: remove pcmc->pci_enabled
 dependent initialisation from pc_init_isa()
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>, pbonzini@redhat.com,
 mst@redhat.com, marcel.apfelbaum@gmail.com, eduardo@habkost.net,
 imammedo@redhat.com, qemu-devel@nongnu.org
References: <20250618112828.235087-1-mark.caveayland@nutanix.com>
 <20250618112828.235087-3-mark.caveayland@nutanix.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250618112828.235087-3-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

On 18/6/25 13:27, Mark Cave-Ayland wrote:
> This code will never be used for an isapc machine.

s/This/PCI/

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> 
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> ---
>   hw/i386/pc_piix.c | 105 ++++------------------------------------------
>   1 file changed, 8 insertions(+), 97 deletions(-)


