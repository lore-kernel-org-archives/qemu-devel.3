Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83A24CCD19F
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 23:02:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAyt4-0004Ro-O4; Mon, 20 Oct 2025 19:01:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vAysv-0004Pw-Th
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 19:01:51 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vAysu-0005mx-55
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 19:01:49 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-781db5068b8so3809283b3a.0
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 16:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761001306; x=1761606106; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=orXcDraZF/3k6pWcr3jjGBfGujCZwc4E9sJtg+6bo9M=;
 b=ROyRd2VEnHByqTPUbGQMNn0ENeeTU3kOu9FP/mmTztiiH8bpj/L5vZIm3l6jOHUeoA
 jMrSrKNZHIn0uHPOZTM4TODMTTpYnA1u4olfw49AGQz9YQ/PQg9clEwdX7SCxPWFItiD
 I5W4mFlzuiZPpy63tcJn5zyYT01wjvGsX0gABdDjxBd2cQKI8aqo3dwc+Z/Vm4/s09rz
 pNXxTVEvYx735WfOgKHhOEVTDhALK57A1v33H8uAo1IXAjcDoqbVkmMg9kcgVf4zTdJn
 BSQSxfuTszWlnB77luzlxziYDeRk8/90JCu7HNypZSaW4CZr9opaHDWObJWAFf/YmNwO
 ajoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761001306; x=1761606106;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=orXcDraZF/3k6pWcr3jjGBfGujCZwc4E9sJtg+6bo9M=;
 b=CTSRiBbU8Rq6STnVtl0+tX6AExLTDUcVgl27dnpkC6uqQ/qhleXaajTEh8C2qtmgRe
 CkoFskqaIw+p+F65Gh/QTMywLE0Lewg4ke84PlzDkEiPiUy16p8lyvRdGzBDxlp7Mq++
 Ewhk49HSUUtZ+RJqHMYdtdWbFettQ5OGFEBWH3ARKXcrsl7AKfp+RV38Vj7kh4/eVxZj
 byOabZuP/IaLorK9Ia98Eo3iUirbEuYuKtiHX5h1oNOumMmT1d1xOEaQH6/qpuAuaO/r
 cFkl2mPVc2O+zyro12+l8BpOtBqt+mC1zwxug8K3duBjb62xsYBlJVMg4yGLW1T7tOGn
 eFoA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWK58+UaYGUyzuyGwf2seBr9Mp4imN/qRTGPg2lj9zSt9xTeYjmSmHH9fCsaDGu188SGJItmSUpG0+1@nongnu.org
X-Gm-Message-State: AOJu0YzWJYY7PX1rXxGlGMw9aZ5m3ArtDgGscNwr0aubgX1MM5f16Mgd
 LfqHCd1CQ0sVKgu0fDWfL8ChxtTgI1jKRjxFA1Tv49gt9Rr04ns7Gfu7UERfXFW6ASw=
X-Gm-Gg: ASbGncvQe/MlQlO/r5qmWpQoU1ZZGESNIKnkLtOtA7NVGLaty6L92TJgFBKAK/Zi4j5
 1JgXEQZAJ9l7FLLjUTKtEDmhT5oRlOWGHbbCXoMMwBTQoxLZOdl5GTJaWsytS5m9RKjOUEGvxq7
 KIgoOzVEhFFTOU9deoUVErS26Cg1ZWcQU/xJZwoQqEeWanJro7FW+Tovs5jSK0TSToVXfEgr9JE
 2g5utDJpc9dKM+e7vGxEj3T5JyyRrddwkvZZkOnDVY2plCp3/fChFm2A9MOrP+67bUeuaejcUyM
 Sxc+N/gKNrK/Ha/YkLdtV7voG/+r8AxqF8qjYxWzk1aLA5TKEMUJaHmA+dQ+tCiJYEXEGmRaEfT
 d5iyxS0r+yYJ+PBoZMkW8EKxODK1dXjF/qy787fc5WVgrrG5CS4Xd52qXvVc7+kAocu1Eqgeurg
 4aAErGYHcz4ka4kw==
X-Google-Smtp-Source: AGHT+IEn0zrCLGeWgpkoob4OWu2PzLRihBwEnW7vMx2KhaKwOVaIWcqpSkkhcX2KtzHIGI6h6SzOvQ==
X-Received: by 2002:a05:6a21:3382:b0:334:7eb0:c9fb with SMTP id
 adf61e73a8af0-334a8585cb8mr20128037637.27.1761001305702; 
 Mon, 20 Oct 2025 16:01:45 -0700 (PDT)
Received: from [192.168.1.111] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-33d5deae553sm9163602a91.21.2025.10.20.16.01.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Oct 2025 16:01:45 -0700 (PDT)
Message-ID: <b9f82ef7-c3c8-4a82-bbe6-5592205a80d7@linaro.org>
Date: Mon, 20 Oct 2025 16:01:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/vfio/helpers: Check base architecture at runtime
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Avihai Horon <avihaih@nvidia.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 "Maciej S . Szmigiero" <maciej.szmigiero@oracle.com>,
 Anton Johansson <anjo@rev.ng>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Luc Michel <luc.michel@amd.com>
References: <20251020222315.68963-1-philmd@linaro.org>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20251020222315.68963-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42d.google.com
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

On 2025-10-20 15:23, Philippe Mathieu-Daudé wrote:
> Replace the compile time check of the TARGET_ARM definition
> by a runtime call to target_base_arm().
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> Based-on: <20251020220941.65269-1-philmd@linaro.org>
> ---
>   hw/vfio/helpers.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


