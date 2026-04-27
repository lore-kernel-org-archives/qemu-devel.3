Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15068FF8860
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 06:25:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHFPB-0006kY-Cq; Mon, 27 Apr 2026 02:25:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHFOl-0006bS-Um
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 02:24:53 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHFOk-0004Gd-1W
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 02:24:51 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-488b0046078so89334025e9.1
 for <qemu-devel@nongnu.org>; Sun, 26 Apr 2026 23:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777271087; x=1777875887; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lH9Nhx0CK+2POU6YoVvymiP8YWbHqsgW0nwulKYOUcw=;
 b=omViBUN/F80IowsGH/z5hzRoadwm1PmqcjMg8R9GeGWX2E1/+2SvNcf9OJhp4rH8uB
 ZYYkd2laIhvxfi+/fpSUCnUVrWch66YmSQJruJNLIHIADpQlj6UnJbwNvruc3k6qZ/Be
 o3j1t9hkaxJV5TFDL/2039t01eFLWz4judBPAaTqdchs9cmOOs+z+K8BTQq4cFk94srA
 syey/cMDu/2Kc/iIQp+WyHUsNtP0LDrfOU/doeSU9D1xx4vesf8BmILZ0yyyf891KTzh
 s9/hCenWLtyfof4Daag5LE5be5yD1IsYvHyN/FSoxaqEycvm00nmJTa/SZScTCqDdfVP
 btxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777271087; x=1777875887;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lH9Nhx0CK+2POU6YoVvymiP8YWbHqsgW0nwulKYOUcw=;
 b=YPY3+k/YtAplMbOLa0N0aLe/PZAlh8tDqC9KK3gv80SDtguvpbfuoHMpAzokiOn9Yd
 rpqxTNi3P5iAArpq32MCc+tjqVbh573dPK2vre4Gr7Q5/8ZbSJ3ImAZT6DhA+dECtDLs
 jJ9oqrp04c2Pc8sTUGKRQ8heTRnAzJ7CUrscaFG3XFEcenOsRS0moh2YxQ7V23/loCPo
 ib9eA0DXaMIfp4wggpljTJIPi10Jom+Bc5EeZi7oFkRY01CalMWDWcKsXx3zueDcQftr
 ekwssKzbMnYK7zY0Xouq+PMSspb1UFU10E8NNXoeYSp9EHY7lR+lUxOgWoA6mBDGqkdv
 vIsQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8MSXYzPUockYGn7bygk5pjyv0a4n39cSSHJ4TeFUDFz9Cl8m7TfEMxhh4vaQVpx5tvwyIXPZLNd05C@nongnu.org
X-Gm-Message-State: AOJu0Yx0ifYNjgfCiAlmwxuUfny7rP18wuaJ3IpFkm7Ua3WKiAsqqI81
 +r1meoiZL0FZXGnEBft0Dpi45P+BamF1WJjIxeYdNCd26YseVijLyYpeHIkcv9seZvw=
X-Gm-Gg: AeBDieuR6Kr0+1IfRJC0/SEZlKcGoQqdqwxtgLSMplGhIy9FbujQQEP+r2fiEnZrUCu
 h5D60zydvd6WSOTO4XTtGnahywSJF99sGXx1C7+DKcrGms5MkFWQUnqcABrCmtX8ErVFCq59YW+
 uw4qiYg41Aqn0UByxPUPDhe0RwY4aDt0e8k5+q30z8IptHmm220Md9d9VM2NsQ1T6HZCDdSXOp+
 g/D58ukox0p4E9dRI9TnuOBOoNGCB4nobB78BucI/phYKGyPyVeYxv2nx8B4KoUcaOeh60SEWhi
 V+1mLN1RZWthvCEDRAZzylf5Iw4CBUBEVP1TZYHsA6lfDqARP9Xc2q4s62tH1G3unoSB8cAI/j0
 7wbLS7uZE5Gm3YI9aJ5A21OLfn2J9TVabm/kfeWlWZLIc88DptVPDhotDdlDh5uYXHxd6Bxo3fs
 jhrJdIL2evXRWBM2un06ltcOr8CHOskYWXS+Sd4UdXkpuDz97iYC6ALU9OeADZeI3qE7WlUPUTh
 DLS
X-Received: by 2002:a05:600c:621a:b0:48a:6268:18a9 with SMTP id
 5b1f17b1804b1-48a626818cdmr203902495e9.13.1777271087286; 
 Sun, 26 Apr 2026 23:24:47 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc1393f5sm714718215e9.9.2026.04.26.23.24.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Apr 2026 23:24:46 -0700 (PDT)
Message-ID: <b45e60d9-b190-4378-84c4-3978b6ee6195@linaro.org>
Date: Mon, 27 Apr 2026 08:24:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] hw/display/cirrus_vga: Fix packed-24 color-expansion
 ops
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Junjie Cao <junjie.cao@intel.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Chad Jablonski <chad@jablonski.xyz>
References: <20260410183249.4046456-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260410183249.4046456-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

Cc'ing Zoltan, Junjie and Chad.

On 10/4/26 20:32, Peter Maydell wrote:
> The Cirrus Logic VGA card raster ops allow the left side of the input
> source to be clipped (or skipped) based on a "destination write mask"
> field in the GR2F bitblt register. For 8, 16 and 32bpp, this field has
> a simple 3-bit format indicating the number of pixels to skip on the
> left edge of each scanline. For 24bpp, the field is 5-bit, and is a
> byte count of how many destination bytes to skip.
> 
> The card also supports a "color expansion" mode for raster ops where
> the input is a monochrome bitmap or bitmap pattern, where each bit is
> expanded into a full-color pixel which is either the background or
> foreground color (or not drawn at all, for transparency).
> 
> We have a bug in our implementation of the interaction of these two
> features: for color-expansion to 8/16/32bpp the 3-bit destination
> write mask field doesn't allow skipping a full byte of the input
> monochrome bitmap, but in 24bpp the 5-bit field means we might need to
> skip a byte and a bit of the source. We weren't accounting for this
> need to skip a full byte. The result for the "pattern fill" raster op
> type (where the input is a repeating 8x8 monochrome tile) is that we
> attempt to shift by a negative value, which is caught by the
> undefined-behaviour sanitizer. For the other color-expansion ops, we
> merely write the wrong data to the display.
> 
> This patchset fixes both bugs. The UB one was reported as
> https://gitlab.com/qemu-project/qemu/-/work_items/3377
> 
> The technical reference manual says that 24-bpp color expansion
> "*must* use transparency" and doesn't say what happens if you try to
> do it anyway, which is presumably why the other raster op functions in
> cirrus_vga_rop2.h don't try to handle the 24bpp write-mask format. I
> have left this as it is, since we don't have any reports of UB there.
> 
> Big disclaimer on this: I have no guest images that try to use the
> Cirrus bitblt handling at all, so I have only developed these against
> the reference manual and confirmed that it fixes the UB repro case
> from the bug. If anybody does have test images for these that would be
> good to test...
> 
> This bug has been in QEMU for decades, so I think we're OK letting
> it slide to QEMU 11.1.
> 
> thanks
> -- PMM
> 
> Peter Maydell (2):
>    hw/display/cirrus_vga: Fix packed-24 color-expansion transparent
>      pattern fills
>    hw/display/cirrus_vga: Fix packed-24 color-expansion transparent
>      copies
> 
>   hw/display/cirrus_vga_rop2.h | 52 ++++++++++++++++++++++++++++++++----
>   1 file changed, 47 insertions(+), 5 deletions(-)
> 


