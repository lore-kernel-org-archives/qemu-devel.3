Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1C81E9537D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 11:01:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnadb-0001Pk-T3; Wed, 04 Feb 2026 06:01:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vnadZ-0001Pa-I6
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 06:01:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vnadY-0002qA-8s
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 06:01:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770202890;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=iX9CLo1079q9GFBbcum8ANwzEzOFk8ylauhc6MGrexs=;
 b=Ezr1xAi/GZGChS5YWPiZfmt+WaylCxdw9+RMED/ZI3/YCvz3TKi3l+xDJyJEoaRezILQE1
 KCAGxQr+ebnb2qG2FCnGSgQLvPylLf+euEVfvJZTLhouxrBDi+hL8E64mL78usrJXcyKXm
 lUEr4pLlmMVislxYtqn+aZVg2UJ7zzI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-JMWNhNN-OkSlIi_3hP64VQ-1; Wed, 04 Feb 2026 06:01:29 -0500
X-MC-Unique: JMWNhNN-OkSlIi_3hP64VQ-1
X-Mimecast-MFC-AGG-ID: JMWNhNN-OkSlIi_3hP64VQ_1770202888
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4806b12ad3fso55458035e9.0
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 03:01:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770202888; x=1770807688; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=iX9CLo1079q9GFBbcum8ANwzEzOFk8ylauhc6MGrexs=;
 b=HyG+L+KjCLiovCYY/yXpkqaP1y3i4/amSNRuU9p6MxhW1sNoSSzAWyvAC3l3ieNFxD
 34a2PrG6NhHBfmYu9Q5cvXSe4hFa7o845XEBntfl9Q+LpTZHURcn8vev0V/SJ0fD0326
 66jU4SQu04hF2NETuGqEZl0quiwgz2Q5j25143J393XWz7gYtQCCc7EXPXuPL+TTXz8l
 Kar/pYSL2W/mlvyEJkzxSp8AEGTANDgszQhr20w5UoHQ5ZPspJwprrmmzs0WyT5P+1EW
 0ZrSmBCi13igAz7wpEvAu1X7fXxjQbBVF+rz5c8AUUaYZzFD2cABbxX3xOJvnfhtEbHl
 vpGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770202888; x=1770807688;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iX9CLo1079q9GFBbcum8ANwzEzOFk8ylauhc6MGrexs=;
 b=pUdGymS9E6X+jgpyDpm7X82eDE+Jd2XXFyt9cvcQpaaafOsRGUBfi0c7UL/+O3mH3k
 76e9eJtV8WnU6DUnLOnla5wq+WenYvY4mR78pkHv7Zf2WcGR8VYGaJx9muQ3ynrc5AQl
 jcP2n25y5xiS3AL5wxNFet1R6q+p27DgIYRbVRSnuuCZH3ncX7yPFQeXjM4xfwxN1nTQ
 KZ9846G6gQmuVxyAb+cWk6LtKvWXTVHUew+jACN7oHG1fh5uZ6JTzqfABzYF+sIc0G9x
 WNg3dzLB5zv/X2aAIIiep457sS9c7GgQvrXQb+iVRN3lSYEiBI5gOt/FFlPvRYVy4XMt
 in1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWnjXxtvCHRM8074Z2I3/P6AueBjBgp7CI1ejuG9hK6YuUuuCuJL6wHjh+pP5NBCl4lT6Ybzn8Ey8Fp@nongnu.org
X-Gm-Message-State: AOJu0YztMWSBJXcu/u9Pwm7x8F1zkEq+1UoJZK1r+/pYleENhV1RS5bC
 0/h+NCeNpIFZ+OOcyQ0RXkD7Wg9zLe0VEqT9otDcYSFLFBCNlriep4eNTxZvTxzpaaBmiEu8fPY
 hZTxV/RTRXCUSduVvuaQPbYMYWQbbVNTz0N5N4U/6Nr/asr5SCJktiX6v
X-Gm-Gg: AZuq6aJ6wDJzVvYk/BCSZvAKd5CaN/qQsKls+XW4nacuFExrknzKnX8ECWYFbDdl3o7
 D7vSL52yfNXkCSoN2EDOT7WA8YyH0dcijFctWXDTnZ/rymWTnqEqVIpjr6IL6iRcKZsfDDVUlIC
 VKbYw5GkKx/F2NXPgh96OQ67xJH9jAxh68p3ThsyZjRin4OxzfiKrYt4IJDH8QhiTPcZ9cMyfMn
 k/Ekh3fBsiQFnBegJvPM9Vfxs07ywU0dr3wRdjYGx7R4julEiCHjSI9DZ6BVlgGI9LgVCIf1Sue
 lipNHUe4WhkNEVwkNcloNLlEdJ91EtHFoZLjaeskMUrQr8mtIeddhFe1LN6Bquc7kNwNMFIIRLx
 l83tmfq+ZYStWIi+nouNYNrUPZZXechRknLhRskmuBjg5dUM7
X-Received: by 2002:a05:600c:5309:b0:480:4b59:9327 with SMTP id
 5b1f17b1804b1-4830e93eb11mr32228295e9.1.1770202887786; 
 Wed, 04 Feb 2026 03:01:27 -0800 (PST)
X-Received: by 2002:a05:600c:5309:b0:480:4b59:9327 with SMTP id
 5b1f17b1804b1-4830e93eb11mr32227875e9.1.1770202887315; 
 Wed, 04 Feb 2026 03:01:27 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4830ec42833sm28680595e9.1.2026.02.04.03.01.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Feb 2026 03:01:26 -0800 (PST)
Message-ID: <f357d187-70df-4482-b224-47006f0cefec@redhat.com>
Date: Wed, 4 Feb 2026 12:01:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/10] virtio-mem: use warn_report_err_once()
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, Alex Williamson <alex@shazbot.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Ben Chaney <bchaney@akamai.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, David Hildenbrand <david@kernel.org>,
 Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mark Kanda <mark.kanda@oracle.com>
References: <20260204100708.724800-1-marcandre.lureau@redhat.com>
 <20260204100708.724800-4-marcandre.lureau@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260204100708.724800-4-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 2/4/26 11:06, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   hw/virtio/virtio-mem.c | 13 +------------
>   1 file changed, 1 insertion(+), 12 deletions(-)
> 
> diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
> index 251d1d50aaa..a4b71974a1c 100644
> --- a/hw/virtio/virtio-mem.c
> +++ b/hw/virtio/virtio-mem.c
> @@ -594,18 +594,7 @@ static int virtio_mem_set_block_state(VirtIOMEM *vmem, uint64_t start_gpa,
>           Error *local_err = NULL;
>   
>           if (!qemu_prealloc_mem(fd, area, size, 1, NULL, false, &local_err)) {
> -            static bool warned;
> -
> -            /*
> -             * Warn only once, we don't want to fill the log with these
> -             * warnings.
> -             */
> -            if (!warned) {
> -                warn_report_err(local_err);
> -                warned = true;
> -            } else {
> -                error_free(local_err);
> -            }
> +            warn_report_err_once(local_err);
>               ret = -EBUSY;
>           }
>       }


Reviewed-by: Cédric Le Goater <clg@redhat.com

Thanks,

C.


