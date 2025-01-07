Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A9A3E77197
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 07:42:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tV4Dx-0006ou-4T; Tue, 07 Jan 2025 02:42:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tV4Dv-0006ok-Sx
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 02:41:59 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tV4Dq-0001Et-KQ
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 02:41:59 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3862d6d5765so8896873f8f.3
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2025 23:41:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736235712; x=1736840512; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aXkvL8bg6UPexDsEi+++KGBokR69pvl3MU4PFc98eCE=;
 b=C9rJ3qjrhcxprgionebvA7UF2nUAjHan4RZ3tMQTpMEI3dj8e2+IuHGJEx7Rp1aE5w
 b1AJuzpHYTxeNv1HdC7RGi+ihp2fEFbG02MT8B1517uNpTMLgSs292/CDIr4zo/ec9io
 otdCNJTZyqCt2GJxjQ8A8/gXSUn8hbFvE7DUASmWsy8Ovlm9g68Se88rvfrlCfSBPjvc
 Zw6QEGWOUP/VsqcqTj3lG2RuQz16jSrUFcuOmt6qieRYzfi75U0K2dyq7q41B2R+f/vK
 4z2VM5LHuOCu1Ca8AFyatcqQ1STE+oTOjnLhYl9K60dd1iP1/FvHpZlQ1gYZ3aDTAyWY
 aVVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736235712; x=1736840512;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aXkvL8bg6UPexDsEi+++KGBokR69pvl3MU4PFc98eCE=;
 b=fQsDgdHu+DjtPl79bdWZppb75BbK0VA72IbU72Nhar9scyNW4gtQU4YdAUh3yj8aaI
 dE0Y7dBNo1sx5MTVBk7QTP/5veJuYd3t1KUGS1U9lVgPf3njYWu2op9zo2LaZRxOIBgF
 +xFN6szq6TeciGgaNvJrq+N7sUiOGSHkLSFBT6pUTtd8Df7yVJmLPTVPCMZ0yqNPhHjC
 AqN+ka4CwFGzO3oJr+TIVMeALEITMf6FF4H5Oc9O6B9AbOqUz7GZ3KlvqurRSEZqXSOC
 tglKQIlVpcY1yRB1Pyo20zadlHl5QHZ7LzE0MBBTYvnn+5OM/uv3jh7F0K7eVdmLsLV0
 +BYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVqkryB9zrLFuG+YiwFAEBVXTahXufaRYhuWL2ZQarCbKPXIX30KI2VCzDeaYKP6E7VFqtDsaeKr1ft@nongnu.org
X-Gm-Message-State: AOJu0Yx9c/+9QeAJKAhO9jN/eoBXIYYlpEn6LwgzJ6btymCbLcL4LuLy
 AXCia09l77DWR5OZdwMZCJVzid56eCwWGzco9wxv3t7fnz9z1p0D3jAlktMSJnU=
X-Gm-Gg: ASbGnctCrt3Pl8PF9R2LUNMSoxp61ee7u1oREQks6xINOw89keiMi8VmR7sT70pVEJm
 YCufJ4uhGS8j9JzPcUlcfkQDk2YB1p1++wDkDtrhgA6ijrPfwyiglh5AxG6c0GPgqwOFzzp24WW
 HzIbd8acGKyqF2Ak8sh8EkDv5px/VVwYOGJIFbwgcPEAQf92pyzDi0atDlPTvm4yliZV8tE41dT
 TH+naghfSDU9u4yqbsLKa5JpLTnPUmS+Founkcbp8Btnh8NfeDy4JkodW8s0fvBOEybrRhhFLOw
 aDqb1bS2hWRdy4Qiq8dwGjBK
X-Google-Smtp-Source: AGHT+IGhbFXi3BDewf5GTOW2i6ml7hubRG0QVITnivFNZYb2gpeC3vjYNICTDSrbfhsp1xS0p7stlQ==
X-Received: by 2002:a05:6000:1846:b0:385:ef97:78c with SMTP id
 ffacd0b85a97d-38a221f3179mr37670830f8f.6.1736235712640; 
 Mon, 06 Jan 2025 23:41:52 -0800 (PST)
Received: from [192.168.69.132] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436611ea3d5sm594519965e9.5.2025.01.06.23.41.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jan 2025 23:41:52 -0800 (PST)
Message-ID: <bc2594c2-8275-403e-bb8f-39fef654153d@linaro.org>
Date: Tue, 7 Jan 2025 08:41:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 1/2] tpm: convert tpmdev options processing to new
 visitor format
To: James Bottomley <James.Bottomley@HansenPartnership.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Stefan Berger <stefanb@linux.ibm.com>
References: <20241212170528.30364-1-James.Bottomley@HansenPartnership.com>
 <20241212170528.30364-2-James.Bottomley@HansenPartnership.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241212170528.30364-2-James.Bottomley@HansenPartnership.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

On 12/12/24 18:05, James Bottomley wrote:
> Instead of processing the tpmdev options using the old qemu options,
> convert to the new visitor format which also allows the passing of
> json on the command line.
> 
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> Tested-by: Stefan Berger <stefanb@linux.ibm.com>
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> 
> ---
> v4: add TpmConfiOptions
> v5: exit(0) for help
> v7: adjust line lengths, free options
> v8: minor updates; add tested/reviewed-by
> v9: optarg->optstr
> ---
>   backends/tpm/tpm_emulator.c    | 25 ++++------
>   backends/tpm/tpm_passthrough.c | 23 +++------
>   include/sysemu/tpm.h           |  5 +-
>   include/sysemu/tpm_backend.h   |  2 +-
>   qapi/tpm.json                  | 21 ++++++++
>   system/tpm.c                   | 91 ++++++++++++++--------------------
>   system/vl.c                    | 19 +------
>   7 files changed, 81 insertions(+), 105 deletions(-)


> diff --git a/qapi/tpm.json b/qapi/tpm.json
> index a16a72edb9..e6345d424b 100644
> --- a/qapi/tpm.json
> +++ b/qapi/tpm.json
> @@ -142,6 +142,27 @@
>               'emulator': 'TPMEmulatorOptionsWrapper' },
>     'if': 'CONFIG_TPM' }
>   
> +##
> +# @TpmCreateOptions:
> +#
> +# A union referencing different TPM backend types' configuration options
> +#   without the wrapper to be usable by visitors.
> +#
> +# @type: - 'passthrough' The configuration options for the TPM passthrough type
> +#        - 'emulator' The configuration options for TPM emulator backend type
> +#
> +# @id: The Id of the TPM
> +#
> +# Since: 9.0

(Now 10.0)

> +##
> +{ 'union': 'TpmCreateOptions',
> +  'base': { 'type': 'TpmType',
> +            'id' : 'str' },
> +  'discriminator': 'type',
> +  'data': { 'passthrough' : 'TPMPassthroughOptions',
> +            'emulator': 'TPMEmulatorOptions' },
> +  'if': 'CONFIG_TPM' }
> +
>   ##
>   # @TPMInfo:
>   #

