Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B7A7C02199
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 13:59:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgOsG-0007dY-Ev; Fri, 07 Feb 2025 08:58:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mvaralar@redhat.com>)
 id 1tgOrw-0007Wg-39
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 08:58:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mvaralar@redhat.com>)
 id 1tgOrs-0003bO-LB
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 08:58:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738936671;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PsHyj/fLCDE0yHLr24iqw8kb0+9c5dcfAfqIhww3Y3I=;
 b=FOunppSvn8Q8RXFuLo35rdCTBAppmBt5KILORs6nRO/4UmjaVO9WiUrn3ETBmQ50GtXgYz
 c/T3Wy3VGs2D8gboTyQdPcHenPNTyyy6SqAWQl9S9e1H19foq60ChKxrGTIHChhlgzXI3U
 PxMxT1rM53CObY2eWH9FhJFmcllWTKk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-373-OVJTH5LYPpmywB56wgZwDA-1; Fri, 07 Feb 2025 08:57:46 -0500
X-MC-Unique: OVJTH5LYPpmywB56wgZwDA-1
X-Mimecast-MFC-AGG-ID: OVJTH5LYPpmywB56wgZwDA
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-38dcc9653a7so266554f8f.0
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2025 05:57:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738936666; x=1739541466;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PsHyj/fLCDE0yHLr24iqw8kb0+9c5dcfAfqIhww3Y3I=;
 b=rZ8/QKMFQtbp5aeAgGW7NimGsfEt9nSGVIU17aigRzHRJGdWDSpi7VetpLNElDCoNX
 jg5RaFfPCkk7QrXpvtIf8RcQf+L1fxNLKfkmrXmtys1Q7ij2yboaAcDWCdiBWH5uwKF6
 ENXtiOCOrFIOIHKdsv5+5kOdRWbbwPP7H3V3lf7SX2djLyE1oOmLqGgHddB9lJK8Tdzv
 AMNa+1PLNmQV6zr9z/BYFGyITZs1p+QGIz0DgnMG4et9MfGWPTV9ErBWDU1yrXX28blt
 tzC3TPhz1XP2SUmNemiIj0BRYDAdeJKN5pcv5BQj53qAWRdSJHqy2pZ7j6NO2tn9GjuC
 MbJw==
X-Gm-Message-State: AOJu0Yx/yvD6tKQrG30XoOPH075EExHw2PVCbx5mcYnA6mMUNPkBpLZI
 Uaf6v8STLohclDv3qATCui8iAKdxIMwvFA/3fHehBl4gHgAFWCOJz4Idy23yo/KflsXfriVkfsY
 LgzVyeTnEQB7MIXM1JC6ovTWB4Ux+0ovqwnjk+vjEszGa1zAlVlxL
X-Gm-Gg: ASbGnctVdeo90m4m2s6eNfMHN3dFi0Krj4a/IjfI5GsEu61My4dPWiKoqJMYjvoXSIe
 gCDB3FIOuu98m4HjAnp3uHavbj6m9T0UPg+4aetDoZRsL4UCda8ebuO/h0c/V01bx9HPWWtYSUP
 jNk74lDwO+g7R2eD62yuRTeTF/mfSmhNjj/gcBLtLaqpvcM2Ei5qOsR2NNXYkHSb6FUjg3CgvLB
 pmE+DEISfweyChxwWtYITAbDyRptDhafCQl0FtluSbXgHKbKaAgUZ9Jyqby4d2NjjDmEoqrYZs=
X-Received: by 2002:a05:6000:2a7:b0:38d:b448:65c4 with SMTP id
 ffacd0b85a97d-38dc959fec4mr2253448f8f.55.1738936665694; 
 Fri, 07 Feb 2025 05:57:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHT1cPs98RF50Y1TuNvTB5/VxMgLbQiTzpp0lh8VKUOC6YGKJKhGf3sDx2eX0CHsInQ6Tqsnw==
X-Received: by 2002:a05:6000:2a7:b0:38d:b448:65c4 with SMTP id
 ffacd0b85a97d-38dc959fec4mr2253409f8f.55.1738936665222; 
 Fri, 07 Feb 2025 05:57:45 -0800 (PST)
Received: from fedora ([2a01:e0a:257:8c60:80f1:cdf8:48d0:b0a1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dcd21fe18sm1380953f8f.91.2025.02.07.05.57.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2025 05:57:44 -0800 (PST)
Date: Fri, 7 Feb 2025 14:57:42 +0100
From: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, kvm <kvm@vger.kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alex Bennee <alex.bennee@linaro.org>,
 Akihiko Odaki <akihiko.odaki@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>, Bibo Mao <maobibo@loongson.cn>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Palmer Dabbelt <palmer@dabbelt.com>,
 Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, felisous@amazon.com,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: Call for GSoC internship project ideas
Message-ID: <Z6YRVrkEW87Jh6bV@fedora>
References: <CAJSP0QVYE1Zcws=9hoO6+B+xB-hVWv38Dtu_LM8SysAmS4qRMw@mail.gmail.com>
 <Z6SCGN+rW2tJYATh@fedora>
 <CAJSP0QXHG8Vj1EomaRRTfQWykR=9mWQ3SDWn0pCG-b_8rJuKcg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJSP0QXHG8Vj1EomaRRTfQWykR=9mWQ3SDWn0pCG-b_8rJuKcg@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mvaralar@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Feb 06, 2025 at 10:02:43AM -0500, Stefan Hajnoczi wrote:
> On Thu, Feb 6, 2025 at 4:34 AM Matias Ezequiel Vara Larsen
> <mvaralar@redhat.com> wrote:
> > === Adding Kani proofs for Virtqueues in Rust-vmm ===
> >
> > '''Summary:''' Verify conformance of the virtqueue implementation in
> > rust-vmm to the VirtIO specification.
> >
> > In the rust-vmm project, devices rely on the virtqueue implementation
> > provided by the `vm-virtio` crate. This implementation is based on the
> > VirtIO specification, which defines the behavior and requirements for
> > virtqueues. To ensure that the implementation meets these
> > specifications, we have been relying on unit tests that check the output
> > of the code given specific inputs.
> >
> > However, writing unit tests can be incomplete, as it's challenging to
> > cover all possible scenarios and edge cases. During this internship, we
> > propose a more comprehensive approach: using Kani proofs to verify that
> > the virtqueue implementation conforms to the VirtIO specification.
> >
> > Kani allows us to write exhaustive checks for all possible values, going
> > beyond what unit tests can achieve. By writing Kani proofs, we can
> > confirm that our implementation meets the requirements of the VirtIO
> > specification. If a proof passes, it provides strong evidence that the
> > virtqueue implementation is correct and conformant.
> >
> > During the internship, we propose the following tasks:
> > - Get familiar with Kani proofs written for Firecraker
> > - Finish current PR that adds a proof for the notification suppression
> >   mechanism (see [2])
> > - Port add_used() proof (see [5])
> > - Port verify_prepare_kick() proof (see [6])
> 
> add_used(), verify_prepare_kick(), and notification suppression are
> explicitly named. Firecracker's queue.rs has proofs for a number of
> other proofs as well. Would it be possible to work on them if there is
> time remaining, or is there a reason why only the proofs you mentioned
> can be ported?
> 

I though that those three proofs were the more interesting. I think we
can cover all the proofs in queue.rs during the internship.

Matias


