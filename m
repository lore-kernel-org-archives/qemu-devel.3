Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD4C1C2BBCA
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 04:48:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLy5d-0005AO-Dr; Tue, 25 Jun 2024 00:47:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sLy5V-00058o-Mh; Tue, 25 Jun 2024 00:47:25 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sLy5R-00062f-Jr; Tue, 25 Jun 2024 00:47:25 -0400
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:958d:0:640:7be4:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 1548460F12;
 Tue, 25 Jun 2024 07:47:16 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b5bf::1:d] (unknown
 [2a02:6b8:b081:b5bf::1:d])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id DlGQ4B0Iha60-0gR4kKlp; Tue, 25 Jun 2024 07:47:15 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1719290835;
 bh=NTs6g9TfC3A6ZpexVzJFX5ZUbYpuCFFIz/DW/ic5Vcc=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=wvNA3c/45NA/9H1a9ILW4PtQcdhyiq+0uEpUjIrOaTLjjcItdbpwOHGs3hRfpIlUQ
 elQe1lC30HIMx7ju0/Fcvmrxtn/RigT64hTJGw72vCm/TKdgOcPmZxUUfrclSk/h1a
 ATUqXoP0N4RL1Z3+SFY6cGINs6c0xMO/rTIKLirw=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <dc3b5477-9628-4247-a741-a8cf700a32dd@yandex-team.ru>
Date: Tue, 25 Jun 2024 07:47:13 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/5] iotests: add test for bitmap mirror
To: Fiona Ebner <f.ebner@proxmox.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, armbru@redhat.com, eblake@redhat.com,
 hreitz@redhat.com, kwolf@redhat.com, jsnow@redhat.com,
 f.gruenbichler@proxmox.com, t.lamprecht@proxmox.com,
 mahaocong@didichuxing.com, xiechanglong.d@gmail.com, wencongyang2@huawei.com
References: <20240521122014.333221-1-f.ebner@proxmox.com>
 <20240521122014.333221-5-f.ebner@proxmox.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20240521122014.333221-5-f.ebner@proxmox.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 21.05.24 15:20, Fiona Ebner wrote:
> From: Fabian Grünbichler<f.gruenbichler@proxmox.com>
> 
> heavily based on/practically forked off iotest 257 for bitmap backups,
> but:

really, heavily. Making a duplication is always bad idea. Could we instead just add test-cases to 257?

> 
> - no writes to filter node 'mirror-top' between completion and
> finalization, as those seem to deadlock?

Could you give a bit more concreteness? If guest writes may lead to dead-lock, that's a bug, is it?



-- 
Best regards,
Vladimir


