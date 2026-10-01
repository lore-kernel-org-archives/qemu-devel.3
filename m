Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCFE6CA5FB3
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 08:32:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCCDF-0004MP-Dx; Thu, 01 Oct 2026 04:32:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1xCCDB-0004M1-Ff
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 04:32:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1xCCD9-00048P-4U
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 04:32:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790843534;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=96UgSydltxa/aXK5jn89QtK6huSyIDJAMZTOZOEjhK8=;
 b=K/3WeptSoOCZPCFUlTlPkLS36qpXPRP87a/+ShhOxLJzXlCy8vCC5vacSAip8AOsAP4UTk
 vNA1c0BODGysWdC79x+opMtxjqN4K1rPJdizNF4WS4gJLLUbPfS0nZgvddLrr/4rQA1jWQ
 Qm/QCxPixEwPCJaGiOFIxFJCuJ8BVrg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-228-eMU9pct7O2a-S5wNjkFhZA-1; Thu, 01 Oct 2026 04:32:13 -0400
X-MC-Unique: eMU9pct7O2a-S5wNjkFhZA-1
X-Mimecast-MFC-AGG-ID: eMU9pct7O2a-S5wNjkFhZA_1790843532
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4a0023f2b97so23027925e9.2
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 01:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790843532; x=1791448332; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=96UgSydltxa/aXK5jn89QtK6huSyIDJAMZTOZOEjhK8=;
 b=HDTs1SMshviUiWjCDsL87f1kmr3Iy/mGeiwwhqdPuIr55s8kPMNG67+DU/RqapRPW4
 Q0iGoj3dRAfNa0ArVIP6Z4NnHOtBQFsE79VS3xkovOgiMjesDD4u2Tm4wVqVbPnQRRpO
 zxSg2o0Fhe4QXWU206OJP2I/Z5H17aaCRfKYFVZI4JxKaoFwa8WqzF1w0d4W6aY/FtTV
 BE93Sjvvl9ipra0gDlyQ8xutnq3d+dsKjDjU2n8FVmG3usF3BkLMT6fg1GpUUP44HMZJ
 4LTs19KePj9veSWS9ciZpY6XH4x2rV7+wXFw9/za+XRMNIeQ6LaM8OzNGFJQ8zxo0hFO
 ktHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790843532; x=1791448332;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=96UgSydltxa/aXK5jn89QtK6huSyIDJAMZTOZOEjhK8=;
 b=wRhSlm8o7AyVYvFX6+gEpnKCz6li7tdmuDESPCWvOa39fu3NYHR50gC/Dmj/cUpIZu
 8NEWZkFu+h2+kDN4P3QsrpheRG0SF1cAzkGJFwHpSZdX4gp/phP2411HGR0mzcR8YDTv
 pDY4GEPMaDfSgNa28nwaSHxXNf9UKsmw09HUmfAuL9KmZBB9yY7ChEzChJYj8qm703xf
 zmf/D0TO60hhEr7NoF/dvb6fzbvGWYpOd4a4FFvUui62t3zq4ewo7BiwnJkM+9Rhnl0A
 Q6KIZJRMD+4+wXtcD9DG9dBGaSPoPKkuh/7QN8RR1/bhTxcUH7UzWvQpOq2TF+CZgh1J
 7zvQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBy82B0o93CaS64Iy3X49+opDTx8mRxRRKmoj/qbwuGp8VX9NDvYhLw2rAXfGHJrKElJoqxMnk4KUJIY@nongnu.org
X-Gm-Message-State: AFuF++kE426ICPuBZm1jG28wysZ7UHxgTUI1ib3MTLC/Z2sFcE69Iqrs
 +gtsC32PtCJQO9QtJirfivywU1NFUeSjPE37M9yaM/7CwUpbA8I9ZZul0pqMBmPmf5Lg/BbwIg1
 CeemKT7JC3l5Sd90w8wkN+SMsz11o0cKpVde0vxUrFy2Abkwe58OfnLf0
X-Gm-Gg: AYBFou2DO9LOGkuLOmvMgAI8V2IO76D2BnstMD0v4D56JSEZEmGh+2TPCfoq2Tmosmt
 l89+lZxO+awG+TL3ifASaVFdyYTEK8HiKvrKtRDe43OASymwR0o11xUInLGjxoZuJJkJisQ2OX/
 SKaU5FZQInQ2sAUzt5Cnn/u9a3+3JhsLrauAj4QmAbxJgAHR/u3R0T5cnPL4JsgfAElYNKH9Id/
 0CuMn150HD2jkrHix0xNSpHVc2zo4lOVwHSyXXcH6wS+psoX5+1y6eEEGBkouO0gfV+DqHTyceg
 nFgmDE6YB1B0FwGUdQze/RqSNnzDJJ+6BjfqwPgH4GzvMpggeUnrFY5cJFhsWO3E7YnY2rrHpb9
 FuR9eFeQul8o=
X-Received: by 2002:a05:600c:45d3:b0:49f:df99:ff1a with SMTP id
 5b1f17b1804b1-4a01affcfa9mr56849295e9.17.1790843531681; 
 Thu, 01 Oct 2026 01:32:11 -0700 (PDT)
