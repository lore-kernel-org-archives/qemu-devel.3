Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 921B2C61DD6
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 15:46:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1n9p-0005LW-7F; Wed, 02 Sep 2026 11:45:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1x1n9n-0005LA-JB
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 11:45:47 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1x1n9k-00057e-P9
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 11:45:47 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2d53197d8b5so11318085ad.3
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 08:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788363942; x=1788968742; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=TPysDsGnpI9b+EwUBvoDR+Wcd16jrG2t2FBfRR3MC1c=;
 b=URvndoNUVO2h5AwJAKAYmwu3/wlxgsrOYqz+bGfzBSy18QQir30KiQ4HaC2wao7STv
 mmwGDn6Q/a/cJTgBH3RiuSOHKfWeSk2Wjs+16K7fKjxuT5Ckx5jvhWdaTURtYolbsbxU
 R2OrQUpUCIVhQk7SXvCYQC1s0D6sWbucMcBZiyEtXXZaVytvJUaMhdVtvybI4ofL66XY
 xpVj2cmv0G0Ax8NpzksaLA7O+uniilwVSoFxLhpPuRmhJrV4B/yyx4cO8XcWMjCroH9t
 7RdfoMwwqPJf9LvLMpPKFEaGYaLIYEBAzrcJd20SpCA5QILPHIZ1dSw8y5Ggti+jUG+F
 vTxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788363942; x=1788968742;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TPysDsGnpI9b+EwUBvoDR+Wcd16jrG2t2FBfRR3MC1c=;
 b=kPMbYB66DkHVe/RuyaGd9Yta52m58qcUu+wjt2Gk+Q7F35XIJOpshkAkscIHaI7Nh4
 1dULnT+2bXQ4bFBpWyJSbJ45A4J3agnL4aRDGZfctGQWiO44e2SAC2gu5qJP1Kj9Xrva
 BKd20hJJOU5/lr/US9mSLEr82e5DiUnVwmSgUGynuTe07QimhEJG1k8jQWQjTHiVGQN4
 mQxkSlAQ+41dnU/M7EcNoRequhKaEcrdIe3R/6vakcZaNhUJwgSPmyZ8rMb0b/YJP0q6
 QSmgCmlNCYAuQ8mLH+uk83LKsW+HeBul+N93r9fWja657fUOFgXJgotCtwXbe9WbYkgg
 0drA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzEnw/8qutv7YwZzomb6NPPYeH4TF5zy5Tos4Ql1SF983H47MkYwF4q6x053mLYqoaJOrqPjh+otfnk@nongnu.org
X-Gm-Message-State: AFuF++kKf9aOBsJCrp1swQrrrKkA3yiXfjlSvhuj0/TgrSj/7zRu/SjA
 E1UufRtPZXLkzj8HlWZIP6AwzAazoQtjS0g6QEyKaz7W3n93mCbCLyAYT/5Lgtpgrfs=
X-Gm-Gg: AYBFou28wDwNI2Gg80kyfemw2I2mQ9QuO0jx8+w2xYKPZHtxW5MByN34UfuMv4RS+/K
 r3nK63sjS2opEhzHrmN+2NH290xKkcTW7c//K4CqTO2ifcUrbJQ/SDlHJHehFjSKFA3zNXgwFf2
 0/Dl2pFwFBI0CB8Cpl61nCW4w2Ul5Fwz0shiu+ox5FEDDRUOfAuGkSdI79a3i7HqVA8C7NuoeZf
 Bp98tm8HLmHivVskew980lb0oBFVxE3NVAV9agte8PaQklGkW562EBYvZIV+bV6UVbKndq45QHY
 VuuXeTHflDn0W3Adkj/rZFlIWB5GdnqKwyMUxhDS1VNu/xXI5LM7VZ1pIxo/qw7Bsinea0l1ALr
 Ler5y9Qy7Rxl4663XlQFzuUHfK+/kNRSqp94y6QRwST9UfyVnI2clR6ikLU4vLKyoCT6lgg3W3e
 vvmwVCX7BmUNhFUaymOLllvDU4l6QzVKhkPuDxJiYozMHpEJOR1DNgTk6sAlN+HKbHQVJATIs5g
 Wg=
