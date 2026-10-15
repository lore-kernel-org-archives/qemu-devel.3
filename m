Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D74D0CC6B34
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 08:50:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHH9b-0006LT-4o; Thu, 15 Oct 2026 04:49:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1xHH9X-0006L3-4O; Thu, 15 Oct 2026 04:49:31 -0400
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1xHH9U-0001DE-Ji; Thu, 15 Oct 2026 04:49:30 -0400
Received: from mail-nwsmtp-smtp-corp-main-63.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-63.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:8a96:0:640:b39c:0])
 by forwardcorp1d.mail.yandex.net (postfix) with ESMTPS id 758A58081F;
 Thu, 15 Oct 2026 11:49:24 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:d5a::1:34] (unknown
 [2a02:6bf:8080:d5a::1:34])
 by mail-nwsmtp-smtp-corp-main-63.iva.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id NnQhOK2fX8c0-Mhm4yXxL; Thu, 15 Oct 2026 11:49:23 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1792054163;
 bh=Qx1v4jvj89gBLFDdQaRaft49EHAyeaLSSOB8xeSWs+k=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=BBlodnRgMM8SOEtGq5/fJAW9u93dqYrRJfwG0/ytxiEP7JfhhtFgLM0tnhYTSzcis
 zkM3L8y0ALAZvpXBiGcvJvOn0w8OoYWbUCNoMGt5eUef2T1sAuFPHlwy0LUqbSo7gj
 dzxWyH7F+V6TSrNQApixVKOCgt/3Y/YwZ/mGuDqg=
Authentication-Results: mail-nwsmtp-smtp-corp-main-63.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <7d5b8b9e-3274-4ba5-a073-3ddc15fe2f3c@yandex-team.ru>
Date: Thu, 15 Oct 2026 11:49:23 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/9] block/block-copy: extract
 block_copy_set_task_method()
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, 
 John Snow <jsnow@redhat.com>
References: <20260929155125.3151111-1-den@openvz.org>
 <20260929155125.3151111-7-den@openvz.org>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20260929155125.3151111-7-den@openvz.org>
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
> Move the per-task block-status query and its skip_unallocated and
> BDRV_BLOCK_ZERO handling out of block_copy_dirty_clusters() into
> block_copy_set_task_method(). No behavior change. The next patch
> changes that decision, and having it in one place keeps that change to
> just the new logic.
> 
> The block-status result no longer lands in the caller's @ret, so drop
> the note saying @ret may be positive at the out: label.
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

