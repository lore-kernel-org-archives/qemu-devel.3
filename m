Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0858EE6452
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 06:51:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sodet-0007Tf-PZ; Thu, 12 Sep 2024 02:50:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1soden-0007T4-VI
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 02:50:23 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sodem-0003FR-C2
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 02:50:21 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-374d29ad870so438073f8f.3
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 23:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726123818; x=1726728618; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nVSUj3R95K8t6PeOD2M0KRTlKOyHX3H5OXK2LQdA+2k=;
 b=D/qHrCJ0mDz/vI0lNkr0UBNEYcFKioijhAqelhIwRnndePfX4hYA8UjRTKlD7aXdNg
 +7IaAG+ihXorvtUByNiBvOuYa3IlF6xYuk55DxeG1uWeiQNpbTe0GE6XbV1rnqeSGOXu
 wX/y16tjxx1f+gxF7bf844d/Pt5cuo/Tp3zSXVCGpPNB1FzwvwUTfdXGYDQlnlZMaio1
 KC9j9H99uLc1hLHdEM3aw0T7AN1t04oFS/LDBR2+AzcPoh8ux4mKEr2xZ/ZjzjDy3FDO
 nS2+VVnsyZC/UfBnNjAo+4sA8NVzVI+CBWscgsyMkIoBmF4lCxnCkGOhfwk4iJ6HFtnN
 M/aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726123818; x=1726728618;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nVSUj3R95K8t6PeOD2M0KRTlKOyHX3H5OXK2LQdA+2k=;
 b=V03OZLdaNUUWG9gRvV9GmxiJpKYukyFqKSSn1JGb83qwWXLAoYOSrh5qJ2vH1jT0Rg
 g+CUnI68+WZsDtP50S+4Fi2uO/HPIntznnV2k4xOt7SPWP/1sJ/C55C1hOqK6Sl9zReI
 2FJsOSXuo6d6pIcHyA3BW/6RjPFEIAm9cuZq1DdFXCOdF4/Iv3LCehdQkRwVaD3OeyXq
 3NNm+ZTq6W0zGB+NZoh1WhPaqL9Lutuc6YMNrsIEzYpA1EkJWmwNS469Bpgv8aursWpX
 T+wQnjfOdFWFNTEJhruJ8o6SZYb6gU5cKXz3VjINRncAPiHOucjbjGbRHDV9ETzJBLZz
 Q2FQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWjAxgpH017N3O9y4RI1PgvrZJOGSpdJhZghclr+tRMDZx4gNtD1utAeiJc2NsYGGeJY5E8OSl5CN3Y@nongnu.org
X-Gm-Message-State: AOJu0YxuxhrXRQgATdZpXqYh4ow620aVf6uoOz5GNgbq8H475hfVoGl+
 SU538iRDcGgr6fPXuSGlM5OTUWJklqdzQeGa5HKLXbHHLEXlqZRGkgum84e5ZF8=
X-Google-Smtp-Source: AGHT+IFFxtwPMaA6TMJqr507XktFFGFxeY1fg+nM8ne9pb01DF+yXPmGXAeedMMy/uvDow5M8godTg==
X-Received: by 2002:a5d:564b:0:b0:375:f59f:221 with SMTP id
 ffacd0b85a97d-378c2cf3c6fmr789944f8f.14.1726123817790; 
 Wed, 11 Sep 2024 23:50:17 -0700 (PDT)
Received: from [192.168.69.100] (mic92-h03-176-184-33-210.dsl.sta.abo.bbox.fr.
 [176.184.33.210]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37895665632sm13346351f8f.37.2024.09.11.23.50.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Sep 2024 23:50:17 -0700 (PDT)
Message-ID: <627641ae-f3f8-46ce-b7a9-64aa6179694e@linaro.org>
Date: Thu, 12 Sep 2024 08:50:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] tmp105: Improvements and fixes
To: Guenter Roeck <linux@roeck-us.net>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
References: <20240906154911.86803-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240906154911.86803-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

On 6/9/24 17:49, Philippe Mathieu-Daudé wrote:
> Respin of Guenter fixes with:
> - Use registerfields API
> - Clear OS bit in WRITE path
> 
> Supersedes: <20240906132912.3826089-1-linux@roeck-us.net>
> 
> Guenter Roeck (2):
>    hw/sensor/tmp105: Coding style fixes
>    hw/sensor/tmp105: Lower 4 bit of limit registers are always 0
> 
> Philippe Mathieu-Daudé (3):
>    hw/sensor/tmp105: Use registerfields API
>    hw/sensor/tmp105: Pass 'oneshot' argument to tmp105_alarm_update()
>    hw/sensor/tmp105: OS (one-shot) bit in config register always returns
>      0

Series queued, thanks!

