Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 018A3CCD195
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Oct 2025 20:25:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAZyJ-00017Y-KY; Sun, 19 Oct 2025 16:25:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vAZyB-00015m-VP
 for qemu-devel@nongnu.org; Sun, 19 Oct 2025 16:25:36 -0400
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vAZy9-00064R-1o
 for qemu-devel@nongnu.org; Sun, 19 Oct 2025 16:25:35 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1760905519; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=n6cWHhANbcrNd7JnMkkiIwjSNWKU+YgXVYkuhD/p/3QCOIgYDdNTuk7EzLfLIKzlbcEwHWkkQbQgWDS+kxEXQ09um7ZJs2mjwsZ7jM1qijUQNqaYVc+OhOGpK3sxS1mnhGeMbYvLWDPKYEBn6rmpHorqsFxC5is8VxwIGQtk5kg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1760905519;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=fLiT1NxtvdKU37aH7cuenFLdwij5SJpTxpCNW7bHH2s=; 
 b=mb97gb9PtROXl9ord5mC4LruSRlcu5FJ/lpRUnPkNyLXBDiQklA3NH8nmOhPHWnazIOtRr5XX37HFbwTz2Hi8RmFtHDR892uIK984hovn8l5antEc8AE8dGNKV1Gq1zjEhQSOUhhzQQwCRrhOLgwuzW6kjiCEjYQAdAJVy2VfaA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1760905519; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=fLiT1NxtvdKU37aH7cuenFLdwij5SJpTxpCNW7bHH2s=;
 b=JtatCWts3ELivjQdKR4KQMtCswsJw/z6nCtxq3eCk6ikYUmOAW7MToTPFuu7zUlL
 YXVSAuRn9RKJvaVjNjnEcYo9Gopyg9Svdabn8nhHO1SgL72Iz0TM+bEChMPtivCv1ER
 fH5FabxX26ww/rtjedE+9xcfLy8nDGswpFKUslL0=
Received: by mx.zohomail.com with SMTPS id 1760905518702238.90821450906424;
 Sun, 19 Oct 2025 13:25:18 -0700 (PDT)
Message-ID: <91a97184-94c8-4b55-99a6-05a0dc4142b1@collabora.com>
Date: Sun, 19 Oct 2025 23:25:14 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rcu: Unify force quiescent state
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand
 <david@redhat.com>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Peter Xu <peterx@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
References: <20251016-force-v1-1-919a82112498@rsg.ci.i.u-tokyo.ac.jp>
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Language: en-US
In-Reply-To: <20251016-force-v1-1-919a82112498@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.112;
 envelope-from=dmitry.osipenko@collabora.com; helo=sender4-pp-f112.zoho.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 10/16/25 09:34, Akihiko Odaki wrote:
> Borrow the concept of force quiescent state from Linux to ensure readers
> remain fast during normal operation and to avoid stalls.
> 
> Background
> ==========
> 
> The previous implementation had four steps to begin reclamation.
> 
> 1. call_rcu_thread() would wait for the first callback.
> 
> 2. call_rcu_thread() would periodically poll until a decent number of
>    callbacks piled up or it timed out.
> 
> 3. synchronize_rcu() would statr a grace period (GP).
> 
> 4. wait_for_readers() would wait for the GP to end. It would also
>    trigger the force_rcu notifier to break busy loops in a read-side
>    critical section if drain_call_rcu() had been called.
> 
> Problem
> =======
> 
> The separation of waiting logic across these steps led to suboptimal
> behavior:
> 
> The GP was delayed until call_rcu_thread() stops polling.
> 
> force_rcu was not consistently triggered when call_rcu_thread() detected
> a high number of pending callbacks or a timeout. This inconsistency
> sometimes led to stalls, as reported in a virtio-gpu issue where memory
> unmapping was blocked[1].
> 
> wait_for_readers() imposed unnecessary overhead in non-urgent cases by
> unconditionally executing qatomic_set(&index->waiting, true) and
> qemu_event_reset(&rcu_gp_event), which are necessary only for expedited
> synchronization.
> 
> Solution
> ========
> 
> Move the polling in call_rcu_thread() to wait_for_readers() to prevent
> the delay of the GP. Additionally, reorganize wait_for_readers() to
> distinguish between two states:
> 
> Normal State: it relies exclusively on periodic polling to detect
> the end of the GP and maintains the read-side fast path.
> 
> Force Quiescent State: Whenever expediting synchronization, it always
> triggers force_rcu and executes both qatomic_set(&index->waiting, true)
> and qemu_event_reset(&rcu_gp_event). This avoids stalls while confining
> the read-side overhead to this state.
> 
> This unified approach, inspired by the Linux RCU, ensures consistent and
> efficient RCU grace period handling and confirms resolution of the
> virtio-gpu issue.
> 
> [1] https://lore.kernel.org/qemu-devel/20251014111234.3190346-9-alex.bennee@linaro.org/
> 
> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> ---
>  util/rcu.c | 79 ++++++++++++++++++++++++++++++++++++++++----------------------
>  1 file changed, 51 insertions(+), 28 deletions(-)

Tested-by: Dmitry Osipenko <dmitry.osipenko@collabora.com> # drm native
contexts + venus


-- 
Best regards,
Dmitry

