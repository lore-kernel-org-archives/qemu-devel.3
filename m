Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A565C25B75
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 12:29:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sD1MQ-0002Gw-GO; Fri, 31 May 2024 08:27:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sD1MO-0002GO-4I
 for qemu-devel@nongnu.org; Fri, 31 May 2024 08:27:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sD1MM-00006k-Bu
 for qemu-devel@nongnu.org; Fri, 31 May 2024 08:27:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717158467;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=KvDq3Au3Kpjfeb4vWCfk2Stn6m076IulG9nhrBnemb4=;
 b=Jp9fCu0aAKSn6rdgs2pb4P+e/9K5lXVkJQ81b0SWGGKigF23vE5e/0jrtUR3m2rCAFPWO8
 85lhCexOKtM9qa732GGF0lwidKb1+g37BasASgYe4qQef0m8LmNSYKSogvYFU8SNcVV4je
 XzhPT17oTWLR07tvN1abVMv955NyhZY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686--LwICvh6OjC1_yhHCDP70Q-1; Fri, 31 May 2024 08:27:43 -0400
X-MC-Unique: -LwICvh6OjC1_yhHCDP70Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 32BAC8008A4;
 Fri, 31 May 2024 12:27:43 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.216])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F11CC103A3B1;
 Fri, 31 May 2024 12:27:40 +0000 (UTC)
Date: Fri, 31 May 2024 13:27:38 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [RFC 0/6] scripts: Rewrite simpletrace printer in Rust
Message-ID: <ZlnCOrvpc2XGcxsh@redhat.com>
References: <20240527081421.2258624-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240527081421.2258624-1-zhao1.liu@intel.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.085,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, May 27, 2024 at 04:14:15PM +0800, Zhao Liu wrote:
> Hi maintainers and list,
> 
> This RFC series attempts to re-implement simpletrace.py with Rust, which
> is the 1st task of Paolo's GSoC 2024 proposal.
> 
> There are two motivations for this work:
> 1. This is an open chance to discuss how to integrate Rust into QEMU.

I don't think this proposal really triggers that discussion to any
great extent, because 'simpletrace.py' is not a part of the QEMU
codebase in any meaningul way. It is a standalone python script
that just happens to live in the qemu.git repository.

The difficult questions around Rust integration will arise when we
want to have Rust used to /replace/ some existing non-optional
functionality. IOW, if Rust were to become a mandatory dep of QEMU
that could not be avoided.

In fact I kinda wonder whether this Rust simpletrace code could
simply be its own git repo under gitlab.com/qemu-project/....,
rather than put into the monolithic QEMU repo ? That just makes
it a "normal" Rust project and no questions around integration
with QEMU's traditional build system would arise.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


