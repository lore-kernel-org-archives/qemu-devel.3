Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5680DEFD239
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 10:04:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvBka-0001hD-Rg; Wed, 25 Feb 2026 05:04:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vvBka-0001h4-3b
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 05:04:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vvBkY-0000z3-BC
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 05:04:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772013849;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6DghlwcnqP+nM+hN/ZTb6CF83dBnmYMc6ENouCr1nao=;
 b=QS9SrN/33N7z9gQbx27+G59Gk1aHmbzLmnqvXuViwTvWkMq/rzAfpDqqPRRIK2jexRtbS9
 I7yxqiS6hvu44FApcLStnIFkiJByieWBcohezbnyUCqBcY4X1H9KfqA3IgB/xN+wQ2CpS+
 vtouPzkztzcbWVFjX71Pc54gGLYU/Dg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-15-5AvJ-CqJMpuh9spits0Y-g-1; Wed,
 25 Feb 2026 05:04:08 -0500
X-MC-Unique: 5AvJ-CqJMpuh9spits0Y-g-1
X-Mimecast-MFC-AGG-ID: 5AvJ-CqJMpuh9spits0Y-g_1772013847
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B76C8195609F; Wed, 25 Feb 2026 10:04:06 +0000 (UTC)
Received: from redhat.com (unknown [10.45.225.165])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5E54B180066B; Wed, 25 Feb 2026 10:04:03 +0000 (UTC)
Date: Wed, 25 Feb 2026 10:04:00 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Prasad Pandit <ppandit@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 kraxel@redhat.com, pbonzini@redhat.com, ani@anisinha.ca,
 Prasad Pandit <pjp@fedoraproject.org>, qemu-devel@nongnu.org
Subject: Re: [PATCH v6 35/35] migration: return EEXIST when trying to add the
 same migration blocker
Message-ID: <aZ7JEKJEBXLtFt7G@redhat.com>
References: <20260225035000.385950-1-anisinha@redhat.com>
 <20260225035000.385950-36-anisinha@redhat.com>
 <CAE8KmOyjB1NEtBVQ2QDiDZrPoem3eTWEi-Ht_mJZQNa-H=5iNQ@mail.gmail.com>
 <aZ670CAG40j1r2PJ@redhat.com> <87342pw4l8.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87342pw4l8.fsf@pond.sub.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.358, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.659,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed, Feb 25, 2026 at 10:32:51AM +0100, Markus Armbruster wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > On Wed, Feb 25, 2026 at 11:35:15AM +0530, Prasad Pandit wrote:
> >> On Wed, 25 Feb 2026 at 09:23, Ani Sinha <anisinha@redhat.com> wrote:
> >> > Currently the code that adds a migration blocker does not check if the same
> >> > blocker already exists. Return an EEXIST error code if there is an attempt to
> >> > add the same migration blocker again. This way the same migration blocker will
> >> > not get added twice.
> >> >
> >> > Suggested-by: Prasad Pandit <pjp@fedoraproject.org>
> >> > Signed-off-by: Ani Sinha <anisinha@redhat.com>
> >> > ---
> >> >  migration/migration.c | 4 ++++
> >> >  1 file changed, 4 insertions(+)
> >> >
> >> > diff --git a/migration/migration.c b/migration/migration.c
> >> > index a5b0465ed3..1eb75fb7fb 100644
> >> > --- a/migration/migration.c
> >> > +++ b/migration/migration.c
> >> > @@ -1702,6 +1702,10 @@ static int add_blockers(Error **reasonp, unsigned modes, Error **errp)
> >
> > This method has an  '**errp' parameter.....
> >
> >> >  {
> >> >      for (MigMode mode = 0; mode < MIG_MODE__MAX; mode++) {
> >> >          if (modes & BIT(mode)) {
> >> > +            if (g_slist_index(migration_blockers[mode],
> >> > +                                 *reasonp) >= 0) {
> >> > +                return -EEXIST;
> >
> > .... so using  -errno for return values is not appropriate - it must
> > set 'errp' and return -1.
> 
> Yes, it must set @errp on failure.  Returning -1 would be wrong,
> because:
> 
>     int migrate_add_blocker_modes(Error **reasonp, unsigned modes, Error **errp)
>     {
>         if (is_only_migratable(reasonp, modes, errp)) {
>             return -EACCES;
>         } else if (is_busy(reasonp, errp)) {
>             return -EBUSY;
>         }
>         return add_blockers(reasonp, modes, errp);
>     }
> 
> If callers don't actually care for error codes, the entire nest of
> functions could be simplified to return 0/-1 or true/false.

AFAICT there is only 1 caller that cares

spapr_mce_req_event tries to block migration while handling machine
check exceptions, and if seeing EBUSY it will report a warning
message.  I'm not convinced it should be checking for EBUSY at all.

If -only-migratable is set, it seems appropriate that it report
the same warning message, as it is unable to block the migration.


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


