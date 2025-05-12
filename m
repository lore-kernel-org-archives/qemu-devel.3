Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28713C3ABC3
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 17:30:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEWz7-0008VB-8d; Mon, 12 May 2025 13:30:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1uEWyq-0008DN-HB
 for qemu-devel@nongnu.org; Mon, 12 May 2025 13:30:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1uEWym-0004RR-QY
 for qemu-devel@nongnu.org; Mon, 12 May 2025 13:30:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747071015;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6emdE9DSYtr+5qtvzBMe8/TA5kmbJRd5vN3FxJkrTSg=;
 b=OWBSAlnst8IVc8m/4W/Hr7IarZUn5Vu/ocgtoIJNvsqrLQYuKNPd/M5iRVQirW84SPJQSp
 hHitz1RisUXC99jpJPOGqF93AcNYdLNVM8Izyym7VBujOnOUDtSTQaakkO63Y8vpSQtWQw
 kuyABRJCcHD82M0aYIT44gcghA0IJsc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-350-m3ONVY0nMgC7vZ0gjwLjCA-1; Mon,
 12 May 2025 13:30:12 -0400
X-MC-Unique: m3ONVY0nMgC7vZ0gjwLjCA-1
X-Mimecast-MFC-AGG-ID: m3ONVY0nMgC7vZ0gjwLjCA_1747071011
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C0677180035F; Mon, 12 May 2025 17:30:10 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.81])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 55AE818003FC; Mon, 12 May 2025 17:30:07 +0000 (UTC)
Date: Mon, 12 May 2025 12:30:04 -0500
From: Eric Blake <eblake@redhat.com>
To: Sunny Zhu <sunnyzhyy@qq.com>
Cc: armbru@redhat.com, hreitz@redhat.com, jsnow@redhat.com, 
 kwolf@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org, 
 stefanha@redhat.com, vsementsov@yandex-team.ru
Subject: Re: [PATCH v4 08/13] mirror: Allow QMP override to declare target
 already zero
Message-ID: <gfyof47cuszyigghtzaopil3k3jobjetht2ygpfrz663zz6ujj@xmqkfxc7zfax>
References: <20250509204341.3553601-23-eblake@redhat.com>
 <tencent_A7998CB3DFA6461A093A09394FD2FD417506@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_A7998CB3DFA6461A093A09394FD2FD417506@qq.com>
User-Agent: NeoMutt/20250404
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.551,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sat, May 03, 2025 at 07:57:24AM +0800, Sunny Zhu wrote:
> On Fri, May 09, 2025 at 03:40:25PM -0500, Eric Blake wrote:
> > QEMU has an optimization for a just-created drive-mirror destination
> > that is not possible for blockdev-mirror (which can't create the
> > destination) - any time we know the destination starts life as all
> > zeroes, we can skip a pre-zeroing pass on the destination.  Recent
> > patches have added an improved heuristic for detecting if a file
> > contains all zeroes, and we plan to use that heuristic in upcoming
> > patches.  But since a heuristic cannot quickly detect all scenarios,
> > and there may be cases where the caller is aware of information that
> > QEMU cannot learn quickly, it makes sense to have a way to tell QEMU
> > to assume facts about the destination that can make the mirror
> > operation faster.  Given our existing example of "qemu-img convert
> > --target-is-zero", it is time to expose this override in QMP for
> > blockdev-mirror as well.
> > 

> > +++ b/qapi/block-core.json
> > @@ -2538,6 +2538,11 @@
> >  #     disappear from the query list without user intervention.
> >  #     Defaults to true.  (Since 3.1)
> >  #
> > +# @target-is-zero: Assume the destination reads as all zeroes before
> > +#     the mirror started.  Setting this to true can speed up the
> > +#     mirror.  Setting this to true when the destination is not
> > +#     actually all zero can corrupt the destination.  (Since 10.1)
> 
> It appears feasible to add target-is-zero to the drive-mirror qmp as well,
> provided this is done under the NEW_IMAGE_MODE_EXISTING scenario. This would
> allow users to pass target-is-zero for optimizations whether using blockdev-mirror
> or drive-mirror when they have pre-prepared destination image.

I didn't want to touch drive-mirror, since it is an older command that
has some awkward semantics that were improved on when we added
blockdev-mirror (that's why libvirt only uses blockdev-mirror).  If we
still think it is worth bolting features onto the old command, instead
of encouraging users to migrate to the new one, then that should be a
separate patch.

> > @@ -3044,6 +3044,8 @@ void qmp_drive_mirror(DriveMirror *arg, Error **errp)
> >      zero_target = (arg->sync == MIRROR_SYNC_MODE_FULL &&
> >                     (arg->mode == NEW_IMAGE_MODE_EXISTING ||
> >                      !bdrv_has_zero_init(target_bs)));
> > +    target_is_zero = (arg->mode != NEW_IMAGE_MODE_EXISTING &&
> > +                      bdrv_has_zero_init(target_bs));
> 
> Similarly, if the qmp_drive_mirror supports the target-is-zero parameter, we would then 
> be able to determine whether the destination image is fully zero-initialized when 
> arg->mode is NEW_IMAGE_MODE_EXISTING.

Determination of whether a pre-existing image is fully
zero-initialized for drive-mirror comes for free later in the patch
series (at the same time that blockdev-mirror is able to infer that
information without an explicit target-is-zero parameter).

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


