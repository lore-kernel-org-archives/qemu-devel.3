Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1908CD4F3C
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 13:52:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOyNn-00012Z-1F; Mon, 18 May 2026 09:51:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1wOyNj-000120-9i
 for qemu-devel@nongnu.org; Mon, 18 May 2026 09:51:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1wOyNh-00063M-FO
 for qemu-devel@nongnu.org; Mon, 18 May 2026 09:51:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779112236;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=rWmWEhAQdjqAqGNl+PevpQ4eorPS6xtb2/KPc3H/uOw=;
 b=Td6taSm/TeFwoHKGfRMy3mX00JNKKKsfrer81qPhvn9oev+7Pm6JndLBmNTXPhmgYW3iSb
 8X6+A+PQSfSqh24cG2FoZuz9Sei0Hsnqal8eVFoQmlpZS9mR2msX3hT6eadKUzVu3cuVj9
 V1JReabpE7MBs5ZFWbZsgqN3bq9DrPY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-451-pHqc5kM-PEyk51gWBSHI3w-1; Mon, 18 May 2026 09:49:29 -0400
X-MC-Unique: pHqc5kM-PEyk51gWBSHI3w-1
X-Mimecast-MFC-AGG-ID: pHqc5kM-PEyk51gWBSHI3w_1779112168
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-45e78dd7baaso1272181f8f.0
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 06:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779112168; x=1779716968; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=rWmWEhAQdjqAqGNl+PevpQ4eorPS6xtb2/KPc3H/uOw=;
 b=frHdBhaVXdtB2ILrIWXna+C/rsxNc900M3/vcJAgJmEeQ4uMtee3iE4Qd1FmoGasah
 d/hPOkAYQNEV9R2nG6HXxhgH5844DzIgC0NRZr98PpuKGZerAjW/irSEbOdtBHFfxuYG
 9Zm1Pj6fiXM2OGg2dGOJjCN2g+Qrf8u2Cw0HIAsYN77x4rad6CzS7Q6RPeqQDt46CpRf
 oA7xToAZ8CVBQ/wUQ6iNn8gCbrtv1avZKvej64T/AWi36p2WyA4lVcAsd+HnZoFOxjFU
 0W/mFOsoYmNrmiJXrpu0dKHc91MMblZ8UUyKrvHhH+RCdNO3qBSe8QutQNAFMve3Px2E
 wQxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779112168; x=1779716968;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rWmWEhAQdjqAqGNl+PevpQ4eorPS6xtb2/KPc3H/uOw=;
 b=Vxj1FoxphnUwOdhbLP/sPa9jxkd/gypPXucfNQ5fUHbdxk+N4EmUiE6IylJaJs5p8Z
 aGg7lN3CtnW4jCdlaopZlOgNLMgCSmdEXnuvSxWW3aSkwoFsRGwdMW+dgssC1WZoZnlu
 rZoFN9rSUR1rknMvR/P0sW8GRjeZpCtM7HfSziA31XY66QGHef39mHjgPGyKFTcSUftG
 vQLgTAimfOgoDaIgFlgo+6fRoZQa7nL4/zv5Mhfq5GkpTB7EahgrGGm3H1iHqv+w3M1J
 F+nKf2VgxsTYwRQVawN6p+Fwm9IgpxY7I5dwHiz5KymoFVN/GQC0GwX2yChuMwBoEDIy
 x2Sw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/3rAKqWycRWhpN6HlD45m2PY1Gl1Xse8waNCevhP88QpGaHFDcbsMaVZJqb+XRlImmgpLzZa7xZYVY@nongnu.org
X-Gm-Message-State: AOJu0Yy88o4yP1SDFyLyeFXQIO5EMUrCaJx/0oi8HGEOXs2QUzrtFDr2
 kdTpMzKTrfsHvEdBdGU9ovP6c6JGvWiq2Wa27IuWMs03TwYKPciP3RofNmvPERun3Ox2tjJfKzF
 QaRour3zHKY8eOG8lTyXR6LeyeIMcg0TaACFEQ9X1iCWZ8/463oz+j2/Y
X-Gm-Gg: Acq92OGCDKzty3YJ/tvBm3LL80oINuM7AlwlU5AzufW4IpEfYRYMM5VkKCi7ALJXoLF
 iB+NnUR+6UlgYpBsPj1B2ogZQl/kK4WJElndBSCi68n/jqucp3uKMeC5MWkK63td32sx/P6Gx3i
 vtwTmYg9tQRbpvF0w2tAaZAMEfePyqlx38epwxqTAitWzJWsFptoE0yCHDhBCjy8fdSPoerZ3PQ
 Jyv5MR7f/PPjGGVY2e30koP6O78RKuXrGGQGaQNVRgGt8UQU6yfZvJSphnwBTqDp6ety1zS8kPD
 QA0ImD+99bvELKm2i1xhd5byr/wAJ3sygfMkrvuOxq/1tybDDVyNXb/ie6EdOuw7r5YwStsmRAT
 hKoyBtmNf4JjZ96ZwQ6bXxEFRKJhmKtpchEbNUxw4/TDr9sJ9q6+h60I=
X-Received: by 2002:a05:6000:2313:b0:448:7049:a6c9 with SMTP id
 ffacd0b85a97d-45e5c5b387bmr22665055f8f.5.1779112168173; 
 Mon, 18 May 2026 06:49:28 -0700 (PDT)
X-Received: by 2002:a05:6000:2313:b0:448:7049:a6c9 with SMTP id
 ffacd0b85a97d-45e5c5b387bmr22665000f8f.5.1779112167770; 
 Mon, 18 May 2026 06:49:27 -0700 (PDT)
Received: from [192.168.100.100] (82-64-211-94.subs.proxad.net. [82.64.211.94])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da0a19c2dsm38685201f8f.21.2026.05.18.06.49.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 May 2026 06:49:27 -0700 (PDT)
Message-ID: <49760042-7227-44ca-8471-dbea0b05307d@redhat.com>
Date: Mon, 18 May 2026 15:49:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] system/qtest: Fix length parameter in the b64write code
To: Thomas Huth <thuth@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-trivial@nongnu.org
References: <20260518134020.1420932-1-thuth@redhat.com>
Content-Language: en-US
From: Laurent Vivier <lvivier@redhat.com>
Autocrypt: addr=lvivier@redhat.com; keydata=
 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
In-Reply-To: <20260518134020.1420932-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lvivier@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 5/18/26 15:40, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> The b64write code has a sanity check that the given lengths matches
> the real length of the given data, and calculates the minimum of the
> two values to be on the safe side. However, the address_space_write()
> then uses the original value and ignores the calculated minimum. Use
> out_len here to fix the problem.
> 
> Fixes: 70da30483e7 ("qtest: Use cpu address space instead of system memory")
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   system/qtest.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/system/qtest.c b/system/qtest.c
> index a79d10d1361..d6db057b0a2 100644
> --- a/system/qtest.c
> +++ b/system/qtest.c
> @@ -698,7 +698,7 @@ static void qtest_process_command(CharFrontend *chr, gchar **words)
>           }
>   
>           address_space_write(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED, data,
> -                            len);
> +                            out_len);
>   
>           qtest_send(chr, "OK\n");
>       } else if (strcmp(words[0], "endianness") == 0) {

Reviewed-by: Laurent Vivier <lvivier@redhat.com>


