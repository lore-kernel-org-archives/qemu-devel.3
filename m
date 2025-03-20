Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12543C28B30
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 07:42:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvAXA-0001Hm-Nc; Thu, 20 Mar 2025 03:41:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tvAX9-0001H7-KR
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 03:41:43 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tvAX5-0006ty-Ox
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 03:41:43 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-39149bccb69so362666f8f.2
 for <qemu-devel@nongnu.org>; Thu, 20 Mar 2025 00:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742456498; x=1743061298; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cXMy2FP8eVpjmuzvVyPyu2ht4al3Gpodl5VUdnLP7kY=;
 b=EALJQvLAesPIsHWz8cvQc8HmkVF8kybhqedh8QKH6sxslaRnFU+QKtf6EPZwy9Ishh
 NmZGeEnQT9wbGwG3dhURw4IPpc+dOfuYUWQmUTJmMDQmn/mwG1pBgeA0lIrHt73ozB+O
 j8Jjhm2aYUMIRboiJJPB4spec6GBtH/2F44Bvjv72fUyWYyoY8P3jiBLiuLggVXHY0pr
 5z6sy6MhOw/2ACj97UOz7q/2fdByFmvGuLVkaNLGJNUsWbBT2mcWbeTRZt/8/QZRmNMi
 bJFsUQE9EA/7znZrfUKDbm5F3cazLCP/F24ZJinJfXilp60UdwptT6COw5+1hCw+ikYL
 grQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742456498; x=1743061298;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cXMy2FP8eVpjmuzvVyPyu2ht4al3Gpodl5VUdnLP7kY=;
 b=LkfvtBm4DvyAfnTwb1LEUWoDAw1zA9zek3ewcLe9KtzuTSPkibpdUR1gUPtrzumoiS
 V3RB5DRQDY3/JGCSmxGO/1COBRVcwuXgxcoJdYWS/QgN0GN0Kp6nEXXxpNuy3fgrKHai
 nQS17K06oxgPj+LBCPVdYuJUq04gxaUyo89X1cxyT09YHfA/EQMzvoYFpmfcP9shnnDD
 UuxfJbBgXsUqZClbAgGFDhWw7Aj/4sJzvJ7dpUHN/IyUmHy/WPPmUpwsPUUe1Obu2aKa
 /WYZiTMFTJzyynb9YUvyYxTo2FF8aR5WlhzcPoKVworJhfvP6P/FHofdXlmhhxGertYj
 sSFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVpurguFqlwObO0swfSzkgeCZUbt1NoFrGYtnLkcD6S4cSPf/lCu1MC4cEskcQdDwt5g+a15H4g0IK@nongnu.org
X-Gm-Message-State: AOJu0YxsOlrihehgKN9q0wKJbI5IvhICQIxZCS4JUDAbx50SSxIWcsjF
 9O/x2LJLckD4nY+GsbFEwWk9hPCi2yMIMhB7w6OJuQ3apxn0QS9KjvVFX+DyrOw=
X-Gm-Gg: ASbGncu8Hh93X5/QTI1019hAVUgoQ6qNRGD5ws7pq0p2IzZNjmXm7zngZdZYPY1lNdi
 gQNE7PVlCHUlqItccnPWU6gOr9ZPRKg6hnM7UEB15bN/I9nI8gpTnrc2OB5xu4Uvz34a3r4WQZl
 gaB5M//Zc3cLzwnze+8MXK4lB+JB/lIdqoOG3ABu2+q4/nUQ5TafogFgkaFf7wLMS0x49DTqUr/
 YA1UIou4M4kh4sTmyz4+/gCGocvSy77lyUjKtceQvwa9tPxQYdwi5X47+kzGyS8e//j7o5T01S8
 YFEy2UYQCZe64dMdUfZiJzxnq0LOZFqQCZ5raMnbXhGGz7V6ikbua6a3AYA9wNH9UdsO1QiTdpt
 Z7aygBSgGB/at
X-Google-Smtp-Source: AGHT+IG/1yMP0Q5F7hpd5pKeF0c6t1xisdz2iimzo7eRUY2CNfTFhvC4bHPYkhXMuMQIAOyiEQj0Tg==
X-Received: by 2002:a05:6000:2c7:b0:391:4835:d888 with SMTP id
 ffacd0b85a97d-39973af9092mr5073139f8f.42.1742456498039; 
 Thu, 20 Mar 2025 00:41:38 -0700 (PDT)
Received: from [192.168.69.235] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395c83b6a5esm22642398f8f.27.2025.03.20.00.41.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Mar 2025 00:41:37 -0700 (PDT)
Message-ID: <2c5bc1aa-c8d6-4077-84df-421d59b542c7@linaro.org>
Date: Thu, 20 Mar 2025 08:41:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 24/24] docs: add uefi variable service documentation
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-arm@nongnu.org,
 Ard Biesheuvel <ardb@kernel.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, graf@amazon.com,
 Eric Blake <eblake@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20250225163031.1409078-1-kraxel@redhat.com>
 <20250225163031.1409078-25-kraxel@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250225163031.1409078-25-kraxel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 25/2/25 17:30, Gerd Hoffmann wrote:
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>   docs/devel/index-internals.rst |  1 +
>   docs/devel/uefi-vars.rst       | 68 ++++++++++++++++++++++++++++++++++

Missing MAINTAINERS update:

   F: docs/devel/uefi-vars.rst

>   hw/uefi/LIMITATIONS.md         |  7 ++++
>   3 files changed, 76 insertions(+)
>   create mode 100644 docs/devel/uefi-vars.rst
>   create mode 100644 hw/uefi/LIMITATIONS.md


