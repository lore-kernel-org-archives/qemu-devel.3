Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2648D3A66B
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 15:19:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5nzg-0004Eq-E1; Tue, 29 Oct 2024 11:18:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t5nzd-0003un-EX
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 11:18:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t5nza-0000Jr-Q6
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 11:18:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730215124;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VqVxXgeikV2TEvtpqRzGiATRxx9H5fvTmokCIQyQaWE=;
 b=OPdGqaqmG36VzolAH7h9yppa4YvG59lXc2XCOxph5BqZ+qNlQWbw89wOyoxQJMw9D9pr9I
 9324/ln5HX5ACiDIDbzz/FG6tPmwFrqsAISXgAB332HdVoyMPccLBK9N9fcKDnqMtXeCrh
 DbGvt5wqkzIsXiCHl4RLurkhFjXR5AI=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-NcsmZdfNNmWdLR_ACLo1Sg-1; Tue, 29 Oct 2024 11:18:39 -0400
X-MC-Unique: NcsmZdfNNmWdLR_ACLo1Sg-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6ce240afa87so83775526d6.2
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2024 08:18:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730215118; x=1730819918;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VqVxXgeikV2TEvtpqRzGiATRxx9H5fvTmokCIQyQaWE=;
 b=vf/TXxMrY0mxR9qNCuEhtsSt1LGI60L7AzRyaTMz4wmpcuHbiJwZNyngm8BXWW4JNQ
 VvHNl1H02VVlVCI92TIeNb+8UtvO7ipTqlSjT0CGIXc4oxQYQo03HQ7msvKh3xk7LI9y
 nGvSBnDfvMM1dNJo64Dmhw0u9Dsb7wyZjxTezOmtjSvHtYme4UmipB2/mYhFjQGvkxfG
 SlmFUUdhlcsgtt2wjUPHIouSYdmgzhMGDvka5eE0U/umXFSHUZr8W8mjjq/bTy38sfnR
 QV64EXp0eGL4/CkGRaJjYuo9Jo9uJVUcjQ8bRbDq9Ogl8dMdKF9ajMRE1mYAt00U76xv
 LEOw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/q+N5vY9lJyTitFonCCQVHMknHxaQ3bdGClV+QLcrnXdhzKBHa27ldvwc5C6D92x3cOrcK85YT5Q7@nongnu.org
X-Gm-Message-State: AOJu0Yw3d4fb+hL5x6fLPMCqO/Qtes3jk5vTkv0jmuSrWaOs5MzmrzCc
 ge5ihB9dp+Xu0fJZLUOEN1dLbPj7B9PCQLyVQiOh2uRrn14DThWc+flUb+0Vf9uceov6e/8Qb5O
 o5QAWcVio5bQ+exjDHV/KKpwNJpr52ZnDCE1x6GrCytJp0oT/5umv
X-Received: by 2002:a05:6214:4b04:b0:6ce:34d5:8882 with SMTP id
 6a1803df08f44-6d18583d232mr219217106d6.39.1730215117919; 
 Tue, 29 Oct 2024 08:18:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPaRTwYPt7r5ZAdUTqpT4n3pVViJMGXQs9k8er4Z3jGogO2DhJ2j/B5RIBTfX7miZGVv4aww==
X-Received: by 2002:a05:6214:4b04:b0:6ce:34d5:8882 with SMTP id
 6a1803df08f44-6d18583d232mr219216636d6.39.1730215117468; 
 Tue, 29 Oct 2024 08:18:37 -0700 (PDT)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d1798a839bsm42813146d6.36.2024.10.29.08.18.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2024 08:18:37 -0700 (PDT)
