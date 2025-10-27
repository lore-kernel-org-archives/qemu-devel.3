Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC1DBCCF9E5
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 20:35:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDTuX-0007j3-TV; Mon, 27 Oct 2025 16:33:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vDTuV-0007iR-TR
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 16:33:47 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vDTuG-0006yp-Sl
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 16:33:47 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c21:2d8b:0:640:7d49:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 809C58078B;
 Mon, 27 Oct 2025 23:33:23 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:c5c::1:11] (unknown
 [2a02:6bf:8080:c5c::1:11])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id MXjur12InCg0-g6kXOtEU; Mon, 27 Oct 2025 23:33:23 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1761597203;
 bh=yazqflWueQ9JxQQaz3yqBx2oOCmHFbihpVIqYUBDJOk=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=gjQ/G/8vsYgwKiQu3tKyfkBIeNNU9Xp7/pDhp5OLEv+M04SguE3fS5/760gSSSdBF
 IkIFb/6x8yuTT7nWNSnUTtp63ayOdLb3n2CfPilwAXWozFtNDlm9am7kB+hNX4xPWF
 sp8SN0xU/vtKiE0dNyNLozVKSuQCGt7nsL+WiRhQ=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <2699d795-25b0-41ce-b884-ce1a357a1417@yandex-team.ru>
Date: Mon, 27 Oct 2025 23:33:22 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] migration: vmsd errp handlers: return bool
To: armenon@redhat.com
Cc: Markus Armbruster <armbru@redhat.com>, peterx@redhat.com,
 stefanb@linux.vnet.ibm.com, farosas@suse.de, qemu-devel@nongnu.org,
 berrange@redhat.com
References: <20251025202649.1122420-1-vsementsov@yandex-team.ru>
 <20251025202649.1122420-5-vsementsov@yandex-team.ru>
 <87o6psocib.fsf@pond.sub.org>
 <9f5ba3d7-3103-4d2a-b50f-f8883a18c812@yandex-team.ru>
 <aP-eHzbAtvNp3N3d@armenon-kvm.bengluru.csb>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <aP-eHzbAtvNp3N3d@armenon-kvm.bengluru.csb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 27.10.25 19:30, Arun Menon wrote:
> We wanted the new errp variants to be structurally as close to the old
> ones as possible so that we can perform a bulk change later.

Still, could you clarify, are you plan to do this bulk change? Or it was
a theoretical possibility?

-- 
Best regards,
Vladimir

