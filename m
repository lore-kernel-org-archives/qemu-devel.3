Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09CD2C02196
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 07:20:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfwBU-0000Y3-Py; Thu, 06 Feb 2025 02:20:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1tfwBR-0000Vc-N5; Thu, 06 Feb 2025 02:20:21 -0500
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1tfwBO-0007Ke-Az; Thu, 06 Feb 2025 02:20:21 -0500
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c15:2a9d:0:640:c19b:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id EF38560917;
 Thu,  6 Feb 2025 10:20:10 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b705::1:6] (unknown
 [2a02:6b8:b081:b705::1:6])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 9Kg8DV0GbOs0-wAr0gOnY; Thu, 06 Feb 2025 10:20:10 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1738826410;
 bh=553sbjiBxpG1Qq7MYvWYo8CFi7NXjNL6roES7QUV6aQ=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=cdZ9SzlSLWgKfEk8+U592z8IerWEBL14qnS7HICOXS9zCEoacx3tLzwRgpicgTqd0
 zkmaaJCws9e6UX6XoygWjv/AxlHhmYO2P6OFovKThqcfLbcetpsnNsDIkv2aIekIK0
 i2WwxUnCtb8s5QKxsyIVgXlPtRhfqxojdPEEpaGE=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <d1171e97-eac6-4b9c-81cd-43dbb3777911@yandex-team.ru>
Date: Thu, 6 Feb 2025 10:20:09 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] nbd/server: Allow users to adjust handshake limit in
 QMP
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <20250203222722.650694-4-eblake@redhat.com>
 <20250203222722.650694-6-eblake@redhat.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20250203222722.650694-6-eblake@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
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

On 04.02.25 01:26, Eric Blake wrote:
> Although defaulting the handshake limit to 10 seconds was a nice QoI
> change to weed out intentionally slow clients, it can interfere with
> integration testing done with manual NBD_OPT commands over 'nbdsh
> --opt-mode'.  Expose a QMP knob 'handshake-max-secs' to allow the user
> to alter the timeout away from the default.
> 
> The parameter name here intentionally matches the spelling of the
> constant added in commit fb1c2aaa98, and not the command-line spelling
> added in the previous patch for qemu-nbd; that's because in QMP,
> longer names serve as good self-documentation, and unlike the command
> line, machines don't have problems generating longer spellings.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

(renaming to -seconds is, of course, OK)

> ---
>   qapi/block-export.json         | 10 ++++++++++
>   include/block/nbd.h            |  6 +++---

[..]

> @@ -52,6 +57,10 @@
>   #
>   # @addr: Address on which to listen.
>   #
> +# @handshake-max-secs: Time limit, in seconds, at which a client that
> +#     has not completed the negotiation handshake will be disconnected,
> +#     or 0 for no limit (since 10.0; default: 10).
> +#

Hmm. [not about the series], shouldn't we finally deprecate older interface?

>   # @tls-creds: ID of the TLS credentials object (since 2.6).
>   #
>   # @tls-authz: ID of the QAuthZ authorization object used to validate
> @@ -72,6 +81,7 @@
>   ##
>   { 'command': 'nbd-server-start',
>     'data': { 'addr': 'SocketAddressLegacy',

[..]

-- 
Best regards,
Vladimir


