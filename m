Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 268F7D3B7EA
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 07:11:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSrsq-0006Nl-Cz; Tue, 09 Dec 2025 02:11:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vSrsT-00065M-2C
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 02:11:22 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vSrsR-0002qE-HX
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 02:11:16 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-47798ded6fcso39234875e9.1
 for <qemu-devel@nongnu.org>; Mon, 08 Dec 2025 23:11:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765264272; x=1765869072; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ga4ajJPzcJ+zzds3qHHuanskpvSQ8dhYi5pekiD4Is0=;
 b=gcsbx0uSMdvugM7U8CB46ywHevfWtx51cKH527bzVQVxvsG1TzpJIYYA3Re34ikwKL
 7ISa3s7hmISagpGS47iiiBX/67BmDdPdYT4jtZZpOL6LNF4KSbc8ru6yPV0WtkDhqO8p
 LByKMa+qcjz0YYN5hLuxJo3X2HdrOkQH7/Q/a/V06YeB9ZH6sv9e/kp2rRJxevgn+B2R
 mN3Z6KQmTkpaGQrIG0CeuS1sixxkEldftZ3Gv1+b/mdjuE2pyCNCaun+W7973mJKR1O3
 XiL9g8wm7Wb/Zawcos/pUX8Cbu905cpyO1NvfxaWpnA47wShdoQKiTuCh8zwQW3L21B7
 6ZfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765264272; x=1765869072;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ga4ajJPzcJ+zzds3qHHuanskpvSQ8dhYi5pekiD4Is0=;
 b=V3KRhcgZAn0h7mrKoXR7GjudDSOlKD5VoAcD7bQ7liq07ubBNgkPLAtjJggNxVzwl8
 tGDOfCy6RvZEn4pBRcXjCthAhJfx7meCu/LTbaSPOQuBtKX2VyRzXaXV723nXiON3Qhi
 oPoTAVIPD9/IqgEd+g/NIwuSi1JqUwpua316Cj3PR5IcJPNKQfxYAG4D1wZcleP+Ix+V
 UvPO47g0vg5M0lZLS7lHXq1ELElk9rNbb6NuIDowaHgNCdziLAc6+yLYZoZmdvyrFPsS
 6TribLW9fsJGAo2T7ZwaT5w354DY54Tmguzx9GRaMi+4Zmigc9ebh71ss+aWdR3SKipm
 pUvQ==
X-Gm-Message-State: AOJu0YyLU2hK6hmSEWQAfe+NsbpbwnK7Ni3qMUZJeZiapTMGDRbwfsGu
 5nv2PcScN/ogmwvZrvMOMP7crhrcKNFxipLUk7JA2o3y2hKYgCLQucBrCJW/Xo38ry0=
X-Gm-Gg: ASbGncsBjWrBJDaE7RfBxEGASk7fXTxhnm4Mym6babGh8FjKdKA+oVWNcy0hRGiUYDd
 1L7Qy1NBg8BRASLrf6dCuCIHiMSWU2joXETW8C37lWQXBYC4yRq/tNeZl9SE4JEcPiKbzVF7QSL
 du6UMCTduqGBOF25lYJJyRcT5QTBFPqYGfyZK3p61nU52C63RIVuSyR/yj8G3g0+x7nmJMizMSg
 8fhxGUZUC3rcJbzZNzzNrhu1tQxNv4fpohbAugyJGLb1SfRxyETI9hKX7ZotaigV+7auK19gfKy
 TCrd7HPjfOC1YAYPhxxs8/b+frbQFElKoil8MbZWWpKKoNDb0Cpk0nGMbZxdW+P6v3AEyj1EIyp
 R/YgSpTZlgTBRzgijikNM7KDS83NoyIzD/wRiP3m+YyqiNg570cy61cMdqQ+/5PuTtVUIALRsfm
 7yxnCBTzHEuIGpdgyQiT1TKFyzqv+24oKHUOD2+mpAQ0ptJGpuDNSdsw==
X-Google-Smtp-Source: AGHT+IFoEVjiAJnrbvYg/Nl/dg/F3h/QIDdxNmC+mo39ioiPd6z8p9JtUGoSMI9EhiLwk8YUH2o53g==
X-Received: by 2002:a05:6000:2211:b0:42f:8816:a507 with SMTP id
 ffacd0b85a97d-42f89f639fbmr10522044f8f.60.1765264272250; 
 Mon, 08 Dec 2025 23:11:12 -0800 (PST)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42f7cbe9065sm29888851f8f.8.2025.12.08.23.11.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Dec 2025 23:11:11 -0800 (PST)
Message-ID: <dd541a44-4d84-40e8-b8e3-82951039036b@linaro.org>
Date: Tue, 9 Dec 2025 08:11:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/qemu-iotests: Fix check for existing file in
 _require_disk_usage()
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Fiona Ebner <f.ebner@proxmox.com>, qemu-trivial@nongnu.org
References: <20251208075320.35682-1-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251208075320.35682-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 8/12/25 08:53, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> Looks like the "$" has been forgotten here to get the contents of
> the FILENAME variable.
> 
> Fixes: c49dda7254d ("iotests: Filter out ZFS in several tests")
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/qemu-iotests/common.rc | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


