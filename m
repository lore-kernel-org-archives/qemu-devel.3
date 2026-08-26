Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32917C61DC2
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 09:50:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzAGP-00072v-GS; Wed, 26 Aug 2026 05:49:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wzAGN-00072O-Qy; Wed, 26 Aug 2026 05:49:43 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wzAGL-0005XW-Mj; Wed, 26 Aug 2026 05:49:43 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c24:fa2:0:640:41ee:0])
 by forwardcorp1b.mail.yandex.net (postfix) with ESMTPS id 3BB4F80835;
 Wed, 26 Aug 2026 12:49:38 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:a6b::1:10] (unknown
 [2a02:6bf:8080:a6b::1:10])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id bnZhO1SaReA0-2lQM1cIy; Wed, 26 Aug 2026 12:49:37 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1787737777;
 bh=baOfsemdVuiZ+7fLhgoBauygwOWOTE9TjuOsAxg4U3U=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=BzE46VYU+gEG7sVb/OgDSfQ7ehQSE41rCxBt//hQpKdIUzSQUXj19aQHjx4ssMVwa
 Nr14Mso9wPKkQ0iGu4rYpm0187DR/qIAN3L8n020DRlMqCLRKw8z7oMkbqqUmLQTMm
 YGNJmjKazwGA7rjKdEkRWDqmRTNrxakuo6fJooxU=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <3090fe4a-2545-4292-a43a-fb450ae3f9e8@yandex-team.ru>
Date: Wed, 26 Aug 2026 12:49:36 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/1] qcow2: add functionality to repair bitmaps
To: Jean-Louis Dupond <jean-louis@dupond.be>, qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, Eric Blake <eblake@redhat.com>,
 qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
References: <20260713081304.84812-1-jean-louis@dupond.be>
 <20260713081304.84812-2-jean-louis@dupond.be>
 <34805728-b3a6-4efb-a52d-ca444c9e816a@dupond.be>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <34805728-b3a6-4efb-a52d-ca444c9e816a@dupond.be>
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

On 25.08.26 12:43, Jean-Louis Dupond wrote:
> Ping for the v6 version of the patch.
> 
> Every previous comment was addressed.

Hi!

Hmm. But I don't see any difference with v5.

Comparison here https://patchew.org/QEMU/20260522224335.1286291-1-jean-louis@dupond.be/diff/20260713081304.84812-1-jean-louis@dupond.be/ is empty.

-- 
Best regards,
Vladimir

