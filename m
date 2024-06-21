Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B4A7C27C4F
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 10:46:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKbm1-0006py-1D; Fri, 21 Jun 2024 06:45:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thomas@t-8ch.de>) id 1sKblz-0006pi-LP
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 06:45:39 -0400
Received: from todd.t-8ch.de ([159.69.126.157])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thomas@t-8ch.de>) id 1sKblw-0004QS-N8
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 06:45:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
 t=1718966730; bh=HAOg6CcvIbtWrST0s7daJ2upj71SoAy3nNYChBzVssY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=S/67yKenKThw2jqYinx+evK6yK5PsvxKTvKD60miRaRh7sg1iaNAWY296XwUofc9r
 aiP9sZ2MDEpNR21cBLaJPxdYMX1lD4ZvDd4BC6GR/HRdc8gxWURwh5CWiCuH/TpM3m
 NAeks98RF0+qnxvv6cuvFWs9gsAtNxGlgPKesg/Q=
Date: Fri, 21 Jun 2024 12:45:29 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org, 
 Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, kvm@vger.kernel.org
Subject: Re: [PATCH v8 3/8] hw/misc/pvpanic: centralize definition of
 supported events
Message-ID: <4873c62a-7d23-4c03-bfde-5f6c00e10aaa@t-8ch.de>
References: <20240527-pvpanic-shutdown-v8-0-5a28ec02558b@t-8ch.de>
 <20240527-pvpanic-shutdown-v8-3-5a28ec02558b@t-8ch.de>
 <20240621062512-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240621062512-mutt-send-email-mst@kernel.org>
Received-SPF: pass client-ip=159.69.126.157; envelope-from=thomas@t-8ch.de;
 helo=todd.t-8ch.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2024-06-21 06:26:19+0000, Michael S. Tsirkin wrote:
> On Mon, May 27, 2024 at 08:27:49AM +0200, Thomas Weißschuh wrote:

<snip>

> > diff --git a/hw/misc/pvpanic.c b/hw/misc/pvpanic.c
> > index 1540e9091a45..a4982cc5928e 100644
> > --- a/hw/misc/pvpanic.c
> > +++ b/hw/misc/pvpanic.c
> > @@ -21,13 +21,12 @@
> >  #include "hw/qdev-properties.h"
> >  #include "hw/misc/pvpanic.h"
> >  #include "qom/object.h"
> > -#include "standard-headers/linux/pvpanic.h"
> 
> 
> This part is wrong. PVPANIC_PANICKED and PVPANIC_CRASH_LOADED
> are still used in pvpanic.c directly, so we should
> include standard-headers/linux/pvpanic.h to avoid depending
> on which header includes which.

Ack.

> I fixed up the patch.

Thanks!

<snip>


Thomas

