Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85A05E9538C
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 11:49:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnbO4-0003mw-0J; Wed, 04 Feb 2026 06:49:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vnbO2-0003mf-NZ; Wed, 04 Feb 2026 06:49:34 -0500
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vnbO0-0004e7-DW; Wed, 04 Feb 2026 06:49:34 -0500
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:3530:0:640:eca4:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id EEF4AC014D;
 Wed, 04 Feb 2026 14:49:26 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:52d::1:1f] (unknown
 [2a02:6bf:8080:52d::1:1f])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id PnnSnQ0A7eA0-uLtfTBNb; Wed, 04 Feb 2026 14:49:26 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1770205766;
 bh=HsBf4/Mv/1arfFzXIjbsIEtV+zB6aqSh4QmaFjajk6E=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=EmuCjyg0opWjrE7qEMzd6efPTmBSYWdbAZ2Az3tFgpIy6JZyAOkKFr7ghephSXKQM
 wcU7rOZ+E7piW6T3v/TgefD+C0A6cPNis3D9bJi+xNUDOmbffZ1u/X2QKtecaKWtDd
 nSt1xpwrbDY0COUcHdATRq8ZReMBUwCtc6tdi/Y4=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <901d164f-47e7-497e-be20-6d2bef9e3d2f@yandex-team.ru>
Date: Wed, 4 Feb 2026 14:49:25 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] [for-10.1] block-jobs: add final flush
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, hreitz@redhat.com, kwolf@redhat.com,
 jsnow@redhat.com, den@openvz.org
References: <20250402083715.391059-1-vsementsov@yandex-team.ru>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20250402083715.391059-1-vsementsov@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

Ping) Patch is good for current master, so ignore "for-10.1".

On 02.04.25 11:37, Vladimir Sementsov-Ogievskiy wrote:
> Actually block job is not completed without the final flush. It's
> rather unexpected to have broken target when job was successfully
> completed long ago and now we fail to flush or process just
> crashed/killed.
> 
> Mirror job already has mirror_flush() for this. So, it's OK.
> 
> Do this for stream, commit and backup jobs too.
> 
> Note that jobs behave a bit different around IGNORE action:
> backup and commit just retry the operation, when stream skip
> failed operation and store the error to report later. Keep
> these different behaviors for final flush too.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy<vsementsov@yandex-team.ru>


-- 
Best regards,
Vladimir

