Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EA04C5DF94
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 23:12:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxYOl-0002gH-2x; Fri, 21 Aug 2026 19:11:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wxYOk-0002g1-Ai
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 19:11:42 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wxYOi-0004vY-OU
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 19:11:42 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-ca97d139d5fso1387248a12.0
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 16:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787353899; x=1787958699; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=T26CDWfmqq4Q7TILhhMDl7DvT2hnD6KCeMd1SqYDqH4=;
 b=ph7sIlyG7O1A8dKvW7yjjM5gMhEB3IsixsfsvptoDDDVoRIk3w0XzTMzeEkhvXdiyu
 Ri8PHooabOyU2XQwG0EL+IKtk4BQiufsjsC6vOG9jjDQ7ZuJrL1IMsxHLTSNezwaNdl5
 bhP+0ijckYbU6epXYQ5CIoIPjjVT7akbL7Nc4rixia4JRmwtDVfMEsxpHJkLklY+GR7+
 x8NMCxzTr+WtACxrTSDLgJd9mvICRTb4e8JtCeg941SpbhnhmUYERQo4gjhyMfG2j86U
 dJKslNZJVU1TJcoWij39wTpeTcJ9tN9m+VGClauU0vBV5iywnQgexspVoT0sK4srYxa+
 gpug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787353899; x=1787958699;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=T26CDWfmqq4Q7TILhhMDl7DvT2hnD6KCeMd1SqYDqH4=;
 b=UNV5alxUouDl/tvmWsxiBMlyFtmkwwf5wKNcf2h++3Yb44xsKHs+qmY6gfsYH2ZHXT
 JZSVhFEk5QuCzU/3Jm3V3y/U1bOHu4Wz8KrePkckgYkKdjYNtGS45xAp6EO7FCy38N1R
 NhKW9r+f2hkjquZZ8okjf09/KikydPAfEnK7xKmE4IdAylhOTRRBvHCdrUTrPkKIwPYA
 mA3gLZqiCeL/RaJgYKG1FvHSYhJyU7MBV/RcwcOJBQzICgZh4b5J9aBPU/LNu7RNUJiG
 nEggTS7tcNynojsoHa+WhEwcLCJ8EME+9lrzn0jQywrUPbYZmQugB+Q51NcnTF56kFu9
 Z2Wg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrsLGjLqS8MeWwWwt7gK+DA9M9mHPB57+NxTyZ/V/m7rb/UWq42kjpgfaScl4mFrZSF2f4D4IGKpvWH@nongnu.org
X-Gm-Message-State: AFuF++mb5bTU2BQhxIbjpbpquKhBWmqWTGKasWmmO+88nfo3r9ENKZ1x
 6UpDbBRydFTRq/jdO5C6S9NYWXuH3/UxsuOeInOABwypeAvFxxcDsqRAsN0F0KzVHOU=
X-Gm-Gg: AR+sD12To4yoe67ToNxwMNA06WEUo3SJfZUJ2XzR9iHmU+qaToUbJqqH/ITtXNDiReM
 r37t9w6C9ApQTJJzt6jDWMZN/1s7Ni/50qSO9b8sNl6G0c/kxRlyygG0aeoWvjQnA7mQ70z66ff
 HId4bxynb1j5qMPuOkA6Ubs1Yk7kz9KSTmXT0f/YETLJ7ojGtEIA/ld8EqAA6qx0QD4W3vWyeRX
 +k4Mhy8dhYQT9OEpgDfbNL7BJOkCcQJoP/UkWb3F568t6wH83an7FaxLvA93kU4pc+GkcVbPY9G
 sAewhdB8WrK/F01i21VxV+0yg8C6X5CzVpGvK1j63wzk8fyVVG/t88pU91gpm5mwPtyLyiCqkVH
 oOi0GpHr+oW5ErbtN8SB+hrE5jFpDPOCRoLWIAMflB/DTw7AsrmTEPyRyGiO2uHUmENuA7SSfZN
 77kmjbIHHShPeUiczp2BVNFMTdYrHwkLwQkhYo/G5qArjRWZXke3QBxRqarJHw4WsP+d00Z2Jd5
 btHfgj9XKRFHAFSWrAI4WKfhHKfC5/m9wlM8Jzcyjs8Id+j5A==
X-Received: by 2002:a05:6a20:394a:b0:3c3:791e:5e18 with SMTP id
 adf61e73a8af0-3cd2fe7a34cmr17385811637.7.1787353898875; 
 Fri, 21 Aug 2026 16:11:38 -0700 (PDT)
Received: from ?IPV6:2607:fb90:339b:bfd7:dac5:d94a:debc:5ef7?
 ([2607:fb90:339b:bfd7:dac5:d94a:debc:5ef7])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc1593060e8sm3357847a12.32.2026.08.21.16.11.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Aug 2026 16:11:38 -0700 (PDT)
Message-ID: <ef89a1f0-1df1-4d41-b0a9-603556a76b33@linaro.org>
Date: Fri, 21 Aug 2026 16:11:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/12] Igvm 20260821 patches
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Xu <peterx@redhat.com>, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Laurent Vivier <lvivier@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20260821161103.3489298-1-kraxel@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260821161103.3489298-1-kraxel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x534.google.com
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

On 8/21/26 09:10, Gerd Hoffmann wrote:
> The following changes since commit ae4f3443209ab154b48b706a146e5f557ab147cb:
> 
>    Merge tag 'qtest-20260819-pull-request' ofhttps://gitlab.com/farosas/qemu into staging (2026-08-19 08:21:57 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/kraxel/qemu.git tags/igvm-20260821-pull-request
> 
> for you to fetch changes up to e27a2b5f36a0fc913ab9a55a00f77a33ec6cc4f0:
> 
>    Update MAINTAINERS (2026-08-20 16:40:33 +0200)
> 
> ----------------------------------------------------------------
> igvm + vmlaunchupdate: allow guests supply their own igvm firmware images.


Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/11.2 as appropriate.

r~

