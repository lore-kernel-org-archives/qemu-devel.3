Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57458CCF9FA
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 11:40:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEnTF-0000jB-IY; Fri, 31 Oct 2025 07:39:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vEnT4-0000iU-UM
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 07:38:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vEnSs-0003VD-ND
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 07:38:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761910714;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JsFoRXGCciAkRoT9QCGPDaLQpZa+WB4pDmHO13zgEKg=;
 b=hFUYNjgXGuPCb/0q5S2Ln5lr4YNClEVkDMMTr0BYY5fak9b394xO7h9nQ9VNzXhzmyy1VO
 /pfboRSR8x5Q1l6EACWPClu3qgyiekdk6LeZLmdElIuEpjxOQTSNSqw1tPnTU0MTjkPlnm
 ooPgW8XhzoIaiB9xdePtz5UCm7VCxhU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-610-X9BESOP8N1SDpcxJXEGYpQ-1; Fri,
 31 Oct 2025 07:38:31 -0400
X-MC-Unique: X9BESOP8N1SDpcxJXEGYpQ-1
X-Mimecast-MFC-AGG-ID: X9BESOP8N1SDpcxJXEGYpQ_1761910710
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6EC9819560A5; Fri, 31 Oct 2025 11:38:30 +0000 (UTC)
Received: from redhat.com (dhcp-17-192.lcy.redhat.com [10.42.17.192])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4FAFE1800452; Fri, 31 Oct 2025 11:38:28 +0000 (UTC)
Date: Fri, 31 Oct 2025 11:38:26 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, devel@lists.libvirt.org
Subject: Re: [PATCH 16/21] crypto: deprecate use of external dh-params.pem file
Message-ID: <aQSfsgbmXDgRtBqp@redhat.com>
References: <20251030144927.2241109-1-berrange@redhat.com>
 <20251030144927.2241109-17-berrange@redhat.com>
 <CAMxuvawDsd+w_UFD7VJDq76BNzoEWL0tQvNt_ZC8soPVEdtTRg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMxuvawDsd+w_UFD7VJDq76BNzoEWL0tQvNt_ZC8soPVEdtTRg@mail.gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Fri, Oct 31, 2025 at 03:32:51PM +0400, Marc-André Lureau wrote:
> Hi
> 
> On Thu, Oct 30, 2025 at 6:50 PM Daniel P. Berrangé <berrange@redhat.com>
> wrote:
> 
> > GNUTLS has deprecated use of externally provided diffie-hellman
> > parameters, since it will automatically negotiate DH params in
> > accordance with RFC7919.
> >
> 
> The doc says:
>  Since 3.6.0, DH parameters are negotiated following RFC7919.
> 
> But QEMU doesn't require >= 3.6. Add a preliminary patch?

Oh whoops. I mis-read the meson.build rules. Our gnutls bump
to 3.5.18 was done in:

  commit d4c7ee330cd0ca05cc0c026f845af6711e37b0f7
  Author: Daniel P. Berrangé <berrange@redhat.com>
  Date:   Fri May 14 13:04:09 2021 +0100

    crypto: bump min gnutls to 3.5.18, dropping RHEL-7 support
    
    It has been over two years since RHEL-8 was released, and thus per the
    platform build policy, we no longer need to support RHEL-7 as a build
    target. This lets us increment the minimum required gnutls version
    
    Per repology, current shipping versions are:
    
                 RHEL-8: 3.6.14
          Debian Buster: 3.6.7
     openSUSE Leap 15.2: 3.6.7
       Ubuntu LTS 18.04: 3.5.18
       Ubuntu LTS 20.04: 3.6.13
                FreeBSD: 3.6.15
              Fedora 33: 3.6.16
              Fedora 34: 3.7.1
                OpenBSD: 3.6.15
         macOS HomeBrew: 3.6.15
    

the only one not already on 3.6 was Ubuntu 18.04 and that
is long outside our support matrix. IOW we can easily assume
at least 3.6 these days and this patch is safe on that basis.

I'll prepare another standalone patch to explicit increase
the min version though. Can probably bump gcrypt & nettle min
versions too.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


