Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49157D5B175
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 14:44:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vV9nu-0001CX-DI; Mon, 15 Dec 2025 09:44:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vV9nr-0001C1-Tr
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 09:43:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vV9nq-0005hY-Dd
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 09:43:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765809837;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=KbmBVMaKs2SCvs0kY5sFfZiNDopO0kTBitZ0Y6fYXHo=;
 b=N1fG/umu2LS46cyhZusqofm3CZvD2aTSaIhgPRfM1F7YtNsMnAaYXKYDK9n57C4qtc/aDg
 TA/dkn0wpJwDTZEz24b0NJp8W7xigCQrRw5DlKdf1yf76jPoxCGrTpa+uctZWa2jlXXz4l
 3WCI66th1pOyq5EFONXH8KXbJtcQBhE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-474-Sj2W_paKP-C9O052Sj6WSA-1; Mon, 15 Dec 2025 09:43:56 -0500
X-MC-Unique: Sj2W_paKP-C9O052Sj6WSA-1
X-Mimecast-MFC-AGG-ID: Sj2W_paKP-C9O052Sj6WSA_1765809834
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-430f433419aso1282164f8f.0
 for <qemu-devel@nongnu.org>; Mon, 15 Dec 2025 06:43:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765809834; x=1766414634; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=KbmBVMaKs2SCvs0kY5sFfZiNDopO0kTBitZ0Y6fYXHo=;
 b=P/Nz7gluZ011tuBQ1M+bp8UKW1sJc1gLJiqm+myy1mN3M9VaQ26xgTpHJCN1BeDc+L
 z8UPQ281b6XJ5STtl0yrdEwxUfShiP//siBzXM31lG0AbWlyvnmpn72nUKhqVT6gVbUo
 5sYCjINYDdQsASKRU1nvP+geAYMtnH5V7MuCDNEMdpkGnCAnJ0bWFK/JsjOdM4t1RTsI
 706XWfM1PJyvjSDwpw2+qkA2tOJQykuzhVcra0A9UyDCbVhH3mOFhzxh92HH4yDIeRq1
 MJKxpy0PBd1zXzJCFEAnzCFs8wSgICwMpCpPrXXn5x3RbwBP0ZSNkSWfG7omwiqubSWr
 YSeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765809834; x=1766414634;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KbmBVMaKs2SCvs0kY5sFfZiNDopO0kTBitZ0Y6fYXHo=;
 b=cm13ScyJa09SQo1NTryqGRMmVSNt2Jl3UH5gjE37ju1hkKDYNRwS3IUq269CYQ6O6w
 hhn2MXfIlb0+XbSv+ZzJTgg3fnywB0wQnMuDNyZH8EQmUuwclyWzupaUxprQorI7kZKk
 mI+IRj50JHLJV7R6x13RqITaJtba4Wp3qHC/k51LQq+me5A8fFNJBgCx4rOHI6aX2RzP
 V2UJ2vSP2/wPmmf3ZMqLGGYrRAnE2bUd2PyhUyXIz7TVjSgGO7BCWVs17YA0dB/+WqDa
 OK5xIGVXNiwWkl51DVUET2Bzso2dJLPWVdsbOVRFPLr5IKpy34ZOE4qJxm7C5Y0q9Nhr
 AWUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUe0OxA4FV7YHT+KLa5QN3eOVBXkPji2xeCeV9C5IOwq/SZMdlk5oFtQIJPW5fo1xYNQeb+RySxkfXc@nongnu.org
X-Gm-Message-State: AOJu0YwgPIpvGvlB+iQR+JiYdWnn4Cf6rb/RujQ8Fc4daH8+YlcdLDs0
 ViSwJyjQCwCnHbyNIEaVoCgx85ZmFIMtd20UHR0eCQYLaXrbDHRtLqp8pSNZVjT74uX9e/HzuJ9
 APwz2c4ejwRkH27obdt9XshJaHL+6m/6tFsYQ7W79EfmDSnGRkoicNlt0
