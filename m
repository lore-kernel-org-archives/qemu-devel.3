Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4AE3CD4F26
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 10:32:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd3rP-0003JU-Hs; Fri, 26 Jun 2026 06:32:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wd3rO-0003Il-43
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 06:32:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wd3rM-0007w9-Go
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 06:32:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782469951;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8q0k8GAoQnnjK2qtidWIk/o3nOn83M+s9z6drbVnJD4=;
 b=VgmD0kw+UctAiqmyOjY+l6jYEQvMF7hExZoGkPAaZVC/ZLoVzFk1OqgSqhKh7TsotCpXwt
 llXAa7nbzrNnATJ/T9FQU+49cskT2L+wAO4aa5Vfl460JfB3V9PKVgt/yJKDI6MDrMirSg
 cbCp1YPa//QCXj+XcZkBKKhjBlMg3aA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-VrVm4bXFNiy0Ja2cKJ8VpQ-1; Fri, 26 Jun 2026 06:32:30 -0400
X-MC-Unique: VrVm4bXFNiy0Ja2cKJ8VpQ-1
X-Mimecast-MFC-AGG-ID: VrVm4bXFNiy0Ja2cKJ8VpQ_1782469949
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-4642a5651d4so672081f8f.2
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 03:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782469949; x=1783074749; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=8q0k8GAoQnnjK2qtidWIk/o3nOn83M+s9z6drbVnJD4=;
 b=VfpdVaWclaL+PF3+YkuR7Yz8C4+CKiL2IVLbm/o3zLKlEAoKvvLB5BAyvKNOTdhkW5
 AIgOhoMMBQck/AkM5/o9mFPIJCxiqWzL9DSCHpjal/y0PsZW0Qo3CQZDJD23MJ5unuWl
 cODTUeq8qkqiXV3birA8kKPRfPbDcbVTLAMe98uzsDRd1cM0faod4DFK/SobbzIW8Wfg
 LrZmBQpiK7nuLyt7pQEnu5NYcYp4fFhF87J/0DDuUuoemI2VkMqMltnuPagZRXnVZO8p
 XfxcIlhBkXkeN3f8n9H9wtIqUfLPs5SXH/hg6Hw3zQILhSIp7BIaajJKxZJdAj5ZOqrr
 PUEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782469949; x=1783074749;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8q0k8GAoQnnjK2qtidWIk/o3nOn83M+s9z6drbVnJD4=;
 b=jVQdz+XUkPgUpKALJaDNW30JOa+uswsMjuRj/zOQ4Ajbiq9XMSJzRF2Xd5YhvBFZKq
 aUYzScompozmmpJPt/NmcmdDATeyYEYC4oBIeGC0iOZ9ZL65ZESa7gRZlzp5KQm6nLFT
 qyss6/QjC8o2pDqzGBH94W53fortcQ7tNLzet/aPV7D4LjhQj89tayX0SZ5DwuLqxkvY
 5YZ/lyd5B6wpRh9PslLv1AMBdbl0ps/ePHe07siWgcO4HTW+nrXKMl2wFyNCSVFm0aNs
 2o1YXI4UFToOlGOHt5J010ZyLIQxXfybkYlr4fjk3vB7iUejgxwWuCHLem6tcPDPt/zL
 2Csw==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro0NGOn0cmBEcgNwi9g4OsbQcPkkB4YZxrhy6yhUro6CptW0xepM/F3wdvI04UCAt1oT5MKWrWWYjkO@nongnu.org
X-Gm-Message-State: AOJu0YyMEz+saRiBc3S4SSHEj9vqGvP5h/viIYsBJ6qm6Mn/6CgBfTHL
 mTFP6XARmwE6eVPmi1r03BY2BefhU6wqh+p7LDEioRs+/c6OOCFVNC6gjhPvBsuM8Jja40feedi
 +3hEjju3IgPWh6FUuOrcLEw79eePUiXQmFAZFwX9UBGxq4A47WG33YTD0
X-Gm-Gg: AfdE7clKPyiBYlsNgAj0Ya0fFLC1t51NoYgsrvVYX6227FrgPukVLj08bvtesQ0C9Ps
 A3YMbLY3MbMvJ6WwNImTxSBGM6vw/Wv4LvJQLGR+GXOgYMuZvPT3smzjD1I0K+XXGrzW9EU9duA
 zbFauHkYFPDQbGpjLAVUChJMWpmfoCLwzegboF8yiaL1K41XShl80wD8xtgX3/vDSttzHwy/HhS
 qABMzoqN/NUAxFz/EHNXZzn76awH6WdG5pdN8tln/OrZ5+QhAO6VwnG0YLqWCVvydv2nY4kBfuw
 NzGNk8WEeFJQlSWeCiNgDRbgeZJVIZgk42HWwKRtRFiSi14U5jycRxE7qEGSEZOFFSWKAMqBtVb
 9368E0cYQqvppgqwkQ5J1DvB6Nr3TJu0qNx7rudTYlQ==
