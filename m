Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FD5DCCD1BC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 13:55:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBvmv-00044q-67; Thu, 23 Oct 2025 09:55:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vBvmt-00040e-BR
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 09:55:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vBvmr-0005CR-Ft
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 09:55:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761227728;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UTR4evT2968cs0+v7ChsBOBa6TPu4uV3AAevJS3KBa0=;
 b=GP7NuXhEzroTfs/wzEtl5MHQT7P1MKEO/q2HDpT1QX4nu0t6xKh22cAxNOaY78YojCWd+R
 NHnkvzvwRW3UvTMgNObD2CgcuXNmsJiuErGno0ky06Z6j4cXyfcLvGa8LW6V5/16E2+tzm
 EItDJmYatkb+BGz7OpQjg1oF4+KBhxg=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-220-of8TS0L2Oc6zBLv8uFHlog-1; Thu, 23 Oct 2025 09:55:25 -0400
X-MC-Unique: of8TS0L2Oc6zBLv8uFHlog-1
X-Mimecast-MFC-AGG-ID: of8TS0L2Oc6zBLv8uFHlog_1761227725
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-88e54c7fe55so221008185a.0
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 06:55:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761227725; x=1761832525;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UTR4evT2968cs0+v7ChsBOBa6TPu4uV3AAevJS3KBa0=;
 b=g/QNfpgQmUR71odexgDJtcwJkpTO5QN/fDmeK8RCiRxhxNlq3Znlg2LsrlPP3EiF4d
 aOPhl226oCtkiyJebMq/ElFWv5RPBum5PUku12XbrJDZAh6GhKkpGZSmJnGkR/BxSX3b
 BbWlgtG+JCyA8GD8pMS/NGu3Gsqsv5XwKitKFfr2zcA4jXtvAPQkDNZc87kGsXKCu7R0
 tnnSiDmc1sw3qxDjWbgtIyxWlCdH6UdJ40NSfVq2Fno6xD40GmCSI+LakHi2cFGNO4V2
 LC5BGfuJP2Z3pU0VNpRD9jg65Vgm7bU6CY7EIVeAB/5YhuZWc/sa1PfERWOcH3llonD3
 DvYA==
X-Gm-Message-State: AOJu0YzkJi4bR+LBBYr6ZV94fwE2hTvrGCt4BBpanu/AKG3txXmjnad1
 glLrQx6roKCGewEMWLxm4SH/GgDwQAzuRhXqCWB73mt9FZxGvOJl/VM2F3VSLnO5s2TQcYqveZa
 XzMpSPqGBG7BGVu4mgzL54gjuUbKMXNVnn84pwpSAEXqKR/GQDaVvIlH5
X-Gm-Gg: ASbGncth+w8zgPynvQO7ZKk3zT67PLPJPPqy+7/WAOP3r6IOdPnN/97w+gzhgZBdI7d
 B4qrBd+7AnSFWQ1R8K7OTkSSPat+7awO/pMmCer7rKZc3iNGewMiEOLk01O20PDqyHrrjSNH+6E
 4jghtHXdUWinGU56yXIenM86hodDypn/uuiwpShf97uFa0GfEVMl5YYnxABPMidWuERsN33N2hH
 pbOJJ5lsH5LvnHTI3l3VRWAOjeVWSWK9C9GjnFNvrg26WmmTi6IWdUHDWuNGc6YMSb1fpjocGck
 ja+SCZrJMVoP2O5DiMmKCni5IlHyabBq/HPnuk0LRfYawiRSA7WJVnyPFfMbIrrzs0o=
X-Received: by 2002:a05:620a:7104:b0:815:9d71:62be with SMTP id
 af79cd13be357-899e91b3406mr887668385a.32.1761227724878; 
 Thu, 23 Oct 2025 06:55:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFF6gYGkCnPlqll26HPP3FSO9EE9k+TQYqnyNyACAmuG/0gAdoU7ppRft9m5I0P9WYfUdJJnA==
X-Received: by 2002:a05:620a:7104:b0:815:9d71:62be with SMTP id
 af79cd13be357-899e91b3406mr887664785a.32.1761227724235; 
 Thu, 23 Oct 2025 06:55:24 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-89c1244e53csm162101785a.55.2025.10.23.06.55.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Oct 2025 06:55:23 -0700 (PDT)
Date: Thu, 23 Oct 2025 09:55:22 -0400
From: Peter Xu <peterx@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH] migration/qmp: Update "resume" flag doc in "migrate"
 command
Message-ID: <aPozyk9Do9iu32G4@x1.local>
References: <20251022190425.2730441-1-peterx@redhat.com>
 <87cy6eb25c.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87cy6eb25c.fsf@pond.sub.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Thu, Oct 23, 2025 at 07:47:11AM +0200, Markus Armbruster wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > It wasn't obvious how the resume flag should be used when staring at the
> > QAPI doc.  Enrich it to be crystal clear.
> >
> > Reported-by: Markus Armbruster <armbru@redhat.com>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  qapi/migration.json | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/qapi/migration.json b/qapi/migration.json
> > index be0f3fcc12..48856078db 100644
> > --- a/qapi/migration.json
> > +++ b/qapi/migration.json
> > @@ -1732,7 +1732,10 @@
> >  # @detach: this argument exists only for compatibility reasons and is
> >  #     ignored by QEMU
> >  #
> > -# @resume: resume one paused migration, default "off".  (since 3.0)
> > +# @resume: when set, resume one paused postcopy migration, using the new
> 
> Scratch "one" unless there can be more than one.

Sure.

> 
> > +#     URI/channels specified to replace the old/broken channels.  The user
> > +#     should make sure the migration is in "postcopy-paused" state before
> > +#     the resume request.  Default "off".  (since 3.0)
> >  #
> >  # Features:
> >  #
> 
> What happens when migration is not in state "postcopy-paused"?

The QMP command "migrate" with resume=true set will be rejected,
corresponds to:

migrate_prepare():
        if (s->state != MIGRATION_STATUS_POSTCOPY_PAUSED) {
            error_setg(errp, "Cannot resume if there is no "
                       "paused migration");
            return false;
        }

> 
> Remind me, how can migration get into and out of this state?

It can happen if any interruption happened during a postcopy migration.  So
it needs to be postcopy-active state first, then something wrong happened
e.g. the network is down.  Then the channel will break on both sides of
QEMU, and both QEMUs will jump into postcopy-paused.

To get out of the state, one needs to explicitly recover the migration, the
core steps are:

  - (optional) Run migrate_recover on dest QEMU to re-establish the ports,
    if the old listening ports are not available anymore.

  - Run migrate on src QEMU with resume=true flag here to resume the
    postcopy migration.

If the recover succeeded, it'll switch from postcopy-paused finally back to
postcopy-active.

Thanks,

-- 
Peter Xu


