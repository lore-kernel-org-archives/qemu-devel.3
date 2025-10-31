Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB644CCF9FF
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 14:01:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEpgB-0000uV-3h; Fri, 31 Oct 2025 10:00:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEpg7-0000ni-Oq
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 10:00:32 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEpfz-0003Xo-SO
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 10:00:30 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-429b895458cso1386230f8f.1
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 07:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761919214; x=1762524014; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=82Fim3M/9FbWKJt337jSsxsrCsdrF/udWkXs47djHWA=;
 b=g+En6/U6qHKiGsN4jnn3OjgZeHVJGOoQMkI1PfOxM30xiphn329fpjoApefokuE/3d
 flQMbHaTJeToYHM3fIYLrtQU8XBd2tkvLI/lNsEYfVH7vbd4Ceq5LdUjxP0PczcvQnbP
 EVJ14YEM1FpzqBBpdyaRbJ7fV0pLJq6goAByxK6DlWyXaRZ+mfXnE/M6KQWkSswuIIlt
 NOuW9JxLOFyNoSNG6s4FrHD/sloJD8UsD9q/Wss1/ZXt6IqfltBrf1yWjFy3ChA+HrQo
 9b98q0WdYlwCtyKzidDcMJ31ii/NpO6ROurKGtOQ0u2U6JyIdM3jzttfWFEKOPHkYLS+
 IvQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761919214; x=1762524014;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=82Fim3M/9FbWKJt337jSsxsrCsdrF/udWkXs47djHWA=;
 b=NoRHHXsq0FW+0IcRyXp+uM/2YZgnSXGIrMNAFE3Iq0FcXGMUd2dz+VTjmUKCb7IzgN
 aQXdjhJLsAbWsfClyTo/w1htJLR2unAzfgSC7vULRDGJxYpv+R7xKPRVNOfGNp7suuzI
 wL/h3eEYJhofXO67nabE9N1P28ZI1GmK0g26BdcyxY8epnehM0SenqsEu6qX18465LxF
 CHTiTu1SA+lwXyWiGj/qkb0VxRkxTBLu5eCZw2teL7o7NAA2E/x821XIwbcd3eMcqkol
 bE1cgVyF1lPSopRmVPP/mX4ud3AY+Xeb4RKPQNX7D1Z9S80icwm9SJiYvyZr56GGytg4
 AtfQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUwnGN9itGbf2XWy+gY129brKkyXRWOkO7MRMiPjpeAfndu22Ex18oE0BGwmxRcwTSc9IVpjZQs8mYa@nongnu.org
X-Gm-Message-State: AOJu0Yzyj5+hsP/ZTOK1+7qM6pKHG3LaH1o7ylnHfYTutS3l116H1An4
 B4iK9sLggPbX0jlkJXxbNaCP3kSLiXWxqno84HPU0IkVKlefALyryMwa46g905cOoHc=
X-Gm-Gg: ASbGncve4dcU0cFCcYVQfU2nwIE3AlPXvMFSW+ypRNbw11aANcQZTMPPcFe1gX8gQQD
 WbnhNedUNORZVaTE2dnMMtmNw9P3P5MPgDbgBMsfuLjgVYC+MBX6rwFYLJ+QbO9CWT9zhSIfK+N
 Ki+ED3EhT0/3Zae04PaaaSfjdub8FfFO9SVSqx3nQwX6UWgCzTRx1YbW4QJLbcC4yLUYxXR1fzt
 K/tIOYYblYYQUY5cyQMfphk7txwbzTwaiA7Mt9hIoNuly+r8IXNim7KEMqXoDUjCzlU7YTJ11/y
 zZXSfFtzqXkbKfUz1tsayFdb6iu4sFT0vJjM2L9AqkHz1t/s0XIZaZfUCeRwEpUvnfVuEH+Nwt8
 GnIDd8w3wsLQ/+704CgBGVXCd84gAJrNJXXnUiseWp2jwuorsAS5HNP5cnU7CbmfVZO6vlr8hxD
 iXI/BrfILxUWMN3BL4blWPq4351AmJ0HoG4ndgYeQtEeJtosVRPzvvOaQ=
X-Google-Smtp-Source: AGHT+IHUfltePkBqgSHx31VSilbgWABiuyJrroq58rA+DWNwHnhHH9vy6ZaU9pb7EB7wUx/DxZgxcg==
X-Received: by 2002:a05:6000:4009:b0:429:957b:ee72 with SMTP id
 ffacd0b85a97d-429bd6ac866mr2859025f8f.53.1761919213657; 
 Fri, 31 Oct 2025 07:00:13 -0700 (PDT)
Received: from [192.168.1.17] (adijon-656-1-155-31.w90-33.abo.wanadoo.fr.
 [90.33.190.31]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429c1406a45sm3729321f8f.47.2025.10.31.07.00.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Oct 2025 07:00:13 -0700 (PDT)
Message-ID: <7b7790ec-aa41-47c9-8bef-c9be2fe5cc42@linaro.org>
Date: Fri, 31 Oct 2025 15:00:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/21] crypto: remove needless indirection via parent_obj
 field
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 devel@lists.libvirt.org
References: <20251030144927.2241109-1-berrange@redhat.com>
 <20251030144927.2241109-8-berrange@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251030144927.2241109-8-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 30/10/25 15:49, Daniel P. Berrangé wrote:
> The reload method already has a pointer to the parent object in
> the 'creds' parameter that is passed in, so indirect access via
> the subclass 'parent_obj' field is redundant.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   crypto/tlscredsx509.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


