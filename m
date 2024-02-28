Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 416D8C47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 17:06:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfNNS-0006KB-1H; Wed, 28 Feb 2024 12:05:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rfNNP-0006JL-EH; Wed, 28 Feb 2024 12:05:51 -0500
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rfNNL-00087t-Gq; Wed, 28 Feb 2024 12:05:51 -0500
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c18:486:0:640:cf34:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 8EF6060A86;
 Wed, 28 Feb 2024 20:05:42 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:a519::1:3a] (unknown
 [2a02:6b8:b081:a519::1:3a])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id f5dDtc1OiuQ0-GnC997sW; Wed, 28 Feb 2024 20:05:42 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1709139942;
 bh=CnEsoNAGHwYQGrDd1erMKrykQXVxZ2jJDRCOivZ3/pM=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=VLPmhqsgpkgNNlUkeRAjtMGiVvtR285IeFxOo5GVnMq00l8CW2EtvmeQM+Ip0w3X4
 FQPpUaSdRUxT9UtUEtCHi+Q31N7r+aAwF0eWWsYDs0VJVSLLhTjVpwObLKyiW764wg
 dL+EqWP/G/1rAgTUG5TY96vC+GrZDbBOqLbjPpvg=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <b61fd46c-77e3-4054-bc07-17073f26b02e@yandex-team.ru>
Date: Wed, 28 Feb 2024 20:05:41 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] block-backend: per-device throttling of BLOCK_IO_ERROR
 reports
Content-Language: en-US
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, eblake@redhat.com, hreitz@redhat.com,
 kwolf@redhat.com, armbru@redhat.com, zeil@yandex-team.ru,
 yc-core@yandex-team.ru, dave@treblig.org, Leonid Kaplan <xeor@yandex-team.ru>
References: <20240109131308.455371-1-vsementsov@yandex-team.ru>
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20240109131308.455371-1-vsementsov@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 09.01.24 16:13, Vladimir Sementsov-Ogievskiy wrote:
> From: Leonid Kaplan<xeor@yandex-team.ru>
> 
> BLOCK_IO_ERROR events comes from guest, so we must throttle them.
> We still want per-device throttling, so let's use device id as a key.
> 
> Signed-off-by: Leonid Kaplan<xeor@yandex-team.ru>
> Signed-off-by: Vladimir Sementsov-Ogievskiy<vsementsov@yandex-team.ru>

ping)

-- 
Best regards,
Vladimir


