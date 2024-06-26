Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 708B5C27C4F
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 11:24:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMQlE-0007b4-8A; Wed, 26 Jun 2024 07:24:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sMQl7-0007VT-2D; Wed, 26 Jun 2024 07:24:17 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sMQl3-0000T2-T4; Wed, 26 Jun 2024 07:24:16 -0400
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:6401:0:640:7e6f:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 9A60860E75;
 Wed, 26 Jun 2024 14:24:08 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b645::1:29] (unknown
 [2a02:6b8:b081:b645::1:29])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 7OOdlY0rASw0-GIMsaoAQ; Wed, 26 Jun 2024 14:24:07 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1719401047;
 bh=5w6Oi/4WkuNXouoz05/Dm+KIEKquoF4V+YhIzsh/V3s=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=WkgtauCjI2Xw/yOXXs5eIHS1rcUHjHhOLFICX7mdF5f/2VqTQu59KvcLFeG4t5rSY
 8+Mnn4bZdTsJzcRA4zHINc3GtYUbG/Vbd72XoHZ4gEC1rMT7p/Fs+6PaOz+rrpOLg4
 Zi9Y2OyOJEQcW1zTfbm3U41xH6L+ya5ccvZaV5pE=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <71e55c6e-6ad9-4244-b710-5e6d1d67dc04@yandex-team.ru>
Date: Wed, 26 Jun 2024 14:24:07 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] block-backend: per-device throttling of BLOCK_IO_ERROR
 reports
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, eblake@redhat.com, hreitz@redhat.com,
 kwolf@redhat.com, armbru@redhat.com, zeil@yandex-team.ru,
 yc-core@yandex-team.ru, dave@treblig.org, Leonid Kaplan <xeor@yandex-team.ru>
References: <20240109131308.455371-1-vsementsov@yandex-team.ru>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20240109131308.455371-1-vsementsov@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

ping2

On 09.01.24 16:13, Vladimir Sementsov-Ogievskiy wrote:
> From: Leonid Kaplan <xeor@yandex-team.ru>
> 
> BLOCK_IO_ERROR events comes from guest, so we must throttle them.
> We still want per-device throttling, so let's use device id as a key.
> 
> Signed-off-by: Leonid Kaplan <xeor@yandex-team.ru>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
> 
> v2: add Note: to QAPI doc
> 
>   monitor/monitor.c    | 10 ++++++++++
>   qapi/block-core.json |  2 ++
>   2 files changed, 12 insertions(+)
> 
> diff --git a/monitor/monitor.c b/monitor/monitor.c
> index 01ede1babd..ad0243e9d7 100644
> --- a/monitor/monitor.c
> +++ b/monitor/monitor.c
> @@ -309,6 +309,7 @@ int error_printf_unless_qmp(const char *fmt, ...)
>   static MonitorQAPIEventConf monitor_qapi_event_conf[QAPI_EVENT__MAX] = {
>       /* Limit guest-triggerable events to 1 per second */
>       [QAPI_EVENT_RTC_CHANGE]        = { 1000 * SCALE_MS },
> +    [QAPI_EVENT_BLOCK_IO_ERROR]    = { 1000 * SCALE_MS },
>       [QAPI_EVENT_WATCHDOG]          = { 1000 * SCALE_MS },
>       [QAPI_EVENT_BALLOON_CHANGE]    = { 1000 * SCALE_MS },
>       [QAPI_EVENT_QUORUM_REPORT_BAD] = { 1000 * SCALE_MS },
> @@ -498,6 +499,10 @@ static unsigned int qapi_event_throttle_hash(const void *key)
>           hash += g_str_hash(qdict_get_str(evstate->data, "qom-path"));
>       }
>   
> +    if (evstate->event == QAPI_EVENT_BLOCK_IO_ERROR) {
> +        hash += g_str_hash(qdict_get_str(evstate->data, "device"));
> +    }
> +
>       return hash;
>   }
>   
> @@ -525,6 +530,11 @@ static gboolean qapi_event_throttle_equal(const void *a, const void *b)
>                          qdict_get_str(evb->data, "qom-path"));
>       }
>   
> +    if (eva->event == QAPI_EVENT_BLOCK_IO_ERROR) {
> +        return !strcmp(qdict_get_str(eva->data, "device"),
> +                       qdict_get_str(evb->data, "device"));
> +    }
> +
>       return TRUE;
>   }
>   
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index ca390c5700..32c2c2f030 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -5559,6 +5559,8 @@
>   # Note: If action is "stop", a STOP event will eventually follow the
>   #     BLOCK_IO_ERROR event
>   #
> +# Note: This event is rate-limited.
> +#
>   # Since: 0.13
>   #
>   # Example:

-- 
Best regards,
Vladimir


