Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7228C369AB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 06:46:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7qLf-0000Ba-El; Thu, 24 Apr 2025 02:46:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7qLR-0000Ac-NN
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 02:46:08 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7qLM-00005m-5y
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 02:46:00 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-39c30d9085aso428014f8f.1
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 23:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745477151; x=1746081951; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8QYqANi18GY4DNuNW9kOaKzavwrJxkTAKBhkEEIPG3E=;
 b=k58Wczs7IPSCwiFsEhY8F5kogppX8ucKTBJUOiWLNsqCCL5fZJexsc+iL9DOTs9go/
 zj++MJrYBw5sUynFUTeJLOJMBDC0u14SGE7kLQArAj7qt4cWP41W1WzXI6I70UwAQmT3
 xm3vOS3CB/4OYBuavEDj0tkzLVCPxfGaNkA+Vi/bKWdpnugiTt0mrS7O80EsGDC6QODL
 j7DFQIBEarip/EsEAeS7HUvSHHqWLqTtaxNRXOfZXDuCAFLQKqlIy7K+VWZF229zI7gC
 SBsgp6JNBRxurOjSLeEQ1N2AnlGaCT9k1r2r0WKb6AdNsLzxhgw25cHzcMHlx+Z2FTm3
 HEZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745477151; x=1746081951;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8QYqANi18GY4DNuNW9kOaKzavwrJxkTAKBhkEEIPG3E=;
 b=Y916pFIVo2o/EwFgeMpSPNpnaeDChmgEPTDDxOAyfcIBjeAkVNlb9WRgGYuLA2wUCY
 Wg0t8dOnjhbZIUsicEldj0pLbn1wfxdw6YSK83a691048iLkgyTA92FnrO51CpPISZ/7
 hyjofceMRnuU/Blza/bzppYa2zt4Yw1mnGlWjFRQ04HkLCm4nsOQAyS8RzOMfZ+jBcGZ
 FpltKNPdT0AM/6hcIKYiCqTZTn58NeJ0Pn/Mb9opIT1kWoeW5Iau/Otx65hgHV6zCH+O
 Y0AAIqXxHYCtQP2sUjAbxCajbkV3uPHkROngkxvExbCwcBvXDC1pkDq4qOfHyUZ/o6C/
 mtSg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXbTOWPPX60KeKIS4lzbQxQO5dzvZmnNd7rE83YItIBIymYFc5JH9u7cVgIkZ7B/kYbSYNxr+jooZ4d@nongnu.org
X-Gm-Message-State: AOJu0YxHPrVZF8Bb5Dz+NzGOm5quS+IqdZ2md89uJXJU8wBvVms/WPOc
 nteM4wchTYqTNG9VGofQZVlrShdxcs+HnvlsKeiby8NNTS9Tj+41v3nyqrb20KY=
X-Gm-Gg: ASbGncth5ej5kLi0Pw94AaqhkRm9yuVmCJI5s6sWF3WfPXHptDtEaCi158PWzKs7anj
 bhQ/9hDW0nEClwGg7Fb7v7ureeeazW+wz8Lbsfo3A16AhTxn8I0mhIqOZQzTpz8UecM4NUzkCdL
 srSxVWC0zOtSUjGP5MnLzmJSjzNU37ee5G+QwYHSuVyXChOf5EycTvpdZ+RhV8xN/pF6ge7W8A2
 iJSlC6DgyNNLSMm1GJHe9a448XTSJQgnwRIV8zArtPmMD3NOMA6FzroS+DRN9vi6h7gIfKuayK7
 Go6GcGA7wMIIJiGEER8CHCh2oaHj28Ll0gC4J2XKcTQxbu3tjNpQkm/XLFbE0UR48wh9BiCmxz1
 VWut7VxiYJa4O8g==
X-Google-Smtp-Source: AGHT+IHEjm92bLbmu73ADmX2Hb9uWFarEktK8AK1NYqPxwZo1L9Fkil+hh20Tsw01DN2SU3PD2GQuw==
X-Received: by 2002:a05:6000:4013:b0:391:1222:b444 with SMTP id
 ffacd0b85a97d-3a06cf56420mr1040718f8f.20.1745477151051; 
 Wed, 23 Apr 2025 23:45:51 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a06d4a8070sm1036870f8f.18.2025.04.23.23.45.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Apr 2025 23:45:49 -0700 (PDT)
Message-ID: <7e5e459e-2385-4d13-a562-082091d4e56f@linaro.org>
Date: Thu, 24 Apr 2025 08:45:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] meson: Share common C source prefixes
To: Akihiko Odaki <akihiko.odaki@daynix.com>, qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 devel@daynix.com
References: <20250424-buildsys-v1-0-97655e3b25d7@daynix.com>
 <20250424-buildsys-v1-3-97655e3b25d7@daynix.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250424-buildsys-v1-3-97655e3b25d7@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

On 24/4/25 06:50, Akihiko Odaki wrote:
> gnu_source_prefix defines _GNU_SOURCE for compiler object functions.
> The definition is universally available in the code base.
> 
> docs/devel/style.rst also says that the "qemu/osdep.h" header is
> always included, so files included in the file is also universally
> available in the code base.
> 
> Rename gnu_source_prefix to osdep_prefix, and add #include directives
> that are referred by the users of gnu_source_prefix and contained in
> qemu/osdep.h to safely de-duplicate #include directives.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>   meson.build | 68 +++++++++++++++++++++++++++++--------------------------------
>   1 file changed, 32 insertions(+), 36 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


