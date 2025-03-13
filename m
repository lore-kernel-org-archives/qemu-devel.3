Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80587C282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 09:58:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsfJv-0008JE-Q8; Thu, 13 Mar 2025 05:57:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tsfJu-0008Is-IE
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 05:57:42 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tsfJp-0007Md-PL
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 05:57:42 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43cf628cb14so11261985e9.1
 for <qemu-devel@nongnu.org>; Thu, 13 Mar 2025 02:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741859856; x=1742464656; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=I0O2yoHYoUsiRdmBcz2l0N0PHG+liK4bF3bqhhsvSOE=;
 b=UAXoD+Dc4wF2yXgKWrg/4sR/Br1NdIcKrytudCACW0cIOQxJPznntRcrDUT3AZIOsk
 hLOAJVKI+k14AjlUyhIckPiBgkiIhffbkfIB3jydHmAWGPPR6texvz5pWXTkSA+eTJZP
 NOWFfNYOBwBjfZUMex1l+niNHJn9mxGQJYDwDtk7UB/6hzLJf53kqD6Y9T/CHQRdhlmL
 yupRH8+/qePXXl2afKzi/EBnRpKfUr3ot0hrCTCksR3JyMj+eZ+oq81jTSftbkMjTHAg
 ahgb2lfPpjaYErXFWSgagVhLKbagqXc1NY2AloOzDPcUBHFPB/yXY185H/ESfVs67MlM
 TBjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741859856; x=1742464656;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=I0O2yoHYoUsiRdmBcz2l0N0PHG+liK4bF3bqhhsvSOE=;
 b=HVJp1SpbyV+hgmu5HI/MLwT6Ik58k6SGoxbhHEY8SP2PzJwdQJ9eNiNoWIrG3FWsct
 RUPbGlK5vEVQCsHi3vHtc+t94JJENDokQche1e7K6hIGRWwlj6ZM0G6E0vyJSOW6/H1D
 SJAP4xV9IjqXF55zv1ccS499yBZoyKl9qEth8CKXToX+p1I1sMDB3vNiRcklTuR/N/wb
 qKEu79LmasEUKdoSBPj5hxVW+voWPGfNCDN8j9v9sTaJWpnfXkqSycygoNrTG1YzjrgM
 sXvmsF3c89Ee438yBEU2eupT7URT5YE8TYdfFT51V4o40EsDdCv2EYdddg6hMNqdL11Y
 FhxA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWOcs5Ia+Sf0nvn49qcsG5zEK0WN5stZdPbXH/sY1rwCtsiILEcdzLdA6j6cXFkRMayN+z1+ciH9ccH@nongnu.org
X-Gm-Message-State: AOJu0YyGI2hqew8Od3L2lxSegS0P9b6qclSeP/R9/HkktPFUpqDlH4EH
 RHuS//tF/449thQrJ1Z5pao5c069tDfM7GVtXnMMaZDfvFZuK6+yIdiz1PTzbwQ=
X-Gm-Gg: ASbGncu1tDJremIcmCODYHQJIQaQZghnb6gf4rNLr9g82z9RrKgveYmApTn1p7FHQKe
 cFg+uUcuVKsyT6DpsdClztocFSsDvRFy34h178LyjluAQWFOcp89pWkLJYOg0kVmMgMwzlXbBbL
 bziXvbKzICSm9/o73vsECMLt6PsMg4lTrbwyb5zuR6n6wze31YTpedE5EUerX+MzG860S2+B23q
 nOEQmdCAyRjDVnvtxJgzh0FWZd6qxEXefE0r0sK5mVOVV8ouSMXh9z/ifHhBBclxmXxehVXrXjM
 i+AZ1s4kN6yWCnBdX5Jg9NPj4ZeK82ei+6YuFADmSxhZbHSOak5LYoCXayJD3WE1ByS7oCt1qhs
 9Q3Zyok8c80wgXlDKm5T7gjP11A==
X-Google-Smtp-Source: AGHT+IF97Jp86/ZCcQo3FD7Ce11QVbzJFQ6/HTV916uRklnMzfwHBE2WYCraA0AnyF+63uOXiD3S8w==
X-Received: by 2002:a05:600c:3b87:b0:439:9434:4f3b with SMTP id
 5b1f17b1804b1-43d1808564bmr13448815e9.8.1741859856149; 
 Thu, 13 Mar 2025 02:57:36 -0700 (PDT)
Received: from [192.168.1.20] (88-178-97-237.subs.proxad.net. [88.178.97.237])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d188b0092sm15018715e9.5.2025.03.13.02.57.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Mar 2025 02:57:35 -0700 (PDT)
Message-ID: <10031b78-899d-495f-b9d0-96a06662a86b@linaro.org>
Date: Thu, 13 Mar 2025 10:57:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/37] accel/tcg: Remove mmap_lock/unlock from watchpoint.c
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org, pbonzini@redhat.com
References: <20250313034524.3069690-1-richard.henderson@linaro.org>
 <20250313034524.3069690-13-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250313034524.3069690-13-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 13/3/25 04:44, Richard Henderson wrote:
> The mmap_lock is user-only, whereas watchpoint.c
> is only compiled for system mode.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/watchpoint.c | 3 ---
>   1 file changed, 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


