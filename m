Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A5A2CAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 12:52:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0g1G-0000Vi-8k; Mon, 22 Sep 2025 08:51:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v0g1E-0000Uq-MP
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 08:51:48 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v0g18-0008QF-BW
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 08:51:48 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-46b303f7469so12895905e9.1
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 05:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758545499; x=1759150299; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dtK9F3aHFtPlT79/f/Mxxb4XrEuXtrM3o9m37D37Vkg=;
 b=D+QXzXStxlS9kGbUEDLTuOA6QQr4QAlY2e4lWoEYNjvv2NcSfKhQmtA/UWCGkfmCmx
 htU9Nx7Zk52Cm3eiDzdo4QkflYi+LR560VoXRjOnSYkN8eKqcP//H3XnZ6TTkuIaFwXC
 OmH/VJSkJp8lZo3MQTDq7ZS6hoRmpSVEKQuR1DOwMfbeSICvVYba+nLEC/XE+N5BVI2d
 hni6tBjZtZoOH9iseNW7eXQwuiSRXqkk/N0eWGrF7FryVS3o5qS7H+xolfJow9uqLQXD
 BHzmKfe6IZ4eT7xIhTKuuW3cAe8nrpekWVVYbsmA1OogX6CMIMPzQVR7NWg7jeLkoIQ0
 RGUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758545499; x=1759150299;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dtK9F3aHFtPlT79/f/Mxxb4XrEuXtrM3o9m37D37Vkg=;
 b=vD+h4PgUdd/i42rtdTlLrARAJ5q7tP0h76KH0cPig2upln8+Akkjbq2LFdJEXAZE1y
 Vk5OHUn7sQrnoB5wTdJbecqhut0/yJyWXkP6l1ShB2d5iwQPnoT7XFoivWJKd3O9v67r
 x9RyGoKF4pVsO0Bkcj/DE0fTkNzb7JyugPRvF2SrAjG9YlFeunC/E0MDpCbpCKwlJZrC
 7Txfadjz3soTdj2iTunhmjSZHtpDPDZRYSsshaVtoP1vO970DEEsFcIgK98wvQbtCdJi
 PaiV2DIScLHU6lj2kzeAIKYQqo5DuF94V12bu7LLukaolGP+lu+bhi4L10pzdnZhsb2A
 DjFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUK2FUs7yw/Zn2jcnNrZ9QICmw+3iFCHw8xUDu6Mnj9qCinCsN6Yu0xGe0TSDA/3RGr9jjMTzwq5Y5f@nongnu.org
X-Gm-Message-State: AOJu0YyRKTcugquYaXGw2jsseVtocmXjkxYJFNW/raC6tuvdfgJYnq6m
 yzIQx1bVmS2Cb+0I71Weng9Td5cMQ4WDnkc/WSwazeIO5aEhmqJu52R+L+KDL/tYPmk=
X-Gm-Gg: ASbGncsVR8MmK4r9g3FrYc+OKQ4WC+dZwojcc1Sa3ue8YTjaWqPmhEgazxChmQi4Tcw
 rVN/hyaVoOZojNwyI4xuty2joYwD+hhK1PLRKJNICeSRWF/oVuVBAILE9xzORbNvWVHxQH3s9QE
 8rXNfvtn0n1NOXUGFx3eoPhTSR/uXiyfNQIwzBiP/zrzyWdY+NnrpR4WiXWveNiSuLvQ1snT5cR
 cNU0jP9ofd4Yz54LhjQVu68AJx+u/K/yYJo4yHKsggqZ06PAPv3Dfp9aUomXD+ZhicV9w1KL/ze
 cpSDr2Ak3J6fIb2GQCkx5Vszlu8c835eHcmF2lGc/g4F8MrPj2OEuFWbGkoFodf0fwV+8SLefmH
 AGohnyjuH4391IGcOCjxU+MuwnAGRzu27yQ==
