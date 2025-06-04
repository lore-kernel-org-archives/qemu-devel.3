Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E263C5B543
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 12:35:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMnKh-0005oi-Cp; Wed, 04 Jun 2025 08:35:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uMnKf-0005oP-BX
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 08:35:01 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uMnKX-00067G-FO
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 08:35:00 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3a4f71831abso5129933f8f.3
 for <qemu-devel@nongnu.org>; Wed, 04 Jun 2025 05:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749040489; x=1749645289; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zNouGB5ownswhzOyeyNO/jbAWCOo3i9n1GPrPt8KAMM=;
 b=J5ijbo5K1YDXgCt96qIiwUx/1qhSVUsZw730h0EIHiQ/6rjIY7Lp0170PYEjexPNFr
 fODKRRjkYQIMwf0fMUUL5Upsq+WI1c/Ki/7nV02gYSGtvsP7XS6457yfmTaP9GYGdwN1
 ZtVsdCp6TCReVFCh/suu/f2R/Kdrl490+/gwBvvPcBrMx6b2J6UT8w+RZ4u7kgSheuBq
 xuZ/ba7hxuVa8vGRyIbTu/z3h9C0FPRlQhRhAQwOchXKxuj9vjA0VTA1IcMX5WCAxIG+
 caeW0B4rpJBBBYkk/BW9yLCZEHiGI/O5Vw4HvWhtosnZdupE/dQLQ2D7t3bg1HKRGD7P
 mGbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749040489; x=1749645289;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zNouGB5ownswhzOyeyNO/jbAWCOo3i9n1GPrPt8KAMM=;
 b=niVXZ7ELL9Tmb9a6JojwqrHGco+5mO8W022U1wVGV2alqVuAsRzj9jnijrft8KL/7I
 rYy3Bhq0I/RJY6v4f27v/H1xGDm9tvzSh1fiMZC82E/s/OCMGQl1ABCQhnG03Im7pCNf
 3haT4oDmZ/KXa8qwBM/P4QH0lcVldfZ/EwGdOBcc0HAJOJAboYqvf+uVXD5z29/L8j+B
 Z6hWPYspcoI/JVynhhdMwBR6r2K5OBaiFrAQha41eJJGWRKjYWhgijeiNxEng37M/DWC
 tPB8ij/NyzPUoYIkEWnr+16Z8CRiRf4FGqIgXcwbt+FTNof0H0a/y1V3lNccWHGLBe59
 Qchw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXzMq54e2fmai50asNqS4XYICFUY2szb7j8tB18GF0sbehk/lOrLk2AxQ1ZVVxUcTml39eEq2Nbz3Ig@nongnu.org
X-Gm-Message-State: AOJu0YyfQiBKfbuH91N8KcgtuLMHdAKHGcF0VZVcFNXi32zA1MaPAQu6
 JHTRKPODbh1BzMGIe0mtHzNshrZ2JV0W8wGeLRiMcDhaxqFPG/DyW9n3JNK5aJkPw3M=
X-Gm-Gg: ASbGncsYkVSQTfhPi9u7FvSbZ5XBeXzgc/x3jgHXPLan+31FzerHhs7COJdsWmLCyEy
 6Qy0eWBvu36UZS14dECsn/oyOfC3q4r+f2Il71mpV8Lc+xiQ7mAaBldoSOP226sYCOi8iSVo3vu
 e0Yr8vhRb9987pd6TTIBDJnf61cCuN967B3FmVUR2dgzJ5bycUAG64x4mDBD5+PeI+oaC5w2Yva
 TexGo4Ejzl+h6/IdyVJvdkq+mxI7/LY+iz/ZuLpakuJvGYogUjQzpLxjGv+HLnipCMfJpCbJCQo
 /TE1jQYdK3A/jQYDGtlMoAm7tnaFFcEUo0EQW5JqtazzX28MD4/MUDSEvGb4a1+UvMjfONfjH19
 KbhhMo2RvnrZ00XU9zaU=
X-Google-Smtp-Source: AGHT+IGCGk+Mpcgy3o65Xx3T+nUkCIfF5YJT8z4rpQE4OV/KrHoCNkX6mIu4VbT3gslkjVN+r+u+3A==
X-Received: by 2002:a05:6000:2409:b0:3a3:7987:945e with SMTP id
 ffacd0b85a97d-3a51d97a17fmr2087284f8f.56.1749040489595; 
 Wed, 04 Jun 2025 05:34:49 -0700 (PDT)
Received: from [192.168.69.138] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a52203c8a7sm1311424f8f.32.2025.06.04.05.34.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Jun 2025 05:34:49 -0700 (PDT)
Message-ID: <fb7143e9-31be-44c9-91df-08a256d878b8@linaro.org>
Date: Wed, 4 Jun 2025 14:34:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] virtio-pmem: Fix definition of VirtIOPMEMClass
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: chao.p.peng@intel.com, david@redhat.com,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20250604115400.98905-1-zhenzhong.duan@intel.com>
 <20250604115400.98905-3-zhenzhong.duan@intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250604115400.98905-3-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 4/6/25 13:53, Zhenzhong Duan wrote:
> VirtIOPMEMClass's parent is VirtioDeviceClass rather than VirtIODevice.
> 
> Fixes: 5f503cd9f388 ("virtio-pmem: add virtio device")
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   include/hw/virtio/virtio-pmem.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


