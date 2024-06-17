Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA247C2BA15
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 13:15:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJCC5-0005JU-DZ; Mon, 17 Jun 2024 09:14:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sJCC2-0005JG-8x
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 09:14:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sJCC0-0006cr-BO
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 09:14:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718630078;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=MRYCUGewdtJETCsAHD7caB1J0V7Rg1cDwaAL6tfgqzU=;
 b=Slka7zHDM5+gf4wuFh2CnDP5YQY0w2t4e3yhpZmLzcgHtyANLDKcuRBLkmtvmGLSGF8rvd
 6S/CYjyPr7ce03oyjSg2Ugvj4soPIZuBmQHhrRPHLwiI4OxtXVRyChcCi5M6ORcWICyyG9
 XRcO9Hclwx7j79Xwj93cJrPPa2+VbK4=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-317-qfEfo0hIPQW3nHDyGvPAeg-1; Mon,
 17 Jun 2024 09:14:33 -0400
X-MC-Unique: qfEfo0hIPQW3nHDyGvPAeg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 43AA8195608C; Mon, 17 Jun 2024 13:14:32 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.46])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A36ED1955F2D; Mon, 17 Jun 2024 13:14:26 +0000 (UTC)
Date: Mon, 17 Jun 2024 14:14:22 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Konstantin Kostiuk <kkostiuk@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, Dehan Meng <demeng@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Roth <michael.roth@amd.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Yan Vugenfirer <yvugenfi@redhat.com>
Subject: Re: Guest agent guest-exec memory usage
Message-ID: <ZnA2rrQ--1liaOH1@redhat.com>
References: <CAPMcbCpER8hvza6fO8D5Pt-8TN4fx8yP-YR0o8WSorOE44dmJw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPMcbCpER8hvza6fO8D5Pt-8TN4fx8yP-YR0o8WSorOE44dmJw@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.148,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Mon, Jun 17, 2024 at 04:05:07PM +0300, Konstantin Kostiuk wrote:
> Hi All,
> 
> During the investigation of a possible memory leak in the `guest-exec`
> command of guest-agent, I found unexpected behavior for me. When we execute
> the `guest-exec` command with `capture-output = true`, guest-agent stores
> stdout/stderr until someone calls `guest-exec-status`.
> 
> Just for testing, I executed the `man man` command 1000 times with
> `capture-output = true` and guest-agent allocated 36Mb to store the results
> and it fully depends on output size.
> 
> I want to ask your opinion about this behavior. Is this behavior expected
> or not? Should we store all output forever or should we limit it by memory
> size/execution time/execution count?

If 'guest-exec' is enabled in the agent, this says that the host OS users
of the guest-agent are inherently trusted. If they're issuing many guest-exec
commands with capture-output = true, and then batching up the calls to
guest-exec-status for a later time, that's their perogative and not any
worse than other things they can already do with 'guest-exec', such as
requesting a fork-bomb.

Or to put it another way, if the guest OS admin is worried about malicious
usage of 'guest-exec' they should block this command entirely.

One of the patches I have in this series:

  https://lists.nongnu.org/archive/html/qemu-devel/2024-06/threads.html

proposes blocking guest-exec by default in the agent, as it is an
inherantly risky command to expose.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