X-Received: by 2002:a05:6000:4014:b0:46d:d5da:f0a7 with SMTP id
 ffacd0b85a97d-46dd5daf1cbmr9297478f8f.46.1782469949003; 
 Fri, 26 Jun 2026 03:32:29 -0700 (PDT)
X-Received: by 2002:a05:6000:4014:b0:46d:d5da:f0a7 with SMTP id
 ffacd0b85a97d-46dd5daf1cbmr9297431f8f.46.1782469948412; 
 Fri, 26 Jun 2026 03:32:28 -0700 (PDT)
Received: from redhat.com (bzq-79-177-145-168.red.bezeqint.net.
 [79.177.145.168]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46c1ee0189esm24669051f8f.9.2026.06.26.03.32.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 03:32:27 -0700 (PDT)
Date: Fri, 26 Jun 2026 06:32:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Mauro Matteo Cascella <mcascell@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Amit Shah <amit@kernel.org>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-stable@nongnu.org
Subject: Re: [PATCH] hw/char/virtio-serial-bus: fix guest-triggerable OOM in
 control_out()
Message-ID: <20260626063111-mutt-send-email-mst@kernel.org>
References: <20260622161144.2883799-1-lvivier@redhat.com>
 <ajljKftAKpkoiN7w@redhat.com>
 <CAA8xKjXARvc3m7F30Us-57BMqaCo1qqZMp8c_wBzMAs_cvFj=Q@mail.gmail.com>
 <aj5JqY7bKkqViaZL@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aj5JqY7bKkqViaZL@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Jun 26, 2026 at 10:43:05AM +0100, Daniel P. Berrangé wrote:
> On Thu, Jun 25, 2026 at 06:56:05PM +0200, Mauro Matteo Cascella wrote:
> > On Mon, Jun 22, 2026 at 6:30 PM Daniel P. Berrangé <berrange@redhat.com> wrote:
> > >
> > > On Mon, Jun 22, 2026 at 06:11:44PM +0200, Laurent Vivier wrote:
> > > > A malicious guest can craft virtqueue descriptors with arbitrary lengths.
> > > > control_out() calls iov_size() on the guest-supplied scatter-gather list
> > > > and passes the result directly to g_malloc(), allowing a guest to force
> > > > QEMU to attempt multi-gigabyte allocations and crash the host process.
> > > >
> > > > Fix this by copying at most sizeof(struct virtio_console_control) into a
> > > > stack-local variable instead of allocating a buffer sized by the guest.
> > > > handle_control_message() only accesses the fixed-size id, event, and
> > > > value fields, so no data beyond the struct was ever needed.
> > >
> > > Does anyone have thoughts on whether we should treat guest initiated
> > > unbounded allocs as a security issue ?
> > >
> > > IIUC, this flaw would require root in the guest OS in order to craft
> > > the malicious virtqueue descriptors.
> > >
> > > A self-initiated crash triggered by root would not historically
> > > be enough justification for CVE. We would require it to be triggered
> > > by unprivileged user.
> > >
> > > Nested virt with device assignment could change that equation though
> > > as the L2 guest could be considered an unpriv user from the L1 POV.
> > >
> > > Also in theory the large alloc might be large enough to consume all
> > > host RAM but not large enough to trigger OOM kill of QEMU. This might
> > > impact operation of other co-located VMs on the same host.
> > >
> > > Anyone think this is bad enough to justify a CVE ? Or should we treat
> > > these OOM scenarios maerely as "hardening" bugs, where they require
> > > 'root' in the L1 guest ?
> > 
> > I'd lean toward classifying these as hardening bugs. I don't see the
> > point in assigning Low CVEs to these kinds of issues nowadays. Under
> > current vulnerability management standards, they would definitely be
> > pushed down the priority list and likely skipped or deferred.
> 
> Ok, so lets apply as a general rule that all OOM bugs which require
> privileged access in the guest are not assigned CVEs.
> 
> An unprivileged guest exploit would be more significant so still
> potentially in scope.
> 
> 
> With regards,
> Daniel


I'd love to have a document where all this is written up, though.



> -- 
> |: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
> |: https://libvirt.org          ~~          https://entangle-photo.org :|
> |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


