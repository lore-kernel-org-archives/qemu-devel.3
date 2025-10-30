Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 327B8CCF9F0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 20:36:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEZMm-0004Tg-Rv; Thu, 30 Oct 2025 16:35:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vEZMk-0004FE-As
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 16:35:26 -0400
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vEZMR-0006DT-Sl
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 16:35:22 -0400
Received: from mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:94a9:0:640:a3fa:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id DA8BA80AA2;
 Thu, 30 Oct 2025 23:34:59 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:861::1:2b] (unknown
 [2a02:6bf:8080:861::1:2b])
 by mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id wYmJfN0FqCg0-IowhKuhH; Thu, 30 Oct 2025 23:34:59 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1761856499;
 bh=iaKcvH458ZQdGbz87sMqu4BxTdGxZ+PZnLG/Efe1BZ4=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=h8SAUDgeYFyoibnX2tkOCGASTVEQ1uF1R8uyiNnw8ng3TZzU7xicFLfRxvw2G9XhL
 jPqSzWgUN8+XWpVd8n/4rzuaYbBpAMo4AREdJKxqbVk4ofvkflJGmTl7gdo++m4F4n
 UonaN+LCNPkYbH4ovtzGunH6q0F7r1kvbZa0oIn0=
Authentication-Results: mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <a694e3bd-9352-408e-a436-7aa1f73d469a@yandex-team.ru>
Date: Thu, 30 Oct 2025 23:34:58 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 1/9] net: introduce backend-connect concept
To: jasowang@redhat.com
Cc: qemu-devel@nongnu.org, leiyang@redhat.com, davydov-max@yandex-team.ru,
 yc-core@yandex-team.ru, pbonzini@redhat.com, berrange@redhat.com,
 eduardo@habkost.net, peterx@redhat.com
References: <20251030171915.726441-1-vsementsov@yandex-team.ru>
 <20251030171915.726441-2-vsementsov@yandex-team.ru>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20251030171915.726441-2-vsementsov@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c41:1300:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 30.10.25 20:19, Vladimir Sementsov-Ogievskiy wrote:
> To implement in future backend-transfer migration for virtio-net,
> i.e. we are going to migrate TAP fd and some other TAP properties,
> we'll need a possibility to postpone opening TAP device until the
> point where we are know what user wants: open TAP device, or wait
> from fd coming in migration stream.
> 
> So, new interface is here: since this commit, net backends may
> postpone some initialization actions (like opening or connecting)
> up to call of .backend_connect() handler.
> 
> Currently, for all net drivers, .backend_connect() is called
> during set of netdev property, so drivers continue to work with
> already "connected" backends.
> 
> Still, we add a possibility for drivers to use new
> DEFINE_NIC_PROPERTIES_NO_CONNECT() instead of
> DEFINE_NIC_PROPERTIES(). This way, driver take responsibility
> to call net_backend_connect() in its own. So, in future we'll
> use it in vritio-net, to finally implement backand-transfer
> migration fot TAP backend.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy<vsementsov@yandex-team.ru>


fixup for this commit (otherwise new macro is impossible to use):

--- a/include/hw/qdev-properties-system.h
+++ b/include/hw/qdev-properties-system.h
@@ -20,6 +20,7 @@ extern const PropertyInfo qdev_prop_fdc_drive_type;
  extern const PropertyInfo qdev_prop_drive;
  extern const PropertyInfo qdev_prop_drive_iothread;
  extern const PropertyInfo qdev_prop_netdev;
+extern const PropertyInfo qdev_prop_netdev_no_connect;
  extern const PropertyInfo qdev_prop_pci_devfn;
  extern const PropertyInfo qdev_prop_blocksize;
  extern const PropertyInfo qdev_prop_pci_host_devaddr;

-- 
Best regards,
Vladimir

