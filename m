Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 392F3EE20BD
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 08:22:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpMXG-0008RL-R0; Mon, 09 Feb 2026 03:22:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vpMXD-0008Qe-Nu
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 03:22:19 -0500
Received: from 8.mo548.mail-out.ovh.net ([46.105.45.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vpMXA-0003lC-H9
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 03:22:19 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.110.58.107])
 by mo548.mail-out.ovh.net (Postfix) with ESMTPS id 4f8d376wqdz5vqF;
 Mon,  9 Feb 2026 08:22:11 +0000 (UTC)
Received: from kaod.org (37.59.142.112) by DAG14EX2.mxp5.local (172.16.2.142)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Mon, 9 Feb
 2026 09:22:10 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-112S006d19b72f1-7758-4ec6-a934-66cbd8db4ac4,
 ECF38C093296ADD45142D325C9F6EF635D78D8A6) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <31a22691-3b03-4ea4-bec3-79ec8aadaa99@kaod.org>
Date: Mon, 9 Feb 2026 09:22:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] hw/i2c/aspeed_i2c: Fix Out-of-Bounds access by using
 dynamic register array
To: Jamin Lin <jamin_lin@aspeedtech.com>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>
References: <20260209014540.823794-1-jamin_lin@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260209014540.823794-1-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.112]
X-ClientProxiedBy: DAG1EX1.mxp5.local (172.16.2.1) To DAG14EX2.mxp5.local
 (172.16.2.142)
X-Ovh-Tracer-GUID: 63e7395b-90ad-4d56-9c7f-7da3e445a25a
X-Ovh-Tracer-Id: 11039167112547568562
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTEd0bbYYrihEJuSVf7R0Pt11OYf5fdPWLHG91JszuJiajrGtpFOJAs9Qm/SXkxXTALzVQuwXHUZ6EIQl3tCDyzgYGgQ+P2P/UNm0+ygirDYNCc8PiF8xBnQM3cf8Ed1Wm3OmniOGlic5Ndln7GK22K/NcZl02VFL9PHMX1idwVPqEKbhLrFWJF1032adNRPQKmrneWAbI080W/YYr74lsCck2yRAKrfFrpypKVsJmivIdbiB9PHILKg7jvjKt3af7PXgvtynE0gZweKv+fj/D6rFxw2u5ov0HRBHJNzWYfUEhqF8Qbv0kOUe5A7iUV/E3597qwD4VGGS7vLw4EaIAQMjFmMOd+jJACqawo/tThKpNNtX4IB+SYDx+odTbnQmmYrUMNETE1JFrSibHzOA/zhGUEE7Jumni6NOKp+bdriNe9NGRLWUPZtuI/IryshPaAvPtUqrn8t+ZBi3q7WYjSUBaLWXj3WTu4C+ZQATMRZFRbLwsKe+Iib4P1vc1sRhToOUuz/dQgzpi1ylzd0nrT+7FbhrWDyr5aNblgQRSaB+6D4dPv5YkSZQeefIFZlBWLWjlcRy8i+F7h2qUbi93qLa/AR5Hv2hai+Ka2LPbjpw0l6HJICHnE0uMqU1QFaRN5Wg40VzVC7+whLYQxfIevZKEOMLzbkZMEYviuGWuBeiQ
DKIM-Signature: a=rsa-sha256; bh=sU/xQ94hE0S0yMyIo2qS/ohMaTcrQRhUCvW4u+KGx78=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1770625333; v=1;
 b=WRcvYDcjdIyJtFfL1GoJF6eFKMbyfbFkt5Fvy0GXA0kSfSx+0t+iEkNAm2y8J3eFy3kc+irq
 8G2WLJcbHvyD0eXwTlCEmFXnxH6NZETeFOk1WM5biOri1aM02Jofej1mFSfasyap3yk1ZzvR5zB
 Zv9GwpyqTnt3BrJnJ/Ab0o8rIqQUpbThpdDWNVtOl5P3kIYhqtmJDKWHq4pwzH3FXA9f39o8urD
 jS47Kcz+0Wnu0VLi4Cm5ggVLIir+BAWb1+f4Q4wmSRJXEJ7edZdCrEveJG2BQBryPl/V3nKJ0Tj
 sD2KbfMGzbxVhFjZcKONV4aAs39LYI02CP9AQ96E1Sw6g==
Received-SPF: pass client-ip=46.105.45.231; envelope-from=clg@kaod.org;
 helo=8.mo548.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2/9/26 02:45, Jamin Lin wrote:
> The ASPEED I2C controller emulation used a fixed-size register array
> (28 dwords) for all SoC variants, while multiple ASPEED SoCs
> (AST2600, AST1030, AST2700) expose a larger MMIO register window
> (e.g. reg_size = 0x80).
> 
> This mismatch allows MMIO accesses beyond the allocated register
> array, leading to out-of-bounds reads in the I2C controller model.
> 
> Fix this by converting the register storage to a dynamically allocated
> array sized according to the controller class reg_size. The register
> array is now allocated during bus realize and free on unrealize,
> ensuring safe access across different ASPEED SoC implementations.
> 
> This change eliminates I2C register out-of-bounds access caused by
> SoC-specific register size differences.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3290
> ---
>   include/hw/i2c/aspeed_i2c.h |  4 +---
>   hw/i2c/aspeed_i2c.c         | 18 ++++++++++++++----
>   2 files changed, 15 insertions(+), 7 deletions(-)
> 
> diff --git a/include/hw/i2c/aspeed_i2c.h b/include/hw/i2c/aspeed_i2c.h
> index 68bd138026..205f0a58d2 100644
> --- a/include/hw/i2c/aspeed_i2c.h
> +++ b/include/hw/i2c/aspeed_i2c.h
> @@ -36,8 +36,6 @@ OBJECT_DECLARE_TYPE(AspeedI2CState, AspeedI2CClass, ASPEED_I2C)
>   #define ASPEED_I2C_NR_BUSSES 16
>   #define ASPEED_I2C_SHARE_POOL_SIZE 0x800
>   #define ASPEED_I2C_BUS_POOL_SIZE 0x20
> -#define ASPEED_I2C_OLD_NUM_REG 11
> -#define ASPEED_I2C_NEW_NUM_REG 28


The ASPEED_I2C_NEW_NUM_REG value correctly covers the supported range
of registers of both 'old' and 'new' implementations.

Instead of dynamically allocating the regs array, which introduces
vmstate complexity, I would fix the way the array is accessed.

In aspeed_i2c_bus_old_read(), change :
    uint64_t value = bus->regs[offset / sizeof(*bus->regs)];
to
    uint64_t value = -1;

and adjust how 'value' is assigned else where.

Same for aspeed_i2c_bus_new_read().

If you want to keep the dynamic allocation, the vmstate needs a fix.
May be introduce a 'regs_nr' attribute for that and check how other
models save/load dynamic arrays.

Thanks,

C.


