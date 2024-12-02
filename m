Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3E3BD7832F
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 16:00:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI8py-0005Ve-RM; Mon, 02 Dec 2024 10:59:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tI8px-0005VQ-6X
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 10:59:49 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tI8pv-0007zj-Lz
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 10:59:48 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-385e35912f1so1840031f8f.3
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 07:59:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733155186; x=1733759986; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rQMiE8O0P6rRP4Job7Sirgdtnr3QXw+GiQuNRYlcJhc=;
 b=nOF/WQ77B7j8gVblXovKYPTlzY8aiIIjJ6eS14vMG81Te8dcXuYruSC776YdVQvji2
 97asA8lAq31S/QEk5G/LjQGWRX944gdV7SHD+pv47XzavgWpbOXYzVMe8U7Zi3PaUDXp
 atdBiDz66fovfeds3BlfReBoFsKU6qmJl++wEuGAI/6Xy6ipACxfo5uBZFSlWMNNjm9u
 WH7KaXt8jOMCLdjtSb96JzQtR7WteQc4cEEK4m5YyMKD1PMzdWxddxBl0RnEnENFKJcq
 b5rd5hHxoP8qCEK4HHxc/zxqQUMKjaAt7TlFqPmDF9Id83MPwLV9MKLKKwUMdtJsz09G
 9ADQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733155186; x=1733759986;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rQMiE8O0P6rRP4Job7Sirgdtnr3QXw+GiQuNRYlcJhc=;
 b=NLTRV70uPdqD+cST/815UHHt5Ouqm5DXrTUswx5fJo3+ufDr+AiBuPwC1yqFCNqEvp
 CXfd4BdAUtXaQilKZh3V4GXrNKkofja7+9ZZGW3Kjw3c1X4MBPGZwc47cnd7AygJoTEr
 umjwNwFEfAkuoIg+oI/EQZQvMPTRHO2ufPY/UIQyYZp2FBD4aqXxHMGRi+Qee8RBgUbC
 QpKb4WsH6iHyvDqB1WDvCAPZzFpI2yCCeLrugitNaHuCpAxewOsRuCKHA90+fTuAENVL
 ecbRfkDMSPlHsPgO6FeCKjJ3IoQzqPJfGQDbIlcqymppPpSD2zCtqmddWjbEpE6x2/fu
 WHqA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUM4ExXnxQk0hfSdyNB4nYb2iwMc7TD8dAY+D/0/hSdf5DL5Ff22Z51fMzxh8sCD2vaOFwWo1Bc6BrT@nongnu.org
X-Gm-Message-State: AOJu0YwsuUSJyRlqJhEkQWd97GadYZe9TJyY4hvxtlK/HY/e9RCNh9VD
 WpsTjh2IHu+Z084L7eanaUVO8w2ccAMFnJscGA42yCBTPLozhQ0wN3DiRE7Ifhg=
X-Gm-Gg: ASbGncud2+JeFmbbYqzGb+0jyeetSTWNZMwvcAkpGQqJCW4K6EqKVDkV5cdQV1jd9lf
 Q0IqbQMSJ/5sZ6+Ze60WLvN/ZSAx+Bnc8Vj/gjRSFXEJUu62200k/4yZVYccRHvD17pKJdf/6R5
 GzLkbV1sKnSxfQg6sdeI4LCx8qloNAITdQSILLG2/MGaqo+e4tKJYL3oma+PaZafTakaCdIlPZM
 nU54Fhy9qFsP6H75tyuT4/IsF2vyDH0fr5g8wI7LBqAIv2bUiDwkCkddvMZZfnoIZ+NOvPmLnVm
 XzPTtVa9DTNLYlaGXcfsKWcE4noypA==
X-Google-Smtp-Source: AGHT+IHa9mBRBHdEd/83uN+mpDjqOj274RqeD/ugPZI72S5AFLtF+uPd9klrVmTKG7pXh9ilLJ3paA==
X-Received: by 2002:a05:6000:1acc:b0:382:4cc3:7def with SMTP id
 ffacd0b85a97d-385c6eb6eb1mr19119367f8f.7.1733155185819; 
 Mon, 02 Dec 2024 07:59:45 -0800 (PST)
Received: from [192.168.68.213] (72.red-95-127-54.dynamicip.rima-tde.net.
 [95.127.54.72]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385e940fef3sm6501783f8f.42.2024.12.02.07.59.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Dec 2024 07:59:45 -0800 (PST)
Message-ID: <21367b78-f88d-4ead-9ed5-62ee5d82f9ae@linaro.org>
Date: Mon, 2 Dec 2024 16:59:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] clock: treat outputs and inputs the same in
 NamedClockList
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20241129180326.722436-1-pbonzini@redhat.com>
 <20241129180326.722436-3-pbonzini@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241129180326.722436-3-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

On 29/11/24 19:03, Paolo Bonzini wrote:
> Leave around a reference not just for inputs but also for outputs.
> This is a better choice because in principle the monitor could walk
> the NamedClockList after the clocks have been unparented (which would
> free them) and before qdev_finalize_clocklist().
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   hw/core/qdev-clock.c | 10 +---------
>   1 file changed, 1 insertion(+), 9 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


