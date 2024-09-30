Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B139FCE8343
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 13:57:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svGu4-0007nQ-Cb; Mon, 30 Sep 2024 09:57:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1svGu1-0007d2-IR; Mon, 30 Sep 2024 09:57:29 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1svGtz-0004o2-Pc; Mon, 30 Sep 2024 09:57:29 -0400
Received: from mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:3f48:0:640:7695:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id E8076609F2;
 Mon, 30 Sep 2024 16:57:24 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b737::1:2c] (unknown
 [2a02:6b8:b081:b737::1:2c])
 by mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id OvZdsB13QmI0-FIylab04; Mon, 30 Sep 2024 16:57:24 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1727704644;
 bh=EqBDfkLJQOLZf0v8eckXz6N6FTIkBnB5xbM6Hp4zj2o=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=sEGs+TbvtaM0oqkt1vQwNgu2ghTos4QnAnI0z1MzYH17mkpq+6Ma3ZYJFJ6tCAIDr
 H4xpJ8dk11iJAeZtYTioQta2YfzZiT71KNSm7NZwzKwWaMog7O7SAvYrTU9SYZurwR
 tyRdOk/WjfPqkwJrILabNlNdDybZiF3Y4ezMOApw=
Authentication-Results: mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <04af4c2b-54f9-4a47-a0aa-1ebf399c79a8@yandex-team.ru>
Date: Mon, 30 Sep 2024 16:57:24 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] block: move commit_run loop to separate function
To: Vincent Vanlaer <libvirt-e6954efa@volkihar.be>, qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>
References: <20240901142405.3183874-1-libvirt-e6954efa@volkihar.be>
 <20240901142405.3183874-3-libvirt-e6954efa@volkihar.be>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20240901142405.3183874-3-libvirt-e6954efa@volkihar.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Yandex-Filter: 1
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 01.09.24 17:24, Vincent Vanlaer wrote:
> +static int commit_iteration(CommitBlockJob *s, int64_t offset, int64_t *n, void *buf) {

Hmm over-80 line. Didn't you forget run ./checkpatch.pl ?

-- 
Best regards,
Vladimir


