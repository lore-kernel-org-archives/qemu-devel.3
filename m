Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A73BCCD1AB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 14:38:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBZyF-0008WP-Sy; Wed, 22 Oct 2025 10:37:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1vBZyD-0008WH-Kn
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 10:37:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1vBZyA-0005k9-Ea
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 10:37:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761143860;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=67FSug6zeEedWhs7HHydiqrnW3dFyI+2T7i1JWF+OZ8=;
 b=a1aK9Yf8wFS2Bk20V+c5GnI2kCo21y55MFfyEeetEBvGs/Bt1QJ/4jXgYLMrzrS562MHvP
 dKqecH55TDueyZtphon2Osv8Sxm68UvE3z9Hjcx4G7LChdG9a+5hS+UfJOZ9Flbwx7fyxp
 NrnGktjPP1PPuSQP7uoiAOviLkBy6K8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-451-wWXdZ0h-M1qN675zwDtK9w-1; Wed,
 22 Oct 2025 10:37:37 -0400
X-MC-Unique: wWXdZ0h-M1qN675zwDtK9w-1
X-Mimecast-MFC-AGG-ID: wWXdZ0h-M1qN675zwDtK9w_1761143856
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5D92718002E4; Wed, 22 Oct 2025 14:37:36 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.32.27])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AA62A1800451; Wed, 22 Oct 2025 14:37:35 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 291B318000B5; Wed, 22 Oct 2025 16:37:33 +0200 (CEST)
Date: Wed, 22 Oct 2025 16:37:33 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Luigi Leonardi <leonardi@redhat.com>
Cc: qemu-devel@nongnu.org, Stefano Garzarella <sgarzare@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Roy Hopkins <roy.hopkins@randomman.co.uk>
Subject: Re: [PATCH v4 4/5] igvm: add support for initial register state load
 in native mode
Message-ID: <5pt6iktxt7fjegov2axrrux3woywuze3cqqmiptwdzayl6vvam@fjm6yyypscrg>
References: <20251022084439.242476-1-kraxel@redhat.com>
 <20251022084439.242476-5-kraxel@redhat.com>
 <ijrybqltievczxvugi4hhnftqqeg42o6vshhnirrz2ugeotplf@cq62mc5seswc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ijrybqltievczxvugi4hhnftqqeg42o6vshhnirrz2ugeotplf@cq62mc5seswc>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

  Hi,

> > +struct IgvmNativeVpContextX64 {
> > +    uint64_t rax;
> > +    uint64_t rcx;
> > +    uint64_t rdx;
> > +    uint64_t rbx;
> > +    uint64_t rsp;
> > +    uint64_t rbp;
> > +    uint64_t rsi;
> > +    uint64_t rdi;
> > +    uint64_t r8;
> > +    uint64_t r9;
> > +    uint64_t r10;
> > +    uint64_t r11;
> > +    uint64_t r12;
> > +    uint64_t r13;
> > +    uint64_t r14;
> > +    uint64_t r15;
> > +    uint64_t rip;
> > +    uint64_t rflags;
> > +    uint64_t idtr_base;
> > +    uint16_t idtr_limit;
> > +    uint16_t reserved[2];
> > +    uint16_t gdtr_limit;
> > +    uint64_t gdtr_base;
> > +
> > +    uint16_t code_selector;
> > +    uint16_t code_attributes;
> > +    uint32_t code_base;
> > +    uint32_t code_limit;
> > +
> > +    uint16_t data_selector;
> > +    uint16_t data_attributes;
> > +    uint32_t data_base;
> > +    uint32_t data_limit;
> > +
> > +    uint64_t gs_base;
> > +    uint64_t cr0;
> > +    uint64_t cr3;
> > +    uint64_t cr4;
> > +    uint64_t efer;
> > +};

> IIUC `R_TR` and `R_LDTR` are used by HVF in QEMU. Is there a reason why you
> didn't add them here?

They are not present in IgvmNativeVpContextX64, so you can't set them
via igvm for the initial vcpu state.  Of course the guest can set them
later on.

take care,
  Gerd


