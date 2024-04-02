Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0690C6FD1F
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Apr 2024 10:54:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrbmJ-00072S-Ae; Tue, 02 Apr 2024 06:54:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rrbmA-0006qZ-H9
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 06:53:58 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rrbm4-0004HO-LO
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 06:53:58 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-415a84ea9bbso7517685e9.2
 for <qemu-devel@nongnu.org>; Tue, 02 Apr 2024 03:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712055231; x=1712660031; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LMjebou22YePxG8vD1+pbKqTTKwxSEnlcF2+ICOziOY=;
 b=chv96NcqgXNAEIj7AVAOFaW5XUuz+MUuMb+Gmb1NVw7juUaeYab6WNLpBAnb++PgFE
 VSym5xP6n8EBfvSaPFOscQami0CQGEa1d3YG2SnB5KkfANNId7tIr7sD0eVcbzDwitfL
 7bPS7SfEd+oVjIh6cS3L719WXMyOpcCLK9gF5kw0YeYzYtG5/Bw+qWG7mHLU+yzOgBsI
 3swBjyyXfVPD0vKZc25vuIbZLUY3wJC72ulckkM11IWQQQtK6tVFc9PmleWAgEC+iI3s
 FBo2hCpGwtW0FtnAPeuwzN2azOZQkcgam931PRtI7/R/zN3Hh8eTS6emj3IRkg6Ic5R7
 1tkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712055231; x=1712660031;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LMjebou22YePxG8vD1+pbKqTTKwxSEnlcF2+ICOziOY=;
 b=TIArPYz1/zz7VKSH6ue7xMMfENQT5+8nJ5EPoSDM+z/hGT+R78G3NFYrYWODnCmzmv
 +bVwlktk0O7XUl2LJIiVebNUWSvxBS1z7dG6bh/8zHOP7PxAR72QO9G9XMH8jsktlcwl
 gzSVNMlPmyjOShVFsowRZtmKmsK9VXAnukNd3H0haGp8YnUTDn2Cc94BuH1ePVPHjvy+
 dtks+LvYigSHTh5EvVFV+oYQLVR4BLbwyTr9F1QP9PuzXDAm+yih/8mhqVbQeMCWsSV5
 AVwD8bHgRAOCSdkmLgqa5HWeQJHzeLizJW5pAvuUf3r03BAYOEuLV9QSGCGUYlz/AsBH
 mmag==
X-Gm-Message-State: AOJu0YxYCDbhqDCj0SCW+GbRA9O4IqON2xUN7xgZ329nXfWC3PWYDWWO
 CggIvo2nySa0OVKdoSbKlGkin/7vMzJDK68/mIQEOSmb3DXiagnpxFo4wcbNPhE=
X-Google-Smtp-Source: AGHT+IHJGohRtWeTkzi/16+ApMb4IByjRIOm3jSyZjSE+r3LY86LU+HJd9FBGm4Dt6edGu0CL54LFw==
X-Received: by 2002:a7b:cc16:0:b0:415:c6e8:9206 with SMTP id
 f22-20020a7bcc16000000b00415c6e89206mr1112407wmh.34.1712055231350; 
 Tue, 02 Apr 2024 03:53:51 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.202.91])
 by smtp.gmail.com with ESMTPSA id
 w7-20020a05600c474700b004156cd7991bsm3658693wmo.11.2024.04.02.03.53.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Apr 2024 03:53:50 -0700 (PDT)
Message-ID: <99c02a9f-bd8d-40ee-b483-48f13028eae3@linaro.org>
Date: Tue, 2 Apr 2024 12:53:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gpio/pca955x: Update maintainer email address
To: Glenn Miles <milesg@linux.vnet.ibm.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Glenn Miles <milesg@linux.ibm.com>
References: <20240328194914.2145709-1-milesg@linux.vnet.ibm.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240328194914.2145709-1-milesg@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 28/3/24 20:49, Glenn Miles wrote:
> It was noticed that my linux.vnet.ibm.com address does not
> always work so dropping the vnet to see if that works better.
> 
> Signed-off-by: Glenn Miles <milesg@linux.ibm.com>
> ---
>   MAINTAINERS | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Patch queued, thanks!


