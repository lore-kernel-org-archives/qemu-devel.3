Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75AFED6C2AF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2024 21:49:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDW5m-0004Ln-5V; Tue, 19 Nov 2024 16:49:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tDW5k-0004Ld-Co
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 16:49:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tDW5i-0008AU-Nw
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 16:49:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732052936;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Bbr7liDdvwU5HJ4Sl9bpASRIgTMTC4BozFoNgT5Arlo=;
 b=ik3GFOcZqndBRO7vxMck/wb9pn2KBTU2Tfb2vJRM9YNbkY/CN0tAh1aPggw0iff7sWJC6f
 8GObqpyyD0rBYRmRysHPmsH3PQ1tQ2i44/HZYK0oatsfZYklaiDVZ4AOwk/LsjmitEp3ea
 yvlJRzpusOxODBQ9DpED5yhGKznGZlw=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-25-HBCYWG2ANvigt63bliNQNA-1; Tue, 19 Nov 2024 16:48:53 -0500
X-MC-Unique: HBCYWG2ANvigt63bliNQNA-1
X-Mimecast-MFC-AGG-ID: HBCYWG2ANvigt63bliNQNA
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7b35b1e7ecaso41764285a.1
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2024 13:48:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732052933; x=1732657733;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bbr7liDdvwU5HJ4Sl9bpASRIgTMTC4BozFoNgT5Arlo=;
 b=OVUxzK8DdmczjUb5Z5pIvMIQf1mdNOlZJfM9akb1PzM5MlLDRvx4DuQ0UDfHOtporV
 JLFh8TCtgbUwv43NCy0yb7PvbCRumJmvgMKIgPvBWWt6ms9aLCpO9ScAcHQzCimJNiJs
 wIOSdWOyhKRffj3rYsqSYf2lOO61OSMm7s/GGZ6W+M7hNNJz1XKsGIatxuKNTQZgmZBF
 /evZxvlPrhv0pwow7vFKJ3Sq59iz8roflTXTJaPKUGWWqqMps934njFbanCGeiAyNZTK
 ptc+oNCGV6g9VPlAzM/JizHFtVxqlNGNvsWH6cDTqq+BKjx2fasWu26oDBE4unGlZDQ7
 wkRQ==
X-Gm-Message-State: AOJu0Yx0WFeRMD+ciuP4JN00MxSiqg/y/tclsy1WNWg+a/c0QPQS2Exp
 8kk1cPmsLnCdbqZj0lquLAoawXA6MmBtNPPwe/p6Qn0V/pb2Uf2U+D8+8zAGJ7TFeu34fBGJyDO
 ucCJlSRKfA9vTgqtgDqr1gaUxb3qVjwznMY1fqWv0wv4U8AF6Q7PK
X-Received: by 2002:a05:620a:400d:b0:7b1:3ff2:697a with SMTP id
 af79cd13be357-7b41e415e55mr121685285a.17.1732052932706; 
 Tue, 19 Nov 2024 13:48:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGwgKYQFadXjwqGRFrcwdkLzcs9XY7ZxpLMZcnOPFb49UpuWjdPL+BzFYT4+8ZKsCzeOzSEng==
X-Received: by 2002:a05:620a:400d:b0:7b1:3ff2:697a with SMTP id
 af79cd13be357-7b41e415e55mr121682385a.17.1732052932397; 
 Tue, 19 Nov 2024 13:48:52 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b485251000sm6466485a.126.2024.11.19.13.48.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2024 13:48:51 -0800 (PST)
