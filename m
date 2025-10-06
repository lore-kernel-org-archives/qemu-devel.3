Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82CCECCA470
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Oct 2025 20:35:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5rua-0000Um-Fr; Mon, 06 Oct 2025 16:34:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>) id 1v5ruY-0000Ua-VV
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 16:34:22 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>) id 1v5ruW-0001AO-Kx
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 16:34:22 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-76e2ea933b7so4433552b3a.1
 for <qemu-devel@nongnu.org>; Mon, 06 Oct 2025 13:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759782858; x=1760387658; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
 bh=UgwEzDcEsNFuCVBIr868c18REO+D/J0U4BTFHPH6dPQ=;
 b=hjnaXUKP6JWxdMHYKgylL7HIKKcsKJWA0E8F9BUT3l77AiV352XkfLswKdg59Pzkoq
 6RCjbQ8oDdmDbCGIyRd3VqgJtdsE+BtbtBn5BlWKOG5D2ZZIo3pdLcP8JApbML5JP6+x
 Rj0/dRO/pDp+Vcf8/umGbmyshY11AGNjEuzOwLMSXYqkEW1fzIcUYyH9Zj5jVU3Jp4m/
 ZzbuBjrFP2Pze8tO5s4cbzW9u6lQd6dkmRJEChYjfHCl4QsPcme2ez1LhmlhUWKuLg2F
 dcFOUlD0SQIQ5O6AWA39d++MZbaNYz+xv6iPJRDoYbs/QalsARPB/qvEOYZQUz9BlYs+
 aHOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759782858; x=1760387658;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UgwEzDcEsNFuCVBIr868c18REO+D/J0U4BTFHPH6dPQ=;
 b=YDdnOh9+cF4u3BCqzfmZkX++K2dQDhYUmdqQbNf43fuugfxeeYC7tqhAr7G7wr2Jhl
 DNSlb4Lqtlahi0kI2lrKOrHEPQAXPUvPs14fWz8LH023Me4JGHVef3aMQzp9pZcji+JD
 N1ospJUVmMtNp0azs2XboDk8CsVWv48nqDWjqn59PP6czNgGvlz09H3BGQt3RhbM16cW
 uvOYM0vdWViHSLBo7zwkR0bnijxR329berlQjrWrfQMg1o63LfLQ3OmvdmjTB3jYwjTd
 PCxHBi7YxOWWnwvwPeyM3WxwXmO0iBSL/arVns4R2yY+jxAXQ7Po16CADent48LHN0ZO
 oWSg==
X-Gm-Message-State: AOJu0YyFX6zniR68PKdZggfBUKBhRoHYTOJPbAhnqmu0lBLQ1Y6MYoE2
 WbH2CM/ifa2kT1FTvs4aA4hmOr8JEaJIqJLkVTK7wWQHlViy/mEj4AjP
X-Gm-Gg: ASbGnctlgFI/9LTOu2epYhDJ2eKYhcq7Zu8342ONFgA6gA84ooaZdFojOigWcFZMgo1
 WRN+yB+YVMN6e5qLayDk6yFbBT6VIHs748qCe0aDA+xyj1dqeiDTaSUEFeMEX6wd32/fdk+jmQ3
 GOFCmsk2vzLW1oICqU3QqNcDHiQO0zTIiFyCG57TUKe1V9I7UvzModpkJkox2jzksPssta3srh2
 aBGY5Qg6sbPBtb/DtKre2mjT+I5j2coQE5H+WPgY9buKPsZYIar3F4HV1zcEad73UbE4WR/o09q
 uUqkcgGeElLsh8dqzMuqHSuJswsvh+SXgcvOJHMKlsaPINHWVOiqbylTpnX8ovk5wm5FSnGyHmH
 /VkkqKTyEeSvVnSTi2z1GwcCg+Pgtbg3mIvUik+S1eEVpHwhTSrZLNgQ1j+z//eAgOogG9N6ALm
 yFBD8LfXO0n/Axm3gf20lc5OvvTL4FvA==
X-Google-Smtp-Source: AGHT+IHwkC+Z2C7z0fXa5iUvtYp/iej70od0Bt4iM6twN0vsopMIguW4TV25jyFdVozKA57ZFKiwhw==
X-Received: by 2002:a05:6a00:140f:b0:781:1f58:ce6e with SMTP id
 d2e1a72fcca58-7923084e057mr1005144b3a.4.1759782858352; 
 Mon, 06 Oct 2025 13:34:18 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5?
 ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-78b020938b1sm13272528b3a.83.2025.10.06.13.34.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Oct 2025 13:34:17 -0700 (PDT)
Message-ID: <67097d9c-ec3c-420c-b5b3-e2f3595a0612@roeck-us.net>
Date: Mon, 6 Oct 2025 13:34:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/6] hw/riscv: Make FDT optional for MPFS
To: Sebastian Huber <sebastian.huber@embedded-brains.de>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-riscv <qemu-riscv@nongnu.org>,
 Alistair Francis <alistair23@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
References: <20250319061342.26435-1-sebastian.huber@embedded-brains.de>
 <20250319061342.26435-4-sebastian.huber@embedded-brains.de>
 <38528707-3d28-4be8-8b58-60269cb1db1b@roeck-us.net>
 <788527663.312.1759727663914.JavaMail.zimbra@embedded-brains.de>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <788527663.312.1759727663914.JavaMail.zimbra@embedded-brains.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=groeck7@gmail.com; helo=mail-pf1-x42d.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 10/5/25 22:14, Sebastian Huber wrote:
> Hello Guenter,
> 
> thanks for the report. Do you have a Linux image and a Qemu command line so that I can test this?
> 
See http://server.roeck-us.net/qemu/riscv64/

run.sh executed with qemu 10.1 or later should trigger the problem
(the command line is not passed to the kernel).

Guenter



