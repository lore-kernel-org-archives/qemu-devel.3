Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECB8EC3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 08:43:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sesXN-0004Eg-Q2; Fri, 16 Aug 2024 04:42:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sesXL-0004Dk-9E
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 04:42:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sesXJ-0006Wk-Fl
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 04:42:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723797735;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=Y4XA43Xcoz+g2ic3dGNxf6liAtMP0wx7qDgoX1tTGLA=;
 b=PDm6IwcAKIDxXEQog5skrCjjzr3K5ZQ7vm/fesjjlvMSGHbVHIDXuT7FsykZ0qh22NfG3o
 7wP9AJNVAQ3FLrGC+boIqhzm+nzENBcO5fUUJQ1dCCU1pVvw3LMHNtThds/J2Kmz+laH/U
 W90It+Q1wV3jNcT0m9n5JQf492QGsRE=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-102-GWUZsbS0P_e8Ls4xKhym5Q-1; Fri,
 16 Aug 2024 04:42:13 -0400
X-MC-Unique: GWUZsbS0P_e8Ls4xKhym5Q-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E49131955F42; Fri, 16 Aug 2024 08:42:11 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.143])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D11241955DD8; Fri, 16 Aug 2024 08:42:09 +0000 (UTC)
Date: Fri, 16 Aug 2024 09:42:06 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Steven Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Markus Armbruster <armbru@redhat.com>
Subject: Re: [RFC V1 0/6] Live update: cpr-transfer
Message-ID: <Zr8Q3rgoKkh1ohTG@redhat.com>
References: <1719776648-435073-1-git-send-email-steven.sistare@oracle.com>
 <Zpk2bfjS1Wu2QbcO@x1n>
 <90a01b2b-6a72-475f-9232-3af73d1618cf@oracle.com>
 <Zr5lC9ryCsn9FjE2@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zr5lC9ryCsn9FjE2@x1n>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.131,
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

On Thu, Aug 15, 2024 at 04:28:59PM -0400, Peter Xu wrote:
> On Sat, Jul 20, 2024 at 04:07:50PM -0400, Steven Sistare wrote:
> > > > The new user-visible interfaces are:
> > > >    * cpr-transfer (MigMode migration parameter)
> > > >    * cpr-uri (migration parameter)
> > > 
> > > I wonder whether this parameter can be avoided already, maybe we can let
> > > cpr-transfer depend on unix socket in -incoming, then integrate fd sharing
> > > in the same channel?
> > 
> > You saw the answer in another thread, but I repeat it here for others benefit:
> > 
> >   "CPR state cannot be sent over the normal migration channel, because devices
> >    and backends are created prior to reading the channel, so this mode sends
> >    CPR state over a second migration channel that is not visible to the user.
> >    New QEMU reads the second channel prior to creating devices or backends."
> 
> Today when looking again, I wonder about the other way round: can we make
> the new parameter called "-incoming-cpr", working exactly the same as
> "cpr-uri" qemu cmdline, but then after cpr is loaded it'll be automatically
> be reused for migration incoming ports?
> 
> After all, cpr needs to happen already with unix sockets.  Having separate
> cmdline options grants user to make the other one to be non-unix, but that
> doesn't seem to buy us anything.. then it seems easier to always reuse it,
> and restrict cpr-transfer to only work with unix sockets for incoming too?

IMHO we should not be adding any new command line parameter at all,
and in fact we should actually deprecate the existing "-incoming",
except when used with "defer".

An application managing migration should be doing all the configuration
via QMP

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