Date: Tue, 19 Nov 2024 16:48:49 -0500
From: Peter Xu <peterx@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH V3 11/16] migration: cpr-transfer mode
Message-ID: <Zz0HwfIDucF7yssl@x1n>
References: <ZzUg9w0Kvfuleuxk@x1n>
 <51967cb2-05ec-485b-a639-8ff58d565604@oracle.com>
 <ZzZJvTldpe3D4EO5@x1n>
 <c53feba3-d448-4494-8dbf-0725a2dd8dba@oracle.com>
 <ZzzyOJT_mDh37_Py@x1n>
 <c56ffc81-b065-4dd0-ab06-eb79912dcaf7@oracle.com>
 <Zzz6NVoJss4JdEHh@x1n>
 <8c56ac9c-c86a-48c1-9172-8f014220c37d@oracle.com>
 <Zz0DJ3RB-bVofkmo@x1n>
 <5860c0d6-98d2-4f52-8a0a-e161a6205ba7@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5860c0d6-98d2-4f52-8a0a-e161a6205ba7@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.14,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On Tue, Nov 19, 2024 at 04:41:07PM -0500, Steven Sistare wrote:
> On 11/19/2024 4:29 PM, Peter Xu wrote:
> > On Tue, Nov 19, 2024 at 04:03:08PM -0500, Steven Sistare wrote:
> > > On 11/19/2024 3:51 PM, Peter Xu wrote:
> > > > On Tue, Nov 19, 2024 at 03:32:55PM -0500, Steven Sistare wrote:
> > > > > This begs the question, should we allow channels to be specified in hmp migrate
> > > > > commands and for -incoming, in a very simple way?  Like with a prefix naming
> > > > > the channel.  And eliminate the -cpr-uri argument. Examples:
> > > > > 
> > > > > (qemu) migrate -d main:tcp:0:44444,cpr:unix:cpr.sock
> > > > > 
> > > > > qemu -incoming main:tcp:0:44444,cpr:unix:cpr.sock
> > > > > qemu -incoming main:defer,cpr:unix:cpr.sock
> > > > 
> > > > IMHO keeping the old syntax working would still be nice to not break
> > > > scripts.
> > > 
> > > The channel tag would be optional, so backwards compatible.  Its unambiguous
> > > as long as the channel names are not also protocol names.
> > 
> > Ah that's ok then.  Or maybe use "="?
> > 
> >    "main=XXX,cpr=XXX"
> > 
> > Then if no "=" it's the old?
> 
> Sure, that works.
> 
> > > > I was thinking we could simply add one more parameter for taking
> > > > cpr uri, like:
> > > > 
> > > >       {
> > > >           .name       = "migrate",
> > > >           .args_type  = "detach:-d,resume:-r,uri:s,cpr:s?",
> > > >           .params     = "[-d] [-r] uri [cpr_uri]",
> > > >           .help       = "migrate to URI (using -d to not wait for completion)"
> > > > 		      "\n\t\t\t -r to resume a paused postcopy migration",
> > > > 		      "\n\t\t\t Setup cpr_uri to migrate with cpr-transfer",
> > > >           .cmd        = hmp_migrate,
> > > >       },
> > > 
> > > That's fine.
> > > 
> > > I do like the incoming syntax, though, instead of -cpr-uri.  What do you think?
> > 
> > That'll definitely be lovely if possible, though would any monitor be alive
> > at all before taking a cpr stream, with this series alone?  I thought you
> > dropped the precreate, then QEMU isn't able to run the monitor loop until
> > cpr-uri is loaded.
> 
> No monitor or precreate changes.  I would parse -incoming, extract and use the cpr
> channel early, and use the main channel later as usual.  It's just a different way of
> specifying cpr-uri.  I like it because the specification language is more consistent,
> referring to a "cpr channel" both on the outgoing and incoming side:
> 
>   This mode requires a second migration channel named "cpr", included in
>   the channel arguments of the migrate command on the outgoing side, and
>   in the QEMU -incoming parameter on the incoming side.  The channel must
>   be a type, such as unix socket, that supports SCM_RIGHTS.

Ah, that's ok at least to me.  I hope defer could still work (for Libvirt),
though.  Probably something like main=defer,cpr=XXX.

-- 
Peter Xu


