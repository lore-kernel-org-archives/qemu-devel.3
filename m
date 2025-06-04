Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8028AC5B552
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 11:30:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMmJl-0004S1-02; Wed, 04 Jun 2025 07:30:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1uMmJi-0004RV-CR
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 07:29:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1uMmJf-0005jk-VV
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 07:29:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749036593;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=VcMmxM8BV27BI5GGovm6YWQ95xlppESodfFirxn74hI=;
 b=Ytkpo/Haol9K+3tR+gIWnUAeTnTNhw576TveSNlGWiHsrnrZATCrUhDL/+WRoUT6P10LTP
 XLSOEvjPlhXZbER5R+j5gU20XPUE9pB/Imtuzqt+CnbvzOPWAFpnld0TFyJgHqyAy5FXib
 0J240U8rM7UljW7+fz/KUC4MWjRAGS4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-230-URWjplcKOdqWUxgQr_Cb5w-1; Wed, 04 Jun 2025 07:29:52 -0400
X-MC-Unique: URWjplcKOdqWUxgQr_Cb5w-1
X-Mimecast-MFC-AGG-ID: URWjplcKOdqWUxgQr_Cb5w_1749036591
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-451d5600a54so30231385e9.2
 for <qemu-devel@nongnu.org>; Wed, 04 Jun 2025 04:29:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749036591; x=1749641391;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=VcMmxM8BV27BI5GGovm6YWQ95xlppESodfFirxn74hI=;
 b=C7U1jpg+gCHYUpm56xRfrXirtb4Mwc+t+NeulmAHi6BWh6Zfm7KZKBmXd0v/GAk4Ez
 SbATrW/aMuYYtY8qa4B32TIhXwZaF+I4QbNUYLgCAxN2MNg1SkOnokvXrNeH0QNQ3lY6
 Wq7fGNlGzzwdZiVzWOJCaEaUKigGQZwV4mQWSyh6NUD+uYHM53hLF5HrzPckgYUVTKyr
 30hT8veeQbyNqUr5INxBQnxhzbtssAD6t31cRHGD8YLSW1HffLVgXzhm5/HJBrbzZpYa
 mY7m3bBLygCuAoFPQPrjiP8h/yJQpRS+2mTOpgjFAcFro/wbBqYV7je50rAxj6j0dUCw
 XkJQ==
X-Gm-Message-State: AOJu0YzTg5IQNSGwRNRhIvOZ3iVecjdGOQ3f4nRewqNDOlveMLTjsq2G
 dvg5bfecWToba0Zs6/PD1s7Xm8JtgsdH53LZSQ6hSvl2Z1LQhd73lTwjIVQuJ38CulaUB2Vdw6W
 7Dl0rpGktfVN6EMakjYf02nK7/e7UjY/8QyKGMwsu+uFN8dCqXZAY9hK+
X-Gm-Gg: ASbGncuB2j4ZJ4Z0O1oeBy3EcW0X8QdZKo5gYkWigxqPgFk3uNfy+a7BkyYAym5LWfa
 8+xG5/jru8LTRxm2KgxG4ETGYpVaLrmuWrrOWESU3P+jPN0XbyQmh/PG4nO+u71QFhktCAt5uIf
 2wespx0x8MY4DJPDL5g6E6DE3WZje0KEER8YSKwsOxcM1u7VabvSsgMdymzb1qaS4WqiY2tB+A3
 B4CwCq0B7Z1AM/K+M03TxBl4yFUsnao/2KgPMLkUbasH8j9FTztecxQpUXq1NoXS1ssO/a11Z5/
 2yqParq/vew2FgkpwPk1+ICdrgbSYR5zM4gZnjOXqKtPztgxLUn7EkAkUpB/RAwT59XQXtUw+Ez
 HPzVQESUARNJYkjnzvBfITH9G0S5NCDOhRIrL/uA=
X-Received: by 2002:a05:600c:4ec6:b0:43c:ec0a:ddfd with SMTP id
 5b1f17b1804b1-451f0a64c0amr20239545e9.6.1749036591152; 
 Wed, 04 Jun 2025 04:29:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvuFQF/8b7k7hr3pcERBG9Jeu7Z4bRrBOvojwxfnOLddVfCMXdF9KQx11TSXpijAT+/REwEQ==
X-Received: by 2002:a05:600c:4ec6:b0:43c:ec0a:ddfd with SMTP id
 5b1f17b1804b1-451f0a64c0amr20239275e9.6.1749036590708; 
 Wed, 04 Jun 2025 04:29:50 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f1b:b800:6fdb:1af2:4fbd:1fdf?
 (p200300d82f1bb8006fdb1af24fbd1fdf.dip0.t-ipconnect.de.
 [2003:d8:2f1b:b800:6fdb:1af2:4fbd:1fdf])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-451ef77b467sm28058735e9.36.2025.06.04.04.29.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Jun 2025 04:29:50 -0700 (PDT)
Message-ID: <49a69be3-0368-440c-8263-0f3eeae7313c@redhat.com>
Date: Wed, 4 Jun 2025 13:29:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/5] physmem: Support coordinated discarding of RAM
 with guest_memfd
To: Chenyi Qiang <chenyi.qiang@intel.com>, Alexey Kardashevskiy
 <aik@amd.com>, Peter Xu <peterx@redhat.com>,
 Gupta Pankaj <pankaj.gupta@amd.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Roth <michael.roth@amd.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Williams Dan J <dan.j.williams@intel.com>, Zhao Liu <zhao1.liu@intel.com>,
 Baolu Lu <baolu.lu@linux.intel.com>, Gao Chao <chao.gao@intel.com>,
 Xu Yilun <yilun.xu@intel.com>, Li Xiaoyao <xiaoyao.li@intel.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Alex Williamson <alex.williamson@redhat.com>
References: <20250530083256.105186-1-chenyi.qiang@intel.com>
 <20250530083256.105186-6-chenyi.qiang@intel.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250530083256.105186-6-chenyi.qiang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 30.05.25 10:32, Chenyi Qiang wrote:
> A new field, attributes, was introduced in RAMBlock to link to a
> RamBlockAttributes object, which centralizes all guest_memfd related
> information (such as fd and shared bitmap) within a RAMBlock.
> 
> Create and initialize the RamBlockAttributes object upon ram_block_add().
> Meanwhile, register the object in the target RAMBlock's MemoryRegion.
> After that, guest_memfd-backed RAMBlock is associated with the
> RamDiscardManager interface, and the users can execute RamDiscardManager
> specific handling. For example, VFIO will register the
> RamDiscardListener and get notifications when the state_change() helper
> invokes.
> 
> As coordinate discarding of RAM with guest_memfd is now supported, only
> block uncoordinated discard.
> 
> Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
> ---
> Changes in v6:
>      - Squash the unblocking of cooridnate discard into this commit.
>      - Remove the checks in migration path.
> 
> Changes in v5:
>      - Revert to use RamDiscardManager interface.
>      - Move the object_new() into the ram_block_attribute_create()
>        helper.
>      - Add some check in migration path.
> 
> Changes in v4:
>      - Remove the replay operations for attribute changes which will be
>        handled in a listener in following patches.
>      - Add some comment in the error path of realize() to remind the
>        future development of the unified error path.
> 
> Changes in v3:
>      - Use ram_discard_manager_reply_populated/discarded() to set the
>        memory attribute and add the undo support if state_change()
>        failed.
>      - Didn't add Reviewed-by from Alexey due to the new changes in this
>        commit.
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


