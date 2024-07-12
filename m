Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47A44C2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 12:53:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSFm9-0007lt-So; Fri, 12 Jul 2024 08:53:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sSFm5-0007SG-06; Fri, 12 Jul 2024 08:53:22 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sSFm1-0002gh-38; Fri, 12 Jul 2024 08:53:20 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c24:25b4:0:640:ef96:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id D73E860CF5;
 Fri, 12 Jul 2024 15:53:11 +0300 (MSK)
Received: from [IPV6:2a02:6b8:0:419:5fb9:9623:463f:792c] (unknown
 [2a02:6b8:0:419:5fb9:9623:463f:792c])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id ArffLC1RlCg0-UihECcsy; Fri, 12 Jul 2024 15:53:11 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1720788791;
 bh=YEBENZokF5uCti3jFa0VbVdu45pM53gBYaDy3qCIIbE=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=aAeDSSZ4YlXPAvFAFhVyTl2OY8vTXJPVP/O0ZNS+rBROY82DlNLtnYq202OE8n9mk
 UxbxaTPs4WxobgiSYfjNtGePNciV8nYMiw++n9JpNwz3vdSzkTx0mRhgECuNgcY1pq
 aRsrAp9n1Xl25Ncfet+9R16TR62CL8m/wz47BWVA=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <1487dfc8-8313-45de-a867-9ca29e63e9bc@yandex-team.ru>
Date: Fri, 12 Jul 2024 15:53:10 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] copy-before-write: allow specifying minimum
 cluster size
To: Fiona Ebner <f.ebner@proxmox.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, armbru@redhat.com, eblake@redhat.com,
 hreitz@redhat.com, kwolf@redhat.com, jsnow@redhat.com
References: <20240711120915.310243-1-f.ebner@proxmox.com>
 <20240711120915.310243-2-f.ebner@proxmox.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20240711120915.310243-2-f.ebner@proxmox.com>
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
> The type 'size' (corresponding to uint64_t in C) is used in QAPI to
> rule out negative inputs and for consistency with already existing
> @cluster-size parameters. Since block_copy_calculate_cluster_size()
> uses int64_t for its result, a check that the input is not too large
> is added in block_copy_state_new() before calling it. The calculation
> in block_copy_calculate_cluster_size() is done in the target int64_t
> type.
> 
> Suggested-by: Vladimir Sementsov-Ogievskiy<vsementsov@yandex-team.ru>
> Acked-by: Markus Armbruster<armbru@redhat.com>  (QAPI schema)
> Signed-off-by: Fiona Ebner<f.ebner@proxmox.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

-- 
Best regards,
Vladimir


