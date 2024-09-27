Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1ED5CEBF8A
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2024 09:30:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1su7IQ-0005Lw-38; Fri, 27 Sep 2024 05:29:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1su7IN-0005LI-JF
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 05:29:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1su7I8-0002WY-CF
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 05:29:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727429374;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=05ZE16n0d092iDI2xtV1S/GyJvgOevhxTLSnFokSsiw=;
 b=SdnGI1QNqABG/9ojpyyKDqbvCX2o5ZDrtmxJAHM5lyH5E/aByZrANrJXTrE42Lz32tr0VW
 XOlDPTRa5wH9+IDYApuRgAYHaAA2iEQTSPe2EA8vXi3nhqCCbdNIK1dYgYeWtkOwFKtK4E
 hSEHzC+WlbbNyDbAqNwUHesMTwF1tmE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-533-LPx33PdDPKiYcfzDiuNpZw-1; Fri, 27 Sep 2024 05:29:32 -0400
X-MC-Unique: LPx33PdDPKiYcfzDiuNpZw-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-42ca8037d9aso11980835e9.3
 for <qemu-devel@nongnu.org>; Fri, 27 Sep 2024 02:29:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727429371; x=1728034171;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=05ZE16n0d092iDI2xtV1S/GyJvgOevhxTLSnFokSsiw=;
 b=KfAQFlYhFraLjKbBSsfXaL/HJlqRRkwj9F79IBIcTpc/mPLKe3EUmUUEcX7Y+S8nDu
 7sExeE2GmKLgMwfipzbqT+GcHYB5ee3Pf5CSeJFTUJloYvKPQ8WZvBpRQhYuB30FohNg
 IVL8DM5RMzo8qvWW7h5MJ76Aj2kMU3/R3oG68oDC3ToftoDuP0GG+R8AgqBRCwmyK/rA
 S4ogbJbq04Hm5J/a8/V+QZwfq/Cn9wC294KGJkXQhSdZucFgPzLzhBmRsnUuamyDumiX
 DL0y6q+hOw5AO9H3uMk8mqpsz8fqmiO9AjAmxOTtxzDBWsxUZ1fBGFbVgfYifICsRync
 vW0Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2+AmaS9tIFINoX1y2diPoa4M6RT2S2Q1vo7Fihc17/fJxqc5LY55R7nXvt+a8ywcUj/ll6DkRqIEF@nongnu.org
X-Gm-Message-State: AOJu0YzqnEOADPTpgFFM20sjBumBYxwljYITTjVFl5Zo0wUForxlXDr9
 fm46c818a7dgIwovpyhiVVGV+XCgkIua0hA7RkS5S6H3D3oA8SD+d7I2xgTsEcTQaTTgeDLudIi
 9Y8hIAY5fLHlWjrI9LL/+DT9v6Cf3FGwpdx322LYcA8FSmRpmYXov
X-Received: by 2002:a05:600c:350f:b0:42c:b34d:720c with SMTP id
 5b1f17b1804b1-42f5840ce88mr15635445e9.4.1727429371606; 
 Fri, 27 Sep 2024 02:29:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGCHM6DNEMEGVJyI9a1DkTfp4fjXRMN5ZKwca8INgwHQSIl9bLMOz9Ra1SNetXTCNR35YBv2w==
X-Received: by 2002:a05:600c:350f:b0:42c:b34d:720c with SMTP id
 5b1f17b1804b1-42f5840ce88mr15635225e9.4.1727429371154; 
 Fri, 27 Sep 2024 02:29:31 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-48-176.web.vodafone.de.
 [109.42.48.176]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42f57dec169sm20705005e9.21.2024.09.27.02.29.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Sep 2024 02:29:30 -0700 (PDT)
Message-ID: <4d4a0c9b-45df-4d2e-b47d-f9ab898801cd@redhat.com>
Date: Fri, 27 Sep 2024 11:29:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 7/7] hw/gpio/aspeed: Add test case for AST2700
To: Jamin Lin <jamin_lin@aspeedtech.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: troy_lee@aspeedtech.com, yunlin.tang@aspeedtech.com
References: <20240927083351.2637798-1-jamin_lin@aspeedtech.com>
 <20240927083351.2637798-8-jamin_lin@aspeedtech.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240927083351.2637798-8-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.131,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 27/09/2024 10.33, Jamin Lin wrote:
