Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EBF5C3DA7F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2024 14:19:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sebJQ-0001wm-Nf; Thu, 15 Aug 2024 10:18:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sebJP-0001rI-Al
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 10:18:47 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sebJN-0003VP-IX
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 10:18:47 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5b8c2a6117aso504114a12.0
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2024 07:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723731524; x=1724336324; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5ktXRN3L6nhgf7kfoPz50UQErPBwCIwP3ToUUpy4xxA=;
 b=yuBEKnf+eC9XAzxgdGvo0EGaxsRd1N8w6ffMTo1ao/Q+MtiffagY5pje41xPD/1qY3
 BHUPYTERhWP0aRvuuuBzh9FhkcnFyDdEJFWKqQQnriOhZ3fiHfnmMEDqRt/0HtR4gFy+
 V+WPG2bilPl8euyCN9OdY4m/3+C/bGmV0bpHu70HZzvYfYPIJ04j4J3LMA+Z/5tbXyfa
 u94YCLc+rrM8lmWbgpjgBtB0qhm34GPlmd0Wwa4+zkeG8VybmSkY77b8S/He/iOSq+s8
 jsmYTfSoEUqGOKJ6VpRhGCiFtc33xB32YyCMsdeQTvRv7ACeg/yPPfr7+b7g212YpJnN
 5Pnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723731524; x=1724336324;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5ktXRN3L6nhgf7kfoPz50UQErPBwCIwP3ToUUpy4xxA=;
 b=AW5EuSEIFDJcQdo3f9yxm/wW3mZXHnBeyh/aXBaP+0iPtWBqXnBrd/Z4dey8qSN/Ng
 X0JNgjIxlqtZD3sTFE+ZbYpuo1UETcFRaw3cgfH23EwPL5Hh/j9HUb1MnuP4oKbRtWTu
 yL3BsVTNqrfpqe0aAxJpnWsssOhiHqjZJwF+9t8Engmq/FBuWsXFLAakNteobBsiUzyE
 CUlZXjeeTiha7E8zy50tUAuI/RNwso1yWTmLT76iljTe9A3vgZjrb+IyuCehRWSSaxM2
 bqM09abZLbY+i5SL8mOF2Xj9aMGiMYv67sL8f2QoybUI0HuPUHWlBal5KEA+bEtJWIiu
 zP9g==
X-Gm-Message-State: AOJu0Yyl+gf6QKdl3tDzLLbfa4QTKud0jr5dZsi119CJlhY5KFBGgkvv
 0iNK75pnUjiKGY4S/t0Q0U+SS+vutOHGum4TqKPTH2Ex2GunK25lsZ1+5puizv0=
X-Google-Smtp-Source: AGHT+IE3hhTpmXk/+f2CzROVsAphMTFlFZo1QnHeai9/9RDcGOPxQVhnmNd7RSlIvqhLiUimmEdzVg==
X-Received: by 2002:a05:6402:50c6:b0:5a2:65cb:7335 with SMTP id
 4fb4d7f45d1cf-5bea1c7ce61mr5657509a12.19.1723731523493; 
 Thu, 15 Aug 2024 07:18:43 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.202.43])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5bebbbe2a02sm943169a12.18.2024.08.15.07.18.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Aug 2024 07:18:43 -0700 (PDT)
Message-ID: <b5587a20-d2ad-4dfa-aba5-0154ebe8c61d@linaro.org>
Date: Thu, 15 Aug 2024 16:18:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Removing python/qemu/qmp
To: John Snow <jsnow@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <CAFn=p-ZJZ1BScebJtgGmFBwV4n2Yhyha6WFAmVe9_T2c4ML7Dw@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFn=p-ZJZ1BScebJtgGmFBwV4n2Yhyha6WFAmVe9_T2c4ML7Dw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x533.google.com
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

On 15/8/24 15:58, John Snow wrote:
> Hi Paolo,
> 
> Let's discuss finally dropping the qemu.qmp lib out of qemu.git in favor 
> of using the standalone package at 
> https://gitlab.com/qemu-project/python-qemu-qmp/ 
> <https://gitlab.com/qemu-project/python-qemu-qmp/>


> Thoughts? Lets schedule a call to discuss if we can. (Anyone else 
> interested can join if they want.)

Next community call is next week on Tuesday 20, 2pm UTC.
(https://meet.jit.si/kvmcallmeeting)

