Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B403CCCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 21:40:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v44Wu-0004ng-I6; Wed, 01 Oct 2025 17:38:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v44Wk-0004mJ-VY
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 17:38:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v44WW-0002R2-Sf
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 17:38:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759354670;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sHJbqne6/6YMBH+43gDkcKMOvKoPAwqGJRJz6cOwLu0=;
 b=P76uzyob49yD7nBKQf0kZHfANfKo9tHqeZ5z5haoO0x+ESn/sMWnMFG06h2BGQ7XqhYBEA
 uMBWFSimrKajx0mZNG7rvP04bcgRSan6KF2NqNRj1cl+hUws6l5pTC8i36iVl/najmLVIl
 s5YH0k59YVec1t2qs1JNAXFWTD18A40=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-6QSdnuqROiWMF5-nm36cUw-1; Wed, 01 Oct 2025 17:37:49 -0400
X-MC-Unique: 6QSdnuqROiWMF5-nm36cUw-1
X-Mimecast-MFC-AGG-ID: 6QSdnuqROiWMF5-nm36cUw_1759354669
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-4df80d0d4aaso19784731cf.2
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 14:37:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759354669; x=1759959469;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sHJbqne6/6YMBH+43gDkcKMOvKoPAwqGJRJz6cOwLu0=;
 b=IR6i8lohLuTGk2Ij+yF1CZlTsRjwxzOUikfd3K6h27DmbDaGxcO5448PIOkKJvrENd
 8deCEdD9UjQYyfUVUSysaZEDSEkxRpnkUqG5KPFCwM0tNKH92tXZ0rnw2htyjemp0Ndb
 TnCoEiG5gO8i/wnXaYBcdjbo/eRy1/TCaxt6C2TXK733BZs+zUghVnTLdye9WHIgDMbY
 XkTkX/YsLvwiV3PxYgxdRwmWQRMZ0/292m6M0HCdUh2B12DfAKMzW9wi511c2h9BgX6/
 z4GOSaJXGTabpWgOmsmuCsrJ26BJ5HlD/H1rxnhNQE1odGJk70YbfImj4qBj2IwXEfLz
 iQNQ==
X-Gm-Message-State: AOJu0Yz9clN6JLiVdo66Z424DnVffLq7dFY6hpwTyU9usB9rlJJodusb
 aSztBkx7rkdS6SveWgiVEj/fcuDLk8fOET+p9Xy1bWEDmRDxNb1pL/QiBEsNYJiCWFrnupf5kn1
 JekH+bDTiBNeHtBQMHDbeEfFQmdbuIztT8ooLU67cKv50MbgSXcNNmpxx
X-Gm-Gg: ASbGncuhJrDj6bt03UWle/ghcEguU7iekAbNykc/U9ddrJYdb55YoXUAMKpvLeOvH4+
 P5LT0dEOhs3Xvu3tFgMO6BiNbLbn3a6zD2gopMEgjHCYlxGXBHuwdAGczK2ZyNbernZGNvdxRce
 Qb/3F3LG+mj9Qlpc9zPIO6Pk+i3TUXZ4n3rBh4hWlmoIVtb8brHj7tV3sshj1BW1svkXUQiRqzh
 GX+iaqjhbhIW+fKSDSUUkdc+d20nw1ybSC4QW4akj39/df27CUSmss7OSXK6U4P+B0ov++i8ju4
 Gu57Eagm+LPipLBFxe4475mfzXDVBpsoFue42w==
X-Received: by 2002:a05:622a:1116:b0:4b5:f6c5:cfc with SMTP id
 d75a77b69052e-4e41cb17ba8mr62565381cf.19.1759354668852; 
 Wed, 01 Oct 2025 14:37:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHF7D5SiVXlU3VzKn1vFwWngvnc77ftz8kd2eeIRy5ITJ8sneQn6jRS6dditye+sRJYY29jVg==
X-Received: by 2002:a05:622a:1116:b0:4b5:f6c5:cfc with SMTP id
 d75a77b69052e-4e41cb17ba8mr62565091cf.19.1759354668375; 
 Wed, 01 Oct 2025 14:37:48 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-878bdf533a0sm7753656d6.58.2025.10.01.14.37.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Oct 2025 14:37:47 -0700 (PDT)
Date: Wed, 1 Oct 2025 17:37:46 -0400
From: Peter Xu <peterx@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 0/3] system: Don't leak CPU AddressSpaces
Message-ID: <aN2fKu6wfPSQx05S@x1.local>
References: <20250929144228.1994037-1-peter.maydell@linaro.org>
 <1c567b4a-4966-4374-8851-81c9b1393d8a@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1c567b4a-4966-4374-8851-81c9b1393d8a@linaro.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.518,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Oct 01, 2025 at 01:36:16PM -0700, Richard Henderson wrote:
> On 9/29/25 07:42, Peter Maydell wrote:
> > When a vCPU is created, it typically calls cpu_address_space_init()
> > one or more times to set up its address spaces. We don't currently
> > do anything to destroy these address spaces, which means that we
> > will leak them on a vcpu hot-plug -> hot-unplug cycle.
> > 
> > This patchset fixes the leak by replacing the current
> > cpu_address_space_destroy() (which has an awkward API, includes
> > a bug, and is never called from anywhere) with a new
> > cpu_destroy_address_spaces() which cleans up all the ASes a CPU
> > has and is called from generic unrealize code.
> > 
> > Patch 1 is just a comment improvement to clarify that
> > address_space_destroy() defers most of its work to RCU and you
> > can't free the memory for the AS struct itself until it's done.
> > 
> > Patch 2 is from Peter Xu; we need to be able to do "destroy and
> > free an AS" via RCU, and at the moment you can't do that.
> > 
> > Patch 3 is the bugfix proper.
> 
> So... I wonder this is really the right direction.
> 
> To be specific:
> 
> Over in split-accel-land we recently had a bit of a kerfuffle over TCG
> registering its MemoryListener with all of the per-cpu address spaces and
> HVF not doing so.  Things get even more complicated when one finds out that
> some MemoryListener callbacks are only used with "global" address spaces and
> some are only used with the per-cpu address spaces.

I only have a very preliminary understanding on this, so please bare with
me if I'll make silly mistakes...

I was expecting QEMU provides both the global view (address_space_memory),
and the per-vcpu view.  Then we can register to any of them on demand.
Then the global views can be the so-called "board model" mentioned below.

Is it not the case?

The root MR is also shared in this case, making sure the address space
operations internally will share the same flatview.

> 
> On reflection, it seems to me that no address spaces should be owned by the
> cpus.  All address spaces should be owned by the board model, and it should
> be the board model that configures the address spaces used by each cpu.
> 
> If we do this then address spaces, and even the array of address spaces, may
> be created once by the board, shared between all (relevant) cpus, and not
> destroyed by cpu unplug.
> 
> Moreover, in the context of virtualization, there's now exactly one address
> space (since Arm Secure and Tag memory spaces are not required or supported
> except by emulation; I assume the same is true for x86 smm), and the
> aforementioned kerfuffle goes away.  There's no difference between global
> and per-cpu address spaces.
> 
> Anyway, it seems like this provides the same flexibility in the complex
> heterogeneous case and simplifies things for the homogeneous virtualization
> case.

We have another question to ask besides this design discussion: Peter's
series here solidly fixes a memory leak that can easily reproduce with
x86_64 + KVM on cpu hotplugs.

Should we still merge it first considering it didn't change how we manage
per-vcpu address spaces, but only fixing it?  Then anything like a big
overhaul can happen on top too.

Thanks,

-- 
Peter Xu


