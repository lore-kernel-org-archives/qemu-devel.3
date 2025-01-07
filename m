Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0587DE77198
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 14:27:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVAX8-0007US-6f; Tue, 07 Jan 2025 09:26:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tVAWv-0007Tp-I6
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 09:26:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tVAWt-0003zb-6y
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 09:26:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736259956;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IaFNB4MndI1vFWN202iri2tsIJpXyjy1kRLi0aCKHNA=;
 b=I5lGx8WpPWrou+lw0px2kTXEgmcH7mvEzIQt0hQ5cP0MoeCKc837XJAqCSA+q1JuYXtxLo
 URHDjz+RSaJc0FioZX6v0Vgho3j4Sf2+fENiNb+JEbiJBkEMBGH76AaiHYLbFu7pgHhOfb
 mUXkCEbhvD5yzx/H5mddrbLES70fnC0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-76-GVND92jSPIaHDgpu-p_m1Q-1; Tue,
 07 Jan 2025 09:25:55 -0500
X-MC-Unique: GVND92jSPIaHDgpu-p_m1Q-1
X-Mimecast-MFC-AGG-ID: GVND92jSPIaHDgpu-p_m1Q
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 289831955F42; Tue,  7 Jan 2025 14:25:54 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.194.101])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 976901956053; Tue,  7 Jan 2025 14:25:53 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2983521E6924; Tue, 07 Jan 2025 15:25:51 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Gustavo Romero <gustavo.romero@linaro.org>
Cc: qemu-devel@nongnu.org,  qemu-arm@nongnu.org,  philmd@linaro.org,
 alex.bennee@linaro.org,  thuth@redhat.com
Subject: Re: [RESEND][PATCH v3 0/7] Add ivshmem-flat device
In-Reply-To: <20241216141818.111255-1-gustavo.romero@linaro.org> (Gustavo
 Romero's message of "Mon, 16 Dec 2024 14:18:11 +0000")
References: <20241216141818.111255-1-gustavo.romero@linaro.org>
Date: Tue, 07 Jan 2025 15:25:51 +0100
Message-ID: <87r05e8zv4.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.437,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

Gustavo Romero <gustavo.romero@linaro.org> writes:

> This is a resend of the series:
>
> https://lore.kernel.org/qemu-devel/20240222222218.2261956-1-gustavo.romero@linaro.org/
>
> rebased on the current master. The series was sent about 9 months ago and
> remains relevant. Besides addressing the longstanding issue:
>
> https://gitlab.com/qemu-project/qemu/-/issues/1134
>
> it has generated interest in the community at least twice since its last
> version, from different contexts:
>
> https://lists.nongnu.org/archive/html/qemu-discuss/2024-05/msg00003.html
> https://lists.nongnu.org/archive/html/qemu-devel/2024-09/msg00374.html
>
> This suggests the series is being used out-of-tree in various contexts, such
> as experiments with heterogeneous architectures.
>
> But due to the fact it relies on sysbus, which is marked for future removal,
> some maintainers objected to accepting the patchset, causing it to be held in
> the ML.

Actually, I inquired about the use cases, and was told it's for OpenAMP.
I challenged the use of ivshmem for that purpose in some detail[*], but
got no reply.

>         However, given the ongoing community interest and since currently there
> isn't a better way on QEMU than using sysbus for the wiring needs of this
> device (e.g. to wire the device to a CPU IRQ input line), I'd kindly like to ask
> maintainers to reconsider its acceptance.



[*] https://lore.kernel.org/qemu-devel/87zfth4psf.fsf@pond.sub.org/

[...]


