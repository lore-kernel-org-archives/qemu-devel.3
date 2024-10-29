Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90C4BD2AB1F
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 11:15:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5kAz-0004ix-0Q; Tue, 29 Oct 2024 07:14:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t5kAv-0004ib-EC
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 07:14:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t5kAr-0001A3-8Y
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 07:14:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730200447;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/TcozZBp0VGOgekA5uxAdPTvfe1eh9LF3wSqhh9DvGM=;
 b=HjK2aZFiFtqumYPJLT/b4U3XaRFdkXEF3iDIZF+CHjpgu3iazvYdAFj0Qbm/2aAUmdvSiR
 yvu1xd4fTPUWlrGt2QWKAKgP5unQfcKpKhC0lnCLC04qhgmWjY7jMdNAS3J/rWOnLRByFc
 VXPhO+FnuCieoA2Kfc+2bBIl+1mpkLI=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-684-6caB_2rFNxiv1Oq1mmS5HA-1; Tue,
 29 Oct 2024 07:14:03 -0400
X-MC-Unique: 6caB_2rFNxiv1Oq1mmS5HA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C89891955D95; Tue, 29 Oct 2024 11:14:01 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.142])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 76B3A19560A7; Tue, 29 Oct 2024 11:13:58 +0000 (UTC)
Date: Tue, 29 Oct 2024 11:13:54 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [RFC V1 00/14] precreate phase
Message-ID: <ZyDDcmDoCE_qHgfT@redhat.com>
References: <1729178055-207271-1-git-send-email-steven.sistare@oracle.com>
 <b36283ff-2e14-4ee0-a64e-a5c4f9e86534@redhat.com>
 <fd8977f7-2787-4387-81fa-240665d0bf1d@oracle.com>
 <Zxta2w6iu2n_5YBa@redhat.com>
 <922177b7-216f-4176-a57a-a86f32252664@oracle.com>
 <ZxugavgmHrawXPNQ@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZxugavgmHrawXPNQ@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Oct 25, 2024 at 02:43:06PM +0100, Daniel P. Berrangé wrote:
> 
> The migration QAPI design has always felt rather odd to me, in that we
> have perfectly good commands "migrate" & "migrate-incoming" that are able
> to accept an arbitrary list of parameters when invoked. Instead of passing
> parameters to them though, we instead require apps use the separate
> migreate-set-parameters/capabiltiies commands many times over to set
> global variables which the later 'migrate' command then uses.
> 
> The reason for this is essentially a historical mistake - we copied the
> way we did it from HMP, which was this way because HMP was bad at supporting
> arbitrary customizable paramters to commands. I wish we hadn't copied this
> design over to QMP.
> 
> To bring it back on topic, we need QMP on the dest to set parameters,
> because -incoming  was limited to only take the URI.
> 
> If the "migrate-incoming" command accepted all parameters directly,
> then we could use QAPI visitor to usupport a "-incoming ..." command
> that took an arbitrary JSON document and turned it into a call to
> "migrate-incoming".
> 
> With that we would never need QMP on the target for cpr-exec, avoiding
> this ordering poblem you're facing....assuming we put processing of
> -incoming at the right point in the code flow
> 
> Can we fix this design and expose the full configurability on the
> CLI using QAPI schema & inline JSON, like we do for other QAPI-ified
> CLI args.
> 
> It seems entirely practical to me to add parameters to 'migrate-incoming'
> in a backwards compatible manner and deprecate set-parameters/capabilities

Incidentally, if we were going to evolve the migration API at all, then
it probably ought to start making use of the async job infrastructure
we have available. This is use by block jobs, and by the internal snapshot
commands, and was intended to be used for any case where we had a long
running operation triggered by a command. Migration was a poster-child
example of what its intended for, but was left alone when we first
introduced the job APIs.

The 'job-cancel' API would obsolete 'migrate-cancel'.

The other interestnig thing is that the job framework creates a well
defined lifecycle for a job, that allows querying information about
the job after completeion, but without QEMU having to keep that info
around forever. ie once a job has finished, an app can query info
about completion, and when it no longer needs that info, it can
call 'job-dismiss' to tell QEMU to discard it.

If "MigrationState" were associated a job, then it would thus have a
clear 'creation' and 'deletion' time.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


