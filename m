Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 543C5D116F5
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Nov 2025 10:24:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOvdh-0001Gr-UD; Fri, 28 Nov 2025 05:23:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vOvdd-0001GQ-Hb
 for qemu-devel@nongnu.org; Fri, 28 Nov 2025 05:23:41 -0500
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vOvda-0005v0-KE
 for qemu-devel@nongnu.org; Fri, 28 Nov 2025 05:23:41 -0500
Received: from mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:94a9:0:640:a3fa:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 4DDBB813A3;
 Fri, 28 Nov 2025 13:23:34 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:894::1:13] (unknown
 [2a02:6bf:8080:894::1:13])
 by mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id XNcf9Z0F0mI0-IrZKt8Lj; Fri, 28 Nov 2025 13:23:33 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1764325413;
 bh=RAJc4wDoHxh/r0ylpXCr+4t7lwjgeuK7waJ9gLy6Zzw=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=p9F5NgASYxsKvR+auH1QjFVHOLZSvHPoHBA5KleIGhexvb3II+QsjjvLfEVRgLe3X
 4ckzB2eBVM1wfc1mq+AmulvVb6ORzxasJbkDgu9Rfw90TPwN1LsWh4HsJJomSiIRm7
 IwhTWao+Jqs/QdOIS+AM3szNxUCk4K+rDOahMC0I=
Authentication-Results: mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <10ea3eef-a562-4d18-b85a-d9421b855e8d@yandex-team.ru>
Date: Fri, 28 Nov 2025 13:23:33 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-11.0 0/5] some improvements around error reporting
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: dave@treblig.org, armbru@redhat.com, pbonzini@redhat.com,
 marcandre.lureau@redhat.com, qemu-devel@nongnu.org
References: <20251127173352.283731-1-vsementsov@yandex-team.ru>
 <aSi5xrJrlI9W_MJk@redhat.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <aSi5xrJrlI9W_MJk@redhat.com>
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

On 27.11.25 23:51, Daniel P. Berrangé wrote:
> On Thu, Nov 27, 2025 at 08:33:47PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>> Hi all. The main thing I wanted to do is to enable timestamps
>> for errer_report() and friends when QMP monitor is active.
>> Analyzing logs without timestamps is painful.
>>
>> And some enhancements here and there around.
> 
> This is significantly overlapping  with what I've been working on here:
> 
>    https://lists.nongnu.org/archive/html/qemu-devel/2025-09/msg05222.html
> 
> I had to pause that temporarily but intend to post a v5 for 11.0 dev
> cycle
> 

Oh, I am late) Seems all my commits duplicate yours. Except 05)

-- 
Best regards,
Vladimir

