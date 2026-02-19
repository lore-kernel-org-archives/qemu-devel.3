Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A863C531CB
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 19:59:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtAAi-0002YH-CH; Thu, 19 Feb 2026 14:58:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vtAAg-0002Y7-O6
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 14:58:46 -0500
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vtAAe-0007wz-Mj
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 14:58:46 -0500
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:1e1e:0:640:c6a6:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id A98CF80771;
 Thu, 19 Feb 2026 22:58:41 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:192::1:26] (unknown
 [2a02:6bf:8080:192::1:26])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id ewh6c04A1mI0-JXiesHp4; Thu, 19 Feb 2026 22:58:41 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1771531121;
 bh=LpCRgsFnCxS3g7muN/+1rOvkEc3ILeQxDi9wKBwYl+M=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=CXHzlwLk8HOwgnjlfn27bGp2ErF94HE/63I/bsetHhLUtmri1T1JYkDbtvIjx7IBK
 yQ1ig2DOOrZLxRuqt7Vo72bCyFlhZ0UYJFMwPJJCKdB3t33Yon/9JPsO6vhxOOFSO2
 UUFjE6fp/zzASOSGF29SJSqf0hVHooDpdCYPYGQo=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <d4883dba-84bf-43bf-ad44-5e9a6ac90960@yandex-team.ru>
Date: Thu, 19 Feb 2026 22:58:40 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/12] net: introduce net_parse_fds()
To: jasowang@redhat.com
Cc: qemu-devel@nongnu.org, bchaney@akamai.com, yc-core@yandex-team.ru,
 d-tatianin@yandex-team.ru, davydov-max@yandex-team.ru,
 Ilya Maximets <i.maximets@ovn.org>
References: <20260218202829.1322088-1-vsementsov@yandex-team.ru>
 <20260218202829.1322088-9-vsementsov@yandex-team.ru>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20260218202829.1322088-9-vsementsov@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 18.02.26 23:28, Vladimir Sementsov-Ogievskiy wrote:
> +
> +int net_parse_fds(const char *fds_param, int **fds, int expected_nfds,
> +                  Error **errp)
> +{
> +    g_auto(GStrv) fdnames = g_strsplit(fds_param, ":", -1);
> +    unsigned nfds = g_strv_length(fdnames);
> +    int i;
> +
> +    if (nfds > INT_MAX) {
> +        error_setg(errp, "fds parameter exceeds maximum of %d", INT_MAX);
> +        return -1;
> +    }
> +
> +    if (expected_nfds && nfds != expected_nfds) {
> +        error_setg(errp, "expected %u socket fds, got %u", expected_nfds, nfds);
> +        return -1;
> +    }
> +
> +    *fds = g_new(int, nfds);
> +
> +    for (i = 0; i < nfds; i++) {
> +        (*fds)[i] = monitor_fd_param(monitor_cur(), fdnames[i], errp);
> +        if ((*fds)[i] == -1) {
> +            net_free_fds(*fds, i);
> +            *fds = NULL;
> +            return -1;
> +        }
> +    }
> +
> +    return nfds;

Note that I tried to use "int" for queues/nfds consistently, but here
implicit cast unsigned -> int is kept. It seems worse use "int" for
nfds, calling g_strv_length() which returns guint. And we do check
that nfds <= INT_MAX.

> +}


-- 
Best regards,
Vladimir

