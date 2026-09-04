Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFBB9C624DE
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 11:27:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2S4v-00038B-KI; Fri, 04 Sep 2026 07:27:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x2S4u-00037t-Cr
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 07:27:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x2S4s-00050W-Nh
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 07:27:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788521245;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n1iClS1gBHzvSLVyH+hmWNvJU7P0IY0m88uFzAkOhaM=;
 b=CvqNFsYCsUFbwSMVE0MBJ7zb5WpZfqp3jLQOAwJn2twzDg6oDvzg1OwYAWIAKp3NM1jFhf
 jbVLqr1Q4Fw7pO0P517PEbUxpccSGb6yH8qzruNI+18OGj+TLcyQn1xXDK70+pgWssyqtT
 RvSEhqScSrJz1YyEYCgVBpTkPJ04jGU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-351-Y8p1-bDjPduF0hNBVgYVQA-1; Fri,
 04 Sep 2026 07:27:22 -0400
X-MC-Unique: Y8p1-bDjPduF0hNBVgYVQA-1
X-Mimecast-MFC-AGG-ID: Y8p1-bDjPduF0hNBVgYVQA_1788521241
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 52B8F191F5B8; Fri,  4 Sep 2026 11:27:20 +0000 (UTC)
Received: from redhat.com (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E7FBE423; Fri,  4 Sep 2026 11:27:17 +0000 (UTC)
Date: Fri, 4 Sep 2026 12:27:15 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, luoyonggang@gmail.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-devel@nongnu.org, anjo@rev.ng,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 philmd@oss.qualcomm.com, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 00/47] single-binary: implement dynamic filtering for QOM
 types
Message-ID: <apqrE4dj6WesobJv@redhat.com>
References: <20260828225901.367438-1-pierrick.bouvier@oss.qualcomm.com>
 <4b4f77ee-21e9-405e-a1da-21506afa1c5b@oss.qualcomm.com>
 <app_CnHimOrOymMH@redhat.com>
 <CAE2XoE9A1WzOe43-qd1v9i6K9kSru4R2kEE1-2TrztoM=8NZJw@mail.gmail.com>
 <CAFEAcA_4TZxYhFbHfJZCas7bvh_KZjNp2aKzx3LPaXTQFuoQYQ@mail.gmail.com>
 <apqVhJrtMDECUb7I@redhat.com> <87h5k58ds8.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87h5k58ds8.fsf@pond.sub.org>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
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

On Fri, Sep 04, 2026 at 01:19:19PM +0200, Markus Armbruster wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > Currently the QOM type name is directly derived from the machine
> > type name, just with a "-machine" suffix attached. So if the
> > machine name is not unique, then neither is the QOM type name.
> >
> > At the very least we need the QOM type name to be unique. We
> > could de-couple the two to make this work though, which does
> > not seem too hard.
> 
> [...]
> 
> > We don't have many examples of clashing machine names. Is there
> > any beyond just the 'virt' boards ? Now that we know we want
> > globally unique names, this feels easy enough to spot during
> > review.
> 
> I checked -machine help for all qemu-system-T, and it seems to be just
> "none", "virt" and "virt-VERSION", not counting duplicates between
> architecture variants such as aarch64 and arm, x86_64 and i386, and so
> forth.
> 
> >> This rests on the assumption that the only thing we need to
> >> disambiguate is machine names, i.e. there aren't multiple
> >> targets with user-facing (i.e. not easily renameable) device
> >> names that are shared.
> >
> > IMHO it is best if our goal is to ensure type names are unique
> > throughout the codebase, so hopefully we don't have clashing
> > device names.
> 
> Yes.
> 
> Quick glance at type_new():
> 
>     if (type_table_lookup(info->name) != NULL) {
>         fprintf(stderr, "Registering `%s' which already exists\n", info->name);
>         abort();
>     }
> 
> If we have duplicate type names, they won't survive being linked
> together in a single binary.

If we want perfect testing coverage, then the main constraint here
is how quickly we get to a point where 'qemu-system' can build with
all targets. I don't that's a show stopper though, as the uniqueness
only becomes a real problem as we enable each new target in the single
binary. We don't appear to have many examples of existing clashes to
suggest it is a major problem to solve any sooner.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


