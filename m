Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38964C87FD1
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Aug 2025 07:13:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujYL1-0007Dp-HZ; Wed, 06 Aug 2025 03:13:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ujYL0-0007CK-GX
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 03:13:26 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ujYKy-00014X-Qr
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 03:13:26 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-459d40d16bdso21600195e9.0
 for <qemu-devel@nongnu.org>; Wed, 06 Aug 2025 00:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754464403; x=1755069203; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0M/1SWsgtDvmbSbM2U1gGyTHJTE9wY4Iz+BD2R/bYqs=;
 b=L10YXcqheKoyaPRHsxOUviXGomFgt0i4sgcOh+mGI5TM/hlsHTrlR9fZDwQ4M6jDwg
 v2pGtkc3jpdTUqG9pcaH2RtC5U1SQ1ArSq3oifF8Paod4YJSD8lYbCFQqpqD3n4UEHis
 uNq7WoCxWtX4dqr6h39lr8Q38B0BH2bi5aDZx5QMvZmzfJZ1bDFLuCWUx+6v/iAHT3N6
 RZmr2JwsIqSUUHcc0Fy+3zcUksyYNSiuhxu2I2NH5I4eTUt83lrqjDNlLYTh/zKgcZZl
 /EsojenufvCmsryVCtKxpWweOxOPvMqRY2htLLDGtbVOlii/0dLzGG6Y4JgLK3V55Jg4
 oYYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754464403; x=1755069203;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0M/1SWsgtDvmbSbM2U1gGyTHJTE9wY4Iz+BD2R/bYqs=;
 b=J/JkM7uOt7BDevIKsO/N0DGV9KnmsVD+DWkGNaaE+SaQA0LPD6gOy57/StrCUV357C
 Tcu7x0FtqATAd2HmZgRPcEQRWl4DLXb0fSKeKzFCRNpBKRSDnDkwLElob1fKEuP+OKF5
 eKz6yjgBEdrfciNYyZz4kbdT6ZSM5hcOvKGd7nXQH1FpDDcsMaszIUSbNrAYp89J6g7H
 lEt03a+ZjZgDsaHSq183DQ1N8u3jnwizW/SnDgOS3x0pawlNzfAGe6cDe1WMKWiLsuJt
 skGCl5nwt1KlsgHZpkeidTvyz8AMAXb4Zn9OpRDNBNS3EOqc2jjc011AiLzD0BlBliOn
 IThw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+ljJ/pSmTYSA/PrJS1geEYIJj/10WrOGd/cPBh1xKce/2njaPRwxe3g/54pF5I0t4pOzivq4cfOJM@nongnu.org
X-Gm-Message-State: AOJu0YxT+EVr9oFBr83gcJ5CW1HLsmqVMXsY0K62ry8q1EIglDUUPFk7
 csXul4cFHYtkjwlG6xAiHFHSnko5/t9EsjIcjyQOTVMagTfIzhhL4pNDnIy2EHt1hKo=
X-Gm-Gg: ASbGncteEETHixWRoDlEh8I99DxH6W9yG3BCdFY/2jaFOkTO8jwxclfMhKhNjRRLstt
 S9NLN/7QiOVn8Q51qUU5VAbF95rfAKe16tGNUXaYmoB274uXjAKYn/8fY7veBDQnN/5Tb/EBzhW
 tfkc80kshQSH3xjhBtukPUpm7uF5VdBgkphMufv9A91iJzuQlANlxRCxeJLxJDykovXV+bYiOd6
 RWVu+i487dbyr9/c51peWpKZiehBf5kuZyUAG+OW+BS+jCqqU7RmE8lqoh6lb0rGEpPnidKK2Sx
 juect34QPlYXpd8VDM1fcSZEvh6y+u934bufbO8BHdsJSOuW2z77eTT1Yw+VWTxqtx7Q+ysJ816
 xxPPcp1a+9fH+V8d50SyXNTtIMFC9ycHKFusxKKqSy6XzdMKAkXJJTr3X+HBCCi7KQA==
X-Google-Smtp-Source: AGHT+IGwh566ux0Vm0HwPF9bryETY1Upryg1PEtjQQ047XagT1qDXy3SY0ARlX1GwLngZRsi7EdVnA==
X-Received: by 2002:a05:600c:4706:b0:456:1d4e:c127 with SMTP id
 5b1f17b1804b1-459e741b644mr12799105e9.8.1754464402800; 
 Wed, 06 Aug 2025 00:13:22 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459e5862be7sm36812835e9.15.2025.08.06.00.13.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Aug 2025 00:13:22 -0700 (PDT)
Message-ID: <cb833b88-db3b-4618-9587-ff0de4197e76@linaro.org>
Date: Wed, 6 Aug 2025 09:13:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/24] tests/functional: Move microblaze tests into
 architecture specific folder
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20250801151251.751368-1-thuth@redhat.com>
 <20250801151251.751368-14-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250801151251.751368-14-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 1/8/25 17:12, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> The tests/functional folder has become quite crowded, thus move the
> microblaze tests into a target-specific subfolder.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   MAINTAINERS                                           |  2 +-
>   tests/functional/meson.build                          | 11 ++---------
>   tests/functional/microblaze/meson.build               |  6 ++++++
>   .../test_replay.py}                                   |  0
>   .../test_s3adsp1800.py}                               |  0
>   tests/functional/microblazeel/meson.build             |  5 +++++
>   .../test_s3adsp1800.py}                               |  2 +-
>   7 files changed, 15 insertions(+), 11 deletions(-)
>   create mode 100644 tests/functional/microblaze/meson.build
>   rename tests/functional/{test_microblaze_replay.py => microblaze/test_replay.py} (100%)
>   rename tests/functional/{test_microblaze_s3adsp1800.py => microblaze/test_s3adsp1800.py} (100%)
>   create mode 100644 tests/functional/microblazeel/meson.build
>   rename tests/functional/{test_microblazeel_s3adsp1800.py => microblazeel/test_s3adsp1800.py} (92%)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


