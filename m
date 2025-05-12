Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6391C3ABC3
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 08:15:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEOJD-0006Pf-QY; Mon, 12 May 2025 04:14:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uEOJC-0006PE-Hi
 for qemu-devel@nongnu.org; Mon, 12 May 2025 04:14:46 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uEOJ9-0007Yg-Vj
 for qemu-devel@nongnu.org; Mon, 12 May 2025 04:14:46 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43cf3192f3bso44083415e9.1
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 01:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747037682; x=1747642482; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Mll3exlrXuuAdA7yJ27rstMprE+JfW+limRUrWGgwgs=;
 b=CoBNuwnHiKpt9v77eypE0bay2Bi62lxquY2ASnAkcsVuYkScomBkHQ5wZJvFFtaM0f
 4UxT1D3wKYgDFZYPXosjIUmYAGi+Ljm+5xetyr49FnEjmv+ChssPEJhdGSumiHia8PNj
 8IO9WkLDOL48w24Lfigxr19Wjem+EDqqQGFMEcQTLygRiD5m1weFRkvtjhr+dOdUtUOw
 ieqIzdQpEOD2fpU1JojeFlUTKwGN7S2Hlfkplv5jHhMrHMfbTAO+NIs10AEnDjzV6Uay
 gft1XFGTLNj55b0Cdg8aVRFrYJ8i10vVvv9SWGerVOpWbmkCQ3lZFDjsdsCk0l4JyANt
 HbxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747037682; x=1747642482;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Mll3exlrXuuAdA7yJ27rstMprE+JfW+limRUrWGgwgs=;
 b=pre9SrAf7/bcZV0waH4SZq1nwhC7y/LYGB7tnX1ByOXVB/Wo1w85yDHhBHZR7zKuvg
 AGXPd+IHBR1sODnXzsA9AB9zReItazj+JwTXwiwWnmOFNGDq2LliADPnxLOeZ4HNtT1R
 aEnFuWYQabtq7mcVXwEAYgN6uYfsPghT2mykfm3yoUhcHgkp2+eeV4b9xy55OoM3XO3/
 scUy+1sLZJ9ZSAQ59jCcgQrtLL6kWPgcthmNJeCRHghesUdJAqo1y5eECWWLseC7i4Fd
 bHWehDlzoVXVb3LZ+e2+Uw7gsIrKKsWV2f0q4ydIr8Bn1FUj9NNo4msP/+ASdAMR4uz/
 K0NQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQBHKk9y0ejL6agrxnWQiNsYUAxKmHLIySzGuAKe58JZKg04g2X+u/yHWr1xTGspeeubgTiSywJ+XN@nongnu.org
X-Gm-Message-State: AOJu0Yy9LjHnX81H3g9aNb3k67jt9s5yyCbFjk6Dq0pAD50l5yNO+pro
 6NkMuMoi197EhcNjnaoZKEM4BoB//t+kn41kITCrESxh8ZpMkQJ2QgXasR4f0v2Zo3W6bd+Jywy
 2iTih+Q==
X-Gm-Gg: ASbGnct3I5j/BxkrowYCrwOxZ0RnRQts9pXvNac7FdJ8kzarEcbXWHdjUwaxK6gs/Hl
 03vpZ3xI51yEHVV4HX3sGsoILNXGXs4flsGiu8TVCg/fol67BwlEhrQlcxx6UOWUT5n5Cygkwe+
 xeNwlZz/ZPVpRoruO/89Zb74i8UeG6lLbawYTg8DHMMMte3dD0hPAj12vLxekLN3qTv0ryAd2Zi
 YcJstK3bQnbYgZfYKSFN1owyKl5vXsiDt1BJg88pOtOOQ5k+7szHeUvUb9hoRnugg6hMxRvv9yx
 SSwy0g+foersHcWFlQsrEYbdrxkOX7mnvn3w6T5QZbg7py+WylFaXl6PJBXgAS4v3BTVsSyoYNb
 miqmP9ii5tw5jr89VyBEjoz0OYuLaQFftiVG0nxxxU8SUdQ==
X-Google-Smtp-Source: AGHT+IGwSeax9MK3+szqdQnNhXnJUfDr3088Irg2G41/NyvDV9chg+j2xSAon7PK0bMHDMv8PGqGgQ==
X-Received: by 2002:a05:600c:c0c3:20b0:442:e0e0:250 with SMTP id
 5b1f17b1804b1-442e0e003famr30777745e9.29.1747037681993; 
 Mon, 12 May 2025 01:14:41 -0700 (PDT)
