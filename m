Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D623CC6B34
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 08:37:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHGwv-00005Z-Un; Thu, 15 Oct 2026 04:36:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1xHGwt-00004q-Dj; Thu, 15 Oct 2026 04:36:27 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1xHGwr-0008J8-8z; Thu, 15 Oct 2026 04:36:27 -0400
Received: from mail-nwsmtp-smtp-corp-main-66.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:bc9b:0:640:efdc:0])
 by forwardcorp1d.mail.yandex.net (postfix) with ESMTPS id 098CE80790;
 Thu, 15 Oct 2026 11:36:17 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:d5a::1:34] (unknown
 [2a02:6bf:8080:d5a::1:34])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id FaQxQC1ktuQ0-HiagLPhp; Thu, 15 Oct 2026 11:36:16 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1792053376;
 bh=0/u4oBTjzFy3+NDLQZ2viC0nMZkggrZiRtuMTxz51j4=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=c2i2evIIb+RhkCg/USVrbkQUDF4mP5wUfoBdhHXF2iz1uf4of6PyTIQEz0ZHQZeJ5
 XdLJ/8Ttv1yxgrR+aipqmGq3YTH7+fOLF4hWvV7JwBRBoI9hMCcFj3fn9BD4vKw9++
 2Ysx9jIoimM9HAMoFS2O9BsNCC4OlChaUhfjZOiM=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <c4321064-3138-4620-a2f5-bfb8474ef817@yandex-team.ru>
Date: Thu, 15 Oct 2026 11:36:15 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/9] block/commit: pass BDRV_WANT_PRECISE to
 block-status
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, 
 John Snow <jsnow@redhat.com>, Eric Blake <eblake@redhat.com>
References: <20260929155125.3151111-1-den@openvz.org>
 <20260929155125.3151111-2-den@openvz.org>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20260929155125.3151111-2-den@openvz.org>
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
> c33159dec790 replaced the want_zero bool with a bitmask of BDRV_WANT_*
> flags. block/commit.c was missed and still passes "true", which is
> BDRV_BLOCK_DATA, not BDRV_WANT_PRECISE. Convert it like the other
> callers.
> 
> Fixes: c33159dec790 ("block: Expand block status mode from bool to flags")
> Reviewed-by: Andrey Drobyshev<andrey.drobyshev@virtuozzo.com>
> Signed-off-by: Denis V. Lunev<den@openvz.org>
> CC: Vladimir Sementsov-Ogievskiy<vsementsov@yandex-team.ru>
> CC: John Snow<jsnow@redhat.com>
> CC: Andrey Drobyshev<andrey.drobyshev@virtuozzo.com>
> CC: Eric Blake<eblake@redhat.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

-- 
Best regards,
Vladimir

