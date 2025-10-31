Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64329CCF9FF
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 13:59:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEped-0008HG-LX; Fri, 31 Oct 2025 09:58:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEpeZ-0008H0-R5
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 09:58:56 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEpeP-0003Bo-Mt
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 09:58:54 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-429b72691b4so2113355f8f.3
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 06:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761919120; x=1762523920; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kvbQ84EseZoQBE+gIzMBX3PwN8bjurCsjMBB2wqx10w=;
 b=JIPAQhYuowXBrAsLExcPJ9+xy8P0VqtoVGfiAuOyKx/Y63Z3qhTD+C3h2pADzG+1OE
 eX8JUvwWEdnbF3ZU5kRcKqna37eKEvqbaXa8xFo3cP1NF3iX+L3gyyvw3pgKXLJiLEmA
 10kL6vZLmcX9O6CeLjw09eSAgKTelPhiYXbE0DTU5O/8r5Jqp7VUKTCh6WBCfC3ojfpT
 Cqc1x+hmHXfQXzGogbaOIiV9/4bJJSSKKQdNdiBpLdpcc7aD6lIZZizWq9mJ1Glbvp9K
 Y7VgaK+b9zX3e2t+D+hLJLH9HMO+OYP29JJ7pzeEpG5LjB2pVkrfP4iqIdtZnGcaohGX
 p9pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761919120; x=1762523920;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kvbQ84EseZoQBE+gIzMBX3PwN8bjurCsjMBB2wqx10w=;
 b=YS8I9vMjRED5R7US0GfexZ0eiJIlVDrn4NZ2aZwMPrVnKz39awIokNLs7AGP4E4R3z
 gkXP+loMbUA9z29btVy19Z/wpzy4nseIgfT73+b9YG6pUj1Ipqb04IppFBIuGmMrlpw5
 F6tANze6+j7B06Y432YYramFkC8liW9eYZjGtZfA6hSzyObCgmpfBFiUJyrtR0Sb2sY/
 AkSOJ2sPCP7hWf2p3p/2NZKW7NuDbBzCdf0EFZ6P0nbI4cDD9LKAbtruRVTJ7Ep8oAlU
 HVFtdHghdDMqRKbSAalo3tH9y2MCOcEum3LvEdtXnZEowfiJ2v9h27SbLtcEGnUNlDOG
 6PxQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXxgT87JFBrDhSR2qIz8eIES2EboKcrAkAF/KQjYlBJ9uhfGoQI80JULOOA1+RqLDVxHW8eEqowIoXF@nongnu.org
X-Gm-Message-State: AOJu0YyK8dXFl30yDNFju27klRD84hMOqYNyuRJ0JFU70NHChM358PK0
 M6IzOgSKZTKXwznt8TkR8/2KikmPKAJVBveawkY+cNXTgKXwp9iXNzVKAIAkxesbwZe88LqE0jO
 utqnNAi11QQ==
X-Gm-Gg: ASbGncu5t5Pd9dJ4HhoQ8MJTdrvLVHhXoWNeOZx1U79hIn8i1yMoqm6KAsMYXVPDjra
 qmrLXdeRi2WuojEbJj8WvbkUMP9UwDUK9EwxyVv7pJ8RLNKvxc7Pbyyd4O839SpPfposLVvBdd7
 g/cNAnLaFKRQbf4HcXJWFMjHU4/Nn2x3R2AJ31eda/cnVLe+PMwRpAwoUg+l4BN/d8zJmtwof7k
 vp5R85RVz5ejV/eQnV0ECF9TxNUaPtFfSUuSk5hXy7Jt6P/2vNDTGu0YYoidtcI294yR9uaC3ye
 6E1lrDUZGN00yy7n5TPMsjXNgtIzQWW/uTZnrNFkjnTqdOvKTb7j9wIZqj8Qqe1fmcH1cw7JZIo
 sBuq/VfidtZYK+KtXVom9X8PTIFz/xPoXGd4ll66B6n/Z1OKO+r/TkTqlVxBWj+SwonNlUF2mVb
 K34Vaj6OghIovM3QldgZ4bhhmkbDcZGYkfDV2t1WFfpiPFVm9FrnhL4qCr2Downp/NbcU2zOl2W
 HfL
X-Google-Smtp-Source: AGHT+IEDrtNwiQVEKIxrBNTT4+svDVaBFhYvUyjG4DcM7zynTEJEydw/FwGyHPUO92bfoeUjfE2OnA==
X-Received: by 2002:a05:6000:2384:b0:428:3d75:b0e8 with SMTP id
 ffacd0b85a97d-429bd6ed1b7mr3465476f8f.62.1761919119632; 
 Fri, 31 Oct 2025 06:58:39 -0700 (PDT)
Received: from [192.168.1.17] (adijon-656-1-155-31.w90-33.abo.wanadoo.fr.
 [90.33.190.31]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429c114c944sm3741112f8f.20.2025.10.31.06.58.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Oct 2025 06:58:39 -0700 (PDT)
Message-ID: <3d89ba27-4ef0-40a7-b0c2-72afaee032d3@linaro.org>
Date: Fri, 31 Oct 2025 14:58:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/21] crypto: replace stat() with access() for credential
 checks
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 devel@lists.libvirt.org
References: <20251030144927.2241109-1-berrange@redhat.com>
 <20251030144927.2241109-4-berrange@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251030144927.2241109-4-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, T_SPF_HELO_TEMPERROR=0.01,
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
> Readability of the credential files is what matters for our usage,
> so access() is more appropriate than stat().
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   crypto/tlscreds.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


