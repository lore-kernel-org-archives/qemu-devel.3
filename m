Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C709D149EB
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 20:06:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4QZv-0000QO-6K; Fri, 25 Oct 2024 16:06:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t4QZu-0000QA-6C
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 16:06:34 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t4QZs-0000sQ-Jv
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 16:06:33 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-7ea7ad1e01fso1678872a12.0
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2024 13:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729886791; x=1730491591; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pIKYZUzW1L+q+b/vorULHWOqRkh3GiyPYwFOYIvWg80=;
 b=azWoMuJIauPz96caNc3/rpu2R67BAW/tXisBsrqrH8jG+hnlvCi9D/vBulSc+yzQK8
 pXw57RgWGhpyJfUMQRdwrORkiGWZyT2XAuXxOSa2vV8yZz32mKojREvq5ZiP9dYZDBFJ
 DfHQZyZ6c8kOsvwikzvAzrOLnhTt9bkKRDygt8B6T2EoLzdqn0atZq+ZIlvsK0XCZFwn
 RomeELxnU01ZP+551uwOwAgFgfAzH8gtItCywMylSjxBigBfcxera9m+qB8ajyF9LUwS
 +w9UMlPd4Qz5HI0BoIbQe9ppkcmcEJ46/wyeD19ghu4VCWIfnsZtA+EmapC6Haus4pye
 Kudw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729886791; x=1730491591;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pIKYZUzW1L+q+b/vorULHWOqRkh3GiyPYwFOYIvWg80=;
 b=nhlpB3Vh3LeHyTQivvyvrYKcHpX3zlCcR6uqWgfglc3rSqn1cHIhGvmQ1FZfTqqPmj
 /wHIEyX09/dnOKyUZsK/Vtggz0ZKz9hXEWFk/3grQUH2AbCrfLwLJJcgkVXoan3rKQ7b
 q49f7Y8Jndp/8gmyOIibWrF/Gp4s3bg4AZhv/YXAerqS64JMmFM2cVGpoFKDriARixxD
 X5tUWzucABknAyA87ELHbv+XGXXAYs5IkwMP3zoJ7dwnUasJrLitoB90p4pJky0EYiW3
 1QjyaH53GjlEZ2JBuHEf8IfIY4wYWvEJ4iDiSlKXsorO3EXSGrEuHxzX7sE2YnJ1DWXu
 V3YA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmq1bjHYoxrQjrg+qgzONCrDzzbGIwjWLDhNyHSaejHn/edRQONKI+VWNmH7GlqpOZy8DKvXIfLu1J@nongnu.org
X-Gm-Message-State: AOJu0YxcUcJodbYutspcw/Q129RigUE+1moq+5ZvNIptAdUMZ/lmjsj6
 AsKa46v1fkSGJi4Za6t0GLcc206YtxpUcz/ve2RcZeYlN/NafzUtU3n3v08r6iE=
X-Google-Smtp-Source: AGHT+IFuB4PWvYlDzajCWvAP45TJTNsShSMW63XyeS/3UKd4POpnuQqs1w0Bm84BZKGPiLMqDkenZQ==
X-Received: by 2002:a05:6a21:4d8b:b0:1d9:651:7d34 with SMTP id
 adf61e73a8af0-1d9a754598bmr1007558637.12.1729886790761; 
 Fri, 25 Oct 2024 13:06:30 -0700 (PDT)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72057921619sm1469546b3a.4.2024.10.25.13.06.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Oct 2024 13:06:30 -0700 (PDT)
Message-ID: <3a0a5685-8c8b-46ad-8933-0fff8715f47d@linaro.org>
Date: Fri, 25 Oct 2024 13:06:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 19/23] rust: do not use --generate-cstr
Content-Language: en-US
To: Michael Tokarev <mjt@tls.msk.ru>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org
Cc: manos.pitsidianakis@linaro.org, zhao1.liu@intel.com,
 junjie.mao@hotmail.com, berrange@redhat.com
References: <20241025160209.194307-1-pbonzini@redhat.com>
 <20241025160209.194307-20-pbonzini@redhat.com>
 <b86de87b-99f3-4fce-9a33-3580d37d90dc@tls.msk.ru>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <b86de87b-99f3-4fce-9a33-3580d37d90dc@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x531.google.com
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

On 10/25/24 13:03, Michael Tokarev wrote:
> 25.10.2024 19:02, Paolo Bonzini wrote:
>> --generate-cstr is a good idea and generally the right thing to do,
>> but it is not available in Debian 12 and Ubuntu 22.04.  Work around
>> the absence.
> 
> Can't we just install a more recent bindgen and use all the current
> features of it, like it's done in patch 22 for ubuntu?
> 

Users yes, but distros expect to be able to use their packaged version.

> /mjt
> 