Date: Tue, 29 Oct 2024 11:18:35 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Steven Sistare <steven.sistare@oracle.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [RFC V1 00/14] precreate phase
Message-ID: <ZyD8y9kHijkTFn7K@x1n>
References: <1729178055-207271-1-git-send-email-steven.sistare@oracle.com>
 <b36283ff-2e14-4ee0-a64e-a5c4f9e86534@redhat.com>
 <fd8977f7-2787-4387-81fa-240665d0bf1d@oracle.com>
 <Zxta2w6iu2n_5YBa@redhat.com>
 <922177b7-216f-4176-a57a-a86f32252664@oracle.com>
 <ZxugavgmHrawXPNQ@redhat.com> <ZyDDcmDoCE_qHgfT@redhat.com>
 <878qu7cag7.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <878qu7cag7.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.302,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Oct 29, 2024 at 10:20:24AM -0300, Fabiano Rosas wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > On Fri, Oct 25, 2024 at 02:43:06PM +0100, Daniel P. Berrangé wrote:
> >> 
> >> The migration QAPI design has always felt rather odd to me, in that we
> >> have perfectly good commands "migrate" & "migrate-incoming" that are able
> >> to accept an arbitrary list of parameters when invoked. Instead of passing
> >> parameters to them though, we instead require apps use the separate
> >> migreate-set-parameters/capabiltiies commands many times over to set
> >> global variables which the later 'migrate' command then uses.
> >> 
> >> The reason for this is essentially a historical mistake - we copied the
> >> way we did it from HMP, which was this way because HMP was bad at supporting
> >> arbitrary customizable paramters to commands. I wish we hadn't copied this
> >> design over to QMP.
> >> 
> >> To bring it back on topic, we need QMP on the dest to set parameters,
> >> because -incoming  was limited to only take the URI.
> >> 
> >> If the "migrate-incoming" command accepted all parameters directly,
> >> then we could use QAPI visitor to usupport a "-incoming ..." command
> >> that took an arbitrary JSON document and turned it into a call to
> >> "migrate-incoming".
> >> 
> >> With that we would never need QMP on the target for cpr-exec, avoiding
> >> this ordering poblem you're facing....assuming we put processing of
> >> -incoming at the right point in the code flow
> >> 
> >> Can we fix this design and expose the full configurability on the
> >> CLI using QAPI schema & inline JSON, like we do for other QAPI-ified
> >> CLI args.
> >> 
> >> It seems entirely practical to me to add parameters to 'migrate-incoming'
> >> in a backwards compatible manner and deprecate set-parameters/capabilities
> >
> > Incidentally, if we were going to evolve the migration API at all, then
> > it probably ought to start making use of the async job infrastructure
> > we have available. This is use by block jobs, and by the internal snapshot
> 
> I'm all for standardization on core infrastructure, but unfortunately
> putting migration in a coroutine would open a can of worms. In fact,
> we've been discussing about moving the incoming side out of coroutines
> for a while.

Yes, I share the same concern.  I think migration decided to go already
with as much thread model as possible that it can.

And I paused that attempt to move load() into a thread, as of now, finding
it's still non-trivial to work out the major issue: after dest load became
a thread, it means it can't take BQL for too long otherwise it blocks the
monitor.

It means we can't take bql for _any_ IO operation because it can stuck at
any IO waiting for the iochannel / NIC, aka, any qemu_get*() API invoked.

Meanwhile we still trivially need the bql from time to time, either in
pre_load() / post_load(), or some of VMStateInfo->get().  But still I can't
blindly take them, as in any VMStateInfo->get(), it can invoke qemu_get*()
itself.

So I am not sure whether what we can get from that is worthwhile yet on the
effort to make it work..

> 
> > commands, and was intended to be used for any case where we had a long
> > running operation triggered by a command. Migration was a poster-child
> > example of what its intended for, but was left alone when we first
> > introduced the job APIs.
> >
> > The 'job-cancel' API would obsolete 'migrate-cancel'.
> >
> > The other interestnig thing is that the job framework creates a well
> > defined lifecycle for a job, that allows querying information about
> > the job after completeion, but without QEMU having to keep that info
> > around forever. ie once a job has finished, an app can query info
> > about completion, and when it no longer needs that info, it can
> > call 'job-dismiss' to tell QEMU to discard it.
> >
> > If "MigrationState" were associated a job, then it would thus have a
> > clear 'creation' and 'deletion' time.

It'll face the same challenge here on whether we can join() in the main
thread.  IOW, job-cancel can take time which can also potentially block
qemu from quitting fast.

-- 
Peter Xu


