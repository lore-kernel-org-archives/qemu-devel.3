Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7872DC02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 09:36:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfyJ3-00030A-Jo; Thu, 06 Feb 2025 04:36:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mvaralar@redhat.com>)
 id 1tfyIo-0002pQ-Rj
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 04:36:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mvaralar@redhat.com>)
 id 1tfyIk-0007vF-RT
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 04:36:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738834561;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=P4ZHJjPRFMKV2LyTsMjVC9uMgqNHhpd5qSqQo6h6SPo=;
 b=IMcybpnJ5SyY5Sws1GWYL3IR+0ecJc1zrsLZEpHzuzh7COcK08myaOXn3k3D1ZjnGVOaWV
 l+ceSpFXTT+7tmL175FyOhVcv1PbnkLWtiDtiP9TW2Zr8vt+gpFR3YwJlGqFKjC/YYdj3e
 y3pJwC9pRqAREVkS6CiEJq7Jr4ryh5Y=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-_etfvzXAMT2qeYtt4-2McA-1; Thu, 06 Feb 2025 04:34:23 -0500
X-MC-Unique: _etfvzXAMT2qeYtt4-2McA-1
X-Mimecast-MFC-AGG-ID: _etfvzXAMT2qeYtt4-2McA
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43625ceae52so4118845e9.0
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 01:34:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738834459; x=1739439259;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P4ZHJjPRFMKV2LyTsMjVC9uMgqNHhpd5qSqQo6h6SPo=;
 b=UQ5I7j7mQCqQ5VqCKb/QbyA3GYmCQh8s47dIxSD+nrkmS2WfI7L7ID67TglTvwtIdi
 r2idqcSWbDKyJYTcHlfGCEpgv8XAo1I1jhi/ssGkMzYkK/6T/8d6guUhah2oEqgVLyBB
 CgsQOUPaZT9YT7h/BoxEKdrGDiFXaN8CVHD1riIUNTqy6qQr3RFSvR4ZE/AHlvwRC7Tz
 0w6f1dQ+su7XIZg03/goUNQwla2C8KKDY+5ZbRPFLVoDGAsKbqCeIUq5DxPfzAVBmarA
 ShwLukBTHQJoV8ywiU0kFaDJVF3puTM+3itV+OGOi8uEz8D8nBFPfNny2RBagT+NZXAI
 EyxA==
X-Gm-Message-State: AOJu0YzowTdJ0kPl8GvX/mkpixx3mJa862pnQK5kRWlqAd5meg4erTsT
 Eo+EgoawvKnc/Xq7ieA4Qo4Yox95g6+ZhaQ4NL+rXbh5RN8UIGdDmhF7y7pnWdBlnkgZXR6O0JX
 Q3ZOOPkQa6q/81oeG05/7Ua9EkFEFTPHuvVp2VT14vqd2ea/j96tZQRcWM6xM1kI=
X-Gm-Gg: ASbGncvVKbaxMvGskxN9Y7mWldrX3PEOaN86MOy43IjUvj7/cyjmfJqYBjLm69MDekv
 geoEHhh9PDcFPBjwQJGCGZ/1DV0JoyKg09ppYD58pIqNCE94fE+TxSsGENBLgTj3qVaFZtIgZ7w
 mm8G2IBam5EAo/Td1gyOtuh0ugmaDm9Xz4Ihx/2sJIG+M+5Q48uF5iEJX1ZSSIS56Gg85Jl+3NL
 AGFfFZWmbQOwhZzz+6KYLVFaK0QYNaRPn1QrP0t7AdkRaa/+i7lWXkTFnaFj8FRNLYCi2UBgSc=
X-Received: by 2002:a05:600c:1c9d:b0:434:9e1d:7626 with SMTP id
 5b1f17b1804b1-4390d5a2e06mr40199505e9.25.1738834459519; 
 Thu, 06 Feb 2025 01:34:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHy2fOO/MU56iUKzPnZlhBwxpOevv3LvEJRLHdAajpCbdN4rFxi6UgPiA9NlUPEvJo9+svERA==
X-Received: by 2002:a05:600c:1c9d:b0:434:9e1d:7626 with SMTP id
 5b1f17b1804b1-4390d5a2e06mr40199075e9.25.1738834459019; 
 Thu, 06 Feb 2025 01:34:19 -0800 (PST)
