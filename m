Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54FA9C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 12:50:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuWNI-0006gP-P2; Tue, 18 Mar 2025 08:48:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tuWIZ-0001Qi-SM
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 08:44:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tuWIK-00037a-3K
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 08:43:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742301821;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S6poyYNCz1bPRG6g5zrEOecDNsc6uknFCDXXprtzlkw=;
 b=f9ShL4Ow9TrdLAA1dp7y5dqDlwSlb/4XRLqJR98BsWDUSSAlPHn+Dy/Z1CH00ZmWlV/qUb
 WJB+la2O923wyEwliLhw/mn3LdMwQU7fktkUfFJPXf3Vi5Jmgd65YlA4ZdFTlG8tExKlRq
 Xg2L6WJfn8GP80bFiyrImaanxmh/WOI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-610-ixmgCToBPk6Cdf5OrAjlDw-1; Tue,
 18 Mar 2025 08:43:36 -0400
X-MC-Unique: ixmgCToBPk6Cdf5OrAjlDw-1
X-Mimecast-MFC-AGG-ID: ixmgCToBPk6Cdf5OrAjlDw_1742301815
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EE5D619560B6; Tue, 18 Mar 2025 12:43:34 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.167])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6606D19560AD; Tue, 18 Mar 2025 12:43:33 +0000 (UTC)
Date: Tue, 18 Mar 2025 12:43:29 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Andreas Schwab <schwab@suse.de>
Cc: Peter Maydell <peter.maydell@linaro.org>, Helge Deller <deller@gmx.de>,
 qemu-devel@nongnu.org
Subject: Re: Generic way to detect qemu linux-user emulation
Message-ID: <Z9lqcQGdIsjUHeVJ@redhat.com>
References: <mvm1puuiqvu.fsf@suse.de>
 <ff0cde0c-67d7-4fc3-8996-ad0e8645deed@gmx.de>
 <CAFEAcA_-fODgkxLLCNf3XHBU=EvGgKx4qcE_PqNt8-4jwqnqVw@mail.gmail.com>
 <Z9lf7lniMWzoy6uS@redhat.com> <mvmmsdih5zi.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <mvmmsdih5zi.fsf@suse.de>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Mar 18, 2025 at 01:34:57PM +0100, Andreas Schwab wrote:
> On Mär 18 2025, Daniel P. Berrangé wrote:
> 
> > Whereever practical, it is preferrable to check a discrete feature
> > or behaviour in a functional way, rather than matching on "is it QEMU"
> 
> Do you know a way to detect support for CLONE_VFORK that isn't too
> expensive?

No, but I feel like the right thing in this particular case is to look
at improving our vfork impl. The current impl is incredibly crude and
acknowledged by the original author

  commit 436d124b7d538b1fd9cf72edf17770664c309856
  Author: Andrzej Zaborowski <balrogg@gmail.com>
  Date:   Sun Sep 21 02:39:45 2008 +0000

    Band-aid vfork() emulation (Kirill Shutemov).

I can see why they did it that way, but I'm feeling like it ought to
be possible to do a better special case vfork impl ni QEMU instead of
overloading the fork() impl.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


