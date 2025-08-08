Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8468FC87FD3
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 09:44:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukJea-0002D1-CY; Fri, 08 Aug 2025 05:44:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1ukJeY-0002BS-Av
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 05:44:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1ukJeV-00037F-Vn
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 05:44:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754646282;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nOEYYEZAhx9Sond3tj8SaSDtfgIIePAGBmpgAJzIL08=;
 b=aTg4hu+8UvtVc8LN2/dB/ijWZNTo7n1jQ4Ur7+oKK9Fq5HAgF5f1MLvvTLQRKzxyyytEmT
 h49B/Vro0av55+Y/4tPXsYYFWZxU1lrrwZpyAc9Zrh9bnpfKz9ov9XQ9B9qSLUct12kaj3
 1+Zh+GrGH46q97eb6SLdvu4AIFIikg0=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-J92SBe_0OsmkvWMp4B-yqg-1; Fri, 08 Aug 2025 05:44:41 -0400
X-MC-Unique: J92SBe_0OsmkvWMp4B-yqg-1
X-Mimecast-MFC-AGG-ID: J92SBe_0OsmkvWMp4B-yqg_1754646280
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-7073a5f61a6so36442806d6.0
 for <qemu-devel@nongnu.org>; Fri, 08 Aug 2025 02:44:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754646280; x=1755251080;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nOEYYEZAhx9Sond3tj8SaSDtfgIIePAGBmpgAJzIL08=;
 b=kKFCcztL+9iOkyYm8FStr7CAf3se6AlFYGt3vwx97HgxddXdseThFDUGHJ1EZkWCVf
 qGaF/oHrNpZ0kH/QnfOXBeBoyE9zsbM2qlP3te2XvRG6fsPlFPkkgrfCygG4/TM7mJpK
 6NFCzV2zCGytLbVla1gluTyIxeN/jv2Qd983vRk0ZELiIxv5eZk509Yaz2lQS2JPWV9E
 dtYz84LQ7yxYvtjigFMTKfdrFWmqMctVwUgTgn4n5PijkovKgLiEYdl5awOcah5M7yFT
 9kBGMRKgIun/AngsqavOF7LyVTUS6a1fv3pBij0HxX/dkXgYAYrWxpSgQHn6G7rXqDgt
 iRew==
X-Gm-Message-State: AOJu0Yw0ikblXj4ov8pIXiYaWK99QBKVNyDKgMT8S1iOKHOs+mE4CDGA
 WpLmDd2t32vOiEgY4VlaoitIEMfcsQY8O0WM5qgdgLeO/RDzYDfFua7EQWkTszzMi4KHHs5xsac
 JQY4Nd0E1JrB2AgfIcNGJU7hf8lmAd6vPvggEKJCsE8csCwN0F1yY+G5Z
X-Gm-Gg: ASbGncuScmjPCgjTJoCDwGQc6DguN88Z/+1zZfkc2tzq5kcWDpy0FJ5ruiEtdtjZQZC
 HRqFq7dWIDo28j7yLKH2nnvy24GPjBCHtYaBbAP3Ukxgzbbdd9WTXiX75OT/hBGJKLo76USVs3N
 gqW93Kg2YbX+ZdW6N2uEobYGPJmUEANgXM68yZChbaG6C4hfI9QYgitAKK6ukK7JK6/vJ32gt6Q
 xfwoKwpic427iizjhBREYcZHOcGqMlYu7jxhcoPK8XJCfNKTqc1/SwYYyFPY+cTlzEIW7X3Glbj
 wQHWfqTNR5rV/dPz8JpUgNeQFWEw
X-Received: by 2002:ad4:5aad:0:b0:709:8fad:cd2d with SMTP id
 6a1803df08f44-7099a369a8dmr24454716d6.43.1754646280480; 
 Fri, 08 Aug 2025 02:44:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFHONGKzCCKqn9QBYAhY6BLWwkey+T5w4MVlvhFbxSvxtfsbZJm9hD/BQzwjhfWsu+A85Ef+g==
X-Received: by 2002:ad4:5aad:0:b0:709:8fad:cd2d with SMTP id
 6a1803df08f44-7099a369a8dmr24454546d6.43.1754646280042; 
 Fri, 08 Aug 2025 02:44:40 -0700 (PDT)
