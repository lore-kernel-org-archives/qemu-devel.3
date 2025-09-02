Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A879CCA0FFE
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 15:08:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utSah-0005nQ-0z; Tue, 02 Sep 2025 11:06:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utSac-0005lg-M1
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 11:06:31 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utSaY-0008AA-VE
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 11:06:30 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-45b7e69570bso28370715e9.0
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 08:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756825581; x=1757430381; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZEGO139SeqDxUI/SQqsVpNZ7wS1+CNUNhT7jQXyiEA8=;
 b=EliLG+igVdHnlre29wOep/CMzAlJx3jdzmKWwnDrvjrZ3Iz9+wLN9uVud44RPq+mAT
 H+A/HIKaUPoKCkulTUmdQVbu3AUZnmbrfrC+aljohV2nBr3tMRuEzHXnXE7XluTnuQB3
 ZmLrsRW0rMU8/ozLzV9T3DbAhccNlAwNztMdn4vZdzzVfrpUAk7b1Czx8RwfZRCJUwlZ
 Hx1Pa2/WCfYHAYuxJelNUYaOf5UpaNx3SUqhMwNYOufmts3rf+jmLDQm1mS7LuYzWBnK
 oReN8EekCYj2cCJKJl105EzleDzvJP016ZOdbDIPUFh3rjB3fMEF2j9zabrTTIPPZDwl
 6ULQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756825581; x=1757430381;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZEGO139SeqDxUI/SQqsVpNZ7wS1+CNUNhT7jQXyiEA8=;
 b=cJPuTHnYp2bjyC5f/2m5Xy1QCWqAJ4pubVs7nRNB8XfCdfFhTQZ2/aGvBcT3AwqZrL
 qIFSF7C28Vw/nC85WL8lj7bTQujMu6DiWhXrVsBcNxq+koQYh0q3VxL3FtOA6aFokKg1
 wPuOr+xIN6Vn0Pp7eU1yrqBCEZZR47V+MIRwwjw93zRstLREvljsFkpwyz4TXW7CiOii
 9Q2HRZ3b8+7CxYcCqTEJFM79pqGSzPOfy8JtbAt5sRbLOIg3jnfaQJurF1qdex99Lyq0
 bIwE36HWCRem20P7QqxwznXVNbX7J9vQBH2/paoGNZyzqBQlYZVz0tzF0tUW8fYQpKX5
 qjCA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMBrlwGYvbaS54RQg3POe482fK1LhAYZohDyc7GatgltxPBNfPGNsiR1SnxvOSOBwLLqUEJNFZQTPs@nongnu.org
X-Gm-Message-State: AOJu0YwNoMUNcLC2a5fuPygKVS6tTZ3DTVF2r+HABkctFhh6NUdVUb9c
 b07RqoljCSaLvtcuLPqMmDtAk3VUOSjwgJSgdfq+fv1C/5/PWNIJQYgUZrWXhH60X8U=
X-Gm-Gg: ASbGncuPUoyM7eFT0G1oWtuRVZ/cxIKWDL3Jath3d9B/zAbdj3ipLfIFnh9BhS9mtje
 PoI+dtjBxajpNn2u2Nc6p0JbFHzP7xSL8lpQhghiygN7TZpId1TNCV2Vfg6ttRqKTISR0GtaMwB
 5ChJLOUpdpivugrMkmCZGb8Kq/M1DP/086OC+ScgvEk1lre1BIrqU0zqWx2X3Qrumx8kO+/xkrg
 UofpzSRsxeGlJ1zItuybBFgSkzXbWc3DK7A0f2KzclbLzeL7CX9krLmjwW6MY1/k+M4HJIlqP0v
 AAQtouZGroaaekEwiFfntByAT/LSikGiSQXNwG7MLTE2qojLa5x03wnlnX69GVOZDwY90zSxxHJ
 UbvTEWlnqaRMCubircb4GqaPaI/9wmxu3NresMuFOq6M/Ng3OBAFAyVWi4Bszb2y1ig==
X-Google-Smtp-Source: AGHT+IF10ro3TGgEArpDgxiZs0Eqj3adox0tKbIlEUiJ0UdUIAUl6iMe3HcGU8/gvgQsDph+PdecLA==
X-Received: by 2002:a05:600c:5248:b0:456:1a69:94fd with SMTP id
 5b1f17b1804b1-45b8549c438mr101209995e9.0.1756825580900; 
 Tue, 02 Sep 2025 08:06:20 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3cf33fb9d37sm20272216f8f.49.2025.09.02.08.06.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Sep 2025 08:06:20 -0700 (PDT)
Message-ID: <6289fe04-82be-4a34-9fed-b0cc08e3b8f0@linaro.org>
Date: Tue, 2 Sep 2025 17:06:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/8] hw/sd/sdcard: Fix size check for backing block
 image
To: Jan Kiszka <jan.kiszka@siemens.com>, qemu-devel <qemu-devel@nongnu.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 qemu-arm <qemu-arm@nongnu.org>
References: <cover.1756706188.git.jan.kiszka@siemens.com>
 <86217712232abd5152e7dfa98111f57b9b78d83b.1756706188.git.jan.kiszka@siemens.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <86217712232abd5152e7dfa98111f57b9b78d83b.1756706188.git.jan.kiszka@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 1/9/25 07:56, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> The power-of-2 rule applies to the user data area, not the complete
> block image. The latter can be concatenation of boot partition images
> and the user data.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/sd/sd.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index 8c290595f0..16aee210b4 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -2789,7 +2789,7 @@ static void sd_realize(DeviceState *dev, Error **errp)
>               return;
>           }
>   
> -        blk_size = blk_getlength(sd->blk);
> +        blk_size = blk_getlength(sd->blk) - sd->boot_part_size * 2;
>           if (blk_size > 0 && !is_power_of_2(blk_size)) {
>               int64_t blk_size_aligned = pow2ceil(blk_size);
>               char *blk_size_str;

This seems to break the tests/functional/arm/test_aspeed_rainier.py
test due to mmc-p10bmc-20240617.qcow2 size:

Command: /builds/qemu-project/qemu/build/qemu-system-arm -display none 
-vga none -chardev socket,id=mon,fd=5 -mon chardev=mon,mode=control 
-machine rainier-bmc -chardev socket,id=console,fd=10 -serial 
chardev:console -drive 
file=/builds/qemu-project/qemu/functional-cache/download/d523fb478d2b84d5adc5658d08502bc64b1486955683814f89c6137518acd90b,if=sd,id=sd2,index=2 
-net nic -net user -snapshot
Output: qemu-system-arm: Invalid SD card size: 16 GiB
SD card size has to be a power of 2, e.g. 16 GiB.

https://gitlab.com/qemu-project/qemu/-/jobs/11217561316


