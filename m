Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD62DCD98E4
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 16:29:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZWeo-0006OK-8G; Tue, 16 Jun 2026 12:28:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wZWem-0006NM-PQ
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 12:28:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wZWek-0005rh-RK
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 12:28:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781627333;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=wis0ts/l9aFM0cQ54p59AWlqTfu1mZY+bhD2hk4rBSY=;
 b=c2JHV4A7FvPiUKYcsIQBJQo/1vtS4VSE97fMb1MQ17KSqwRr202h1K064D9X7GCxt53mvV
 0yagd/+D7RGHSLPZhg09sriEQiEAxnmzDtqpnbM/MKtyvyS2EjPTLvyXaatrz0huUbz+x5
 6922eEx1IPGnDIUlMRzSvZB0UnADe54=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-351-_L4CGX-jM7uXLSATX3DvcQ-1; Tue, 16 Jun 2026 12:28:51 -0400
X-MC-Unique: _L4CGX-jM7uXLSATX3DvcQ-1
X-Mimecast-MFC-AGG-ID: _L4CGX-jM7uXLSATX3DvcQ_1781627331
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-490b9cd54f3so28238015e9.2
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 09:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781627330; x=1782232130; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=wis0ts/l9aFM0cQ54p59AWlqTfu1mZY+bhD2hk4rBSY=;
 b=TiuBkYEd8CQIeYEcG1idL4eLGBNgD1kv47Kat0dAYcTAQN5VhmCCOJata955VgwSBL
 CEr/x2r1lNCcvsb2QCTHagSgUS9vsl8wuT4Hl0ga9N3V2BG5UrZZgTjto6WD1Cf9Ssc0
 lIT4dx0yAUPbtqJaBeUAIhR6MuKwonV9xrXV+knROtsS0qb5Y1Vc5CkCno7ZM4PYu43V
 u19M3yi71NpsdRgP6oSRkrmt8/e5TUTpvdhgkKXEd4sdQIXCySrJ1XHzNrsiggpgpnWv
 XhQimNSFs8QfsnY4p48aEOYcdFJUhNiGJDt6YzUzkqlQbhzddgU/h2RDXM979RR/L8q2
 sJEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781627330; x=1782232130;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wis0ts/l9aFM0cQ54p59AWlqTfu1mZY+bhD2hk4rBSY=;
 b=Tf8OYD/U/THkJcEfMyrpD7BPXn4VTbu//h2LRVy+aftV73VHt+zNJ8b7CDKk6Jl6i5
 sR337BufeflAZ8BF1P7h5xxSkqo6gOGZ4SUzXY2nIZp/vAb4l+TDF6ggOZs/l45mRtMG
 6MHZhgDr3cV2Iq9xw7Qi5fKuAi+r9RuCl8UrB5M4jf3QLH06UPe6bwFgVSEyvC+kV5N8
 /EULXHfePYNzBnkc0QXp7POV5sLHJUb3CSzEtPFrgR5siu0HbkDaPkDlPnWon3C5gwSY
 mVbw3Y+9EqzIWOL8vB9oVd1p7CHsLgz1nk9JtfKDGELUD/mg7yDICd2hK5Fp/VXxv1Lp
 yBMw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/di4VKHYyyUS7Bz2EeWAt9op/hdhjhyOe5wrWyXEWSwxdfZOZnnXVqRmooudnD+fQFkWarHZHPmBFR@nongnu.org
X-Gm-Message-State: AOJu0Yxi2mArYUOBm3V8SjbjUAcHsf1J67zSk+m9tZTXIawRkA5TFNRx
 ngM7TAFIdPMyaTPhMPAJC7YBc2NnS98VruvW/l9E5HoYS+MdvZfZQQ3w0lgs761XW8plrZU9/j4
 GK9EjcGOlXZvlPMlJaqZp5tOYoWSDnFJzxrhiSpnYE+HKQtBrHOBhizXT
X-Gm-Gg: Acq92OHhhJvRQ5PbUTgynD61NgkDREyi21h0nuOUN59T51wUnfVkE/56WCTnArxziFG
 L+ST3IrSw0yqhZJDZQV2eSwjA1jFnM09szpwjDQi+1AMjJ8cwga7dBiocU/5fowGeTav4sQMrqn
 +Ba/TZAlwrF2D9S0M3sEpWEnv09MqY4QRbAvLURl8OgpacleevUMO72ysQDm3rghbOiFCDMVqyu
 HMgPESZ8Npy2sbANmo7wcz4vw8ezRT5A9+BN/Ok6SzhDj0Cl7sD07eRQ0qaDwCdwRG5I3jcZ8IU
 tpLhNzaI2C4oA7ZZ/s9h2qKouhlwlxQb0YKtA3T5Cagzc0ny1Du6zpv4PBe9H9rWp1pOBPY8ce0
 s0oGl9sX1DcLvqoAPaVMvEhYeR67FN86las4YcOlsL+whAHY6DUKcJOiCYykV
X-Received: by 2002:a05:600c:80c1:b0:490:6e12:542d with SMTP id
 5b1f17b1804b1-492333e2f1bmr3164435e9.19.1781627330474; 
 Tue, 16 Jun 2026 09:28:50 -0700 (PDT)
