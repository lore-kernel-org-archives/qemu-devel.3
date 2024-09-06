Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F11FECE7AFB
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 10:10:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smVuX-0003Ob-Of; Fri, 06 Sep 2024 06:09:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1smVuU-0003LI-Pv
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 06:09:47 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1smVuT-00011Q-9K
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 06:09:46 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3787ddbd5a2so967977f8f.0
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2024 03:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725617383; x=1726222183; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=809sxjCqIdzpogNlBhfUNGeDFJ7H93zc3rl0vI9KzlM=;
 b=RqvFWVjvYcfb4vdK+4XQCBbRweNZdqvUwe/FewJq7GxI6IYFXKRhgWbFCb4QHCZfi2
 1X3IwxhTj6Eebp+/Q/ZbEervYByejh9Tt8i1dQFTRro/TK0xOqe26zrByfJ4p8uHh7SX
 6W2B13y8LPO8mXX3mgvLAaS7TuGeddheyb27djdAeYikEGXAFnaUnaE8vqfNcgDoK2QS
 0GvcziySr0i+rKWRygRvkrwJgOsrgzMCXBZM8G/WbmWDavxufJGdMmE6mQFPMfek034E
 Wh6C9QDjc8yFChBlCMoSOAxv+YultIzbcGqa4xQlURKc80ThWJ2nl8Ksja85K9PShFrM
 gXsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725617383; x=1726222183;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=809sxjCqIdzpogNlBhfUNGeDFJ7H93zc3rl0vI9KzlM=;
 b=rN0LqGojjE/oJpIfPgx5PGpeBYFR6urtyCBk9N4yBRzMGNt6IQGvdWYbbIfIagIRUz
 MZrWMDgnstjpRGLRD5tHFG7XX3Lq3zrqxwHglMypwO0srT9aWVyty2UH+pDpBDwzhV8K
 CwUXHa9K/Gk2MZ6c9s3hC6FT6TBR0071fkd7qi5oXk4fhSthqbTcSQxT5ZMz70DIUMHi
 8Bn9prPKzHoVpDdtXxKl9AoCdkULVHa159o99CsdVmsBdOL64XtKVZjEsqDb1qkks6FK
 90s/WLrs0HYrHVd35p468sEw758oUMZQg/C7xc4llHwSjH+jskyVHbYQU5wVhh/P4ZYp
 9KaQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVN7rCwWGDbZk13vh++pKyk8V0qGb42QifE0ON1WLcHi7w0CuDlgFkMUXUl/noUZjLUqqwIn8PkoU1S@nongnu.org
X-Gm-Message-State: AOJu0YxpHPwh2sokU8P8QTnqNUItK3QonJvc8W12DudsrZe6lOIHyvcb
 RPMcvKaLI0e/rkuNAGOx5p16wGDu52MVmvfeY05AD+SUOpBJC5D8baVjrWFAf3k=
X-Google-Smtp-Source: AGHT+IHCDDEudDrf/gNBJuoE0xDST9XDpPu+NwPzo9PLpS+xG8PoggJJE4TJghCXONSQGm4Pn2yvrA==
X-Received: by 2002:adf:e982:0:b0:371:88b9:256d with SMTP id
 ffacd0b85a97d-378895c4a31mr1330614f8f.6.1725617383356; 
 Fri, 06 Sep 2024 03:09:43 -0700 (PDT)
Received: from [192.168.1.67] ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42ca0606917sm15316975e9.39.2024.09.06.03.09.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Sep 2024 03:09:42 -0700 (PDT)
Message-ID: <658d7d65-04c6-4da2-a741-6e2635590fce@linaro.org>
Date: Fri, 6 Sep 2024 12:09:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/7] hw/net: report errors from failing to use eBPF RSS
 FDs
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Andrew Melnychenko <andrew@daynix.com>
References: <20240905181330.3657590-1-berrange@redhat.com>
 <20240905181330.3657590-6-berrange@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240905181330.3657590-6-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

On 5/9/24 20:13, Daniel P. Berrangé wrote:
> If the user/mgmt app passed in a set of pre-opened FDs for eBPF RSS,
> then it is expecting QEMU to use them. Any failure to do so must be
> considered a fatal error and propagated back up the stack, otherwise
> deployment mistakes will not be detectable in a prompt manner. When
> not using pre-opened FDs, then eBPF RSS is tried on a "best effort"
> basis only and thus fallback to software RSS is valid.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   hw/net/virtio-net.c | 41 +++++++++++++++++++++++++++++------------
>   1 file changed, 29 insertions(+), 12 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


