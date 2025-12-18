Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DFCDD6E2CC
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Dec 2025 18:26:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWIhQ-0002EL-VS; Thu, 18 Dec 2025 13:26:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vWIh9-0002DQ-US
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 13:25:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vWIh7-0005Am-Fd
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 13:25:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766082344;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=wZCRGkkGpnqicapnsPhNJndrvcKWL//kBJvuY5TfLyw=;
 b=Na38CvJerG5JqbfRrNeJ8FsZk5sC/7MTBGjFxhWfHGaUGP7jjqYtNDj9YW0JJ76iJFIHf0
 w39BosOGoEg3Kil1GrICJPxe0pHPsbMYPSR4XIrjZwcV0mbLlLK6IvqP0Z4nIRMeAsFQSc
 pgxQi3D4BoT+cNPh90+Jj8zQEfraB4c=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-Bwyi7J25PfKvuYDQ7XgITg-1; Thu, 18 Dec 2025 13:25:42 -0500
X-MC-Unique: Bwyi7J25PfKvuYDQ7XgITg-1
X-Mimecast-MFC-AGG-ID: Bwyi7J25PfKvuYDQ7XgITg_1766082341
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-477964c22e0so7482575e9.0
 for <qemu-devel@nongnu.org>; Thu, 18 Dec 2025 10:25:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766082341; x=1766687141; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=wZCRGkkGpnqicapnsPhNJndrvcKWL//kBJvuY5TfLyw=;
 b=J6rCcN3coh2pKWA6sencuo1DrclZhhRo3Ck8ioRTCdi8HxLtzi72Y8qt0N7pA2lZ4d
 hWP2zjrx4CuaPZ4NPin6OW7x5sGQMtz6VPonomSvaMg/B6VIVwHUCx2SE3LfcNsY6JkG
 TPBYmQVimiVNXJrT+S8dhLm8rT0XTSMJ0RnjCDYvuGIFv+faBQbLWUEGoYB7ZQkERAmy
 yj9O+sO+5ky07/eZMZpiTQr6GI3NlpCxBa7tX0DqUMt7NLseo+wrZ7z+7GJ7i/10SR1P
 sJ6VkpTZAAZGtJUGtqamFZy/175gtXPrVVDOmtFsHTkn6sZ0LPnSc736ECYD3DiFlWqC
 D38A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766082341; x=1766687141;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wZCRGkkGpnqicapnsPhNJndrvcKWL//kBJvuY5TfLyw=;
 b=MiKvvbbt1BcyMCqL7XT2aZvyPRiNIIMW2hI7qFyZaGls9JCUkNydDOOBR3wTKjJf4b
 4z52GMdadUwLHi9am8/s8Z312vd4UNxeGxJTzYS0m9vQXm+6PgMButQ1SP6s5G5K5bXg
 VWMZF9l3L0ezCwHzNuY/to+zGYO+K6t38zP9hlqS+KY3nE+nP1K0aPusnvgEAN4ekDwU
 N7JHX/Lot1nxPWVoD+WkAh7rLpi9mcn4OrMLhRzsrHO4aeGzrVpGi3daIokhblRdXW/z
 +ghqO2OOBVa2uPT/Ey6DmKgxX9uwGOS85qJiBirYyfs/sTpBQHKN5d4kb2KBzPz/dW1v
 uX4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFRVP4x3DxAqbWf6F7OeAGkD0hvgPP6HXJV+VSa+1U/G3JVz0IYyi3pRzcBV+AriV+IwbL9+i149I3@nongnu.org
X-Gm-Message-State: AOJu0YwT4u4rAMx8n17oUEIhrImQGpQEe4QVqZPhoYjw9HstID/VWAsn
 g8ENUJlCaxdpA2Nu0uAn9MT+6wy1mCjBAOAKN+Qag2mgn+s+Wgwk71cqamzWQOEO9aZ1kf5SFn6
 b29urP7CA6AzL8WG23tOYeRfyGUWKzTmJQozQDdP5qEwM9ySPKGlXki9J
X-Gm-Gg: AY/fxX4s7YFR63HoVfTxJWe0GiCUVqp++H6AvBTtWEi7lLConSaxXXdTW2o3pT3fVKD
 cbADehg9icoyyqX9AtM3jbPeDjymbkNzFRbPSxBIidsIOupHfw8XhPHaRpQf28g6ruleehuiHTf
 XZu8ljudfgtsYQ/dMzCbiTwX4VMBcaI3huz5dL1N5UGLP3TWwjSrFakck2PABpCk6pXtztWihLz
 nC+UyJTXJJkOW3/sYLYc+s8xP+8b8BLXqgsrnWAjG/83FZmkXQeRgLCt4ehfr56vYA2fIBns1Se
 A+L0OopxT4+t+rFj0frs574nJhHB89hdk9Ow5noKxNY6Hx+/X2KS1sn0CfnASyL+MyYtNiARqWu
 wTiKPdnA=
X-Received: by 2002:a05:600c:4f93:b0:479:3a8e:e490 with SMTP id
 5b1f17b1804b1-47d18be8f2emr6112125e9.18.1766082341091; 
 Thu, 18 Dec 2025 10:25:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFgGF77W9h43xc7G2QOnnxCU05Dl+ZkX0ByCzqoHDu34u/7qQtA1+lVPpt1+Vk1Ik3X6UDPFg==
X-Received: by 2002:a05:600c:4f93:b0:479:3a8e:e490 with SMTP id
 5b1f17b1804b1-47d18be8f2emr6111875e9.18.1766082340731; 
 Thu, 18 Dec 2025 10:25:40 -0800 (PST)
Received: from [192.168.0.5] ([47.64.112.241])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be3a0fb9asm19629565e9.2.2025.12.18.10.25.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Dec 2025 10:25:40 -0800 (PST)
Message-ID: <274845c2-ffad-45a2-939b-7fefa3159bba@redhat.com>
Date: Thu, 18 Dec 2025 19:25:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/arm/Kconfig: Have FSL_IMX6UL SoC select IMX_USBPHY
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Guenter Roeck <linux@roeck-us.net>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-arm@nongnu.org
References: <20251218174455.57451-1-philmd@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20251218174455.57451-1-philmd@linaro.org>
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
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 18/12/2025 18.44, Philippe Mathieu-Daudé wrote:
> Since commit 17372bd812d, the SoC used by the mcimx6ul-evk
> machine requires the IMX USB PHY component.
> As this component is only used by 2 machines, do not select
> it by default (it will be automatically  selected when
> necessary).
> 
> Fixes: 17372bd812d ("hw/arm/fsl-imx6ul: Wire up USB controllers")
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/arm/Kconfig | 1 +
>   hw/usb/Kconfig | 1 -
>   2 files changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>


