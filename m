Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C910C19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 19:39:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqdXc-000367-En; Fri, 07 Mar 2025 14:39:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tqdXa-0002uA-7q
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 14:39:26 -0500
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tqdXY-0007fb-MI
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 14:39:25 -0500
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2ff64550991so3669360a91.0
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 11:39:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741376363; x=1741981163; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=n4DBrroX60vSE6MhlD18HAKhG95B2LCnVBL33ZQjaLk=;
 b=Z31G48bsX4QSsKw8RI0rlPRqd/nFVTR/dIXaN//CJROvzUo5cbJUubsf0uyoY5Fqwn
 yYvJQROKad92ZCmuGFlHwSxvdKpUd+X8wyxONvOuMKjZFGyRIlrpthJb/RU/GpgQrG+e
 Uq3CJaiN3A1phOF4QPhaGEVFj7vRQ+mj4hbanWVqezpPerMEMLQXoOPLY9axP5c9Kipo
 gxQ1YvrWOddTLjh7bGPPtsgd8tsVBpU6y+BMhOET8Hf7phf0W8ukj5ICAVlm+XvYiNot
 Dq/c7l+YVM4UaUgcew1KHbB6RYBkRROswULPA4wlTgUnTc8Jxv2bbJnGEftmK1GxxFT/
 PdYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741376363; x=1741981163;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=n4DBrroX60vSE6MhlD18HAKhG95B2LCnVBL33ZQjaLk=;
 b=HcJpe1nhZX7OvFsv76d4FUTlGheNKB/ctm4diqJ+hB8lTXbUbm10cg3AyetciAcxkY
 4YVx/c9t04fowRjmYOtsWG7qAO3PvexA2Pth6l7cF8oGYwY6e7psQRjuSUDiA0iEr3F/
 EZIzTe5Mzy3tyvwXV4WV9H9lXhySfNL9gWiPaQgbFRS8UeGGIfDsgPZW85QqguNMszNS
 7Rf/jgdec4sgzHWkNzLFwB6i/72aWxcd4mDHi8ZrNi4XRfEyyeJ27rt2+XFsShgBTkYV
 S7ma+sdzVEFYd4vHgf1+6nsU8/grdUHHuj6BVprL+mnjTnSW/m81LwhlgtyUmOuhz6h+
 77tw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6j0Ix+1WHLbC6zHg4XeNLJwydYvAUrzKxaq0PB9tmKKr+z/lWt1hqdDdGYJWGkrPS3BFYFnB8hquz@nongnu.org
X-Gm-Message-State: AOJu0YzE7iBI8H3ktgDLRKHOPJAxdzQIp4ZmSGZXI/Yt2imSchp6mB1t
 awyUEfii3vUbDgRz4iRoZFS0nHy+4PH67Ogp3IcKu6NrXEltec1xiezwj/yDwyc=
X-Gm-Gg: ASbGncu7XcnluKCQEI2cX0246SzXIT/Jrts/Mva/glx4M76jXWVwTwSBgO1EicYe2E3
 sGh0wuMYi9Ni4HuVRRniCfwZtTin5VYvPz1JMB9jOek7Ds1nWFk2F86ZAYIoI7bgyaqdXJWiDyP
 Xl/rSUBHm6R8RwMNlvQE05aE0yl50gZB7Q/V+s+GO5kiyxaSFV6syWSB6+jB0WkG97hYP7yy77w
 ATdp+XfX5VbAqPnU08mU1u/R7pSRYDV5F5BYq/XIZBW/sspvjTU174ajhullglKsqcKn1yrTSYL
 TOF5q/6lfApw8mVH7bQG/IDBvtL2+tQrkDKwUqmS7U1vqbgbP5fhiwakAOAZqmj266lKbuus2Eu
 0448Upx2F
X-Google-Smtp-Source: AGHT+IGo7C4lopTsmVYaYp2pDtxJ7qLrUwS+TRu5FYG4DmRHgRD7p+EkAors857v2+zYqyet2Wt2Qw==
X-Received: by 2002:a17:90b:4b90:b0:2ff:62f8:9a12 with SMTP id
 98e67ed59e1d1-2ff7cf0a65cmr5955242a91.23.1741376362987; 
 Fri, 07 Mar 2025 11:39:22 -0800 (PST)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ff4e7ffe18sm5368737a91.31.2025.03.07.11.39.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Mar 2025 11:39:22 -0800 (PST)
Message-ID: <a5de568e-0171-4352-85e7-312e88d40146@linaro.org>
Date: Fri, 7 Mar 2025 11:39:21 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/14] hw/vfio/spapr: Do not include <linux/kvm.h>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250307180337.14811-1-philmd@linaro.org>
 <20250307180337.14811-3-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250307180337.14811-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102c.google.com
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

On 3/7/25 10:03, Philippe Mathieu-Daudé wrote:
> <linux/kvm.h> is already include by "system/kvm.h" in the next line.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/vfio/spapr.c | 3 ---
>   1 file changed, 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

