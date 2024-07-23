Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C5FEC3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 10:46:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWD1s-0006u2-9b; Tue, 23 Jul 2024 06:46:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sWD1p-0006tJ-IG
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 06:45:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sWD1n-0007oA-1p
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 06:45:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721731553;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CsIC1nP/cDFmHI76J7F55HLNZAWCFHJiAbM0o69QIPc=;
 b=KVcH8WZyOYY8aoeUsdhrUUQE3HlMeIgoJS3ls74eN8atXEs9DMrDueFMTGIVzER4N0glLW
 gY72cfbLJtN5UbVryKQY39omomj8S1lID9kP6/blLBORO0BsiX+0wyjH1GsDKdfWSdn3lD
 VOXFFzPyeiROFSaVzL/bQk0rEnIL22M=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-228-ADLV7S1EMweYMuTOcQWwHw-1; Tue, 23 Jul 2024 06:45:52 -0400
X-MC-Unique: ADLV7S1EMweYMuTOcQWwHw-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-5a0fa34d1c9so4230946a12.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 03:45:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721731551; x=1722336351;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CsIC1nP/cDFmHI76J7F55HLNZAWCFHJiAbM0o69QIPc=;
 b=APaw4cLsloaetcGj5hsPbgTmz8ty9OW8xtCA8iBquAnhPWfOZBVRoKmkhCpn2b3L5e
 LvlQnn+GAQDEIJ+53V+9x5LKL3n8svMTvwxwVsECUU0jZRLs9T1GFXe7v1ttxmj2SimZ
 W+ADEpAfqm4hC/Hq2sIwqo9rZLL7CaSKe8+mOOcpn8xfci3InDA2KvOMB2KQLTKnMbg4
 IBeV+UwrhQizQptbeFCFxsEBZKjUfzb3FEShJJs/kWIqY5NZp28obUmjkv++oIm3tGL+
 a4rd2Xz1RYvAeOw7TaLC31NhGkYfS4ePIdT3hUnkVDJt7ogY6q6lTHSbGK8XujLopVyh
 lFfw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWjDLPR+n6OXdxyRDpplQpJwramX6H3gdcbH+NiTHriTIV7XYE6L8O8UblBqSwfw0y2LTtKRA45oqKkl+G6S8cVuHtnmrw=
X-Gm-Message-State: AOJu0YwUiDoOMqwO2fqB9eDIxB3I8ZIeg4rNEMrhs433vBLORNG/LhDB
 ++qjFLBLvWXkFjMDL5nYzrQiy2seAruZR99ksrH/+wFpD5CWNSFUu1kDFxebJuFy4FpyLS4dfCU
 z6rS/h38eurpwzirSBJCivi2aRHAN7oH3YGWWs713QlHuGRyeJ/C4
X-Received: by 2002:a50:cd81:0:b0:5a2:5bd2:ca50 with SMTP id
 4fb4d7f45d1cf-5a47b5c1a4emr6328540a12.25.1721731550905; 
 Tue, 23 Jul 2024 03:45:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG84hD9Ffw4PLr291lN6aUsjzPNXUSdscWcjIGRrCRhqOtjPas2cksmJann5EPIeBMN8qZCbA==
X-Received: by 2002:a50:cd81:0:b0:5a2:5bd2:ca50 with SMTP id
 4fb4d7f45d1cf-5a47b5c1a4emr6328518a12.25.1721731550226; 
 Tue, 23 Jul 2024 03:45:50 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:440:9c9a:ffee:509d:1766:aa7f])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5a30aaa3295sm7400987a12.31.2024.07.23.03.45.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jul 2024 03:45:49 -0700 (PDT)
Date: Tue, 23 Jul 2024 06:45:42 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL 00/63] virtio,pci,pc: features,fixes
Message-ID: <20240723064525-mutt-send-email-mst@kernel.org>
References: <cover.1721607331.git.mst@redhat.com>
 <438af529-ad2e-4500-9347-387317255ae0@linaro.org>
 <27fce655-4345-4ee7-af0a-0f11bde7074d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <27fce655-4345-4ee7-af0a-0f11bde7074d@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Jul 23, 2024 at 12:18:48PM +0200, Hanna Czenczek wrote:
> On 22.07.24 23:32, Richard Henderson wrote:
> > On 7/22/24 10:16, Michael S. Tsirkin wrote:
> > > A couple of fixes are outstanding, will merge later.
> > > 
> > > 
> > > The following changes since commit
> > > a87a7c449e532130d4fa8faa391ff7e1f04ed660:
> > > 
> > >    Merge tag 'pull-loongarch-20240719'
> > > ofhttps://gitlab.com/gaosong/qemu into staging (2024-07-19 16:28:28
> > > +1000)
> > > 
> > > are available in the Git repository at:
> > > 
> > >    https://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git
> > > tags/for_upstream
> > > 
> > > for you to fetch changes up to 67d834362c55d6fca6504975bc34755606f17cf2:
> > > 
> > >    virtio: Always reset vhost devices (2024-07-21 14:45:56 -0400)
> > > 
> > > ----------------------------------------------------------------
> > > virtio,pci,pc: features,fixes
> > > 
> > > pci: Initial support for SPDM Responders
> > > cxl: Add support for scan media, feature commands, device patrol scrub
> > >      control, DDR5 ECS control, firmware updates
> > > virtio: in-order support
> > > virtio-net: support for SR-IOV emulation (note: known issues on s390,
> > >                                            might get reverted if not
> > > fixed)
> > > smbios: memory device size is now configurable per Machine
> > > cpu: architecture agnostic code to support vCPU Hotplug
> > > 
> > > Fixes, cleanups all over the place.
> > > 
> > > Signed-off-by: Michael S. Tsirkin<mst@redhat.com>
> > 
> > Fails ubsan testing:
> > 
> > https://gitlab.com/qemu-project/qemu/-/jobs/7397450714
> > 
> > ../publish/hw/net/virtio-net.c:3895:18: runtime error: member access
> > within null pointer of type 'struct vhost_net'
> 
> Honestly, I saw this piece of code, but concluded it already doesn’t make
> sense, so I assumed someone™ who wrote this would know why it’s been written
> this way, and I should rather not touch it.
> 
> Specifically, the problem is that get_vhost_net() can return a NULL
> pointer[1], which is fine, but virtio_net_get_vhost() never checks this.  I
> assumed this was written with intent (i.e. `(uintptr_t)&net->dev ==
> (uintptr_t)net`, so that NULL remains NULL), because it’s so obvious that
> get_vhost_net() can happily return NULL under many circumstances, but maybe
> not.
> 
> The same theoretically applies to virtio_crypto_get_vhost(), although I
> don’t think that can ever be NULL in practice.
> 
> I’ll re-send the reset patch in a series with two patches that fix those two
> functions to check for NULL and explicitly return NULL if necessary.  In the
> meantime, it probably makes sense to drop it from this pull request.
> 
> Hanna
> 
> [1] For some reason, it uses integer 0 throughout to signify NULL. That was
> another reason that put me off touching this.

drop what specifically?


