Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA07DC54F61
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 14:40:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmadB-0000uY-CY; Tue, 19 Mar 2024 10:39:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rmad8-0000u1-QQ
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 10:39:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rmad6-0001iU-Vl
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 10:39:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710859192;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P8fui8DKb2PbdlfbAsPH76xrkRsbFKCrzW6uuxI81us=;
 b=M2FkYbYd9JXtDshR84PRHef0ilAdNM32zupB4rnyj/MzNgRtKWBQWTyJUakPYE62ZbapBs
 REzdzx6ehfR/mdR7Gu6UjJ506PHd18H1faK98CFde7m9oKUocf5gRDUbZjokIyGY9y7uEk
 DSTdlgPRbXDX+bjkUBQ/UmTUs9tktK8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-161-M9051_TgOyKHZ4OYbX2Uww-1; Tue, 19 Mar 2024 10:39:49 -0400
X-MC-Unique: M9051_TgOyKHZ4OYbX2Uww-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D84E018813D2;
 Tue, 19 Mar 2024 14:39:48 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.88])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3E07F492BF0;
 Tue, 19 Mar 2024 14:39:48 +0000 (UTC)
Date: Tue, 19 Mar 2024 14:39:42 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, xiaoyao.li@intel.com, michael.roth@amd.com
Subject: Re: [PATCH 6/7] target/i386: Implement mc->kvm_type() to get VM type
Message-ID: <ZfmjrpoOSmgwWXhW@redhat.com>
References: <20240319140000.1014247-1-pbonzini@redhat.com>
 <20240319140000.1014247-7-pbonzini@redhat.com>
 <Zfmd55tus3nV5DJV@redhat.com>
 <CABgObfZ7ikZHG3EEQHoPKoMo+1JpF6Ntb_QXsYTgEw6zF1zXmQ@mail.gmail.com>
 <ZfmgybXHbCTbisum@redhat.com>
 <CABgObfaKe=EE0N6YHTqpaoK-LaACpzSWykWB+mo=_KDMCnFd1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABgObfaKe=EE0N6YHTqpaoK-LaACpzSWykWB+mo=_KDMCnFd1Q@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
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

On Tue, Mar 19, 2024 at 03:29:14PM +0100, Paolo Bonzini wrote:
> On Tue, Mar 19, 2024 at 3:27 PM Daniel P. Berrangé <berrange@redhat.com> wrote:
> >
> > On Tue, Mar 19, 2024 at 03:25:53PM +0100, Paolo Bonzini wrote:
> > > On Tue, Mar 19, 2024 at 3:15 PM Daniel P. Berrangé <berrange@redhat.com> wrote:
> > > > > +int kvm_get_vm_type(MachineState *ms, const char *vm_type)
> > > >
> > > > The 'vm_type' parameter is never used here. What value is it expected
> > > > to have, and should be diagnosing an error if some unexpected value
> > > > is provided.
> > >
> > > It's the value of the kvm-type machine property, if any; but no x86
> > > machine defines one, so right now it's always NULL. I left it in
> > > because then it's clearer than this is an implementation of
> > > mc->kvm_type, but I can remove it or pass it down to
> > > x86_confidential_guest_kvm_type().
> >
> > If we expect it to always be NULL, lets validate that is the
> > case and error_report + exit, if not.
> 
> I think it's enough to have an assertion in x86_kvm_type():
> 
>     /*
>      * No x86 machine has a kvm-type property.  If one is added that has
>      * it, it should call kvm_get_vm_type() directly or not use it at all.
>      */
>     assert(vm_type == NULL);

Sure, that's fine too.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


