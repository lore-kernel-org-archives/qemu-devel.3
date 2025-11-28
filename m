Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2A59D116F1
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Nov 2025 13:00:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOy5f-0005q8-W1; Fri, 28 Nov 2025 08:00:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vOy5K-0005m3-EM
 for qemu-devel@nongnu.org; Fri, 28 Nov 2025 08:00:28 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vOy5I-0005ng-DV
 for qemu-devel@nongnu.org; Fri, 28 Nov 2025 08:00:25 -0500
Received: by mail-wr1-x442.google.com with SMTP id
 ffacd0b85a97d-42b32900c8bso1222083f8f.0
 for <qemu-devel@nongnu.org>; Fri, 28 Nov 2025 05:00:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764334822; x=1764939622; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Z0lcmO25JMTF98tbEeS/ePbWywvZaQ0AiiR4KiAhCRw=;
 b=BTPgCay0wsYHjb9qowr5CBH5Xc1pY7jsv1r7CN6fwrl5HdQ0RE+NhyGErkFBtjV/Nh
 l88is5puntVXQaN+8SQpG+rrmxMYGjb5zL4At2xED66wSCB3dwN9vlaGyw6XI4j7LT85
 DiszFkHeg0+IkvaQgX9mldA7v+Bh8uvK1zFS9StJ4w5FcPURaZ1+8LqqJ0Mand6/jdGc
 VI9NdEd3BmOSVCwcREljv3wVcQBCoUJf/SLHCbARQCWa8Ws9MrWak54k2oWMw1lq609T
 cCjfIflFuGhAP1kuCmnCKhKzD7jvt34Cvg6F9Y+O6Sy9KxtxjzBCcSa6N2wQ+1aIauOX
 RZzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764334822; x=1764939622;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Z0lcmO25JMTF98tbEeS/ePbWywvZaQ0AiiR4KiAhCRw=;
 b=ef9KyifBMI19veLGNt/Gcm7/cxF08ebiYwgaiW1z0bf1uX235OB34jNDzXCC+0bai7
 iHHPtzyLTwWxYAE3zk15uwa+Uv9/gqX0E91LEQJwYpnH1prDkurXRbDsJqtoYWoQES6f
 JtlxKyU4gC42yGNt/aIm0LAJnmmJBUKUKQBtysJAwF+k/VNNeHSDpqgH0l4z7mbOyxM/
 hHhV9G7kcSGz2yYKMyHsyMSTGWuDSDmWHBeg6iuXqIi0tCTHWT1amPOpWbHbXiyU/04j
 4noO7NUBagLPfCP38NSdbK0AxkN0uTczJ5djfFUy1sy330H5axjAyRfTQxZZ2FuoZ+E6
 wgcg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXPVMcbE4JN5klMKy1zDTE6q1VoppmRtNrN/2LOYZHC5T54BkTu0/cCeVo9ZATvCEgoNp25g8Ge8kU8@nongnu.org
X-Gm-Message-State: AOJu0YzG3nuAN4WjPMfQr79ZOiuG/Xejm+BSurYGIpXZh8I5OB1XqV6B
 ODfCmL0dCyX75EhyscWX1kiWertq2XeNT64s1cBiqHLuJWjwuykILVj3MR4+oAax+NY=
X-Gm-Gg: ASbGnctZUXyiLnC/4xGmFUwrhtwniUau5YyI+flipKi7vpGRvwU8Cvlgz/0Zmms1k4X
 g1k8187ok4tE3MWNMLpiyItYQUQkcfPekZNDti2OU1wAn/nD7LJV9/M4phGAF+JSbxkBWZR1yNO
 nExa9p/sart3pn22NoJ2meTxctFL8krxUO4xaGt0EXUAhsJlf7SPnU1s9Y5XwEnoDSwvI7c70dj
 avibNCFr5BW0doBlwOATK3YZcKaJa9AYYdayF96oYYiZK8SRkcrS/76tfRRX6xUCV3PZf+s2vFf
 f70wU1rxg6forLJdRSixZGDrw7Xvv6OCxh33ITAl9VtLitZsmCsLYbhsq18LxcfUAK16oBv3Q24
 Fo0Gt904t1hm3SSzFlE1BfKBPn/VKYsarNGx0WFKsYThdU5+qfmo2wlgg5/XDl64D0/DHm2JwvK
 LfEBCJpcXza4f3xsOHH/+SuI0OIK9/fgkuVmZiCw/CCMjxnGjkKL0stg==
X-Google-Smtp-Source: AGHT+IFqi+C6pQ91KEHnmfDx58zX6FNEE+hvkF7lSU+RWiSA/+Q6Gi0XsNKFJVO0oDMzBOULtxIDOA==
X-Received: by 2002:a05:6000:26c9:b0:42b:30f9:79b6 with SMTP id
 ffacd0b85a97d-42cc1d62843mr29404341f8f.58.1764334822359; 
 Fri, 28 Nov 2025 05:00:22 -0800 (PST)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42e1c5c3041sm9112980f8f.6.2025.11.28.05.00.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Nov 2025 05:00:21 -0800 (PST)
Message-ID: <8d3463da-918c-4738-84e2-f82afddcef87@linaro.org>
Date: Fri, 28 Nov 2025 14:00:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/9] edk2: update build script
Content-Language: en-US
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov
 <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
References: <20251128084524.363989-1-kraxel@redhat.com>
 <20251128084524.363989-3-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251128084524.363989-3-kraxel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x442.google.com
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

On 28/11/25 09:45, Gerd Hoffmann wrote:
> sync with https://gitlab.com/kraxel/edk2-build-config/
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>   roms/edk2-build.py | 21 +++++++++++++++++----
>   1 file changed, 17 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


