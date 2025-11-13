Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AE60CD98E4
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 21:37:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJezu-0004qq-P7; Thu, 13 Nov 2025 16:36:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vJefg-0007PM-Pi
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 16:16:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vJeff-0002Co-5N
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 16:16:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763068557;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UxfdfeKhksr7Shhwo5KjviUOw/+xEuPJsL1HNVl7OtY=;
 b=aGturQZVNgW0X74kBGiG1I5e1bvK1p1l7JFRdNeI4SOPRr3lWivPmeDJmgh5CR5iHU+uPR
 KjwdE2k2B25zdAWOln4WUO6XaV0mf6SyOWRbwWIX/s/qENRC9gjkYLE6XKIUgk4F9dHdbP
 HYHhJAKDZ/kxHnFXXcjyvuLRtElQNBc=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-4UZjiEiXNe2fwJbXTkWVMg-1; Thu, 13 Nov 2025 16:15:56 -0500
X-MC-Unique: 4UZjiEiXNe2fwJbXTkWVMg-1
X-Mimecast-MFC-AGG-ID: 4UZjiEiXNe2fwJbXTkWVMg_1763068556
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-8b19a112b75so351981385a.1
 for <qemu-devel@nongnu.org>; Thu, 13 Nov 2025 13:15:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763068556; x=1763673356; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=UxfdfeKhksr7Shhwo5KjviUOw/+xEuPJsL1HNVl7OtY=;
 b=e+HyugUYW7y1Ep5Pim1694lYsfyCv93YgKsz2HCbpSwyUQhvYOLzo4HfHOBq1YthsA
 Lw0E74sysqtR/GgkdXPWSTuJEUxxGYiuaH9PTZgdQZPagQob6n5WbH8PF9rl1B77cK1I
 jEN+ta5o6QORCGdx+J4jgXRw4njfH5/Cfvca8DKCVd1lG2lj6rpskJO5f1BaahQIP0/j
 LfMHSRoP3mdNM4q4cDx2814M+6fMeL2e1g/4PUAmXczgw8AHC3uG82QZq0CFYJB/SYS8
 ECyzQGue8JKOcuz+S5gD4gxVUSKDSvdkwrOdTSKk4E31DWBWQ+Zms8fNP72if74Z3+Nw
 YTfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763068556; x=1763673356;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UxfdfeKhksr7Shhwo5KjviUOw/+xEuPJsL1HNVl7OtY=;
 b=ClNrD9QC6lDDUtwwXZSPt5pM0ZFGQj4IkYr2Bg8Ypt7WaHBNlLV4PGCfQZbYIq7VTi
 eebviJRGnkLbPn7jDPDtFwjjVsWpAdq60eA7Jx31RC7ZAdmzgeku0l3vRR9Yx0EjdaR0
 NOSxhgu5efKhjuYmZewbOLqngkm9gzRMZMvDk6pyVGM3BdAWQzj1G7Fi9bvTgWiyEyNr
 1jnAENn/l86fqWgjJIg/hW1DZSGXLgHkkhToRoAejtIkGD0yszurD61OdN+itZNvOytf
 kizlgpupYO26H6sgM7hUPf70NIoZrqufHVdOdt1jFBlW+bwUp2B57SL3y/eCvrBE04h8
 P9zA==
X-Gm-Message-State: AOJu0YxYfo7jUABBnl18vtoG7e4dheRREdaFFre8jrNTYzrxl3We3fO5
 rnil7lctskOQEzk9XpgJEVTKpZWEV2TahJdTFdkTevQRwO3O/7yikiar7GRvFiVHNNN395yOe0S
 OTXw+nhXsnGJoO5B4Od2s5EWf62qnatYYEWSJMKRdmLv2iLXMBopQMWab
X-Gm-Gg: ASbGncs/Yc0qnk2pzfT/nNd24DV/s/2CZoRHJRdN/aRQiyLBXwMChaMHCL+uSMyBgQ7
 XRyu9XJ1mt499lcGAkdEdGG1fjQpqMmurr2Ihf4OsSO/ll52TO21RIDCGJsOoGF3HQitAcS6/xo
 x0M/vJFPa/IXjiBxbX/7yiyRZ+6HMgUH1UNG4QcUC6s8Bgxn0jXVA36GAnAFt0BtrzG0L6ch6hE
 BziTmAYmOyog7UcK9azCCa8iphWYS9+m25WUie/87X6miGoyMrRVZHAEKqYAVQqwPYL2KsbcMvJ
 zLmgDto84ymgTasSjHlTnlPbiaGj4xlIeCEYuPojqihQLaa5ZTtlSntoe9GeokIMYpc6Udlf/dY
 tzA==
X-Received: by 2002:a05:620a:710a:b0:8b2:37ff:de74 with SMTP id
 af79cd13be357-8b2c315efdcmr113657885a.34.1763068555535; 
 Thu, 13 Nov 2025 13:15:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHMvcDpYcM7ipdc1sBxLqGjcUeDHWt5KWQTKaxbVk+dFWFPcQBihaqew1PAJO0C331Jy2dViQ==
X-Received: by 2002:a05:620a:710a:b0:8b2:37ff:de74 with SMTP id
 af79cd13be357-8b2c315efdcmr113654185a.34.1763068555058; 
 Thu, 13 Nov 2025 13:15:55 -0800 (PST)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8b2aef2f9bbsm204732985a.31.2025.11.13.13.15.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Nov 2025 13:15:54 -0800 (PST)
Date: Thu, 13 Nov 2025 16:15:50 -0500
From: Peter Xu <peterx@redhat.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Chenyi Qiang <chenyi.qiang@intel.com>,
 David Hildenbrand <david@redhat.com>, Alexey Kardashevskiy <aik@amd.com>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH 3/8] kvm: Detect guest-memfd flags supported
Message-ID: <aRZKhniIgG7HFaoq@x1.local>
References: <20251023185913.2923322-1-peterx@redhat.com>
 <20251023185913.2923322-4-peterx@redhat.com>
 <30f9d0b9-0a27-4b78-9633-8912bc18998b@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <30f9d0b9-0a27-4b78-9633-8912bc18998b@intel.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

On Fri, Oct 24, 2025 at 11:52:01AM +0800, Xiaoyao Li wrote:
> > @@ -2781,6 +2782,11 @@ static int kvm_init(AccelState *as, MachineState *ms)
> >       kvm_supported_memory_attributes = kvm_vm_check_extension(s, KVM_CAP_MEMORY_ATTRIBUTES);
> >       kvm_guest_memfd_supported = kvm_vm_check_extension(s, KVM_CAP_GUEST_MEMFD) &&
> >           kvm_vm_check_extension(s, KVM_CAP_USER_MEMORY2);
> > +    ret = kvm_vm_check_extension(s, KVM_CAP_GUEST_MEMFD_FLAGS);
> > +    if (ret > 0)
> > +        kvm_guest_memfd_flags_supported = (uint64_t)ret;
> > +    else
> > +        kvm_guest_memfd_flags_supported = 0;
> 
> Nit:
> 1. QEMU's coding style always requires curly braces.
> 2. is the (uint64_t) necessary?
> 3. can we name it "kvm_supported_guest_memfd_flags" to make it consistent
> with "kvm_supported_memory_attributes"?
> 
> so how about
> 
> kvm_supported_guest_memfd_flags = kvm_vm_check_extension(s,
> KVM_CAP_GUEST_MEMFD_FLAGS);
>     if (kvm_supported_guest_memfd_flags < 0) {
>         kvm_supported_guest_memfd_flags = 0;
>     }

Yep this looks good, I'll use it, thanks.

-- 
Peter Xu