Received: from [172.19.170.213] (54.red-95-127-42.staticip.rima-tde.net.
 [95.127.42.54]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442d67df639sm116711395e9.13.2025.05.12.01.14.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 May 2025 01:14:41 -0700 (PDT)
Message-ID: <b8f6eb5e-1a6b-4b53-aee3-f63276de6e0e@linaro.org>
Date: Mon, 12 May 2025 10:14:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/19] hw/net/e1000: Remove unused E1000_FLAG_MAC flag
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Fam Zheng <fam@euphon.net>, Hanna Reitz <hreitz@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, qemu-block@nongnu.org,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, John Snow <jsnow@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
References: <20250506143905.4961-1-philmd@linaro.org>
 <20250506143905.4961-7-philmd@linaro.org>
 <a47270aa-3de5-4474-80ea-bc2d126d6442@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <a47270aa-3de5-4474-80ea-bc2d126d6442@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 12/5/25 08:00, Thomas Huth wrote:
> On 06/05/2025 16.38, Philippe Mathieu-Daudé wrote:
>> E1000_FLAG_MAC was only used by the hw_compat_2_4[] array,
>> via the 'extra_mac_registers=off' property. We removed all
>> machines using that array, lets remove all the code around
>> E1000_FLAG_MAC, including the MAC_ACCESS_FLAG_NEEDED enum,
>> similarly to commit fa4ec9ffda7 ("e1000: remove old
>> compatibility code").
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
>> ---
>>   hw/net/e1000.c | 72 ++++++++++----------------------------------------
>>   1 file changed, 14 insertions(+), 58 deletions(-)
>>
>> diff --git a/hw/net/e1000.c b/hw/net/e1000.c
>> index cba4999e6d0..e0310aef872 100644
>> --- a/hw/net/e1000.c
>> +++ b/hw/net/e1000.c
>> @@ -127,10 +127,8 @@ struct E1000State_st {
>>       QEMUTimer *flush_queue_timer;
>>   /* Compatibility flags for migration to/from qemu 1.3.0 and older */
>> -#define E1000_FLAG_MAC_BIT 2
>>   #define E1000_FLAG_TSO_BIT 3
>>   #define E1000_FLAG_VET_BIT 4
>> -#define E1000_FLAG_MAC (1 << E1000_FLAG_MAC_BIT)
>>   #define E1000_FLAG_TSO (1 << E1000_FLAG_TSO_BIT)
>>   #define E1000_FLAG_VET (1 << E1000_FLAG_VET_BIT)
>> @@ -1210,54 +1208,24 @@ static const writeops macreg_writeops[] = {
>>   enum { NWRITEOPS = ARRAY_SIZE(macreg_writeops) };
>> -enum { MAC_ACCESS_PARTIAL = 1, MAC_ACCESS_FLAG_NEEDED = 2 };
>> +enum { MAC_ACCESS_PARTIAL = 1 };
>> -#define markflag(x)    ((E1000_FLAG_##x << 2) | MAC_ACCESS_FLAG_NEEDED)
>>   /* In the array below the meaning of the bits is: [f|f|f|f|f|f|n|p]
>>    * f - flag bits (up to 6 possible flags)
>>    * n - flag needed
>>    * p - partially implenented */
>>   static const uint8_t mac_reg_access[0x8000] = {
>> -    [IPAV]    = markflag(MAC),    [WUC]     = markflag(MAC),
>> -    [IP6AT]   = markflag(MAC),    [IP4AT]   = markflag(MAC),
>> -    [FFVT]    = markflag(MAC),    [WUPM]    = markflag(MAC),
>> -    [ECOL]    = markflag(MAC),    [MCC]     = markflag(MAC),
>> -    [DC]      = markflag(MAC),    [TNCRS]   = markflag(MAC),
>> -    [RLEC]    = markflag(MAC),    [XONRXC]  = markflag(MAC),
>> -    [XOFFTXC] = markflag(MAC),    [RFC]     = markflag(MAC),
>> -    [TSCTFC]  = markflag(MAC),    [MGTPRC]  = markflag(MAC),
>> -    [WUS]     = markflag(MAC),    [AIT]     = markflag(MAC),
>> -    [FFLT]    = markflag(MAC),    [FFMT]    = markflag(MAC),
>> -    [SCC]     = markflag(MAC),    [FCRUC]   = markflag(MAC),
>> -    [LATECOL] = markflag(MAC),    [COLC]    = markflag(MAC),
>> -    [SEQEC]   = markflag(MAC),    [CEXTERR] = markflag(MAC),
>> -    [XONTXC]  = markflag(MAC),    [XOFFRXC] = markflag(MAC),
>> -    [RJC]     = markflag(MAC),    [RNBC]    = markflag(MAC),
>> -    [MGTPDC]  = markflag(MAC),    [MGTPTC]  = markflag(MAC),
>> -    [RUC]     = markflag(MAC),    [ROC]     = markflag(MAC),
>> -    [GORCL]   = markflag(MAC),    [GORCH]   = markflag(MAC),
>> -    [GOTCL]   = markflag(MAC),    [GOTCH]   = markflag(MAC),
>> -    [BPRC]    = markflag(MAC),    [MPRC]    = markflag(MAC),
>> -    [TSCTC]   = markflag(MAC),    [PRC64]   = markflag(MAC),
>> -    [PRC127]  = markflag(MAC),    [PRC255]  = markflag(MAC),
>> -    [PRC511]  = markflag(MAC),    [PRC1023] = markflag(MAC),
>> -    [PRC1522] = markflag(MAC),    [PTC64]   = markflag(MAC),
>> -    [PTC127]  = markflag(MAC),    [PTC255]  = markflag(MAC),
>> -    [PTC511]  = markflag(MAC),    [PTC1023] = markflag(MAC),
>> -    [PTC1522] = markflag(MAC),    [MPTC]    = markflag(MAC),
>> -    [BPTC]    = markflag(MAC),
>> -
>> -    [TDFH]  = markflag(MAC) | MAC_ACCESS_PARTIAL,
>> -    [TDFT]  = markflag(MAC) | MAC_ACCESS_PARTIAL,
>> -    [TDFHS] = markflag(MAC) | MAC_ACCESS_PARTIAL,
>> -    [TDFTS] = markflag(MAC) | MAC_ACCESS_PARTIAL,
>> -    [TDFPC] = markflag(MAC) | MAC_ACCESS_PARTIAL,
>> -    [RDFH]  = markflag(MAC) | MAC_ACCESS_PARTIAL,
>> -    [RDFT]  = markflag(MAC) | MAC_ACCESS_PARTIAL,
>> -    [RDFHS] = markflag(MAC) | MAC_ACCESS_PARTIAL,
>> -    [RDFTS] = markflag(MAC) | MAC_ACCESS_PARTIAL,
>> -    [RDFPC] = markflag(MAC) | MAC_ACCESS_PARTIAL,
>> -    [PBM]   = markflag(MAC) | MAC_ACCESS_PARTIAL,
>> +    [TDFH]  = MAC_ACCESS_PARTIAL,
>> +    [TDFT]  = MAC_ACCESS_PARTIAL,
>> +    [TDFHS] = MAC_ACCESS_PARTIAL,
>> +    [TDFTS] = MAC_ACCESS_PARTIAL,
>> +    [TDFPC] = MAC_ACCESS_PARTIAL,
>> +    [RDFH]  = MAC_ACCESS_PARTIAL,
>> +    [RDFT]  = MAC_ACCESS_PARTIAL,
>> +    [RDFHS] = MAC_ACCESS_PARTIAL,
>> +    [RDFTS] = MAC_ACCESS_PARTIAL,
>> +    [RDFPC] = MAC_ACCESS_PARTIAL,
>> +    [PBM]   = MAC_ACCESS_PARTIAL,
>>   };
>>   static void
>> @@ -1268,8 +1236,7 @@ e1000_mmio_write(void *opaque, hwaddr addr, 
>> uint64_t val,
>>       unsigned int index = (addr & 0x1ffff) >> 2;
>>       if (index < NWRITEOPS && macreg_writeops[index]) {
>> -        if (!(mac_reg_access[index] & MAC_ACCESS_FLAG_NEEDED)
>> -            || (s->compat_flags & (mac_reg_access[index] >> 2))) {
>> +        if (s->compat_flags & (mac_reg_access[index] >> 2)) {
>>               if (mac_reg_access[index] & MAC_ACCESS_PARTIAL) {
>>                   DBGOUT(GENERAL, "Writing to register at offset: 
>> 0x%08x. "
>>                          "It is not fully implemented.\n", index<<2);
>> @@ -1295,8 +1262,7 @@ e1000_mmio_read(void *opaque, hwaddr addr, 
>> unsigned size)
>>       unsigned int index = (addr & 0x1ffff) >> 2;
>>       if (index < NREADOPS && macreg_readops[index]) {
>> -        if (!(mac_reg_access[index] & MAC_ACCESS_FLAG_NEEDED)
>> -            || (s->compat_flags & (mac_reg_access[index] >> 2))) {
>> +        if (s->compat_flags & (mac_reg_access[index] >> 2)) {
>>               if (mac_reg_access[index] & MAC_ACCESS_PARTIAL) {
>>                   DBGOUT(GENERAL, "Reading register at offset: 0x%08x. "
>>                          "It is not fully implemented.\n", index<<2);
> 
> There still seems to be something wrong in this patch, tests/qtest/pxe- 
> test is failing when this is applied ... could you please have another 
> look?

Fixed by not removing MAC_ACCESS_FLAG_NEEDED, thanks.

