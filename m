Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E848C3ABC3
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 07:58:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDIch-0006cO-Hs; Fri, 09 May 2025 03:58:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uDIcf-0006bC-KM
 for qemu-devel@nongnu.org; Fri, 09 May 2025 03:58:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uDIcc-00006r-TF
 for qemu-devel@nongnu.org; Fri, 09 May 2025 03:58:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746777497;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=2uFmFK9m9Kpnj4fKPd+BLnD551jrkLOdZfLuVl09ae4=;
 b=i0OaTc1iYlcfFL9VaKcUUhSkLVZ9yxNvLn5S348/m8DxC5fE9rDNbRTB207l382ihHdyMh
 qdGfD7pKZRT4BfaaEBVj5W/WGtVGinf1D4bv7kihjRaj/uy7LoC0miOAFrT6R/FH+i18T5
 tnmnChsWpzku2b30O9RzS/0EUZvWLzo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-595-bNpfGs4EOu6w8EpDevm6Kw-1; Fri,
 09 May 2025 03:58:14 -0400
X-MC-Unique: bNpfGs4EOu6w8EpDevm6Kw-1
X-Mimecast-MFC-AGG-ID: bNpfGs4EOu6w8EpDevm6Kw_1746777493
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6B50B19560BC; Fri,  9 May 2025 07:58:13 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.100])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 135DD18003FD; Fri,  9 May 2025 07:58:10 +0000 (UTC)
Date: Fri, 9 May 2025 08:58:07 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Nabih Estefan <nabihestefan@google.com>, qemu-devel@nongnu.org,
 richard.henderson@linaro.org, pbonzini@redhat.com,
 Peter Foley <pefoley@google.com>
Subject: Re: [PATCH 1/2] util: fix msan findings in keyval
Message-ID: <aB207Rl-vZxfuJBM@redhat.com>
References: <20250508222132.748479-1-nabihestefan@google.com>
 <20250508222132.748479-2-nabihestefan@google.com>
 <87cycibagm.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87cycibagm.fsf@pond.sub.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.416,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Fri, May 09, 2025 at 07:48:57AM +0200, Markus Armbruster wrote:
> Nabih Estefan <nabihestefan@google.com> writes:
> 
> > From: Peter Foley <pefoley@google.com>
> >
> > e.g.
> > I	2025-02-28 09:51:05.240071-0800		624	stream.go:47	qemu: Uninitialized value was created by an allocation of 'key_in_cur.i' in the stack frame
> > I	2025-02-28 09:51:05.240187-0800		624	stream.go:47	qemu: #0 0xaaaac49f489c in keyval_parse_one third_party/qemu/util/keyval.c:190:5
> >
> > Signed-off-by: Peter Foley <pefoley@google.com>
> > Signed-off-by: Nabih Estefan <nabihestefan@google.com>
> > ---
> >  util/keyval.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/util/keyval.c b/util/keyval.c
> > index a70629a481..f33c64079d 100644
> > --- a/util/keyval.c
> > +++ b/util/keyval.c
> > @@ -187,7 +187,7 @@ static const char *keyval_parse_one(QDict *qdict, const char *params,
> >  {
> >      const char *key, *key_end, *val_end, *s, *end;
> >      size_t len;
> > -    char key_in_cur[128];
> > +    char key_in_cur[128] = {};
> >      QDict *cur;
> >      int ret;
> >      QObject *next;
> 
> Prior review of Peter's patch concluded this must be false positive:
> https://lore.kernel.org/qemu-devel/14168384-ecdb-4c05-8267-ac5ef1c46fe9@redhat.com/

While I agree with Paolo's reasoning, I think it is still worth adding an
explicit initializer, because it makes it easier for both humans and machines
to reason about correctless.

To reinforce that we don't have an actual bug though, also note that qemu
unconditionally builds with -ftrivial-auto-var-init=zero. So if we happen
to forget any, it won't cause a bug in the common case of a zero-initializer.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


