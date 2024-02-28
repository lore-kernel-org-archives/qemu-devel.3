Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39491C5478C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 17:13:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfNU2-0001rF-63; Wed, 28 Feb 2024 12:12:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rfNTs-0001pX-RY
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 12:12:34 -0500
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rfNTn-0002B4-H3
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 12:12:32 -0500
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2a:3dc:0:640:1e66:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 9FABE60BA2;
 Wed, 28 Feb 2024 20:12:19 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:a519::1:3a] (unknown
 [2a02:6b8:b081:a519::1:3a])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id ICdGwr1i08c0-bvvO5QSD; Wed, 28 Feb 2024 20:12:19 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1709140339;
 bh=53ffgVKFnnlgdScA8X95YFpe40nr2SQKkVphESXwSRA=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=qLiPBY+T6YfhBaB4Jx1v2iOaRY7dCQls/y1GJe/OZNCoGihAbtFQFvGHixGKI5aR1
 ip9mkMzJK8lsUIbf1ZWjwr55Dd+T05O7l1ZLXh/SRK52JCkC+aEJL3wbpMTynBDG8O
 lPFe34LW2JtU+SeMnQrDs6xi3WVNbbosflY9o4mg=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <5fa5fe8a-fb2a-4b4f-8509-6cebae37a87f@yandex-team.ru>
Date: Wed, 28 Feb 2024 20:12:18 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] system/qdev-monitor: move drain_call_rcu call under if
 (!dev) in qmp_device_add()
Content-Language: en-US
To: Dmitrii Gavrilov <ds-gavr@yandex-team.ru>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: pbonzini@redhat.com, berrange@redhat.com, eduardo@habkost.net,
 mlevitsk@redhat.com, yc-core@yandex-team.ru
References: <20231103105602.90475-1-ds-gavr@yandex-team.ru>
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20231103105602.90475-1-ds-gavr@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

ping.

Hi again!

Paolo could you please take a look? Could we merge that? It still applies to master branch.

On 03.11.23 13:56, Dmitrii Gavrilov wrote:
> Original goal of addition of drain_call_rcu to qmp_device_add was to cover
> the failure case of qdev_device_add. It seems call of drain_call_rcu was
> misplaced in 7bed89958bfbf40df what led to waiting for pending RCU callbacks
> under happy path too. What led to overall performance degradation of
> qmp_device_add.
> 
> In this patch call of drain_call_rcu moved under handling of failure of
> qdev_device_add.
> 
> Signed-off-by: Dmitrii Gavrilov <ds-gavr@yandex-team.ru>
> ---
>   system/qdev-monitor.c | 23 +++++++++++------------
>   1 file changed, 11 insertions(+), 12 deletions(-)
> 
> diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
> index 1b8005a..dc7b02d 100644
> --- a/system/qdev-monitor.c
> +++ b/system/qdev-monitor.c
> @@ -856,19 +856,18 @@ void qmp_device_add(QDict *qdict, QObject **ret_data, Error **errp)
>           return;
>       }
>       dev = qdev_device_add(opts, errp);
> -
> -    /*
> -     * Drain all pending RCU callbacks. This is done because
> -     * some bus related operations can delay a device removal
> -     * (in this case this can happen if device is added and then
> -     * removed due to a configuration error)
> -     * to a RCU callback, but user might expect that this interface
> -     * will finish its job completely once qmp command returns result
> -     * to the user
> -     */
> -    drain_call_rcu();
> -
>       if (!dev) {
> +        /*
> +         * Drain all pending RCU callbacks. This is done because
> +         * some bus related operations can delay a device removal
> +         * (in this case this can happen if device is added and then
> +         * removed due to a configuration error)
> +         * to a RCU callback, but user might expect that this interface
> +         * will finish its job completely once qmp command returns result
> +         * to the user
> +         */
> +        drain_call_rcu();
> +
>           qemu_opts_del(opts);
>           return;
>       }

-- 
Best regards,
Vladimir


