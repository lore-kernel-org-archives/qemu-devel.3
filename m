Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71904C369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 21:03:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAEZl-0001Oe-DR; Wed, 30 Apr 2025 17:02:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nirsof@gmail.com>) id 1uAEZk-0001Nf-Cu
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 17:02:40 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nirsof@gmail.com>) id 1uAEZi-0000Xm-GC
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 17:02:40 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-39ee57c0b8cso206374f8f.0
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 14:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746046957; x=1746651757; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sYTTAKxlNtF708pviBF8zUHYU9OK+3a1/q7rl9HdDsg=;
 b=P/TsxsAp3zZ8wf7qGOfqSIoTeM09qIKjHT31LAL89pfTUcFnDLr3LzqRTS08je0PEw
 Qk7m5TwSwSpHOr1XDWkuf4rbjIS1Hbvj0uTAOVZnZ+N4E7aGwvMKE7vGOyXWuW3JqCzD
 czocrOHlNxDlicpINr1OHpxAHAQqZ2TR7NBZB+jfjgBvkMiQ+uKLmlzQRKRN9xK5l3p7
 gEWdKXdIYoKwNWQN6iYzON99HkmhJEAqok0hSXuGm2vibU0IzBKohsu40eHVMUmXutaR
 OD7ydlZkRI3pZG5by5n2zAuX2lGmBmI7SCm+Tkk6MHuPRB8ZTJSl6/YKy5PFTx8hDV9Y
 8xCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746046957; x=1746651757;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sYTTAKxlNtF708pviBF8zUHYU9OK+3a1/q7rl9HdDsg=;
 b=Tl6dFIMxy25mWk9zIPxxkqqQZZDlaJ/ygx0MmYubkr2/r3V+jJJ52rOtpBXzw8zwYQ
 c/4qPEuie+fzVPX1N3FQbLpV4um3XVVkYAa7mIC3jV3ZoI+L3jvVydpiNp9ywK5Vp4aE
 KLYLlqFrhbjK15QJHFaNRGeTXwVr37jimmVFGM2Dp+j0TnWxhxYLnpmFsi8hIpyXvKaS
 1k06gAeGdLnyzSrGM8qngar+aNUO6coHzGfejD/+fzKpd7eHascw/bVc09DIYbG2ttck
 uUspwRxXOuMn0zRedzf8O54wYPO5w2+Aj6hvMhTbNW5nmFZFlgmZ4pt0EvdOQsIhBMIp
 DdLQ==
X-Gm-Message-State: AOJu0YwzQWhfxvvDl5VIsjJ6nl65jbw2vU4o5eYDl+l/YQ66U/qGZ1Ii
 OGjiwURK/ieKhp2YxmvNMRRCzFWxP6zt+ja80kFJy0UJ+bvXaNb4HaiCqew6
X-Gm-Gg: ASbGnctWgepw1OfpXn3tH61rYLN6xLcx0A87AlUaLukbVl+gpB2lvxqg5rDDtl4+NS5
 ZNGW9rBUHBc7pZKiXh0QBppiZrVV7Z8//smuJT/JxQrcWfCjKdopdwUf20d1wyBrQCUBwzySwLN
 QaNHoWqpSk55zerHaVRqhUft8hnTz6gMpztCnIKHaMl6kEEqKkiCwfSzPhc52otyNR7+MrjspuM
 xqpRXqH/Kyg7+0Z3jmMXPrEASUH++FR7NokBkSF2+azOwWUBRb3wRHjSl+WkXTj8Rc8CMHSfkZH
 1VJdBy83rIYVJrgZBdlYyLZ6g4/lrfZci0HXgIGldLarsc/NSuOf+rBR48/f3k3izgCm+akTXip
 DooSuxAs9euqA9iOX
X-Google-Smtp-Source: AGHT+IEPdUub5mI/eeFq2FIhdmm5I5JHdSJjyX7ty2Y+ePhmGgzIwFKCtRjE9QrySgdxMeajMMJ19Q==
X-Received: by 2002:a5d:59af:0:b0:39c:142a:ed6c with SMTP id
 ffacd0b85a97d-3a08f7a4872mr4750491f8f.40.1746046956579; 
 Wed, 30 Apr 2025 14:02:36 -0700 (PDT)
Received: from smtpclient.apple (46-116-102-127.bb.netvision.net.il.
 [46.116.102.127]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073ca4742sm17626252f8f.23.2025.04.30.14.02.35
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 30 Apr 2025 14:02:36 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.500.181.1.5\))
Subject: Re: [PATCH v3 2/2] io: Increase unix socket buffers on Linux
From: Nir Soffer <nirsof@gmail.com>
In-Reply-To: <ttbupbckoby7agbxdpwrnnkigahb7w4bsujjiz3o5kefyjrkgc@a6xmrs6fcwp5>
Date: Thu, 1 May 2025 00:02:24 +0300
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Daniel Berrange <berrange@redhat.com>, Richard Jones <rjones@redhat.com>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <8F7E5FA2-FB65-467D-8AF6-606F0EFB5963@gmail.com>
References: <20250427165029.9072-1-nirsof@gmail.com>
 <20250427165029.9072-3-nirsof@gmail.com>
 <ttbupbckoby7agbxdpwrnnkigahb7w4bsujjiz3o5kefyjrkgc@a6xmrs6fcwp5>
To: Eric Blake <eblake@redhat.com>
X-Mailer: Apple Mail (2.3826.500.181.1.5)
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=nirsof@gmail.com; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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


> On 29 Apr 2025, at 0:37, Eric Blake <eblake@redhat.com> wrote:
>=20
> On Sun, Apr 27, 2025 at 07:50:29PM +0300, Nir Soffer wrote:
>> Like macOS we have similar issue on Linux. For TCP socket the send
>> buffer size is 2626560 bytes (~2.5 MiB) and we get good performance.
>> However for unix socket the default and maximum buffer size is 212992
>> bytes (208 KiB) and we see poor performance when using one NBD
>> connection, up to 4 times slower than macOS on the same machine.
>>=20
>=20
>> +++ b/io/channel-socket.c
>> @@ -39,12 +39,13 @@
>> #define SOCKET_MAX_FDS 16
>>=20
>> /*
>> - * Testing shows that 2m send buffer gives best throuput and lowest =
cpu usage.
>> - * Changing the receive buffer size has no effect on performance.
>> + * Testing shows that 2m send buffer is optimal. Changing the =
receive buffer
>> + * size has no effect on performance.
>> + * On Linux we need to increase net.core.wmem_max to make this =
effective.
>=20
> How can we reliably inform the user of the need to tweak this setting?

Maybe log a warning (or debug message) if net.core.wmem_max is too =
small?

For example libkrun does this:
=
https://github.com/containers/libkrun/blob/main/src/devices/src/virtio/net=
/gvproxy.rs#L70

If we document this some users that read the docs can tune their system =
in a better way.

What is the best place to document this?

> Is it worth a bug report to the Linux kernel folks asking them to
> reconsider the default cap on this setting, now that modern systems
> tend to have more memory than when the cap was first introduced, and
> given that we have demonstrable numbers showing why it is beneficial,
> especially for parity with TCP?

Makes sense.

What is the best place to discuss this or file a bug?


