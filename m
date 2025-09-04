Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29B78CA1015
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Sep 2025 14:44:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uuBBB-0000jg-Ho; Thu, 04 Sep 2025 10:43:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1uuBB8-0000jM-8i
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 10:43:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1uuBAz-0001yc-3w
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 10:43:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756996974;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Df2p+y2ylOBZQLnTrhj4EoBzwdxVWp0YkD/h9ctYVMs=;
 b=VQMZwOFEgzRDwTqhIHxin0R3r6ut8pmq0rXuy7jksjDOccbrjAw9ZMyrOWT1JVDIFbZ5Hv
 51fJnn3Gtq2Bka5X2lhkNcQvSFURQHJA1vWxju2kqQTZhK7gkGOlPRIq5VtHVc3N1d97G1
 XOvAHmvdl3oJ1mSKwDd9t39Q1i5+vtQ=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-219-UWAA-kyYPmG4vWk0N7otVw-1; Thu, 04 Sep 2025 10:42:53 -0400
X-MC-Unique: UWAA-kyYPmG4vWk0N7otVw-1
X-Mimecast-MFC-AGG-ID: UWAA-kyYPmG4vWk0N7otVw_1756996972
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-61ed103a202so2256354a12.1
 for <qemu-devel@nongnu.org>; Thu, 04 Sep 2025 07:42:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756996971; x=1757601771;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Df2p+y2ylOBZQLnTrhj4EoBzwdxVWp0YkD/h9ctYVMs=;
 b=DDBjBni/zuKe3OsRmJF4lGyv/XQOMXweuIN7PWf6bg8cb2i59RuZkpSGzeBkBDj8+1
 sN/V0RNNlzx1nXH43+4G21NW4lMDyJpaVFW9ehInCJnL5C2nxJ3lknlFUZoZFq/z9FEw
 M3GSKOHKeXUTg+C3Jo5CA5xWoZdfqf5OH7PrEh/6I0b6e0MiHOK0tqV10flS93D1uDMM
 USDUfhmGgASxjoI0jzxVwivUs+fh7sMkaFceXdpN1J+CLN/BNdOUlOwGTaSJVvuiGSd6
 GivC1VrqQC9ziU8Diw8WE3uZVmkYQuZtrkLu1POzpd7OG3jdQ4XSxut8Sug3/ukGRife
 3sBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWImUbKQqfX5IFnYsb0dxBJ3Z9CndL5lKWDeKg/7VBGz2pZ12CDDGqTbSbkwhVo6oPb//fS0tL+Vnon@nongnu.org
X-Gm-Message-State: AOJu0Ywr97WhXx8+KXCjbDVbKzENOReHnRu4DStGm7RAvZMkqenhu25p
 Nj+b+PlNLY1sFwH4Wu0N6KBRX5ULjs+C8oSaLGQrrak7H/ya9RMT/8OBW2tm1c8zSZztixp81H8
 DQSUm5FZIRQ+jFKBh448ZTybUOf4i8VcdSwN2JFGtTD4Ta8Nqz7frbsVEzi2Y9LjDsCQcBl8+tH
 UYoTfJXPU1SxZq8saO7e0Vmax83iP25eDtMDq4OZ9B73kizWQ=
X-Gm-Gg: ASbGncsjVD2y8o+ZcfiFlhoFiRJmosOkFrMY2V4Di/WOHTZdHPzIuxaIMqQdIPikbK/
 bFOcELN2de6OoPyY1UMLkM+0LGCnrJHEwn86Ex4g7gizruBm6c2VgoCh6IBOFG/46fF/2XDOnKK
 ZYzVAMqr/Rd7a2Xj0qqmdXUA==
X-Received: by 2002:a05:6402:5243:b0:61c:6386:5398 with SMTP id
 4fb4d7f45d1cf-61d269974f5mr17716634a12.5.1756996971357; 
 Thu, 04 Sep 2025 07:42:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF4W4qWOhijMAv3Gc6dPzVDfPwUwER/1HtqRlSzcFVMlEw7ysfALEEt/HCKxdqBEMpqKBkeZ3rZjZqksI9YA64=