X-Received: by 2002:a17:902:d4ce:b0:2d8:d2bd:a111 with SMTP id
 d9443c01a7336-2daec626dbdmr76719805ad.6.1788363942059; 
 Wed, 02 Sep 2026 08:45:42 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:fff4:86c5:8d86:9e93])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2dadd48898fsm15694765ad.39.2026.09.02.08.45.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 08:45:41 -0700 (PDT)
Date: Wed, 2 Sep 2026 09:45:38 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Markus Armbruster <armbru@redhat.com>
Cc: berrange@redhat.com, kchamart@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
 mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com,
 eblake@redhat.com, lorenzo.pieralisi@linaro.org, gshan@redhat.com,
 enju.kohei@fujitsu.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 kvm@vger.kernel.org
Subject: Re: [RFC v3 00/24] Add Realm support to QEMU-VMM
Message-ID: <aphEopEnM1pEDLV4@p14s>
References: <20260825220101.3443954-1-mathieu.poirier@linaro.org>
 <87wlt55cs2.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wlt55cs2.fsf@pond.sub.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=mathieu.poirier@linaro.org; helo=mail-pl1-x62a.google.com
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

On Tue, Sep 01, 2026 at 03:20:13PM +0200, Markus Armbruster wrote:
> Mathieu Poirier <mathieu.poirier@linaro.org> writes:
> 
> > This patchset provides minimal functionality to start a Realm VM
> > from an Arm RME capable host using the following command line:
> >
> > qemu-system-aarch64 \
> >  -M confidential-guest-support=rme0,memory-backend=ram0 \
> >  -object rme-guest,id=rme0,convert-in-place=on \
> >  -object memory-backend-guest-memfd,id=ram0,size=1G,share=on \
> >  -cpu host -M virt -enable-kvm -M gic-version=3,its=on -nodefaults ..
> >
> > It is a refactoring of Jean-Philippe Brucker's initial work dating from a while
> > back.  It is compatible with Steven Price's v16 revision [1] of his work adding
> > CCA support to KVM.
> >
> > This revision is based on Michael Roth's work on guest memfd in-place memory
> > conversion [2] and as such, the QEMU baseline is different from 'master'.  Other
> 
> Use
> 
>     Based-on: <20260528000416.8161-1-michael.roth@amd.com>
> 
> to document your base.  This stands out to humans, and is readable by
> machines.  Next time :)
> 
> > than modifications to use in-place memory conversion from Lorenzo Pieralisi that
> > were integrated to patches 04, 08-11, it is identical to V2.   
> >
> > It was tested on the QEMU SBSA machine.  For convenience, a repository is hosted
> > here [3],
> 
> Michael's series doesn't apply on master anymore, so I fetched this
> branch.  It's based on master as of *May*.  This won't do.  Please rebase.

This was clearly explained above.  The goal was to provide a patchset that can
be used for testing. I can attempt a rebase but can't guarantee a timeline or
success.

> 
> >           along with the TF-A [4] and RMM [5] for the SBSA machine (compatible
> > with Steven's v16 patchset).  The Repository for the kernel [6] is available
> > from Arm.
> >
> > Instructions to compile and run the entire stack can be found here [7].
> >
> > Device Assignment is not included.
> >
> > Thanks,
> > Mathieu
> >
> > [1]. https://lore.kernel.org/kvm/20260803134403.80630-1-steven.price@arm.com/
> > [2]. https://lore.kernel.org/kvm/20260528000416.8161-1-michael.roth@amd.com/
> > [3]. https://gitlab.com/Linaro/cca-public/qemu/-/tree/upstream-v3?ref_type=heads
> > [4]. https://gitlab.com/Linaro/cca-public/tf-a/trusted-firmware-a/-/tree/cca/v13?ref_type=heads
> > [5]. https://gitlab.com/Linaro/cca-public/rmm/-/tree/cca/v16?ref_type=heads
> > [6]. https://gitlab.arm.com/linux-arm/linux-cca/-/tree/cca-host/v16?ref_type=heads
> > [7]. https://gitlab.com/Linaro/cca-public/build-instructions
> >
> > RFC v2: https://lore.kernel.org/kvm/20260728192630.240375-1-mathieu.poirier@linaro.org/
> > RFC v1: https://lists.gnu.org/archive/html/qemu-devel/2026-07/msg02307.html
> 
> 

