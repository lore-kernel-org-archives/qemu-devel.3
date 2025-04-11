Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B871EC36010
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 08:19:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u39bU-0004lw-T2; Fri, 11 Apr 2025 04:19:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1u39bL-0004kx-AQ
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 04:19:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1u39bJ-0006Xn-Bh
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 04:19:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744359540;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p5tv82XoNM8n+7OjVviD3xcy/gBt+IAz/mDEGdURPPM=;
 b=gGTpyWxebQge9Q9fVZ5b2w9ht/WFLiO3rF12aHpjggvPQ6bl6sdt/eWZw6ig+ai6WeLmvL
 Xn5jQ6FgApYk5uZuBStHM/WpF8aMpxXW/yHxPD2rCtNBjoGFXcXnTIiSki1NTgY/1RAoL3
 ZTQzLGlEHjBKijL3fMVXeXCV5r16Fl8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-SBMGke_TPVi0gkOmfbCztA-1; Fri, 11 Apr 2025 04:18:59 -0400
X-MC-Unique: SBMGke_TPVi0gkOmfbCztA-1
X-Mimecast-MFC-AGG-ID: SBMGke_TPVi0gkOmfbCztA_1744359538
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3912fe32a30so727191f8f.1
 for <qemu-devel@nongnu.org>; Fri, 11 Apr 2025 01:18:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744359537; x=1744964337;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=p5tv82XoNM8n+7OjVviD3xcy/gBt+IAz/mDEGdURPPM=;
 b=j4pO7fjPIHTuRuDR/IxGbEjnBfd68hep1kDm/Gt/K7+bczuCAvI3kCf+39gb2I3ZLS
 uBpcx0/6jn4W3qwOm74bWekM7v0oTW4MmRWMnsW0Xj56idQ2/a3kdVn0x2+iMy5tWmYD
 hjkSlqqvwOYLzgr/9nx9grnyLJ9UoBiRy/Lxb/J8NvA32JFEQT2323AhevMOL6mdXem1
 dt5brnW5vfGXOMl6A02UyaqypR7I1vjVQBO6idqXiXlPopqcfEuNOJlFno0lqR/E3VQJ
 aMUTBqv5iIEa2KSccsy1ggHlUyqhdRrQpBhs4XYZO90cLjMqjrt8tzwP/nrHDOu35R2N
 IklA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCJ1vwlyaUmWm3ldokPtzRdpiu3ruzJM8UpxU6Jov7P/hd6u2H+tM9ElnubfqpalWGqFxnzD9dvRI5@nongnu.org
X-Gm-Message-State: AOJu0YxY+icUHc0Uma7Bxw+b/wg4pDAdxCK1owJSHMPieOlqCR0+oNWv
 etcdc0mCodl2/kgXnE+EMKKy6rKprHgU63DuNfQFgZgtZmE9EJ4WhLsqST8hA0QXUwAj4V42seX
 Bb0Kfh8NOlGDzFJrHdmxqgej+zpgPqJPRp0ZEyRHCvEx9VvQt8qmyM6OmPlnU
X-Gm-Gg: ASbGncuieTPQ/44MlHO78XeGVAp1ahV4JunojFN6K51LCO/lQ8KwfjKaiLcxrtAtnsG
 yWpn03+XbQwfgxeZ0pUsYuOaEl2t3AQ0pBRYYmQmEltM0KV5O1zBK7bJarSPLYhao1HL0zM4tc5
 Z89N1n9KKPZVrKYvh9dfIoXlSCeyeXCtKntbayvyLsb1WBspSFYcqlPQU3by760+zQTIJaLR5Gd
 9/bIKfUypV367KI/btiT3ZnZXLRgMCjmTeF3TVkAqpFrOG2Y0U8D4xzfNinBS56Tcq+rHTURcUL
 q1ZRep6NiNz3bySHKJ6pEsSoNgSRmUH0T5X6jC94Qc8Ghh0JJ7N0IJtWxepwun28C3sUn1CGPxV
 6rd4kqhBB4OE+xFWf1eEnncfBQ+Hb6bJdi1CZOG5w
X-Received: by 2002:a5d:588a:0:b0:39a:c9ae:9efe with SMTP id
 ffacd0b85a97d-39ea520384emr1026309f8f.18.1744359537260; 
 Fri, 11 Apr 2025 01:18:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnLI0i3ZqQLj2jTeaq9OWds+ta4lzdfw0GfmNmdfmkflEEvg9hJLHjngdKuTbL+rb0iWV0nA==
X-Received: by 2002:a5d:588a:0:b0:39a:c9ae:9efe with SMTP id
 ffacd0b85a97d-39ea520384emr1026292f8f.18.1744359536897; 
 Fri, 11 Apr 2025 01:18:56 -0700 (PDT)
Received: from ?IPV6:2003:cf:d732:e4be:15e6:ccc0:870d:ec27?
 (p200300cfd732e4be15e6ccc0870dec27.dip0.t-ipconnect.de.
 [2003:cf:d732:e4be:15e6:ccc0:870d:ec27])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43f233a2c53sm75170165e9.14.2025.04.11.01.18.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Apr 2025 01:18:56 -0700 (PDT)
Message-ID: <c2daf7e2-359b-4e4b-826f-511fa9c0e3fb@redhat.com>
Date: Fri, 11 Apr 2025 10:18:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] block/io: skip head/tail requests on EINVAL
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org
References: <20250410184103.23385-1-stefanha@redhat.com>
 <20250410184103.23385-3-stefanha@redhat.com>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20250410184103.23385-3-stefanha@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.593,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 10.04.25 20:41, Stefan Hajnoczi wrote:
> When guests send misaligned discard requests, the block layer breaks
> them up into a misaligned head, an aligned main body, and a misaligned
> tail.
>
> The file-posix block driver on Linux returns -EINVAL on misaligned
> discard requests. This causes bdrv_co_pdiscard() to fail and guests
> configured with werror=stop will pause.
>
> Add a special case for misaligned head/tail requests. Simply continue
> when EINVAL is encountered so that the aligned main body of the request
> can be completed and the guest is not paused. This is the best we can do
> when guest discard limits do not match the host discard limits.
>
> Fixes: https://issues.redhat.com/browse/RHEL-86032
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>   block/io.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/block/io.c b/block/io.c
> index 1ba8d1aeea..a0d0b31a3e 100644
> --- a/block/io.c
> +++ b/block/io.c
> @@ -3180,7 +3180,11 @@ int coroutine_fn bdrv_co_pdiscard(BdrvChild *child, int64_t offset,
>               }
>           }
>           if (ret && ret != -ENOTSUP) {
> -            goto out;
> +            if (ret == -EINVAL && (offset % align != 0 || num % align != 0)) {

Could use `(offset | num) % align != 0`, but either way:

Reviewed-by: Hanna Czenczek <hreitz@redhat.com>

> +                /* Silently skip rejected unaligned head/tail requests */
> +            } else {
> +                goto out; /* bail out */
> +            }
>           }
>   
>           offset += num;


