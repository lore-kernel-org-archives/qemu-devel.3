Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA9D2C531DC
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2024 06:21:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1shNfT-00025i-J3; Fri, 23 Aug 2024 02:21:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1shNfP-0001ol-Az
 for qemu-devel@nongnu.org; Fri, 23 Aug 2024 02:20:59 -0400
Received: from mail-qk1-x734.google.com ([2607:f8b0:4864:20::734])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1shNfN-0004MB-8R
 for qemu-devel@nongnu.org; Fri, 23 Aug 2024 02:20:59 -0400
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-7a1da7cafccso93590185a.3
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2024 23:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724394055; x=1724998855; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lHhF/F/swQaONpwD+nKZPTJF1ZZpGwL3r/Flj4EEU9E=;
 b=Zzbj0jHfnx9v4v04dhauXw6NK5fq7T7dDD9/VYV38vmFFWEEycpjl38d4qKzGr0/FN
 bFmnesXfk+HxFZ5BwES+/HAPcX9UjwBpRSuFtcadm+6M8SegTZNSWCzdeg08OMBemJIt
 fWgnwxbJP+exKPTtewrKcF8X8y/GpoTmljFBL2mzB0/h2pFP5CrZEoF6oBQmI53S0Na/
 7T3zR3Y4I1rh3DTw3tmJtMSipE7dMjYlfmSVdI4edgzo0ILG8C+lJGVhZkXSENubculz
 S+pfesfIsjEZ8xJ5wWm48eJRI5OP8BFYo9/04rUHhaqut6IR0N38IWvl9M+Iebbgd8od
 Mieg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724394055; x=1724998855;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lHhF/F/swQaONpwD+nKZPTJF1ZZpGwL3r/Flj4EEU9E=;
 b=RaiqlKIIFfNQhXN09jVXmuP7W1iPBFRg3tMRL8014IhAlrbv9xub6ZQqsy6/EQkQH+
 K+IVXx4l1Sbc+ztKdaiQwuRCdodHhmcILmU1zKTR2CzewRbmjlQN6mClirCyIRAHF0tM
 SX/rzdz4OtEBT1E3E3KdK0+c5WiDdSrO1Cn8Tjgz17dgjHNAXdjLNOcXRmRub1eCZ360
 KzHiDcnvr3exIOoDGyxxpsgbfoFobFMf1mMsAvno78F0oPzpnedm+qAWCXGVcizxsggQ
 XfCt/ifWWbLfAtphjtm3tJT8Naxy3FEbCN+JNeshGdCo04avyLcpTneDTg+MhKNbSneL
 5tOg==
X-Forwarded-Encrypted: i=1;
 AJvYcCURegmcuJf2o3EPlV7MLGcpaqKjR+MGE8cXaKjdaNxSXP89LXwLSdETIL+hBvw/gvDRB1h5Tv2zt8mW@nongnu.org
X-Gm-Message-State: AOJu0YyIgaLyUXMmNCnem/8OImWMgVMw46+1UjhX0WeRQu/RBuWRZUqq
 zRirJrcIHk0auVBCczwbICnDl9Z+J/wx6glamnDO1SwQQ16MEisZDT4Ej5zwkJQ=
X-Google-Smtp-Source: AGHT+IEPuJ8UiFbl5RUJgZ2zOCHnyMuIRvioNWh+4HWnn2QD0L/GeYWDRT4w0h/8yMXLq8Ip94lYaA==
X-Received: by 2002:a05:620a:170b:b0:7a1:df6f:4374 with SMTP id
 af79cd13be357-7a689700b3fmr125664085a.16.1724394055249; 
 Thu, 22 Aug 2024 23:20:55 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.206.153])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a67f3fc6b9sm145482785a.115.2024.08.22.23.20.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Aug 2024 23:20:54 -0700 (PDT)
Message-ID: <60ae5753-548f-429d-89b5-f9f3721741f3@linaro.org>
Date: Fri, 23 Aug 2024 08:20:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tests/functional: Convert Aarch64 SBSA-Ref avocado
 tests
To: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Radoslaw Biernacki <rad@semihalf.com>,
 qemu-arm@nongnu.org, Leif Lindholm <quic_llindhol@quicinc.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20240822114146.86838-1-philmd@linaro.org>
 <17ba91fd-b876-4169-8b72-3fddf966e1a3@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <17ba91fd-b876-4169-8b72-3fddf966e1a3@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::734;
 envelope-from=philmd@linaro.org; helo=mail-qk1-x734.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 22/8/24 20:48, Marcin Juszkiewicz wrote:
> On 22.08.2024 13:41, Philippe Mathieu-Daudé wrote:
>> Straight forward conversion. Since SBSA_FLASH files are not
>> tarballs, use lzma_uncompress() method.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>> Based-on: <20240821082748.65853-1-thuth@redhat.com>
>> ---
> 
>> diff --git a/tests/avocado/machine_aarch64_sbsaref.py 
>> b/tests/functional/test_aarch64_sbsaref.py
>> old mode 100644
>> new mode 100755
>> similarity index 56%
>> rename from tests/avocado/machine_aarch64_sbsaref.py
>> rename to tests/functional/test_aarch64_sbsaref.py
>> index f8bf40c192..6728e5f92a
>> --- a/tests/avocado/machine_aarch64_sbsaref.py
>> +++ b/tests/functional/test_aarch64_sbsaref.py
> 
>> @@ -44,47 +55,31 @@ def fetch_firmware(self):
>>           """
>>           # Secure BootRom (TF-A code)
>> -        fs0_xz_url = (
>> -            
>> "https://artifacts.codelinaro.org/artifactory/linaro-419-sbsa-ref/"
>> -            "20240619-148232/edk2/SBSA_FLASH0.fd.xz"
>> -        )
>> -        fs0_xz_hash = 
>> "0c954842a590988f526984de22e21ae0ab9cb351a0c99a8a58e928f0c7359cf7"
>> -        tar_xz_path = self.fetch_asset(fs0_xz_url, 
>> asset_hash=fs0_xz_hash,
>> -                                      algorithm='sha256')
>> -        archive.extract(tar_xz_path, self.workdir)
>> +        fs0_xz_path = self.ASSET_FLASH0.fetch()
>>           fs0_path = os.path.join(self.workdir, "SBSA_FLASH0.fd")
>> +        lzma_uncompress(fs0_xz_path, fs0_path)
>>           # Non-secure rom (UEFI and EFI variables)
>> -        fs1_xz_url = (
>> -            
>> "https://artifacts.codelinaro.org/artifactory/linaro-419-sbsa-ref/"
>> -            "20240619-148232/edk2/SBSA_FLASH1.fd.xz"
>> -        )
>> -        fs1_xz_hash = 
>> "c6ec39374c4d79bb9e9cdeeb6db44732d90bb4a334cec92002b3f4b9cac4b5ee"
>> -        tar_xz_path = self.fetch_asset(fs1_xz_url, 
>> asset_hash=fs1_xz_hash,
>> -                                      algorithm='sha256')
>> -        archive.extract(tar_xz_path, self.workdir)
>> +        fs1_xz_path = self.ASSET_FLASH0.fetch()
> 
> Here you want ASSET_FLASH1 not ASSET_FLASH0. That's why it timed out - 
> system was hanging on exit from TF-A to EDK2.

Oops... Thanks you for debugging / noticing this!

> 
>>           fs1_path = os.path.join(self.workdir, "SBSA_FLASH1.fd")
>> +        lzma_uncompress(fs1_xz_path, fs1_path)
> 


