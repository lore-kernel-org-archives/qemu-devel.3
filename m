Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D097C54E49
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 09:48:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riAMG-0008Sv-Qw; Thu, 07 Mar 2024 04:48:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1riAMD-0008SF-Ta
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 04:48:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1riAMA-00059e-UH
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 04:48:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709804886;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=moISXf3TJdK06yo5wUypoGypKCpJCTMRSJZq1HR0XBc=;
 b=Y7ozKSkHRUyQNOXaeJ6rdgiRd+iXgaKAL7upydlVzlCAg6Lu9h5NX2ecxpnxccJcqeP6D9
 d+WMohormyTA1hs3NF+Vk6VcxFEqeYqaXFu3ms96jtX9nN0jlZqJLnMUXmYkmKQ7Z1qC5e
 r86VXWTK+oMi0FWKtcxYe7o9cRItQAA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-63-vYCcUHyGNyeUrD4NKPepxA-1; Thu, 07 Mar 2024 04:48:02 -0500
X-MC-Unique: vYCcUHyGNyeUrD4NKPepxA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 708C9811E81;
 Thu,  7 Mar 2024 09:48:02 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.51])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C753337F6;
 Thu,  7 Mar 2024 09:48:01 +0000 (UTC)
Date: Thu, 7 Mar 2024 09:47:59 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: dongwon.kim@intel.com, qemu-devel@nongnu.org
Subject: Re: [PATCH 2/3] ui/gtk: set the ui size to 0 when invisible
Message-ID: <ZemNT-651Kl5S3uY@redhat.com>
References: <20240130234840.53122-1-dongwon.kim@intel.com>
 <20240130234840.53122-3-dongwon.kim@intel.com>
 <CAJ+F1CKH6oWkvN44de_FT0hG5vKd8pKapn62OM+DfmQggnDcHg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ+F1CKH6oWkvN44de_FT0hG5vKd8pKapn62OM+DfmQggnDcHg@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.365,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, Jan 31, 2024 at 11:12:57AM +0400, Marc-André Lureau wrote:
> Hi
> 
> On Wed, Jan 31, 2024 at 3:50 AM <dongwon.kim@intel.com> wrote:
> >
> > From: Dongwon Kim <dongwon.kim@intel.com>
> >
> > UI size is set to 0 when the VC is invisible, which will prevent
> > the further scanout update by notifying the guest that the display
> > is not in active state. Then it is restored to the original size
> > whenever the VC becomes visible again.
> 
> This can have unwanted results on multi monitor setups, such as moving
> windows or icons around on different monitors.
> 
> Switching tabs or minimizing the display window shouldn't cause a
> guest display reconfiguration.

I agree, changing the size of displays as a side-effect of
something that isn't a guest owner initiated resize operation
is asking for trouble.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


