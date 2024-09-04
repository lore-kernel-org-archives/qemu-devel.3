Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A9EBCA0ED3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 09:01:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sllsi-0002aN-20; Wed, 04 Sep 2024 05:00:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sllsf-0002ZE-7c
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 05:00:49 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sllsb-0005TE-Cv
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 05:00:48 -0400
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:8a3:0:640:33b5:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 1560560B38;
 Wed,  4 Sep 2024 12:00:37 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:4::1:25] (unknown [2a02:6b8:b081:4::1:25])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (smtpcorp/Yandex) with ESMTPSA id Y0Ye9Z0Ib4Y0-ul3WVJER; 
 Wed, 04 Sep 2024 12:00:36 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1725440436;
 bh=CruYvI7BY1TKFXXHGDhwUw9u2B3/p6xiekG4c4gye9U=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=sDFJlyJl5WiUQp6rO90kV3F8HUgOuaCc2gmR5pDpM1jm0DG2hnEjvHbL4Hq+9eldb
 bBjKsy9O0qrT2W4Np1NAH5cAnDvxCodQDrBlC1/T0FDO3krGUY6zj1hVcYIb3dIkp2
 YU8VO+f6+jTNUtHNpMKBAt/I4nN6JycJ462tVbZo=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <9934b7ba-912f-435f-80e0-c70b272faf86@yandex-team.ru>
Date: Wed, 4 Sep 2024 12:00:34 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] chardev: introduce 'reconnect-ms' and deprecate
 'reconnect'
To: Daniil Tatianin <d-tatianin@yandex-team.ru>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 devel@lists.libvirt.org, Peter Krempa <pkrempa@redhat.com>,
 Michal Privoznik <mprivozn@redhat.com>
References: <20240904051913.53148-1-d-tatianin@yandex-team.ru>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20240904051913.53148-1-d-tatianin@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 04.09.24 08:19, Daniil Tatianin wrote:
> The 'reconnect' option only allows to specify the time in seconds,
> which is way too long for certain workflows.
> 
> We have a lightweight disk backend server, which takes about 20ms to
> live update, but due to this limitation in QEMU, previously the guest
> disk controller would hang for one second because it would take this
> long for QEMU to reinitialize the socket connection.
> 
> Introduce a new option called 'reconnect-ms', which is the same as
> 'reconnect', except the value is treated as milliseconds. These are
> mutually exclusive and specifying both results in an error.
> 
> 'reconnect' is also deprecated by this commit to make it possible to
> remove it in the future as to not keep two options that control the
> same thing.
> 
> Signed-off-by: Daniil Tatianin<d-tatianin@yandex-team.ru>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

-- 
Best regards,
Vladimir


