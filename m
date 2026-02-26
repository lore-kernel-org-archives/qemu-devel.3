Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98AD9FD9E1A
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 22:06:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvjVW-0006hL-G4; Thu, 26 Feb 2026 17:06:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvjVV-0006gs-4L
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 17:06:53 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvjVT-0002gi-LO
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 17:06:52 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-43996323357so724254f8f.0
 for <qemu-devel@nongnu.org>; Thu, 26 Feb 2026 14:06:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772143610; x=1772748410; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xdfSEde8iALo+6fIw/TXT37y9HX0X1tCRIdTmr+Gfn8=;
 b=YCBKbndYcRmw5y7bcAWvuwEfF1/Aexy5LoLm64g83zyuayEjEr3h+XgkLaE5jAAerm
 XRaEfb2aW1AkNAgmxGmMCmAqKVhJzim7Bxo2H0ipJoppOfJBZ9MFuvavxlxMGDZvgEWk
 mHfMipasZ+Pc5N6SA64v34W8T2S4RnDJLWAZrVDdR6UphgyjMfeZJz48H5HAdVzucFi3
 NI0fbtwPE8fgADcdayZ0cGq1Qvefwavlh/1yGuOjRvTQocG62ckqxm1I/jdBxjdC5gTW
 btXyDCe6liK7TuKwSeooLPQMkWFojygkdcLhKCE+8/GpYPtyCllDUQBWkFb6UnnHzLVL
 BkxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772143610; x=1772748410;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xdfSEde8iALo+6fIw/TXT37y9HX0X1tCRIdTmr+Gfn8=;
 b=G4xxnBkYNxZgeSfkdCO3C5Mkm9rfbl936H9ucue+oI8ebQtUbtBYb3OtwpzZ70c4xh
 Hzlf9DxFLo1PlXxnGMa+E17XWVIcPJShMd9BroFQWzq+ptjeZascFHivhk17sHQQPrdT
 HhYJOiC1TdxuESWaSTpUnsYXiMFhcFIleG3Yvit6huxTlHexDK4j1A3T4kgaLIo3QgBL
 uK3MnDddN4llPapxKNw5pWLEvwImiJ+osBNHhokT83ZhCn41EMoOw3+57++THeooLK+r
 ashMxQAVIzIR0tzN43Dl8b8kkz248S8hIaXtdFTRskt/qb3bwoR5cKLYmLj36ULDyhi1
 plUw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRhEiGXjPI2Z6z8nzsYZ2hx1lZxf1pePr/xt6KXrACm8/dOtm0hlnqTUCbkK2l+0kKAypX0eAb5xPS@nongnu.org
X-Gm-Message-State: AOJu0YwHYi0qJxOzwUqFJTrwgdV8FjvUH1GFEf10Ki1p2o/2QFt6OL6S
 2V1gr3yNYAchqDgilWARiAq5jWG96bRugWNpaLZEwBvbZYAX9S+c6zvS1xT8rAtW6pQ=
X-Gm-Gg: ATEYQzxaUMgpKxulWBYTu1zRUhery3zf9RvL+JRUAQbKyctzOI1KSAjz3yITaa98YdK
 Xf0YKEiDW/4qEiSNvFl6j7dcgbRzBxbiUgEVc5MmfKpWE5PLzA7vU4thWw+RvdmCibiG3ZeF3nO
 4/WNy8loNoPVlzaggkiWEQ/KtUZ83QA7FyZbFnbIOhoIhBhgW6BnM92JpNiw4/JO9QfeqXaoAtr
 VHhC7mUgZn4l+xIeOEelp5wD2RxVhqeBJ541pe0FqW90QtStjAeEeo34KRLXPxq3bpYBp0CWQ7X
 ybGfl0XmHq6L7swWjF6xI8M3s2jweb0DXI7CJpDDxh+hdV/A5XXWk6F1wX3sDCSnmNaXrVCfLCS
 lB5YqHIFi1ELSmFBlpgKWshuqSatgoF7O3LVr6gwXj2/JLhAWjqQBvkMEKj/VwT5QWcQfsZ3vij
 GqJG8jXGh9ujCPm6k1gq+de+VSbLO/4Vmr8M6HTIUXpzqODNPXimgCAHtihLKO80VCFA==
X-Received: by 2002:a5d:5f49:0:b0:436:2fdf:b599 with SMTP id
 ffacd0b85a97d-4399ddff7d8mr780885f8f.21.1772143609980; 
 Thu, 26 Feb 2026 14:06:49 -0800 (PST)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4399c76c49fsm2306264f8f.38.2026.02.26.14.06.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Feb 2026 14:06:49 -0800 (PST)
Message-ID: <93bab2b5-7a2c-49d8-8b09-d46ff02770c2@linaro.org>
Date: Thu, 26 Feb 2026 23:06:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] Remove deprecated qemu-system-microblazeel from
 the build
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Eric Blake <eblake@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Eduardo Habkost <eduardo@habkost.net>, Markus Armbruster
 <armbru@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20260226084608.11251-1-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260226084608.11251-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

On 26/2/26 09:46, Thomas Huth wrote:

> Thomas Huth (4):
>    tests/functional: Remove the microblazeel test
>    tests/qtest: Remove the microblazeel target from the qtests
>    gitlab-ci: Remove the microblazeel target from the CI jobs
>    Remove the qemu-system-microblazeel target from the build

Series:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

