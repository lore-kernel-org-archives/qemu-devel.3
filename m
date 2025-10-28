Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BD80CCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 17:13:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDnFr-00023Z-EI; Tue, 28 Oct 2025 13:13:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vDnFk-00020x-Rv
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 13:13:01 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vDnFc-00012U-HL
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 13:12:57 -0400
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:3a87:0:640:845c:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 58C9EC017D;
 Tue, 28 Oct 2025 20:12:46 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:582::1:19] (unknown
 [2a02:6bf:8080:582::1:19])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id jChSGa1LpGk0-Qq66rqio; Tue, 28 Oct 2025 20:12:45 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1761671565;
 bh=q358qZ9y++91aGv6ZwjwQYkh6xbp4HpdGPBzZb6p2Dk=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=RH/CrMiKZ+/F/dUYTRsamA8Gmmy/3htoyjK2F50bWGgI0zmRpJPXLyLxKKXzHyxHQ
 +wTCD+j6m5zZzsq6Cz6b1lF+ECbWfIQ3E+Ke3ycGuHcNwflxzOx6xvd33uudMk77Lw
 ZK5wP+QB6zAKoHvZOhR0DjKARpRv5z06Q8GqALa4=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <9bafb5eb-9808-428c-804d-b7122c9f598e@yandex-team.ru>
Date: Tue, 28 Oct 2025 20:12:45 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/2] migration: vmsd errp handlers: return bool
To: peterx@redhat.com
Cc: stefanb@linux.vnet.ibm.com, farosas@suse.de, qemu-devel@nongnu.org,
 armbru@redhat.com, berrange@redhat.com, armenon@redhat.com
References: <20251028130738.29037-1-vsementsov@yandex-team.ru>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20251028130738.29037-1-vsementsov@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
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

On 28.10.25 16:07, Vladimir Sementsov-Ogievskiy wrote:
> Hi.
> 
> Finally, I understood, that there is no real benefit in converting
> these new APIs to bool, as it will break plans of converting all
> other handlers to new API.
> 
> So, only unrelated fixes are kept in the series, maintainers may
> pick them in separate if convenient.
> 
> v4:
> 01: add r-b by Stefan
> 02: rework to better patch (and fix one more similar issue)

After analysis by Peter ( https://lore.kernel.org/qemu-devel/aQDdRn8t0B8oE3gf@x1.local/ ), I've added 03 and 04 back.

Unfortunately I missed that I should use --no-thread together with --in-reply-to.. That's why 04 is reply to 03.

> 
> Vladimir Sementsov-Ogievskiy (2):
>    migration: vmstate_save_state_v(): fix error path
>    tmp_emulator: improve and fix use of errp
> 
>   backends/tpm/tpm_emulator.c | 63 +++++++++++++++++++++++--------------
>   migration/vmstate.c         |  1 +
>   2 files changed, 40 insertions(+), 24 deletions(-)
> 


-- 
Best regards,
Vladimir

