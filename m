Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BD16D33A04
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 16:48:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgQWQ-00076a-9C; Thu, 15 Jan 2026 11:48:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vgQV1-0005u8-9a
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 11:47:11 -0500
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vgQUy-0002kW-Tv
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 11:47:07 -0500
Received: from mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:94a9:0:640:a3fa:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id BC444807A6;
 Thu, 15 Jan 2026 19:46:58 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:b8d::1:8] (unknown [2a02:6bf:8080:b8d::1:8])
 by mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id vkY4360AmOs0-DjPNeCok; Thu, 15 Jan 2026 19:46:58 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1768495618;
 bh=4/3jsc6bzLa+NFGX6JYGXavvC/UlVpeHARlm6pifyH0=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=EWWneAl2N/RR2rcu0oB3pWI5dd/SMBJeevec0SfgerH7cYj9EMkuYesuOzI7DKtqN
 FY27LdHVCK0KUqq4ko1Sa1R7KnnynYy56qRkkB62syiMlEocl8wz13QYS53WJtSg6p
 FSnZHUaO3JTiuwaM9/zUcDYnLm1QTl1aK8thdC9A=
Authentication-Results: mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <d95df5d1-2837-42cb-9654-b5fa60f8e1d0@yandex-team.ru>
Date: Thu, 15 Jan 2026 19:46:57 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 0/7] net/tap: simple refactoring
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, leiyang@redhat.com, davydov-max@yandex-team.ru,
 yc-core@yandex-team.ru
References: <20251030164023.710048-1-vsementsov@yandex-team.ru>
 <a8dcf37b-f7c1-486b-bc7d-5877c4d9ccfe@yandex-team.ru>
 <CACGkMEtUn8aLApCu5RCF2tpNgMskOYycp4jjrNCvgNe3aWuTLA@mail.gmail.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <CACGkMEtUn8aLApCu5RCF2tpNgMskOYycp4jjrNCvgNe3aWuTLA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c41:1300:1:45:d181:df01;
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 05.12.25 09:19, Jason Wang wrote:
> On Fri, Dec 5, 2025 at 4:05 AM Vladimir Sementsov-Ogievskiy
> <vsementsov@yandex-team.ru> wrote:
>>
>> ping
>>
>> (now as 11.0 material)
>>
> 
> I've queued this.
> 
> Thanks
> 

Hi! Gently remind. Aren't these patches forgotten?

-- 
Best regards,
Vladimir

