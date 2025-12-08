Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69837D3B7ED
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Dec 2025 10:09:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSYAO-0000U5-SQ; Mon, 08 Dec 2025 05:08:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vSYAL-0000SG-7x
 for qemu-devel@nongnu.org; Mon, 08 Dec 2025 05:08:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vSYAJ-0002LQ-G0
 for qemu-devel@nongnu.org; Mon, 08 Dec 2025 05:08:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765188501;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=WWPS4QYMCmz34Cm1MwDwgIe/qGzIpFi/KrEE8aEGrFU=;
 b=Mma731FxSK75S85GkhyyfjNM/uK7jw85oAtm2YcHpVXrnjWIeGrgAkFc2rDpEnnsTpU0y2
 k8fANHXWDS5y0HCh+Vs0/YiL49w1jjPbPuVpQa3qoGQQT2wCCWpPxC/LtAnxpw8vpIc9Us
 QHGUfizfcbb17jrc/w5jzeO4d7PjJ4c=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-5G886ikKP2eTbzzyPDBWzA-1; Mon, 08 Dec 2025 05:08:18 -0500
X-MC-Unique: 5G886ikKP2eTbzzyPDBWzA-1
X-Mimecast-MFC-AGG-ID: 5G886ikKP2eTbzzyPDBWzA_1765188497
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4779b3749a8so33002915e9.1
 for <qemu-devel@nongnu.org>; Mon, 08 Dec 2025 02:08:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765188497; x=1765793297; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=WWPS4QYMCmz34Cm1MwDwgIe/qGzIpFi/KrEE8aEGrFU=;
 b=l8SSrhHspfPcoR2EUUHDesvTK6S5zKI2HKoVn6TZ+fa+I3trTb5brUiLNSzYezSqci
 wmpdx1jimJRRRqF5DKvmF5YKI2ZJpEREEh0GC4f99foREk7wracRopmh08TKhKTF6f+3
 5AIxy9uDKq8pRyynr59Jrmf2aygql3xXjxsAnJgx4xd4AtKgGOqXZnMKwMjdJCX4LpjY
 pImrhapMl8YI9XXYLlyWmShtFUVeVi7XnjkZFYoPgLlybN/HDR0Pf7lbFOCOhJ6oDLNx
 jm3kPOq12TKKmL+45KRul4r4CrS/zUKntG1ho0UFv1PnWg7O+CplwvuB22T7y8lLc8HC
 K8RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765188497; x=1765793297;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WWPS4QYMCmz34Cm1MwDwgIe/qGzIpFi/KrEE8aEGrFU=;
 b=H0TMgJxM7g4d0lt8FhG7IEbP03zFqVngvGBET5UZxf3fUEaMZtLq4/gfD4prG9ux/u
 e/j0MPjpyFmdjUnrcmDE48rcsj3H5Wng+JRFH8Z4UbgFVXv+6qS3RRo8bXPzJVsO2oIW
 hnkMos/lJ4d4qfk7/ZdlEiMT7/zOqyAcvb98jWtUQGsbHdXhlGMalZSbA9DQPfS9jA+t
 qv8Q/v+jST/ja8k0K/03eMVHLmMWk6On5wM3bd1jqRASF1aa41iYMqty5Ofd3eEnQ7Me
 ANEZEuwOtbcp5fxfl1gmCoOfW99V1ikWZY0iC9m13TgxUmVFRvZYxmFBfiSZLbA2GjwH
 feVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWax7XiqfK2O4JUZpZy7+ICfXnUPXcGwFQQetaq/TmiwtPAEGpMaMO1njL+w5fF+LTplNCp6JLRpUt1@nongnu.org
X-Gm-Message-State: AOJu0YxfSIuacEE1MYrwWkVb4UOxSS6WvI6V/vhK4zSjhqON4aeFxhCe
 VaxIyhmzEmjEKmSJiltnZLc2/m1rMJbkXKxhz4H+6qdqMgIeZEwcqAPjFIcgvgNtezZkaU8ffFE
 gP7IZouo4cJfCaYEMQge0jMLfQRcNcfuIIV9riIJs4gbMFU3o3w0AwUwi
