Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50526C52D70
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 06:44:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZm1X-00071y-1B; Fri, 02 Aug 2024 02:44:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sZm1V-00070y-Dg
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 02:44:21 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sZm1T-0004oB-OF
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 02:44:21 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1fc587361b6so58553045ad.2
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 23:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1722581058; x=1723185858;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fMukaNkBN1v8nOhOBQhHq9LJXtSLU4mnt5ced46M+4o=;
 b=IRNv9aPUo9LU89T2MkCcrfKIuyabNakd2kr89JsEhhMjfOafLdbdB4wyF/BINC5DBh
 8VM+AhmgnKAT1IEO+GzsFb3gXUHupLvA0aeapcXE+ggXBntxUx825kOhf080Uwf3iU4M
 s2Q88MqQv2hHJgQGd/BQaxQVsbl3f1Xgad5CjpPxM4On+QmJgT/w3khSYsDLTp+hXVRR
 Dlgm4HgPi7ZG/xwMoSyLOhh5/3+6ZvYlnL52SiYKZidGdP5VtNcUXvzTeu7QHfO8aQn8
 kQyOcPokBFB6wiBJ0wZj8RVCwmK4DXecTz7IEFena+25hjhK8wM7OTnaMC6zE/k9OxOp
 C79A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722581058; x=1723185858;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fMukaNkBN1v8nOhOBQhHq9LJXtSLU4mnt5ced46M+4o=;
 b=Zkr/rqPWIQojD8r/TTFn/3oOlK08CfAQ2mK9rqtmT5jUqaVzKH0g8QSxkXKRkDjsDh
 0VIyTKExVkm9HLYZHUc/QH5xhozgoyOxBkdSlc6C53f68Xwy920wvUmHwWHiz+ppC9LN
 ReDfZYxQyHW0KbX1KA+0MdGk0u6DTganOQoH2x5xrpsichUOlrzFsQkR62Oc7YJRWu8/
 9t3/qrWRVBRgkxWFWqW+/lrYKWetWSKedOq3/l5dWiSUUXuunb/r9Mk3bDCHjHcwYUqZ
 1InuLKF8Klm24U9fBe+cVBb1+gBHMK70Pid6bnJB4QJsSaH5M6drxHPo3zbwfXWtSahL
 kpEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXsUy/yIs6Z5COZAjC71a9CpA0plr9ux8UUFjzsEeuzqefycXSIU1fnj7OAyg1bEZi1Yb2FiGzpIpa8oDuKYqbl9ufWWDk=
X-Gm-Message-State: AOJu0YwzZV+PRDLULXBGKG5CEBC9TQZmiVYHXXypWWDV7isrxFt90684
 4JQ8B36Yu4sJRJGpoozjDqSNFf+4HpMnnGlrgUvT2Hj5Q31Cs9D5SCl7nWLEh0U=
X-Google-Smtp-Source: AGHT+IGLvb4WFCo2jk3N7o0FYUK66tKq318mzzsGZ0AfW234azPne231OCHg3yxPUpgvjmlieEI62g==
X-Received: by 2002:a17:902:c40e:b0:1fd:8c42:61ca with SMTP id
 d9443c01a7336-1ff572d9c5fmr31221775ad.25.1722581058280; 
 Thu, 01 Aug 2024 23:44:18 -0700 (PDT)
Received: from [157.82.201.15] ([157.82.201.15])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ff592afe6fsm9552095ad.296.2024.08.01.23.44.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Aug 2024 23:44:17 -0700 (PDT)
Message-ID: <1c98fcd4-0474-4c5f-8f83-ec6b2b6e6c8b@daynix.com>
Date: Fri, 2 Aug 2024 15:44:14 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/6] hvf: arm: Do not advance PC when raising an
 exception
To: Michael Tokarev <mjt@tls.msk.ru>, Peter Maydell
 <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kvm@vger.kernel.org
References: <20240720-pmu-v4-0-2a2b28f6b08f@daynix.com>
 <20240720-pmu-v4-6-2a2b28f6b08f@daynix.com>
 <7bf379b7-eb51-4fe3-a93b-88849a8d1292@tls.msk.ru>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <7bf379b7-eb51-4fe3-a93b-88849a8d1292@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::632;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 2024/08/02 15:41, Michael Tokarev wrote:
> 20.07.2024 12:30, Akihiko Odaki wrote:
>> This is identical with commit 30a1690f2402 ("hvf: arm: Do not advance
>> PC when raising an exception") but for writes instead of reads.
>>
>> Fixes: a2260983c655 ("hvf: arm: Add support for GICv3")
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> 
> Is it -stable material (together with 30a1690f2402) ?

The fixed bugs are trivial, and probably nobody is actually impacted by 
them.

Regards,
Akihiko Odaki

