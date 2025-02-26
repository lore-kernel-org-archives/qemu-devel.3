Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43747C021BF
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 14:02:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnHz3-0000MZ-Rz; Wed, 26 Feb 2025 09:01:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tnHyz-0000L2-7n
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 09:01:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tnHyw-0005Uh-VA
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 09:01:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740578508;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JVidmizNCbJ6EeULW6eQNsp/dmDqZvnm0SJwNyQKgKA=;
 b=cHg6TZ5wJKTn42zXgcpDkPc+ExZ0UF8RhawIP9DHqGijNvk5YPLGY9oCYVdeucImm25j+w
 ROqoMPPbOxJTnErey0PLOW/NpWWSq2UWP2IoRwySMAx4Zz/UrMG1c4o/9+CE6ow5p8e72R
 a/hWhnjDwbC0ulyzgU5C5XdMoIJ/zJA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-99-atyDhawKM7q2IXqhA5-wvw-1; Wed,
 26 Feb 2025 09:01:46 -0500
X-MC-Unique: atyDhawKM7q2IXqhA5-wvw-1
X-Mimecast-MFC-AGG-ID: atyDhawKM7q2IXqhA5-wvw_1740578505
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 75FBD1975AFC
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2025 14:01:44 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.113])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D1ED21955BD4; Wed, 26 Feb 2025 14:01:42 +0000 (UTC)
Date: Wed, 26 Feb 2025 14:01:39 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH 0/2] vfio: Restrict to 64-bit host platforms
Message-ID: <Z78ew0NSNMNmcM0W@redhat.com>
References: <20250226084721.232703-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250226084721.232703-1-clg@redhat.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.44,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Feb 26, 2025 at 09:47:19AM +0100, Cédric Le Goater wrote:
> Hello,
> 
> This series avoids compiling VFIO on 32-bit host platforms where it is
> not needed.

If it was previously enabled on 32-bit and was possible to successfully
build & use, then it needs to go through the deprecation process - we
can't just rip out features with no prior warning.

In any case this recently merged:

  commit 6d701c9bac1d3571e9ad511e01b27df7237f0b13
  Author: Richard Henderson <richard.henderson@linaro.org>
  Date:   Mon Jan 27 16:22:24 2025 -0800

    meson: Deprecate 32-bit host support
    
    We deprecated i686 system mode support for qemu 8.0.  However, to
    make real cleanups to TCG we need to deprecate all 32-bit hosts.

so 32-bit host support in general is nearing end of life. Given that,
I don't think we need to further limit 32-bit host for individual
features, just let it die all at once.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