X-Received: by 2002:a05:6402:5243:b0:61c:6386:5398 with SMTP id
 4fb4d7f45d1cf-61d269974f5mr17716610a12.5.1756996970935; Thu, 04 Sep 2025
 07:42:50 -0700 (PDT)
MIME-Version: 1.0
References: <20250903133706.1177633-1-vsementsov@yandex-team.ru>
In-Reply-To: <20250903133706.1177633-1-vsementsov@yandex-team.ru>
From: Lei Yang <leiyang@redhat.com>
Date: Thu, 4 Sep 2025 22:42:14 +0800
X-Gm-Features: Ac12FXzjqvKY_-pbQWv5eFftHnZuX22X3qhasWMMn4iE1_unMi9fIyHi9ZMC_3g
Message-ID: <CAPpAL=x6FW_5b1mkCjt6j-4BBOaG=Ps5iAPVf+jZnnY8r_uTNQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] virtio-net: live-TAP local migration
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: jasowang@redhat.com, qemu-devel@nongnu.org, steven.sistare@oracle.com, 
 yc-core@yandex-team.ru, peterx@redhat.com, mst@redhat.com, farosas@suse.de, 
 eblake@redhat.com, armbru@redhat.com, thuth@redhat.com, philmd@linaro.org, 
 berrange@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=leiyang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

Tested the current series of patches, mixed with patches from series
[1] and [2], and the virtio-net regression tests passed. I also tested
local VM migration under multiple NIC queues enabled and disabled, it
also passed.

[1] https://patchwork.ozlabs.org/project/qemu-devel/cover/20250903094411.10=
29449-1-vsementsov@yandex-team.ru/
[2] https://patchwork.ozlabs.org/project/qemu-devel/cover/20250903124934.11=
69899-1-vsementsov@yandex-team.ru/

Tested-by: Lei Yang <leiyang@redhat.com>

On Wed, Sep 3, 2025 at 9:37=E2=80=AFPM Vladimir Sementsov-Ogievskiy
<vsementsov@yandex-team.ru> wrote:
>
> Hi all!
>
> Here is a  new migration capability "local-tap", which
> allows local migration of TAP device, including its properties
> and open fds.
>
> With this new option, management software doesn't need to
> initialize new TAP and do a switch to it. Nothing should be
> done around virtio-net in local migration: it just migrates
> and continues to use same TAP device. So we avoid extra logic
> in management software, extra allocations in kenel (for new TAP),
> and corresponding extra delay in migration downtime.
>
> Note that patch 07 is reused from
> [PATCH 00/33] vhost-user-blk: live-backend local migration
> to not create extra dependency on a big series.
>
> Based on [PATCH v3 00/19] TAP initialization refactoring, or in other
> words:
> Based-on: <20250903124934.1169899-1-vsementsov@yandex-team.ru>
>
> Vladimir Sementsov-Ogievskiy (8):
>   net/tap: add some trace points
>   net/tap: keep exit notifier only when downscript set
>   net/tap: refactor net_tap_setup_vhost()
>   qapi: add interface for local TAP migration
>   net/tap: implement interfaces for local migration
>   virtio-net: support local tap migration
>   test/functional: exec_command_and_wait_for_pattern: add vm arg
>   tests/functional: add test_x86_64_tap_fd_migration
>
>  hw/net/virtio-net.c                           | 100 ++++-
>  include/hw/virtio/virtio-net.h                |   2 +
>  include/net/tap.h                             |   4 +
>  migration/options.c                           |   7 +
>  migration/options.h                           |   1 +
>  net/tap.c                                     | 323 ++++++++++++----
>  net/trace-events                              |   7 +
>  qapi/migration.json                           |   9 +-
>  qapi/net.json                                 |  12 +-
>  tests/functional/qemu_test/cmd.py             |   7 +-
>  .../test_x86_64_tap_fd_migration.py           | 347 ++++++++++++++++++
>  11 files changed, 734 insertions(+), 85 deletions(-)
>  create mode 100644 tests/functional/test_x86_64_tap_fd_migration.py
>
> --
> 2.48.1
>


