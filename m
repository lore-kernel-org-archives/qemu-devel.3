Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63FADFF8868
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 20:33:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHSdk-00068l-Qc; Mon, 27 Apr 2026 16:33:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHSdi-00066B-Jr
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 16:33:10 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHSde-0002rZ-Nk
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 16:33:08 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4891d7164ddso53296195e9.3
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 13:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777321985; x=1777926785; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3HdjDaT3SryrI3CumM5wGpAplD2TZykyVHPV2cJRYt8=;
 b=uvbAlPeLh3WBOibY22pUSTXJnNVIRBnVfE9B1nZMx6ABTp0PfgNmltOP8/zhirPNf/
 rmFh3mWNQzjfDt5bN0PnHbBjZytZZdIZIvcEd8XRt/f83NJ0OR3Av+WuZzeZUSNYGrcY
 4BYXf3emehTXti8S1S2EdcYW+jWx8A6ZFBJEg4bbXkda+s7TgFKyT8J+Jp5AzfUnDNnt
 MPuFkrRZVSzdeMKTZOli6drpL+4Z4M9aFu+tciWm3f6P4de8UojYuSnvTMaX8t87WdgU
 NTlN4W5ZwNhayUXgKfaba7yk8UPvkk1guhzYT6+I43BdK2uw4vB450z/zfX0pqMp2cIk
 QrjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777321985; x=1777926785;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3HdjDaT3SryrI3CumM5wGpAplD2TZykyVHPV2cJRYt8=;
 b=kHLJFqJszRCJaWnwiPV3Sf0ks0feZHib3v7Mnc2lQ6hXpvJ0AEBxV6/ZObngo19wxs
 gO9jKYNEvbGaSEuYAogbEH6/oGluvxaPmAEvdr9ZinD0vNjh2fmPeGVOdoHMBitQDBDn
 udBwx+h8HL9WUs7qGGzh8lV5bEwTe4vAwX6HjLYc/+OgIP2sfW19qmgP1aswQ+s1dt6W
 NZwd5sa7+MmheJ0z3YYVZ2n0k7q3lox/mjO04TvGimfe2YkRkSMVg7UmUxojmDxiJ984
 WBflv1cAdceZ0z6GhUHwSAnh/1Cf24xQcrjB6jD8eRfnMfp7eje4KdxUZT86+t8Iu6s7
 F4wg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/Ijt3BF7Mya5YbD99wLl8K4M7LjPCRNYRk76wESDgGQScJYtHkJbY6rxJzWxWZBbhwVNxf4hlFxDgE@nongnu.org
X-Gm-Message-State: AOJu0Yym/kgqMZ5nOjvLIjjcbzxRDa8r+EHcEi6sumjEOleexsQngR5z
 k9PwgXqDY7kRmEy0lXLG2AHZILV86czXCh3guu5D7DX8yinBjXnyVfq3aUkKtLiXbPA=
X-Gm-Gg: AeBDievDgZgu2a43KDl+Hdf/3O29FJ7m0zN1eye+Oxlp5T8SvGmtRXOXPYHXjpvM5gK
 Zf61JOWvRK572JKLpZfnf7U3q55Knc+qN/nplPI0ggq/9FxaP9x+PXPHFNmfEa/OaAo8nPWMyDu
 bp/Tp9ZcyOvRtLDc+TlVIPPpN/DZQb1cQBcdPm+AhIQ4k96985v6Uq3+isa5G4E6kmFNYe26Url
 5zlVPe2yNI/glcbLZREPTxMhADNmhUHmSmo/29RzQrIVYYQ1FZkbLcOjEOQ+Kp1r/0d3I6Ej8/p
 MHFajH2UF+VqoCr8WBc+ifBIJ8HGlLZGSvOrLpxsCThIq02a4CKQgaOCDJ1ewMBddxAaMkf8sNA
 /Y94WaxDrqBQkOfRgpyLOtGlvBpYzKEcZqb1RSi6xZE2ryoUwLJQTzWrhd0zYoO58qd6pcUhvYR
 EhDWLi1riwMNUr5JnmEY8k8z/2cvnZ+mPsxcHLSg6jy6S7+efpj0niILfvAAwvuVy52dtwWoPCC
 oUs
X-Received: by 2002:a05:600c:630a:b0:488:ac01:72de with SMTP id
 5b1f17b1804b1-48a77ae0340mr3979775e9.5.1777321984946; 
 Mon, 27 Apr 2026 13:33:04 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a775f7ce6sm2636865e9.30.2026.04.27.13.33.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Apr 2026 13:33:04 -0700 (PDT)
Message-ID: <16c30008-5d6f-4ae2-9204-c8f5c064bbb0@linaro.org>
Date: Mon, 27 Apr 2026 22:33:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 23/84] fpu: Drop parts_uint_to_float
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org
References: <20260426134002.865628-1-richard.henderson@linaro.org>
 <20260426134002.865628-24-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260426134002.865628-24-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 26/4/26 15:39, Richard Henderson wrote:
> Use parts{64,128}_uint_to_float at each call site.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   fpu/softfloat.c | 18 +++++-------------
>   1 file changed, 5 insertions(+), 13 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

