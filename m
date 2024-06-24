Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E496C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 11:11:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLhaz-0003iB-TK; Mon, 24 Jun 2024 07:10:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sLhZh-0003NI-EO
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 07:09:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sLhZb-00031p-H4
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 07:09:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719227362;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=X+wpPDWiupIMePohwuNeaZEIGD+FPYjpxxftpXhHSK4=;
 b=iD+xbZNSbu96bCfowAulQ17drWnhcKB374oIwAYYx7qU7//hPHMvMlPT5ANKBmdGTWE0Qs
 kU4bBOjdRwovGbqfr5xFnsTUk2b8VVq73IuFGDRoCOk6ASKBVlqB8HBF9s7/hc/ztzCfDl
 pvUM2JoomWMCglmjKSYOFHs2HopVk4w=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-617-BDToK7w6N9m7ULA7uOJPQg-1; Mon,
 24 Jun 2024 07:09:18 -0400
X-MC-Unique: BDToK7w6N9m7ULA7uOJPQg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F026619560B7; Mon, 24 Jun 2024 11:09:16 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.226])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E115E19560AD; Mon, 24 Jun 2024 11:09:13 +0000 (UTC)
Date: Mon, 24 Jun 2024 12:09:10 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>,
 Phil =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: command line syntax for connecting a chardev to a CPU
Message-ID: <ZnlT1rya2dSm1y5O@redhat.com>
References: <CAFEAcA94twaBSx--NVXQcRBQ7v9TuK9iTq9kTWP4FYpRzgPbBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA94twaBSx--NVXQcRBQ7v9TuK9iTq9kTWP4FYpRzgPbBA@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.149,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SBL_CSS=3.335, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

On Fri, Jun 21, 2024 at 06:43:57PM +0100, Peter Maydell wrote:
> Arm CPUs have a "debug communications channel" which on real hardware
> is basically a way to talk to the debugger on the other end of a JTAG
> connection; Linux supports using this as a console. This patchseries:
>  https://patchew.org/QEMU/20240614093026.328271-1-sai.pavan.boddu@amd.com/
> proposes implementing this in QEMU by wiring it up to a QEMU chardev.
> 
> I think this is useful (among other things, it lets the user sidestep
> the "where is my UART?" question). But I'm not sure what the right way
> to let the user enable it and pick the chardev on the command line is.
> Do we have any relevant existing precedent?
> 
> The patchseries has the CPU look for a chardev by ID, so if the user
> creates a chardev with id=dcc0 the first CPU will use that, if there's
> a chardev with id=dcc1 the second CPU will use that, and so on. I
> don't think we really want to make some ID string values be magic,
> but maybe we do that already somewhere, and so it's OK to do here?
> 
> I thought also of having the CPU take a chardev property, but then the
> question is how to specify that on the command line. AFAICT the -cpu
> option (a) requires a CPU type first, which is a pain for cases where
> otherwise the user has no need to care about the exact type of CPU
> because the machine model creates the right one for them, and (b) for
> the key=value properties in a -cpu option string it will set the same
> property value for every CPU in the system (which obviously isn't what
> we want for this chardev).
> 
> We could make it a machine property (so you would say eg
>  -M xlnx-zcu102,dcc0=mychardev -chardev stdio,id=mychardev)
> but then that would require plumbing code in every machine model to
> create the property and set the value on the right CPU.
> 
> Do we have a neat way to specify per-cpu CPU properties that I'm missing?


Partially relevant context is that on x86 we have the "isa-debugcon"
device, that effectively just creates a output only serial port
for firmware to use for debugging. That's an actual device though.

The problem with CPUs is that we don't have a -device <cpu-type>
for each CPU that's created, instead -cpu creates the devices
implicitly.

This might suggest using an object type instead, eg

  -object arm-ddc,cpu=0,chardev=cdev0
  -chardev pty,id=cdev0
  -object arm-ddc,cpu=1,chardev=cdev1
  -chardev pty,id=cdev2
  -object arm-ddc,cpu=2,chardev=cdev2
  -chardev pty,id=cdev2
  -object arm-ddc,cpu=3,chardev=cdev3
  -chardev pty,id=cdev3

And the CPU impl would just have to access some internal global API
from the 'arm-ddc' object type, to find its chardev, if any.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


