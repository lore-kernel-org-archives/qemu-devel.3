Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8998C54FB3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 09:36:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJUFc-0000xH-BO; Mon, 26 May 2025 05:36:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uJUFY-0000x1-W5
 for qemu-devel@nongnu.org; Mon, 26 May 2025 05:36:05 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uJUFW-00059F-On
 for qemu-devel@nongnu.org; Mon, 26 May 2025 05:36:04 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-441d437cfaaso12065135e9.1
 for <qemu-devel@nongnu.org>; Mon, 26 May 2025 02:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748252161; x=1748856961; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HkENEDwTrOUlcFOPP9qwiQ9HYFQ61KmkI7052U8Azv8=;
 b=iuhuZ1KXoGOOYWLruomQhm5bnwMDbtt4V9IMt2Ai6bJMTQNy24H9C7NoA8Y2cyStWA
 V75/XNXYmRcy76oc6hWqTK36+K/4d6tNdHH1pge7XOVwXtZl8cJ0YAm7A8RweD3Rovz6
 fHqztRzuqWnzQ3Dycdbd93PtYJxmqJHMESV0dmgduQSRrQnrtIjV5C5h5dlFtjq+lw/j
 WbMukZnvDU8pOa9pBcLcSzP5UWLqfo+3ILlaVE/5Sv5iy1aTx1YSGc26nbeztYIlHfTL
 DpglXAP9tqnUExwsRh0QCJW9j+2JXDskYKdNGAmNdhB/WBEwD1fgE0JEuKwjethiorH+
 oVhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748252161; x=1748856961;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HkENEDwTrOUlcFOPP9qwiQ9HYFQ61KmkI7052U8Azv8=;
 b=fyyFzpjzubqf2X8FyK/2agX91Tjv+o02f4IoUokNDCFljebFMkd2fA3zfoqT+3KfFm
 ETkoX6wG34Eg+wzYRbDjAKajDgIa2PMP9fDbOo4dujon7nFdS3cqDiUjTBi47XexW4Cz
 GsA2eKR4zc4Tp2Y/13naDyW8baKEnInMaViqRI6vSBXhif1myNIzJW8MwfGn6yw22xfO
 fbDlRSzr/z77zjWq8ikKK4IZJnDYjk9RbBk8z6DJZFe2Pw3wtSbrKm57XAqzbDRpVEr4
 ykUknqLl9nc/y/g4EzZFsIu+4+N5k0NkfTl1VUJFdccp0vCdsCIqzX5DcrMQOj0Jon9m
 7Huw==
X-Gm-Message-State: AOJu0YwpMP39PXzWYWA9sNpiwmfMxxRFVkOhbEO3COJpV+/GB+8xniz6
 hI0zilcB5jm7usRk29i9ZROhvi6f3h7bz17H3S+mijvWijvAouUKYG9B4X+LfQnQRBc=
X-Gm-Gg: ASbGncvgrkbPn8wMyxHrQJhwGxlVEmsIIHsIVqZ0M4FD4NbJJ5rUfEs5afvMKfM+YjD
 XNUN0ZMPv/U7zH9eBeT0yc0LzpRWYhtaCkAanHZA55mOyUYCz61bxkUz243319K+a2ppOTFAZun
 wNvZyfC37TDTzY3RgoirhVeVTOd2B0kGUzHx8xpqJxGll6VdV+1RU2RDVVNLvUlI3eD6mBtiU0p
 oc7aIJJNsl6+q/9ZZvXiglKEuyRXoMXFjaXbE8b4TNlOzz081DUDoo6nL638k5NhuAGIUCI4laJ
 VvK6+Y4+vED7SWEVcBlkr+fGSFWQgIuTOjzelNjPVKjQUTF/JbC+N4lMJH8IArWz/QYS+9Q7Fy7
 mkQ4jHdMMU47UphkjoPNiR3py
X-Google-Smtp-Source: AGHT+IGKj/M2WcKFmwle9OkS5/LAr7IGfFBXu4u7qW1Da7kO2fKVjzchrg8JxR17GB8ljC9mQ1ktfw==
X-Received: by 2002:a05:600c:8112:b0:43d:47e:3205 with SMTP id
 5b1f17b1804b1-44c935dd583mr65118765e9.11.1748252160731; 
 Mon, 26 May 2025 02:36:00 -0700 (PDT)
Received: from [192.168.69.138] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-447f23bfe80sm228185335e9.20.2025.05.26.02.35.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 May 2025 02:36:00 -0700 (PDT)
Message-ID: <dca6ed89-e704-44ce-b9f1-deb3c6dd8dc3@linaro.org>
Date: Mon, 26 May 2025 11:35:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 03/10] memory: Unify the definiton of
 ReplayRamPopulate() and ReplayRamDiscard()
To: Chenyi Qiang <chenyi.qiang@intel.com>,
 David Hildenbrand <david@redhat.com>, Alexey Kardashevskiy <aik@amd.com>,
 Peter Xu <peterx@redhat.com>, Gupta Pankaj <pankaj.gupta@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Roth <michael.roth@amd.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Williams Dan J <dan.j.williams@intel.com>, Zhao Liu <zhao1.liu@intel.com>,
 Baolu Lu <baolu.lu@linux.intel.com>, Gao Chao <chao.gao@intel.com>,
 Xu Yilun <yilun.xu@intel.com>, Li Xiaoyao <xiaoyao.li@intel.com>
