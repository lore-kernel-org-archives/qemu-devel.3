Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C48CDC54E67
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 10:20:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpmr6-0000Id-CX; Thu, 28 Mar 2024 06:19:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rpmr3-0000HE-50; Thu, 28 Mar 2024 06:19:30 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rpmr0-0006vK-1W; Thu, 28 Mar 2024 06:19:28 -0400
Received: from mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net
 [IPv6:2a02:6b8:c12:5428:0:640:7351:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id BA75A60B16;
 Thu, 28 Mar 2024 13:19:18 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:6509::1:4] (unknown
 [2a02:6b8:b081:6509::1:4])
 by mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id cIKfNf3Ic8c0-uyvSZ3Oh; Thu, 28 Mar 2024 13:19:18 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1711621158;
 bh=yXdj5P+80E1xkt8VddGKTfkZ3KPWox4HWuhXTya5VXw=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=1TzSWQIn4gqW8rB0LDcSD6hnRop6lLlKAYhIeTAQd1MMGf4dLc8HrNMbanv/J5pOj
 cNOtrG0ElNgzO7MzskkQg2QoP5Pa1B47iuzJ8sh4NCyR0eSbGbZm69TNhy6lVOulT+
 2rFaWkSmDcdlIUytHDBPaMCA4dzfZtyxxG9avXK0=
Authentication-Results: mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <8213f8ef-9b66-4d8c-afde-994aa177b835@yandex-team.ru>
Date: Thu, 28 Mar 2024 13:18:38 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 01/15] scripts/qapi: support type-based unions
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, jsnow@redhat.com,
 kwolf@redhat.com, hreitz@redhat.com, devel@lists.libvirt.org,
 eblake@redhat.com, michael.roth@amd.com, pbonzini@redhat.com,
 pkrempa@redhat.com, f.ebner@proxmox.com
References: <20240313150907.623462-1-vsementsov@yandex-team.ru>
 <20240313150907.623462-2-vsementsov@yandex-team.ru>
 <87le62d78u.fsf@pond.sub.org>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <87le62d78u.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
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

On 28.03.24 12:40, Markus Armbruster wrote:
> Subject: all unions are type-based.  Perhaps "support implicit union
> tags on the wire"?

Yes, sounds good.

> 
> Do you need this schema language feature for folding block jobs into the
> jobs abstraction, or is it just for making the wire protocol nicer in
> places?
> 

It's not necessary, we can proceed with job-* API, specifying both type and id.

But I think, as we are not in a hurry, better to make new job-* API more effective from the beginning.

-- 
Best regards,
Vladimir


