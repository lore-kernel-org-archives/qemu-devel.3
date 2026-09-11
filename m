Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D464DC88E4A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 10:53:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4ysN-000304-Cz; Fri, 11 Sep 2026 06:52:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1x4ysL-0002zk-Ev; Fri, 11 Sep 2026 06:52:57 -0400
Received: from fanzine2.igalia.com ([213.97.179.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1x4ysJ-0001jK-A3; Fri, 11 Sep 2026 06:52:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
 From:Reply-To; bh=vUacKBIksIh7vKNrhaLkEvFsF3e5tm/UIhGN4fzVIbk=; b=AGQatNP8EE3
 UHKElVvBRa+EylM1zJtb3HDk9/LqCnrDLrpigc/GtZa4cmaYAuZ8OY0Txa4BfFQrhH4S0fUyxgHpp
 ceuESYZCqN8SlMAkvIKgmBn5VOeLZM28iUjrBJeaN1WyXaBChtctt20ZmWtvM6jcrMxMWOeV6Q9+r
 xj3hgDOQxXws3YrYkYw4pkKuv/bAZwH3mUl0F5T0Hqwj0nEbqaxunanIENXSFrlmnRRgI81BsUELm
 sjt2m0l4ewxj3paFJPrI+JP17y+Dp7uBcCP2xfUTtjnEaD+YHqcOw9xBuy8LeedtuhxeGsPdePFt7
 EgS1dFGgRpD4632ZVWwcZ6w==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine2.igalia.com with esmtps 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1x4ysA-000dPd-AN; Fri, 11 Sep 2026 12:52:46 +0200
Received: from gate.service.igalia.com ([192.168.21.52])
 by mail.igalia.com with esmtp (Exim)
 id 1x4ys9-001yys-8I; Fri, 11 Sep 2026 12:52:45 +0200
Received: from berto by gate.service.igalia.com with local (Exim 4.96)
 (envelope-from <berto@igalia.com>) id 1x4ys9-000zCt-0H;
 Fri, 11 Sep 2026 10:52:45 +0000
From: Alberto Garcia <berto@igalia.com>
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, qemu-stable@nongnu.org, "Denis V. Lunev"
 <den@openvz.org>, Kevin Wolf <kwolf@redhat.com>, Hanna Reitz
 <hreitz@redhat.com>
Subject: Re: [PATCH] block/throttle-groups: fix crash when enabling I/O
 limits on a busy disk
In-Reply-To: <20260908145554.3215221-2-den@openvz.org>
References: <20260908145554.3215221-1-den@openvz.org>
 <20260908145554.3215221-2-den@openvz.org>
Date: Fri, 11 Sep 2026 12:52:45 +0200
Message-ID: <w51se3ggiv6.fsf@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=213.97.179.56; envelope-from=berto@igalia.com;
 helo=fanzine2.igalia.com
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

On Tue 08 Sep 2026 04:55:53 PM +02, Denis V. Lunev wrote:
> throttle_group_register_tgm() stores tgm->throttle_state before it takes
> tg->lock, so the I/O path can see a member whose group still has NULL
> tokens[] and an empty member list. A request in an iothread then reaches
> throttle_group_co_io_limits_intercept(), wins tg->lock ahead of the
> registering thread, and next_throttle_token() passes the NULL token to
> throttle_group_next_tgm(), which dereferences it:

Acked-by: Alberto Garcia <berto@igalia.com>

Berto

