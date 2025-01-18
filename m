Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1787C02185
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2025 10:09:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZ5la-0005LV-BT; Sat, 18 Jan 2025 05:09:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@gmail.com>)
 id 1tZ5lY-0005LK-Ac
 for qemu-devel@nongnu.org; Sat, 18 Jan 2025 05:09:20 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@gmail.com>)
 id 1tZ5lW-0008J4-6r
 for qemu-devel@nongnu.org; Sat, 18 Jan 2025 05:09:19 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2161eb94cceso36723835ad.2
 for <qemu-devel@nongnu.org>; Sat, 18 Jan 2025 02:09:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737194956; x=1737799756; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2opQBsl7rqm5zIKEYdaNZzsCdm10KnWISlLhTd4FScw=;
 b=QDnBUQOG/0d3upD4xOD44wjpRHIuhd5Tct671Nx+VCTmw+M9CNIjnHkqLqHZf3QYTH
 T4RSFKaiopzLOvEkfa6oR8rrXs1Tyy/daMYmNkTItBFb3WhwraDmwe54LEODezSWd68r
 3Tm2sDwyYXi6/0N0Krkpj+siX/xSqI8GhllKXB6EiC6pxgNGJZqVRiPkuhmlvEcy9sQ7
 E/+yxAoJ//i88rt1cBZwjpTdHp6jp3cha0yLbc7BN/u+5GgdlAhfixPd7pT1SBhq+34C
 XpwhXw7H7ENgm5/IJT3LlrNUnEjYdHyLZVsKD7m/pjXqdY6gnI32dgp+Gf9aAOc2R9oA
 CKpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737194956; x=1737799756;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2opQBsl7rqm5zIKEYdaNZzsCdm10KnWISlLhTd4FScw=;
 b=NR2UPqy+ajW9nj0heGL4JCdcFn/ISOHk5SwvH7acZK7e+swRn95mAz2gfIQWuRqrbV
 Kdj1GKCrmLT2+WhifZpaHZ4Bg1Zk33HXg/8vwlQdxKufNlhEyE7fAFpMclv1QV2HnLqI
 NQ5ZPn18RWwGM66WeZZP6YHk4+NWak2dfCcv1lbJiWxJSxY3KpeoLhvnqXkCjIOJVS6Q
 ehe09HjN97KaFpFBmNn2YS+QbpwOURE935VF/CfY++ExdKUorfN5rdZ5yfLUEpyNJRkZ
 wLFTW9HvAquLNw/QI+2jtadLxLvw72+nTBiHx86yhbi0YNKjauRUcIPpoBE1/+5QNzvG
 dBDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHmeYpFEijlwFcV3VG/GcIPhIkmgZXFiZHU1OinQFmA+Fe+jcrPlmq2l4DE6G3o4BODVzTziwOdeqO@nongnu.org
X-Gm-Message-State: AOJu0Ywdh/pOkhWohr+81FR+SSBlKyK9Bss2JMA+ZvSJNNd+/gZMTU4e
 +J3KCp1N/85dTzd9kcB8rusBMYSFMyMGcRNn2qG9UiZt4tFknSrJHNxO4faQ
X-Gm-Gg: ASbGncvcA8My1yfH19cfA1c0hm9gOVdzRYhaz0ixHnobqocymMCTRNFoQzybDUyg+bv
 NInR0W+uawuuG6lrrmQX59moCPZEESMj7Xqh11S4oKc0JPbvFpHZQLPtzq3n0J9i7FuGPFRK6rr
 lYosRgcqlGXMvq9+ApoGflMYhC8NSNWUMMW5fEAJM04hIFj8twJPUGhTmKULJGHc2D9RwXpIPta
 ZqHrOkXssNlpWYfafosNB8uL9uOyMaPefW0iauPM8jrOsT0j9yNwyEz+ZGWHq6yQNthG7bHQSa5
 2w==
X-Google-Smtp-Source: AGHT+IHe/YtWpwNDmPwJEDsxusye9QgmUSuolWE5/AuqR00N9cXJkgJq1XVYm7dadgHBrU8mK5dbGA==
X-Received: by 2002:a17:902:ce01:b0:212:63c0:d9e7 with SMTP id
 d9443c01a7336-21c34cc00f8mr86131785ad.0.1737194956298; 
 Sat, 18 Jan 2025 02:09:16 -0800 (PST)
Received: from [10.4.77.176] ([118.103.63.141])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2d3a87e4sm29221515ad.111.2025.01.18.02.09.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 18 Jan 2025 02:09:16 -0800 (PST)
Message-ID: <0e59f286-15d1-426a-8012-0370b07f149c@gmail.com>
Date: Sat, 18 Jan 2025 19:09:13 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] net: Fix announce_self
To: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>
References: <20250117111709.970789-1-lvivier@redhat.com>
 <20250117111709.970789-2-lvivier@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@gmail.com>
In-Reply-To: <20250117111709.970789-2-lvivier@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=akihiko.odaki@gmail.com; helo=mail-pl1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On 2025/01/17 20:17, Laurent Vivier wrote:
> b9ad513e1876 ("net: Remove receive_raw()") adds an iovec entry
> in qemu_deliver_packet_iov() to add the virtio-net header
> in the data when QEMU_NET_PACKET_FLAG_RAW is set but forgets
> to increase the number of iovec entries in the array, so
> receive_iov() will only send the first entry (the virtio-net
> entry, full of 0) and no data. The packet will be discarded.
> 
> The only user of QEMU_NET_PACKET_FLAG_RAW is announce_self.
> 
> We can see the problem with tcpdump:
> 
> - QEMU parameters:
> 
>    .. -monitor stdio \
>       -netdev bridge,id=netdev0,br=virbr0 \
>       -device virtio-net,mac=9a:2b:2c:2d:2e:2f,netdev=netdev0 \
> 
> - HMP command:
> 
>    (qemu) announce_self
> 
> - TCP dump:
> 
>    $ sudo tcpdump -nxi virbr0
> 
>    without the fix:
> 
>      <nothing>
> 
>    with the fix:
> 
>     ARP, Reverse Request who-is 9a:2b:2c:2d:2e:2f tell 9a:2b:2c:2d:2e:2f, length 46
>          0x0000:  0001 0800 0604 0003 9a2b 2c2d 2e2f 0000
>          0x0010:  0000 9a2b 2c2d 2e2f 0000 0000 0000 0000
>          0x0020:  0000 0000 0000 0000 0000 0000 0000
> 
> Reported-by: Xiaohui Li <xiaohli@redhat.com>
> Bug: https://issues.redhat.com/browse/RHEL-73891
> Fixes: b9ad513e1876 ("net: Remove receive_raw()")
> Cc: akihiko.odaki@daynix.com
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>

Thanks for finding out this bug:

Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>

I believe this should have:

Cc: qemu-stable@nongnu.org

> ---
>   net/net.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/net/net.c b/net/net.c
> index c1bb19a52373..9cded70dde74 100644
> --- a/net/net.c
> +++ b/net/net.c
> @@ -822,6 +822,7 @@ static ssize_t qemu_deliver_packet_iov(NetClientState *sender,
>           iov_copy[0].iov_len =  nc->vnet_hdr_len;
>           memcpy(&iov_copy[1], iov, iovcnt * sizeof(*iov));
>           iov = iov_copy;
> +        iovcnt++;
>       }
>   
>       if (nc->info->receive_iov) {


