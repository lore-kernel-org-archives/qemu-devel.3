Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DC33CEE347
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 18:10:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLQ9w-00075I-0o; Tue, 18 Nov 2025 13:10:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vLQ9t-00072f-J8
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 13:10:30 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vLQ9s-0006wd-6F
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 13:10:29 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-47796a837c7so22910335e9.0
 for <qemu-devel@nongnu.org>; Tue, 18 Nov 2025 10:10:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763489426; x=1764094226; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uR5/yM7IYBjMk3NdNwXKqqT1F26CKwhzXg2M8+Ly0MI=;
 b=wTR42MXSkjKCh2MliEvTAHU9RfCP3X07xAh7twAdiobHcuRjY3X+uJrISXsfTWPA6j
 TrsOZ6JyoMjyDLAogHI7Rs/iyBxIctxA6jHAa9HEQXUNbGgkHsgOQu1EktHbdp+MFbGL
 yjSZaDcEbDrcEmY7eL4hEMz4kxn+eOuWXbnMVhqL7+qujVQKM4ClaKyP0WERhTq9ff43
 ellze+bGSwDb99pJuyRwTXL0lBYFnRC2eV3QTJH2LH2KbEDCM71081s5axTw+MSQIes0
 zpVv+DPzHfIS/D9I0cmvXlgIG2T9D6HKl4UewGysaRpyKk5i79n8sSm8norH/fqrxbxM
 YTgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763489426; x=1764094226;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uR5/yM7IYBjMk3NdNwXKqqT1F26CKwhzXg2M8+Ly0MI=;
 b=vwiHanucMTSyBBr4vIiog1cMO2haHqmYVE7WcY/RweHKWgP20wtnYAfI+FkOCiZIx8
 CETR3RCvOkBsUw2Y8X2d2Ue0R9FvbNWb7Pck0wNlkIelA7QGuptmGA6ckpmRJi0ocyhT
 YPYrvGwaXPbwy7uuZyGofm6OBnyKtQcVtgyqWQdfC+fIcViwOdGE2pbGqFFZDJWs4W/I
 dIxPcHSztsZZgdg08zRNMvuPo3KZlZwMrPlnyTcr9/VPXJSt9YcK1rneG1YujyC8g+uF
 tP11R//d6B/clCtMXHMdFbwoPDaeB8rlZ1qC2s1TLee6areyNOP7Rr669upxlZtdg7IN
 nvOQ==
X-Gm-Message-State: AOJu0YzPhcAzYhL3MJG+3Ojcg/o5nek8VDS0SDNecMgP/0GpYHElFVd/
 6P+WLcoCFjxqZzAgYlBCViRDoZ87swoZucauSmJq5/NrUFnpg5PYZOE7LfmWW9mAaLxf3WNSOXe
 bb0Pe2WW1Rw==
X-Gm-Gg: ASbGnctXYbwWsrGbpjKq6GClJsopjiOfTLOCZJzQEuELnMSwsSmb5fg287uP9T7l48p
 9WrXYwENMxh0Bp9MaT4LtuUnp7EH9qKiNWBYCq0ReGOUoraBZIzRy6D1/SMU22rVH7UUwzgHWSf
 Ilu12/kGZMinIcZl7SDwJFfSgmKrWJemLIGdYz4PNi3Y2DXOKC8NpmE1M798afPYnP7bgiWG/3p
 p0Z5mJC2EU7xysMWcB9d10V6kgyjcIOSJtUqHpmNOJMdV+3rihJz7KvNZ5I2YuXTVhm2xExCFYi
 Oci5Mq1fbh/KrJ2oP2Ds4fTBTCSizZdifZrXb8X5e5mKji8y3woaK3i6GdrmgDnog8WOiPCPmhV
 l69X34zGzZgkE58r120+8r1T43cf9umzYjSpYj2bHb5hdbWDQenpxmt6TnMGw/8oQK0coBOl6kk
 59d+7AUXURvMgOgb9m/n+4UURA7Lpl7i8OhI30bFkLUgKNJUnqfuRzbw==
X-Google-Smtp-Source: AGHT+IGbYrXstbW7fiwiunh2+f+HI3X6tpKYbSmM4SxSSc6jvmbDOnUkuGwN60k1nego5JQCzr3s6A==
X-Received: by 2002:a05:600c:4f51:b0:477:a02d:397a with SMTP id
 5b1f17b1804b1-477a02d3af1mr90400055e9.2.1763489426095; 
 Tue, 18 Nov 2025 10:10:26 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477b10804c8sm2525115e9.15.2025.11.18.10.10.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Nov 2025 10:10:25 -0800 (PST)
Message-ID: <5c98f807-a872-42f4-a911-7f9b7aa3a091@linaro.org>
Date: Tue, 18 Nov 2025 19:10:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.2] hw/southbridge/lasi: Correct LasiState parent
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>,
 Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20251117091804.56529-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251117091804.56529-1-philmd@linaro.org>
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

On 17/11/25 10:18, Philippe Mathieu-Daudé wrote:
> TYPE_LASI_CHIP inherits from TYPE_SYS_BUS_DEVICE, not
> TYPE_PCI_HOST_BRIDGE, so its parent structure is of
> SysBusDevice type.
> 
> Fixes: 376b851909d ("hppa: Add support for LASI chip with i82596 NIC")
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/hw/misc/lasi.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Queued, thanks.

