Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACDD7CA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 15:22:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNDt-00036w-Fe; Sat, 30 Aug 2025 11:10:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-louis@dupond.be>)
 id 1urvdk-0002Sp-Ll; Fri, 29 Aug 2025 05:43:24 -0400
Received: from apollo.dupie.be ([51.159.20.238])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-louis@dupond.be>)
 id 1urvdh-0001lz-GA; Fri, 29 Aug 2025 05:43:23 -0400
Received: from [IPV6:2a02:a03f:eaf9:5401:5fb3:a398:4351:5e57] (unknown
 [IPv6:2a02:a03f:eaf9:5401:5fb3:a398:4351:5e57])
 by apollo.dupie.be (Postfix) with ESMTPSA id 3AC2D1520DF7;
 Fri, 29 Aug 2025 11:43:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dupond.be; s=dkim;
 t=1756460592;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JDSVKia2awfNEGjE80OXFYyZVf1FYankz5gcB8IqXTE=;
 b=JGVwcx2uV+q/BGBk1qERKbnYqEAzg7rA5ypObLEdsyinvqWhr7LVzcXd/q3wCJS9QPbyN0
 L9mvFYpFUMNDD0POMRP6GeEmivS4ldND5WFguWvvMJRrMINRKtKnVasT1eGqqynfCml5fQ
 JDo0Y7MIgybZZ1+aDll9Tbd12T2+ed6VU28NymRvD+YXHqcWZEUeqrfgMXzt99rgjJipMr
 lcIWNOmX2IE9b1AgJN2B+7zwmQabneZkkvfodjJmRkbkb9ZmttgxUMkzx9AQZOeu6xwdYH
 wSu2fFjwI4ZOlEUyoCj2mCkOCpmUU2ioiyqqMRidjhvbiT/LFiNFUBLMM8eqkw==
Message-ID: <8d2033db-34e3-434a-aaae-22fe538ddbb6@dupond.be>
Date: Fri, 29 Aug 2025 11:43:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] qcow2: queue discards when discard-no-unref enabled
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Alexander Ivanov <alexander.ivanov@virtuozzo.com>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, qemu-block@nongnu.org
References: <20250513132628.1055549-1-jean-louis@dupond.be>
Content-Language: en-US, en-GB, nl-BE
From: Jean-Louis Dupond <jean-louis@dupond.be>
In-Reply-To: <20250513132628.1055549-1-jean-louis@dupond.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=51.159.20.238; envelope-from=jean-louis@dupond.be;
 helo=apollo.dupie.be
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

On 13/05/2025 15:26, Jean-Louis Dupond wrote:
> Partially based on the proposal of Andrey in
> https://patchew.org/QEMU/20240913163942.423050-1-andrey.drobyshev@virtuozzo.com/
> Split up this from the rest might get it merged a bit quicker hopefully :)
>
> Since the implementation of discard-no-unref, we did not queue the discards correctly
> when discard-no-unref was enabled.
>
> Jean-Louis Dupond (2):
>    qcow2: rename update_refcount_discard to queue_discard
>    qcow2: put discards in discard queue when discard-no-unref is enabled
>
>   block/qcow2-cluster.c  | 16 ++++++----------
>   block/qcow2-refcount.c | 25 +++++++++++++++++++++----
>   block/qcow2.h          |  4 ++++
>   3 files changed, 31 insertions(+), 14 deletions(-)
>
This was already reviewed.
Reviewed-by: Eric Blake <eblake@redhat.com>

Any chance on getting this merged?

Thanks
Jean-Louis


