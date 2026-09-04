Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DE43C79F81
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 05:46:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2MkB-0007ke-Gp; Fri, 04 Sep 2026 01:45:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ghoffman@redhat.com>)
 id 1x2Mk9-0007k3-8P
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 01:45:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ghoffman@redhat.com>)
 id 1x2Mk7-0004Bm-Q6
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 01:45:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788500738;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nTotYGPu90JhCnYNifYML+HWUdaK6vkzUYREYlvxQ5M=;
 b=Vvqr50890suga2QbxopBPe2w6mtda2etkZWK5UaMD8rm6Zn6k25sXb6VY5zRfeuR2dsFAM
 Vex5Q88bzBJOOfIA3fS+hogTbFvzhhBaSM5FtjTuFlWzgQPxGH1TnR3iVP0fC6ik8d4BQL
 EhuE5DLtPz4vkGJnhj3vjftKdj3oIxE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-687-zW7PY-abNOWSJpRh2eTr8g-1; Fri,
 04 Sep 2026 01:45:34 -0400
X-MC-Unique: zW7PY-abNOWSJpRh2eTr8g-1
X-Mimecast-MFC-AGG-ID: zW7PY-abNOWSJpRh2eTr8g_1788500733
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 42E451954227; Fri,  4 Sep 2026 05:45:33 +0000 (UTC)
Received: from ghoffman.nuc.csb.home.kraxel.org
 (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9401D1800598; Fri,  4 Sep 2026 05:45:32 +0000 (UTC)
Received: by ghoffman.nuc.csb.home.kraxel.org (Postfix, from userid 11758)
 id 692B34006269; Fri, 04 Sep 2026 07:45:29 +0200 (CEST)
Date: Fri, 4 Sep 2026 07:45:29 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Luigi Leonardi <leonardi@redhat.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>, 
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, 
 qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, 
 Zhao Liu <zhao1.liu@intel.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 kvm@vger.kernel.org
Subject: Re: [PATCH 4/4] igvm/sev: forward the IGVM guest policy to the
 platform before launch
Message-ID: <appYz1617QTPH-Qf@ghoffman-na.rmtde.csb>
References: <20260901-fix_igvm_policy-v1-0-e93a6cf8c5ac@redhat.com>
 <20260901-fix_igvm_policy-v1-4-e93a6cf8c5ac@redhat.com>
 <16C1B63D-7E80-49DF-83AC-47769A6D9AE8@redhat.com>
 <apk1djopa9z3tfYR@leonardi-redhat>
 <CEF80B59-E81A-4B97-87E5-9087FAF3680B@redhat.com>
 <aplQKjieyMHUoCWs@leonardi-redhat> <aplfB4L_WoFdpeBD@redhat.com>
 <aplz6Wvb-IhgUJ59@sgarzare-redhat>
 <apl3wnsHORCNP4k-@leonardi-redhat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <apl3wnsHORCNP4k-@leonardi-redhat>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ghoffman@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
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

  Hi,

> > > If the user choose to override policy on the CLI, isn't it now just
> > > their problem to also figure out what the new expected measurement
> > > will be ?
> > > 
> > > Why wouldn't we just honour the IGVM by default, and if the CLI
> > > has further customizations let them override the IGVM, and leave
> > > the user to figure out the implications.
> > 
> > I also slightly prefer this behaviour too, I see some advantages,
> > especially for testing and debugging, where you don't want to regenerate
> > the IGVM. But I don't have a strong opinion on this; if there is a
> > mismatch, though, I agree that it's better to get an error than to
> > ignore the CLI.
> 
> In this series, if there is a mismatch between IGVM and CLI, QEMU returns an error.
> Debugging sounds very reasonable to me, so I'm fine on letting the CLI override IGVM.

qemu should flag this mismatch in any case.  Either throw an error and
exit, or log a warning and continue.  Given that changing the policy
changes the launch measurement I'd tend to prefer an error.  If people
see value and real use cases for policy overrides I'm fine with a
warning too.

Silently accepting the override is IMHO not an option.  We had enough
problems with qemu silently doing things not expected by users in the
past.

take care,
  Gerd


