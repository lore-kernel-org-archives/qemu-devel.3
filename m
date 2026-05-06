Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2FCCCD342C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 09:00:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKY6o-0001kN-1Q; Wed, 06 May 2026 04:59:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKY6n-0001jh-BU
 for qemu-devel@nongnu.org; Wed, 06 May 2026 04:59:57 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKY6l-0007Kx-FP
 for qemu-devel@nongnu.org; Wed, 06 May 2026 04:59:57 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-488af96f6b2so77899775e9.0
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 01:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778057993; x=1778662793; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pNC7E6IrBW7vIw4bZ3B4X4qRO4Qdnr0erjrpnILwPvY=;
 b=sQeV7S8PlGeIWBunoo2BasyhcAJXSsXro6y/nkeMDKsl19fN9u3g86hTZsjs4UAePm
 VEwk2r76yxFnl6rvi2Ej4RwNHkpoFtoTvzV65Zq+9drR82+5nL76KLP6FZiPjS/JSMxL
 AHW7g42EiKQI0sShtSI/3Jnf0Ei53p6PddoTda8yGWVh8uEmJwPwJ2sag9Bx5soD375K
 ilTUufHKUs2Vo3tWH/kmJiZvsBGSa4kHkY7ieFkSrFQg7iAn65sPcQv5nwrhmARIbzE0
 VCMYJ0zNZP/cQBoY5VzfIlJ+ewlEZm3OLHNWdcbOuLMvj4szFUc2+iG0CEJQGM5jUZFE
 yEmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778057993; x=1778662793;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pNC7E6IrBW7vIw4bZ3B4X4qRO4Qdnr0erjrpnILwPvY=;
 b=r4FR4m5r3bD+SNyASOODxDldmUdUoOq7PnnobGW34NTddf0YjCXoeWEg6qB9BO5Kj7
 rP5RSOuMg9ZQAcW1SYNw6f/7l8WIIQe89aJWpk46AWNd9Br3j4+qBeZNHd2RGEK75rB1
 AaNeIZKBvM+cKEwIFlVo/ekxzJT+NaoBzNoQubVwS1TyWa9RttjKv+2yo3Xn761pbTnq
 epYlBZ/RLj31uiaJcyekG45HHC92F/ASouRxmtn6J2YsviDJtj6lF8+auFqWXrleKNdE
 L4SXe1RVOICwvfTAm3KpfWb9n3jZKeFFmQBTnSbsOkxmEkGTs9mNqWfMe5WOqJeD35j/
 CKEQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+P0Fw/3GCMExq52nsb0UuEdblMy9Te/XvsRQ8Z9QdVKTT+cOpmSqaVcxTCOpQ0vFlPLTI+ZLkG20yl@nongnu.org
X-Gm-Message-State: AOJu0YyPimj64z1nomnKlnIF72e/1qQbaFUA/OLsTmCry62efFWLE0KW
 YYIRFw971SlM1nL9C8AGhbn9UgHFk+PHe8P/ioadEEsZVwMlEUtwWtAJbGmNXk7c/2M=
X-Gm-Gg: AeBDiesxk2rAVRkC79sa2bBZaX4rUdBA6FGww+k/lofKqJY8OXV2KG0bu8UhuJxUV2p
 slcOdbb2u0NfVyiU+luUKikhwxOCH7N6ITcDhGGFU65lqIYUVTkOeyKRtr2i701MuLBO6nruXoz
 F8yJT/y3Bdr5Xj3FSShqs+1egH0DpeYYt3O39dqRw64DYfTaW2wxcwM3SPLsAPvta6T4RUag3lu
 QTs8lLS/6nQvoKZOGG4Ax1vfSIpz2kVvEN/BkqG4ZIrlZ3V5sQP5hBk4K9lGc0hyQBSqDeNXwhl
 ++nBFyV4FGyYCidAFGL0Gj4bcIabxIDQ1Th1j6ZLuTCumyjpQVQ6DtIIVpWaVr1bCXGdGPyXnHb
 l4Cc1azIHFmcEQkuSUIk3t/hqb0XnLmWCyHs+FyPQhrz6jAg8QPbaDM2jMrHB0Xk2EU7OHmbpjA
 k92qH+I+zETMoRY5dNKi+wSe03s2j3niUFAfWn/CV6aiw7cYYCr2KwKdNcQyaTatZ05ZDd9f+E2
 UVU
X-Received: by 2002:a05:600c:2d51:b0:48a:6315:da26 with SMTP id
 5b1f17b1804b1-48e51f41bf4mr23679375e9.26.1778057993190; 
 Wed, 06 May 2026 01:59:53 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e5312dc04sm14352195e9.19.2026.05.06.01.59.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 May 2026 01:59:52 -0700 (PDT)
