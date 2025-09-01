Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 066CCCA1002
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 11:01:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut2I8-0007E1-8U; Mon, 01 Sep 2025 07:01:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ut2Hu-00072u-7U
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 07:01:27 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ut2Hl-0001vy-3C
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 07:01:21 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3cbe70a7923so3247473f8f.2
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 04:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756724474; x=1757329274; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MkCbogk/efZJ0KLbVBX6ULxMCBrzvyHbeRfPU451Pv0=;
 b=QQ1iZbFhMbOJNS+iF+Gbv1debVEiOiU3bBKi53NbH176+wJOYCcNQaPRIW5DuGXnYf
 EuRF1oifV2WSXGm9bA0a4coLnIud/cXJVwiCb4D15tvhxW6OIJOhj5K4grtGhFtQK5ED
 6udaURZ0roPO/3A8GqhjVGhnXsNUJnZerNykghimAcbFKrwx90/K9GSnkq9fP0ODDH6p
 BCO+ysCJo8/qLLEIX7mIgRzo2SF9RHfLyvQOVsGSOAsPmOdPaEZJoPAy7i7qy32Q4Qz+
 YdPWP81fGxxMs1+UMyPzZca5hlMeBXoyKP8Oacz5SYd1ISloXIQQ8nrchtYWpDrBkw6w
 g0hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756724474; x=1757329274;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MkCbogk/efZJ0KLbVBX6ULxMCBrzvyHbeRfPU451Pv0=;
 b=IeyuaH9ErHyEtrteVFzc7qXLO1ib3PLscr5H7wV9f5hJKu01psw76vjTtMJH6xJsMm
 RzRhto+5H/xjQKcGp1DApR4dkJRutpxiFXgZEKvLbVRPXrh4fd8jUcZkKZ2la2x01d9R
 6VVKcB2nZzeE3ECyapNH/hAq6FoUuLBSV7ClbA/uIoNQQCWLS/U7Q7o2PuQm2/XCqKsr
 yALqFS31ZWg567ZuqJknvewKTBcpCCiE0NIyPoXms23AhZlaa7XS5AAgRGdDadwBzVQc
 9+Oy9aBEktkee4nvOaoeXj6jnaZmCqjv2W6vFEEoV1b/Hg09HncJSveg/lXwhVlYXodX
 +h1w==
X-Gm-Message-State: AOJu0Yx0fzZfUoRCwPQ7WZ1AI/SgTw0xh6iIBAcEo6G7eDaCWWB2OM2p
 tkGV65dCVItXT8Ev8kEQqpHyKTsG/VIB+xbzwnYttE6OQVoCQo71/g1mB4fMHrPXgjjxxUuQNlM
 M6pLxIuA=
X-Gm-Gg: ASbGncvCPIIi34DXMVYLN6l0Ys8h6i55FG+lIyhKumKlvufoq/8Pg6hz1j+HpmdJXbX
 HBZ48ncGHE2GfQGr2htrvAkWVlLVUAo9hGxqnZYcK+6LlAFueB03rd0Bq3Dsv3OR2mRKVG0jpx6
 F5hQB0rEV9pQUvy41x/B/+DzHzERblgEMvUXm0KNfPXF1PsyLQg+lxu1tKS2naCbFvhpOjPDM/a
 Z2XzV5t15CrEDpmPUk72UNq7BEHbaAwFLR0o6HHVFxVLojy4+3F6TltxpGacnMrsRoeTM6+WZhI
 +ow68tJENDPIlU+upqQ7jw74Svwn/+4jx2gIUmO558ijfweurkfLAcrV3oDJLmGMGmkTnQcimRi
 NPQs4QZ9LqnghPd/BP53DqZA=
X-Google-Smtp-Source: AGHT+IEud1io77LhrStnZV61FgBei8dTqUuBhgeyuIGgXPMI69TZdTRHUFwUWMHdxvSoKM9GU9tOmw==
X-Received: by 2002:a05:6000:4021:b0:3ce:e9d6:ad24 with SMTP id
 ffacd0b85a97d-3d1e05bab3dmr5303570f8f.50.1756724474408; 
 Mon, 01 Sep 2025 04:01:14 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3cf34493b8csm14568857f8f.59.2025.09.01.04.01.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 04:01:13 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B86D85F7F5;
 Mon, 01 Sep 2025 12:01:12 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Stefano Garzarella <sgarzare@redhat.com>,  Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>,  Stefan Hajnoczi <stefanha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] hw/virtio: rename vhost-user-device and make user
 creatable
In-Reply-To: <20250828104021.3910859-1-alex.bennee@linaro.org> ("Alex
 =?utf-8?Q?Benn=C3=A9e=22's?= message of "Thu, 28 Aug 2025 11:40:21 +0100")
References: <20250828104021.3910859-1-alex.bennee@linaro.org>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Mon, 01 Sep 2025 12:01:12 +0100
Message-ID: <87cy8a3093.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x431.google.com
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

Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> We didn't make the device user creatable in the first place because we
> were worried users might get confused. Rename the device to make its
> nature as a test device even more explicit. While we are at it add a
> Kconfig variable so it can be skipped for those that want to thin out
> their build configuration even further.
>
> Acked-by: Stefano Garzarella <sgarzare@redhat.com>
> Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Message-ID: <20250820195632.1956795-1-alex.bennee@linaro.org>
>
<snip>
> --- a/hw/virtio/vhost-user-device-pci.c
> +++ b/hw/virtio/vhost-user-test-device-pci.c
> @@ -18,13 +18,13 @@ struct VHostUserDevicePCI {
>      VHostUserBase vub;
>  };
>=20=20
> -#define TYPE_VHOST_USER_DEVICE_PCI "vhost-user-device-pci-base"
> +#define TYPE_VHOST_USER_TEST_DEVICE_PCI "vhost-user-test-device-pci"

oops dropping the -base here broke:

>=20=20
>  static const VirtioPCIDeviceTypeInfo vhost_user_device_pci_info =3D {
> -    .base_name =3D TYPE_VHOST_USER_DEVICE_PCI,
> -    .non_transitional_name =3D "vhost-user-device-pci",
> +    .base_name =3D TYPE_VHOST_USER_TEST_DEVICE_PCI,
> +    .non_transitional_name =3D "vhost-user-test-device-pci",
>      .instance_size =3D sizeof(VHostUserDevicePCI),
>      .instance_init =3D vhost_user_device_pci_instance_init,
>      .class_init =3D vhost_user_device_pci_class_init,
<snip>

the checking here. So I have sent v2:

  Subject: [PATCH v2] hw/virtio: rename vhost-user-device and make user cre=
atable
  Date: Mon,  1 Sep 2025 11:59:48 +0100
  Message-ID: <20250901105948.982583-1-alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

