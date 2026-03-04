Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49F31EDEC1E
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 07:50:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxh03-0003X6-8m; Wed, 04 Mar 2026 02:50:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1vxh01-0003Ww-Lx
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 02:50:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1vxgzz-0002ei-Td
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 02:50:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772610626;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=jceWmQVXH0yzJzdeni8fkbI6OW8LtfYSIlzm4J4f+j4=;
 b=cyfwmZajaO6gIeKwhl/4NJhNjYmqm67R3Z0vjViy0FzJjgi3ljZ3AEx1Xs44FJ/f76bMzw
 w6TUtt7GvvXxwug/wVjqO8jok/YwetzU/3iCPSvxoFRlHThuUKTCnefKLCF36bzy3MlFTh
 m+bcZf/G9vOjioUUjxLUym9i0Oqv1b0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-673--1MZVIkaOyW97Rd4wMUqVQ-1; Wed, 04 Mar 2026 02:50:25 -0500
X-MC-Unique: -1MZVIkaOyW97Rd4wMUqVQ-1
X-Mimecast-MFC-AGG-ID: -1MZVIkaOyW97Rd4wMUqVQ_1772610624
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-439af7ba802so3452111f8f.2
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 23:50:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772610624; x=1773215424; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=jceWmQVXH0yzJzdeni8fkbI6OW8LtfYSIlzm4J4f+j4=;
 b=Wk9n8EM8blVFameU5PWySj5O5Np4NhwD/x9b2fg3ZBeA6Qw5xTzO0Ch0FmBFz1Nb1f
 IvaUp3b2SdN4Fwvf2fi9+/nRmpRD4BOGhhFYEPHqgnCvQjsqwkKFaz3YCydh3s2mZTdG
 iLUunt3MZYYFRtnP5dKh1lOK0n0FCxKHl3mYF43TleYJRePcfu8EY+GrgTjuFpH6XTpd
 pBg8F8EqYhksAO226++f7c7Vm3K5uI6LlO1d/BEWuEsNWN0PpeiD3skmPIwsjgQbJCHz
 RMc3G98UIYHzHvmEDOZquJsaTKDA67zGlaUGlF4D5AMoV68YzZD8MQf6NxYua8kO4z3b
 U15w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772610624; x=1773215424;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jceWmQVXH0yzJzdeni8fkbI6OW8LtfYSIlzm4J4f+j4=;
 b=twL/FkBogtDoJAzV8bs/TlVgyB2/MM8vW50EbaLgTiRez+CBIuJqrE4/Nq+hEhcSxk
 z6wN9WERISh4ENCsWDKy/Ln1p/5QLPVeLl4h82/pgDTYR640S8a7fGf9NrXVoo7VfePm
 lxRb/3TtSoxrIGhKJgrJLRchl5aE904DHAcNGpaXLBhPp4viylxKAejKqgiR+WzC5iSs
 ra3/JOgNHTANa8e9LskgE94snlDJON9/oNqddwanHYHeY00V6DmCb1fPtzeMXKz34tXW
 IlyOkhvgKM+gZZDib5uXHwM6T0YKYiru+/VN/f1RTvUZvcIp9sHUV0E9AYCn2AFYsEvy
 xhng==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9ZTd8upeR8i54FrmaOSxEmZJGSNj0UaZmk7bdPEEUcwce2tchwA7mCUTzl4FqWgcbGAcBX0erxK//@nongnu.org
X-Gm-Message-State: AOJu0YygTVvL9qRHfXjjQEDxC00Refyej8uFF+KPoAmvHgcmO+KAvfuS
 VqcYI5VCyIY/e93ttfNS+LKdaVVhDyzsTuoi81oRWYgW1NEOZ2Iu9MNLmO+gf9PyAlZgTR/m74V
 YPNVve2fmkwUtq5ZcT/BZIGMMlVJe67F/66Rcpvw2uUa9lsr2hfXeGezc
