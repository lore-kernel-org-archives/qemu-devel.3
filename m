Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEDA2C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 13:00:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgiw1-0000fw-RO; Mon, 06 Jul 2026 09:00:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wgivo-0000dR-Je
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 09:00:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wgivm-0001XB-St
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 09:00:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783342813;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r7wsWgUASH/v7DI1r9pfMh0B6itUVPl4lKAWn7rsK7M=;
 b=TzRQ0C7NgIK6iQgJRIq2/ZNAg50cqnQodMw9ZVD4GDc79ZejxMOwdZr1mKhU7WxmVv2M0A
 I9IYi5h5WtD3uYdCVINPxYpyFpMmIL/xdTaHMiXUUHM9AVtD9jah5VX6KY+N0oOO06sw6E
 nYOivYy8qh8WAIcs4ChkLgHvOfllrMA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-596-BuPG-YCaPlqrgtHaQuiWFw-1; Mon,
 06 Jul 2026 09:00:10 -0400
X-MC-Unique: BuPG-YCaPlqrgtHaQuiWFw-1
X-Mimecast-MFC-AGG-ID: BuPG-YCaPlqrgtHaQuiWFw_1783342809
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A213B1955DE1; Mon,  6 Jul 2026 13:00:08 +0000 (UTC)
Received: from redhat.com (unknown [10.44.48.165])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2CEE03000B4C; Mon,  6 Jul 2026 13:00:04 +0000 (UTC)
Date: Mon, 6 Jul 2026 14:00:01 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Christian Brauner <brauner@kernel.org>, devel@lists.libvirt.org
Subject: Re: [PATCH v6 01/34] qom: replace 'can_be_deleted' with
 'prepare_delete'
Message-ID: <akum0a48LrMa0bJt@redhat.com>
References: <20260702160337.1910921-1-berrange@redhat.com>
 <20260702160337.1910921-2-berrange@redhat.com>
 <87mrw8y3s3.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87mrw8y3s3.fsf@pond.sub.org>
User-Agent: Mutt/2.3.2 (2026-04-26)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Jul 03, 2026 at 08:40:28AM +0200, Markus Armbruster wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > While most objects can perform all their cleanup in the finalizer
> > method, there can be interactions with other resources / subsystems
> > / threads which require that some cleanup be performed on an user
> > creatable object before unparenting it and entering finalization.
> >
> > The current 'can_be_deleted' method runs in the deletion path and
> > is intended to be used to block deletion. While it could be used
> > to perform cleanup tasks, its name suggests it should be free of
> > side-effects.
> >
> > Generalize this by renaming it to 'prepare_delete', explicitly
> > allowing for cleanup to be provided. Existing users of 'can_be_deleted'
> > are re-written, which provides them with more detailed/tailored error
> > messages.
> 
> Old message:
> 
>         error_setg(errp, "object '%s' is in use, can not be deleted", id);
> 
> New messages:
> 
>         error_setg(errp, "Cryptodev backend '%s' is still in use",
>         error_setg(errp, "Host memory backend '%s' is still mapped",
>         error_setg(errp, "IOMMUFD backend '%s' still has %d users",
>         error_setg(errp, "Throttle group '%s' still has multiple references",
>     error_setg(errp, "Deleting CAN bus device '%s' is not supported",
>     error_setg(errp, "Deleting main loop '%s' is not supported",
> 
> All now mention what kind of object it is.  Users could probably figure
> this out from context easily.  Welcome small improvement.
> 
> The two unconditional ones become more accurate: they now report "not
> supported" instead of "in use".
> 
> The other four lose "can not be deleted".  Users can probably figure
> this out from context.  Still, I lean towards error messages like "Can't
> DO-SOMETHING because REASON" until that becomes overly verbose.  What do
> you think?

I'll change them as follows:

  -        error_setg(errp, "Cryptodev backend '%s' is still in use",
  +        error_setg(errp,
  +                   "Cannot delete cryptodev backend '%s' that is in use",


  -        error_setg(errp, "Host memory backend '%s' is still mapped",
  +        error_setg(errp,
  +                   "Cannot delete host memory backend '%s' which is mapped",


  -        error_setg(errp, "IOMMUFD backend '%s' still has %d users",
  +        error_setg(errp, "Can not delete IOMMUFD backend '%s' with %d users",


  -        error_setg(errp, "Throttle group '%s' still has multiple references",
  +        error_setg(errp,
  +                   "Cannot delete throttle group '%s' with active references",


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


