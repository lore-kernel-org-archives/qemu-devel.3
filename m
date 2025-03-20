Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D782C28B30
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 07:52:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvAh2-0004hP-Hw; Thu, 20 Mar 2025 03:51:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1tvAgy-0004gs-Rh
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 03:51:52 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1tvAgv-0002CL-QT
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 03:51:52 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c24:4c7:0:640:d178:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 1F17E60DC0;
 Thu, 20 Mar 2025 10:51:40 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:8106::1:23] (unknown
 [2a02:6b8:b081:8106::1:23])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 5pEix20FbCg0-VFIFAkkp; Thu, 20 Mar 2025 10:51:39 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1742457099;
 bh=AKzaWEJdxnWO6FUam8gH7Qpa/AdaC0UrUSgn4jp2l6A=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=CVUFT6OZtbIvcDzOx4LwHouKMbO8qDr9mqZ711lM/oYslCml2CT01Wm8T+fZCub+L
 D3mKdMoub9//t5/rKKpCoBrFYv2/79+TtB5BHAGpWIyO7VmZ4JpxsQj/Ta75kfnMfe
 wmoQTzeAzHlgsMDoZ7/kYQidxqmbeyzmgCS/FJRk=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <0fd9cd18-afd2-4fbc-9833-91e128f73529@yandex-team.ru>
Date: Thu, 20 Mar 2025 10:51:05 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] util/qemu-sockets: Add support for keep-alive flag
 to passive sockets
To: Juraj Marcin <jmarcin@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20250319163638.456417-1-jmarcin@redhat.com>
 <20250319163638.456417-2-jmarcin@redhat.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20250319163638.456417-2-jmarcin@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 19.03.25 19:36, Juraj Marcin wrote:
> From: Juraj Marcin<jmarcin@redhat.com>
> 
> Commit aec21d3175 (qapi: Add InetSocketAddress member keep-alive)
> introduces the keep-alive flag, which enables the SO_KEEPALIVE socket
> option, but only on client-side sockets. However, this option is also
> useful for server-side sockets, so they can check if a client is still
> reachable or drop the connection otherwise.
> 
> This patch enables the SO_KEEPALIVE socket option on passive server-side
> sockets if the keep-alive flag is enabled. This socket option is then
> inherited by active server-side sockets communicating with connected
> clients.
> 
> This patch also fixes an issue in 'qio_dns_resolver_lookup_sync_inet()'
> where the keep-alive flag is not copied together with other attributes.
> 
> Signed-off-by: Juraj Marcin<jmarcin@redhat.com>


Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

-- 
Best regards,
Vladimir


