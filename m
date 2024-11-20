Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C39F8D711C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2024 16:27:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDnXL-0008EI-Ur; Wed, 20 Nov 2024 11:26:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tDnXK-0008E5-6U
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 11:26:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tDnXI-0002ry-FB
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 11:26:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732119992;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wZHAT265Emdk3sie3jF9Z8/5I7LNCj/9GaSPNcwhcXE=;
 b=D7o2E4M8wUXf1sWC0NDB13yolIVJn7j8BQ9hf3YUNSqoe0LwrcrLfvCX5ojU6wNvS+RYlD
 +1pV0BJYFpEEvLFhRM8PSAGqvZvvIlYe6adUVlzD3UGwxdG9uD0ITsu3GbcAflnNWo/466
 ofN4dm2x5E3KfEn9tAvYUUFqzB7E3h8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-80-uUqsketfOf6IDlifehVX4A-1; Wed,
 20 Nov 2024 11:26:27 -0500
X-MC-Unique: uUqsketfOf6IDlifehVX4A-1
X-Mimecast-MFC-AGG-ID: uUqsketfOf6IDlifehVX4A
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A5D241954B10; Wed, 20 Nov 2024 16:26:25 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.50])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 14A4919560A3; Wed, 20 Nov 2024 16:26:20 +0000 (UTC)
Date: Wed, 20 Nov 2024 16:26:17 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH V3 11/16] migration: cpr-transfer mode
Message-ID: <Zz4NqcTDK73MKOaa@redhat.com>
References: <1730468875-249970-1-git-send-email-steven.sistare@oracle.com>
 <1730468875-249970-12-git-send-email-steven.sistare@oracle.com>
 <ZzUg9w0Kvfuleuxk@x1n>
 <51967cb2-05ec-485b-a639-8ff58d565604@oracle.com>
 <ZzZJvTldpe3D4EO5@x1n>
 <c53feba3-d448-4494-8dbf-0725a2dd8dba@oracle.com>
 <ZzzyOJT_mDh37_Py@x1n>
 <c56ffc81-b065-4dd0-ab06-eb79912dcaf7@oracle.com>
 <Zz2uAWLAhaf2TQ01@redhat.com>
 <fc5397de-8955-452e-87da-c5887e7f690d@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fc5397de-8955-452e-87da-c5887e7f690d@oracle.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Nov 20, 2024 at 11:12:51AM -0500, Steven Sistare wrote:
> On 11/20/2024 4:38 AM, Daniel P. Berrangé wrote:
> > On Tue, Nov 19, 2024 at 03:32:55PM -0500, Steven Sistare wrote:
> > > 
> > > This begs the question, should we allow channels to be specified in hmp migrate
> > > commands and for -incoming, in a very simple way?  Like with a prefix naming
> > > the channel.  And eliminate the -cpr-uri argument. Examples:
> > > 
> > > (qemu) migrate -d main:tcp:0:44444,cpr:unix:cpr.sock
> > > 
> > > qemu -incoming main:tcp:0:44444,cpr:unix:cpr.sock
> > > qemu -incoming main:defer,cpr:unix:cpr.sock
> > 
> > As a general rule, if you ever find yourself asking "should we add more
> > magic parsing logic" to the command line argv, the answer should always
> > be 'no'.
> > 
> > Any command line args where we need to have more expressive formatting
> > are getting converted to accept JSON syntax, backed by QAPI modelling.
> > We were anticipating that '-incoming' should ideally end up deprecated
> > except for the plain "defer" option, on the expectation that any non-
> > trivial use of migration needs HMP/QMP regardless. If there's a vaild
> > use case for something other than 'defer', then we need to QAPI-ify
> > -incoming with JSON syntax IMHO.
> 
> Hi Daniel, thank you for the guidance.
> 
> CPR needs to open and read its channel before the monitor is available,
> so the cpr uri must be passed on the command line in some form.  Is that
> sufficient reason to violate your general rule?

Not really. IMHO it is still viable to define a CLI arg using JSON and
QAPI, even if there's no need to use it from QMP.

> If not, would you support the -cpr-uri command-line option?
> 
> If not, that leaves us with QAPI-ifying -incoming, which is messy, because
> MigrationChannel has a nested type structure.  We would need to define
> a flattened list of properties and duplicate much of the existing specification.
> Unless, it could take a JSON object as its value, with all the {}:" syntax,
> and be parsed with visit_type_MigrationChannel.  But I do not see any
> precedent for that in other command-line arguments.

Using JSON syntax exclusively is exactly what I'm suggesting. While some
command line args have invented ways to express nested types, we don't
really want to be in that business anymore. Anything complex should be
JSON syntax on the command line. We support this with -object, -device,
-audiodev, -netdev, -blockdev already, and eventually expect everything
to support JSON syntax.

You can see this in practice in libvirt, where we'll prefer JSON syntax
for any args that support it:

  https://gitlab.com/libvirt/libvirt/-/blob/master/tests/qemuxmlconfdata/x86_64-q35-graphics.x86_64-latest.args

The approach to retrofitting to an existing cli arg is pretty crude but
effective in QEMU. Just look if the first character is '{' and if so,
switch to QAPI based parsing instead of legacy parsing.

> Of these, I still think "qemu -incoming main:tcp:0:44444,cpr:unix:cpr.sock"
> is the least worst option.  We could further simplify it by allowing the
> option multiple times, and only recognizing the additional "cpr" prefix.
> 
>   qemu -incoming tcp:0:44444 -incoming cpr:unix:cpr.sock
>   qemu -incoming defer -incoming cpr:unix:cpr.sock
> 
> Your further comments, please.  I need a way forward that you and other
> maintainers will support.

In terms of where we wire up CPR, -incoming or -cpr-uri is fairly
arbitrary and I'm not seeing (easy) better answers.

The (hard) better answer, would potentally be to leverage '-object'
to create the migration state object but that would be a massive
pile of work, that is unreasonable to ask you to experiment with.

> 
> > Yes, there's still the question of HMP, but personally I'm fine with
> > leaving feature gaps in HMP and expecting people to use QMP. HMP shares
> > all the same flaws as our old approach to the CLI, of needing to invent
> > arbitrary magic syntaxes which has proved to be an undesirble path to
> > take in general. I see HMP as being there for the 80% common / simple
> > cases, and if you need to go beyond that, then QMP is there for you.
> 
> Fine with me.
> 
> - Steve
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


