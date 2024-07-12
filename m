Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A033C3DA4B
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 12:57:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSFpY-0005c9-7z; Fri, 12 Jul 2024 08:56:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sSFpX-0005XM-3j; Fri, 12 Jul 2024 08:56:55 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sSFpU-0004FF-UL; Fri, 12 Jul 2024 08:56:54 -0400
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:6401:0:640:7e6f:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 2EF396168E;
 Fri, 12 Jul 2024 15:56:49 +0300 (MSK)
Received: from [IPV6:2a02:6b8:0:419:5fb9:9623:463f:792c] (unknown
 [2a02:6b8:0:419:5fb9:9623:463f:792c])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id mufIL81IdKo0-RCEtZ3Gy; Fri, 12 Jul 2024 15:56:48 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1720789008;
 bh=zbf6oQn+sxDn9V6CYq8OV+Syqe/KCq8KEia1SfTOYbw=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=KbAC73QqEK8xQtx55N3FO0gRVDtYTX8yC/vKfc8JiopaNfAAKGDmRieKbPSxdGc12
 RLCf+lkwZRlUXScLDQNXJwM16aB9kmNvbfdcOvJ6iGewYBeKrDGRo86uQ+k4w2505e
 Imy8G+RgTlrQc22UwJc2kRDI0jFK243APM45R4R4=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <bc1f94e5-6734-42cc-b01c-f551207f5b7d@yandex-team.ru>
Date: Fri, 12 Jul 2024 15:56:48 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] backup: add minimum cluster size to performance
 options
To: Fiona Ebner <f.ebner@proxmox.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, armbru@redhat.com, eblake@redhat.com,
 hreitz@redhat.com, kwolf@redhat.com, jsnow@redhat.com
References: <20240711120915.310243-1-f.ebner@proxmox.com>
 <20240711120915.310243-3-f.ebner@proxmox.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20240711120915.310243-3-f.ebner@proxmox.com>
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
Precedence: list
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

On 11.07.24 15:09, Fiona Ebner wrote:
> In the context of backup fleecing, discarding the source will not work
> when the fleecing image has a larger granularity than the one used for
> block-copy operations (can happen if the backup target has smaller
> cluster size), because cbw_co_pdiscard_snapshot() will align down the
> discard requests and thus effectively ignore then.
> 
> To make @discard-source work in such a scenario, allow specifying the
> minimum cluster size used for block-copy operations and thus in
> particular also the granularity for discard requests to the source.
> 
> Suggested-by: Vladimir Sementsov-Ogievskiy<vsementsov@yandex-team.ru>
> Acked-by: Markus Armbruster<armbru@redhat.com>  (QAPI schema)
> Signed-off-by: Fiona Ebner<f.ebner@proxmox.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

-- 
Best regards,
Vladimir


