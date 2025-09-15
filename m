Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3B48CAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 19:37:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyEwW-0002Kn-IF; Mon, 15 Sep 2025 15:32:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uyEwQ-0002Gc-Ul; Mon, 15 Sep 2025 15:32:50 -0400
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uyEwB-00021l-Io; Mon, 15 Sep 2025 15:32:45 -0400
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:cf2d:0:640:140f:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 4BBD7807C8;
 Mon, 15 Sep 2025 22:32:26 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:184::1:6] (unknown [2a02:6bf:8080:184::1:6])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id PWV2vt1FiW20-nLoG66DA; Mon, 15 Sep 2025 22:32:25 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1757964745;
 bh=gj8cORPbQlvh8ZP0z6p0gaj6QmuNXIr8s9Tj7DG4bvs=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=0DqG6u/DY7YjBkfaR/i5oEHxHHHp0vUxzCeLAmIYiKuP+YFKIrZMq7co0YjNUfhGl
 2vaCtkpVStI6RWgFPDtXE11AxT9A7o+eaM8Nl4sJOTyY6VqWKPefbzNHy/Mh273BdT
 Z15PmND1eUFMk7cFAhDGtN5+kBf9OQfsmzUBP/Ww=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <f9bafce1-6e03-476a-a4a6-3e2d7105841c@yandex-team.ru>
Date: Mon, 15 Sep 2025 22:32:25 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/12] io: deal with blocking/non-blocking fds
To: berrange@redhat.com
Cc: qemu-devel@nongnu.org, peterx@redhat.com, qemu-block@nongnu.org,
 leiyang@redhat.com, marcandre.lureau@redhat.com
References: <20250915193105.230085-1-vsementsov@yandex-team.ru>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20250915193105.230085-1-vsementsov@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c41:1300:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 15.09.25 22:30, Vladimir Sementsov-Ogievskiy wrote:
> Hi all!
> 
> The series aims to unify code which sets fds blocking/non-blocking
> through the whole source.
> 
> v4:
> Drop patch about error_reporter, and use local_err
> instead
> 
> 04: - use local_err instead of dropped error_reporter
>      - change error handling in tcp_chr_sync_read
>      - fix change in nbd_co_do_establish_connection
>      - drop r-b because of changes
> 05-06:
>      - use local_err instead of dropped error_reporter
> 08: add r-b by Daniel
> 10: - use local_err, drop r-b
> 11-12: add r-b by Daniel

Of-course, series still based on
"[PATCH v4 0/2] save qemu-file incoming non-blocking fds"
Based-on: <20250910193112.1220763-1-vsementsov@yandex-team.ru>

-- 
Best regards,
Vladimir

