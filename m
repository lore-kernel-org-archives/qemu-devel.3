Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB6F4C83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Jul 2025 14:59:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugPJB-0005is-Qd; Mon, 28 Jul 2025 10:58:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ugPIj-0005PN-1W
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 10:58:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ugPIg-0005ae-JY
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 10:58:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753714681;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=dDmZnwTEBBCEtoZOgRZpkYwjeA5lJi2WnG2sTRdknlM=;
 b=LAsIoly3d95RJz+ynuBdlr01KVePDDqXIabArnD/TqQjMhdAmiFK0a360AD2KvT2E/uAaY
 wzIMe83189LJ58l91VEJFmDlINvDP6HdF3wT1QHxGNNvKmkw9YQscM5Ljz6XcF5Ca7mqOW
 JznHhISKHbsK8nwJ3c12NVgzNDiXwOQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-546-GtIQ1MGiMICk1RNA-fE16Q-1; Mon,
 28 Jul 2025 10:57:57 -0400
X-MC-Unique: GtIQ1MGiMICk1RNA-fE16Q-1
X-Mimecast-MFC-AGG-ID: GtIQ1MGiMICk1RNA-fE16Q_1753714677
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DFA671800256; Mon, 28 Jul 2025 14:57:56 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.32])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 756051800B69; Mon, 28 Jul 2025 14:57:55 +0000 (UTC)
Date: Mon, 28 Jul 2025 15:57:52 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Subject: Re: qos-test is annoyingly noisy
Message-ID: <aIeP8MvrITqNtnsF@redhat.com>
References: <87o6tbnfqx.fsf@pond.sub.org>
 <ed3009be-8707-4340-a8ee-2523f77fe861@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ed3009be-8707-4340-a8ee-2523f77fe861@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Jul 23, 2025 at 06:38:45PM +0200, Paolo Bonzini wrote:
> On 7/23/25 16:28, Markus Armbruster wrote:
> > Noise starting with "stdout: " has been polluting output of "make check"
> > for a while.  I traced it to qos-test.  Output of "make
> > check-qtest-aarch64" appended as an example.
> > 
> > Blessed silence if I revert commit 30ea13e9d97d (tests/qtest: use
> > qos_printf instead of g_test_message).
> > 
> > Alex, what shall we do here?
> 
> What is printing "stdout:", is it glib?  I think glib should be using
> g_test_message() to do those "stdout:" prints. But I agree a more practical
> alternative is a revert.

AFAICT, this is a bug in meson.

The test in question is running in a subprocess, and glib uses
nested TAP plans for the subprocess. These messages are all
TAP diagnositic lines from the nested plan, and meson is
incorrectly complaining about them.

> > 
> > stdout: 138: UNKNOWN:     # # qos_test running single test in subprocess

IIUC, the original text from glib nested plan was

  "     # # qos_test running single test in subprocess"

and meson adds the 'stdout: 128: UNKNOWN: ' prefix


> > Unknown TAP output lines have been ignored. Please open a feature request to
> > implement them, or prefix them with a # if they are not TAP syntax.

...they were already prefixed with '#', they just had some
whitespace before the '#' due to the nested plans.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


