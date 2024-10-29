Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDCE9D3A661
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 15:59:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5ocM-0000mm-Al; Tue, 29 Oct 2024 11:58:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t5ocC-0000lc-SI
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 11:58:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t5oc8-00051q-HC
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 11:58:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730217515;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hcyf3TROLo0DWlL1tiKXt/ssAt8I1UoonoFmBwlzSm0=;
 b=UGL9HRHyKcrA5ZryStfmJKQOp7uETbQ4rXRkLP2RB6eNNE12g6244ctGDCPDJYuELtWKbm
 1nFetI4ReB2YVmmSzJkx3YN2I/2kYcWnn1D6dCCThlaBh6C0zeh6Y86aAHYrTq/flOxKaf
 rL7l/K7uc95PKD/UDPfQiBvwys+WmnY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-27-NVcQA1PFPg-xhHKNgE4S9A-1; Tue,
 29 Oct 2024 11:58:33 -0400
X-MC-Unique: NVcQA1PFPg-xhHKNgE4S9A-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 81CEE1955F2E; Tue, 29 Oct 2024 15:58:31 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.142])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B4A5419560AA; Tue, 29 Oct 2024 15:58:27 +0000 (UTC)
Date: Tue, 29 Oct 2024 15:58:24 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Steven Sistare <steven.sistare@oracle.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [RFC V1 00/14] precreate phase
Message-ID: <ZyEGAfcKRdVTMzLy@redhat.com>
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
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.302,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
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

Yeah, I can understand that.

The job API at the QMP level has no association with coroutines. It
simply expresses a way to handle long running background jobs in a
standard manner.

The dependency on coroutines is purely the internal job APIs. I wonder
if it is at all practical to alter the job APIs to allow migration to
use them as it exists today, as the migration code already is quite
capable to running in the background, without adding more coroutine
usage.

It would be quite annoying if our general purpose QMP API cannot be
used because internal only impl limitations :-(

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