Message-ID: <f259ce5e-9000-40a2-8a0a-8d4724d9082b@linaro.org>
Date: Wed, 6 May 2026 10:59:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/13] hw/i2c: Add designware i2c controller
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Alistair Francis <alistair23@gmail.com>, Joel Stanley <joel@jms.id.au>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Chris Rauer <crauer@google.com>,
 Michael Ellerman <mpe@kernel.org>, Joel Stanley <jms@oss.tenstorrent.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Portia Stephens <portias@oss.tenstorrent.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, Hao Wu <wuhaotsh@google.com>
References: <20260425131721.932250-1-joel@jms.id.au>
 <20260425131721.932250-2-joel@jms.id.au>
 <CAKmqyKPyUYfnS3BsHT31hp_P5ufDOZHmr3VW8aUyeTTSTS-Rcw@mail.gmail.com>
 <afmKctliUOEgQrmN@lima-default>
 <1476b7df-b8b7-492a-b46c-81d0bf9cb66e@linaro.org>
 <afrXTtGrUClrUWMb@lima-default>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <afrXTtGrUClrUWMb@lima-default>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 6/5/26 07:58, Nicholas Piggin wrote:
> On Tue, May 05, 2026 at 09:36:57AM +0200, Philippe Mathieu-Daudé wrote:
>> On 5/5/26 08:20, Nicholas Piggin wrote:
>>> On Thu, Apr 30, 2026 at 01:53:21PM +1000, Alistair Francis wrote:
>>>> On Sat, Apr 25, 2026 at 11:20 PM Joel Stanley <joel@jms.id.au> wrote:
>>>>>
>>>>> From: Chris Rauer <crauer@google.com>
>>>>>
>>>>> In the past this model has been submitted for use with the arm virt
>>>>> machine, however in this case it will be used by the upcoming
>>>>> Tenstorrent Atlantis RISC-V machine.
>>>>>
>>>>> This is a re-submission of the model with Chris' permission, with a
>>>>> light touch of updates to make it build with qemu master.
>>>>>
>>>>> Reviewed-by: Hao Wu <wuhaotsh@google.com>
>>>>> Signed-off-by: Chris Rauer <crauer@google.com>
>>>>> Link: https://lore.kernel.org/qemu-devel/20220110214755.810343-2-venture@google.com
>>>>> [jms: rebase and minor build fixes for class_init and reset callback]
>>>>> Signed-off-by: Joel Stanley <joel@jms.id.au>
>>>>> ---
>>
>>
>>>>> +#define DW_IC_COMP_PARAM_1_HAS_ENCODED_PARAMS   BIT(7)
>>>>> +#define DW_IC_COMP_PARAM_1_HAS_DMA              0 /* bit 6 - DMA disabled. */
>>>>> +#define DW_IC_COMP_PARAM_1_INTR_IO              BIT(5)
>>>>> +#define DW_IC_COMP_PARAM_1_HC_COUNT_VAL         0 /* bit 4 - disabled */
>>>>> +#define DW_IC_COMP_PARAM_1_HIGH_SPEED_MODE      (BIT(2) | BIT(3))
>>>>> +#define DW_IC_COMP_PARAM_1_APB_DATA_WIDTH_32    BIT(1) /* bits 0, 1 */
>>>>> +#define DW_IC_COMP_PARAM_1_INIT_VAL             \
>>>>> +    (DW_IC_COMP_PARAM_1_APB_DATA_WIDTH_32 | \
>>>>> +    DW_IC_COMP_PARAM_1_HIGH_SPEED_MODE | \
>>>>> +    DW_IC_COMP_PARAM_1_HC_COUNT_VAL | \
>>>>> +    DW_IC_COMP_PARAM_1_INTR_IO | \
>>>>> +    DW_IC_COMP_PARAM_1_HAS_DMA | \
>>>>> +    DW_IC_COMP_PARAM_1_HAS_ENCODED_PARAMS | \
>>>>> +    ((DESIGNWARE_I2C_RX_FIFO_SIZE - 1) << 8) | \
>>>>> +    ((DESIGNWARE_I2C_TX_FIFO_SIZE - 1) << 16))
>>>>> +#define DW_IC_COMP_VERSION_INIT_VAL             0x3132302a
>>>>> +#define DW_IC_COMP_TYPE_INIT_VAL                0x44570140
>>>>
>>>> I would prefer these to sue the QEMU register API
>>>
>>> That's probably a good idea. It's a lot of churn to change it, but
>>> I'm having a try. Might do it as a follow on patch.
>>
>> Good suggestion but please as a follow up, this patch is already
>> big enough, is reviewed and tested.
> 
> I agree... however I implemented it and it is a large amount of chrun
> which is also not easy to review. Also it breaks migration
> compatibility. So I don't want to get this patch bogged down but if we
> agree to take the register API conversion then maybe we should squash
> before upstreaming?

OK.

> Not sure. I will post the patch as a separate optional addition to the
> series to begin with.

Yeah, you can respin this series without i2c at all, then follow up
with this patch, #12 and #13 (integrate i2c bus & few peripherals to
the Atlantis machine).


