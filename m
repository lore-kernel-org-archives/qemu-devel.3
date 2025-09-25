Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFF7ACAC5A5
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 10:02:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1inV-000073-1o; Thu, 25 Sep 2025 06:01:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1inT-0008Vy-1s
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 06:01:55 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1inN-0005c0-9R
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 06:01:54 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-46e37d10ed2so2713905e9.2
 for <qemu-devel@nongnu.org>; Thu, 25 Sep 2025 03:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758794505; x=1759399305; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=REXk0seohHucogRD5GD38sXvJj5vj3tcRaZynkpBQmI=;
 b=FQl24dtd9+/vrjoDaC3Em3VJ+lvr8fbTno3RciTZVk9XTVSSoqbtPLu1ajXSccrOEh
 rn9yFdBXvLwaL0osrrvFG1lxHBkr5PH8O5I6dh8Ir8XGTElSyu3O1jHoynUHC/bBoUVv
 qOHsN20jU/zNz/doV6pOEOYcRx4gm6UQYDID6da9P62FP07EuNzFBSaJr/VQcf9RDUbf
 l2ppzsRmnpcM0ZTYdTZYGIajWM4WNCPVJ+EVR8Z/VUoIVc8Pw5F3lJQPNIPk1XYN3m8x
 gkEmN0aEotLAyeWJiIWe6X332s2qbttsDkg4bbw2kKU/1KsoOKprTTI/A1ZKBubiMX1R
 l2VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758794505; x=1759399305;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=REXk0seohHucogRD5GD38sXvJj5vj3tcRaZynkpBQmI=;
 b=r10tQk46pUPnKDGUoA0IivVTy7ctkjPNCHsGU2GfTBD1IGlXB5sCa38xE3MwtZVA89
 gfRdDlnrBQCxq4voMrPAlejbvCNHiGpX4mJw81sGK9Mk7paPXN/BXFEDW/wYb8jNxmTb
 QVy0iSjvcz3IqCrKdbL6m8eV/oAflXFpQxh3WaqyNGhHCSyQeYMz3AqWTa365m03ZHlF
 vFDPB94RIPEhy5G7C3C6MlEdiyQGFwOEpDkpX20w/2jsSjNjNSbZpnlZdCBrFiaWkcia
 EEyZ9Ce5gFTVcPyDiTotf8K3sRn13gk3wLakiNiuZdS7LelqHz3VxSOJsKit0GlTRmS0
 rv3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXaGSiAEIr3UmSCT/Rh+8xNXqXBiWF2Livb3EV9ITcNZQlKLIRoy/iJwEthGCqbQIRhUHlssrRaoxEK@nongnu.org
X-Gm-Message-State: AOJu0YwjSLfbr/GWmdmLOPns9BIeeL/SCp/BrNKKt9iE2gbCayxF9evD
 23qU+aQOWk8j3SEiNBKZ/Qv8sitfncIP25d7EfNKSFheOrZdPuX8oH7jUWDjLlV0zdRd3ieOm1/
 FffXPNC6/fw==
X-Gm-Gg: ASbGncsgERwAiNwj8Nk0r2aFX0mjtFaK4foKi7+FhrbkdMQlaV0lIt/WEhTF5U04+H7
 KGWaLd+ZCj4q5jHL59EAOatUegUP0+dzeZET0tUD013bFODl9XTlmlirAulH4XeW4WPiIELN16r
 ddgM9C6b8X2kQ3kCC2khy5+kRZZkUUQBUtSPdBMRLTH2W/gl+EO+Z9BxCI9GYx0zAs+I6sazr06
 KMcRXnYoLKu+OY+hDQv7EjTCGpeMb+Jbyq++kPJgJuOAcor6AZF8iuW85t4pbLiT7CPP+rP26tT
 lbZTSFBCdIYjH8mblmgaZS6aFvZS3GGVc07vB8Oe/Py9qNmo7vhVOqkAt2+fUO8erbFhmmZOHC/
 f3GrcmJQbnvL6h8Nt6+mUlHyDhDtBcglxkmdH9MNE3f874uvtKLS+gUvipTXlKoQZzw==
X-Google-Smtp-Source: AGHT+IEeYCMFlQQufiuQMFCwcH7XNfX4sCCXibRiuOpKTxYId0gHMBCbbB9f6WRIFbN+lwdG3Mv5pQ==
X-Received: by 2002:a05:600c:4511:b0:46e:19f8:88d8 with SMTP id
 5b1f17b1804b1-46e32a54d21mr24750365e9.34.1758794505080; 
 Thu, 25 Sep 2025 03:01:45 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e33b9eabbsm29409755e9.3.2025.09.25.03.01.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Sep 2025 03:01:44 -0700 (PDT)
Message-ID: <5b72b061-8516-4ea4-80c6-43b3f5eafc8c@linaro.org>
Date: Thu, 25 Sep 2025 12:01:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 23/23] util: add brackets around guest name in message
 context
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-rust@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, qemu-block@nongnu.org,
 Stefan Weil <sw@weilnetz.de>, "Dr. David Alan Gilbert" <dave@treblig.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, devel@lists.libvirt.org,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20250925094441.1651372-1-berrange@redhat.com>
 <20250925094441.1651372-24-berrange@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250925094441.1651372-24-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 25/9/25 11:44, Daniel P. Berrangé wrote:
> The message context can optionally include the guest name if the
> argument '-msg guest-name=on' is given. The formatting, however,
> does not look good if the guest name contains whitespace. Change
> the output to include square brackets to demarcate the name.
> 
> Before:
> 
>    # qemu-system-x86_64 -object tls-creds-x509,id=t0,dir=fish -d 'trace:qcrypto*' -msg guest-name=on -name "fish food"
>    fish food qemu-system-x86_64: (1146846:main): qcrypto_tls_creds_x509_load TLS creds x509 load creds=0x55657e94e690 dir=fish
>    fish food qemu-system-x86_64: (1146846:main): qcrypto_tls_creds_get_path TLS creds path creds=0x55657e94e690 filename=ca-cert.pem path=<none>
>    fish food qemu-system-x86_64: (1146846:main): Unable to access credentials fish/ca-cert.pem: No such file or directory
> 
> After:
> 
>    # qemu-system-x86_64 -object tls-creds-x509,id=t0,dir=fish -d 'trace:qcrypto*' -msg guest-name=on -name "fish food"
>    [fish food] qemu-system-x86_64: (1144713:main): qcrypto_tls_creds_x509_load TLS creds x509 load creds=0x5604ada2c950 dir=fish
>    [fish food] qemu-system-x86_64: (1144713:main): qcrypto_tls_creds_get_path TLS creds path creds=0x5604ada2c950 filename=ca-cert.pem path=<none>
>    [fish food] qemu-system-x86_64: (1144713:main): Unable to access credentials fish/ca-cert.pem: No such file or directory
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   util/message.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/util/message.c b/util/message.c
> index 814ca0316e..7d94b9d970 100644
> --- a/util/message.c
> +++ b/util/message.c
> @@ -28,7 +28,7 @@ void qmessage_context_print(FILE *fp)
>   
>       if ((message_format & QMESSAGE_FORMAT_WORKLOAD_NAME) &&
>           message_workloadname) {
> -        fprintf(fp, "%s ", message_workloadname);
> +        fprintf(fp, "[%s] ", message_workloadname);

Squash with patch #20 "util: add support for formatting a workload
name in messages"? Anyhow,

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


