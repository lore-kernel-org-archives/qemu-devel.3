Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1C62CE8373
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 16:37:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svJOV-0004PR-Da; Mon, 30 Sep 2024 12:37:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1svJOT-0004Mo-Pc
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 12:37:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1svJOR-0006Hw-Ud
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 12:37:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727714222;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Yb94j3vRM+NpzfYheQTDsZWP4NMxNiowy0/QwfkQogw=;
 b=BCM9fE9LXcn4Eb8FWs7m4ykbq+vEvqPIqnSp79GKSrASxEknPHtxzD/Vb7uAviun0Bi09d
 FrWUqR6UvCCUdQKYVn9ywFudrm8Kl9cLLySk2AXmDkyLbPD5q+/m4JlARZg3eFQoM1J/Iw
 7PmUvz76FxWRYwItLgsnYaaLX2+qVkg=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-204-nGGhjn1hPdS7E8Z-0aaezg-1; Mon, 30 Sep 2024 12:37:00 -0400
X-MC-Unique: nGGhjn1hPdS7E8Z-0aaezg-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6cb3a855022so67390456d6.2
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2024 09:37:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727714220; x=1728319020;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Yb94j3vRM+NpzfYheQTDsZWP4NMxNiowy0/QwfkQogw=;
 b=kszMfKgZFAc9sg8fmK2ZY48hMGwEL6JyY5HTVPRvE++ahv3+21bKZbj9V6zDmLFnBB
 gomBqdhtYnfbQsyhc+8y98R9/aV6AWL5I1maDBkxdeZ4O+BwIaOpSyfO15Y0qBGsfaHB
 14HwnIXjH3cSxWjUD2UC7JL4kNKFYjzJT7Ueqi5KXFuW7o6ISzLBN/UxKLIYaZnoegYt
 3fTcNoE/oIKbLsgCObxjop6ozMVwe/+4F+rOh4ChM2jTv2RvFcxn5/spZyVef34y8/2K
 AVutVmJgkpUuc5uTo71R9w4U9npi6XXScttsfLPhsHMikrgsOLaBHHCVz7Ry9zgqShIQ
 popA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmBTxcYHgw5wYI1YO7/JllrLQhDZ/TvwtQiNn6CebMcTW4Xmy1PCmke/9h5yLdFgRalixkdQkzxnUi@nongnu.org
X-Gm-Message-State: AOJu0YzMc5ArTDFoS5N7jntd0ha90UFfoO6TK7o9r/hUzybM+QNvBJQ4
 JEW1qSa11umqMgpeXC6IDF3Wv3XfoRRFeOdzefamn/9XZwVtZvkipZGoP/nxWPlscE/wWVtXrNo
 mwUxLhsD1opmpMNF9MkHQ1a4SclJvQljHR0e1ydRlWab74z2eQ9H2
X-Received: by 2002:a05:6214:3b8a:b0:6cb:4e76:25d with SMTP id
 6a1803df08f44-6cb4e76028amr123765376d6.37.1727714220018; 
 Mon, 30 Sep 2024 09:37:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5IMA8OETvrqHuG+aGeDMLI1r96uoqz8skR24tiW+RqJ2u8C3VicbSQaav0qpgD+1LLOS3Aw==
X-Received: by 2002:a05:6214:3b8a:b0:6cb:4e76:25d with SMTP id
 6a1803df08f44-6cb4e76028amr123765116d6.37.1727714219645; 
 Mon, 30 Sep 2024 09:36:59 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-48-176.web.vodafone.de.
 [109.42.48.176]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cb3b66d0d5sm41495686d6.81.2024.09.30.09.36.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Sep 2024 09:36:59 -0700 (PDT)
Message-ID: <e3f31190-85fb-41c9-9ecb-eefdaa8c5c49@redhat.com>
Date: Mon, 30 Sep 2024 18:36:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 8/8] hw/gpio/aspeed: Add test case for AST2700
To: Jamin Lin <jamin_lin@aspeedtech.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: troy_lee@aspeedtech.com, yunlin.tang@aspeedtech.com
References: <20240930085239.3089901-1-jamin_lin@aspeedtech.com>
 <20240930085239.3089901-9-jamin_lin@aspeedtech.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240930085239.3089901-9-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 30/09/2024 10.52, Jamin Lin wrote:
> Add test case to test GPIO output and input pins from A0 to D7 for AST2700.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   tests/qtest/aspeed_gpio-test.c | 77 ++++++++++++++++++++++++++++++++--
>   tests/qtest/meson.build        |  3 ++
>   2 files changed, 76 insertions(+), 4 deletions(-)
> 
> diff --git a/tests/qtest/aspeed_gpio-test.c b/tests/qtest/aspeed_gpio-test.c
> index d38f51d719..03b3b1c2b2 100644
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
> @@ -72,17 +76,82 @@ static void test_set_input_pins(const void *data)
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

As far as I can see, there is nothing in these two functions that requires 
any of the other code in this file ...

> +
>   int main(int argc, char **argv)
>   {
> +    const char *arch = qtest_get_arch();
>       QTestState *s;
>       int r;
>   
>       g_test_init(&argc, &argv, NULL);
>   
> -    s = qtest_init("-machine ast2600-evb");
> -    qtest_add_data_func("/ast2600/gpio/set_colocated_pins", s,
> -                        test_set_colocated_pins);
> -    qtest_add_data_func("/ast2600/gpio/set_input_pins", s, test_set_input_pins);
> +    if (strcmp(arch, "aarch64") == 0) {
> +        s = qtest_init("-machine ast2700-evb");
> +        qtest_add_data_func("/ast2700/gpio/input_pins",
> +                            s, test_2700_input_pins);
> +        qtest_add_data_func("/ast2700/gpio/out_pins", s, test_2700_output_pins);
> +    } else {
> +        s = qtest_init("-machine ast2600-evb");
> +        qtest_add_data_func("/ast2600/gpio/set_colocated_pins", s,
> +                            test_set_colocated_pins);
> +        qtest_add_data_func("/ast2600/gpio/set_input_pins", s,
> +                            test_set_input_pins);
> +    }

... so the more I look at this, the more I think your new test should reside 
in a separate file that only gets executed for aarch64, while this file here 
should stay for arm 32-bit. Or is there a real compelling reason for putting 
your code in this file here?

  Thomas


>       r = g_test_run();
>       qtest_quit(s);
>   
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index 310865e49c..292980e3ad 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -209,6 +209,8 @@ qtests_aspeed = \
>     ['aspeed_hace-test',
>      'aspeed_smc-test',
>      'aspeed_gpio-test']
> +qtests_aspeed64 = \
> +  ['aspeed_gpio-test']
>   
>   qtests_stm32l4x5 = \
>     ['stm32l4x5_exti-test',
> @@ -247,6 +249,7 @@ qtests_aarch64 = \
>     (config_all_devices.has_key('CONFIG_RASPI') ? ['bcm2835-dma-test', 'bcm2835-i2c-test'] : []) +  \
>     (config_all_accel.has_key('CONFIG_TCG') and                                            \
>      config_all_devices.has_key('CONFIG_TPM_TIS_I2C') ? ['tpm-tis-i2c-test'] : []) + \
> +  (config_all_devices.has_key('CONFIG_ASPEED_SOC') ? qtests_aspeed64 : []) + \
>     ['arm-cpu-features',
>      'numa-test',
>      'boot-serial-test',


