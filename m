Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C4F9C7EE2A
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Jun 2025 07:08:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTxkf-00013c-0Y; Tue, 24 Jun 2025 03:07:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1uTxkd-000128-Jg
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 03:07:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1uTxkb-00018m-Fz
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 03:07:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750748841;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iyI6VxsX3m+C1CJm9Dqdm8u1xvtdFED9m5ykMjVXMsM=;
 b=dAFw7TS+lCXMQJlikQ3uPoMgDe7rEtO6/rRYgRSN/WDg1VL3iN8Yg77acJ5QFyqV3TVXtq
 7gZj+AFq0J0u+saw177fR4PLSxI7Q12Omt4ssfjzNdv11kkag2GC0HJkGmRVD5bEn0DNO4
 Catijk6DY8aP0ambaXYzx/P0ZXh4KJ4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-656-I2h0sklCNLmjwAYzrHq-SA-1; Tue,
 24 Jun 2025 03:07:17 -0400
X-MC-Unique: I2h0sklCNLmjwAYzrHq-SA-1
X-Mimecast-MFC-AGG-ID: I2h0sklCNLmjwAYzrHq-SA_1750748836
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 04FF21800289; Tue, 24 Jun 2025 07:07:16 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.45.226.80])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6BB9D195608D; Tue, 24 Jun 2025 07:07:14 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 0810218000BA; Tue, 24 Jun 2025 09:07:12 +0200 (CEST)
Date: Tue, 24 Jun 2025 09:07:11 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org, 
 mst@redhat.com, anisinha@redhat.com, elena.ufimtseva@oracle.com, 
 jag.raman@oracle.com, pbonzini@redhat.com, david@redhat.com, philmd@linaro.org
Subject: Re: [PATCH 1/3] memory: reintroduce BQL-free fine-grained PIO/MMIO
Message-ID: <uyuhe6pvmqtkb3ruywgsvwc3hh4hu27c454an4avme6xxfrls4@fwoathup2su4>
References: <20250620151418.1166195-1-imammedo@redhat.com>
 <20250620151418.1166195-2-imammedo@redhat.com>
 <aFWR8rM7-4y1R0GG@x1.local> <20250623145146.4462bf59@fedora>
 <aFlYRWc7rRwBGM8S@x1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aFlYRWc7rRwBGM8S@x1.local>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

  Hi,

> Gerd mentioned this in the relevant bz:
> 
>         Note: root cause for the initrd issue noted in comment 5 is seabios
>         running into problems with ehci -> io errors -> corrupted initrd.
>         Sometimes it doesn't boot at all, probably in case the io errors
>         happen to hit the kernel not the initrd.
> 
> This seems to be the last piece of information we have had that is closest
> to the root cause.

seabios used to prefer pmtimer back then for timekeeping then because it
has a fixed frequency.  Doing tsc calibration can easily be /way/ off in
a virtual machine on a loaded host.

Meanwhile seabios got support for reading the tsc frequency via cpuid
(if invtsc is available) or via kvmclock.  If that works seabios will
prefer the tsc for timekeeping.

So, when trying to reproduce the failure for analysis you have to either
use an old seabios version, or turn off kvmclock + invtsc support,
otherwise seabios will not use the pmtimer in the first place.

You should have this line in the firmware log:

    Using pmtimer, ioport 0x608

HTH & take care,
  Gerd


