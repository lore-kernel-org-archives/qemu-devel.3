Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0AC3CD98E4
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 11:50:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZomK-0000va-MH; Wed, 17 Jun 2026 07:49:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1wZomH-0000tL-EU; Wed, 17 Jun 2026 07:49:53 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1wZomF-0003fF-Vo; Wed, 17 Jun 2026 07:49:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=dwEznelm4TZFXWqhPl98DzB1KiZ45pBsrSTd8sHpwlI=; b=pyWsWfUtTN7Da93i+mzbqW9Eu8
 MgQG4xuTC5BYdfNAIKM4QTPHShrjkDfr1PXB3QmGPDaRks13PZquqkbuDZM3ObMQbksfNrMaRba4r
 UtRTe0lf44clmj4CYtvPCZg1a8J1xKMxs8n8+A5KD4U/E7AbtSMb3NAENRpPeseJaOWL2Ai/9DgpY
 ks/xrrzZ8ho+/ksYVIP/2S4dTwSyhwZD/t43eN0ZQj3pGeGV6/+59Yej+Okbt8g6llRUN0jWeXBS9
 o8EP82OjhJukVWmB+Lmhd+52wY3wUC6oHktUCcU65hIvqEjY1joJGjXmiZbsxlCiwQHUkyFdYJkZP
 h/0C3IRx85JGoZR5UX9aPY6i4zgWnvk4tlGl1S05KB13H7ufW5/EreNITyukaOMxL/t7bCvWs/ESm
 wy8NE7z759fF/qfELk6OLnoQUo8U5467L5JaOUYb7hfde8WP1vZ1yHZAfJLTF/0pdMgBcG7mUEc1J
 60LczK0iCd1rIuJ3hJKfl7Ups4Z+1FI8O4mdwgot4QJ8liFkTX0vBf6sNhV9rjMKLi3Blg2wX5qG+
 6LeUhkXGeOKF1MbtjNnS4XT1x1p64s2d3Liz3UTUPf5zROoT4DfuaefKj+b1Mum0C2qLIdR+OQSLm
 xNf/okAP8LTKbdwI9VWWGCbJ4XuAoucMEsBlSfzNo=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org, qemu-stable@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>
Cc: Greg Kurz <groug@kaod.org>, Feifan Qian <bea1e@proton.me>
Subject: Re: [PATCH 0/3] 9pfs: fix invalid union V9fsFidOpenState access
Date: Wed, 17 Jun 2026 13:49:46 +0200
Message-ID: <7957233.EvYhyI6sBW@weasel>
In-Reply-To: <7735fc49-6669-43c7-b367-669cb88b2c8f@tls.msk.ru>
References: <cover.1781621428.git.qemu_oss@crudebyte.com>
 <2353743.iZASKD2KPV@weasel>
 <7735fc49-6669-43c7-b367-669cb88b2c8f@tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=qemu_oss@crudebyte.com; helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

On Wednesday, 17 June 2026 12:43:09 CEST Michael Tokarev wrote:
> On 17.06.2026 12:59, Christian Schoenebeck wrote:
[...]
> > What about delaying the stable release for a week? Does that sound like a
> > viable compromise?
> 
> Let's make it into the next stable releases instead.  You can include
> the set which is already published in your tree, and for the rest, let's
> wait for the next round.  I don't plan to delay next stable releases.

Agreed.

The already queued 3 patches will certainly make it to master in-time for the 
stable release next week, but all other patches will miss that release window.

Thanks!

/Christian



