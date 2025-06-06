Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5E73C61CE8
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 20:51:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNe1q-0000sg-EF; Fri, 06 Jun 2025 16:51:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uNe1p-0000s9-5H
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 16:51:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uNe1m-0006qk-3e
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 16:51:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749243060;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Pl1iJVAwbmj2k/Qu1VmgLakylCSHgmA0/gr1PYfswhA=;
 b=EiCQMc88pogfCpZuR5Ecejl4qJsZdpZBJ7oUxBXRIMNCsbyHJmKFqJpbC9mWFg5mTlQ6KE
 DbJzzu+sV35oGZG+H7AulCxbOTBFohnSz+63IAzORGFzG++Y71G5MeLObo3UmijmeoNtMM
 fIHZTHyaTJw36XRL4/ONYM+GRCWlM1w=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-L1GwN62rOSq_e_D-gdrEfg-1; Fri, 06 Jun 2025 16:50:58 -0400
X-MC-Unique: L1GwN62rOSq_e_D-gdrEfg-1
X-Mimecast-MFC-AGG-ID: L1GwN62rOSq_e_D-gdrEfg_1749243058
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7c5d608e6f5so581589385a.0
 for <qemu-devel@nongnu.org>; Fri, 06 Jun 2025 13:50:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749243058; x=1749847858;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pl1iJVAwbmj2k/Qu1VmgLakylCSHgmA0/gr1PYfswhA=;
 b=UThH6vjYjmxDtZlW7UwCyTRXFtd79oaL67qB377PuCMea7tfkhmwdVF+ESrd0joLnX
 Fz9rfHo0ip/qhAZh49wyNI3qxhMloQskdlucCdVu/eKL0jVmuJPZlGOZhOJGo5hG8s/8
 kfRB27/jEZGqPzQGDx2bCMwxbCmTLGEJFa1peCm/VLCLcc72UgQ/0PLtGNxL7yjo8TM8
 F2onOecYKwXMCfCbRPXQ8eFRL+G4oZhXBP/NaxPpHxzjiwtw9EGiSTkqpUuoh+jwKhvZ
 DDvFK4h/CuNF3blU2XlY0WiTrDD02GCuswh5JpLyZdM6mKz2n1Tksl+cWq71zQE85inK
 DIlg==
X-Gm-Message-State: AOJu0YzYqZ0B81wnOVdo+2UEnju2K19KVRhCu7rGgOlNEbEd+Z/dyR99
 lkL0g+rCNIigG00MJw94bjL413KzxMDLipEwsEMuLuMx8XpCfEPc6KZhMatoCd5tDJOTplC2n5g
 /YBnDz8wS9Ol1cglggEFyvCm20qBpx+3RwBk7SZKzsIbckdCbWi+XA307
X-Gm-Gg: ASbGnctWWRTOUbyfEJQci9fXEKioQSjadjeQCOaRVHk0vY1JAcCiUUBmIpFipXGcN/Q
 05gD0UUnM7Av66/+ZjWWiPqqrRg5+qE7Z7RgJXKsKodAYJurUdhlmLOanmKLgvYEJ/f0pNZyZ8Z
 HFc4S5LeD0NfFnwqHCtw0VEwh5uCDMCGH2GVVbvTc+s9leLpHjXPzNAS+VNsXgGnqxc8Mh2WzNq
 yL0wNvR2a2Apz7YRAD4UbsNduojK9UOqmUhutZJ9i2oMCNJyLTEFE2qZW/MeKGWeX+s7+WredJL
 v+G2HKJgfbnD0Q==
X-Received: by 2002:a05:620a:4728:b0:7d2:28c7:7795 with SMTP id
 af79cd13be357-7d2298d8ad7mr718528285a.35.1749243057800; 
 Fri, 06 Jun 2025 13:50:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHLDPZ64jSlAYGy6SjsPAj1qXu9lrf9Z7nnJJcjc+UW0vK469MYT6RFfhiAREjG/6UA8lQfsQ==
X-Received: by 2002:a05:620a:4728:b0:7d2:28c7:7795 with SMTP id
 af79cd13be357-7d2298d8ad7mr718525085a.35.1749243057388; 
 Fri, 06 Jun 2025 13:50:57 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7d25a536ec9sm186100785a.36.2025.06.06.13.50.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Jun 2025 13:50:56 -0700 (PDT)
Date: Fri, 6 Jun 2025 16:50:54 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>
Subject: Re: [PATCH 19/21] migration: Allow migrate commands to provide the
 migration config
Message-ID: <aENUrociiqlFuPpz@x1.local>
References: <20250603013810.4772-1-farosas@suse.de>
 <20250603013810.4772-20-farosas@suse.de>
 <aENBda_y3v3y4ptS@x1.local> <874iwswrex.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <874iwswrex.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.104,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Jun 06, 2025 at 05:23:18PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Mon, Jun 02, 2025 at 10:38:08PM -0300, Fabiano Rosas wrote:
> >> Allow the migrate and migrate_incoming commands to pass the migration
> >> configuration options all at once, dispensing the use of
> >> migrate-set-parameters and migrate-set-capabilities.
> >> 
> >> The motivation of this is to simplify the interface with the
> >> management layer and avoid the usage of several command invocations to
> >> configure a migration. It also avoids stale parameters from a previous
> >> migration to influence the current migration.
> >> 
> >> The options that are changed during the migration can still be set
> >> with the existing commands.
> >> 
> >> The order of precedence is:
> >> 
> >> 'config' argument > -global cmdline > defaults (migration_properties)
> >
> > Could we still keep the QMP migrate-set-parameters values?
> >
> >   'config' argument > QMP setups using migrate-set-parameters >
> >     -global cmdline > defaults (migration_properties)
> >
> 
> That's the case. I failed to mention it in the commit message. IOW it
> behaves just like today, but the new 'config' way takes precedence over
> all.

Referring to below chunk of code:

[...]

> >> +bool migrate_params_override(MigrationState *s, MigrationParameters *new,
> >> +                             Error **errp)
> >> +{
> >> +    ERRP_GUARD();
> >> +
> >> +    assert(bql_locked());
> >> +
> >> +    /* reset to default parameters */
> >> +    migrate_params_apply(&s->defaults);

IIUC here it'll reset all global parameters using the initial defaults
first, then apply the "config" specified in "migrate" QMP command?

I think there're actually two separate questions to be asked, to make it
clearer, they are:

  (1) Whether we should allow QMP "migrate" 'config' parameter to overwrite
      global setup?

  (2) Whether we should allow previous QMP global setup to be used even if
      QMP "migrate" provided 'config' parameter?

So IIUC the patch does (1) YES (2) NO, while what I think might be more
intuitive is (1) NO (2) YES.

> >> +
> >> +    /* overwrite with the new ones */
> >> +    qmp_migrate_set_parameters(new, errp);
> >> +    if (*errp) {
> >> +        return false;
> >> +    }
> >> +
> >> +    return true;
> >> +}

-- 
Peter Xu