References: <20250520102856.132417-1-chenyi.qiang@intel.com>
 <20250520102856.132417-4-chenyi.qiang@intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250520102856.132417-4-chenyi.qiang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

Hi Chenyi Qiang,

On 20/5/25 12:28, Chenyi Qiang wrote:
> Update ReplayRamDiscard() function to return the result and unify the
> ReplayRamPopulate() and ReplayRamDiscard() to ReplayRamDiscardState() at
> the same time due to their identical definitions. This unification
> simplifies related structures, such as VirtIOMEMReplayData, which makes
> it cleaner.
> 
> Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
> ---
> Changes in v5:
>      - Rename ReplayRamStateChange to ReplayRamDiscardState (David)
>      - return data->fn(s, data->opaque) instead of 0 in
>        virtio_mem_rdm_replay_discarded_cb(). (Alexey)
> 
> Changes in v4:
>      - Modify the commit message. We won't use Replay() operation when
>        doing the attribute change like v3.
> 
> Changes in v3:
>      - Newly added.
> ---
>   hw/virtio/virtio-mem.c  | 21 ++++++++++-----------
>   include/system/memory.h | 36 +++++++++++++++++++-----------------
>   migration/ram.c         |  5 +++--
>   system/memory.c         | 12 ++++++------
>   4 files changed, 38 insertions(+), 36 deletions(-)


> diff --git a/include/system/memory.h b/include/system/memory.h
> index 896948deb1..83b28551c4 100644
> --- a/include/system/memory.h
> +++ b/include/system/memory.h
> @@ -575,8 +575,8 @@ static inline void ram_discard_listener_init(RamDiscardListener *rdl,
>       rdl->double_discard_supported = double_discard_supported;
>   }
>   
> -typedef int (*ReplayRamPopulate)(MemoryRegionSection *section, void *opaque);
> -typedef void (*ReplayRamDiscard)(MemoryRegionSection *section, void *opaque);
> +typedef int (*ReplayRamDiscardState)(MemoryRegionSection *section,
> +                                     void *opaque);

While changing this prototype, please add a documentation comment.

>   /*
>    * RamDiscardManagerClass:
> @@ -650,36 +650,38 @@ struct RamDiscardManagerClass {
>       /**
>        * @replay_populated:
>        *
> -     * Call the #ReplayRamPopulate callback for all populated parts within the
> -     * #MemoryRegionSection via the #RamDiscardManager.
> +     * Call the #ReplayRamDiscardState callback for all populated parts within
> +     * the #MemoryRegionSection via the #RamDiscardManager.
>        *
>        * In case any call fails, no further calls are made.
>        *
>        * @rdm: the #RamDiscardManager
>        * @section: the #MemoryRegionSection
> -     * @replay_fn: the #ReplayRamPopulate callback
> +     * @replay_fn: the #ReplayRamDiscardState callback
>        * @opaque: pointer to forward to the callback
>        *
>        * Returns 0 on success, or a negative error if any notification failed.
>        */
>       int (*replay_populated)(const RamDiscardManager *rdm,
>                               MemoryRegionSection *section,
> -                            ReplayRamPopulate replay_fn, void *opaque);
> +                            ReplayRamDiscardState replay_fn, void *opaque);
>   
>       /**
>        * @replay_discarded:
>        *
> -     * Call the #ReplayRamDiscard callback for all discarded parts within the
> -     * #MemoryRegionSection via the #RamDiscardManager.
> +     * Call the #ReplayRamDiscardState callback for all discarded parts within
> +     * the #MemoryRegionSection via the #RamDiscardManager.
>        *
>        * @rdm: the #RamDiscardManager
>        * @section: the #MemoryRegionSection
> -     * @replay_fn: the #ReplayRamDiscard callback
> +     * @replay_fn: the #ReplayRamDiscardState callback
>        * @opaque: pointer to forward to the callback
> +     *
> +     * Returns 0 on success, or a negative error if any notification failed.
>        */
> -    void (*replay_discarded)(const RamDiscardManager *rdm,
> -                             MemoryRegionSection *section,
> -                             ReplayRamDiscard replay_fn, void *opaque);
> +    int (*replay_discarded)(const RamDiscardManager *rdm,
> +                            MemoryRegionSection *section,
> +                            ReplayRamDiscardState replay_fn, void *opaque);
>   
>       /**
>        * @register_listener:
> @@ -722,13 +724,13 @@ bool ram_discard_manager_is_populated(const RamDiscardManager *rdm,
>   
>   int ram_discard_manager_replay_populated(const RamDiscardManager *rdm,
>                                            MemoryRegionSection *section,
> -                                         ReplayRamPopulate replay_fn,
> +                                         ReplayRamDiscardState replay_fn,
>                                            void *opaque);
>   
> -void ram_discard_manager_replay_discarded(const RamDiscardManager *rdm,
> -                                          MemoryRegionSection *section,
> -                                          ReplayRamDiscard replay_fn,
> -                                          void *opaque);
> +int ram_discard_manager_replay_discarded(const RamDiscardManager *rdm,
> +                                         MemoryRegionSection *section,
> +                                         ReplayRamDiscardState replay_fn,
> +                                         void *opaque);

Similar for ram_discard_manager_replay_populated() and
ram_discard_manager_replay_discarded(), since you understood
what they do :)

Thanks!

Phil.


