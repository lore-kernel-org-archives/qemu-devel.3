Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6BB0CA0EF5
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 21:50:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoUDf-00085k-2e; Tue, 19 Aug 2025 17:50:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uoUDd-00084k-Q1
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 17:50:13 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uoUDc-0000un-Bx
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 17:50:13 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-76e6cbb991aso2156494b3a.1
 for <qemu-devel@nongnu.org>; Tue, 19 Aug 2025 14:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755640210; x=1756245010; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xmvL1vbn8xlBqrqn3YBJllwHu3AuZow33IOxQ+2O4go=;
 b=M8ObA91wDUorbw2yVcqAHJU8N7qJQCTsjXusrA3ipelp28btRDV7CIM8dTwBaXKUlc
 1dKb1UcM6tKWY20vl6OPj2k7F7jC2Zsj6V+NRdqYnd5Xeyn+Qb1wgR93gtiNykxq05Yp
 5rEMssf2Bz/IcLNSjbldCM3FjeHs0PxTYlri5Uz7bn5Jn60FLR9tt4QpyJ8iuEjU5FDn
 1lyEHAQzRZX4XRTZlsQFSEpD//AXb26QIV1rM2JwD4mJ4rRN6hgSM00u7d7PfESNlc1q
 B0mneiuuqUY8UknjOW8Uqoq03SxDyDm6gXWnAxlFmazUq9cMQ13+8eW+7TwIREn0xtzW
 Ib6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755640210; x=1756245010;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xmvL1vbn8xlBqrqn3YBJllwHu3AuZow33IOxQ+2O4go=;
 b=sRFXBRS5G6tJ2a4PlWARgvU5vl4RtjG2vwkpgJK+xOWfB0YcbU5A7s9Nxvj3D6W5w8
 7Z1SOsI4mUePix2uNdTPOKCxHS1cQ/VEzx7F/L2FX3/X54x1RPkDaJP7WMk2X9WKnYJx
 gQfTKssTwZ7d28wMLZEWef8pz3kT5omOjEmdXnsQF0AcDU3vscA+HWrRxUtQfkiYI1kF
 HyT6PTfU+Psi7JeIbHLpXTCodhBS5ZQrkuYjK3wM6iTsvutUQOvSHewTnnqlA5c9uBZX
 Ow9R80fZIVxV5J8FV6LOZK+l/kmKniugWyIz77gUYrhhrItlFnT8lHY9sk92I0kFBQt0
 8Hgw==
X-Gm-Message-State: AOJu0YzCvM6UEbxBPmAu6byQ2+cdMIy0A6yF0WgkyYRMqZjh6Bl8H75i
 lPgx8GdH/F46KugZpdWfPYDwzuvUuyc7WyrInZZlHBmft7FvmpYWozYRXVf/Qa1yWDQQvkaf8iW
 FxTxXFz4=
X-Gm-Gg: ASbGncveCEdPbqQegrgh7DreNNgq+mNOsHC83Ne961njBnC+f4r3gK9IaG7VjuraJJR
 4Ec2pw0ZBEIe7kTzgl1depvw+KyPXCuOAmAxXAN9MHO24NMramSSHm4AAHlL7nAgA4Ly1LA2eaj
 KXnFx79RX8Airx/P/gVrbEjkeTuAsdHyY4kGAlaCCLLxPNwKjZR9hjtxp2QOWj7yBkU3wE7DtGh
 LUDNyMODy13uisT4qRXKmUZ8qFgAoRzJcRDrpN0P1URX0dbH0DozmyzggJiw1C2FSHIE/qFYPPx
 8qbCkltiBba42FoBESuFmZQd4789a+qTwm4dFLFimyYvaKy8utlQE2lHpxEx7/42AxorsgRut/2
 IX3ww2edxouQg+9EIcxkRICCC6EY2qsZ7sA==
X-Google-Smtp-Source: AGHT+IHBDjEY6MLXWolEG/r1XDaqnMdWf7LPOb3r4eVcgNCZ6lfYOaNEAgGcNpoaY9z6fPbDSyTMnA==
X-Received: by 2002:a05:6a00:3a12:b0:76e:885a:c3ef with SMTP id
 d2e1a72fcca58-76e8dd8e2e5mr768060b3a.27.1755640210298; 
 Tue, 19 Aug 2025 14:50:10 -0700 (PDT)
Received: from [10.0.0.90] ([120.159.20.238]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76e7d4f77fdsm3388058b3a.66.2025.08.19.14.50.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Aug 2025 14:50:09 -0700 (PDT)
Message-ID: <4fedf23a-b72d-4e28-b018-ab6f58a066b9@linaro.org>
Date: Wed, 20 Aug 2025 07:50:05 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/12] util: add API to fetch the current thread name
To: qemu-devel@nongnu.org
References: <20250819202708.1185594-1-berrange@redhat.com>
 <20250819202708.1185594-7-berrange@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250819202708.1185594-7-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

On 8/20/25 06:27, Daniel P. Berrangé wrote:
> +        strncpy(namebuf, "unnamed", sizeof(namebuf) - 1);
> +        namebuf[sizeof(namebuf) - 1] = '\0';

g_strlcpy?

r~

