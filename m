Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF029CCD193
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 08:30:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAlGr-0003Ik-QJ; Mon, 20 Oct 2025 04:29:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAlGo-0003IL-UM
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 04:29:36 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAlGm-0007fY-SK
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 04:29:34 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-471066cfc2aso36883945e9.0
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 01:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760948970; x=1761553770; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=upLQabNrkLN9xzP5rlMjYwim4MepxAdcp1g39Wi3qvw=;
 b=j8i7E4YWRWjhyWpjPxpyh2ouCNFmF7YVBjNMhtSUNF0F1EzjTqL9ddZOcpbg0haz1t
 ewzKbLGoyWPQ3Hs7kPN+moVY9y1+/ie1I9n0MQAQ0+D4zkTafR8GUPEfaCfMEfTtQyN4
 8NdxQ1VbMimo42/YD+VgkDmbZeNMSvahIwRVLAisCN/SgEJXBIx1aXpWIkblkUidxq7H
 YfEt7/FMb4EEroKadFkwWZnRY4MMtDs5pArTFcKyAZpEhobGValVZOZySDx9JXjYYEMX
 sxj6b6nziPhmpt2EI/AqEuHPcJHcFRUv1W1lECveBit1LKyGMOeaY1F5XmvVHG45aW9S
 UlkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760948970; x=1761553770;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=upLQabNrkLN9xzP5rlMjYwim4MepxAdcp1g39Wi3qvw=;
 b=QoMWBLEOBKGW1LrvnV6WkXTckmJAdDb/OWYFWn75ZvKq7TF4IyECsKRwjN6ac3ZCKY
 AK0C8zAQeDfr66AD8UQ0i594ZsUJYfimBvnv+wKDD4YahJb+AD9RFmCcJ1AC2eCgLol1
 GcWgzHe/yv5akUlB/P2UUdtQdz/OdMHtPVFleIBPEHyb9EeJ8SGF2nCB7zT++Ie4NSrk
 l+DjzmvCdjx2QWME/Z8DBjsl+zPjVCDC4SMk5VNpU094WOSfi2SzW40Ju1Clx2HdyfGT
 l2uzW58tYyv4I0L2PMM9d45ihZfqzTUE/a+ZdxoQw8788j0sGjtCYIcnvcyHViB1WFdT
 Djpw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0nH+pAbT2UzDh00OFqb5Ml1qVn38A/MpHh4Vpszp2f7Oias14qQYBLr49dQo+0uHUNVI5LyLxfesU@nongnu.org
X-Gm-Message-State: AOJu0YyzfMXw4B551N2I5Fh9Pu9Uv5XPYV4cfaePRCCR0IEEqottp7AW
 ke+Msw3lhCTKUJgYNMOCYDhvsXwrfy9wFob1WHyGt9tu5ch45toVABdSxX4UpfqzTYw=
X-Gm-Gg: ASbGncuOiuzIwvUYat68NH4mrQogLoRRHP1Q7mp1lDJn28vbxKolSqfOi+H5FUEObXe
 m6RP8hPlscesU/VF8M84lS3e2ZXL3Ur/0FIDWscZRJAP5MZ4jhnyjU4K8K4Z3WllyufZ6cgkkRN
 klU5senSJuY6trebWulp7K3wlRwJvw9igGED4FOp00OukRlrEZw8tGQ1yjkKN8u7gxieXUIojXb
 qoosxue7Xh5wALQvfrieOlZpUWHqd8BuOSMoXIUKHMPFbQo2rc8BbKHZY/OKCn6BxG3WxJm9uaN
 N3wC1TPniWh0x8/4kXu93Xri5Cd9VZsqcyL13+Qyo6ef+sJWsPCFHlCuc02tShBvpC3eUsesO35
 IDxbSUakuWDm7CyBxkn9Vo32cTrW3mL1rDcIdXm4CgvCVkTZDDOplOFl1qqLoBeCpMp0uwOoePr
 OweA7Il0b/QQXCw8fJ3WgTTjDUPKjL3RhKUN6cM4stZGtEWi1rbT5eeJ9XSh0YLO49
X-Google-Smtp-Source: AGHT+IEzE1bsNkCQUwgrRUB+00ZejTXpM1jHhePaWJboCKPtO+YsgVt7DQis+/s5Igcc0ShXfXMXog==
X-Received: by 2002:a05:600c:3e8f:b0:46e:4b89:13d9 with SMTP id
 5b1f17b1804b1-471177ad526mr90113505e9.0.1760948969780; 
 Mon, 20 Oct 2025 01:29:29 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4710e7050c6sm114773395e9.1.2025.10.20.01.29.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Oct 2025 01:29:29 -0700 (PDT)
Message-ID: <5cee31c8-57d6-4245-a49b-bf317677e211@linaro.org>
Date: Mon, 20 Oct 2025 10:29:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/10] hw/audio/pcspk: Add I/O trace events
Content-Language: en-US
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Laurent Vivier <laurent@vivier.eu>, "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Zhao Liu <zhao1.liu@intel.com>,
 kvm@vger.kernel.org, Michael Tokarev <mjt@tls.msk.ru>,
 Cameron Esfahani <dirty@apple.com>, qemu-block@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-trivial@nongnu.org,
 Laurent Vivier <lvivier@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, Phil Dennis-Jordan
 <phil@philjordan.eu>, John Snow <jsnow@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Gerd Hoffmann <kraxel@redhat.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
References: <20251019210303.104718-1-shentey@gmail.com>
 <20251019210303.104718-3-shentey@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251019210303.104718-3-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 19/10/25 23:02, Bernhard Beschow wrote:
> Allows to see how the guest interacts with the device.
> 
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>   hw/audio/pcspk.c      | 10 +++++++++-
>   hw/audio/trace-events |  4 ++++
>   2 files changed, 13 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


