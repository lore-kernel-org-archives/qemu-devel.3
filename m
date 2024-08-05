Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34B61C3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 22:01:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sb5l7-0003WO-Pe; Mon, 05 Aug 2024 18:00:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sb5kj-0003Nd-3z
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 18:00:30 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sb5kh-0006fB-FF
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 18:00:28 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-70d399da0b5so9402008b3a.3
 for <qemu-devel@nongnu.org>; Mon, 05 Aug 2024 15:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722895226; x=1723500026; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NTttE00CmzfFjdscIumMFzaKp8EO2aBOHKD2eCYpcHo=;
 b=TnTqKUORsY8GXIT1Virvbxt7SuzP7VFfCZkw4eCWdSFzz6hyIGyZ/VIYW9Wc/Co/Gc
 bpF0/B3DBkJofmBD0pclJ7Ez6TstkwlL+mYoeB6t59jE2N4ShdGWUsPAjhUI6UqknepZ
 fPbkPeSuHonDRWTgJGzrVZudXzAkzWkj9gDfZCluhe0+NWsCwmWAXbSXnfFX53r4q1cz
 c1cKZ4lEAHY2wF4381q7TBxZOAIn9RLMUvd+Cqmd+BX9aUYinKOCoXLSrAJELQ09pB2G
 o/2XrTIscFcSTGiLKK0qUJ9Jb9Paw+JL8otluhGEiAbzJsfZ+QXMdJsFG2AUjgJF3o3f
 UUIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722895226; x=1723500026;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NTttE00CmzfFjdscIumMFzaKp8EO2aBOHKD2eCYpcHo=;
 b=PM3e7uNm8FnVaGkfsacnB7UBGlZhEoKC9JKUdgLMflEGzFAPQ191pauN3z7ovms1pY
 i9aetpGm5Ytv+pz6tjaN4bh4ZRuDcBIiZL5HQMX6crWpRDBK0WpctNlsK07qO8wAn3v2
 EmcOgoZ/e899jTfOtQArlm11Utpj1VlzVdoFv1AfL1QnDX/K7GwKD61oUJoQ9bhTYHDJ
 CWGqGPXIaAuJcKJrfxxAoOXadmDa4RfCtm0w+Kr8nBsVFyLhZVW+JCQSw0/yXvtG1lbo
 ZqflJGKFfehh6oooQUNQrwAMVkdCPf8/pbP/SUg17Q635OeJKCApncqg3MCkJ2AzrNMu
 ciPg==
X-Gm-Message-State: AOJu0YzLam/TL51YAVuabgqqQdCWHr6ZP5ETKDSHX5rneZQbJwf2FErh
 2i5FzczrcSPsZW3i9N+qjURrMgRjwM1hAjg7PeIeDPAcfao3Oi9xDxINSVvknMY=
X-Google-Smtp-Source: AGHT+IFdTBNm6dFZhmJdwyZ3jcEbCq/blQzqrmppIV3KHoX54VVq4sVWuJvDYO3wU+XoH66TQMu4/w==
X-Received: by 2002:a05:6a00:140b:b0:70e:8dfd:412e with SMTP id
 d2e1a72fcca58-7106cfd9d29mr16369826b3a.18.1722895225596; 
 Mon, 05 Aug 2024 15:00:25 -0700 (PDT)
Received: from [192.168.0.152] ([144.6.121.55])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7106ecdffd9sm5816464b3a.129.2024.08.05.15.00.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Aug 2024 15:00:25 -0700 (PDT)
Message-ID: <aca5616b-0e3d-40d2-ae6d-c7ea631119d2@linaro.org>
Date: Tue, 6 Aug 2024 08:00:20 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/8] Net patches
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20240802031929.44060-1-jasowang@redhat.com>
 <01fe2ff5-d630-4608-9ae1-cce62f290594@linaro.org>
 <CACGkMEtFHxRdxh6ZLJM=C5qok_Xjd5btqHUYpbQQhrqa9+BKJA@mail.gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CACGkMEtFHxRdxh6ZLJM=C5qok_Xjd5btqHUYpbQQhrqa9+BKJA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 8/5/24 12:38, Jason Wang wrote:
> Hi Richard:
> 
> On Fri, Aug 2, 2024 at 5:48 PM Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> On 8/2/24 13:19, Jason Wang wrote:
>>> The following changes since commit 31669121a01a14732f57c49400bc239cf9fd505f:
>>>
>>>     Merge tag 'pull-target-arm-20240801' ofhttps://git.linaro.org/people/pmaydell/qemu-arm into staging (2024-08-02 08:18:37 +1000)
>>>
>>> are available in the Git repository at:
>>>
>>>     https://github.com/jasowang/qemu.git tags/net-pull-request
>>>
>>> for you to fetch changes up to 64f75f57f9d2c8c12ac6d9355fa5d3a2af5879ca:
>>>
>>>     net: Reinstate '-net nic, model=help' output as documented in man page (2024-08-02 11:09:52 +0800)
>>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>>
>>
> 
> I guess it means it has been merged :) ?

Whoops, yes, wrong macro button pushed.  :-)


r~

