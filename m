Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 205C1CF6A86
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 08:54:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdllw-0006AU-5c; Thu, 08 Jan 2026 03:53:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vdllu-00060J-Dk
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 03:53:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vdlls-0007cL-2M
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 03:53:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767862411;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=KIm9pgvFlFioYnFc+gtW8yawfWjRX1rvYhiEfG4YM+k=;
 b=NiNkx4ynSHC7IHlnpDLewiF+S+ioMw8V+8iHCVQ9QSpqOT/K2WwoinycujoY6Gu9JvH7lG
 X55mOgeATh44BF4tcanKHWeax+HA4I1Hexg4Aht6jYo183TCDIrTL0vSt/rXSSZjXdf60x
 2cl0zSPxzfh/bABfZ8PTVEJuZjeeFpQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-VEfhksBIPceTLINott6j3g-1; Thu, 08 Jan 2026 03:53:29 -0500
X-MC-Unique: VEfhksBIPceTLINott6j3g-1
X-Mimecast-MFC-AGG-ID: VEfhksBIPceTLINott6j3g_1767862408
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-477964c22e0so14204135e9.0
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 00:53:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767862408; x=1768467208; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=KIm9pgvFlFioYnFc+gtW8yawfWjRX1rvYhiEfG4YM+k=;
 b=V95h3kaq3ip3iMcX8RoilkZoc0IZOrBQCx1BmRcPpSLT2agRLzs+bTCAIWp1XXElUr
 gkB0WHSW7CdKlBET2BskZknU/kZV7w3HZklTihCbl4PGB/Y3O7VgxbI6qlpJGwABTgC6
 rsFyg2B7slpPgdfG0G9g9Rl3Yal+69/rkl7kkphzs2M9BxnQ62hPK8Qz+t5cBoQ/NzXu
 01E0zJU29zV/w921AmW811ot7tCjkTaaQxeOQB254C7sOQ0LAwdFo//qIv98f/p7BrWY
 nRS2mzh52SfUOiKCEvy102fV5Hx3usiBWN74BdubFvygVVOHepUsWzAfAdCiiX8Lhjrw
 6iNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767862408; x=1768467208;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KIm9pgvFlFioYnFc+gtW8yawfWjRX1rvYhiEfG4YM+k=;
 b=kQ1GY8i5is5vYEONU4DhzEBojc69Hd4gbK+0R1k6o65eKGHve9lQDUEFT/cQ6dC1t5
 e0wKK0xgpK9Z0otw/YJU46Csge5voTYNyQU/DwT5pzSYESrBupCbadv0AwTBNWMh99nU
 HZP4pdqQKQu7lDgTGyKZZeHh+4JrDDTfGlkfdXCJeqWBlHOOLoZnaaaGZjfQs25y0mG0
 nvq6d1xOtjBRuSUWa08myT4KwecTV0ypg7tpjsM0tbJhYeZxWTTFZSrf8HU31AEp9kRx
 wf8Zg5LPF+FYl8+VgZVAYdL+6Kj/aTlCk/eLse/uPqo9HjhHYXdtVtwZWtuz/b79CMbY
 JPKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+PT4QXLeS6VbCvvYtC2JlDRoZCBIn4ap9iUIn4hhN9TitM8LIdctbr6+Rj48mNMIzYTzs+z3j7LD+@nongnu.org
X-Gm-Message-State: AOJu0YzDACq+0AvsHwbNf7MXzCTP8ros6vWHRmx5rUNNMMSkmqSygFZQ
 78rdbhEkLSmZkBZc7MqX2+/e1v7YqNmnjB3vjuVgTIa992lKxijsKj9cj3uuXX8thkZj6qRB4iy
 CEXmFbNnSPKpPWfugD0DVhH4ZvBC9EyptywFqTtbtWnnu3VAGDyytQKam
X-Gm-Gg: AY/fxX5khJVqfVh28+1MtI0V2Lj/JaA/z6KyBl2V5Bf1iuLwoa9K06LBCipwMq7dOPs
 QVvPqAiRoS0Pi9EJIzGM3w0Y1QpzklNkP/7Q27LnLsmhERWihMxnqRyaBflCrANx5DQ6tvouDqm
 bHVsZ2HCS3g31RG6xFC02YQq6FGA038ZQQ3TBL39DLVbSn+pUEX++EIJmVpS3FohQCHaxYk1scg
 7kJF+xeSig7BG5SDfde8RU+wt8F4dvSFlVyxQ6a6NC+SWiavQNPXxaaAgn47NQSN23rK6xb0XFA
 vKQm9vGMR+tzJn6XJESQZ+IM7BmGhHpC5I9qP0NmwwbuQBu9wwTZIRzgDEjxGjAfGUvrlxu+UUp
 oSyNQ/GQ=
X-Received: by 2002:a05:600c:6308:b0:479:1348:c63e with SMTP id
 5b1f17b1804b1-47d8486d60dmr48934845e9.9.1767862408384; 
 Thu, 08 Jan 2026 00:53:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG1bq8vSbpdKk+dq/k3MqRJRFndn80Ai7q4IlgGWlk89eDqh+2u7SPx4HlOp7y3+7zz+qhOcQ==
X-Received: by 2002:a05:600c:6308:b0:479:1348:c63e with SMTP id
 5b1f17b1804b1-47d8486d60dmr48934575e9.9.1767862408024; 
 Thu, 08 Jan 2026 00:53:28 -0800 (PST)
Received: from [192.168.0.9] ([47.64.114.194])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f653cd6sm149309715e9.9.2026.01.08.00.53.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jan 2026 00:53:27 -0800 (PST)
Message-ID: <c4f1fbed-44f4-4fca-a4d4-5dad27b5866b@redhat.com>
Date: Thu, 8 Jan 2026 09:53:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/18] target/s390x: Add more unreachable KVM stubs
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>, Pierrick Bouvier
 <pierrick.bouvier@linaro.org>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>
References: <20260107130807.69870-1-philmd@linaro.org>
 <20260107130807.69870-18-philmd@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260107130807.69870-18-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
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

On 07/01/2026 14.08, Philippe Mathieu-Daudé wrote:
> Next patch will move s390x system objects from the target
> specific source set to the common one. Unfortunately the
> kvm_enabled() macro won't be evaluable at built-time
> anymore. Add stubs for KVM symbols unreachable at runtime.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/s390x/kvm/stubs.c | 76 +++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 75 insertions(+), 1 deletion(-)

Acked-by: Thomas Huth <thuth@redhat.com>