X-Received: by 2002:a05:600c:45d3:b0:49f:df99:ff1a with SMTP id
 5b1f17b1804b1-4a01affcfa9mr56848705e9.17.1790843531145; 
 Thu, 01 Oct 2026 01:32:11 -0700 (PDT)
Received: from sgarzare-redhat ([5.77.112.40])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b0690d284sm4627928f8f.17.2026.10.01.01.32.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2026 01:32:10 -0700 (PDT)
Date: Thu, 1 Oct 2026 10:32:00 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Dorinda Bassey <dbassey@redhat.com>, qemu-devel@nongnu.org
Cc: virtualization@lists.linux.dev, rust-vmm@lists.opendev.org, 
 Albert Esteve <aesteve@redhat.com>, Sergio Lopez Pascual <slp@redhat.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Matej Hrica <mhrica@redhat.com>, Milan Zamazal <mzamazal@redhat.com>, 
 Gurchetan Singh <gurchetansingh@google.com>,
 "Jorge E. Moreira" <jemoreira@google.com>, 
 Matias Ezequiel Vara Larsen <mvaralar@redhat.com>,
 Alberto Ruiz <aruiz@redhat.com>, 
 Erico Nunes <ernunes@redhat.com>, John Ferlan <jferlan@redhat.com>, 
 Michael Tsirkin <mst@redhat.com>, German Maglione <gmaglion@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, t.ampelikiotis@virtualopensystems.com, 
 harald.mommer@oss.qualcomm.com
Subject: Re: Invitation: Virtio and Vhost-User Ecosystem BoF - LPC 2026 (Oct
 7, Prague)
Message-ID: <ar4aTDEPwCbmjR3a@sgarzare-redhat>
References: <CACzuRyxNzJ7E_K0zL3J4F9MGm+UX01uRkNhtEXKOHT732JytBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CACzuRyxNzJ7E_K0zL3J4F9MGm+UX01uRkNhtEXKOHT732JytBA@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


+Cc qemu-devel

On Wed, Sep 30, 2026 at 06:38:42PM +0200, Dorinda Bassey wrote:
>Hi all,
>
>I'd like to invite you to join us for a Birds of a Feather session at
>the Linux Plumbers Conference 2026:
>
>"Virtio and Vhost-User Ecosystem for Production and Automotive Systems"
>
>When: Tuesday, October 7, 2026 at 17:45 CEST (UTC+2) (45 minutes)
>Where: South Hall 1 B, Prague Congress Centre
>Speakers: Dorinda Bassey, Albert Esteve, Stefano Garzarella (Red Hat)
>
>If you are unable to join in-person, there's also an option for remote
>attendance,
>See the link on how to register: https://lpc.events/event/20/page/267-attend
>
>Description:
>The vhost-user protocol started as a simple QEMU feature, but it has
>grown into a standard used across the entire Linux virtualization
>community. Today, it powers production workloads in the cloud (e.g.
>QEMU and cloud-hypervisor), lightweight environments like libkrun, and
>modern automotive systems.
>However, as the ecosystem expands, we are hitting new "plumbing"
>bottlenecks. For example, the protocol specification is still stored
>inside the QEMU documentation, which makes it harder for other
>projects to participate in its growth. At the same time, automotive
>deployments are introducing strict new needs, such as safety
>certification, real-time performance, and long-term support, that
>impact everyone.
>This BoF will bring developers and users together to address these
>challenges and other emerging topics across the ecosystem. Our goal is
>to establish better coordination, align technical roadmaps for both
>cloud and automotive, and build shared tests and tools to ensure all
>implementations work together.
>
>Key Discussion Topics:
>- vhost-user Specification Governance: Discuss official location for
>the vhost-user specification
>- Automotive Virtualization Requirements & Reference Platforms:
>Coordinate deployment needs across Automotive platforms [1]
>- Real-time performance needs (camera, display, CAN)
>- Status Update: Ongoing work on vhost-user device (virtio-Media,
>virtio-can, virtio-rtc, etc) [2][3]
>- Graphics Stack Alignment: on roadmaps for shared dependencies like
>rutabaga_gfx across libkrun, crosvm, vhost-device-gpu [4]
>- Shared Virtio Message-Parsing Crates: Evaluate creating unified Rust
>crates for Virtio device specs to share virtqueue parsing logic across
>backends and VMMs
>- Open questions about:
>  - vhost-user Specification Refinements: Identify protocol gaps,
>missing features, and necessary standard improvements
>  - New Virtio/vhost-user Device Proposals
>
>References:
>[1] https://source.android.com/docs/automotive/virtualization/reference_platform
>[2] https://lore.kernel.org/virtualization/ab2FlQTWUxl0KmlT@fedora/
>[3] https://github.com/rust-vmm/vhost-device/pull/944
>[4] https://github.com/magma-gpu/rutabaga_gfx/issues/24
>
>Session details: https://lpc.events/event/20/contributions/2365/
>
>Looking forward to seeing you there!
>
>Best regards,
>Dorinda Bassey
>Red Hat
>


