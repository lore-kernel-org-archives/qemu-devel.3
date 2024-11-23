Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E389E6ADE8
	for <qemu-devel@archiver.kernel.org>; Sat, 23 Nov 2024 06:47:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEjv4-0001zW-1f; Sat, 23 Nov 2024 01:47:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tEjv1-0001yt-RI
 for qemu-devel@nongnu.org; Sat, 23 Nov 2024 01:46:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tEjuz-0003FE-MU
 for qemu-devel@nongnu.org; Sat, 23 Nov 2024 01:46:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732344414;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yVDVI/q8IFkPF+zWEYSf8AvSrN1MvyAY2NvSyFNvi50=;
 b=D1pZxeqSB39QSQ2CVRKpS0uMGb2Q66QSrvxgoTDkLdldS8hDfXawBmFx3ELa552UZzzlWg
 d44PFYEQqlyeKSbFRxgJusDqSv9gLtFnvecRiR/3B4YS7yEGGWnUAVzlXy7AjdfGclVYlU
 K6owRtkT31AyeK+u7+XTSe1+Z4erj0k=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-284-B_nY6QRWP-GPL7GkwbLUCg-1; Sat,
 23 Nov 2024 01:46:48 -0500
X-MC-Unique: B_nY6QRWP-GPL7GkwbLUCg-1
X-Mimecast-MFC-AGG-ID: B_nY6QRWP-GPL7GkwbLUCg
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 435BA195609E; Sat, 23 Nov 2024 06:46:44 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.194.102])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B76AE1955E9E; Sat, 23 Nov 2024 06:46:41 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8B93221E6828; Sat, 23 Nov 2024 07:46:39 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org,  peter.maydell@linaro.org,
 vsementsov@yandex-team.ru,  berrange@redhat.com,  stefanha@redhat.com,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] tests/avocado/hotplug_blk: Fix addr in device_add command
In-Reply-To: <20241122224042.149258-1-kwolf@redhat.com> (Kevin Wolf's message
 of "Fri, 22 Nov 2024 23:40:42 +0100")
References: <20241122224042.149258-1-kwolf@redhat.com>
Date: Sat, 23 Nov 2024 07:46:39 +0100
Message-ID: <87v7we1m7k.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Kevin Wolf <kwolf@redhat.com> writes:

> pci_devfn properties accept both integer and string values, but
> integer 1 and string '1' have different meanings: The integer value
> means device 0, function 1 whereas the string value '1' is short for
> '1.0' and means device 1, function 0.

This is a terrible interface.  Goes back to

commit 768a9ebe188bd0a6172a9a4e64777d21fff7f014
Author: Paolo Bonzini <pbonzini@redhat.com>
Date:   Thu Feb 9 09:53:32 2012 +0100

    qdev: accept both strings and integers for PCI addresses
    
    Visitors allow a limited form of polymorphism.  Exploit it to support
    setting the non-legacy PCI address property both as a DD.F string
    and as an 8-bit integer.
    
Less than clear.  Before the patch, only strings where accepted.
Afterwards, integers are accepted, too.

    The 8-bit integer form is just too clumsy, it is unlikely that we will
    ever drop it.

No idea what that means.
    
    Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

> This test wants the string version so that the device actually becomes
> visible for the guest. device_add hides the problem because it goes
> through QemuOpts, which turns all properties into strings - this is a
> QEMU bug that we want to fix, but that cancelled out the bug in this
> test.

The integer half of the terrible interface is inaccessible with
device_add.  This is fixable for QMP device_add: avoid the ill-advised
detour that turns all values into strings.

It will remain inaccessible with HMP device_add and -device with dotted
key arguments: scalar values can only be strings there.

> Fix the test first so that device_add can be fixed afterwards.

Your patch fixes a misuse of the terrible interface.

> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  tests/avocado/hotplug_blk.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tests/avocado/hotplug_blk.py b/tests/avocado/hotplug_blk.py
> index d55ded1c1d..b36bca02ec 100644
> --- a/tests/avocado/hotplug_blk.py
> +++ b/tests/avocado/hotplug_blk.py
> @@ -33,7 +33,7 @@ def plug(self) -> None:
>              'drive': 'disk',
>              'id': 'virtio-disk0',
>              'bus': 'pci.1',
> -            'addr': 1
> +            'addr': '1',
>          }
>  
>          self.assert_no_vda()

Reviewed-by: Markus Armbruster <armbru@redhat.com>