Received: from fedora ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-7077ca1d5ecsm112209516d6.26.2025.08.08.02.44.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Aug 2025 02:44:39 -0700 (PDT)
Date: Fri, 8 Aug 2025 11:44:36 +0200
From: Juraj Marcin <jmarcin@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Jiri Denemark <jdenemar@redhat.com>, 
 Stefan Weil <sw@weilnetz.de>, Paolo Bonzini <pbonzini@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [RFC PATCH 2/4] migration: Fix state transition in
 postcopy_start() error handling
Message-ID: <ftnfp4glpvoe3hwycvzqc2q3soyrmblshllfxgnjt7dlmpryvp@sqjom56wab5j>
References: <20250807114922.1013286-1-jmarcin@redhat.com>
 <20250807114922.1013286-3-jmarcin@redhat.com>
 <aJUSeOIKfQ47uliY@x1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJUSeOIKfQ47uliY@x1.local>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jmarcin@redhat.com;
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Peter,

On 2025-08-07 16:54, Peter Xu wrote:
> On Thu, Aug 07, 2025 at 01:49:10PM +0200, Juraj Marcin wrote:
> > From: Juraj Marcin <jmarcin@redhat.com>
> > 
> > Depending on where an error during postcopy_start() happens, the state
> > can be either "active", "device" or "cancelling", but never
> > "postcopy-active". Migration state is transitioned to "postcopy-active"
> > only just before a successful return from the function.
> > 
> > Accept any state except "cancelling" when transitioning to "failed"
> > state.
> > 
> > Signed-off-by: Juraj Marcin <jmarcin@redhat.com>
> > ---
> >  migration/migration.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/migration/migration.c b/migration/migration.c
> > index 10c216d25d..e5ce2940d5 100644
> > --- a/migration/migration.c
> > +++ b/migration/migration.c
> > @@ -2872,8 +2872,9 @@ static int postcopy_start(MigrationState *ms, Error **errp)
> >  fail_closefb:
> >      qemu_fclose(fb);
> >  fail:
> > -    migrate_set_state(&ms->state, MIGRATION_STATUS_POSTCOPY_ACTIVE,
> > -                          MIGRATION_STATUS_FAILED);
> > +    if ( ms->state != MIGRATION_STATUS_CANCELLING) {
> > +        migrate_set_state(&ms->state, ms->state, MIGRATION_STATUS_FAILED);
> > +    }
> 
> Hmm, this might have been overlooked from my commit 48814111366b.  Maybe
> worth a Fixes and copy stable?

yeah, it looks like it. POSTCOPY_ACTIVE state used to be set way sooner
before. I'll add Fixes tag to the patch.

> 
> For example, I would expect the old code (prior of 48814111366b) still be
> able to fail postcopy and resume src QEMU if qemu_savevm_send_packaged()
> failed.  Now, looks like it'll be stuck at "device" state..
> 
> The other thing is it also looks like a common pattern to set FAILED
> meanwhile not messing with a CANCELLING stage.  It's not easy to always
> remember this, so maybe we should consider having a helper function?
> 
>   migrate_set_failure(MigrationState *, Error *err);
> 
> Which could set err with migrate_set_error() (likely we could also
> error_report() the error), and update FAILED iff it's not CANCELLING.
> 
> I saw three of such occurances that such helper may apply, but worth double
> check:
> 
> postcopy_start[2725]           if (ms->state != MIGRATION_STATUS_CANCELLING) {
> migration_completion[3069]     if (s->state != MIGRATION_STATUS_CANCELLING) {
> igration_connect[4064]        if (s->state != MIGRATION_STATUS_CANCELLING) {
> 
> If the cleanup looks worthwhile, and if the Fixes apply, we could have the
> cleanup patch on top of the fixes patch so patch 1 is easier to backport.

Such function could be useful. I could also send it with the above fix
together as a separate patchset, and send it also to stable.


Best regards

Juraj Marcin

> 
> Thanks,
> 
> >      migration_block_activate(NULL);
> >      migration_call_notifiers(ms, MIG_EVENT_PRECOPY_FAILED, NULL);
> >      bql_unlock();
> > -- 
> > 2.50.1
> > 
> 
> -- 
> Peter Xu
> 


