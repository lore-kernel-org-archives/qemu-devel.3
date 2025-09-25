Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC83ACAC5A5
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 13:34:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1m6W-0006PU-OI; Thu, 25 Sep 2025 09:33:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1m6S-0006OC-2p
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 09:33:44 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1m6J-0005OD-FN
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 09:33:42 -0400
Received: by mail-wr1-x442.google.com with SMTP id
 ffacd0b85a97d-3eebc513678so1081392f8f.1
 for <qemu-devel@nongnu.org>; Thu, 25 Sep 2025 06:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758807202; x=1759412002; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=u4zt9ULoPhuPWIhx06ZPdvKxJoLapLa6JUnFo3oCnp0=;
 b=j6W7Q7DW139eTqSjgAzBIaHAaDG+qeXrufxlzkXRSHiLXDIk57L2GfCBI/VspNSKQn
 pGm+HCML7ceMOTKH2FnxymRUN2EA9VJ1mETSmCMOWQ1QDdL/LfyiDIXTDpAPmBkkCLDq
 uCtAQA1eCsBYDuYSIkL36UBKoFdg6ZebQnPo7/UkT0HzWVLsuN0hQNNzvrCCd2SHkTXJ
 owcmPEDwnBec2IGU09O91j8KuRXMToJhAcqPwg07jpKBWNHHi5gGssMHj7d/sBgqmty6
 24+OYUKEErriYnRvR0pjdqHhaGjWKDbnTJgOw2kbMMFU5EVjYXNl97ynCUmwUfDvyKgr
 QOGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758807202; x=1759412002;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=u4zt9ULoPhuPWIhx06ZPdvKxJoLapLa6JUnFo3oCnp0=;
 b=ds93tdy4KkZDyWsR2zAYoyerZCky7O7KGbOicM1OShCXA9rqDXbjFmbVoLDsWcLrD8
 fOb9nfrIPlNF6DUqi0DcWcB9BAm5lnHs3ISJ+nO9Gk5dA0+O9AwnV9CbrUpKubb/LgJ6
 QObLDnLIttuNdEAUMtmUDl5O3rgE3ewJ0FLZG+c1PvqPXR6sbvLUAJ4T6QTKig/RezKX
 eXE7ldhJqosAnV/iHLal0+JOXr9YJItPUAEInWyuufIpjkj2FOiggmrgbKPKCsChC8eb
 m/ypVi2sE0ELuTBiO1JWUIAseDnxUpEUuiTbG7peyR3m9VQfk7vMc5jN3Iq0R6SV5ysf
 7T7A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZOr0nIRxEF4i86BAQI1hnerk1fOtyDO+Hr8udAGV/SIyuBYPxcNBlw2FaK4OIyum1TlWd0g6XgtC6@nongnu.org
X-Gm-Message-State: AOJu0Yy3AphFbrjRtwOOYp+DHIfzuiFplNAzPOEKKbldMiYde4pyfcmU
 e1EeYpcti+KniOvD/taX+ZJxWrKUlrhTjr0NfOw4rFG1eTmvwx4+8wuAHPjv0BTC8vWvKsV9wci
 brKqkKCssq5on
X-Gm-Gg: ASbGncuYmJrCEFYtoRcKhzB6pqGbiUtpQP5HbbvujqikM2IZK7qRMcra9P5QRDQNJzw
 +fvI+HIfh1PTYIgoJShUysH+4i7sNXfibG9wSyS+g7M96BVRsGYbjGBu7ITbBH3YhJVXtRg0Tn8
 uF47WSq0lbON82SlYBBNv9i9U52O0woCNsF9bJ7iKVmWr/O4jDFj9QL73rebGJodRwYNoctgBs7
 pzwDK3gKaE2E+sbL5tYyvVIT42Ob4ZN5MV/ojlMHBgul9xt4wEIWGY06gPOKf0h/3wB19oyw1mh
 YTqsJ+mEp5aBGnDGFTMF9Rhc5KLp+Z+1Hvam7voXTHKevEWL5wKKd/k238ZFWRC1orjBOmwb0DY
 Kmmg3O8HWNAt9IW0xxXi7dta8rTV8l8xBeIrynz1/DiDoSA0w4M/HCjzVabCdSWbCkg==
X-Google-Smtp-Source: AGHT+IGA3fOWSAdLj0plsJtkX8TUc2pcLa62zyyl4VD+/TWJRf0OZfJSBOEnyUjE/pKEjUz4rSG7vQ==
X-Received: by 2002:a5d:5f85:0:b0:3e9:ad34:2b2e with SMTP id
 ffacd0b85a97d-40e4cb6e211mr3592496f8f.46.1758807202538; 
 Thu, 25 Sep 2025 06:33:22 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fb985e080sm3052684f8f.24.2025.09.25.06.33.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Sep 2025 06:33:21 -0700 (PDT)
Message-ID: <bfc949e5-ff2d-499e-9af3-dad7636b9e2a@linaro.org>
Date: Thu, 25 Sep 2025 15:33:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] qtest/am53c974-test: add additional test for cmdfifo
 overflow
Content-Language: en-US
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, pbonzini@redhat.com,
 fam@euphon.net, farosas@suse.de, lvivier@redhat.com, qemu-devel@nongnu.org
References: <20250925122846.527615-1-mark.cave-ayland@ilande.co.uk>
 <20250925122846.527615-3-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250925122846.527615-3-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x442.google.com
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

On 25/9/25 14:28, Mark Cave-Ayland wrote:
> Based upon the qtest reproducer posted to Gitlab issue #3082 at
> https://gitlab.com/qemu-project/qemu/-/issues/3082.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   tests/qtest/am53c974-test.c | 40 +++++++++++++++++++++++++++++++++++++
>   1 file changed, 40 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


