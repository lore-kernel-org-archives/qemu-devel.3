Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13ECEE9A053
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 18:08:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt8Ru-0003kl-N6; Thu, 19 Feb 2026 13:08:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vt8Rq-0003j4-AN
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 13:08:22 -0500
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vt8Ri-0001pL-NF
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 13:08:16 -0500
Received: from mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:94a9:0:640:a3fa:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 4B830806F1;
 Thu, 19 Feb 2026 21:08:11 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:192::1:26] (unknown
 [2a02:6bf:8080:192::1:26])
 by mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id A8g3BP4A7iE0-VuS2OJjD; Thu, 19 Feb 2026 21:08:10 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1771524490;
 bh=Defj6a/yK4NGt5UOLjKDUQ+jKwy6CzPmcm86HcUbnfI=;
 h=In-Reply-To:Cc:Date:References:To:From:Subject:Message-ID;
 b=N0/+QlB4Ms0tZQV35Ir9t9tWoBUHTzjZEivnSIaMaTxQ2xqn0p2HAamQ09/DuSSjO
 dEvNWK2w3E+aa22TGhWFaFmDYCHAM/tgFBx7cxtVK68Q8k+wbUPYG6P6jg4D+8ommw
 eE+08CbBVE0Hol5NoPlbKCepAw0OJlOsE3/nyOSE=
Authentication-Results: mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <f4daf0e1-a918-4458-b7fb-87a91e77c617@yandex-team.ru>
Date: Thu, 19 Feb 2026 21:08:09 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] char: qemu_chr_write_log() use qemu_write_full()
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: marcandre.lureau@redhat.com, pbonzini@redhat.com, armbru@redhat.com,
 eblake@redhat.com, yc-core@yandex-team.ru, d-tatianin@yandex-team.ru,
 qemu-devel@nongnu.org, philmd@linaro.org
References: <20260201173633.413934-1-vsementsov@yandex-team.ru>
 <20260201173633.413934-2-vsementsov@yandex-team.ru>
 <aYCJ3Mu9XJYnl1-r@redhat.com>
 <c70aacec-aa10-4a0c-8eae-f6c48da5b9f1@yandex-team.ru>
Content-Language: en-US
In-Reply-To: <c70aacec-aa10-4a0c-8eae-f6c48da5b9f1@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 19.02.26 21:07, Vladimir Sementsov-Ogievskiy wrote:
> 
> 
> Looking through:

"Looking through usages of qemu_create()" I mean

-- 
Best regards,
Vladimir

