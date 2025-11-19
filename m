Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D585DCF3189
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Nov 2025 10:22:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLfKc-00013C-7I; Wed, 19 Nov 2025 05:22:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vLfKa-00012V-74
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 05:22:32 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vLfKY-0001yK-Gh
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 05:22:31 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-42b3c965ca9so3352249f8f.1
 for <qemu-devel@nongnu.org>; Wed, 19 Nov 2025 02:22:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763547748; x=1764152548; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=D05WlJvleh/QQVqFXOHzRxL94yiC+gsCRKAsvzbXy5Y=;
 b=sakGkIRZ0f61r1JYhpvh4sdPB8Bq5XznS+AB3/KuSd3KGYm6h4HAWHYQV63QHH0XMN
 RmG+3CxVlM3LZg1kZiun/AEd7l1Iy+NGCZwQtSHqcQU2rWb1XOO6Lt1+agHz6iQl+Cxn
 DIl9vM5mfVRclVs1oHyN8ZCZDV0ihkBTrat+c88RturPMImQpYJOJ0Oqol6HVpbKs8GW
 yPpwOiJRQs3Ix3Hhx5N1rqkP3dKobuvOfraNt8wRc01qtaYYK07PL7Opau6t2vDrz9Wo
 6vFz5D2FKw+h0ZCsStPOyLRnbr0sWRih6hqnE0lFfkZVzCDHDNbO+aUmcpvbPhbfWzCt
 XAog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763547748; x=1764152548;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=D05WlJvleh/QQVqFXOHzRxL94yiC+gsCRKAsvzbXy5Y=;
 b=cE7kDjG2hp5/sBNU3yob3nYdny3ua4wGnXV3Rn79X95kFj9XFC2j9xDnq4ZQ4oTQrX
 ZLou0Ykz3ddvqtB7HdQBTgCjgWKhbRtrYh8sQyGoe0bDv5D10nb8BRZkxtQVjc0EOZ9z
 JXJsqPdCQwidRPG4KUD8P3OrNJQB+juZbl2I/rf7vIU4FHkevpw7KDLZodpCjyvdw9Km
 q56NSMhK83BmV2J2BwvA+TBGMNy44g516bp+722JlRthJmJxg1N/5FHSqe4vycCKHux2
 QByqgjbCUKeSEoU+lpoZ/NP+xW0HKjzTJelKksoYT3XkmsAWgyONWVhiKCYzMzO785T/
 qwEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVbM3hWh2b1gFhc3EoiJJpGqb/spIPv36CASDCrJDh9BEItNxYzxQc4eUpd1NKqyZOxg5w8vVlAiJDi@nongnu.org
X-Gm-Message-State: AOJu0YxcM60yrH4FuMZrp9qt1URtHAII+aPcSosldg/xx6vc5SP4Hg4B
 ETsByLkZZZpbs99NKOXKMxYHd1g1x/9uFLm2VZWe/XM/g0+dWXXNGxq6adsvlYfkGlQ=
X-Gm-Gg: ASbGnctWBZgAP0sZnBaBmvum9gQ3pRoZJ/pAgj1GtHuaT13FuxxrEHmpY4YmwIZ3u3q
 /9G1s4DQG+CqKBZrHHIen//2WipXnhwSqtMhPRaKx2g9mUOQZSfSgtWKm/8a3YpjD5/fJ7+4uRH
 OQFZJ0MkmrEQZ3JFAzVh3laZ96zFcmQ3VrEeyzH7W3/DAXDRHlmpyx6wDsvRG65zmQInlx1qvw6
 VLI/vdO7qp0wdLJgqviB8fx3fNek5y187rmKFAKLrUX326xnioTW1b9CZA53RcsZtqgrxlT/v4M
 0yMjCEPwM5RDm1lG2wyCbGxaznlzaj6A6K3MvB3PQYx3nUvXjq7iCT0xKFejf54igvU8mDk1+hs
 K7EZ5VsNtc6E4xvKTQItjL4ZHbOtdLOCcn1rmzBE7QRWZKQQurzAkrst70vn2TIaKfMactVd/pf
 T07dTkaVYu2kIJKfjc12+CnYdxDmFpH28LtS8j5OB55TjvKSbwiPp60iiO0X0Z+WMn
X-Google-Smtp-Source: AGHT+IFVSp7Z87WR3kFVNXVjiCY3DKdeT8PeUwlOWi9kA2BE3QkXzbY6HoCRrcZn/3zrEtWnqKxL5w==
X-Received: by 2002:a05:6000:2c0c:b0:42b:3aca:5a86 with SMTP id
 ffacd0b85a97d-42cb1fc9664mr2286729f8f.57.1763547747575; 
 Wed, 19 Nov 2025 02:22:27 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b53dea1c9sm37317040f8f.0.2025.11.19.02.22.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Nov 2025 02:22:27 -0800 (PST)
Message-ID: <72c06177-a9f7-4fa8-9ad7-855a66b2bd8d@linaro.org>
Date: Wed, 19 Nov 2025 11:22:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-11.0 07/15]
 tests/functional/x86_64/test_reverse_debug: Silence pylint warning
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 John Snow <jsnow@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Radoslaw Biernacki <rad@semihalf.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>,
 Eric Auger <eric.auger@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 BALATON Zoltan <balaton@eik.bme.hu>, Glenn Miles <milesg@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Zhao Liu <zhao1.liu@intel.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20251119082636.43286-1-thuth@redhat.com>
 <20251119082636.43286-8-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251119082636.43286-8-thuth@redhat.com>
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

On 19/11/25 09:26, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> Pylint does not like the underscores in the class name here, so
> rename the class accordingly to make pylint happy here.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/functional/x86_64/test_reverse_debug.py | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


