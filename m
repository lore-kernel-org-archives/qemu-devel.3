Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C542CE8E6A
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2024 17:54:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t421s-00054i-W1; Thu, 24 Oct 2024 13:53:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t421m-00054E-SC
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 13:53:42 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t421j-0002Ju-Dg
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 13:53:41 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-7db908c9c83so695639a12.2
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2024 10:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729792417; x=1730397217; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=S5yCjJSTtpBCKuL6oAxXQ3icP8CLu07VEDpomx/5oNM=;
 b=q1YdYguijVa/tz4BaVTx3JvKcOFtqP9sEVgZlgeB2WQGOzbrm5UX/NjRyMRoITFP2m
 +E5nlArTAzWgLKUnwm9KPRSsxcibfWB39z1VFI2Ss7mt6zIEP/KTfw+1K0M5vi64qnNR
 i6pJYcOFkOlpvVSNbMt0HwLlkxLI9mOOLEOl/d0ZdauoA4DKvE1NPyXPolrLF5Zau2yk
 sOG2LX6QM4qbhhBeUI1lotIg6PVdkzml8i7QivrljKzf711Wh712AqrsAx2zE0nXUGct
 eg+3SVPguxC/+qT856LqqO/+ItnLXto6s8LIM+sH0uR5gbbjG/N2gOWXUXSCoSuXaLNG
 eC3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729792417; x=1730397217;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=S5yCjJSTtpBCKuL6oAxXQ3icP8CLu07VEDpomx/5oNM=;
 b=rkgxHvhFzVWv8M3DwrHkXBTE91lSkE62CDdG9FBK+irDI/w7jPP/VVCkMuSe6lbAOq
 qUL3taEXq+GvJnEtz8Z2fQufFC4VQGPzUoARFm2CSnDMR/6FXO3TOxAlSOpZvW50rXiC
 MeOEO7FNy0LgJLrP0j4gq4Roxrahq9+AixuS0IVWZI6CpytQn3nEnq0kx4FhFIT37uWw
 G3sCHJFuMf8HzHJbI4erw2x4x77a08WDM466ig43j4GOpqZEu5Tafgrnah+F9rxoSliG
 8h7wZWK9mV4j3EFJO9Dif2zYHkuRJ3MwvimHhOR0t1wUgEgAoytSYonoSj64yESIPE1Q
 olvQ==
X-Gm-Message-State: AOJu0Ywma59nNzofkuuofRBmH0MESB+44uI832XDpVbzAiYz+BSIbQWy
 RVl4Qo14xl2rur2ugd32o3Jhs1Ko2qPBf3+bnCrtDgMTrqR2ASf0dSnFo4XVnfY=
X-Google-Smtp-Source: AGHT+IFSSFUz4+OFDZZ7eu/hNQp6TY3zb6SYaBY/1EPqB8Kx1YB527ztlep+/ftJZmM+JIc53BZTxg==
X-Received: by 2002:a05:6a21:2986:b0:1d9:20bb:4afe with SMTP id
 adf61e73a8af0-1d978bb45b5mr7278003637.50.1729792417045; 
 Thu, 24 Oct 2024 10:53:37 -0700 (PDT)
Received: from [192.168.100.49] ([45.176.88.171])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7eaeab638c5sm8939847a12.55.2024.10.24.10.53.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Oct 2024 10:53:36 -0700 (PDT)
Message-ID: <e52b231d-f23e-4772-bfb2-08ddcc3e7ad0@linaro.org>
Date: Thu, 24 Oct 2024 14:53:33 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v42 51/98] hw/sd/sdcard: Add spi_cmd_SEND_CSD/CID handlers
 (CMD9 & CMD10)
To: Guenter Roeck <linux@roeck-us.net>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 qemu-riscv <qemu-riscv@nongnu.org>
References: <20240628070216.92609-1-philmd@linaro.org>
 <20240628070216.92609-52-philmd@linaro.org>
 <94b2c5bf-53d0-4c74-8264-f3021916f38c@roeck-us.net>
 <7965f970-cdbd-4e3e-bc4c-62fb496a9e24@linaro.org>
 <a49719b7-e3fb-46ca-b884-cb7019a0b09f@roeck-us.net>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <a49719b7-e3fb-46ca-b884-cb7019a0b09f@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=philmd@linaro.org; helo=mail-pg1-x531.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi Guenter,