Received: from fedora ([2a01:e0a:257:8c60:80f1:cdf8:48d0:b0a1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4390db11750sm49963365e9.40.2025.02.06.01.34.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2025 01:34:18 -0800 (PST)
Date: Thu, 6 Feb 2025 10:34:16 +0100
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
Message-ID: <Z6SCGN+rW2tJYATh@fedora>
References: <CAJSP0QVYE1Zcws=9hoO6+B+xB-hVWv38Dtu_LM8SysAmS4qRMw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJSP0QVYE1Zcws=9hoO6+B+xB-hVWv38Dtu_LM8SysAmS4qRMw@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mvaralar@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Tue, Jan 28, 2025 at 11:16:43AM -0500, Stefan Hajnoczi wrote:
> Dear QEMU and KVM communities,
> QEMU will apply for the Google Summer of Code internship
> program again this year. Regular contributors can submit project
> ideas that they'd like to mentor by replying to this email by
> February 7th.
> 
> About Google Summer of Code
> -----------------------------------------
> GSoC (https://summerofcode.withgoogle.com/) offers paid open
> source remote work internships to eligible people wishing to participate
> in open source development. QEMU has been doing internship for
> many years. Our mentors have enjoyed helping talented interns make
> their first open source contributions and some former interns continue
> to participate today.
> 
> Who can mentor
> ----------------------
> Regular contributors to QEMU and KVM can participate as mentors.
> Mentorship involves about 5 hours of time commitment per week to
> communicate with the intern, review their patches, etc. Time is also
> required during the intern selection phase to communicate with
> applicants. Being a mentor is an opportunity to help someone get
> started in open source development, will give you experience with
> managing a project in a low-stakes environment, and a chance to
> explore interesting technical ideas that you may not have time to
> develop yourself.
> 
> How to propose your idea
> ------------------------------
> Reply to this email with the following project idea template filled in:
> 
> === TITLE ===
> 
> '''Summary:''' Short description of the project
> 
> Detailed description of the project that explains the general idea,
> including a list of high-level tasks that will be completed by the
> project, and provides enough background for someone unfamiliar with
> the code base to research the idea. Typically 2 or 3 paragraphs.
> 
> '''Links:'''
> * Links to mailing lists threads, git repos, or web sites
> 
> '''Details:'''
> * Skill level: beginner or intermediate or advanced
> * Language: C/Python/Rust/etc
> 
> More information
> ----------------------
> You can find out about the process we follow here:
> Video: https://www.youtube.com/watch?v=xNVCX7YMUL8
> Slides (PDF): https://vmsplice.net/~stefan/stefanha-kvm-forum-2016.pdf
> 
> The QEMU wiki page for GSoC 2024 is now available:
> https://wiki.qemu.org/Google_Summer_of_Code_2025
> 
> What about Outreachy?
> -------------------------------
> We have struggled to find sponsors for the Outreachy internship
> program (https://www.outreachy.org/) in recent years. If you or your
> organization would like to sponsor an Outreachy internship, please get
> in touch.
> 
> Thanks,
> Stefan

=== Adding Kani proofs for Virtqueues in Rust-vmm ===

'''Summary:''' Verify conformance of the virtqueue implementation in
rust-vmm to the VirtIO specification.

In the rust-vmm project, devices rely on the virtqueue implementation
provided by the `vm-virtio` crate. This implementation is based on the
VirtIO specification, which defines the behavior and requirements for
virtqueues. To ensure that the implementation meets these
specifications, we have been relying on unit tests that check the output
of the code given specific inputs.

However, writing unit tests can be incomplete, as it's challenging to
cover all possible scenarios and edge cases. During this internship, we
propose a more comprehensive approach: using Kani proofs to verify that
the virtqueue implementation conforms to the VirtIO specification.

Kani allows us to write exhaustive checks for all possible values, going
beyond what unit tests can achieve. By writing Kani proofs, we can
confirm that our implementation meets the requirements of the VirtIO
specification. If a proof passes, it provides strong evidence that the
virtqueue implementation is correct and conformant.

During the internship, we propose the following tasks:
- Get familiar with Kani proofs written for Firecraker
- Finish current PR that adds a proof for the notification suppression
  mechanism (see [2])
- Port add_used() proof (see [5])
- Port verify_prepare_kick() proof (see [6])

'''Links:'''
  * [1] Kani source code - https://github.com/model-checking/kani/
  * [2] Notification suppression mechanism PR -
    https://github.com/rust-vmm/vm-virtio/pull/324
  * [3] LPC Talk about how we may check conformance in the VirtIO
    specification - https://www.youtube.com/watch?v=w7BAR228344
  * [4] FOSDEM'25 talk current effort to use Kani -
    https://fosdem.org/2025/schedule/event/fosdem-2025-5930-hunting-virtio-specification-violations/
  * [5] https://github.com/firecracker-microvm/firecracker/blob/4bbbec06ee0d529add07807f75d923cc3d3cd210/src/vmm/src/devices/virtio/queue.rs#L1006
  * [6] https://github.com/firecracker-microvm/firecracker/blob/4bbbec06ee0d529add07807f75d923cc3d3cd210/src/vmm/src/devices/virtio/queue.rs#L966
 
'''Details:'''
  * Skill level: intermediate
  * Language: Rust 


