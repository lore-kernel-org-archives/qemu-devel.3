Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91C82C87FD2
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Aug 2025 01:23:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiNRo-0007Mp-Ri; Sat, 02 Aug 2025 21:23:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiNRl-0007G8-5h
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 21:23:33 -0400
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiNRj-0002AX-Jl
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 21:23:32 -0400
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-73e88bc38bbso1179327a34.3
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 18:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754184210; x=1754789010; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TjpduI7txmOAYrbJSSbm1B2okNpLxcHOpe3ffpk884M=;
 b=mANELs91f9K0w+ypB53Y8q4YmKo9g4kSr01xmLV1Jx9w7OMFm6yCiY/Xgq4eJvExkE
 hpjayqQliC7+0957nepXM8xVMHCDf/TM7v6OW/Ny7039v7Rbas0ZO9J4eMecMVgimyoa
 L0pfMPJh+WnBD/3hqsVVKnZCNtHNfhmWyDpeB7alhZef6CXebpJEPKZ26uHGx/E6CJdS
 gu6rmbQP5WKwkYJLq8YvrX7WZyJ66enu61QJv6OVkVtdrhJkoCJVaNWKqIsuHD+RHBMc
 Is66XE3X/LmU4IDJ7ejsBfp006w/o2w/AFwqJQwA4TDm/3nz6RKxCzP1l9D32aQL/Jhe
 HmAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754184210; x=1754789010;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TjpduI7txmOAYrbJSSbm1B2okNpLxcHOpe3ffpk884M=;
 b=tlUnCEwjLA7PiBLRI1CPP7wgk83LgEoDYuxN3yYzeTbQd17RjtTxfeV+7pDXIcCiUW
 Uy/sJdGVCZ2TXHARc77A6AlDEzzhKg1rdVujD2gim3H1JMPwvLRQDaQl5fz/aogoxyrn
 yENNAOfnUiTgOf9NHGW1xd4X83413I8+K6bZravyckoOipxcyEEIxwv2hyvA7dfIwdEG
 EE4nMfS8BPuv3H4401gaBcRcMV2Uo0L05bb01dz3vyP9XEJl5NqUWe9YDj29ah6ZAPqI
 DXusPPx1CV+i7GaO6If+2nV17knHK1+AJaslq5A+hP+JRQafjJIfy+qnLpfXwTZ+o69r
 T5QA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWSlc/yb/ssXCC/4QAYO8DpH8JHY2X/KPptmmDpFv+kx27U6/HGUffyZEZldiJezzAalEI6GnF058t@nongnu.org
X-Gm-Message-State: AOJu0Yx2EFxbdHBZEpbJfJ+hGwJJw6rFaGbQ/KOVBizhytnIlNXMeEmg
 Z1VIzPX9H0DgExTejL/wz8DzDE2Og9USo7yob5HkAlrxmd2i2viM0ZM1ld2X1zoj/BgMN2a9Z11
 H9dKR+vI=
X-Gm-Gg: ASbGnctd4OtdyXWPNMnVOZsdsgfMHo/HP4vD/uDj5Ziy9QxQV5fy5Bvt/D2/UWbKHF4
 chkdncWDiOPS1/9Xtpsdz6GndH0TQGGcGcRSASxVbeNdPiW4kiRmHlPlLYJpGVEZxg0Cg3UX6oS
 waG8/NFwuCZsv5ikeWbUsBchQObBlRvMBRufgV3lb3p+6Jsl+osjqe7cHE8OMk3JZBbVpgaJxkc
 VJoFFJBkKH8N2ZBzasulag3+uPdqVSWft2tnLA1t9/VkxC3mhrMO5qYWoV+QxCp9XhB6QFPS3HV
 qH9mPbuig88eZzIfdplGSDKanQcrnz9hrJ058st/5DzDwB5mbsHYq9ugHHJbmPIA9vBC1H7Dyi/
 xtXa6k+GX4U7UWE2IVngOPHhy9zoNdPwRaKY8JYNMP5dpQMWevSYN1VEyYyZ6ifWYPomuw7+MSp
 k=
X-Google-Smtp-Source: AGHT+IHhDb+5Syi8Wya9i86DWnpHAvK0ZfLZxIr93afFjCvdvcYfcP4zTYujNgEHuMXngL8/2Me85w==
X-Received: by 2002:a05:6830:3485:b0:73e:9b93:2808 with SMTP id
 46e09a7af769-7419d21cb8amr2680325a34.18.1754184210217; 
 Sat, 02 Aug 2025 18:23:30 -0700 (PDT)
Received: from [10.153.194.227] ([172.58.111.133])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-74186dac9dcsm1530099a34.42.2025.08.02.18.23.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 02 Aug 2025 18:23:29 -0700 (PDT)
Message-ID: <88134bdc-efbf-47c4-911a-324706e0a6b5@linaro.org>
Date: Sun, 3 Aug 2025 11:23:23 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 14/14] MAINTAINERS: Add myself as a maintainer for WHPX
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
References: <20250802081800.76030-1-mohamed@unpredictable.fr>
 <20250802081800.76030-15-mohamed@unpredictable.fr>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250802081800.76030-15-mohamed@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::336;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x336.google.com
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

On 8/2/25 18:18, Mohamed Mediouni wrote:
> And add arm64 files.
> 
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

