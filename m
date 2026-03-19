Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7F96108E1E9
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 11:22:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3BSC-0002ke-Lt; Thu, 19 Mar 2026 07:22:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w3BRo-0002LT-1b
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 07:21:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w3BRm-000884-II
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 07:21:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773919309;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=v5n2rzLTJOT6jhhqr0oksgbKEDds3CCeNC7nR8BZLR8=;
 b=TkvVt6PLD+Rw7rMvedga6xVFdkhhDeEl/fP9uACVJSW6HzZw4c4zHTGP7pDD7sR/gW7Io0
 FuaP14qu3056W3LQbQ1Q/Ppb82yMQT5Wzh3mfGVnoLMVsVPPcY5fWCYb74DqQrL9eV80az
 o4FJW+0/gvU5SKacjR7YNnZIZIl9frM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-474-BAJQ4RMINe6DP5GCszuPKA-1; Thu,
 19 Mar 2026 07:21:46 -0400
X-MC-Unique: BAJQ4RMINe6DP5GCszuPKA-1
X-Mimecast-MFC-AGG-ID: BAJQ4RMINe6DP5GCszuPKA_1773919305
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6D31B180034F; Thu, 19 Mar 2026 11:21:45 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 166251800107; Thu, 19 Mar 2026 11:21:45 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B72A421E6937; Thu, 19 Mar 2026 12:21:42 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 qemu-devel@nongnu.org,  qemu-trivial@nongnu.org,  Markus Armbruster
 <armbru@redhat.com>,  Artyom Tarasenko <atar4qemu@gmail.com>
Subject: Re: [PATCH] hw/sparc64/sun4u_iommu: Fix crash when introspecting
 sun4u-iommu from the CLI
In-Reply-To: <20260317085839.445178-1-thuth@redhat.com> (Thomas Huth's message
 of "Tue, 17 Mar 2026 09:58:39 +0100")
References: <20260317085839.445178-1-thuth@redhat.com>
Date: Thu, 19 Mar 2026 12:21:42 +0100
Message-ID: <871phgawu1.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
> QEMU currently crashes when introspecting the sun4u-iommu device from the
> command line interface:
>
>  $ ./qemu-system-sparc64 -display none -device sun4u-iommu,help
>  qemu-system-sparc64: ../../devel/qemu/system/physmem.c:1401:
>   register_multipage: Assertion `num_pages' failed.
>  Aborted (core dumped)
>
> There does not seem to be a compelling reason for initializing the
> memory regions from the instance_init function, so let's simply move
> the code into a realize() function instead to fix this issue.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reported-by: Markus Armbruster <armbru@redhat.com>
Tested-by: Markus Armbruster <armbru@redhat.com>


