Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50262C27C5E
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2024 08:35:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGaUv-0004lD-Mm; Mon, 10 Jun 2024 04:35:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sGaUu-0004kn-I8
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 04:35:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sGaUt-0003O3-0E
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 04:35:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718008522;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qB6bTwdwYhH8KKkzEGKYedji7aN4XB7gVBhUcpnOdlo=;
 b=cXm4F5rp3whhfC0hdsRSly1TkEoX74dRSkr8OVfSe3pz1aPwvsYaB89y12v52/REkpogA5
 JVFEYZIwvwmZlH+7R3FWmDkImfmgstCRA2x8SJ6KRkqYo1Psz0cqZJizQtnAIflLr8mgns
 z2gRLebupOEdP1FLzM3+VGhS/oMzgug=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-onwNnjWdPpagxdmF0iK-5A-1; Mon, 10 Jun 2024 04:35:18 -0400
X-MC-Unique: onwNnjWdPpagxdmF0iK-5A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6CC3180027F;
 Mon, 10 Jun 2024 08:35:17 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D6119C158D0;
 Mon, 10 Jun 2024 08:35:13 +0000 (UTC)
Date: Mon, 10 Jun 2024 09:35:11 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 David Gibson <david@gibson.dropbear.id.au>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Eric Blake <eblake@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 Nicholas Piggin <npiggin@gmail.com>, Don Porter <porter@cs.unc.edu>,
 =?utf-8?B?RnLDqWTDqXJpYw==?= Barrat <fbarrat@linux.ibm.com>,
 qemu-ppc@nongnu.org, Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH 2/2] hw/intc: Introduce x-query-interrupt-controllers QMP
 command
Message-ID: <Zma6vxzcINmSO0Z8@redhat.com>
References: <20240610063518.50680-1-philmd@linaro.org>
 <20240610063518.50680-3-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240610063518.50680-3-philmd@linaro.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Jun 10, 2024 at 08:35:17AM +0200, Philippe Mathieu-Daudé wrote:
> This is a counterpart to the HMP "info pic" command. It is being
> added with an "x-" prefix because this QMP command is intended as an
> adhoc debugging tool and will thus not be modelled in QAPI as fully
> structured data, nor will it have long term guaranteed stability.
> The existing HMP command is rewritten to call the QMP command.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  qapi/machine.json          | 17 +++++++++++++++++
>  hw/core/machine-qmp-cmds.c | 29 +++++++++++++++++++++++++++++
>  monitor/hmp-cmds.c         | 33 ---------------------------------
>  hmp-commands-info.hx       |  2 +-
>  4 files changed, 47 insertions(+), 34 deletions(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


