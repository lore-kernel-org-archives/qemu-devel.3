Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7781C982D2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 21:50:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7K07-0001U3-BF; Thu, 17 Sep 2026 17:50:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x7K04-0001M7-0Z
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 17:50:36 -0400
Received: from mail-pj2-x0f.google.com ([2607:f8b0:4864:39::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x7K01-0002jw-RD
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 17:50:35 -0400
Received: by mail-pj2-x0f.google.com with SMTP id
 98e67ed59e1d1-396ccafb752so116252a91.0
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 14:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789681832; x=1790286632; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=MW/t/GvMSyUXlIM0eIcKq0E57Y4Rnp6duUcMnIYcYWg=;
 b=XEPTJDo8sFWjGkitTtsBZqDM4zyQ2vyNBla0iqmKKpXhTSplrqfPhvBf2TTGVxPfme
 4t5SD71dLNvnIM2SBC9Gtv+FU43lEYmh7bTxzPH2JfkAXW0Quhs6iFhHcL0eChoFIIvL
 0bbKnLoNqHBTHgabECP9xvwUCHU0PlqbircHKRfBLVvQdGcYUT3sQsWLe9qgZcF2RCnT
 W9djjNn9HqFLlhPJcZgqTpccPqgeB5xwmkaeNN+PVwxz6nEYkNGrmziG7rp00tc4xjzO
 /ZqC52LKMXiULye1+FGXcnY8mxMAOMRI7BVlY71Wzh+SF+1nEByRgqBr3UL0MWlan+lV
 5OXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789681832; x=1790286632;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MW/t/GvMSyUXlIM0eIcKq0E57Y4Rnp6duUcMnIYcYWg=;
 b=ioo35ZgAfkL6ejOiwsNmVHM/feSViDJk/LuScA84pOUqxKTf+WhYd2Bubl5aZ3ZTTo
 o0w0W6sdd5Ui0I2KC6Mg1fDqMqz7cidhyGDZzD6RFlFTx0uLoqleBsq72P/gjAPp5Ju2
 kuV9kCVBKMY5BgENcWUSpTk3YYTKpe8YzuQx7Ul5OtclNr0r7D9OFrhh1ZmwH/GoY9pY
 +4S6a4ipVO7foItQUvziBmYgpwhxw0aAUn/Ko2tCEdooGJd7bq1OrSnYZ+6tOFJQ6KKS
 l3sFbZEf8kT2t9SWO/vRjQVNQmdXOMQfrFY5UGl19152hRrlhICGBuvbJf1YQVP7a24v
 nTkQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxTQFkFrjyF70xJC6mEVyXxY0HjFMkXAU/z/Yvondyjz+lXtVz1pOF4w2/4eS/l9HDV+aPwm1Y0wEqE@nongnu.org
X-Gm-Message-State: AFuF++mEscO06YnEo1M1mZtLphQqDOr45Z6lacyql2lcyXKbeBacphrw
 +KjeW3jThVHrGmez//DlGWhPO97v2Ra0AJX72hWx3DwQQiB86twCjoViKRiCb7dTBSY=
X-Gm-Gg: AYBFou15NgsGTfBgPKeqhpX+449JnpHgr/TNwgzZj0a4WsA/7jq9Hvl9HcLdl+uGOfm
 qRz6xXcJXDKU2qPqHbvDDfh2G1G0Y0sqqM/jDHqczIPmhfxe/K7QTjhrom87kRyvaGJL+oz8RIU
 IUorHjxIbiR3dAq5CxUYxkZ8HHTY/jI1eiH2hpommXOqUhwX2Nzp3x6/DOEWxp3XEdNTHkxwUJ0
 6gwFBiYY3SYJdBzfkbtiW2R1BaxKnLUU3ri7vl2H6eahan+PrvybLnoTIlv4YZDEgCSeZ3vRX3P
 p90NnfJO4zolaFGxeudOpQJSdhdNbwzj6OxOm34tU9I/4kFCvjAp0FzYTMQGHhxmqweDqKGTHkX
 CwR0VKVWEmsiGXsVV8qXSdA41aAzxGpzJsR7Aap6bjz5pDZHNhYXOsG5YKCO2IKwONR6gFB3Kj/
 IehBCWxnXvqnMNXuNFYi0LuFQiHvvfL7aqpM2WiG08S31F8DTueCKcFHGLyPbzPBVzVc9uCj0Y/
 DPfEV0aX1Sr5IFVIXunPm6hOzOh4iqjb+1xAU6unOej2/oFbQTT4lGcjAMBnw==
X-Received: by 2002:a17:90b:2243:b0:39d:f773:37b5 with SMTP id
 98e67ed59e1d1-39e549c5057mr1725241a91.0.1789681832285; 
 Thu, 17 Sep 2026 14:50:32 -0700 (PDT)
Received: from ?IPV6:2603:800c:7900:ed00:5a4b:653b:1dce:569f?
 ([2603:800c:7900:ed00:5a4b:653b:1dce:569f])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395d771e5sm15663827c88.15.2026.09.17.14.50.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Sep 2026 14:50:31 -0700 (PDT)
Message-ID: <c008c71b-071e-427d-96c4-7b9024a5cfb0@linaro.org>
Date: Thu, 17 Sep 2026 11:50:29 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/5] Firmware 20260917 patches
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Zhao Liu <zhao1.liu@intel.com>
References: <20260917133318.2004317-1-kraxel@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260917133318.2004317-1-kraxel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x0f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 9/17/26 03:33, Gerd Hoffmann wrote:
> The following changes since commit f8296b816fabd370307cd22b0270b610fc0fa279:
> 
>    Merge tag 'pull-loongarch-20260917' ofhttps://github.com/bibo-mao/qemu into staging (2026-09-16 18:24:08 -1000)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/kraxel/qemu.git tags/firmware-20260917-pull-request
> 
> for you to fetch changes up to a1b96fcde870e49896cddee40459d5feb1f15694:
> 
>    hw/uefi: improve default config security (2026-09-17 13:16:02 +0200)
> 
> ----------------------------------------------------------------
> - igvm: add checks to parameter directive processing
> - hw/uefi: add check to uefi_vars_mm_lock_variable
> - hw/uefi: align default config with upstream edk2

Applied, thanks.

r~