X-Google-Smtp-Source: AGHT+IGNQnOIFXp81z1ukv3VkSvQuvA2qa79oVl/blIBzmdgqsrkINhDmcqwA4Ab1lT426A0C/8ucA==
X-Received: by 2002:a05:600c:3595:b0:45d:e0cf:41c9 with SMTP id
 5b1f17b1804b1-4680b51acaamr132814595e9.22.1758545498388; 
 Mon, 22 Sep 2025 05:51:38 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45f325a32f6sm138493195e9.2.2025.09.22.05.51.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Sep 2025 05:51:37 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 9AFEA5F7C4;
 Mon, 22 Sep 2025 13:51:36 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,  Christian Speich
 <c.speich@avm.de>,  qemu-devel@nongnu.org,  Stefano Garzarella
 <sgarzare@redhat.com>
Subject: Re: [PATCH] virtio: vhost-user-device: Make user creatable again
In-Reply-To: <aNE0Bp0hsA31sLCJ@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Mon, 22 Sep 2025 12:33:26 +0100")
References: <20250919-vhost-user-device-creatable-v1-1-87eefeea7f68@avm.de>
 <20250919160526-mutt-send-email-mst@kernel.org>
 <aNE0Bp0hsA31sLCJ@redhat.com>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Mon, 22 Sep 2025 13:51:36 +0100
Message-ID: <87frceodk7.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x332.google.com
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Fri, Sep 19, 2025 at 04:07:19PM -0400, Michael S. Tsirkin wrote:
>> On Fri, Sep 19, 2025 at 04:30:53PM +0200, Christian Speich wrote:
>> > This removes the change introduced in [1] that prevents the use of
>> > vhost-user-device and vhost-user-device-pci on unpatched QEMU builds.
>> >=20
>> > [1]: 6275989647efb708f126eb4f880e593792301ed4
>> >=20
>> > Signed-off-by: Christian Speich <c.speich@avm.de>
>> > ---
>> > vhost-user-device and vhost-user-device-pci started out as user
>> > creatable devices. This was changed in [1] when the vhost-user-base was
>> > introduced.
>> >=20
>> > The reason given is to prevent user confusion. Searching qemu-discuss =
or
>> > google for "vhost-user-device" I've seen no confused users.
>> >=20
>> > Our use case is to provide wifi emulation using "vhost-user-device-pci=
",
>> > which currently is working fine with the QEMU 9.0.2 present in Ubuntu
>> > 24.04. With newer QEMU versions we now need to patch, distribute and
>> > maintain our own QEMU packages, which is non-trivial.
>> >=20
>> > So I want to propose lifting this restriction to make this feature
>> > usable without a custom QEMU.
>> >=20
>> > [1]: 6275989647efb708f126eb4f880e593792301ed4
>>=20
>> The confusion is after someone reuses the ID you are claiming without
>> telling anyone and then linux guests will start binding that driver to
>> your device.
>>=20
>>=20
>> We want people doing this kind of thing to *at a minimum*
>> go ahead and register a device id with the virtio TC,
>> but really to write and publish a spec.
>
> Wanting people to register a device ID is a social problem and
> we're trying to apply a technical hammer to it, which is rarely
> an productive approach.
>
> If we want to demonstrate that vhost-user-device is "risky", then
> how about we rename it to have an 'x-' prefix and thus disclaim
> any support for it, but none the less allow its use. Document it
> as an experimental device, and if it breaks, users get to keep
> both pieces.
>
> It seems like it would be useful before any virtio spec submission
> as a mechanism by which users can experiment to finese their ideas
> prior to getting to the point of needing to make a spec proposal.

That's basically it. Adding the stubs is fairly trivial for vhost-user
backends that implement the config space but you can't add stubs for
things that are currently RFC specs. Also you are forcing a delay for
the spec to be updated and then wait for the next QEMU with the stub
added.

>
> With regards,
> Daniel

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

