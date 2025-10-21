Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDDA9CCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 16:02:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBEoR-0008Dg-T4; Tue, 21 Oct 2025 12:02:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBEnZ-0007KB-27
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 12:01:23 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBEnV-00005q-DW
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 12:01:20 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-471066cfc2aso11977255e9.0
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 09:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761062473; x=1761667273; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Wi4jMzpi3nbawrsaPcGe1LeGK6a/mFs1A8RcgbTOttA=;
 b=hpVYvxo3JvrIguVRYoLHnxUM6Oa9gupv+6575LHzlylyehRM1VCUUS087Vpnot2wcL
 XjosPJAjv4SQIf/FhTcXOym2ySjBQl+v6jCHjflJyHX7A3OQDkocdt3SPgBEIaK0uaOo
 kV5i2vSYqUxB2AF/LaFXXENiEU264Zj1oO9iqKwOyB2VlOdYtf6Hq994bKOVZrbeSRw2
 F8OpWHubAck01OOelyC1zSc24/Lgq8koU8fZ5lnBlGzYiT4GBCJGDvpJezfq0Q7VSuUC
 fuKOxyTyolsW5up7pvwzjEJt7WR3Fotc1x5A6jvwZZlkB4ARZoNqSvd/wutSnGSl/uAh
 x2iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761062473; x=1761667273;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Wi4jMzpi3nbawrsaPcGe1LeGK6a/mFs1A8RcgbTOttA=;
 b=IgASjFjdp5nfIiVondu1MCIkOQbQj6fMqII8tw7SumjEbClxKBD01qcrrHTbLNGalr
 lfzs7y92EWabvMwQMObNYwgdU+92VWsN9bofx8pylpt5lqcm3B1VgzjT+ZsJHn+KOt7V
 8DM7P0FEii0bveGkw2V16DN90DP1dFTBqHXFpG/iUpHzRmTcgMZFj3U9li8yEihkur2i
 rj1LhzrQW4OtuxR57c/4L8q+tj94U1gvRapAZWhWY1auC0//RfQdUR570hZ82bN5U2fI
 wiw4SA6NfhWDgFVSZ9kzInCHNSikw0yO9jvIRSbW5HyDDpfCgjhzw/zNavUwzYdwMKEE
 VBHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXV0KS948bsP0W8TF8THEFFSg9d5zsns0uhH8Af5YXyHWuTKQimjz2p6+R1qJIabkB/uxRLuVuSuQpn@nongnu.org
X-Gm-Message-State: AOJu0YzQkLfbj7l6Qp7Aw0IiW5M2GtO56yZbQZ90+0vGa3TbztxnfWRz
 ADxkEFkmmWhc1AVlhy5ldS94+9TQMzjKO5GVZUhLbJpbYuFbz/aOHtVPSTlMz79NaSk=
X-Gm-Gg: ASbGncs/qk+7AKauH0Ab4g0KBIOV6jGj33XT7MFru5rgiHEoM+7lFJxjQzWBxgxr0vJ
 ypTuh+Ydau0WhStW+Na4H/nx1Uhu+/e4Cr6PnBxeDHCAHEcCPHosUTdTFlRoLQ9bVXbWMHFjNkw
 lXRj2tlB/gNX3mc9V9JNIOKH+JkyCkcJvYhDuIGY4gxnTEkK6Ox3KnkuE/WDaWckvU/vYOGblEv
 Fi+ISHKmeH06kaXSddYwLc8DZD/IM7Z6Jv+64hSP+D85C4wKG5gYK8qaohx4pf/PG+nQIrWuUz+
 ZRUUxpIhuC6sdn0FfWNGdomBBtRqjU9Fgk4Us1e18xEEAke10JQKrIzaWzaFHBnlyqoHZ9gNwVj
 54BoXYhQF0Wqv09w+ihNzDeSaZ82+KXNn+sD8TpLXofOH+rxpJtk0j/fkyU6as5LQE7wEZuu2Bg
 WQWf/7MEhbbOWlOuJqwmkS7cjV81k7WxtnlP2Sjblndgjhr0ZFyoSCgg==
X-Google-Smtp-Source: AGHT+IHrko61yHL+EkLhNGwx9wqvLp8HifeGykLYFnZoo841oLOivvfKWYEyiB4PmnxGj+jpat6DHA==
X-Received: by 2002:a05:600c:45ca:b0:46e:59dd:1b4d with SMTP id
 5b1f17b1804b1-471178a4bb0mr128739695e9.16.1761062472496; 
 Tue, 21 Oct 2025 09:01:12 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-471144c82b8sm287502825e9.15.2025.10.21.09.01.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Oct 2025 09:01:12 -0700 (PDT)
Message-ID: <f1e8c675-d7fb-407c-adba-d30ed0e771b8@linaro.org>
Date: Tue, 21 Oct 2025 18:01:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/10] hw/intc/apic: Pass APICCommonState to
 apic_register_{read, write}
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
 <20251019210303.104718-10-shentey@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251019210303.104718-10-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 19/10/25 23:03, Bernhard Beschow wrote:
> As per the previous patch, the APIC instance is already available in
> apic_msr_{read,write}, so it can be passed along. It turns out that
> the call to cpu_get_current_apic() is only required in
> apic_mem_{read,write}, so it has been moved there. Longer term,
> cpu_get_current_apic() could be removed entirely if
> apic_mem_{read,write} is tied to a CPU's local address space.
> 
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>   hw/intc/apic.c | 35 ++++++++++++++++-------------------
>   1 file changed, 16 insertions(+), 19 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


