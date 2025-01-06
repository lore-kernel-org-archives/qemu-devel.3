Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ED83E77188
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2025 07:14:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tUhJ9-0005NE-SA; Mon, 06 Jan 2025 02:13:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tUhJ7-0005M6-PE
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 02:13:49 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tUhJ6-0002Hs-68
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 02:13:49 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-385d7f19f20so6133907f8f.1
 for <qemu-devel@nongnu.org>; Sun, 05 Jan 2025 23:13:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736147626; x=1736752426; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JYAs7krdghJgPIP7luxNAz9/xZPLBjw+himBYOH2sIs=;
 b=faCYVvPiVyD/+f8W/pmmcN/meACAjtpPqpp+pPd3xz2DdH3czUYDfZU07e8dxLK/fh
 SZDVeNsiAX6nr+UFq4SM/F5LiJmH9+qKKM9NM3JFdg80hf5dftYhIbP69vnFRuPxuPTN
 oRpA+0oaru/E4C1Z/GYZ4e23+G5MzjXY5wz7vaAsD/OoTFwkTig1Wp83k5ftXYAC80AB
 /QwUxjXrgAngz/LuZE7K1tyj/98RYn3iyYAqdzW0P/iMZm0/wnYCQskYW1YsV5PPTd+w
 LxdV+IUkqXEuCprMQwQF6EW7nrK6R4qDsT3dceOV/JDBtisj2DFvwW4Q7oiFBa8G0GuO
 g01A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736147626; x=1736752426;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JYAs7krdghJgPIP7luxNAz9/xZPLBjw+himBYOH2sIs=;
 b=imyiRnkepUuzVfgvUBGIWBKBFTYqtzpSBZzQxG69Az2dcRaCZjeDsjgQVbrDXqX/8C
 XlyKL8zzt7Ne7IGHw/jfR6kkpBUkjZwHQ/MMd96dEoUPiJDE9pAvw+GBi9yfyDCAeZl/
 705p5/OVvlXOhpBo3o401QmuTDImhtHRPHk7x+axArqDzPWkMjKKTJj5edoKeXRhrCOL
 1LOhl3PQfbEjUQNhUnbh59NM+jZYnb3YsJt/22yH4UiPBBhqvNwCR+x5sa2GHEruSDOD
 7fULtQ04xk9LFWeumdcZG7I+3WHYdKSj3hmz1QUnyeUrE4eJ6I5FMsv1aB+pi7nj+J+j
 LU9A==
X-Gm-Message-State: AOJu0YyWz9kpD4YAoNvjo/YVkC1GCV7peG9m1CjB2wYsvkBgTXWzhpF3
 AVSTXTnZINik+lZPWzwq2bvjJ4I7w/mSAkhBS5jDxNDJ6Dyejp/OPo7CURlIjOM=
X-Gm-Gg: ASbGnctRc9zCe1BQWs3EkfBI/AZqyPt2vkFxKy2UNvB7TYIXMPKkP/7jNmOtZoJebi0
 IQVBe143/0rRyZy5btyd5ELaH0+eNc0GSr4RrueES/XqVkerm/6IaaZ+uyX8ZZ/4jB97Y926wPP
 qLgz0T474tOreK7xitaXXrY9iUjHZ0RKZYCkWVj/T8OQyPy7q0tOtGaKpXmSXLQoohNANIJN8oQ
 sWzrm8YwI822VdGTgGUSQeEttpf2ZawIR0OJKIjM4Z530ztn7pMlsgnn0bSnyaZaOnKi7MyBf7O
 3CNwXLX9PxChxy6ZFODkxtfv
X-Google-Smtp-Source: AGHT+IGvnloJ0WYS3NJ5YS90jB5vBtbxlVnDQXCK7PDr4hNPY+EHGKuw2lpOgXTtT6jnKvnk5GNabg==
X-Received: by 2002:a5d:584b:0:b0:386:373f:47c4 with SMTP id
 ffacd0b85a97d-38a224053d8mr49771293f8f.49.1736147626422; 
 Sun, 05 Jan 2025 23:13:46 -0800 (PST)
Received: from [192.168.69.132] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43661219611sm564747455e9.23.2025.01.05.23.13.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 05 Jan 2025 23:13:45 -0800 (PST)
Message-ID: <1ae23ba3-30d1-4ae4-b68a-784c56040f7d@linaro.org>
Date: Mon, 6 Jan 2025 08:13:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v18 13/14] hw/pci: Use -1 as the default value for rombar
To: Akihiko Odaki <akihiko.odaki@daynix.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Markus Armbruster <armbru@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Shivaprasad G Bhat <sbhat@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, devel@daynix.com
References: <20250104-reuse-v18-0-c349eafd8673@daynix.com>
 <20250104-reuse-v18-13-c349eafd8673@daynix.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250104-reuse-v18-13-c349eafd8673@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

On 4/1/25 08:52, Akihiko Odaki wrote:
> vfio_pci_size_rom() distinguishes whether rombar is explicitly set to 1
> by checking dev->opts, bypassing the QOM property infrastructure.
> 
> Use -1 as the default value for rombar to tell if the user explicitly
> set it to 1. The property is also converted from unsigned to signed.
> -1 is signed so it is safe to give it a new meaning. The values in
> [2 ^ 31, 2 ^ 32) become invalid, but nobody should have typed these
> values by chance.
> 
> Suggested-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> ---
>   include/hw/pci/pci_device.h | 2 +-
>   hw/pci/pci.c                | 2 +-
>   hw/vfio/pci.c               | 5 ++---
>   3 files changed, 4 insertions(+), 5 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


