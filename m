Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 379DFC369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 21:02:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7hEf-00077K-9e; Wed, 23 Apr 2025 17:02:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7hEd-00076T-6k
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 17:02:23 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7hEb-0005aZ-H5
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 17:02:22 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2295d78b433so3252585ad.2
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 14:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745442139; x=1746046939; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=U+rfqX26zcDFA6/KX9P6XT0eCbgwi0Ty7MFIiDORJ/o=;
 b=KxfuOK80VCIHt8k0c52euFa4V1tNsKKklawczrhpxJtuZZx16y6D716ScAlK+TOIA3
 DT5D2iCgDZWi0aH8BxtKjoYshl5LXjjlcwHCyYcI99INsMxN5kFJ3lbx9vRhoqM28Bqx
 BUzwpzmXnW+YABz+oIWUMcTrApdIObkEL5U7ZJMq7b27OOh6BgGWH3TBTL+PPZ9//W6/
 BWPsev5zialDUDf9IrtO/7d6q+Mg6P7WWwnYUg62Rgxq99iLoYFl9cWDchz6ejCxLbKv
 /EOxFI2/2thlcAITwSA7tkED6QD9NRyrCWC6Cj4O6qSIBpMW0pW4xLvRzg+n23Ccf6sD
 uRWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745442139; x=1746046939;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=U+rfqX26zcDFA6/KX9P6XT0eCbgwi0Ty7MFIiDORJ/o=;
 b=IyA0d+OMVRkp5/OgAKuFmmxsMeMiC/nLpz+PUvp7876ZWAUx69eJoZbd5TgUnK9syD
 tBRNtEds042SUgkMA9//CjtzleHiqLnSGGhZSb3a3++z7IwAz8mUqHElzPTo721pvxhe
 SbUvipNX2Q3nIi1LZy4UZWAMH3jE/BwEdJtL687J+2kfyngmVS9EuO39UWJuZUCpHhn/
 i/hMkheHgT0saw9HK5Oo3ZspCxd6mbHiAoW5pCRD2uaHfYHW74WP86LEBVk97qNMsYyA
 Zd5HA4hJtEG8CrJsshYTOo0P01Y2S2nMBNW0N1PN4ll0wAOgy+HxotjljmXQbHl9ILaj
 7oNw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjbd0Oun9HmyUVozg4mAZTbGgIzLm2q+cWEX49GDu7Q/oBDwCtGtRxt8O7CdJ0llEC4tKOce67ooh3@nongnu.org
X-Gm-Message-State: AOJu0YxLDOiErMecBGGFFQ8yMEp7YzHkSdxmd+iWCLnBFuctJrFJwOUW
 ZR4p9G5Vn6zA/vAOZKoyDSX0k4k1b37sVy888R6kj2yMAJ0b/Tv6RGLHC4eDj/o=
X-Gm-Gg: ASbGncsFUQOCMSRoa3etfGUdbur4LI97ws7q7DeJWGYUC80IV3wc1YdS4jB+Im0jQh3
 YNsM+lcKC05rn+phV4L15jwRjX6LZqs3oQH3sL9BgtTu1IazsgIOyzmo0ro9yMpEbamkDp24oTD
 ulXlVK92hfMlMXwwSehLn5lmwEONzqwsby6HM1tx6q/sM20fol6jfSIuIy52GOr87i3OHcEBYtP
 b0K4qwEJb1giEXlPOPhcwtl+tJ0no1zVxACes3O1pR4HLxHAouueA21otkMoUUSadiwmhUKkWoX
 77Bs0gLSTlzZtWhj6rDct+6B+zT9NtOgheYDAQBpI90vff2oTBgw+HphwkdmoP7ZJGXdyZ+k3Mt
 uRoQC4O1zX4fRU0gSAA==
X-Google-Smtp-Source: AGHT+IG1HEqtgbxAChtVPTuocI9tjFuJDD7xGP1xAsuGcYY7Kxtff7HxdWp/DmnapnMU4QNzD3LPRg==
X-Received: by 2002:a17:903:1b66:b0:216:6901:d588 with SMTP id
 d9443c01a7336-22db3bde914mr192125ad.15.1745442139630; 
 Wed, 23 Apr 2025 14:02:19 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50ed0eaasm109240675ad.177.2025.04.23.14.02.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Apr 2025 14:02:19 -0700 (PDT)
Message-ID: <c53f3082-b1dd-4bef-a66d-eb61f61c9285@linaro.org>
Date: Wed, 23 Apr 2025 14:02:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 020/147] accel/tcg: Build plugin-gen.c once
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
 <20250422192819.302784-21-richard.henderson@linaro.org>
 <08aa6eac-7b43-4916-993a-b7b9555c967e@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <08aa6eac-7b43-4916-993a-b7b9555c967e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

On 4/23/25 02:26, Philippe Mathieu-Daudé wrote:
>> diff --git a/accel/tcg/meson.build b/accel/tcg/meson.build
>> index 14bf797fda..185830d0f5 100644
>> --- a/accel/tcg/meson.build
>> +++ b/accel/tcg/meson.build
>> @@ -3,6 +3,10 @@ common_ss.add(when: 'CONFIG_TCG', if_true: files(
>>     'tcg-runtime.c',
>>     'tcg-runtime-gvec.c',
>>   ))
>> +if get_option('plugins')
>> +  common_ss.add(when: 'CONFIG_TCG', if_true: files('plugin-gen.c'))
> 
> So far plugins imply TCG; is this in preparation of supporting plugins
> with other accelerators?

No, all items in accel/tcg/meson.build are tagged CONFIG_TCG.


r~

