Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A405C87FCB
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Aug 2025 17:12:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujhgt-0006q7-SC; Wed, 06 Aug 2025 13:12:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ujhI7-0003bd-Bw
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 12:47:03 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ujhI5-00022Z-Cu
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 12:47:03 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-459eb4ae596so1155295e9.1
 for <qemu-devel@nongnu.org>; Wed, 06 Aug 2025 09:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754498818; x=1755103618; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ad53HRJ739v7jQzW/6MWw0lLZeql6pfvkgPUZS5ewAo=;
 b=ZVk6q5/5B9pmBuztmUGFU9GARNQoqoUoSGyFZ9VlHCVMcPUJatflqnsQbfQsgao1Sh
 bMIUFL4UahPZ7FsW/5B1ewMzlHgUE3+C+s5bLmeWNi4BNbu8A9PF+CzxH+j8KxR+byAi
 nNtFSQ3CqT51ThSfLpruzSh/DZzAHQ6Cs+HQWDFLJb7dy0nWlMY5kamug3imh/CDWbbV
 rkRdrS7CKBnlwmWB6NQ9DAmX1PjEKpV3pvMK2cxtIVQnm1BobT7jhlZy7j5YXGdIih0G
 Ajs6w91nNpFs2MR+FDoUoaw2VmK+DPLb8NiPZpw7ogZ/yzvmbSiC6d+EdpBeBTycq9yF
 808A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754498818; x=1755103618;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ad53HRJ739v7jQzW/6MWw0lLZeql6pfvkgPUZS5ewAo=;
 b=f5kOQOwNJ1WiRxCAg3gHbOkyCLYuNsNfm8wpWh9g/zhQ5VZ/olr3VnjWK5RjLoeClR
 0s66PcivXhSZH6qdxO+YcT5t0GJ1CsrQtzeVxRggSP5UMpdxVFC9ewrPMU2dj7eUuO6p
 Af8o4/NDYbZu4zhZm9gEWC788+8wHx7sLK/JN24kmyJ6AqqHTZznU3yw4JxuJnkZThzR
 XLjD6s8iKcQyaUUM0P/0o6MBKgsS50omhO7ett+u/mB5nGecjsx2lwqViDKp5uJYGahb
 pBIqKZ3u8qcab47KcErB5wKioAhLFXUg3T2f73zOHcP4im0i/esRi6/VEvjz7Gsgss4v
 4vRg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWXFChdx1fS7oVm0T3nP4EtCv4BhuGbGbLoquWBvOAacFu9qVE/25YgsKkOqLiJlJu6X3nU7u0vHRS0@nongnu.org
X-Gm-Message-State: AOJu0Yy4tfLt6AEhkrlvF2qK2hQn3lg/aQGVVMa92IuVZ2EvQM0ii0pg
 9Esj/kdyTj3Ayeuu2dmjf9nO60Rk4Es7+QpXyMPsb4FJaH6uSw3YWE6rQz3O6fGa7rI=
X-Gm-Gg: ASbGncviqMSf4Gic16mRM1JHN/quPspGhYHIoFwwToaJKP6eMooeKZXukUHnVwQWnNy
 tCi6Wy/rtzzYOvkRY76tEGstgWRje7/uvjPVxncbEc+EMH+mgai4k3sUW2tCtOCnexyZibM7b7X
 uv8tb2szYrRXlrDMzGLpwRCjXrlDt29SDMCTiZOonQqJIPS+tgIGdue50WEltUaD3D5ojm88bSq
 xpkYGqG7gQ1Yzhk2YMJwFLKqRJX0VSutRyCBJVhOXi30PXHGQ4VgFyIQFKQXeVuX6d66Xy3c2iS
 SjvPEhSQiCW/60Dg/zUVwBVdMw7e9x9a/CkrKfR00+mWrVsLOQGl/uoILdNvguUmmRp3sJkustU
 kvkUZVznUEnWr/AQXopmNgQ1htLRdyi2kkPRgn4+zKDD62YolD26FGf1rb8+IOLr5kA==
X-Google-Smtp-Source: AGHT+IFdGlkE/QWAAz0znRiQWp5ScIsu5NZVS7svEk3VF4a1LLkbBTHxcUYUn8Wbrq2p7aE+HtE0Bw==
X-Received: by 2002:a05:600c:b90:b0:459:ddad:a3bd with SMTP id
 5b1f17b1804b1-459e742a118mr40703525e9.15.1754498818241; 
 Wed, 06 Aug 2025 09:46:58 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459c58ececdsm91183015e9.1.2025.08.06.09.46.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Aug 2025 09:46:57 -0700 (PDT)
Message-ID: <ff2a5b63-d7a1-4c72-bd10-93300a8439b4@linaro.org>
Date: Wed, 6 Aug 2025 18:46:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] migration/vmstate: remove
 VMSTATE_BUFFER_POINTER_UNSAFE macro
To: Michael Tokarev <mjt@tls.msk.ru>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Akihiko Odaki
 <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org
References: <20250802142115.41638-1-mjt@tls.msk.ru>
 <20250802142115.41638-2-mjt@tls.msk.ru>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250802142115.41638-2-mjt@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 2/8/25 16:21, Michael Tokarev wrote:
> The only user of this macro was VirtIONet.vlans, which has been
> converted to regular VMSTATE_BUFFER.
> 
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
> ---
>   include/migration/vmstate.h | 9 ---------
>   1 file changed, 9 deletions(-)

Yay!

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


