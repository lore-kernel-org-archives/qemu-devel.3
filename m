Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B89DCA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 15:08:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usN61-0006pZ-MO; Sat, 30 Aug 2025 11:02:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1urskY-0005RL-HV
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 02:38:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1urskV-0007Ub-ER
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 02:38:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756449487;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=BGQ5qRLZ/dVY/7rHyQ0NoHm8va70Idrov02dYKnG/xQ=;
 b=IpzwppBGSmQH9uDuUAXiDJZmIRKIK2Ttng8FfJU9HMLra5qt9nGw3Y5ftAO/N3VVAaHjD9
 Zkd0A2zs4JgUmH5apMBVRBVFTgYMOuuYL4WWDJ8cPGHd2sDMLMCw1ZSY3REz2foYF3MYBd
 8sxiKHLpDhYOXuzdM5KyxWS+MX0l2o4=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-FbElfyGLOgO1em8pTZQo6Q-1; Fri, 29 Aug 2025 02:38:04 -0400
X-MC-Unique: FbElfyGLOgO1em8pTZQo6Q-1
X-Mimecast-MFC-AGG-ID: FbElfyGLOgO1em8pTZQo6Q_1756449484
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-afef67d1735so99203166b.1
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 23:38:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756449484; x=1757054284;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BGQ5qRLZ/dVY/7rHyQ0NoHm8va70Idrov02dYKnG/xQ=;
 b=rKLvY1Ouc8ZMB5vIS+e90mS5omycFBzEFtqqNf7BAFosU3E155h1F53Je9tPrzp6Na
 WmXUFs3wCVh49V7Qref19TDn3oZ26bae2PJ31CKM6Qkz90E7p9pWt85hlO6493uI3rvf
 BehMqo6k7Mv1Ve2Y4IfXyH1D/bJgGNl7aUi4Ml+8kxd4Ynm5Og8QWHtZcq4cBS1igWcH
 qTRn8G8L79vw6dXfQ4B9FcOSiDBWULZzGZxQODmtsHLAyGtLsMPQgBfQ12DvoaPKGXUc
 GOKsepvS12mI+CYw7JC2KSGA4IK5KB72AHhl5x87f4f0LrAmdpjXFz3h+GK5M1uRd69Q
 mQew==
X-Forwarded-Encrypted: i=1;
 AJvYcCVEt50kZgN8GvuEuMJGtEaG/qHFvjfrTFubrRNngVAhrz40F+rF1/uDkXXiDUu7OYyXGXCbj2HXnRNp@nongnu.org
X-Gm-Message-State: AOJu0YyaY0gN+aWF1TcFoGFiKpohB/kLv42No3L48iYeGLEB+GyZP/RI
 9IpF0XaTmULO8OyshqDem2808Y1U2Tce2wnpezZeA30h/hqwjuNFlNtiPcCxQ04t67hcohja4Fc
 FiQ3Xqe/Iv9HJ4fp1f3/Hr+pWmO0lXA2Y5QLW3nlc5BxioZCjhiYl0RZe
X-Gm-Gg: ASbGnctgHVZOlRnqPzXABxG0T0rWWBKYahFgdBY2JNJc/UN3EdUEfTRTu4bb9FJY3cK
 HM6wGe7HonLtxvOgg471SFI+tNLaw/Tq1r+gI6PttEi36YPfLo12PKVtNxq53R+0xCUBXbdkmip
 RGXJKWL/72Pjxw3+AoIBE9YLmh0D7hW4SNRRZXdFqqYLU9WHZLDY9R/bsvoilRV3b5foCbPjDLH
 Z4qqhgdwOQKVu3febk6ZE4RdYNLgHVk0cbzKABfOM+jp/KYKzFi4+eNro1SD6uEmOJlQgW78Dcc
 mNQ66zr3niiJegBOArQPKeZvbYC13TsciBI/eJe8Cvz7XUxrmQh31ep46z7gbLwBnYqh
X-Received: by 2002:a17:907:7242:b0:afb:513a:f62f with SMTP id
 a640c23a62f3a-afeafec9004mr984149866b.20.1756449483735; 
 Thu, 28 Aug 2025 23:38:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHiYLvWcEtyKgdQxcMm4tf9PNPvifJigu/BQLjlk3wnCXeeHyQ6Lnb38FpywfHFOYA4qUXtw==
X-Received: by 2002:a17:907:7242:b0:afb:513a:f62f with SMTP id
 a640c23a62f3a-afeafec9004mr984148766b.20.1756449483373; 
 Thu, 28 Aug 2025 23:38:03 -0700 (PDT)
Received: from [192.168.0.6] (ip-109-42-48-43.web.vodafone.de. [109.42.48.43])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aff08b86833sm54546166b.48.2025.08.28.23.38.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Aug 2025 23:38:02 -0700 (PDT)
Message-ID: <0d35ea26-d3b7-48f3-ae86-b065e000a8cc@redhat.com>
Date: Fri, 29 Aug 2025 08:38:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user: Drop deprecated -p option
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250828162012.3307647-1-peter.maydell@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250828162012.3307647-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 28/08/2025 18.20, Peter Maydell wrote:
> The user-mode '-p' option has been deprecated since 9.0 and
> doesn't do anything except emit a warning. We are well past
> our minimum deprecation period, so drop the option.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   docs/about/deprecated.rst       | 10 ----------
>   docs/about/removed-features.rst |  8 ++++++++
>   bsd-user/main.c                 |  8 --------
>   linux-user/main.c               | 12 ------------
>   4 files changed, 8 insertions(+), 30 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>