X-Gm-Gg: AY/fxX5/9qUf96NCdGMYZaOxqDQJQ+Oi/xST263N1fs3JS7lgbHe0661hO5m1xzzijf
 8qP6Eev9n6rClj/cYisw1XpRdy+52eTP7jAi7TGcvJT0xhRVyjJGOh+jqW+ra/+mEvcRikj+JUc
 5zs80IQAEZZX/gMmnmo+PrIkroCLYEh0hQZRl0I3iJWpLT1Uf9V9sJ8jhy6kEbT7RGs7ORhotxC
 XAtZqvGYPdxhu4m+VI2b+vO21HH96rHUtnIZqfr9Eyeuqlc8m1B+eFwGrQGa00W7GCt8hcrXij4
 yzyK4+KUSv5DW2XLfr2Uh9/kqsv3aBRmyfa9vtgx2Cmo3qve4ZOxzDKcE8N5aIfQ+gRJmw3svIS
 XORiiqSqjJhdC9pKn7I+vgvp+Js1W3LPKvE04hx9AiEtdIAFfLhvv+E/hpG6fsbZPQY6RgoidxO
 Mn2FFl0oLXBO6OBRs=
X-Received: by 2002:a05:6000:2003:b0:430:fdfc:7ddf with SMTP id
 ffacd0b85a97d-430fdfc7f3dmr3346984f8f.42.1765809834076; 
 Mon, 15 Dec 2025 06:43:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGE8z7d28O5QIYZWoRf+K+IW6v0b/UhSS4nFlmnvJmnnvSIBIqZMZaI0o6LAB3W1sR28YpbMw==
X-Received: by 2002:a05:6000:2003:b0:430:fdfc:7ddf with SMTP id
 ffacd0b85a97d-430fdfc7f3dmr3346950f8f.42.1765809833591; 
 Mon, 15 Dec 2025 06:43:53 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-430f6e78a7csm12109808f8f.34.2025.12.15.06.43.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Dec 2025 06:43:53 -0800 (PST)
Message-ID: <159ced33-46e4-4b86-85e7-eda01406f768@redhat.com>
Date: Mon, 15 Dec 2025 15:43:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] thread-pool: Fix thread race
To: Marc Morcos <marcmorcos@google.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Dr . David Alan Gilbert" <dave@treblig.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, Marcelo Tosatti
 <mtosatti@redhat.com>, qemu-devel@nongnu.org, kvm@vger.kernel.org
References: <20251213001443.2041258-1-marcmorcos@google.com>
 <20251213001443.2041258-3-marcmorcos@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20251213001443.2041258-3-marcmorcos@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 12/13/25 01:14, Marc Morcos wrote:
>   
>           req->ret = ret;

Better use qatomic_set here---will fix it myself, thanks!

Paolo

> -        /* Write ret before state.  */
> -        smp_wmb();
> -        req->state = THREAD_DONE;
> +        /* _release to write ret before state.  */
> +        qatomic_store_release(&req->state, THREAD_DONE);
>   
>           qemu_bh_schedule(pool->completion_bh);
>           qemu_mutex_lock(&pool->lock);
> @@ -180,7 +184,8 @@ static void thread_pool_completion_bh(void *opaque)
>   
>   restart:
>       QLIST_FOREACH_SAFE(elem, &pool->head, all, next) {
> -        if (elem->state != THREAD_DONE) {
> +        /* _acquire to read state before ret.  */
> +        if (qatomic_load_acquire(&elem->state) != THREAD_DONE) {
>               continue;
>           }
>   
> @@ -189,9 +194,6 @@ restart:
>           QLIST_REMOVE(elem, all);
>   
>           if (elem->common.cb) {
> -            /* Read state before ret.  */
> -            smp_rmb();
> -
>               /* Schedule ourselves in case elem->common.cb() calls aio_poll() to
>                * wait for another request that completed at the same time.
>                */
> @@ -223,12 +225,12 @@ static void thread_pool_cancel(BlockAIOCB *acb)
>       trace_thread_pool_cancel_aio(elem, elem->common.opaque);
>   
>       QEMU_LOCK_GUARD(&pool->lock);
> -    if (elem->state == THREAD_QUEUED) {
> +    if (qatomic_read(&elem->state) == THREAD_QUEUED) {
>           QTAILQ_REMOVE(&pool->request_list, elem, reqs);
>           qemu_bh_schedule(pool->completion_bh);
>   
> -        elem->state = THREAD_DONE;
> -        elem->ret = -ECANCELED;
> +        qatomic_set(&elem->ret, -ECANCELED);
> +        qatomic_store_release(&elem->state, THREAD_DONE);
>       }
>   
>   }


