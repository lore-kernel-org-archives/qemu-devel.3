Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0472CD98E4
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 11:23:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZoMZ-0005BC-Fp; Wed, 17 Jun 2026 07:23:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wZoMP-0005AQ-V1
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 07:23:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wZoMN-0003fC-NK
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 07:23:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781695386;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PbyEhpP0HW/JIMDrGjn9LSY1ZZ+wQkhZkPcebEhr+oE=;
 b=GGxd3X4NmKW0IZcpvn8w3cNmb4vqquGLm+qtOkIE+FfAMYYh70S3a3rg0woAtaCCuNa8Gj
 KF59MtnKyzwFAyOE4r3WiXfZN3Nrv41Ix+ViS7IeX/wt5USKtArtFGnI76khne6e5fBdDO
 z92IK+BqnlISaumQ4pSDDouQi5mB+ig=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-571-EfyutAGrNUekTN06KELt7A-1; Wed,
 17 Jun 2026 07:23:01 -0400
X-MC-Unique: EfyutAGrNUekTN06KELt7A-1
X-Mimecast-MFC-AGG-ID: EfyutAGrNUekTN06KELt7A_1781695379
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 897F41955DA0; Wed, 17 Jun 2026 11:22:59 +0000 (UTC)
Received: from redhat.com (unknown [10.44.48.201])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1AF68195411F; Wed, 17 Jun 2026 11:22:53 +0000 (UTC)
Date: Wed, 17 Jun 2026 12:22:50 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Xu <peterx@redhat.com>,
 =?utf-8?B?SGVydsOp?= Poussineau <hpoussin@reactos.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Aurelien Jarno <aurelien@aurel32.net>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [RFC 7/7] qom: improve error message for invalid ID values
Message-ID: <ajKDikXElrr50mWZ@redhat.com>
References: <20260616155554.264412-1-berrange@redhat.com>
 <20260616155554.264412-8-berrange@redhat.com>
 <87o6h9o350.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87o6h9o350.fsf@pond.sub.org>
User-Agent: Mutt/2.3.2 (2026-04-26)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed, Jun 17, 2026 at 12:46:51PM +0200, Markus Armbruster wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > Include the actual ID that was validated, since this may not be
> > obvious in all contexts.
> >
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> 
> Reproducer?
> 
> I'm asking because:
> 
>     $ qemu-system-x86_64 -object id=@
>     qemu-system-x86_64: -object id=@: Parameter 'id' expects an identifier
>     Identifiers consist of letters, digits, '-', '.', '_', starting with a letter.
> 
> This is qemu_opts_create().
> 
> And:
> 
>     {"execute":"device_add","arguments":{"driver":"e1000", "id":"@"}}
>     {"error": {"class": "GenericError", "desc": "Invalid qdev ID '@'"}}
> 
> This is qdev_set_id().
> 
> Ah, found it:
> 
>     $ qemu-system-x86_64 -object '{"id": "@", "qom-type": "iothread"}'
>     qemu-system-x86_64: QOM ID value '@' is not valid
>     Identifiers consist of letters, digits, '-', '.', '_', starting with a letter.

Actually in this case it wasn't anything user controlled,
I was calling  object_new_with_props internally to create
child objects and it tripped over this due to a bug of
my own making. It was just rather confusing as to what I
had done wrong

> 
> > ---
> >  qom/object.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/qom/object.c b/qom/object.c
> > index 415d5c5291..9cd17e3bcc 100644
> > --- a/qom/object.c
> > +++ b/qom/object.c
> > @@ -774,7 +774,7 @@ object_new_with_props_helper(const char *typename,
> >             (id == NULL && parent == NULL));
> >  
> >      if (id != NULL && !id_wellformed(id)) {
> > -        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "id", "an identifier");
> > +        error_setg(errp, "QOM ID value '%s' is not valid", id);
> >          error_append_hint(errp, "Identifiers consist of letters, digits, "
> >                            "'-', '.', '_', starting with a letter.\n");
> >          return NULL;
> 
> Improvement, but what about other places reporting an error when
> id_wellformed() fails?
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


