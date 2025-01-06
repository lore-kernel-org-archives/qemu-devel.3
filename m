Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54602E77188
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2025 07:12:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tUhH0-00047B-EA; Mon, 06 Jan 2025 02:11:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tUhGx-00046H-Pl
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 02:11:35 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tUhGv-00027O-Df
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 02:11:35 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4361b0ec57aso140016035e9.0
 for <qemu-devel@nongnu.org>; Sun, 05 Jan 2025 23:11:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736147491; x=1736752291; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qmtb4H1yvqTUqu5C5qVwhkNZdh6ipuYsNPSvkh25XGE=;
 b=zsC7RrKGuHe7Z7Wluq7+WtCyQoL4AvDJTJHbPlmHntFGxbMAlxD74uaHCgHFtwwm8K
 oX89WH2KtiiA8jCiqQ9PfX0yubiHWaQkarlDBPP8E3baZNeie2M8xEYPa62wNMYLaWIp
 2YjDXnWLqmdiwUa9Ye7ewODsuynmEL6T/ZOvIolf2BvbqX7w3ayKvzeCZOlwgcqVwKlx
 1P9e9Jv/ijHP59IHmNJlyx+/NZKOrPt1x7rqN0drG8L75qOH6RTYOD+xvcYA3vVGK2no
 8bTqD3835nsNbfndOghlExwwaGcvZFPzBbPLgpVLeD4DMiTYr29+PQSofSoPjJlwpWh0
 qIlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736147491; x=1736752291;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qmtb4H1yvqTUqu5C5qVwhkNZdh6ipuYsNPSvkh25XGE=;
 b=OH02vx9oRwjvcOzC14nIB5Bm60h0pYZa3vT1M2s7785AVH4chZNzt2p2PFCGSbtfoD
 Sr8vFjOrbKUhiMc4BZq9ixH6B+2Mvu1B7434Rqb6eTyLAyMmnzUKQFbolD4OMcmrcwT6
 +k9noPuq+BGObLZvBzZEAWW1f47li5nxWjqFqXb9hUhpYKI8Tt2Al/THsewjqfGFgdyn
 F0IDp2Jdt1xlkxYGwvbNwJAH6z3iyiopmmKSdWLYn+Y6WMfGsaQGAVph6qmGzcLxnYSk
 ZlEG0E/wBdaWnFVRqosUCnowrP6rF7AerwJM0i9sBt7u333EGamdPExFERRLErERclwa
 CgiA==
X-Gm-Message-State: AOJu0YzdQGL4ltWLkPgFMh51W0VH84O60kt8V1uJ5P2HZWik9yBPkfOA
 9u5bioUV6LY+5cj21jIwuS+XWEdesWZ49tD8K1Lbe4zXeoXg8lDhYnjBNGqHQOU=
X-Gm-Gg: ASbGncuXN27rvuaYcVwTPakLHJqZaJfy7SHEe01JXcc4EiXvbBfw1CGk37vRIsofDUU
 ix4+HOG02Ppq83cQ38oh0kfosMY3uuvpOG67BJlHgZimtj7RPG9rYQFqiz86n5LdH3u7QYUO9tI
 GYARbz2GBT1BP6PVATX+f4eNdzqlRUHBl4Pn02LL6jf7HGFCG/kbFwT0ENzcZBjHbi5vHYDBXEj
 wHWEPmZzIePDmHl+4RttnhzCQ0S8k3Azj8tnqIyJv8D012G/LXlLqYDDb6C5vy2+CIffBwdz4Sc
 xE1n/boXzS8yE1kEDZNTfI9d
X-Google-Smtp-Source: AGHT+IEMoBsRrQE+lT3TaHF7YUlcRRjvPYng8r6ICW+bZGna0/NoMY/W3Ehh+nmIPv3MuMsok7hypQ==
X-Received: by 2002:a05:600c:1550:b0:434:f99e:a5b5 with SMTP id
 5b1f17b1804b1-43668b61bcemr385024805e9.28.1736147491457; 
 Sun, 05 Jan 2025 23:11:31 -0800 (PST)
Received: from [192.168.69.132] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43656b442dasm590742215e9.42.2025.01.05.23.11.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 05 Jan 2025 23:11:30 -0800 (PST)
Message-ID: <6d6c5322-836a-4381-95fa-a27150c7dc02@linaro.org>
Date: Mon, 6 Jan 2025 08:11:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v18 01/14] hw/pci: Rename has_power to enabled
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
 <20250104-reuse-v18-1-c349eafd8673@daynix.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250104-reuse-v18-1-c349eafd8673@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 4/1/25 08:52, Akihiko Odaki wrote:
> The renamed state will not only represent powering state of PFs, but
> also represent SR-IOV VF enablement in the future.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>   include/hw/pci/pci.h        |  7 ++++++-
>   include/hw/pci/pci_device.h |  2 +-
>   hw/pci/pci.c                | 14 +++++++-------
>   hw/pci/pci_host.c           |  4 ++--
>   4 files changed, 16 insertions(+), 11 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