X-Received: by 2002:a05:600c:80c1:b0:490:6e12:542d with SMTP id
 5b1f17b1804b1-492333e2f1bmr3163785e9.19.1781627329858; 
 Tue, 16 Jun 2026 09:28:49 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49230a96b47sm64085335e9.13.2026.06.16.09.28.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jun 2026 09:28:49 -0700 (PDT)
Message-ID: <2f6725d5-3b35-4a12-9f18-2812fe6bed27@redhat.com>
Date: Tue, 16 Jun 2026 18:28:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/35] docs: start a vfio-pci document
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Alex Williamson <alex@shazbot.org>, Peter Maydell
 <peter.maydell@linaro.org>, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
References: <20260611-b4-ui-v3-0-72bcbbea0fae@redhat.com>
 <20260611-b4-ui-v3-6-72bcbbea0fae@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260611-b4-ui-v3-6-72bcbbea0fae@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hello,

Subject could be :

   docs: add mdpy mdev vfio display testing guide ?

On 6/11/26 11:03, Marc-André Lureau wrote:
> Add a section to help me remember how to test vfio display hotplug.

May be :

Document how to test VFIO display hotplug using the kernel mdpy mdev
sample
  
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   docs/devel/index-internals.rst |  1 +
>   docs/devel/vfio-mdpy.rst       | 83 ++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 84 insertions(+)
> 
> diff --git a/docs/devel/index-internals.rst b/docs/devel/index-internals.rst
> index 7a0678cbdd3..198f155247a 100644
> --- a/docs/devel/index-internals.rst
> +++ b/docs/devel/index-internals.rst
> @@ -22,6 +22,7 @@ Details about QEMU's various subsystems including how to add features to them.
>      tracing
>      uefi-vars
>      vfio-iommufd
> +   vfio-mdpy
>      writing-monitor-commands
>      virtio-backends
>      crypto
> diff --git a/docs/devel/vfio-mdpy.rst b/docs/devel/vfio-mdpy.rst
> new file mode 100644
> index 00000000000..14cddd11d81
> --- /dev/null
> +++ b/docs/devel/vfio-mdpy.rst
> @@ -0,0 +1,83 @@
> +.. SPDX-License-Identifier: GPL-2.0-or-later
> +
> +===================================
> +Testing VFIO display with mdev mdpy
> +===================================
> +
> +.. contents:: Table of Contents
> +
> +The kernel provides a sample mediated device driver, ``mdpy``
> +(``samples/vfio-mdev/mdpy.c``), that exposes a fake framebuffer through the VFIO
> +display region interface. It can be used to test VFIO display support, including
> +hotplug, without any real GPU hardware.
> +
> +The kernel modules
> +==================
> +
> +The ``mdpy`` driver depends on the ``mdev`` subsystem. Enable, build and load
> +the modules.

The minimal set is:

     CONFIG_SAMPLE_VFIO_MDEV_MDPY=m
     CONFIG_SAMPLE_VFIO_MDEV_MDPY_FB=m   # guest framebuffer driver

CONFIG_VFIO_MDEV is selected automatically.


> +
> +Verify that the driver registered successfully:
> +
> +.. code-block:: bash
> +
> +    ls /sys/devices/virtual/mdpy/mdpy/mdev_supported_types/
> +
> +Creating an mdev instance
> +=========================
> +
> +Available types correspond to different resolutions (e.g. ``mdpy-vga``
> +for 640x480, ``mdpy-xga`` for 1024x768, ``mdpy-hd`` for 1920x1080).
> +
> +Each mdev instance is identified by a UUID:
> +
> +.. code-block:: bash
> +
> +    uuid=$(uuidgen)
> +    echo "$uuid" > /sys/devices/virtual/mdpy/mdpy/mdev_supported_types/mdpy-xga/create
> +
> +To remove the instance later:
> +
> +.. code-block:: bash
> +
> +    echo 1 > /sys/bus/mdev/devices/$uuid/remove
> +
> +Make sure your user has the necessary permissions to access the vfio group.
> +(ex: chmod 666 /dev/vfio/16)
> +
> +Starting QEMU
> +=============
> +
> +Boot-time attachment
> +--------------------
> +
> +.. code-block:: bash
> +
> +    qemu-system-x86_64 -machine q35 -m 1G \
> +        -device vfio-pci,sysfsdev=/sys/bus/mdev/devices/$uuid,display=on \
> +        -display gtk,gl=on
> +
> +Hotplug via HMP
> +---------------
> +
> +Start QEMU with a PCIe root port (required for PCIe hotplug) and a
> +monitor:
> +
> +.. code-block:: bash
> +
> +    qemu-system-x86_64 -machine q35 -m 1G \
> +        -device pcie-root-port,id=rp0,slot=1 \
> +        -display gtk,gl=on \
> +        -monitor stdio
> +
> +Then at the ``(qemu)`` prompt:
> +
> +.. code-block:: none
> +
> +    device_add vfio-pci,sysfsdev=/sys/bus/mdev/devices/<uuid>,display=on,bus=rp0,id=mdpy0
> +
> +To hot-unplug:
> +
> +.. code-block:: none
> +
> +    device_del mdpy0
> 

Thanks,

C.


