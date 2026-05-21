Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77412CD4F3D
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 05:50:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPwIs-0002k9-PJ; Thu, 21 May 2026 01:50:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPwIr-0002fj-4a
 for qemu-devel@nongnu.org; Thu, 21 May 2026 01:50:41 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPwIp-0003TX-HJ
 for qemu-devel@nongnu.org; Thu, 21 May 2026 01:50:40 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-44a044cb827so4122060f8f.0
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 22:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779342637; x=1779947437; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3REAND0N3M50lUQJqtt0os5hT81RSGoIpwxgH5q33JQ=;
 b=l3YEKXcy6hQwzpm9Yk9zJMwHBsroMlkAX0Yf8v7YOUshNZM+Z2H/shsrkVjAatQTri
 KzpXcXFEvWcjV3T7ugGMKdEHBBsQYAh97PByVyv2AXyXAAucqt8vQSKA7MG/l8N1msrE
 uRIiBT9c6WKcrXmqHeK0lFal8HzhdWiFS/VZ+T0UMCr8dal49N5lXW5/R06OEJaYKM5B
 2FrbLnLp6AvM2i4A9HVJBrHPguZhH+Nqc2sLNzEy9fxWannZKIgO4g+RUXQOyA9LXVzM
 0w/8vTNT4WrzA0JVHiRKsOVujzYpfu+O5rXaRi6bcGPPUXybFSyRwSFenQnazlIuwTHE
 ezVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779342637; x=1779947437;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3REAND0N3M50lUQJqtt0os5hT81RSGoIpwxgH5q33JQ=;
 b=qcqMjy6AzyhsOhh5oTF6heZKGbUfY4kvk7f0pvHC7CC8kbTi8NcmdTNN+bX/B94eeQ
 NMQv+am9ONR8G3GEu1PVS7O18DUtYy14waY6RCjYBqkt/Mn5m62S7O9ZM6mNAk5gKlvA
 dDhSSp1neFAC9v9ypY/dKaC4fXs9aH95+oqBWvmT69/h7cgsnSbqQ6eShvXh5otHFkis
 L3yjV1mehww16ZnCDL0rtrrRD1/6QDlGe2aw0lkf41Tk0tSkPrt4+WsJPCQcJYST1p8v
 0aWofSm+mqG03zPV6d4Vpg79Um/CXHjV0YxMLtr0kjIdQsXwQZtSrkCdz5GlEeGWOL/t
 5pCg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/yigYwWTdJNju/dBQlsBE+mpLptChS+WHu0f8HSEYAYzY2VYYjr7P4Bsw54A4cO1AZHBWeDuA8P47u@nongnu.org
X-Gm-Message-State: AOJu0YysgWyoXpfmX8Z/rcoR33S5Zz9J0kNGVabE9yl4+zb5fXWZoj2t
 gDMrVMx6mF3XpLQeU/xZow4Cav+TIAaETemNuDKzeIh8DKzKpfCpACsk82dsZ45bjPo=
X-Gm-Gg: Acq92OHPOddu4bHdnbjpYiNjWsXtyeKW4yF3P2Tu0JLximQu0dlPKgGG/WoZg+NBsrK
 r3HrfbpmM7KGIL/8T/XsdW5RoO0mZr48UEAeWGrqANE3h1OzFpPmQtMXAK7v6a6QMPXnFIxNHUC
 1cdOpFzn7g/EUn/2iqn4ehILtdzmtxaIiP/Cz+m7CJEUfvF8/wsgJ54b4foODPe7ZKchznKGa78
 yiJz65SFJHAFUHDLj9D64RpYilhmIB8RR0/XVXog+rrqK32+cN3dE/60iHYCwtiiuK9p/HRZgwK
 x8mEOVMAuGV1YsFIAwCHOTrxlV35nfh7EGtW1uAPEESpklqG18/lLqRTuWE69tRDFk8VsntNVH5
 AFyTuJoNZZUSXc8TCcLa5oaxne+4Ah/NCP647jdNBgWUbf0xrQtF8NmXQr77KblVNSPjPrMfSEa
 khd3Ooq4tBFLAYWoV6onbMHgCUUIGLwuh7n18+aWue8K6b0jsEjVhqCNNIZ7CmE1YGCQ==
X-Received: by 2002:a5d:5d07:0:b0:45d:41e0:467b with SMTP id
 ffacd0b85a97d-45ea38cd484mr1901363f8f.3.1779342636976; 
 Wed, 20 May 2026 22:50:36 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eaa7cf58fsm26670f8f.3.2026.05.20.22.50.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 May 2026 22:50:35 -0700 (PDT)
Message-ID: <de389d46-a65d-46ab-bac8-b9471d894d07@linaro.org>
Date: Thu, 21 May 2026 07:50:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/40] hmp: remove 'vcpu' argument from trace-event help
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
References: <20260521-qemu-no-hmp-v1-0-d104f809e145@redhat.com>
 <20260521-qemu-no-hmp-v1-2-d104f809e145@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260521-qemu-no-hmp-v1-2-d104f809e145@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

On 20/5/26 23:49, Marc-André Lureau wrote:
> Fixes: 89aafcf2a793 ("trace: remove code that depends on setting vcpu")
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   hmp-commands-info.hx | 6 +++---
>   hmp-commands.hx      | 7 +++----
>   2 files changed, 6 insertions(+), 7 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