X-Gm-Gg: ASbGncsIEb2XZBHN+dlcqt9ZMiQJnWfbEmT8HST4HfjL+OfC+LyJm2kSbZDSAFGcfuN
 lLTYBlnvWjsf5fIo8ZzKmxQVk/pyv1r00mVgyFvUvPXcqKZb2eGBCDuLNs75O99qDqzvgRU/D/y
 KbItTg5aJv01kMnSbIjNQAtEhwUcI0Z8vopRCexv8bIruUZuWhbsDp2WMHCDC5QHeH7Ey1EbHbA
 OrtuZFwvIDJVeLxw5q7iWkAZws1keT3F8oL30LUh93x1MqVj2xAUkn598LeUHaTIDi9zPebY810
 BTwoQMYXWtJzVhRsHerEDVV8F21mTu/bkPd4Rt3XLbiWnEK6dWmiIA1xTYUNVBvcEUCoXfp1I9F
 PpL6K0mqox4WzCHd55MfQ6ObQwklylYxnXVUhE4lZhPe7vF6C
X-Received: by 2002:a05:600c:4e8b:b0:46f:b32e:5094 with SMTP id
 5b1f17b1804b1-47939e3e25cmr72286605e9.32.1765188496929; 
 Mon, 08 Dec 2025 02:08:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFcOG77t0ywjcYahfCZsJZP9srk4+uCSNwgNzvhxfaKFGhUsKYpRPAm1NnICbak2iGzLQvJgg==
X-Received: by 2002:a05:600c:4e8b:b0:46f:b32e:5094 with SMTP id
 5b1f17b1804b1-47939e3e25cmr72286295e9.32.1765188496479; 
 Mon, 08 Dec 2025 02:08:16 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47a2e8fc146sm51038505e9.19.2025.12.08.02.08.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Dec 2025 02:08:16 -0800 (PST)
Message-ID: <1728acb2-e098-490d-b37d-7455679ee3ba@redhat.com>
Date: Mon, 8 Dec 2025 11:08:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/8] Live update: tap and vhost
To: Ben Chaney <bchaney@akamai.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Alex Williamson <alex@shazbot.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Hamza Khan <hamza.khan@nutanix.com>,
 Mark Kanda <mark.kanda@oracle.com>, Joshua Hunt <johunt@akamai.com>,
 Max Tottenham <mtottenh@akamai.com>,
 Steve Sistare <steven.sistare@oracle.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
References: <20251203-cpr-tap-v3-0-3c12e0a61f8e@akamai.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20251203-cpr-tap-v3-0-3c12e0a61f8e@akamai.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hello,

Ben, Mark,

Since Steve retired, we have generic names under the "CheckPoint and
Restart (CPR)" entry in MAINTAINERS. Would you be willing to step forward
as Reviewers/Maintainers ?

Also, do you have a gitlab account so we can copy you on any reported
issues [1] ?

Thanks,

C.

[1] https://gitlab.com/qemu-project/qemu/-/issues/3235



On 12/3/25 19:51, Ben Chaney wrote:
> Changes since v2
> - I have taken over this patch set since Steve retired
> - Added comments to explain the order of events
> - Remove redundant reversion to cleanup git history
> - Inclusion of virtio and stub fixes
> 
> Tap and vhost devices can be preserved during cpr-transfer using
> traditional live migration methods, wherein the management layer
> creates new interfaces for the target and fiddles with 'ip link'
> to deactivate the old interface and activate the new.
> 
> However, CPR can simply send the file descriptors to new QEMU,
> with no special management actions required.  The user enables
> this behavior by specifing '-netdev tap,cpr=on'.  The default
> is cpr=off.
> 
> Signed-off-by: Ben Chaney <bchaney@akamai.com>
> ---
> Steve Sistare (8):
>        migration: stop vm earlier for cpr
>        migration: cpr setup notifier
>        vhost: reset vhost devices for cpr
>        cpr: delete all fds
>        tap: common return label
>        tap: cpr support
>        tap: postload fix for cpr
>        tap: cpr fixes
> 
>   hw/net/virtio-net.c               |  26 +++++++
>   hw/vfio/device.c                  |   2 +-
>   hw/virtio/vhost-backend.c         |   6 ++
>   hw/virtio/vhost.c                 |  32 +++++++++
>   include/hw/virtio/vhost-backend.h |   1 +
>   include/hw/virtio/vhost.h         |   1 +
>   include/migration/cpr.h           |   3 +-
>   include/net/tap.h                 |   1 +
>   io/channel-socket.c               |   4 +-
>   migration/cpr.c                   |  24 +++++--
>   migration/migration.c             |  69 ++++++++++++++----
>   net/tap-win32.c                   |   5 ++
>   net/tap.c                         | 147 +++++++++++++++++++++++++++++---------
>   qapi/net.json                     |   5 +-
>   stubs/cpr.c                       |   8 +++
>   stubs/meson.build                 |   1 +
>   16 files changed, 279 insertions(+), 56 deletions(-)
> ---
> base-commit: 9febfa94b69b7146582c48a868bd2330ac45037f
> change-id: 20251203-cpr-tap-04fd811ace03
> 
> Best regards,




