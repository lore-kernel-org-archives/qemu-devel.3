Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFCA3CCD1A2
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 06:09:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAj5L-0008W1-5p; Mon, 20 Oct 2025 02:09:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAj5I-0008Ue-G7
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 02:09:32 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAj5C-00033h-U3
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 02:09:29 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3f2cf786abeso3018905f8f.3
 for <qemu-devel@nongnu.org>; Sun, 19 Oct 2025 23:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760940564; x=1761545364; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xK3vQr3w7c2275t0XHP867DUAg+tgBdfWMCxjmYkzF4=;
 b=PjmAZuwILfbwiv3wz88DgqpGR8RzhBN5ya73h4FOp/UtIptziar5wI5JNOE948ijHi
 pp4/MDIvD7RoVusDQFTktO08n4wN5jSnIRA4XNHRtopNH4fSlsd570ymL0mKhOK6kkle
 qzJ0TpTr/2HOXmcwQGYE5IqinejxYQ6yYBBTKM7fygB7pdRcqOS6aLaSJlRqmLO1FStS
 1YVnhnR453MhHxJLTufOBMPVfKySSbDmTwFYryAzi3k0OOF3wkUMpIvF6fk0DAjq8lJY
 3x+rLZKwcxtHEIZEOGP52bOK8lHU8wv998IEj+M84p6V0CiJFOYjQXO+22iAa6XiMkEH
 KMkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760940564; x=1761545364;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xK3vQr3w7c2275t0XHP867DUAg+tgBdfWMCxjmYkzF4=;
 b=K1o0Ua7Qxt49gyXAyUJt1CbeJJ4jDK8piltYZj6MbbDZ5h/j5oMJXGTXYsoI2VzV/t
 KNwMql2/vOItoXlP7ZCAoC31+3uKOCfZKwMkbWhPozFU3OeR6bwTdfcC+y+E8juf2SxE
 7M81FSCO0KcrKjVqN0/7CWHat4vpWW6C0OxmGx2jjNJFN3/7P3I/2ACKEedPWmB/mVmW
 3zO9Tz3znX4l+7TwDNH0aeSCHq5gA4j32ZGy+N9sht+wSsdH7bPtWI4qdvyBBsrXbxq8
 7Vh23bnbNSAkNlwo2dPGeMdPOtywjb+fiW/40WKwRY52tBO/OFuK+0n1pEZHE8YNaeZI
 IaDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9NEta3JNHSO3Ou0RYHZGjwT7/gmo9KeBmx+8u99HT5PEOa376brJMTQR6kjztSq7fUAFPnw85renM@nongnu.org
X-Gm-Message-State: AOJu0YzQKVJ/v4KPgIyEygX7Ph2ey402fchxJnaG9L5+uikshXRFkd0C
 qhMrQvhCb+yWsphQTl6nNqqF0+qEa+zrqH8J1dQsmx2tSv4d/PfU4J4uu5D6ZA4h+kY=
X-Gm-Gg: ASbGnctgUaahctRqzNgriUnvNgy0x2i+6854Mlkww9idH3A+4/Eu3BqV8CjKvpHgfUC
 zAUP3toxHgLKprF3DsMqYqAN7wmAphz0JTYYZ5AEvDlUmYEE39ryvV050SDo5hb/UPMc+ndXQQb
 eFwqhAwvXHrDnBGKrXYEtdqBrIknkU6IfemFuJmYQr8OcGYiHSB2CimGrG/3OW37/n3R0pinKgc
 AV4Egm05JTwIiWwctl5dRC/aejeOS/zk9NGiY2Jd5XVBoGFY72e5fi01jTSN9w8GUPn1E7JHla7
 uyV5rzWZQih9aZvO3gNdttNFGhr0ZCUiMggTyRjlO7Fj6bGtfGaeA7rAVKY02WuDzCwT9AxrcXd
 SO2pwrrKG11E9Hb/jCktK7e7Ldw9BblxZpPIzbA9Nq8OPBHiDDSjYh4FtX79r7OWGtJyi0Dnyk9
 dA6gCYl7og9TC2m8uDD8xW1buBzk/fv54gL8oMMZotEBQ=
X-Google-Smtp-Source: AGHT+IH6aE1/9mNQVtfezNv1vXAOqDvkNrJ2zXOqGMeA57yHsWkWEwgHEm6EoTlGntSTI5kGSeXAlw==
X-Received: by 2002:a05:6000:40ca:b0:427:a3d:71ff with SMTP id
 ffacd0b85a97d-4270a3d7470mr5688361f8f.58.1760940564209; 
 Sun, 19 Oct 2025 23:09:24 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427ea5a0ec2sm13357109f8f.3.2025.10.19.23.09.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 19 Oct 2025 23:09:23 -0700 (PDT)
Message-ID: <3de8cdd2-ffd9-4f6a-ab2c-fa0782310746@linaro.org>
Date: Mon, 20 Oct 2025 08:09:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/10] hw/i386/apic: Ensure own APIC use in
 apic_msr_{read, write}
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
 <20251019210303.104718-9-shentey@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251019210303.104718-9-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

On 19/10/25 23:03, Bernhard Beschow wrote:
> Avoids the `current_cpu` global and seems more robust by not "forgetting" the
> own APIC and then re-determining it by cpu_get_current_apic() which uses the
> global.
> 
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>   include/hw/i386/apic.h               |  4 ++--
>   hw/intc/apic.c                       | 10 ++--------
>   target/i386/hvf/hvf.c                |  4 ++--
>   target/i386/tcg/system/misc_helper.c |  4 ++--
>   4 files changed, 8 insertions(+), 14 deletions(-)

Good cleanup!

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