X-Gm-Gg: ATEYQzzDg4XO0x+z9c4WAmTGSAAVRSHGH/Pi7tSNkok5EwoKyIiiFV6YOt0vA8sMNTS
 Cvg+4FOrQqcY+aVndizBdOcIewrv9WvB4Jr2n4xhvXlEbAvC3LpQummuONGsKVO8wt8jARLvyYh
 qnXASNGlFfUj0UuEDFsOTREIlIyiRe9AJPN1DYLeUEIiSQyCLbmTM4I67cn/zFhbdFdKs1TxicA
 ih9HBikzm5ZhJOZPWzSYj16fDV2w5vpHN2d0Fvk1wS37Yb/umMts6FrdqikjoeCI/Ud9saol+Ri
 8raQneQVhi0sZ0tJvU/0ZJCQrxVl53JrIB4uLj0Bz80AYzBKlRD0fn6m7qjgN3t3JEHpkPY8rUo
 +5r+0EYs4646V6DPhze64GLXZSybJXbQup2E1EtwGwoGsAx2nMEd3aWn4ZjxSoC5GbQ==
X-Received: by 2002:a05:6000:310d:b0:436:369f:39f5 with SMTP id
 ffacd0b85a97d-439c7fe4149mr1915433f8f.43.1772610624338; 
 Tue, 03 Mar 2026 23:50:24 -0800 (PST)
X-Received: by 2002:a05:6000:310d:b0:436:369f:39f5 with SMTP id
 ffacd0b85a97d-439c7fe4149mr1915402f8f.43.1772610623817; 
 Tue, 03 Mar 2026 23:50:23 -0800 (PST)
Received: from ?IPV6:2a01:e0a:e10:ef90:4326:a36e:a7cb:624b?
 ([2a01:e0a:e10:ef90:4326:a36e:a7cb:624b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439b4175fd2sm25223168f8f.14.2026.03.03.23.50.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Mar 2026 23:50:23 -0800 (PST)
Message-ID: <4df4b611-f60a-4b4d-ac10-69b7562be037@redhat.com>
Date: Wed, 4 Mar 2026 08:50:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] Don't try to read the pidfile if passt got a signal
To: Peter Foley <pefoley@google.com>, qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>
References: <20260223-passt-v1-0-101c6ba1c88a@google.com>
 <20260223-passt-v1-2-101c6ba1c88a@google.com>
Content-Language: en-US
From: Laurent Vivier <lvivier@redhat.com>
Autocrypt: addr=lvivier@redhat.com; keydata=
 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
In-Reply-To: <20260223-passt-v1-2-101c6ba1c88a@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lvivier@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2/23/26 22:52, Peter Foley wrote:
> g_subprocess_get_if_exited returns false if passt was killed by a signal, so we fall through to trying to read the pidfile.
> 
> Update the error when passt exits to include the exit code.
> 
> Signed-off-by: Peter Foley <pefoley@google.com>
> ---
>   net/passt.c | 13 +++++++++++--
>   1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/net/passt.c b/net/passt.c
> index b3d4b71314..053c2f5f57 100644
> --- a/net/passt.c
> +++ b/net/passt.c
> @@ -270,8 +270,17 @@ static int net_passt_start_daemon(NetPasstState *s, int sock, Error **errp)
>           return -1;
>       }
>   
> -    if (g_subprocess_get_if_exited(daemon) &&
> -        g_subprocess_get_exit_status(daemon)) {
> +    if (g_subprocess_get_if_exited(daemon)) {
> +        gint status = g_subprocess_get_exit_status(daemon);
> +        if (status) {
> +            error_setg(errp, "Passt exited with code %d", status);
> +            return -1;
> +      }
        ^^^
Indentation problem (6 spaces instead of 8)

> +    }
> +
> +    if (g_subprocess_get_if_signaled(daemon)) {
> +        error_setg(errp, "Passt killed with signal %d",
> +                   g_subprocess_get_term_sig(daemon));
>           return -1;
>       }
>   
> 

Reviewed-by: Laurent Vivier <lvivier@redhat.com>


