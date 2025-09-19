Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E239CAC59A
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 17:20:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzemI-0006v5-Jc; Fri, 19 Sep 2025 13:20:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uzemD-0006u4-UP
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 13:20:06 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uzem6-0002sU-B5
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 13:20:05 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c21:2d8b:0:640:7d49:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id D715C808B0;
 Fri, 19 Sep 2025 20:19:49 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:a72::1:38] (unknown
 [2a02:6bf:8080:a72::1:38])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id mJXuMo1Go0U0-dHIKkVo2; Fri, 19 Sep 2025 20:19:49 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1758302389;
 bh=ohJX4gc7fdEgkPSDaa/W6VJpMFVKGVO/KQOfJRKVdl8=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=p1GgEfYVvKh9/9zZjsKoBrjGFv8mSJ0SHL02HzwcuAtsT7r9aetS5RlimeefXTIfa
 syQ0ou74mmlz602PdNbaGvjRM1CPiZOL9NEMB20+QB3hjrJ2Ra2k3AxfoIzR/9UlsL
 GLL7+qg3Xu4tjl2xX1jani5V/gUFJK+dYDt0DfBo=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <416c94d3-7f63-4d8c-8fbb-1d94d39c0913@yandex-team.ru>
Date: Fri, 19 Sep 2025 20:19:48 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 15/19] net/tap: postpone tap setup to pre-incoming
To: mst@redhat.com
Cc: qemu-devel@nongnu.org, philmd@linaro.org, thuth@redhat.com,
 eblake@redhat.com, michael.roth@amd.com, armbru@redhat.com, farosas@suse.de,
 peterx@redhat.com, berrange@redhat.com, jasowang@redhat.com,
 steven.sistare@oracle.com, leiyang@redhat.com, davydov-max@yandex-team.ru,
 yc-core@yandex-team.ru
References: <20250919095545.1912042-1-vsementsov@yandex-team.ru>
 <20250919095545.1912042-16-vsementsov@yandex-team.ru>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20250919095545.1912042-16-vsementsov@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

On 19.09.25 12:55, Vladimir Sementsov-Ogievskiy wrote:
> As described in previous commit, to support fds-passing TAP migration,
> we need to postpone the decision to open the device or to wait for
> incoming fds up to pre-incoming point (when we actually can decide).
> 
> This commit only postpones TAP-open case of initialization.
> We don't try to postpone the all cases of initialization, as it will
> require a lot more work of refactoring the code.
> 
> So we postpone only the simple case, for which we are going to support
> fd-incoming migration:
> 
> 1. No fds / fd parameters: obviously, if user give fd/fds the should
> be used, no incoming fds migration is possible.
> 
> 2. No helper: just for simplicity. It probably possible to allow it
> (and just ignore in case of fds-incoming migration), to allow user
> use same cmdline on target QEMU.. But that questionable, and
> postponable.
> 
> 3. No sciprt/downscript. It's not simple to support downscript:
> we should pass the responsiblity to call it on target QEMU with
> migration.. And back to source QEMU on migration failure. It
> feasible, but may be implemented later on demand.
> 
> 3. Concrete ifname and vnet_hdr: to not try to share them between
> queues, when we only can setup queues as separate entities.
> Supporting undecided ifname will require to create some extra
> netdev state, connecting all the taps, to be able to iterate through
> them.
> 
> No part of incoming-fds migration is here, we only prepare the code
> for future implementation of it.
> 
> Are net-drivers prepared to postponed initialization of NICs?
> For future feature of fds-passing migration, we are mainly interested
> in virtio-net. So, let's prepare virtio-net to work with postponed
> initialization of TAP (two places about early set/get features) and
> for other drivers let's simply finalize initialization on setting
> netdev property. Support for other drivers may be added later if
> needed.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy<vsementsov@yandex-team.ru>


gitlab CI helps: "undefined reference to `tap_wait_incoming'" in win64 system build, will fix.

-- 
Best regards,
Vladimir

