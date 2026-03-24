Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD153FEC0E6
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 17:26:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w55WW-0000Le-JK; Tue, 24 Mar 2026 13:26:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1w55WM-0000HM-W3
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 13:26:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1w55WL-0006NT-EF
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 13:26:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774373183;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hNq0SuMZYNgje4Y1Gxj6WXavOKLXubnQySKZN/R535Y=;
 b=R5GSUskIAIH76xLOR7C/BG5xcnquxHGuCvZ1tKysG1ZnSxzx1imoOeWtyUi4e/GlSp1K0w
 gj7bf9f6FPJDiZYpiCNYswitDVwhxAcXlwgvd9K/zrSDi6V998KXYiUWPR+p3iL+xV9QuQ
 0rEmuWCtpT/F32oKiygw6whz7EOgtJM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-497-x_N81YpoNf-F9wz6tiTwzQ-1; Tue, 24 Mar 2026 13:26:21 -0400
X-MC-Unique: x_N81YpoNf-F9wz6tiTwzQ-1
X-Mimecast-MFC-AGG-ID: x_N81YpoNf-F9wz6tiTwzQ_1774373181
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4836abfc742so30501565e9.0
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2026 10:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774373180; x=1774977980; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hNq0SuMZYNgje4Y1Gxj6WXavOKLXubnQySKZN/R535Y=;
 b=fxR3c61xDXMgyb36tzMGKsUaNG8BNNTSPenMK1c4eIkGbRC1npZ3Z7cXkCQHwwm83Y
 MvMocJAySRL6tWLSvqy/4evDYify6EDTOZ1NVChPZZ+s7hk26lIJCamu9I09WgeV0551
 uWLmdqs31BqlkPS/DEqre0tiswEDQbe8o05Bjc1bDTBfaPGpwo3d6HCwDcqSIlFLi8rQ
 23hXGDcNysukq09TAYk+AP96FWfCcyN4h8uDqacDxKA4MDyQg0AtpCWhPm6f+Y7T62lA
 TpfmAcbpKUQo9g6dS09FeqIObnqfXigekpYmEuDF73OFY098co+3cKVJ6VrncCF/7mqG
 atxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774373180; x=1774977980;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hNq0SuMZYNgje4Y1Gxj6WXavOKLXubnQySKZN/R535Y=;
 b=RGSvTwvM1G2O3SuHIPzR05Sbg6zro+xv1DR/gKiux0OsPK/oicWR6oO4vhLDaCXDgx
 CJmSJONsN/RQMKt3lxcvOdg49igLDRE4IKttsUnWHv6tRz4mUoM2b0e/ubaEvgcclvbQ
 wzoRqgSwZlJq8ugUCmhR3UI9zIG23LfpTxXH1JZC8OIzubZwLLHk+UbD1Vp5fFBDICgl
 Ztuw/qBvzFyTv7S702kT4aCNh7FZu4kqjHC/nMQbpYZ+kZsQ6cTUqXON5i8TDOnIPhld
 zYTMiNnuhWLwa+MXWLjwUM0xAl6vGAS1VR56ySIOh4G+F/cidk+M+bbTJBad7rZcB4YR
 gSig==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8PEcf6LkLiKCLd9HY3RyeXyYBF8524PSlubx206/XrpKUhGkOIxrLOxySGLTBMS8jqXVRJ+YHgpAf@nongnu.org
X-Gm-Message-State: AOJu0Yyd5H4ugS31Rsy8/O7F/3Ojyfxn133ae3uMpvGeBxR+SsyCkIiZ
 aoM54JEJQRB0Q6wH+U376s+PVJKB0cauF/5XgiN2W3BTpyEQ+NmaZ28D+MGvzOgspi4xWgPk4EW
 6m6cD8jlGbtVeWjWsnEXPw9BehCxMDOlWm9jF2/r9VgfFLe7Z2dFsUn95OCQSE84j
X-Gm-Gg: ATEYQzwI36xmVoxtT76k+/xaLDEOKySsKMbw0dQRqpEXazIvChvzioMYVOsxBC9MKqp
 r4kHHiUwxX5PG132zNlYHDAVKfvobm7j5JTXpza01GCgamPz4lSvPNiC1xsBCQX71UB+4AeIzkx
 Ha1YDFE81OTYRBj8U1xZtfXXUtQY7WiGRnM3AoauXNoOainJfusS6y1EKceDnBep/NRzkngc57l
 q5o1n44UhR/TEAvGAGGKRGk4ExAmabM6OBEZ9JQUeKkiq9TATUDvoju9h7HoYpluOOAzSmckXhj
 HJxPK9fTOi/w/SOg7unViGoftJ7IPecAlfEniVOzsyog9X9+OK7AyvYFPtqgN6XiDAJFpON4lcl
 VdwwBsHfR65bea3YC/K8vUypS6qg/kXRmJ5qc7KvVKtUofnvpK53phsh3rh7pTOqenQ2OFBtr26
 3ZzEw+Ke53Oppmm130zK/g9zqqJwLtFLtFBnCoJbzUvwP7oQ==
X-Received: by 2002:a05:600d:8:b0:483:1403:c47f with SMTP id
 5b1f17b1804b1-48715fb7246mr7811595e9.6.1774373180148; 
 Tue, 24 Mar 2026 10:26:20 -0700 (PDT)
X-Received: by 2002:a05:600d:8:b0:483:1403:c47f with SMTP id
 5b1f17b1804b1-48715fb7246mr7811165e9.6.1774373179649; 
 Tue, 24 Mar 2026 10:26:19 -0700 (PDT)
Received: from ?IPV6:2003:cf:d737:d03d:8a89:7a8:8c2:97dd?
 (p200300cfd737d03d8a8907a808c297dd.dip0.t-ipconnect.de.
 [2003:cf:d737:d03d:8a89:7a8:8c2:97dd])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48711117377sm22976235e9.36.2026.03.24.10.26.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Mar 2026 10:26:19 -0700 (PDT)
Message-ID: <cf2e482e-65fd-418e-bdda-9948c2b39ff3@redhat.com>
Date: Tue, 24 Mar 2026 18:26:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GSoC 2026] vhost-user memory isolation proposal feedback request
To: Han Zhang <ihanzhzh@gmail.com>, qemu-devel@nongnu.org
Cc: stefanha@redhat.com, tfanelli@redhat.com
References: <CAHjCdDAJomXwQ8Z0kkiDGn_8hLWredsby3Nwy4rRgeC9sywc8A@mail.gmail.com>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <CAHjCdDAJomXwQ8Z0kkiDGn_8hLWredsby3Nwy4rRgeC9sywc8A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
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

Hi Han,

I’ve taken a look at your proposal, thanks for submitting it!

It clearly shows you looked into the code and the vhost-user spec and 
made yourself familiar with both, that’s very good. I find it a solid 
concept. I also like your clear separation in fundamental work and later 
optimization.

I have one question: In the optimization section, you suggest using a 
memory pool. I fully agree that’s a good optimization, but it makes me 
wonder what model you have in mind for the original implementation. Do 
you plan on allocating a new buffer for each request? (To be clear: I’m 
not saying that would be a bad idea for the initial proof-of-concept, 
I’m just asking for clarification.)

To help make these detail questions clearer, could you lay out how an 
example request from the guest to the vhost-user back-end would go 
through all the layers, and the response back?


Hanna


