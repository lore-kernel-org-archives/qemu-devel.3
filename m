Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E2F1CD484E
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 20:01:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMWo5-0005Ce-NM; Mon, 11 May 2026 16:00:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wMWo0-0005CA-Sk
 for qemu-devel@nongnu.org; Mon, 11 May 2026 16:00:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wMWny-0004Iy-Mo
 for qemu-devel@nongnu.org; Mon, 11 May 2026 16:00:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778529640;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dSwlvLMU5EovEkbHnz7yRFdFWCfRyA02CiP3rYAgdCQ=;
 b=GbF1T0C9e7SI5aU6fG/fl8Phi8MCcymckiqQknF7dhCOlhebzLsz6zgmz5S58UXaJxnK/3
 pMH36J44MbL8rZmuIxY5E5ZvnvEpx9I7WiDcHfBRDaIzWvFYZT69U7QfIa4eQYNFlyHNTS
 QT6jlS2ubJb6MVgNfKHsb1Po4mmGQlc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-632-2MYT9pgUOwaTG-6zoe3pjg-1; Mon,
 11 May 2026 16:00:38 -0400
X-MC-Unique: 2MYT9pgUOwaTG-6zoe3pjg-1
X-Mimecast-MFC-AGG-ID: 2MYT9pgUOwaTG-6zoe3pjg_1778529636
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C0D05195609F; Mon, 11 May 2026 20:00:35 +0000 (UTC)
Received: from localhost (unknown [10.2.16.172])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2097F19560A6; Mon, 11 May 2026 20:00:34 +0000 (UTC)
From: stefanha@redhat.com
To: arei.gonglei@huawei.com
Cc: berrange@redhat.com, buzzy0257@gmail.com, mcascell@redhat.com,
 qemu-devel@nongnu.org, qemu-stable@nongnu.org, zhenwei.pi@linux.dev
Subject: Re: [PULL 0/1] cryptodev CVE fix
Date: Mon, 11 May 2026 16:00:33 -0400
Message-ID: <20260511200033.587769-1-stefanha@redhat.com>
In-Reply-To: <20260511141947.267-2-arei.gonglei@huawei.com>
References: <20260511141947.267-2-arei.gonglei@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 0
X-Spam_score: -0.0
X-Spam_bar: /
X-Spam_report: (-0.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SORTED_RECIPS=2.499, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Please make the following adjustments for future pull requests:

1. Set a public https:// URL for your branch

> are available in the Git repository at:
>
>  git@github.com:gongleiarei/qemu.git tags/cryptodev-2026-05-11

This is not a public URL that I can pull from. You can adjust your .git/config
as follows to use a separate pull request URL and push URL:

  [remote "github"]
        url = https://github.com/gongleiarei/qemu
        pushUrl = git@github.com:gongleiarei/qemu.git

This will allow the scripts that we use for QEMU pull request handling to merge
your pull request without manual steps.

2. Pull requests must be signed with your GPG key

If you don't already have a GPG key, create one and push it to the keyservers.
Then sign your pull request emails. This adds extra protection should someone
manage to spoof your email or compromise your email account. All QEMU pull
requests must be signed.

Two issues with this patch:

1.
>    qemu_mutex_destroy(&lkcf->mutex);
>    qemu_cond_destroy(&lkcf->cond);
>    qemu_mutex_destroy(&lkcf->rsp_mutex);
>
>    for (i = 0; i < MAX_SESSIONS; i++) {
>        if (lkcf->sess[i] != NULL) {
>            cryptodev_lkcf_close_session(backend, i, 0, NULL, NULL);

The mutex is already destroyed, so it is not possible to call
cryptodev_lkcf_close_session() here.

2. cryptodev_lkcf_cleanup() hangs if called right after tasks are queued.
in_use has already been incremented but cryptodev_lkcf_cleanup() frees the
tasks without decrementing in_use. cryptodev_lkcf_close_session() will hang.

Stefan


