Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2A93CC6B39
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 08:37:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHGxs-0000b8-OT; Thu, 15 Oct 2026 04:37:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1xHGxe-0000Gb-9h; Thu, 15 Oct 2026 04:37:16 -0400
Received: from forwardcorp2d.mail.yandex.net ([178.154.239.207])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1xHGxY-0008LQ-Ht; Thu, 15 Oct 2026 04:37:12 -0400
Received: from mail-nwsmtp-smtp-corp-main-66.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:bc9b:0:640:efdc:0])
 by forwardcorp2d.mail.yandex.net (postfix) with ESMTPS id 7376D80242;
 Thu, 15 Oct 2026 11:37:05 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:d5a::1:34] (unknown
 [2a02:6bf:8080:d5a::1:34])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id 4bQdSC1kmqM0-PWG9Vf18; Thu, 15 Oct 2026 11:37:04 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1792053424;
 bh=Nb5nss3c6iTfUK9OpOQTmK8gMJ6aCGFPECD5dGkuoj4=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=o5BJ6VLm1J1MnRiSYC+P2clvYZwyN0qouseh59zlUNSs//r6vqNp1LrA567CMzytW
 Zn2B2gHSc0v9J7z0eW86MHns/RUw8zcVjeXvSvJCWcKS4mFIhxvP+0jV612akG0xmA
 CycPd7/mHmiNk5sZ6F+a5SUM5P4q0/xzy2LCw7Ag=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <386b373f-8f25-4b33-bc6f-da575662edf5@yandex-team.ru>
Date: Thu, 15 Oct 2026 11:37:04 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/9] iotests/124: cover backup of zero clusters and
 holes
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, 
 John Snow <jsnow@redhat.com>
References: <20260929155125.3151111-1-den@openvz.org>
 <20260929155125.3151111-5-den@openvz.org>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20260929155125.3151111-5-den@openvz.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.207;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp2d.mail.yandex.net
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

On 29.09.26 18:51, Denis V. Lunev wrote:
> From: Denis V. Lunev<den@openvz.org>
> 
> The backup tests compare content only, and their sources hold data
> alone, so nothing pins how backup treats zero clusters and holes. Back
> up a source mixing data, write-zero and holes with sync=full, sync=top
> and sync=bitmap, and check the target with qemu-img map, which tells a
> copied cluster apart from a write-zero and from an untouched one.
> 
> Reviewed-by: Andrey Drobyshev<andrey.drobyshev@virtuozzo.com>
> Signed-off-by: Denis V. Lunev<den@openvz.org>
> CC: Vladimir Sementsov-Ogievskiy<vsementsov@yandex-team.ru>
> CC: John Snow<jsnow@redhat.com>
> CC: Andrey Drobyshev<andrey.drobyshev@virtuozzo.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

-- 
Best regards,
Vladimir

