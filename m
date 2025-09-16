Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1999CCAC599
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 13:19:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyVX6-0006RW-2K; Tue, 16 Sep 2025 09:15:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uyVWx-0006FW-4g; Tue, 16 Sep 2025 09:15:35 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uyVWm-0006qx-4y; Tue, 16 Sep 2025 09:15:34 -0400
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:cf2d:0:640:140f:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 8540180760;
 Tue, 16 Sep 2025 16:15:20 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:16c::1:b] (unknown [2a02:6bf:8080:16c::1:b])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id KFQAoC2FvW20-7IF6E5fa; Tue, 16 Sep 2025 16:15:20 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1758028520;
 bh=S13TtJgrkLlc9vzwSjnIv9TKHYFeqQxl+ix8t91PgaI=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=NFY/VKLZ2WvueQVVZz/VP/3Ihd9BztiX3FtZ5XBexS4OLFOl+aYC+knFJNFxstDAo
 +kOU++vv+t9lx+/lCpdwuAmHAb83yF5c4IfWZWkcVG9Ql/qsZu27VzjtQltrFcQolg
 6tFyV4Q9l2PqZnskGQmNidkeJUXN+27YNH6rFtu4=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <696afc64-127c-4e33-b52f-4caf08d7186f@yandex-team.ru>
Date: Tue, 16 Sep 2025 16:15:20 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/13] io: deal with blocking/non-blocking fds
To: berrange@redhat.com
Cc: qemu-devel@nongnu.org, peterx@redhat.com, qemu-block@nongnu.org,
 leiyang@redhat.com, marcandre.lureau@redhat.com
References: <20250916131403.368343-1-vsementsov@yandex-team.ru>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20250916131403.368343-1-vsementsov@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 16.09.25 16:13, Vladimir Sementsov-Ogievskiy wrote:
> Hi all!
> 
> The series aims to unify code which sets fds blocking/non-blocking
> through the whole source.
> 
> v5:
> 04: add r-b by Daniel
> 06: add TODOs in vhost-user-server.c
> 13: new optional patch, to solve one of new TODOs

Series based on
"[PATCH v4 0/2] save qemu-file incoming non-blocking fds"
Based-on: <20250910193112.1220763-1-vsementsov@yandex-team.ru>

-- 
Best regards,
Vladimir

