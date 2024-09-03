Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B894DCD37AE
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 20:50:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slaTC-00063Q-QT; Tue, 03 Sep 2024 16:49:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1slaT9-00062P-56; Tue, 03 Sep 2024 16:49:44 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1slaT6-0000a4-Le; Tue, 03 Sep 2024 16:49:42 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2053525bd90so29077505ad.0; 
 Tue, 03 Sep 2024 13:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725396579; x=1726001379; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
 bh=E0F/v2veV0YuRAxAXeKlGuCZDMCkYwUcOReGiMDAL9k=;
 b=CbbTuV7T7kCbsoaKZmNRDXpetJAH1dqpM+mUyH7H08nbqSj2CdiB59FGKMy5er643r
 RJZpwkOziyht57gIwRgIQbrrjXmJtu5+hU+LBkUNfVtG7/oCRgA4HQrPMrMx+8szB1We
 OXKrwYYDabSHGLiUJpl9y7pfFAfAYqziD3bx+ualpyMlJJs3YIG5EmtxAtKOC6Z4klrG
 CCfoParTENp9Sw5xDNA7QYVkjonz9XulOESVtizutEMht2vXaFfWZrmp+fYJwRkG7ZbF
 VJvECG47pgrLRS8D4vTjPX66Y1wqtPCteNsvhWPvQzGMC44e7qzczBiH7wHPBs19RO38
 4AMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725396579; x=1726001379;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E0F/v2veV0YuRAxAXeKlGuCZDMCkYwUcOReGiMDAL9k=;
 b=xTWSN8ZMTRbC2ZL6PgJ5iMgwHVe9NIb2wecBGuqbLHnBMStMmzPOjxXIAy+WcYyiS9
 alFbEKZdxIv2RtBvckaGgb2CIUU/fvi7/xicjPSUiVFRIEvlKemGjBXCSYI23l2pgSCv
 VjTmARRG46xJm5vnZc7skVzSNqXEjBKua+ssJMYoEY2YjCy0SQy1JJP7zsnkWROYqHer
 msu92EVtu+DGzZLea1yF5NgEt5fm4NthHfyoo4SxkubrkWfvz7MN8Ch24AKFCURRsZI5
 h5u9gxK3581aBNCHMEv4l+nAq+dWj8QoliUth//O47vOEzwd49fv99H0a9mO8bbCuLrL
 pRiA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+ZwjYFaGBtZxqxNQ2MzK1bi4HMVPL3UAD8Yo9B4fMI4ZZPYmH0YxmlyvhnhWOGwueGErhjiii7lKh@nongnu.org,
 AJvYcCV4hLdFJ42zyR1rfIcFJ8rYGz3zG/gqAi+IuS8T/VXsHJgB7D9SzBc3RqjLPyl49QtTcCRVr4J2hWCW1g==@nongnu.org
X-Gm-Message-State: AOJu0YzIDECLWqXF86GPjWnHoQz3V4kFe+RTKK3FL4fNGM5oWihjY6xZ
 NfPayZl8xWnOEwUVuFmZctWUYMOHyMZgsK/Tu1Lc0mVcYd5MOYlP
X-Google-Smtp-Source: AGHT+IH9h6yiS/YKyJdLYJsAgY5ehXDKH0SZfxEcH/yujmhdf6IAFsFyFeH9yoNIUk0u+Flu+43/Sg==
X-Received: by 2002:a17:902:d2c2:b0:202:3324:68bd with SMTP id
 d9443c01a7336-2054c248f61mr108409115ad.43.1725396578549; 
 Tue, 03 Sep 2024 13:49:38 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c?
 ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-206aea67fc8sm2345535ad.269.2024.09.03.13.49.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Sep 2024 13:49:37 -0700 (PDT)
Message-ID: <ac3df79a-edc1-44bb-9981-09142dcff44c@roeck-us.net>
Date: Tue, 3 Sep 2024 13:49:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] hw/sd: Remove legacy sd_set_cb()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org,
 Bin Meng <bmeng.cn@gmail.com>
