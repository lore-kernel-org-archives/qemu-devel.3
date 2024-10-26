Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32920D10BE3
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2024 04:55:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4Yoe-00057b-50; Sat, 26 Oct 2024 00:54:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t4Yoa-00057Q-Md
 for qemu-devel@nongnu.org; Sat, 26 Oct 2024 00:54:16 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t4YoZ-0002pD-8T
 for qemu-devel@nongnu.org; Sat, 26 Oct 2024 00:54:16 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-20c9978a221so27420785ad.1
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2024 21:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729918453; x=1730523253; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=u37XwggRM+b99ha/2NST/UfXKdx0coEheXY0HIKdL+8=;
 b=YI7J1fKsryWRGpqUqfMTzpGUTJiayzDrv5eLLk+TJepzyNDfBK9s3KGBUtyFzQBEzv
 pg7eRUPLN4kzmjdKY7oQsWEOxf3CIv0QJbr6fxrSyB+ftGRerH4CdCl+h/m2CnSP8knQ
 LXp67sNfk8iiN22I6zwib6YQvCaxncIqBIHjPGqp3ixO0C7ugxh8XgK8BdFoeRn5lABF
 HVzOJ7Vj2mu++CNlQ+MwRZjG++v+osW/juANO9aKjaMKbw2xx9HXb3yuyD7ywMuy/UB8
 dfEsQ0KrwxSD8OGK0jnYKHcAcYeWjhe5uuYYiTWz+wcxja80OSR8Ouvu+HipmCpJUw4q
 WZBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729918453; x=1730523253;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=u37XwggRM+b99ha/2NST/UfXKdx0coEheXY0HIKdL+8=;
 b=eBfWvBkptJ/ZvXBgT5GZY737yBE6PUjmuJqMODCJmjMqq/LQQ04di6zFd/7DeiMB+s
 PaznklMbDi25HkGJcTRCeuBbaePWJ19jEIUw/M/2ErZ7JwZFxxBtMs/0dZYmkl5vL+uH
 w8keuJ/h1CNzXwRjSs1wgChcesdGn/2ZpKpl5hJzAm3zCpn1EpQE0ZHSbfoeNnwzjbck
 uF1GBDzxcPdlrvrpqjR9UMoVtFf2pO+L81yGHUygoqG1vzoYCZTH9MRgOwz4U2ohA7Y5
 0PDdTt9yOD73XAkInFVHesnSrKqnlXkZbjIXmHr3DyOhgRkcHDOQ3FaKkCzLVpOlsgrm
 UMHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXKJwk73PyFrQP8QTQ8qnwZ2dW2EI7x2Y3jdMplEHhElpePoTgvdR9jLR3mTJ210iu3dsTYAPJurMlX@nongnu.org
X-Gm-Message-State: AOJu0Yw1Vj7gjW00N61CBmU1qn0hChsDPK3WwAxdfH9vOwWIqV6hOcNu
 OBZaDMdRby/k3IOB9s6z1qYfBop4vdS/8sh4tuNAUOLb86klGY9t/oD+9Kn8EKI=
X-Google-Smtp-Source: AGHT+IGzendqbLUt3OfBaWzzPEjZ1jO4i0ASLPfXo+z3A0OkO5t51HjlO5oxOqm5n/Cl6g83mnAFDg==
X-Received: by 2002:a17:902:ea12:b0:20c:c9db:7c45 with SMTP id
 d9443c01a7336-210c68dd56amr19749005ad.20.1729918453496; 
 Fri, 25 Oct 2024 21:54:13 -0700 (PDT)
Received: from [192.168.120.226] ([45.176.88.169])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-210bbf44321sm17512185ad.30.2024.10.25.21.54.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Oct 2024 21:54:13 -0700 (PDT)
Message-ID: <3de77a67-e41f-49d6-bbe4-cd186f742211@linaro.org>
Date: Sat, 26 Oct 2024 01:54:09 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] cpu: ensure we don't call start_exclusive from
 cpu_exec
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20241025175857.2554252-1-pierrick.bouvier@linaro.org>
 <20241025175857.2554252-3-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241025175857.2554252-3-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=philmd@linaro.org; helo=mail-pl1-x630.google.com
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

On 25/10/24 14:58, Pierrick Bouvier wrote:
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   cpu-common.c | 3 +++
>   1 file changed, 3 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


