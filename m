Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A691D47CD6
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 10:57:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vghVz-00053R-6g; Fri, 16 Jan 2026 05:57:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vghVx-00052w-PY
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 05:57:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vghVw-0002en-Es
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 05:57:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768561031;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=F9NfGLIILCJE93X62D4Nehh3Ajcehdh9OdXsCk75FDc=;
 b=V5DkiV8ubOOt9gTp4ZyZfLkNLlknOJbdd719zXmvIrqoYyZ5AKzjU0lKFzlEYf10KJdqVN
 2jR+DiELeAz5VuzVhfhwedpeSa1SYIm5B7AeledmYuLjSKYu9es3K97gqDqmCnQBD9zQWJ
 Ga0NM+PeMdKp2IRewre0deTXTwqJAcU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-6a72YCsaPQmpj60m6FoXww-1; Fri, 16 Jan 2026 05:57:08 -0500
X-MC-Unique: 6a72YCsaPQmpj60m6FoXww-1
X-Mimecast-MFC-AGG-ID: 6a72YCsaPQmpj60m6FoXww_1768561027
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4801e2e3532so4894365e9.2
 for <qemu-devel@nongnu.org>; Fri, 16 Jan 2026 02:57:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768561027; x=1769165827; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=F9NfGLIILCJE93X62D4Nehh3Ajcehdh9OdXsCk75FDc=;
 b=PN177NkjgKnn4UtvF7VYY6EHg2nj2enb7e33jN6n4m6SBNiKwAXnqCSGg3wduSYl6A
 d0Y8GQsYBv6f946SM/PnelBgTsmke0Ejxl2uzb/rN8Qbjyv1kuqrHJUb/kd9vfHD2RTe
 zfLkZEtP7BS5wZH1DpMr88yrSd6bJbzkBdfVFyHYaxkFNwOVUosUWsolKb/Un0LRBRc3
 1+EEeFksu2YFLvhNA7/E0rddlmBoehSU6BaODitOmVDP9sV5KIwYuSWbz8ujGMiDP5nY
 o6J6t2EptTTP55nsOYekLztzxPPrTxAoyI63eCEkKIQW5isRcaZO+tcdRfVZ087NWhsa
 Gk3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768561027; x=1769165827;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F9NfGLIILCJE93X62D4Nehh3Ajcehdh9OdXsCk75FDc=;
 b=ZOYG/aAKdMgUBBN5LV70ZGt2DvzoQ+y0KbeLvUheLDKWXG+zvVJXjdqnB7IqTN/6TT
 dujRaMsV29REZIstqAYGm+JqEj7zttjUs45e8kKW6P2FfmoLUSo380waBVRLYhREj03P
 8PWPeIFpwEYEFdXe4zNg90BQDfOyBjObbZnEkyznRIotCEWcw/5fJ+jbkICPAXoU0Ap3
 lWc1o4K5lVCQtYhkQuL76r+3pEB9u0B2M65zRoYJGJf6QAhbfwTrhDSTmm3W8t5lDoed
 BQFkAZj8XJ+WJXtzXQjslRAQbG9Zib/6+Rr/zjWX2B8IzSHjjIKjXsVLXU6y9HRlfmp3
 hufA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOwpIHCANeInCYnsl+rTmCX8XAJalhFik+srdzaFohVhIWMcNDTF/6nHAn5y3/X15VFMAHl/6+OnRG@nongnu.org
X-Gm-Message-State: AOJu0YzC/sBRriW39RtPlfGLtZCULDvuMEWS+KP3NKGGbXmHfbA5TnaM
 FsCj2o8vWGOh2Ay6vBBEC74AIJ/a8MXEkYTHllLbCJaq3548EednicRDSDqhdh4DM8RI3A4fbNy
 OBiO9o1I406s/j2+1T7BcmYTMiA4JqlNN2xaq4pTwv0Uap6RW8KFzsNUs
X-Gm-Gg: AY/fxX4mBuqnjqy53LaVpY/aqjEb1l5j9j2lF2QfUrIvbbfBc+apko2FY759/GSFhU3
 WrhEbVLUnLczXhySYpdEjGzgt9bPL1urBnSvTAj7ijplCFFxMkPo4Xg9o3t61czPLio0UTUHtr2
 jO5O9US2YjLmPtrq19oZaYNclAgefaFcCEMe0sFWt4mHOru4qlAcNmqa3732mndKkEP8gP3l1mf
 lrhutLkYjRqMJef0/CJs4aQucawIj9ND/beoytDu43pszQN5AbAgLQI7/aA33Z+fOiqCo0TTDDb
 C7hG71s2P+leGaloDDcKokTypt/Ax513kQdH+zjomcY3kdluDH+aQaduQJAsQJQeqaW/JwMo26A
 uCC37lHv710MsCFXxhHdqtAlu0uCNai5HG0kcG52GYbUGTTNe
X-Received: by 2002:a05:600c:8109:b0:480:1c69:9d36 with SMTP id
 5b1f17b1804b1-4801eb04f54mr21770805e9.17.1768561026969; 
 Fri, 16 Jan 2026 02:57:06 -0800 (PST)
X-Received: by 2002:a05:600c:8109:b0:480:1c69:9d36 with SMTP id
 5b1f17b1804b1-4801eb04f54mr21770625e9.17.1768561026575; 
 Fri, 16 Jan 2026 02:57:06 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4801e9ac373sm16277375e9.1.2026.01.16.02.57.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Jan 2026 02:57:06 -0800 (PST)
Message-ID: <ce4eeb41-4c35-4919-b315-3431b99f03ab@redhat.com>
Date: Fri, 16 Jan 2026 11:57:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio/migration: Fix page size calculation
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex@shazbot.org
References: <20260116060315.65723-1-zhenzhong.duan@intel.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260116060315.65723-1-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 1/16/26 07:03, Zhenzhong Duan wrote:
> Coverity detected an issue of left shifting int by more than 31 bits leading
> to undefined behavior.
> 
> In practice bcontainer->dirty_pgsizes always have some common page sizes
> when dirty tracking is supported.
> 
> Resolves: Coverity CID 1644186
> Resolves: Coverity CID 1644187
> Resolves: Coverity CID 1644188
> Fixes: 46c763311419 ("vfio/migration: Add migration blocker if VM memory is too large to cause unmap_bitmap failure").
> Suggested-by: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   hw/vfio/migration.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index f857dc25ed..b4695030c7 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -1173,7 +1173,7 @@ static bool vfio_dirty_tracking_exceed_limit(VFIODevice *vbasedev)
>        * can also switch to use IOMMUFD backend if there is a need to migrate
>        * large VM.
>        */
> -    page_size = 1 << ctz64(bcontainer->dirty_pgsizes);
> +    page_size = 1ULL << ctz64(bcontainer->dirty_pgsizes);
>       max_size = bcontainer->max_dirty_bitmap_size * BITS_PER_BYTE * page_size;
>   
>       return current_machine->ram_size > max_size;

Applied to vfio-next.

Thanks,

C.


