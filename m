Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF3B9C0218C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 15:38:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taGKp-0005QR-NB; Tue, 21 Jan 2025 10:38:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1taGKi-0005M5-RX
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 10:38:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1taGKf-0007sq-SA
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 10:38:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737473903;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7vWlp2CUskTYXbSVehnKEKMyRmaqBpVNMhezv4fMKgM=;
 b=JXZSg1aEgZssqmi33MMdzSG8j5MhzK1YBA29Ci42MuZ728UxeGt9T48e8cDu6EZt0bCbOw
 DTbXj/E066jaZalF6Vn9A/XpxffV4cBA7vt12VurFU0G+AwAaGLdshIupBAyuhix2vWewT
 41zgiM9NHBAGKgt+XfjJCiztfLoEAL8=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-548-V3BRIrspNEqbBXt3Bs0eLg-1; Tue, 21 Jan 2025 10:38:21 -0500
X-MC-Unique: V3BRIrspNEqbBXt3Bs0eLg-1
X-Mimecast-MFC-AGG-ID: V3BRIrspNEqbBXt3Bs0eLg
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6d87d6c09baso85453006d6.3
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 07:38:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737473901; x=1738078701;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7vWlp2CUskTYXbSVehnKEKMyRmaqBpVNMhezv4fMKgM=;
 b=jSoi+rV6UO34UxqwFiPKutB+kqOzYSbiC26LS2CfhlWBUZCw+Kcu6avdMnpeB3ax2Z
 TeusoCYqGZ0NNLofNOWzMYslq3OgoFKqYkGA4vAZoGWNsTME8cZerWja2Ug+oOQv7jCL
 +wfGuDUZs5OFLYKrra7n+UxkLoJBmzG4CUrKsDYuPmqGTAJXle1NO/nX4aE9AsTErkFj
 j5p1Kei51HoMuPRkmr5nPMafXHn4mz2XT2UoKu28ol7BrTN3D4gELO21lBClfBUQ+wa7
 pyRvyXozrYqmX8DPi/U6agLjo94GyP35OE/5bHUMmyaDkqO4q4LfUdQtdEk1lEtbUTDG
 JSlw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLA25P+3k+ioHAIlL4YiPDoBVvA+ottiK8j6gJWT7c8FV4es3f+QE0lMLKmWk762V196Nn7SXzrOd1@nongnu.org
X-Gm-Message-State: AOJu0YwPCWv+sndPtS7D8R+K2hZgHHBM0keiJZcWzmcUMP0aEE9cd1eP
 7+nAdjdQUv3pLURU5U7Fk49o0egJw1mX8TJxlea9mtMpbxru5Udo4yn/DOs8pTMCwh/ZmFBkRpx
 ttxSBSXbRTqJPJB9czMGTdLvUCw/v6V5cijBTWgNUFiaQwn2kVWFq
X-Gm-Gg: ASbGncvuuxqjS4PjX8NV4MVQsYRqrZhNEI47npG7hXwRjPts0AN/1g7HiPhFINBzsyp
 D/CoUAC36jQUCaU2e09zfCQoHtHjwUXFh0MG5UfHIeTpW4CJMwrH4tep/OwTm5UF+W+IjqJf6Q+
 Bo3CyX6xupTf+GPsG/vZ7jRDSAfQM+OvQW2vE8RIZNK3QLXfZoYvlJQl6sStBA6CzNluO4/2Zts
 0YDP1j2n0pMMOO6RH08CfxHXng8VbxwOZQ42jI4EXBAlszUdZsp3s8RAaK//LJFKON5jG61pQ1Q
 +wQBrMSFRp7Tm7ZdYIa3mLMIGfJ6VNo=
X-Received: by 2002:a05:6214:1305:b0:6d3:fa03:23f1 with SMTP id
 6a1803df08f44-6e1b2186a41mr285474056d6.13.1737473901083; 
 Tue, 21 Jan 2025 07:38:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHgfx1VJkB5kdl2P+V5WFmu/JkUYutt6JPaRTYfjpiG4rWtIeQDLUTt4TZ3FFWubwJB5OXSGA==
X-Received: by 2002:a05:6214:1305:b0:6d3:fa03:23f1 with SMTP id
 6a1803df08f44-6e1b2186a41mr285473756d6.13.1737473900788; 
 Tue, 21 Jan 2025 07:38:20 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e1afbf3783sm51948996d6.7.2025.01.21.07.38.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jan 2025 07:38:20 -0800 (PST)
Date: Tue, 21 Jan 2025 10:38:11 -0500
From: Peter Xu <peterx@redhat.com>
To: Chenyi Qiang <chenyi.qiang@intel.com>
Cc: David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Roth <michael.roth@amd.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Williams Dan J <dan.j.williams@intel.com>,
 Peng Chao P <chao.p.peng@intel.com>, Gao Chao <chao.gao@intel.com>,
 Xu Yilun <yilun.xu@intel.com>
Subject: Re: [PATCH 2/7] guest_memfd: Introduce an object to manage the
 guest-memfd with RamDiscardManager
Message-ID: <Z4-_Y-Yqmz_wBWaU@x1n>
References: <20241213070852.106092-1-chenyi.qiang@intel.com>
 <20241213070852.106092-3-chenyi.qiang@intel.com>
 <Z46RT__q02nhz3dc@x1n>
 <a55048ec-c02d-4845-8595-cc79b7a5e340@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a55048ec-c02d-4845-8595-cc79b7a5e340@intel.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.086,
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

On Tue, Jan 21, 2025 at 05:00:45PM +0800, Chenyi Qiang wrote:
> >> +
> >> +    /* block size and alignment */
> >> +    uint64_t block_size;
> > 
> > Can we always fetch it from the MR/ramblock? If this is needed, better add
> > some comment explaining why.
> 
> The block_size is the granularity used to track the private/shared
> attribute in the bitmap. It is currently hardcoded to 4K as guest_memfd
> may manipulate the page conversion in at least 4K size and alignment.
> I think It is somewhat a variable to cache the size and can avoid many
> getpagesize() calls.

Though qemu does it frequently.. e.g. qemu_real_host_page_size() wraps
that.  So IIUC that's not a major concern, and if it's a concern maybe we
can cache it globally instead.

OTOH, this is not a per-ramblock limitation either, IIUC.  So maybe instead
of caching it per manager, we could have memory_attr_manager_get_psize()
helper (or any better name..):

memory_attr_manager_get_psize(MemoryAttrManager *mgr)
{
        /* Due to limitation of ... always notify with host psize */
        return qemu_real_host_page_size();
}

Then in the future if necessary, switch to:

memory_attr_manager_get_psize(MemoryAttrManager *mgr)
{
        return mgr->mr->ramblock->pagesize;
}

Thanks,

-- 
Peter Xu


