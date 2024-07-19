Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4643C3DA5D
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2024 08:34:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUj3x-0003NL-8i; Fri, 19 Jul 2024 04:34:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sUj3w-0003MT-7T; Fri, 19 Jul 2024 04:34:00 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sUj3u-0005GH-F4; Fri, 19 Jul 2024 04:33:59 -0400
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:3129:0:640:91b0:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id CE7BE6247F;
 Fri, 19 Jul 2024 11:33:54 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b721::1:1f] (unknown
 [2a02:6b8:b081:b721::1:1f])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id rXFH7B0GaOs0-GInN3THf; Fri, 19 Jul 2024 11:33:54 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1721378034;
 bh=ZdlMM2yUP/aHEELBhBWd1m+fTroJcY4ZsJagTXyjPgI=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=1Hf5Upl5Ao/YHahCH2C/Hy+jM0BoZE056zlVmN0IODBDNZWyS7NYYaVeNUX/nF0DI
 DKwX12F9WutMMcab8ihRTRn92t03AIzFuQto6FI1ZUTexi5j7PVYN52JfkV+l/dV1y
 RExu47ZHPn/WGZlkvcYk2G06N048tZE7lIbWeefI=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <ce4cfa2e-7f11-456b-8680-05d5e5f49dee@yandex-team.ru>
Date: Fri, 19 Jul 2024 11:33:53 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/3] vhost-user-blk: live resize additional APIs
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-block@nongnu.org, raphael@enfabrica.net, mst@redhat.com,
 Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, eduardo@habkost.net,
 berrange@redhat.com, pbonzini@redhat.com, hreitz@redhat.com,
 kwolf@redhat.com, yc-core@yandex-team.ru
References: <20240625121843.120035-1-vsementsov@yandex-team.ru>
 <0e199197-9bad-40ef-9081-eca74ca39f69@yandex-team.ru>
 <874j8nm793.fsf@pond.sub.org>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <874j8nm793.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 18.07.24 11:31, Markus Armbruster wrote:
> Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:
> 
>> ping. Markus, Eric, could someone give an ACC for QAPI part?
> 
> I apologize for the delay.  It was pretty bad.
> 

No problem, I myself make worse delays now when busy with other work, thanks for reviewing!

-- 
Best regards,
Vladimir


