Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3998CCE7AFD
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 10:11:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smVvX-0006ut-VV; Fri, 06 Sep 2024 06:10:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1smVvV-0006o3-VV
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 06:10:50 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1smVvT-0001HP-N1
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 06:10:49 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-42bbe908380so14600915e9.2
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2024 03:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725617446; x=1726222246; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ax1WD9d4xleJDBwZv3u94ksOAYSwdLgS+qeMzY3rupQ=;
 b=nWRwNS8EKc0PCXsUz7AO5XHmE5FYZVFbLH+tLQIZWToqPM8qrm159xbFa+6iwGjg4R
 qkG/Ttw1GBunAjQH7fXzIqlGiy/peKonZhL9GlVnOpKAQCtAvOIc+oXFjxtnx6nWbbpP
 bEfn07rLIJY/AsQdvFOacgKUNUCiFTj/eaqoifGOKpEIOw9sT9+au5CeyhsXxM1QNGH2
 uYjAH8vbuWLLMp9Mkvt/mLew93/bAellQnVeAt7hHmMF+2CxSiuLE1IlHSzI5a9cxpaQ
 nWum7vYwSqFXTZgrH1iBbfwSx7H8PoMofwWDLTr/NQNFiZJWhKSzHSN3zM/4mSaufKMs
 Tr5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725617446; x=1726222246;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ax1WD9d4xleJDBwZv3u94ksOAYSwdLgS+qeMzY3rupQ=;
 b=rVUVn7kr0e7yj6im3gw9BKfq/2TamI17xMpQoHKEoDWSnIIE962eGyX5k7IhDEomdD
 /NtfKurk0wQeh9S1XCzJvYB+BGRjXApOlDfUM41Rlib6JEtOXoirrvF3NaczntUhkbND
 gJhqBP6u/2FJtpF2P2FCDvQMQnJUR1baNDOZGL1XDP3zjawGNePIKWKe+MHougkAEddS
 kRfZFtEkQ4qFVTKjlk87VRFZGNWos3Cz66YVkrhedbtfIrtViieWvVqfDCeKnnowTf1X
 4au0Bfv42Gs5pDkAPQjdzUYrwdlMZ7Ems33+8SUsBMeNCj/X/i9jHcfDSK3+H8oaQnlJ
 GRmw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWbwQEKolyt2VuJx5lwrnVR8itFzJBvOOX5vChLqKhGURRaKnTwMT8OOS8Qg5d6nTtAu5pcc9izrhGa@nongnu.org
X-Gm-Message-State: AOJu0YzDn49kQaBY9bilwRdZ67FO9eKUtFFbVtpS/dgEB0FalRG2QPCE
 C8MkoEMh7am6IMgBNFX2YQ6rmo7FCGLG44yYO7uypCTiHVokGlxq/x/TLI2zvv0=
X-Google-Smtp-Source: AGHT+IHQqsh1m3vUFO3NIcb2a4qMynwcCDynYMuKvFvIUDpw/6x/fN6eMVWuwuTY9rPvm0uXZPMLOw==
X-Received: by 2002:a05:6000:507:b0:368:41bd:149b with SMTP id
 ffacd0b85a97d-37889612a68mr1230588f8f.34.1725617445622; 
 Fri, 06 Sep 2024 03:10:45 -0700 (PDT)
Received: from [192.168.1.67] ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-374be2edf08sm16787301f8f.6.2024.09.06.03.10.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Sep 2024 03:10:45 -0700 (PDT)
Message-ID: <c0da63c1-2f73-48a8-9fa5-2f4497a73464@linaro.org>
Date: Fri, 6 Sep 2024 12:10:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/7] ebpf: improve trace event coverage to all key
 operations
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Andrew Melnychenko <andrew@daynix.com>
References: <20240905181330.3657590-1-berrange@redhat.com>
 <20240905181330.3657590-7-berrange@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240905181330.3657590-7-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 5/9/24 20:13, Daniel P. Berrangé wrote:
> The existing error trace event is renamed to have a name prefix
> matching its source file & to remove the redundant first arg that
> adds no useful information.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   ebpf/ebpf_rss.c   | 19 +++++++++++++++++++
>   ebpf/trace-events |  4 ++++
>   2 files changed, 23 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


