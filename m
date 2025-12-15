Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF9F3D5B17D
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 15:07:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVAAG-0000sE-5n; Mon, 15 Dec 2025 10:07:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vVAA2-0000mM-T0
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 10:06:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vVA9h-0004Yb-G9
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 10:06:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765811192;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=sNS5vjnHm2DF9FnNnGAwuQ0E4NMd1rpIjTLhsGKWTQc=;
 b=J43opsywa8sm4TBTesrlEld6tBNRdarGQ865nxkBlnTMRCFaVx2oe7sNhwV3EQFl0Olg6i
 eTpCLytdIlMQ7ZJ7DDoEyWmBgIHxkkg+aPSBWzbjT4IWg+/6WCg/ZTLVlO9siv61AyKyWo
 VCmqhTUBx/ONCwrMCIQdVoSbaTtbWnc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-6-x-1d76hdPhSAaYEHaAGtsQ-1; Mon, 15 Dec 2025 10:06:29 -0500
X-MC-Unique: x-1d76hdPhSAaYEHaAGtsQ-1
X-Mimecast-MFC-AGG-ID: x-1d76hdPhSAaYEHaAGtsQ_1765811188
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4779ecc3cc8so25330055e9.3
 for <qemu-devel@nongnu.org>; Mon, 15 Dec 2025 07:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765811188; x=1766415988; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=sNS5vjnHm2DF9FnNnGAwuQ0E4NMd1rpIjTLhsGKWTQc=;
 b=R0WliulYg6KhE2nMGv7X62nFTDr04gQ9avD4WLcqTzzrqnhv8d+FB27JtsEXTacn+S
 WbGSBa2FzyiDZb2BgISFJ3TKiNSJxwklcHqYxQvLJhpr2ip7yGkqLU/bEMgvc8TGqdrU
 RgUMcJgryyArkVzjob4+zP/UYvoim/rWkszdG+vy0hib30CuErYJ+1YY7nGut956ZgCI
 vUHH4LkJXjPMJ65cREZgsQsYjflNT60ZhWm0tgRu78TLhVyswZZF/4pl0GJoZ2+J57Wp
 WZp3goFLro0DtsqC3qYQ1h6pFbv3SB4wgKVbCcf7+z9lu3QND/Yf7z6BUFTnmct5YZa9
 41yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765811188; x=1766415988;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sNS5vjnHm2DF9FnNnGAwuQ0E4NMd1rpIjTLhsGKWTQc=;
 b=GSSLslSWLlaPez7ja5C/e4DWhFp2GqYFrmwOKWazaNPcKxb3Wp7GSJrdYE0zR+xZSH
 MKVED+Atplzh8TmDROO16TJaTPlTw+OEOqBOoiyKOpCw9aRmvTviYc1CcNV5s7xVtRLg
 23v5H1t9F6SEoMR0pvfHwjlqmNLOTQdt8uM9bgqIuRpUkIE+N03Ehv7DhfTnk/t+3kqO
 LGFaz/pLwXGUyA4s8kX0bltL/9aWrxhBR/lpwakpHagM+KzrXdQW50i/lXH0dFVX9jfH
 sZxY4hGD2dmIHReSphvI4KiyOisw2Cwyq1q3bNkwTT1GdG4lRwNgUuErlR+/pr92Rh9E
 6C5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLrzGHCwn8e8/Gh4KiIym1Vg3jArsoO117jPGjxtcz/fHFPyuPMpPPyciM9OvoTZ7dlM4biRkYCZDT@nongnu.org
X-Gm-Message-State: AOJu0Yxq97RPmMtxhsoOviVmCKFsAyJMDAiWMJOlj36M3w86vZ/5mPeP
 yQhFjDtA0Jp+q0e2xi5SHpVEEC0m6/mT+K35i4JM7jfTehRAt5gxCxiu9nQqo3/d8UlGQb6NXvg
 vqfiimk+cbc0g7TBFmquw7sluhCm9wCKhQDHou72mrNZ4iMEUz1CVp5Is
X-Gm-Gg: AY/fxX7KvS9dzr4xKVIzH+6wGInhSjPZuxxFvw9CsaXoX/2w/dc4j1XI2tFM9IyH9d9
 du++wrlrJ7XeEXLNpzOPSA4i0HmSzTMFuNT8ryaZtKoK3Z6TzGrN7HUu1DFTCsEfzHvLF+H5Tdd
 btSo1Y6Sob4qFCk2CoVzuHjAbySizRyFoUJaz7iLUd/6+SU1sU6XbnSSZTBlW3b2K2UUUXJOEDy
 mVX+RXR3AIJkn/SkHOnJvGG8eLb05hpqSSHbd6tfSzlTxm94ZOzjf7wvYQ/1phfGWIG04bKmD/Q
 vs8XWBOKDc3F7XLjxG7bQ7eANxVpA3bhIHqZgYQC/ad8dVaWCWHscqNM2eNC8fByiRI9yJqhsoQ
 nzo6o+qjCwa8yABF4vh9/QUdcifA6KtiUNjzAZIT+wRwC
X-Received: by 2002:a05:600c:6291:b0:477:5c58:3d42 with SMTP id
 5b1f17b1804b1-47a8f8c3cecmr120876715e9.10.1765811188201; 
 Mon, 15 Dec 2025 07:06:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFNSpj0AhQ3NGkM8Rxm9oVliCs1NRp0Dxy5bVSyMy/PguiXomXfGxt0/NHUAd4uj3ikkf/3lA==
X-Received: by 2002:a05:600c:6291:b0:477:5c58:3d42 with SMTP id
 5b1f17b1804b1-47a8f8c3cecmr120876465e9.10.1765811187704; 
 Mon, 15 Dec 2025 07:06:27 -0800 (PST)
Received: from [192.168.0.5] (ip-109-41-115-194.web.vodafone.de.
 [109.41.115.194]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47a8f38a4e9sm244121885e9.2.2025.12.15.07.06.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Dec 2025 07:06:27 -0800 (PST)
Message-ID: <375c6799-ea84-4dfc-a9ee-3fbd94611988@redhat.com>
Date: Mon, 15 Dec 2025 16:06:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [qemu-web PATCH] reorganize sponsorship page
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20251215144027.567313-1-pbonzini@redhat.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20251215144027.567313-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
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

On 15/12/2025 15.40, Paolo Bonzini wrote:
> Put all CI resources together. Azure was replaced by OSUOSL and AWS.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   sponsors.md | 20 ++++++++++----------
>   1 file changed, 10 insertions(+), 10 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>


