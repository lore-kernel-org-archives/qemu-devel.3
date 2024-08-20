Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1053C3DA4A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2024 22:17:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgX9R-0000iy-5c; Tue, 20 Aug 2024 18:16:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sgX9P-0000hd-Iu
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 18:16:27 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sgX9N-0005bU-P9
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 18:16:27 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-7163489149eso4404840a12.1
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2024 15:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724192184; x=1724796984; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=U/Ds9ooX5nwVjJIgllYoSjkfS+kl4IWHxCDPe2z/HYQ=;
 b=NLD/oFYgXJ57mAd0wq9Klg3qcvXrtUN6PvTFLzNfINviTN4gHe6ZLPyG80qaMkrNWB
 oBue5Y+kupQzIjQh1MQSWY/JeLDouyMI/yWK3Nal1qJLHEf+qFkl12wJ1pL52ag+uQ7P
 v8BDiV04b5GWg/FDL5mV1+gwc57EXJlexsH57SB2e4Jlb3A3zqnitE0fY6XvqVj9tppf
 tOl2Dewbj8VvVcm4vKraqoMItY0jjxFS581asPOtODxM2HtsnjgCuk4SvLE/SJQoOPOv
 LhfrrmhF6a17FEef1MGquDfju4uqhBcv8/W/WVG7j4owXC+OZE4g23I5NHyOyEKbIfWK
 NBzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724192184; x=1724796984;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=U/Ds9ooX5nwVjJIgllYoSjkfS+kl4IWHxCDPe2z/HYQ=;
 b=VnmFk+UXJsvnapRQf1DecKmOt7UuAH8Ot+KCInAAwDJ2Rqpf8tPC4pQd4G5lZqwh4Q
 ROSv0it2jOI9xA5JAmKmQWHj0YERF/xBywr4u5hQTGje9a7a9GV3l3E9ggM4ox/yxh5T
 7WitcJG7whu+OdmaJFjr2uod8/Ckzp71iVWBSvKwsVishCcl4YF0Z/a8ujP/elW7dzrY
 L8xW+lJr58d9SvbOqLX4W1vqDBJ9/K7SYWjmbynvf7eSF0nMDnGWoFJnYFjMnozJaGhC
 HqgpYF1JLdNCQuJdVCTlp/kTF9MVl7wr0bxMtHGLwVpgxO3hBRlWtt4DLz9Cjg32cMzn
 G93A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVUOG231TCyFSbjZUH1+oWKQLULYC99WZ8Iz0GCpzg2KIO3kfg1+iK/tVrIm3cd8coWesWPxWj1HOv6@nongnu.org
X-Gm-Message-State: AOJu0YyJW0a/A+6y+tQYtRfQDuLXAWJzP/C3976n3AjcM4YSKVa7qbyg
 3J4Mh0XC9p1oeKXspuTwgH96TMGkNDpeHFtucMKegZisiAqK1HkfmB120v1JiZw=
X-Google-Smtp-Source: AGHT+IEETn/xQRSuEisr1BlJgOcWRzdj0lE1STFjPBbnO4od9be5imR36/yA1peyojWzfNtgm27tDA==
X-Received: by 2002:a17:90a:c68c:b0:2c7:700e:e2b7 with SMTP id
 98e67ed59e1d1-2d5e9fc7db7mr432725a91.39.1724192183569; 
 Tue, 20 Aug 2024 15:16:23 -0700 (PDT)
Received: from [192.168.1.113] ([203.30.3.188])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d5ebba2552sm113539a91.52.2024.08.20.15.16.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Aug 2024 15:16:23 -0700 (PDT)
Message-ID: <327a1abf-6ae0-4df4-b160-6435d3c62512@linaro.org>
Date: Wed, 21 Aug 2024 08:16:16 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.2 v3 0/6] target/sparc: emulate floating point queue
 when raising fp traps -- CORRECTION
To: Carl Hauser <chauser@pullman.com>, qemu-devel@nongnu.org
References: <20240816072311.353234-1-richard.henderson@linaro.org>
 <501c22c3-d8e3-4439-a958-549e9a772ffd@pullman.com>
 <2c1d0942-1428-47a7-bd37-29c16d596761@pullman.com>
 <092fdfde-7305-467c-9131-6f5d2128c58f@linaro.org>
 <aa172755-faf8-4587-a4e8-d1cbfdc139b1@pullman.com>
 <e2aa8b92-4cb1-4fcf-92b7-eadb86893ccf@linaro.org>
 <275021f0-887c-4de8-a86d-ad9abc83df95@pullman.com>
 <6d973ff1-10af-4f1a-be07-501199216b50@linaro.org>
 <24c5b02b-c401-4081-aa46-f745592002ca@pullman.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <24c5b02b-c401-4081-aa46-f745592002ca@pullman.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 8/21/24 02:59, Carl Hauser wrote:
> Do you want me to submit a patch set fixing this or will you?

I will.


r~

