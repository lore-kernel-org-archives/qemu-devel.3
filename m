Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BEA0CC6B38
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 20:31:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHS6f-0002nL-Fr; Thu, 15 Oct 2026 16:31:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1xHS6c-0002ih-3m
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 16:31:14 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1xHS6a-0005ke-FM
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 16:31:13 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-8899a204034so2881961b3a.2
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 13:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792096271; x=1792701071; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=pBnzENG+hypG+KwtFE6xg5OmepbVILPhdpggt/oBR/M=;
 b=JeHtUZ1eNVXlfB1SsqsNNQ5T6Ep5gJ7RvZT1bxlIn/EsgVaUpNXqGjKhtC9jLIlXuQ
 cUg09aGX02y+bjXUsbEoHmWlvqC7ZbBS0XqU/vc1kw5mMbPf2hKO8sMqrQL4H2yqd/EM
 is1sm30NajLrdJbG/Tm4ieH6ve1tHA9P6wQONOCnlgktviP1UktqFPJYrL0LTFjrScz4
 8cc6btyJU9k2wbSxeBfZMzf+/50k5nWqgDtLYmHZnSwucPXdZPFqMhnbyN+M61OWcORe
 cX08+M+LQnD6yknOXGrMULwsatKiPUUj8Th79xtgM64NdDXgAYFn4xeG5vnL+A/3QDYM
 zVYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792096271; x=1792701071;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pBnzENG+hypG+KwtFE6xg5OmepbVILPhdpggt/oBR/M=;
 b=HFPOXwk9EP8SL44uE2J3nUHjWET1e5esWqmzFhrM6bg5g3ayS5g+aIYVzpy9w4Nfei
 jsLGNzacgh2xanEC+rT/XETvNqwkoHXDIImxfm1royArgrg+SYGOU7LdVS/NeEgdGcxr
 Q+lc3XCWlM+eElvkOKwqNTb5RkPj7DRIX3GrhdAQAue3Uwee/nZG+Js+xli5QSuPT4u8
 3oL4V1M3ggtT3cQ4rdo8Euo11lTrmSnkHaG/fT+i5WcGmyqWOqTRFqeWGqxkDum/Mvqd
 83xynb0n2IUpI3xmUyOwdw2vrf+DNiEsswzKq+RzNfm2x6fGFePL2y6TVq82Y4zfY0LQ
 VDwA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxmr3pDeil4ENsKzt/tiLHwNUNBoByq88yv++2kNl1/XjrOGTaEWd+iTwE7ZUbph03OrpcB75/mww8p@nongnu.org
X-Gm-Message-State: AFq9FYKr9xV42PCmGL1/fD15rLmPIrWydv9+XBcxu5F0ruYY9BXOx+9a
 zDd4cRC7jOAH1BQ349SsAL3gqaMTPXjii8nFFNlQGBVRSi+bUtnKKo9f+wBcfN3DHkw=
X-Gm-Gg: AYBFou3Xinq9HOzeahTPK+grninHjSjqhdpODmk41G4TsMSVeKO0vHGORkEfD+hRDcV
 TwdlyUz+DgqxPEzEJBHgK7TDeoSOvA0MCGZvBrgfJQ5Vw2LO+PhJx8hqCUWyJHGJA0dnWPj6pkH
 gP85UNWbEmYKbSm9JMlc0l/XmRyPMY8RogoSaeadnDWQEaYFttjNwyl5AT5zhjI4ywLSi6MlBh5
 KDb6yxpAS61Ig25CjB2pPS0imWj3COWmPe/P4496T/1EEVvHx5MXZl7TE1E257Hr/SaqaTDYRBq
 gQ04Ck9q4WYEVmZot4jeOzxWML0RT/teoWAGOqcjSkIprtMVDMRbHLB/W5zU7DUtwPGJ/aJA7I5
 T9G4r1npbB6uzGiH6zhhjdwYBIJMJVbAjrKkho3cP3JK746joETY/xTmxg9X3rljAwb0HO2eoqz
 cUoYbpWcyQ9ESpbqhB8K/bt1QGAeDelfjE7WEyV8JzLMreM/yfND5JGcCy9pF1Upbo8tm5JaCB0
 g==
