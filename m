Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55E68C5321D
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2024 06:33:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1siTH4-0004Xe-8j; Mon, 26 Aug 2024 02:32:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1siTGx-0004Wq-5p
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 02:32:16 -0400
Received: from mail-oo1-xc31.google.com ([2607:f8b0:4864:20::c31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1siTGv-0007mG-JT
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 02:32:14 -0400
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-5d5bf833de7so3043088eaf.2
 for <qemu-devel@nongnu.org>; Sun, 25 Aug 2024 23:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724653932; x=1725258732; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nam13A3RdtNOwsp+TM7/oTRlnH9wAf9Kn+rEQ6CJ3o4=;
 b=j6ebqIlnwdZqXoEOCrH/27QFvrIUKFdh/XjtyPid3IM0/kNwk4dT1b1mYGe2rmEBt0
 JI4qk5BwsAV0kU3A86zTF8l3CJv3ddK5yFpdJ2b1Tt7PBl9AEte4RrRyJOCLrt8l+T60
 ggZdHXICz+QA2CN1+bTGpeqrhrzcbC2h44gwKj5UVF/Wh8rQwDhOcNFZbPEQr5agVS4a
 tVImc3ECQWSeGklzHXt0gY/kHeeEGozJm3q3aUFme6Hht9GU56SsSaiu4m5nkrVeMfsF
 tNlHhS7lwobX6Du1t0b5B7lfi8mpkgvVAEzDC1Oau2hLwLpOWvrUStShRKXWAtOEIGmc
 5Q9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724653932; x=1725258732;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nam13A3RdtNOwsp+TM7/oTRlnH9wAf9Kn+rEQ6CJ3o4=;
 b=msAyQbCkBjyvCzAXg5fgmVPGhAm16mhK7NBcXjHZGKiv2NLV21byEaO/6CcGtBIz53
 CU5kWIcOjwiYlV/FdqRY+LrEHXuAWvOOlqfTnz0zxCeLqgVmIYj9tpA4mUqQglTsp+8Z
 SzElN6E7XFPLrTm8aRBPnlGGnVyARh1uckg0wPIA8molp27JwNFAyJx9DO+bSeZ3lcK6
 Qp+tqldHzIpljkg6KLy+AsXMRm5VDSfCgY0RtpA/NLRs8+U21/6rP4ZmG/kxSuRLx3T+
 ivGtNMmZAx2FrboNtiWHGfVPWoB4ca4KM88BSa9FMYfVOy+noQBE0113app+oRK01Hia
 zf/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWqP5+CLBzuE5fXlEdc0xsEuRsh/Qi0Ni2Gcm2ip1Qs/UeFP2ns1qFPrfA3Hi9dl2xRtbKna8adylM@nongnu.org
X-Gm-Message-State: AOJu0YyGukwaGGsBXizQfJAa7vmb89mWI0l2TeU//+WW9lZDLori/Z+w
 1K9+89SXVVbFxqfBEH8Rp25YTyMIjsuXHARnN6TIP2ekJyXJ5VNhSxYjqKjqc2M=
X-Google-Smtp-Source: AGHT+IElt2zAUxYIEEg1GsPabhnT3qbDhbI5KuiA6KAmWyjhklCGrEGccMtObxw3Gcd0ZbLMK+tnUw==
X-Received: by 2002:a05:6359:5a92:b0:1aa:bde7:5725 with SMTP id
 e5c5f4694b2df-1b5c22eab67mr1179809555d.28.1724653931771; 
 Sun, 25 Aug 2024 23:32:11 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.216.241])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-454fe0f3e24sm40876461cf.55.2024.08.25.23.32.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 25 Aug 2024 23:32:11 -0700 (PDT)
Message-ID: <c944fe50-1e59-4687-80a2-617ea3dbbced@linaro.org>
Date: Mon, 26 Aug 2024 08:32:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 15/16] migration/multifd: Register nocomp ops
 dynamically
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>
References: <20240823173911.6712-1-farosas@suse.de>
 <20240823173911.6712-16-farosas@suse.de>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240823173911.6712-16-farosas@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c31;
 envelope-from=philmd@linaro.org; helo=mail-oo1-xc31.google.com
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

On 23/8/24 19:39, Fabiano Rosas wrote:
> Prior to moving the ram code into multifd-nocomp.c, change the code to
> register the nocomp ops dynamically so we don't need to have the ops
> structure defined in multifd.c.
> 
> While here, move the ops struct initialization to the end of the file
> to make the next diff cleaner.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>   migration/multifd.c | 32 +++++++++++++++++++-------------
>   1 file changed, 19 insertions(+), 13 deletions(-)


> +static MultiFDMethods multifd_nocomp_ops = {

As a follow up cleanup, have multifd_register_ops() take a
const MultiFDMethods*, making these arrays also const.

> +    .send_setup = multifd_nocomp_send_setup,
> +    .send_cleanup = multifd_nocomp_send_cleanup,
> +    .send_prepare = multifd_nocomp_send_prepare,
> +    .recv_setup = multifd_nocomp_recv_setup,
> +    .recv_cleanup = multifd_nocomp_recv_cleanup,
> +    .recv = multifd_nocomp_recv
> +};
> +
> +static void multifd_nocomp_register(void)
> +{
> +    multifd_register_ops(MULTIFD_COMPRESSION_NONE, &multifd_nocomp_ops);
> +}
> +
> +migration_init(multifd_nocomp_register);


