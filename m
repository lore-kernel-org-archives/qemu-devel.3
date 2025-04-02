Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0286C28B20
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 13:32:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzyBw-0007Ho-HQ; Wed, 02 Apr 2025 09:31:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tzyBc-0007G9-Ey
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 09:31:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tzyBa-0005EQ-Ir
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 09:31:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743600676;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=sL//N7w8e4N738m/1EfuSP5BsWXiGLZf4rKjqq1g1Bk=;
 b=Xa1uKAQNfJ/87sPXdh8Px3e26kSedvDsVw0kKcfLSt2JUM/NDK7R9OkSzAo4vSSA/GKfa+
 61k2OFe8wtaDyuyiLDngq0NPoOn4TzJIlAlNx66CnYJ1HmUIzYy2cIqTxgALMHbXsuKcFR
 jBJAjQhu/DmtFpsLi9IqqQAVw+gjVVk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-448-CUSO4-rlM7WRYM-_jmtJ2Q-1; Wed,
 02 Apr 2025 09:31:11 -0400
X-MC-Unique: CUSO4-rlM7WRYM-_jmtJ2Q-1
X-Mimecast-MFC-AGG-ID: CUSO4-rlM7WRYM-_jmtJ2Q_1743600670
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C6DEA19560B6; Wed,  2 Apr 2025 13:31:08 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.12])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E3CAA180A803; Wed,  2 Apr 2025 13:31:07 +0000 (UTC)
Date: Wed, 2 Apr 2025 14:31:04 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Pierre-Samuel LE STANG <pierre-samuel.le-stang@ovhcloud.com>
Cc: qemu-devel@nongnu.org
Subject: Re: smbios entry point auto on pc-i440fx
Message-ID: <Z-08GHW6EvlzyMky@redhat.com>
References: <20250402123601.4nfw6bxk6apphpvw@corp.ovh.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250402123601.4nfw6bxk6apphpvw@corp.ovh.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.153,
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

On Wed, Apr 02, 2025 at 02:36:01PM +0200, Pierre-Samuel LE STANG wrote:
> Hello team, 
> 
> I'm facing the issue of windows instances not beeing able of retrieving
> the uuid because of smbios 3.0 (qemu 8.2 on debian openstack/libvirt).
> The instances are of pc-i440fx-8.2 machine type.
> 
> If I understand well since 8.1 qemu use a 64bit format for the smbios
> v3 which is not handle by windows OS.
> 
> I also found some commit about handling automatically the format by qemu
> on q35 machine type to resolve this bug startting to 9.0.0 version
> https://gitlab.com/qemu-project/qemu/-/issues/2008 
> 
> It seems forced to 64 bit on pc-i440fx-8.1 and above while forced to 32
> under.
> 
> Is there a reason to not handle it automatically on pc-i440fx machine
> type?

That is done since:

  commit 2c7c45b3d0ba097ac99bf4b9a13c6de1d7724032
  Author: Igor Mammedov <imammedo@redhat.com>
  Date:   Thu Mar 14 16:23:00 2024 +0100

    pc/q35: set SMBIOS entry point type to 'auto' by default
    
    Use smbios-entry-point-type='auto' for newer machine types as a workaround
    for Windows not detecting SMBIOS tables. Which makes QEMU pick SMBIOS tables
    based on configuration (with 2.x preferred and fallback to 3.x if the former
    isn't compatible with configuration)
    
    Default compat setting of smbios-entry-point-type after series
    for pc/q35 machines:
      * 9.0-newer: 'auto'
      * 8.1-8.2: '64'
      * 8.0-older: '32'

> Is it safe to keep it to 32 for machine type pc-i440fx-8.1 and above?

Once QEMU ships a particular machine type version, it is fixed and
we cannot change its defaults. Hence the "auto" choice of SMBIOS
entrypoint is only done for 9.0 or newer machine types.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


