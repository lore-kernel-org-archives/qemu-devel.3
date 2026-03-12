Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 961AF106ACE4
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 20:30:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0meE-0000bK-6K; Thu, 12 Mar 2026 16:28:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1w0mdw-0000aK-N2
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 16:28:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1w0mdu-0002Qz-BB
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 16:28:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773347304;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WWwSFcJdUqxbgFLWfiU9F/FhiOIvbACd+Yv1F5S21Vg=;
 b=BSFz5IxSKsBK9LApe+KSF2eeMx1mbxTKiKrNIjMOmBCrS/A04tGhv8Q+GlmkRPpHHsXx4h
 ShMqsdQYgwFF3TW0OORANRH6qmPW/7k0IuqVutTz4Kqv1QVKh5EUO0l6TFkh+FYIpYY7y6
 OZ5aDa8w3W6GsM0v8WIdbokNUkGGDU8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-381-2MTrKeABP1CACChhWt0z6Q-1; Thu,
 12 Mar 2026 16:28:20 -0400
X-MC-Unique: 2MTrKeABP1CACChhWt0z6Q-1
X-Mimecast-MFC-AGG-ID: 2MTrKeABP1CACChhWt0z6Q_1773347298
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 30DD418002CD; Thu, 12 Mar 2026 20:28:17 +0000 (UTC)
Received: from redhat.com (unknown [10.45.224.33])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C3CA930002DA; Thu, 12 Mar 2026 20:28:13 +0000 (UTC)
Date: Thu, 12 Mar 2026 20:28:10 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 mcascell@redhat.com, security@1seal.org,
 qemu-stable <qemu-stable@nongnu.org>
Subject: Re: [PATCH] hyperv/syndbg: check length returned by
 cpu_physical_memory_map() [Fixes: CVE-2026-3842]
Message-ID: <abMhvEk9b-Q5u08D@redhat.com>
References: <20260309190155.80619-1-pbonzini@redhat.com>
 <e653dfe8-f522-4978-a4cf-953b14b8eb87@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e653dfe8-f522-4978-a4cf-953b14b8eb87@tls.msk.ru>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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

On Thu, Mar 12, 2026 at 10:34:20PM +0300, Michael Tokarev wrote:
> On 09.03.2026 22:01, Paolo Bonzini wrote:
> > If cpu_physical_memory_map() returns a length shorter than the one
> > that was passed into the function, writing the full out_len bytes
> > causes an access beyond the memory allocated to the guest; or in
> > the case of the MMIO bounce buffer, an out-of-bounds access in a
> > heap-allocated object.
> > 
> > Add a check similar to the one already in handle_send_msg(),
> > and take the occasion to remove repeated computations of
> > recv_byte_count + UDP_PKT_HEADER_SIZE and clarify that the
> > code does not write past out_len bytes.
> > 
> > Reported-by: Oleh Konko <https://github.com/1seal>
> > Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> 
> I'm picking this up for qemu stable series.
> Please let me know if I shouldn't :)

Yes, as a security fix it should go to stable too

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


