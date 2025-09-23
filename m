Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD2F2CAC5A7
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 10:40:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v10RL-0001kL-Jc; Tue, 23 Sep 2025 06:40:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v10RC-0001TP-CF
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 06:39:59 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v10R4-0005QH-Dh
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 06:39:58 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c23:36c1:0:640:5f85:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 1F6BF88513;
 Tue, 23 Sep 2025 13:39:45 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:b38::1:12] (unknown
 [2a02:6bf:8080:b38::1:12])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id hdUPWE0Gka60-jdz8IcOT; Tue, 23 Sep 2025 13:39:44 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1758623984;
 bh=BcJAJ0L45q33j1zyLla4riURqtnA1SaWy0GIhjh18Js=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=zA+qkS8vSmNDhJetlpcH/jqZtCWz3yG6QANNor+qaBOY0n/VhlzcqaW7kw0l+G38m
 7OxjzHAbiWI9YBBg+8EwSa6CCEYhTHZFmKFAphUPKOW1bwpxK8ECCsyYJB528J7Qae
 4FLtZatY/VCynkteIBUNQOui90UnWIqKp2DwzMuA=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <01bee699-3d9d-48b1-ab62-16bf4174f657@yandex-team.ru>
Date: Tue, 23 Sep 2025 13:39:43 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 05/19] net/tap: rework scripts handling
To: mst@redhat.com
Cc: qemu-devel@nongnu.org, philmd@linaro.org, thuth@redhat.com,
 eblake@redhat.com, michael.roth@amd.com, armbru@redhat.com, farosas@suse.de,
 peterx@redhat.com, berrange@redhat.com, jasowang@redhat.com,
 steven.sistare@oracle.com, leiyang@redhat.com, davydov-max@yandex-team.ru,
 yc-core@yandex-team.ru
References: <20250923100110.70862-1-vsementsov@yandex-team.ru>
 <20250923100110.70862-6-vsementsov@yandex-team.ru>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20250923100110.70862-6-vsementsov@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
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

On 23.09.25 13:00, Vladimir Sementsov-Ogievskiy wrote:
> Simplify handling scripts: parse all these "no" and '\0' once, and
> then keep simpler logic for net_tap_open() and net_init_tap_one(): NULL
> means no script to run, otherwise run script.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>   net/tap.c | 45 +++++++++++++++++++++++++--------------------
>   1 file changed, 25 insertions(+), 20 deletions(-)
> 

[..]

>                        "%s", ifname);
> @@ -950,10 +963,10 @@ free_fail:
>               return -1;
>           }
>       } else {
> -        const char *script = tap->script;
> -        const char *downscript = tap->downscript;
> -        g_autofree char *default_script = NULL;
> -        g_autofree char *default_downscript = NULL;
> +        g_autofree char *script =
> +            tap_parse_script(tap->script, DEFAULT_NETWORK_SCRIPT);
> +        g_autofree char *downscript =
> +            tap_parse_script(tap->script, DEFAULT_NETWORK_DOWN_SCRIPT);

Ohh, tap->downscript of-course

>           bool vnet_hdr_required = tap->has_vnet_hdr && tap->vnet_hdr;
>   
>           if (tap->vhostfds) {
> @@ -961,14 +974,6 @@ free_fail:
>               return -1;
>           }
>   
-- 
Best regards,
Vladimir

