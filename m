Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54B07CCFA04
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 16:36:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGK18-0003Ey-VP; Tue, 04 Nov 2025 11:36:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vGK17-0003Eo-I3
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 11:36:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vGK15-000509-Az
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 11:36:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762274178;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jykdoySEJphhlJSQp6w9P1A+Gk+UpdqKeeQS/q5kz0c=;
 b=PVuv95CLf9PomLLXr/tXpyg+qXyY2jaKHS863nYG6cPIoqON1KIbsTv4fHq9tFt5Zd+CUS
 0yQMiBMwY6JgAfArxePre4HSd3TfAz6nIr9YoIBfUtMEymw0r11ZT/xJbKJgG/Y2b9MkMf
 ukhU60lASfg6Gm2T/CQcqlKMTuplStk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-330-n1Sxy-wuOJOjDjT85dMqTA-1; Tue,
 04 Nov 2025 11:36:15 -0500
X-MC-Unique: n1Sxy-wuOJOjDjT85dMqTA-1
X-Mimecast-MFC-AGG-ID: n1Sxy-wuOJOjDjT85dMqTA_1762274174
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EB96E19560AD; Tue,  4 Nov 2025 16:36:13 +0000 (UTC)
Received: from redhat.com (unknown [10.45.226.47])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3B0D2300019F; Tue,  4 Nov 2025 16:36:11 +0000 (UTC)
Date: Tue, 4 Nov 2025 17:36:09 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org
Subject: Re: [PATCH 0/2] iotests: Run iotests with sanitizers
Message-ID: <aQoreVO2hpaRCzt3@redhat.com>
References: <20251023-iotests-v1-0-fab143ca4c2f@rsg.ci.i.u-tokyo.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251023-iotests-v1-0-fab143ca4c2f@rsg.ci.i.u-tokyo.ac.jp>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.788,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Am 23.10.2025 um 10:10 hat Akihiko Odaki geschrieben:
> Commit 2cc4d1c5eab1 ("tests/check-block: Skip iotests when sanitizers
> are enabled") changed iotests to skip when sanitizers are enabled.
> The rationale is that AddressSanitizer emits warnings and reports leaks,
> which results in test breakage. Later, sanitizers that are enabled for
> production environments (safe-stack and cfi-icall) were exempted.
> 
> However, this approach has a few problems.
> 
> - It requires rebuild to disable sanitizers if the existing build has
>   them enabled.
> - It disables other useful non-production sanitizers.
> - The exemption of safe-stack and cfi-icall is not correctly
>   implemented, so qemu-iotests are incorrectly enabled whenever either
>   safe-stack or cfi-icall is enabled *and*, even if there is another
>   sanitizer like AddressSanitizer.
> 
> To solve these problems, direct AddressSanitizer warnings to separate
> files to avoid changing the test results, and selectively disable
> leak detection at runtime instead of requiring to disable all
> sanitizers at buildtime.
> 
> Enabling AddressSanitizer actually revealed a use-after-free so a patch
> to fix it is placed before one that enables iotests with sanitizers.
> 
> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

Thanks, applied to the block branch.

Kevin


