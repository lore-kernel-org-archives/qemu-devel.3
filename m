Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BDCACD4F47
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 14:11:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNtFo-0005OQ-F5; Fri, 15 May 2026 10:11:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wNtFm-0005NA-EA
 for qemu-devel@nongnu.org; Fri, 15 May 2026 10:11:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wNtFi-0003qE-Ip
 for qemu-devel@nongnu.org; Fri, 15 May 2026 10:11:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778854257;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=HH/bGUDNwdcv2uSBsJ68cqnSxFkwSSn7GY94zUTPcvQ=;
 b=hJmDMfUjms4dbLJh5CeL0XWLQHa+vhUrHu3ldAARXGZ1Snp4z3isa3ZQvY7mNXhSBq31rN
 Ix31LNQqupZ9SUOtHi/H2MxAiVV2bpDLE9tdeMV6cIrnz2IxlkJy4GwzUHqnr/kufMEhoC
 ZJWF7LIkGkcMozIyfSkGNuchIrax8Oc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-aidYUcKiPiyVkstJvqVLyQ-1; Fri, 15 May 2026 10:10:53 -0400
X-MC-Unique: aidYUcKiPiyVkstJvqVLyQ-1
X-Mimecast-MFC-AGG-ID: aidYUcKiPiyVkstJvqVLyQ_1778854251
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-48fd396daedso13820995e9.0
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 07:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1778854251; x=1779459051; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=HH/bGUDNwdcv2uSBsJ68cqnSxFkwSSn7GY94zUTPcvQ=;
 b=gB7UNmllqvzNMaxWDa9rfTu2OWLBjTJu5K2NMZmQ2g1R+n7mzlSIOuQiNQvpJSPNzm
 cVETyCYbp6be+TRIFCkX/nfSC8JvsEgQG9S4sDb8kvq8zhKGdTT9IrMVQw/C1blGD3x1
 RoMi6cU38oLlEFxQgNeq5JoOmiuvD4hbBIxN71nYYCCFBFjjpknb+sU7rTr0mRIixbd2
 pnqP0+k46QNuYcxrOzO3rM5ShQI5ASFr2+YrGafUV6JUYdWYVwEEyKJUIhRiFGQT3VZl
 fXFi4XzCqW9vxkDIO3DHRRNEeKB/YjW5y1XCLR/WgHMwLKI4w3U1f73N1wg6bVaTaYxg
 GKyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778854251; x=1779459051;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HH/bGUDNwdcv2uSBsJ68cqnSxFkwSSn7GY94zUTPcvQ=;
 b=jhrY6zYfvtbGAGS9+f8AjmMHi/ynMdyBp4t0eHsorSRC/jUaDKoQTCModjTPx2FPyJ
 j5t3WMiZ4lni27XecDhmY8ZsH99tyGmzaU8rpOuD7RDtc0tfr+IodSj3DN/iGfK2O5wa
 H5KEwokMo0PqdtrmIXMAZRngZ/vNs7Wz76VMXpdMdiyauXXITYQ4dLzf6ZznWeD2w1rz
 e0tA+vip6FEX0n7I2+4MEtWh7tcnT4HaHabCKUTjJiolrbpCpMzMw7uHPypng8mYE4Jj
 oCzNouTE/v8FUbHPj5XJZkpWmeV1xjqGGrfhUy80au4t1WCfgTuLHZaAfWmkc5tuwo5c
 9Exw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8v29jnBaPLk/rW20SU0DC4C94gs7EhVZA7+RVgj6PSr00yuCn7uPt8wrbHt/T5ONNWlc1Rs/Nb/mVC@nongnu.org
X-Gm-Message-State: AOJu0YyQTJ5ZnP8Arpc/dnjOk/VKUdMoTjOGsCC7i5TP5vjqPluU+hpA
 hjS3x68H04WJL+IvGom7+loKrIIAx6KFy93pvYAspvkEFJfUhtqFSuLJ1f7xtnrS5Y0l4h8X2hW
 JTcPVB6z8WqSTVv5JjdQJvv3yWMco4DxKj/p4tudh9PracB4sWyqGB7QB
X-Gm-Gg: Acq92OF5xqHdwaV5rp0rnHeB5HaXtzqgE1ne8Uri5Dd3TRoCahnm6EGlAJCTciEWRHj
 tLy7IocW8DAli67GWyBXBkqXpsOnp41N0SMQGXFNzrhhpZNGDHPtHjqFOOt3w3o5t4WRRqSBFwM
 nR5oIOOZALvPny0ihFp/+Rf6Vy9odH9nDaUHH5lkR6WU/yojk4Utm/DVJZnFPkn0R/BOgS4G3Vz
 SqndXIqv9F2NhORRURPWbR+k+lc3P6ItIxD3BQPwMVxax05Tr/d/FJhczJP8Gb4lzjNeu/I3rL2
 oPqdoPtWLCeSYatMSGlNmeBipV0fMWmbq1pVYFD23qj+OqHnLr3tQP9PzU/T/7zFucepFxykF4d
 hSxXm35Xt8/ekcasb9A==
X-Received: by 2002:a05:600c:37ca:b0:489:1b10:d896 with SMTP id
 5b1f17b1804b1-48fe59af198mr63730535e9.0.1778854250678; 
 Fri, 15 May 2026 07:10:50 -0700 (PDT)
X-Received: by 2002:a05:600c:37ca:b0:489:1b10:d896 with SMTP id
 5b1f17b1804b1-48fe59af198mr63729905e9.0.1778854250213; 
 Fri, 15 May 2026 07:10:50 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.114.83]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48febf81970sm20321685e9.8.2026.05.15.07.10.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 May 2026 07:10:49 -0700 (PDT)
Message-ID: <b4d40be0-b236-4f1a-af04-cc155c6088b7@redhat.com>
Date: Fri, 15 May 2026 16:10:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/qtest: fix discarded const qualifier warning
To: Matthew Penney <matt@matthewpenney.net>, qemu-devel@nongnu.org,
 farosas@suse.de
Cc: lvivier@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 QEMU Trivial <qemu-trivial@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>
References: <20260514191844.105888-1-matt@matthewpenney.net>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260514191844.105888-1-matt@matthewpenney.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
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

On 14/05/2026 21.19, Matthew Penney wrote:
> Modern compilers warn that the result of strstr() may discard
> const qualifiers when assigned to a non-const pointer.
> 
> Make 'found' a const char * to fix the warning.
> 
> Signed-off-by: Matthew Penney <matt@matthewpenney.net>
> ---
>   tests/qtest/libqtest.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
> index bf9284b9a1..b1e06ea364 100644
> --- a/tests/qtest/libqtest.c
> +++ b/tests/qtest/libqtest.c
> @@ -2146,7 +2146,7 @@ bool mkimg(const char *file, const char *fmt, unsigned size_mb)
>   bool qtest_verbose(const char *domain)
>   {
>       const char *log = getenv("QTEST_LOG");
> -    char *found;
> +    const char *found;
>   
>       assert(domain);
Reviewed-by: Thomas Huth <thuth@redhat.com>
Tested-by: Thomas Huth <thuth@redhat.com>


