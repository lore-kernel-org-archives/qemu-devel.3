Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4FAAC43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 08:59:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whkaq-0006Hj-UV; Thu, 09 Jul 2026 04:58:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1whkaq-0006G8-6v
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 04:58:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1whkao-0000Gy-Gy
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 04:58:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783587529;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=5AppHoW/wuEssQgoMHQtlDDtcGDA7qoYxyMy4vjMKVo=;
 b=Enjks9wo84N/cnO/rqnsqZARa3Pe6jxgk786miHjDnX8PKRsui2yfZYuFUaHMP2EDuDtRp
 YUCr+DVRVMgFKjKhi41dcew+zyxQywW5sdRXd/Fg0q95lg9Z77PF5gEZBn4cM7AF9xHW/u
 Eq/h9qQd7mmsN8TSWwJENVRx3VIS9fI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-27-qPvZue4nPO-x7s7l5eltCA-1; Thu,
 09 Jul 2026 04:58:47 -0400
X-MC-Unique: qPvZue4nPO-x7s7l5eltCA-1
X-Mimecast-MFC-AGG-ID: qPvZue4nPO-x7s7l5eltCA_1783587526
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C34AE180065A; Thu,  9 Jul 2026 08:58:46 +0000 (UTC)
Received: from redhat.com (unknown [10.44.49.59])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E83B1180059F; Thu,  9 Jul 2026 08:58:44 +0000 (UTC)
Date: Thu, 9 Jul 2026 09:58:41 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Max Filippov <jcmvbkbc@gmail.com>, qemu-devel@nongnu.org,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: Re: [PATCH] tests/tcg: fix buffer overflow in
 multiarch/linux/linux-sigrtminmax
Message-ID: <ak9iwbtqYB_EcRCB@redhat.com>
References: <20260708150541.2137546-1-jcmvbkbc@gmail.com>
 <875x2oh786.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <875x2oh786.fsf@pond.sub.org>
User-Agent: Mutt/2.3.2 (2026-04-26)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Jul 09, 2026 at 10:56:09AM +0200, Markus Armbruster wrote:
> Max Filippov <jcmvbkbc@gmail.com> writes:
> 
> > Fix new_argv allocation size to be `(argc + 2) * sizeof(char *)` bytes,
> > which matches the way it's used to store `argc + 2` pointers.
> >
> > This fixes the test for me, which otherwise fails on xtensa with the
> > following message
> >
> >   linux-sigrtminmax.c: 59: main: Assertion `execve(new_argv[0], new_argv, environ) == 0' failed.'.
> >
> > Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
> > ---
> >  tests/tcg/multiarch/linux/linux-sigrtminmax.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tests/tcg/multiarch/linux/linux-sigrtminmax.c b/tests/tcg/multiarch/linux/linux-sigrtminmax.c
> > index a7059aacd9cb..b5ea65f3d393 100644
> > --- a/tests/tcg/multiarch/linux/linux-sigrtminmax.c
> > +++ b/tests/tcg/multiarch/linux/linux-sigrtminmax.c
> > @@ -39,7 +39,7 @@ int main(int argc, char **argv)
> >      assert(qemu);
> >  
> >      if (!getenv("QEMU_RTSIG_MAP")) {
> > -        char **new_argv = malloc((argc + 2) + sizeof(char *));
> > +        char **new_argv = malloc((argc + 2) * sizeof(char *));
> 
> If you can switch to glib's malloc, then g_new(argc + 2, sizeof(char *))
> is better.  Yes, @argc can't become big enough for the multiplication to
> overflow, but g_new() removes the need for reasoning.

The TCG unit tests don't link to GLib, only basic libc.

Fortunately unit tests have a trusted caller (the QEMU
meson build system), so we don't have to worry about
malicious usage with overflow in this context.

> 
> >          int tsig1, hsig1, count1, tsig2, hsig2, count2;
> >          char rt_sigmap[64];
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


