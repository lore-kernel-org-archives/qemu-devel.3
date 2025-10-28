Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAD26CCF9E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 08:10:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDemG-0005L9-BE; Tue, 28 Oct 2025 04:10:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vDemD-0005Do-Kp
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 04:09:57 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vDemA-0001Ua-Tx
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 04:09:57 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4710665e7deso29218075e9.1
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 01:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761638993; x=1762243793; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5o79HTrwKutaocALjFgRBFk+W1FD9POxl9sF26qwAFo=;
 b=Lo405zsL1wmjOyJBdv6qQbnXuedblttkgvrd4WVKH07bMupUzySV9QaN4RA+jMLcCw
 zlzIN9aLWmDaOtYRk/jxO1F5DL7I6OvDiMWya1g4M9q6DQsV2QN3730oJ4aIWiVRElWX
 EkfWBkpSBjY6YhE2Q+q7xWGjv7QiisaKG2bxUhDeUn+OynTN664+IpTnn/o+F0JBrwPA
 /wNRLSJdS31GS79MmXEjHkg2guEnhCv7J3AS8L+1TXkEA1fLWQjuKPnREbu9FMVpB1oA
 OWYFwjZyE8KXBQdh1l1H/Z1HZdmhHBhWaM2WP64ZMj4r5VSYw6uNbk7d0xNtxWSJgeKk
 FXVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761638993; x=1762243793;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5o79HTrwKutaocALjFgRBFk+W1FD9POxl9sF26qwAFo=;
 b=IMzJQdPjSEvLfTOTX6DrJD52PQglqqCERSXBdQmLb166Di5EWD5acBiCOMYYQ0OFlt
 32NcO3cEdWzHbZ9Y/JozJRg9R8A7yYEjXNF2PjjfkxjqFMJ8qux+h4ys5CtIsPTXN2QN
 9bHkQpC9BYoJ4ud6Nwv6rXFZHOQWivdWd1DeA3b6tT1NnoPSZ3IYRazc7WkGBal2wSqf
 yqQXiIf8zvgpirIKszDQEFqbD26EcuNQGbCvafy7IFOLC2qoIhLXvQdIB6nlEO+R/79U
 U6lMHxnHaoZBA+Rfp42ypW0LvveRu8Qj0/Hd9EwFYJRTPkjI9AST5LU1tF0VdRhc7x3p
 tTRA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZFblqaaAjg2UVCRA9RInsTrjjyUPOilMkFSIr4xAtS18zak8T2pva1TPbTvRLkwd6fZgVIiFmQtY0@nongnu.org
X-Gm-Message-State: AOJu0Yz2VQXXOYdz0EFvTBInVLgqStcuEG2UJVZw0UleXuUx4hriZguB
 kYDl30qZ4DomNqTEvStYyIyJUN2Bi8oc6/6TCE6Q8G+4b73Yzqsfnsj+Urf41SjmPUw=
X-Gm-Gg: ASbGncsiAipQKGxpKK1TcwzaOScrBcqmSNfqQyUr1I4tiM4MSaQJlYpqlgZsDZ5A/qW
 TO4shAVDaFESV1LEJNbOnyWQBpOW78o6DNrYmFp56TCxzMa8EF07PMrq2tZkaoHY4ja10G+iP0i
 St7YqHcPHNu8bjUEen9aAG7afbKHNSEWbGW1sFoieN7mLM5TKJd0fMnUId6TLtu/5+V2/v1H1WQ
 tpnGZGZ+JCm2Ue9H58R3KsI0+JshkyrHW+0lpbtWQUAjQ2KkjCT7tTiXCzR1qwb5YP7nhSsqryK
 Yu3myWQOmaxqXyBDFyjkwiqnOx5BNemyrGpojR8OatldlxtsznaiU9poyD1GrtF2oJPZk+hqe2f
 weKfAmUo0kjFBmMl62306X3KSgDcTNbFsID2gRtG0tSuVZnTIo5sYoFJmaQPew+nqwY8TvzgT4K
 ifhLnbw3+1TWhqNN5MYUMovsZBlWv1IkgZ69sk+1x2gQwkJRuGxRq9udM=
X-Google-Smtp-Source: AGHT+IG8WnEd3rtSmYijCGk8un9q2hWj+EkrVhAxHMmyi3ZNajwLYrqwT75wz5yMjleeWzji1yqPog==
X-Received: by 2002:a05:600d:8304:b0:456:1a69:94fa with SMTP id
 5b1f17b1804b1-47719a0e688mr5508395e9.13.1761638992731; 
 Tue, 28 Oct 2025 01:09:52 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:404:4d10:9f16:e9b1:dc97:28e6?
 ([2a01:e0a:404:4d10:9f16:e9b1:dc97:28e6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952df682sm18709406f8f.43.2025.10.28.01.09.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Oct 2025 01:09:52 -0700 (PDT)
Message-ID: <9e4ad29e-1dda-4c5b-844c-d950b91b8591@linaro.org>
Date: Tue, 28 Oct 2025 09:09:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] hw/xen: Build only once
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Anthony PERARD <anthony@xenproject.org>, xen-devel@lists.xenproject.org,
 Paul Durrant <paul@xen.org>, Stefano Stabellini <sstabellini@kernel.org>,
 Anton Johansson <anjo@rev.ng>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
References: <20251022140114.72372-1-philmd@linaro.org>
 <20251022140114.72372-4-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20251022140114.72372-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wm1-x32e.google.com
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

On 2025-10-22 16:01, Philippe Mathieu-Daudé wrote:
> Now than hw/xen/ files don't use any target-specific code,
> we can build all file units once, removing the need for the
> xen_specific_ss[] source set.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/xen/meson.build | 22 +++++++++-------------
>   1 file changed, 9 insertions(+), 13 deletions(-)
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