On 24/10/24 01:04, Guenter Roeck wrote:
> On 10/23/24 20:27, Philippe Mathieu-Daudé wrote:
>> Hi Guenter,
>>
>> On 23/10/24 19:24, Guenter Roeck wrote:
>>> Hi,
>>>
>>> On Fri, Jun 28, 2024 at 09:01:27AM +0200, Philippe Mathieu-Daudé wrote:
>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>> Reviewed-by: Cédric Le Goater <clg@redhat.com>
>>>> ---
>>>
>>> This patch results in:
>>>
>>> [    5.976133] Waiting for root device /dev/mmcblk0...
>>> [    6.501462] mmc0: error -38 whilst initialising SD card
>>> [    7.557473] mmc0: error -38 whilst initialising SD card
>>>
>>> ... (repeated until session is aborted)
>>>
>>> when trying to boot Linux for sifive_u from sd card.
>>> The command used to boot the image is
>>>
>>> qemu-system-riscv64 -M sifive_u -m 512M -no-reboot \
>>>      -kernel arch/riscv/boot/Image \
>>>      -snapshot -drive file=rootfs.ext2,format=raw,if=sd \
>>>      -bios default \
>>>      -append "root=/dev/mmcblk0 rootwait console=ttySIF0,115200 
>>> earlycon" \
>>>      -nographic -monitor none


>>> # first bad commit: [da954d0e32444f122a41c24948d4d1c718bf66d4] 
>>> hw/sd/sdcard: Add spi_cmd_SEND_CSD/CID handlers (CMD9 & CMD10)
>>
>> I don't have access to my workstation, but looking at the patch,
>> maybe the fix is simply:
>>
>> ---
>> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
>> index a5d2d929a8a..1594d340a6e 100644
>> --- a/hw/sd/sd.c
>> +++ b/hw/sd/sd.c
>> @@ -1567,7 +1567,7 @@ static sd_rsp_type_t 
>> emmc_cmd_SEND_EXT_CSD(SDState *sd, SDRequest req)
>>   /* CMD9 */
>>   static sd_rsp_type_t spi_cmd_SEND_CSD(SDState *sd, SDRequest req)
>>   {
>> -    if (sd->state != sd_standby_state) {
>> +    if (sd->state != sd_transfer_state) {
>>           return sd_invalid_state_for_cmd(sd, req);
>>       }
>>       return sd_cmd_to_sendingdata(sd, req, sd_req_get_address(sd, req),
>> @@ -1586,7 +1586,7 @@ static sd_rsp_type_t sd_cmd_SEND_CSD(SDState 
>> *sd, SDRequest req)
>>   /* CMD10 */
>>   static sd_rsp_type_t spi_cmd_SEND_CID(SDState *sd, SDRequest req)
>>   {
>> -    if (sd->state != sd_standby_state) {
>> +    if (sd->state != sd_transfer_state) {
>>           return sd_invalid_state_for_cmd(sd, req);
>>       }
>>       return sd_cmd_to_sendingdata(sd, req, sd_req_get_address(sd, req),
>> ---
>>
>> Is it possible for you to test this snippet?
>>
> 
> It must be related, but something else must be wrong. With the above, I get
> 
> [    4.355063] Run /sbin/init as init process
> ssi_sd: error: Unexpected response to cmd 13
> [    4.780139] mmc0: SPI card removed
> [    4.785194] EXT4-fs (mmcblk0): shut down requested (2)
> [    4.812689] Starting init: /sbin/init exists but couldn't execute it 
> (error -5)
> [    4.813248] Run /etc/init as init process
> [    4.825799] init: attempt to access beyond end of device
> 
> The state is always 4 when spi_cmd_SEND_CSD() and spi_cmd_SEND_CID()
> are called. With more debugging added:
> 
> ssi_sd: error: Unexpected response to cmd 13 (arglen expected 4, got 16)
> 
> Changing only one of the functions to check against sd_transfer_state
> doesn't help either; that brings back the repeated error -38.

Looking at commit 807f6adac37 ("hw/sd/sdcard: Add sd_cmd_SEND_STATUS
handler (CMD13)"), this should fix:

-- >8 --
@@ -1639,7 +1639,7 @@ static sd_rsp_type_t sd_cmd_SEND_STATUS(SDState 
*sd, SDRequest req)
      }

      if (sd_is_spi(sd)) {
-        return sd_r2_s;
+        return sd_r1;
      }

      return sd_req_rca_same(sd, req) ? sd_r1 : sd_r0;
---

But -- why the commit msg didn't mention the spec fix -- the commit
looks correct to me. We might be missing smth from the spec. I'll
have a look during soft freeze. Having a test such the one recently
added in 
https://lore.kernel.org/qemu-devel/20241024082735.42324-3-thuth@redhat.com/
would help me ;)

Regards,

Phil.


