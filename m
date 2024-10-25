Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 314BCD0C608
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 13:44:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4Kb5-0002g8-Pt; Fri, 25 Oct 2024 09:43:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t4Kb3-0002fh-Ex
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 09:43:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t4Kb0-0003aS-Pq
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 09:43:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729863797;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yM4Jc1kTE/p9yQj7ck3VFOx4x9mqgjwZu3Fpr9aaRe8=;
 b=e/bNixUcdq8Dsw2KLf02TBe3he5pgNj3fRM6nqk3x32+iuw8no673wQcpKd2MemFlC94JU
 udyYqDEr/9sOJayu0AK0pEX/eOZfqFQgsuAMHTW6bb/tQ9jxhHIlT4oEnKoXc/9cKRGkCt
 X3ojYRkQ4IPq/LIJL2Ko7UmjiuI6SyI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-552-D-h6gWZjNlOt_v1UEl7KIA-1; Fri,
 25 Oct 2024 09:43:14 -0400
X-MC-Unique: D-h6gWZjNlOt_v1UEl7KIA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8B14C19560BA; Fri, 25 Oct 2024 13:43:12 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.164])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1D9B0196BB7D; Fri, 25 Oct 2024 13:43:08 +0000 (UTC)
Date: Fri, 25 Oct 2024 14:43:06 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [RFC V1 00/14] precreate phase
Message-ID: <ZxugavgmHrawXPNQ@redhat.com>
References: <1729178055-207271-1-git-send-email-steven.sistare@oracle.com>
 <b36283ff-2e14-4ee0-a64e-a5c4f9e86534@redhat.com>
 <fd8977f7-2787-4387-81fa-240665d0bf1d@oracle.com>
 <Zxta2w6iu2n_5YBa@redhat.com>
 <922177b7-216f-4176-a57a-a86f32252664@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <922177b7-216f-4176-a57a-a86f32252664@oracle.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.454,
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

On Fri, Oct 25, 2024 at 09:33:51AM -0400, Steven Sistare wrote:
> On 10/25/2024 4:46 AM, Daniel P. Berrangé wrote:
> > On Thu, Oct 24, 2024 at 05:16:14PM -0400, Steven Sistare wrote:
> > > 
> > > Regarding: "what you want is effectively to execute monitor commands
> > > from the migration stream"
> > > 
> > > That is not the goal of this series.  It could be someone else's goal, when
> > > fully developing a precreate phase, and in that context I understand and
> > > agree with your comments.  I have a narrower immediate problem to solve,
> > > however.
> > > 
> > > For CPR, src qemu sends file descriptors to dst qemu using SCM_RIGHTS over
> > > a dedicated channel, then src qemu sends migration state over the normal
> > > migration channel.
> > > 
> > > Dst qemu reads the fds early, then calls the backend and device creation
> > > functions which use them.  Dst qemu then accepts and reads the migration
> > > channel.
> > > 
> > > We need a way to send monitor commands that set dst migration capabilities,
> > > before src qemu starts the migration.  Hence the dst cannot proceed to
> > > backend and device creation because the src has not sent fd's yet.  Hence
> > > we need a dst monitor before device creation.  The precreate phase does that.
> > 
> > Sigh, what we obviously need here, is what we've always talked about as our
> > long term design goal:
> > 
> > A way to launch QEMU with the CLI only specifying the QMP socket, and every
> > other config aspect done by issuing QMP commands, which are processed in the
> > order the mgmt app sends them, so QEMU hasn't have to hardcode processing
> > of different pieces in different phases.
> > 
> > Anything that isn't that, is piling more hacks on top of our existing
> > mountain of hacks. That's OK if it does something useful as a side effect
> > that moves us incrementally closer towards that desired end goal.
> > 
> > > Regarding: "This series makes this much more complex."
> > > 
> > > I could simplify it if I abandon CPR for chardevs.  Then qemu_create_early_backends
> > > and other early dependencies can remain as is.  I would drop the notion of
> > > a precreate phase, and instead leverage the preconfig phase.  I would move
> > > qemu_create_late_backends, and a small part at the end of qemu_init, to
> > > qmp_x_exit_preconfig.
> > 
> > Is CPR still going to useful enough in the real world if you drop chardev
> > support ? Every VM has at least one chardev for a serial device doesn't
> > it, and often more since we wire chardevs into all kinds of places.
> 
> CPR for chardev is not as useful for cpr-transfer mode because the mgmt layer already
> knows how to create and manage new connections to dest qemu, as it would for normal
> migration.
> 
> CPR for chardev is very useful for cpr-exec mode.  And cpr-exec mode does not need any
> of these monitor patches, because old qemu exec's new qemu, and they are never active
> at the same time.  One must completely specify the migration using src qemu before
> initiating the exec.  I mourn cpr-exec mode.
> 
> Which begs the question, do we really need to allow migration parameters to be set
> in the dest monitor when using cpr?  CPR is a very restricted mode of migration.
> Let me discuss this with Peter.

The migration QAPI design has always felt rather odd to me, in that we
have perfectly good commands "migrate" & "migrate-incoming" that are able
to accept an arbitrary list of parameters when invoked. Instead of passing
parameters to them though, we instead require apps use the separate
migreate-set-parameters/capabiltiies commands many times over to set
global variables which the later 'migrate' command then uses.

The reason for this is essentially a historical mistake - we copied the
way we did it from HMP, which was this way because HMP was bad at supporting
arbitrary customizable paramters to commands. I wish we hadn't copied this
design over to QMP.

To bring it back on topic, we need QMP on the dest to set parameters,
because -incoming  was limited to only take the URI.

If the "migrate-incoming" command accepted all parameters directly,
then we could use QAPI visitor to usupport a "-incoming ..." command
that took an arbitrary JSON document and turned it into a call to
"migrate-incoming".

With that we would never need QMP on the target for cpr-exec, avoiding
this ordering poblem you're facing....assuming we put processing of
-incoming at the right point in the code flow

Can we fix this design and expose the full configurability on the
CLI using QAPI schema & inline JSON, like we do for other QAPI-ified
CLI args.

It seems entirely practical to me to add parameters to 'migrate-incoming'
in a backwards compatible manner and deprecate set-parameters/capabilities

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