X-Received: by 2002:a05:6a21:9018:b0:3e0:e542:4ca6 with SMTP id
 adf61e73a8af0-3e1d0c3d35dmr6352907637.19.1792096269809; 
 Thu, 15 Oct 2026 13:31:09 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:48ff:8de9:17ca:1542])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cd6549eea48sm78394a12.19.2026.10.15.13.31.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 13:31:08 -0700 (PDT)
Date: Thu, 15 Oct 2026 14:31:05 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Gavin Shan <gshan@redhat.com>
Cc: berrange@redhat.com, kchamart@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
 mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com,
 eblake@redhat.com, armbru@redhat.com, lorenzo.pieralisi@linaro.org,
 enju.kohei@fujitsu.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 kvm@vger.kernel.org
Subject: Re: [RFC v4 07/24] target/arm/kvm: Create scratch Realm VM when
 requested
Message-ID: <atE4CS3P4n5o3n3w@p14s>
References: <20260903193611.1058589-1-mathieu.poirier@linaro.org>
 <20260903193611.1058589-8-mathieu.poirier@linaro.org>
 <d04fe4a6-4418-48b9-b2ed-cce6278e0081@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d04fe4a6-4418-48b9-b2ed-cce6278e0081@redhat.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=mathieu.poirier@linaro.org; helo=mail-pf1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, Oct 02, 2026 at 11:05:09AM +1000, Gavin Shan wrote:
> On 9/4/26 5:35 AM, Mathieu Poirier wrote:
> > From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > 
> > When a Realm is requested, create a scratch Realm VM by setting bit 8
> > of the argument given to the KVM_CREATE_VM ioctl().  Bit 7-0 are reserved
> > for the guest PA size.
> > 
> > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > ---
> >   target/arm/kvm.c | 6 +++++-
> >   1 file changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> > index b4c6da1fb9f3..d86e66e056b9 100644
> > --- a/target/arm/kvm.c
> > +++ b/target/arm/kvm.c
> > @@ -108,7 +108,9 @@ bool kvm_arm_create_scratch_host_vcpu(int *fdarray,
> >                                         struct kvm_vcpu_init *init)
> >   {
> >       int ret = 0, kvmfd = -1, vmfd = -1, cpufd = -1;
> > +    MachineState *ms = MACHINE(qdev_get_machine());
> >       int max_vm_pa_size;
> > +    int vm_type;
> > 
> 
> @vm_type can be initialized when it's declared.
> 
>        MachineState *ms = MACHINE(qdev_get_machine());
>        int vm_type = ms->cgs ? KVM_VM_TYPE_ARM_REALM : KVM_VM_TYPE_ARM_NORMAL;
>        int max_vm_pa_size;
> 
> >       kvmfd = qemu_open_old("/dev/kvm", O_RDWR);
> >       if (kvmfd < 0) {
> > @@ -118,8 +120,10 @@ bool kvm_arm_create_scratch_host_vcpu(int *fdarray,
> >       if (max_vm_pa_size < 0) {
> >           max_vm_pa_size = 0;
> >       }
> > +
> > +    vm_type = (ms->cgs ? KVM_VM_TYPE_ARM_REALM : KVM_VM_TYPE_ARM_NORMAL);
> 
> () aren't needed.
>

All fixed.
 
> >       do {
> > -        vmfd = ioctl(kvmfd, KVM_CREATE_VM, max_vm_pa_size);
> > +        vmfd = ioctl(kvmfd, KVM_CREATE_VM, max_vm_pa_size | vm_type);
> >       } while (vmfd == -1 && errno == EINTR);
> >       if (vmfd < 0) {
> >           goto err;
> 
> Thanks,
> Gavin
> 

