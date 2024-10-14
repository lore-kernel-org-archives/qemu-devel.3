Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B513ECFC538
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2024 10:29:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0IJu-0000zg-Ne; Mon, 14 Oct 2024 06:28:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t0IJt-0000zJ-4s
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 06:28:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t0IJq-00045g-AU
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 06:28:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728901732;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=pxoJw4Dit4f5xXcyPaILxt4ZLcVeZ8BdWhn9kl+0N2U=;
 b=R8NeZQ8sVUe4+XsqK9Nkwq+rn5kUtlX/EFavKbIVN+enRdwb9ydpG+Th7R2CerwcbT7RzM
 m7cTHHrIaj5i2QGWMvFZnxx3Tz6AfPgd4K0Piybncdc9ydG0booXqQy/gBReN44FaMmsdb
 /y6vBqXrajRjit4SqbI0xtWrzeFeBD8=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-195-U_Ix489hO1KraR86EFtVmg-1; Mon,
 14 Oct 2024 06:28:49 -0400
X-MC-Unique: U_Ix489hO1KraR86EFtVmg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2D6071955EE7; Mon, 14 Oct 2024 10:28:48 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.155])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 304E41955EA2; Mon, 14 Oct 2024 10:28:45 +0000 (UTC)
Date: Mon, 14 Oct 2024 11:28:42 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Alexander Graf <graf@amazon.com>
Subject: Re: possible bug in recent crypto patches in master branch
Message-ID: <ZwzyWpitEpwpYLfT@redhat.com>
References: <CAFfO_h4Byz-RNv+HjTnbmo0NWL_BA4JM_3c_7ecFWa0wE21Pkw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFfO_h4Byz-RNv+HjTnbmo0NWL_BA4JM_3c_7ecFWa0wE21Pkw@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.028,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Sun, Oct 13, 2024 at 10:32:36PM +0600, Dorjoy Chowdhury wrote:
> Hi,
> I think there maybe some bugs caused by the recent crypto patches that got
> merged to master. ref:
> https://lore.kernel.org/qemu-devel/CAFEAcA-e_1WFLun2HptTt2bSzXkSMBnxKAK_UzUhwRh_fb66Fg@mail.gmail.com/T/#t
> 
> I think before these patches the "qcrypto_hash_bytes" or
> "qcrypto_hash_bytesv" apis used to behave such that a user of the apis
> could pass his own allocated buffers. In that case, the passed buffers
> would be used to fill in the hash result instead of allocating a new
> buffer. But I think in the master branch now, these apis always allocate
> the result buffer regardless of it's users passing their own buffers or
> not. So this is problematic for wherever the users of the apis are passing
> their own allocated buffers. For example, I see target/i386/sev.c is one
> such api user. Am I missing something here or does this look like it's a
> clear bug?
> 
> If I am correct, I think it makes sense to keep the old behavior of the
> apis where new buffers are not allocated if the user supplies one (I think
> it probably also makes sense if we force the users to always provide the
> bufffer instead of the apis themselves allocating them). I noticed this bug
> in the nitro-enclave work I am doing where rebasing the branch builds but
> the actual behavior is buggy because of this new change of the api
> implementations.

Yes, you're right. The behaviour has changed.

Although the API docs suggested that the 'result' buffer was allocated
internally, they did not explicitly require that, and our impl did
lazy allocation.

I'll work on fixing this and adding test cases for it

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


