Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9972CC25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 22:28:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7N6j-00057h-BB; Wed, 15 May 2024 18:28:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1s7N6X-0004yn-RZ; Wed, 15 May 2024 18:28:13 -0400
Received: from fanzine.igalia.com ([178.60.130.6] helo=fanzine2.igalia.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1s7N6W-0007tv-CQ; Wed, 15 May 2024 18:28:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Type:MIME-Version:Message-ID:Date:References:
 In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=aZ3o8qQlfWmbnju0Q0BCDBOLwmSIXUVYScAe2v92aZ8=; b=iNvV4TZON1jQvHjqrHI4VeWU1J
 9PWcWy3W4GwtUAJW12C5guYXrt+cwkBWy5LWjy8sF580XoqrPPlvBxCtLsSiiTDcRSqFcFpMSgN6F
 ZQ8/p8mAoh6K25qRVW5MQv4qdTWA8c1JqNwZ/jN8BCu4LorJydAeZYdYo05uatdLxRyVosr7BVng7
 MPYOfu/BDTK/YHXLlwEImJmVfkyBcPiOOaRqLKU2Z+eietK2bz56Y9LRLp2aJFAMKuq/ULSZg279b
 MDyjQWNU17r0eAJLnSPCgbzc+tLFVfWNFJZgX+RGZhlD+/2djLCYps3Rv2mctWzYEJY8JUBEs6jMH
 gT9wPpJw==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine2.igalia.com with esmtps 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1s7N6U-008an2-4P; Thu, 16 May 2024 00:28:06 +0200
Received: from gate.service.igalia.com ([192.168.21.52])
 by mail.igalia.com with esmtp (Exim)
 id 1s7N6R-002PwJ-VX; Thu, 16 May 2024 00:28:06 +0200
Received: from berto by gate.service.igalia.com with local (Exim 4.96)
 (envelope-from <berto@igalia.com>) id 1s7N6R-005Gsm-2d;
 Wed, 15 May 2024 22:28:03 +0000
From: Alberto Garcia <berto@igalia.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, hreitz@redhat.com, kwolf@redhat.com,
 eblake@redhat.com, jean-louis@dupond.be, andrey.drobyshev@virtuozzo.com,
 den@virtuozzo.com
Subject: Re: [PATCH v2 02/11] qcow2: simplify L2 entries accounting for
 discard-no-unref
In-Reply-To: <20240513063203.113911-3-andrey.drobyshev@virtuozzo.com>
References: <20240513063203.113911-1-andrey.drobyshev@virtuozzo.com>
 <20240513063203.113911-3-andrey.drobyshev@virtuozzo.com>
Date: Thu, 16 May 2024 00:28:03 +0200
Message-ID: <w51zfsqaex8.fsf@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
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

On Mon 13 May 2024 09:31:54 AM +03, Andrey Drobyshev wrote:
> Commits 42a2890a and b2b10904 introduce handling of discard-no-unref
> option in discard_in_l2_slice() and zero_in_l2_slice().  They add even
> more if's when chosing the right l2 entry.  What we really need for this
> option is the new entry simply to contain the same host cluster offset,
> no matter whether we unmap or zeroize the cluster.  For that OR'ing with
> the old entry is enough.
>
> This patch doesn't change the logic and is pure refactoring.
>
> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto

