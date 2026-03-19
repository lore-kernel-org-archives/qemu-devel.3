Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFDA9108E1EC
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 11:21:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3BQU-0007nU-HU; Thu, 19 Mar 2026 07:20:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w3BQR-0007ls-9f
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 07:20:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w3BQN-0005nf-Ts
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 07:20:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773919221;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Z3LCxgyFo0bzjru08OdGjin0hQE9Ce/IR6a1VQcoVHc=;
 b=HQPzRgA2h2L83VfG0UopgcXCXdkFWj5iV4siiN7xbZawoBdIqQSBCiQ4SfnQv8Dv5VqknL
 zuuiaTuy0JebRl9kBMtoDriJ/rVy7TtnclXs88B8mCCAr45xKqN9oQMC49pj7Ri20iMBmh
 WaLvn3kxwU0y9gVE7/1a2RvTAry1NJk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-399-dYbhEiGgMHyE3jHtWZoM_w-1; Thu,
 19 Mar 2026 07:20:18 -0400
X-MC-Unique: dYbhEiGgMHyE3jHtWZoM_w-1
X-Mimecast-MFC-AGG-ID: dYbhEiGgMHyE3jHtWZoM_w_1773919217
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 763E41800371; Thu, 19 Mar 2026 11:20:16 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8B2051955F21; Thu, 19 Mar 2026 11:20:15 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E871321E6937; Thu, 19 Mar 2026 12:20:12 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: =?utf-8?Q?Herv=C3=A9?= Poussineau <hpoussin@reactos.org>,
 qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org,  qemu-trivial@nongnu.org,  BALATON Zoltan
 <balaton@eik.bme.hu>
Subject: Re: [PATCH] hw/pci-host/raven: Fix crash when introspecting
 raven-pcihost from the CLI
In-Reply-To: <20260317074049.436460-1-thuth@redhat.com> (Thomas Huth's message
 of "Tue, 17 Mar 2026 08:40:49 +0100")
References: <20260317074049.436460-1-thuth@redhat.com>
Date: Thu, 19 Mar 2026 12:20:12 +0100
Message-ID: <87eclgawwj.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Thomas Huth <thuth@redhat.com> writes:

> From: Thomas Huth <thuth@redhat.com>
>
> QEMU currently crashes when introspecting raven-pcihost from the command
> line interface:
>
>  $ ./qemu-system-ppc -device raven-pcihost,help
>  Segmentation fault (core dumped)
>
> This happens because the raven_pcihost_initfn instance init function
> calls get_system_memory(), but that is not available here yet.
>
> There does not seem to be a compelling reason for initializing the
> memory regions from the instance init function, so let's simply move
> the code into the realize() function instead to fix this issue.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Tested-by: Markus Armbruster <armbru@redhat.com>