> Add test case to test GPIO output and input pins from A0 to D7 for AST2700.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   tests/qtest/aspeed_gpio-test.c | 68 ++++++++++++++++++++++++++++++++++
>   1 file changed, 68 insertions(+)
> 
> diff --git a/tests/qtest/aspeed_gpio-test.c b/tests/qtest/aspeed_gpio-test.c
> index d38f51d719..9d978b70e0 100644
> --- a/tests/qtest/aspeed_gpio-test.c
> +++ b/tests/qtest/aspeed_gpio-test.c
> @@ -33,6 +33,10 @@
>   #define GPIO_ABCD_DATA_VALUE 0x000
>   #define GPIO_ABCD_DIRECTION  0x004
>   
> +/* AST2700 */
> +#define AST2700_GPIO_BASE 0x14C0B000
> +#define GPIOA0_CONTROL 0x180
> +
>   static void test_set_colocated_pins(const void *data)
>   {
>       QTestState *s = (QTestState *)data;
> @@ -72,8 +76,64 @@ static void test_set_input_pins(const void *data)
>       g_assert_cmphex(value, ==, 0xffffffff);
>   }
>   
> +static void test_2700_output_pins(const void *data)
> +{
> +    QTestState *s = (QTestState *)data;
> +    uint32_t offset = 0;
> +    uint32_t value = 0;
> +    uint32_t pin = 0;
> +
> +    for (char c = 'A'; c <= 'D'; c++) {
> +        for (int i = 0; i < 8; i++) {
> +            offset = AST2700_GPIO_BASE + GPIOA0_CONTROL + (pin * 4);
> +
> +            /* output direction and output hi */
> +            qtest_writel(s, offset, 0x00000003);
> +            value = qtest_readl(s, offset);
> +            g_assert_cmphex(value, ==, 0x00000003);
> +
> +            /* output direction and output low */
> +            qtest_writel(s, offset, 0x00000002);
> +            value = qtest_readl(s, offset);
> +            g_assert_cmphex(value, ==, 0x00000002);
> +            pin++;
> +        }
> +    }
> +}
> +
> +static void test_2700_input_pins(const void *data)
> +{
> +    QTestState *s = (QTestState *)data;
> +    char name[16];
> +    uint32_t offset = 0;
> +    uint32_t value = 0;
> +    uint32_t pin = 0;
> +
> +    for (char c = 'A'; c <= 'D'; c++) {
> +        for (int i = 0; i < 8; i++) {
> +            sprintf(name, "gpio%c%d", c, i);
> +            offset = AST2700_GPIO_BASE + GPIOA0_CONTROL + (pin * 4);
> +            /* input direction */
> +            qtest_writel(s, offset, 0);
> +
> +            /* set input */
> +            qtest_qom_set_bool(s, "/machine/soc/gpio", name, true);
> +            value = qtest_readl(s, offset);
> +            g_assert_cmphex(value, ==, 0x00002000);
> +
> +            /* clear input */
> +            qtest_qom_set_bool(s, "/machine/soc/gpio", name, false);
> +            value = qtest_readl(s, offset);
> +            g_assert_cmphex(value, ==, 0);
> +            pin++;
> +        }
> +    }
> +}
> +
> +
>   int main(int argc, char **argv)
>   {
> +    const char *arch = qtest_get_arch();
>       QTestState *s;
>       int r;
>   
> @@ -83,6 +143,14 @@ int main(int argc, char **argv)
>       qtest_add_data_func("/ast2600/gpio/set_colocated_pins", s,
>                           test_set_colocated_pins);
>       qtest_add_data_func("/ast2600/gpio/set_input_pins", s, test_set_input_pins);
> +
> +    if (strcmp(arch, "aarch64") == 0) {
> +        s = qtest_init("-machine ast2700-evb");
> +        qtest_add_data_func("/ast2700/gpio/input_pins",
> +                            s, test_2700_input_pins);
> +        qtest_add_data_func("/ast2700/gpio/out_pins", s, test_2700_output_pins);
> +    }

Are you sure that this is executed here at all? As far as I can see, 
aspeed_gpio-test is not executed for the aarch64 target at all, so this 
looks like dead code to me.

  Thomas


