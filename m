Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3016DCA1005
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 10:28:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utOEX-0004I4-F4; Tue, 02 Sep 2025 06:27:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utOEV-0004Ha-Ue
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 06:27:23 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utOET-0000WC-Qd
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 06:27:23 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3dae49b117bso360878f8f.1
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 03:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756808840; x=1757413640; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cVUdYGKa24cj4nvdAy9vOSS1mh1984JyzO3vmKT9xug=;
 b=Kr4LBDXkekH0XqygISX9fUYjN4V7CeHaEzrOPN6qQ6A7zbWWpaS2osToLhUiEPSj5B
 3ss3UoDy0L25sCtWCM39fuc6/SMTgzHKal0rvGC9v97mFMyTpke2O/iLcF6i11RXGzQ9
 sUx6WIehcSHVTV6Jp8px+6evK3yoH4wKsqKyaj9SF59X/unQ2YU3rytUA5r282VPe5QF
 v02htBgOYDdOLpvnNwJsh4iV9ojqtGAWFhoCOsVNLXlmoZD2ZCcZlAFNHYTGW60Y7EjO
 c5xD3fvKaHbMdQ+Tu30z51Do/b3zSrPi6wfgkdCj4QiyesKiC7ZSLl3U6SqxJ7FD6Z45
 /AGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756808840; x=1757413640;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cVUdYGKa24cj4nvdAy9vOSS1mh1984JyzO3vmKT9xug=;
 b=BXjx0Lmd79NGvcHeFTpX6/Y76Slb/xdYgEmBaCvs+uzLK+LjsVApt6S+4cgFcj5a42
 Y1KqZ8qwRIt25lt4S+PmXYXSCztaGxowSpwJo3LUeKdJYgAni8JhD7ViAN2EFKmL7qJy
 wvf0sxcwRW5ktWA4LeYLw6qqtjWgDcRjJA7bBQRH+6uhw3RKgTU/j4po09O81DqwGHIj
 2PoCO2d0m2wo70IKW64JIhaHnTG8MM1ysmIJVeRYmAr+dSz46rZuxLjFC6CVWlorqQ3H
 nCDhr6pmldb1L9tJaIlq8JNogYml3rW5ThEaHfV8P0/YJLdH5bTo6odpTjXbS1QVe2bB
 KKFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCNS6K1VeTUTOPtFipMKQtJdrcpelryaGnKJK0xx/Vn/n1Jp7OY/NNLmHbovMAQoLUK4bz3HjjJsf4@nongnu.org
X-Gm-Message-State: AOJu0Yxel8W9fYWM6xjVvVRJPuDf2XHJ0EXCXKmVBSdKVJ5OaVAo4ZtW
 YG45S1GEcTZrCqQjCOLxhl9OTsJgBygNhMvtMt+tTcjXFgGSUULEZTcKZD4gobfY7p0=
X-Gm-Gg: ASbGncvDPskO9SCSIx6ODLREkmPINfrxj3amI7DyqZCmSaBdu9dwlxCV4sBJSaQsTDT
 jRrXPZopygls8vKQSGSD8zVFmZpBn+xqRjaJ5mabM/8GhjyglumdL5PEIkqyr75JPSAkj09YiHl
 47JRJbidOKsOPuY66bCDPbxoIrcl2aXoAEexVsdXlU1cZJcgktJOIaa1ZlIwumOnxzElalXgkQ4
 NghYpAbuMHGZKi4pRFMIWrqaZl1FVVaLcM4aun+JnR1+f1nTPvEgUTVdANX5HW9nKWvAeDJmJuz
 3KYKMa4idRbcnvMZsOrc5pYWB12tB7yhxWNKL59+xfuyQpsY19gILQvMACADumhg8V/U/kN8ENS
 TK5rrtm9+uB9dWuyjUenxw9Q6aMFUG+M8HfcspTjIAHyvbO7DEQlG1h5UoH8qwUSPNcfoIMYS7q
 7h
X-Google-Smtp-Source: AGHT+IHvINrOSXihdYhatG+OlhpVk1dynq2dd671bqi4jXYVESKVwjOJSVtggtl04yYkvzm7YODPcA==
X-Received: by 2002:a05:6000:1a8c:b0:3c9:24f5:4711 with SMTP id
 ffacd0b85a97d-3d1def66f6dmr8500780f8f.43.1756808839622; 
 Tue, 02 Sep 2025 03:27:19 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b7e7efb79sm193566515e9.9.2025.09.02.03.27.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Sep 2025 03:27:19 -0700 (PDT)
Message-ID: <08162174-9a37-4a72-883d-b3a610de7f68@linaro.org>
Date: Tue, 2 Sep 2025 12:27:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/arm/boot: Correctly free the MemoryDeviceInfoList
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
References: <20250901102214.3748011-1-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250901102214.3748011-1-peter.maydell@linaro.org>
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

On 1/9/25 12:22, Peter Maydell wrote:
> When running the bios-tables-test under ASAN we see leaks like this:
> 
> Direct leak of 16 byte(s) in 1 object(s) allocated from:
>      #0 0x5bc58579b00d in calloc (/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/qemu-system-aarch64+0x250400d) (BuildId: 2e27b63dc9ac45f522ced40a17c2a60cc32f1d38)
>      #1 0x7b4ad90337b1 in g_malloc0 (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x637b1) (BuildId: 1eb6131419edb83b2178b682829a6913cf682d75)
>      #2 0x5bc5861826db in qmp_memory_device_list /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../hw/mem/memory-device.c:307:34
>      #3 0x5bc587a9edb6 in arm_load_dtb /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../hw/arm/boot.c:656:15
> 
> Indirect leak of 28 byte(s) in 2 object(s) allocated from:
>      #0 0x5bc58579ae23 in malloc (/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/qemu-system-aarch64+0x2503e23) (BuildId: 2e27b63dc9ac45f522ced40a17c2a60cc32f1d38)
>      #1 0x7b4ad6c8f947 in __vasprintf_internal libio/vasprintf.c:116:16
>      #2 0x7b4ad9080a52 in g_vasprintf (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0xb0a52) (BuildId: 1eb6131419edb83b2178b682829a6913cf682d75)
>      #3 0x7b4ad90515e4 in g_strdup_vprintf (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x815e4) (BuildId: 1eb6131419edb83b2178b682829a6913cf682d75)
>      #4 0x7b4ad9051940 in g_strdup_printf (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x81940) (BuildId: 1eb6131419edb83b2178b682829a6913cf682d75)
>      #5 0x5bc5885eb739 in object_get_canonical_path /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../qom/object.c:2123:19
>      #6 0x5bc58618dca8 in pc_dimm_md_fill_device_info /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../hw/mem/pc-dimm.c:268:18
>      #7 0x5bc586182792 in qmp_memory_device_list /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../hw/mem/memory-device.c:310:9
> 
> This happens because we declared the MemoryDeviceInfoList *md_list
> with g_autofree, which will free the direct memory with g_free() but
> doesn't free all the other data structures referenced by it.  Instead
> what we want is to declare the pointer with g_autoptr(), which will
> automatically call the qapi_free_MemoryDeviceInfoList() cleanup
> function when the variable goes out of scope.
> 
> Fixes: 36bc78aca83cfd ("hw/arm: add static NVDIMMs in device tree")
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/arm/boot.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

And queued, thanks!