References: <20240903200446.25921-1-philmd@linaro.org>
 <20240903200446.25921-2-philmd@linaro.org>
 <4965aeea-4e19-47a3-b330-6caa5994f40c@linaro.org>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <4965aeea-4e19-47a3-b330-6caa5994f40c@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=groeck7@gmail.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 9/3/24 13:10, Philippe Mathieu-Daudé wrote:
> (Cc'ing Guenter who asked to keep the SX1 machine)
> 
> On 3/9/24 22:04, Philippe Mathieu-Daudé wrote:
>> sd_set_cb() was only used by omap2_mmc_init() which
>> got recently removed. Time to remove it. For historical
>> background on the me_no_qdev_me_kill_mammoth_with_rocks
>> kludge, see commit 007d1dbf72 ("sd: Hide the qdev-but-not-quite
>> thing created by sd_init()").
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   include/hw/sd/sdcard_legacy.h |  1 -
>>   hw/sd/sd.c                    | 30 ++++--------------------------
>>   2 files changed, 4 insertions(+), 27 deletions(-)
>>
>> diff --git a/include/hw/sd/sdcard_legacy.h b/include/hw/sd/sdcard_legacy.h
>> index 0dc3889555..a121232560 100644
>> --- a/include/hw/sd/sdcard_legacy.h
>> +++ b/include/hw/sd/sdcard_legacy.h
>> @@ -36,7 +36,6 @@ SDState *sd_init(BlockBackend *blk, bool is_spi);
>>   int sd_do_command(SDState *card, SDRequest *request, uint8_t *response);
>>   void sd_write_byte(SDState *card, uint8_t value);
>>   uint8_t sd_read_byte(SDState *card);
>> -void sd_set_cb(SDState *card, qemu_irq readonly, qemu_irq insert);
>>   /* sd_enable should not be used -- it is only used on the nseries boards,
>>    * where it is part of a broken implementation of the MMC card slot switch
>> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
>> index a140a32ccd..8a30c61ce0 100644
>> --- a/hw/sd/sd.c
>> +++ b/hw/sd/sd.c
>> @@ -112,10 +112,6 @@ typedef struct SDProto {
>>   struct SDState {
>>       DeviceState parent_obj;
>> -    /* If true, created by sd_init() for a non-qdevified caller */
>> -    /* TODO purge them with fire */
>> -    bool me_no_qdev_me_kill_mammoth_with_rocks;
>> -
>>       /* SD Memory Card Registers */
>>       uint32_t ocr;
>>       uint8_t scr[8];
>> @@ -169,8 +165,6 @@ struct SDState {
>>       uint32_t data_offset;
>>       size_t data_size;
>>       uint8_t data[512];
>> -    qemu_irq readonly_cb;
>> -    qemu_irq inserted_cb;
>>       QEMUTimer *ocr_power_timer;
>>       bool enable;
>>       uint8_t dat_lines;
>> @@ -889,17 +883,10 @@ static void sd_cardchange(void *opaque, bool load, Error **errp)
>>           trace_sdcard_ejected();
>>       }
>> -    if (sd->me_no_qdev_me_kill_mammoth_with_rocks) {
>> -        qemu_set_irq(sd->inserted_cb, inserted);
>> -        if (inserted) {
>> -            qemu_set_irq(sd->readonly_cb, readonly);
>> -        }
>> -    } else {
>> -        sdbus = SD_BUS(qdev_get_parent_bus(dev));
>> -        sdbus_set_inserted(sdbus, inserted);
>> -        if (inserted) {
>> -            sdbus_set_readonly(sdbus, readonly);
>> -        }
>> +    sdbus = SD_BUS(qdev_get_parent_bus(dev));
> 
> Guenter, we don't have SX1 tests. I wonder if this call could
> fire an assertion. Do you have test images I can use? I'd need
> to eject/reinsert a card to get there.
> 

Have a look into
https://github.com/groeck/linux-build-test/tree/master/rootfs/arm

rootfs-armv4*are root file systems. You'd boot those with "noreboot"
command line argument to prevent them from rebooting automatically.
Let me know if you need more detailed directions; if so, I can make
a directory with everything needed.

Guenter


