Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A7DBE67A98
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 08:45:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxLNc-0002Gz-4A; Tue, 03 Mar 2026 03:45:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vxLNZ-0002GT-MB; Tue, 03 Mar 2026 03:45:21 -0500
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vxLNW-0005rf-Bu; Tue, 03 Mar 2026 03:45:21 -0500
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c37:8aa5:0:640:e6ae:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 0E67C807BE;
 Tue, 03 Mar 2026 11:45:10 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:d82::1:b] (unknown [2a02:6bf:8080:d82::1:b])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 6jieV00Ag8c0-KfxgldtG; Tue, 03 Mar 2026 11:45:09 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1772527509;
 bh=NvQ34poYzdQskGMUHMFU+EJW3oMU8eYoGNq/ZT7RaPI=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=BQocEVorc8+8BHtNjaDNag3BmJxc8TuZY8BrRuNeFrU+49XMZYoEB1SKhTZvHL7Xf
 pgyds2mznDBVBPr35sUpWgxfTeCA4fhvDcl/zy1wBZyd1XnS3q+iQlRobc+kiI4IY+
 Yd8xTzy84oR9Cdu1lTSHyqUo2wAL8d2h0vriZfAY=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <d16021a0-3994-4ab7-9de4-2eb7a8eed30b@yandex-team.ru>
Date: Tue, 3 Mar 2026 11:45:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] vhost-user: add skip_drain param to GET_VRING_BASE
To: Alexandr Moshkov <dtalexundeer@yandex-team.ru>,
 Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Raphael Norwitz <rnorwitz@nvidia.com>,
 virtio-fs@lists.linux.dev, Milan Zamazal <mzamazal@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 zhenwei pi <zhenwei.pi@linux.dev>, "Gonglei (Arei)"
 <arei.gonglei@huawei.com>, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefano Garzarella
 <sgarzare@redhat.com>, Fam Zheng <fam@euphon.net>, qemu-block@nongnu.org
References: <20260224075055.863068-1-dtalexundeer@yandex-team.ru>
 <20260224075055.863068-3-dtalexundeer@yandex-team.ru>
 <20260301233406.GA8465@fedora>
 <121fea54-0041-4004-aa4f-3a402da8169e@yandex-team.ru>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <121fea54-0041-4004-aa4f-3a402da8169e@yandex-team.ru>
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

On 02.03.26 10:12, Alexandr Moshkov wrote:
> It seemed to me to be the more correct solution, because it took a little time for someone

Moreover, it's not yet released.

-- 
Best regards,
Vladimir

