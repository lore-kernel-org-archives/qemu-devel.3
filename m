Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C673CDB471
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 16:54:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wc4Nk-0007nx-R4; Tue, 23 Jun 2026 12:53:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wc4Ng-0007nP-P8
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 12:53:48 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wc4Nf-0000IY-7K
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 12:53:48 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-8453f568e84so173104b3a.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 09:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782233625; x=1782838425; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ti5xMooiKqHlznKvfnxEqeJBoY9S2PXvVydb/VcNtuM=;
 b=pcb0EjKQtkPz8xwE9OXE98OPbgLRbm49dPNho75hkpQ6SCjmMyHZYPucjRZgKIVNRK
 dti3CIB+ZJMxao5B/OjWZutxg9ccFhwB4wHV1us6sqL9SAAV7p3cbp2IljjDPu/+rwd8
 tJef1I0EUwKN2fvtpzKIG8pXN0uKeerlcLcPy+woHi8a6SLXNXIjnWzolYWLp1C7xsRD
 qafJ0kI99zW7/GFBvMq3SLheWcJj6HURbws1UbmKwj5g78PZSy6qclEWX3GW5lsU/i3G
 baqdNYuPgnMjf2mrTvhIEwNg+UuaVoBKRVMhdZM+uj8/XInteHJGtZ7OpJIJZ5SYnwZ0
 yXNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782233625; x=1782838425;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ti5xMooiKqHlznKvfnxEqeJBoY9S2PXvVydb/VcNtuM=;
 b=kDfycQtzNJYzHjhIzF/t8s5qL96xAYAG54uQRLsxiokfW0GaamBdnD1HuZqu2AM29T
 A1Omr//N/AObKJsezP+huuimkml3rsccs1UHViF3T/adHCxv0Nn6EFaSyuSUsKh/QjOi
 B3FTJ7gaVc12IzxRdh6oBfTCfWOQWIgH1EL9IlmHAwxBCz+a9IuxDJ28/yOqbvMhiPSJ
 mJIhqHIyBi008TYffIG/zo5Q4Z0Yzouzp8Il5+P20E+wR9JbMgrjbCYaGx6EODZgUPBR
 4J1DjGfmZ1bbH9X3xz2xRtJJrlwGBtMwjsinhKJh2uVxJUZ+gBsD/SSSl4+wKs4d72cE
 vtfg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8Herpcji9rCUl+tLbQLg0+eFkaEL58rUaGTWKIo1p8/tO4yTChMoHhaBh7XiZ9qAB6hItLI/N729JP@nongnu.org
X-Gm-Message-State: AOJu0YztXmruKx5DIMfL4U3LeIcEMA20bnzeMogSWug2JU2qYKRUjSOt
 4wz9g8s6UFWoUspC1NcOXWscd+KjrWpEGbAbIETaMW1nlQ1zgMbEWvTq3zCXNIRlXSQ=
X-Gm-Gg: AfdE7ckZOaNfiUM81nuL1n/bNDQ+VdZvTV44s0DZCZc+73WkMFxmYqAXO8tpVoGUk4m
 2zO7ZVAoIzU2F3JytGC/ZG5po8iNaegibyTt07WjNg7mONxZWKPum1Cs7hmTit9C9GNt5Pavz72
 on9ZkDL4+w1puuqeNJZkeWNqhUeNeFtvWzDkRYJIvBuYXTXLtBGdAXg2zGjCDcxjpibQvS3nAzL
 yCw9PjTUGyyfJLbjax8ZnfX73mHvnDAhjCvgHguOn4STPo8vaFaMNSldz5eQMAVvRkAX/nqEdkx
 JfCQsgP0HgNXx0l+au4hgthM5gcXVsRuskSPdN7sY16PPEtZm7BZd3Rz8vLC0D/E/hfsJWqSZiM
 eLUIwimoGUTjkPen7rm48/rWQz4J8uGjX6busB5cskw24sIuVuL6wp5LhWrucV8uVOHtCQjkVY/
 XPbJ4O8W6XjrdE2EwxSLPYYDU49T6xfjCcdIrhMQnmkE0rw6yGCSHHcxSPYhBuLDZSKFIB
X-Received: by 2002:a05:6a00:1388:b0:845:4fec:3f8f with SMTP id
 d2e1a72fcca58-845952fa7ecmr4482242b3a.40.1782233624959; 
 Tue, 23 Jun 2026 09:53:44 -0700 (PDT)
Received: from [192.168.0.4] (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84564ee3dc2sm10794698b3a.58.2026.06.23.09.53.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jun 2026 09:53:44 -0700 (PDT)
Message-ID: <a2891cc9-4591-4898-b0c6-b15170b815ee@linaro.org>
Date: Tue, 23 Jun 2026 09:53:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] build: Use meson b_sanitize option for sanitizers
To: Nabih Estefan <nabihestefan@google.com>, pbonzini@redhat.com
Cc: alex.bennee@linaro.org, laurent@vivier.eu, deller@gmx.de,
 pierrick.bouvier@oss.qualcomm.com, marcandre.lureau@redhat.com,
 berrange@redhat.com, philmd@mailo.com, zhao1.liu@intel.com,
 qemu-devel@nongnu.org
References: <20260623154659.3137518-1-nabihestefan@google.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260623154659.3137518-1-nabihestefan@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

On 6/23/26 08:46, Nabih Estefan wrote:
> +# gen-vdso doesn't play well with sanitizers. It originally didn't get them due
> +# to the way we passed sanitizer flags. Now that they're being passed through
> +# meson wen need to override it.

Details?  It's not an especially complicated program...


r~

