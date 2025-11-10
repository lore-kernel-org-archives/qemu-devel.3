Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A71DFCCF9E3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Nov 2025 12:57:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIRS8-0001Tp-Tm; Mon, 10 Nov 2025 07:57:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vIR0r-0006pJ-CB
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 07:28:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vIR0p-0001rp-88
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 07:28:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762777725;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=UHCIcnmCFYluOts0s83RaynDq0U5VxapwBYKJ3qbFlY=;
 b=R99diqjNDBhNQRLJDqy/Mm1kaaH9FLwzxrdjXbzMg5L06KrMxtm2q4Vn6r9mB351/cd7RF
 RkZsoqHecnt4TF3XFXw053Sek4eR0bCF0Egxgg2llQFLCEfBTU+sJ6Gw7iZFv6AY4rWGow
 EEwz8+5v9UJPA5i4oxn7dXiR6Utb8Rc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-MYVSiR6SPWmCCjRoILC8vA-1; Mon, 10 Nov 2025 07:28:44 -0500
X-MC-Unique: MYVSiR6SPWmCCjRoILC8vA-1
X-Mimecast-MFC-AGG-ID: MYVSiR6SPWmCCjRoILC8vA_1762777723
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-471201dc0e9so22184205e9.2
 for <qemu-devel@nongnu.org>; Mon, 10 Nov 2025 04:28:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762777723; x=1763382523; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=UHCIcnmCFYluOts0s83RaynDq0U5VxapwBYKJ3qbFlY=;
 b=TQ/cXgpr3ANNpNhQ5yZQGN0ymLRJksR3iMRTVSuhnEUb9Y2jPxYXXskPlR44TnjET3
 R+Lx0J8m0LCbmmbNzrGxTPFLrDaXGmz3J+tFhgWy9bZIvs3t6bFSnaNOkkqqYqFtRA8k
 9vKzt2DX0THuBtHHD5/UlZTdHKYSj9pTZPg2yGOHgFUPteH+ViijymQXjnbg6+w/Eaji
 1diffdFCw053Eqt79u8P8pcpUce5k3XXZbjbrt3yxRIOhsJGTFoqicOfieqPEr4GcYN0
 xKYp66G5Q7G1ieGg+9MZAs4NgdbPVGcReCEb1RyP8NvLmPlq80Se0OmGMkd7WrSe2SUy
 Ne6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762777723; x=1763382523;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UHCIcnmCFYluOts0s83RaynDq0U5VxapwBYKJ3qbFlY=;
 b=DfyGzpmDNZ+Z9Likqg2jJqPakYM6eYTrxUIyaiUddZe5P3ETJc4LHQ3JPU1QtW8iyi
 A8Qz2+3EXfMSvB7vgtYpXuI9ZVX+KGaaDcpRsDI/XNPqLFWv5wKpcIOzCDrqHzbX+ETZ
 C1BA2zMmSzMDGQQA9qp56U0FOTfuiXxbOYL4Bsyj98YQdUX9Ca2I4pXO4GP9XpK15RaA
 ngUPYwuDZSZ17tHZONTzabcwmG8DcKbk4YsJXc0lyf1cjBQhoL9ooFF4WytL4sem3SDJ
 3fEQkt/A9ah3pn2nFuf6HWrxibF6pxGW/ybAl6Oa7v2sHaky+RZppkij4y5XlVl/sPSy
 Aa7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWyLJj3q4jTbR9xPahKlrbty24ab91Z6DELELKVsP4d75OXJDhd5It7TSDPve8oBDnAFgW23P1F8avG@nongnu.org
X-Gm-Message-State: AOJu0YxsdAPAF18edQCr1DHNIViXPLns4UV/WQZEyP24SZ+N+CQtRxNz
 vNP2fm3JGystmEF4y4NHBICFowYwLzBEcz0m7LdsUG9jLPEFNe0l556rvZxvqQBuNX8FaBXWWb/
 Ysh1F1mZeEltqa8LWhBov/aE0faSg9fZ5hFdZzqYguujq3Ro4lUwX59op
X-Gm-Gg: ASbGnctU+Yv5e1YpB63LUYTOotyG+45a8FDqZkUO0J5293lcv/D6BH5l0+Uqr3+rhKf
 WssLaLtnl3fzj42M9zblL09bXtBF/cZQiYKCPuE+xOytOA9BYy9hAXAGUNqFXGa+U3tdIVvJrzm
 R78qu83lkUjezBmoQ2TKE9qhe36xYC/qOhI1WbRatkmeZEGdCUOzeVI7/3PqJB/Z1enJkDy5hWE
 MYAkfV19Pp+s8nq4tnvIvejq3EYk4h1+Ve5VmcZI2rLJAWjl8xqQ7neN62KhVQ2XVDf79U2zowU
 lnocZtAjDsNbjRvnCu2dq+KqRADWTvAcSOGXrM3X1dDd86b9LFhFSD8WBrtQHVcocfT9aw92
X-Received: by 2002:a05:600c:474c:b0:475:da13:256b with SMTP id
 5b1f17b1804b1-4777329777amr70078895e9.38.1762777722954; 
 Mon, 10 Nov 2025 04:28:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGlXidrtTJ/SWo+IjP9zsPqLqPY8EnUauEJtqayLmsohT+XVNgx1nnDrtMXulJvKsAvoNmA4A==
X-Received: by 2002:a05:600c:474c:b0:475:da13:256b with SMTP id
 5b1f17b1804b1-4777329777amr70078655e9.38.1762777722548; 
 Mon, 10 Nov 2025 04:28:42 -0800 (PST)
Received: from [192.168.0.7] ([47.64.114.171])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42ac675cd25sm22203503f8f.22.2025.11.10.04.28.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Nov 2025 04:28:42 -0800 (PST)
Message-ID: <d3f15618-3f1e-4e41-9e0b-228923c78e42@redhat.com>
Date: Mon, 10 Nov 2025 13:28:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/5] RISC-V: NEORV32 CPU, peripherials, and machine
To: Michael Levit <michael@videogpu.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, philmd@linaro.org, pbonzini@redhat.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 liwei1518@gmail.com, smishash@gmail.com
References: <20251109191532.32419-1-michael@videogpu.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20251109191532.32419-1-michael@videogpu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 09/11/2025 20.15, Michael Levit wrote:
> 
> This v4 reworks the initial NEORV32 submissions.
> 
> The series introduces:
>    * a minimal NEORV32 RV32 CPU type and vendor CSR hook,
>    * the SYSINFO MMIO block,
>    * a small UART device,
>    * an SPI controller with command-mode chip-select,
>    * and the 'neorv32' RISC-V board wiring the above, plus docs.
> 
> Tested by booting the NEORV32 bootloader as -bios and chaining into a
> Hello World from an MTD-backed SPI flash image, with UART on stdio.

  Hi!

Are these binaries available publically somewhere on the internet? If so, 
could you please add a test in tests/functional/riscv32 that make sure that 
the machine is basically working, so we don't face any regressions in the 
future?

  Thanks,
   Thomas


