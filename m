Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE8A5C83013
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 06:57:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWrOj-0006aL-Fh; Wed, 02 Jul 2025 02:56:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWrOa-0006XX-0k
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 02:56:40 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWrOS-00080N-Od
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 02:56:39 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3a525eee2e3so4070123f8f.2
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 23:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751439388; x=1752044188; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=T4Zx99QimOI7p4Z9U8ZK+dMGdmMSE7DeJaCAtdtwvqI=;
 b=P5UMeaxONr9XuKDT8NE+7Ek8xfWMUy5ko9n/lZx6To/gBCdH3WPp86ojflgoQtre15
 RUJVRLTWQEp7O5NS9iR9JGL70048AnPpce+wglUTzFMaR3uzeXdotQZ7+eOh7C0IYQfA
 NBzjfT+6WXbAysitBcikiog9Yl7Z9DNZn6kstAdkijqpuAm5umjqWekjhIKeVhJwI5sM
 nZNCs8wamnpUoAWOX0IOllYtXhVdwthDZ6iM34pzwEwPWxV6HHL2NEJihqIksV7zzXkH
 giU9K10LYrlqRQqw/dP/Nxp7TJUmQIeR6vYoBfWXpaF1nh/RLzr0hCEwv6vOQPHd39ds
 x3+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751439388; x=1752044188;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=T4Zx99QimOI7p4Z9U8ZK+dMGdmMSE7DeJaCAtdtwvqI=;
 b=YWoILfcVMt/gyXHT7Ku1XlkKHt9u2cEzMVCs9ZbU7VTazCBfr+LZC6iv1NST6e0tyZ
 RFRF2mwauWJ03fQnV60b6wK30sIF3y8mgz4c1deb0FrIJQibh/C0YYh61HOfWQZtta3l
 3GHeH1ZyAhpIgckyT7bVnqGaeZGDvdmJqmc7CWQ8bqES0jS4E69qbOrvtaPXEbCJiKu4
 +M6m3hYqGV2eOBY6IKTMEC7E6giZEseTTgqB4Yw6zagbA9lDaGubUH5FUf16lEX99K0e
 xTcViD1ndKAVd3pOUXUkUCX9JqgSBfEgb9OFPTDJ1HTwj5HxjN9bh82ZL9YXXbj3Klsq
 SPJg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVp5CjUtL7QmngXWdamE+DXyB++WGAiFCL18vRks8tkYv0HP5mdwmYdvItFNVgrPslkDKFQgjQYCSXR@nongnu.org
X-Gm-Message-State: AOJu0YyzHSZPJICjby06hFJK2EUT8BvNLu/mEpyfjv8hCQuGCyLSiMrF
 JmEvRgemNI/h35oykDXVZIiCK0hDfrUYU/rHCdb9h2KjsaM8LcVpliEe5u4cZUiKV+U=
X-Gm-Gg: ASbGncu/CyxyXIOdX+CynZFNyfpENqZBcDE5z5pnomoMwrg+SHENXxZWZYHnGzLMdJk
 6VOXNCYgdorj29Z3nanOzGADLvrLMD6wf0zJs0uLBwnrPsQUunaSD45pd4ayRW5LIqn0y9cD7Zo
 MqTuOxPQRlobwB52XSpO9j34NL9QolvkLNImnacFK+aqd2Z/OCMkYA9a+u2ZDaTS4tpDUuYMqtA
 QAjXJ8MaDFNzdz5T8IWX+/sqmzUDekVwZgNqYplpNzOFyhQKcdYdV92JhGErL11dp/piOurdTyX
 yEyhj89ZAVEtq+7DQRNCpvs8MsR8JhVypVadGkpDW/LQQB2UmkEw5eS4dEN3ORLcyf7yyHTPhMY
 mlr+EIl2eFPHmWv4NKH50k8r5qXDyU68kZwtiBtDy
X-Google-Smtp-Source: AGHT+IH9mHv/pAjAEq2jTAyW3orjWeuq5PFCCn8HfbkS66hGKT2OrCmPaVT5k1viUX1/SIqNxONLmw==
X-Received: by 2002:a05:6000:25e3:b0:3a6:d403:6e75 with SMTP id
 ffacd0b85a97d-3b1fdc209b5mr868713f8f.4.1751439387821; 
 Tue, 01 Jul 2025 23:56:27 -0700 (PDT)
Received: from [192.168.69.166] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a88c7fa54dsm15002743f8f.23.2025.07.01.23.56.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Jul 2025 23:56:26 -0700 (PDT)
Message-ID: <46cd8b91-72e3-4031-b7d0-857b53ee9c9a@linaro.org>
Date: Wed, 2 Jul 2025 08:56:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/s390x: A fix for the trouble with tribles
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org, David Hildenbrand <david@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, Michael Mueller <mimu@linux.ibm.com>
References: <20250701194241.434183-1-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250701194241.434183-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 1/7/25 21:42, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> While Tribbles are cute, it should be "triple store" here,
> not "trible store".
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   target/s390x/cpu_features_def.h.inc | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

:)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


