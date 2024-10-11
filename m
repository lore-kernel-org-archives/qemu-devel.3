Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72A05D0EE1E
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2024 17:37:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1szJ9p-0008Kz-HJ; Fri, 11 Oct 2024 13:10:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1szJ6C-0000hD-CL
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 13:06:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1szGAU-0001Po-KU
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 09:59:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728655136;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=7JnSocFVG88fWSowPcnJ+DBMsG/uiWApFaUq2h8jatI=;
 b=eyOnSybjbp+Odcoan3hWv0VWHESf9oqnQkg934bwJi/tRJ1S/5/+RotGaC/USsGM2o91w7
 7x5qt+/M+NMmqqoKqnG6FUYYdVWTh8vuNMhXA8wQ6+I6c25/IjZmY6t0ZiqWNwbB5o0bPX
 yFqv7zE4vhqOaB725PZ+k/+2TLyJHZA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-k0CJ-O54NDa9PLCHTsT_Sg-1; Fri, 11 Oct 2024 09:58:55 -0400
X-MC-Unique: k0CJ-O54NDa9PLCHTsT_Sg-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-430581bd920so12840595e9.3
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2024 06:58:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728655134; x=1729259934;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7JnSocFVG88fWSowPcnJ+DBMsG/uiWApFaUq2h8jatI=;
 b=ixQeymInwfzRoIel0svjoQM8NqpbTVmZNwJ66N8a3qol0OcY+JeC/U6O2O2SUU3Rha
 qNP1X/YSW1GBh76h9ynqSswKLnaFnJx8bYrEvtCcVJjnIxtr20ituCZ5HV/7/KnIpT5o
 IP07pQDgGXuFR1yBA/A8apJxe7PXqHZCMEqVIbIWph1br4SBL6XCTi/HJWkl7DDC0IeR
 Eh9pYcTQl7FampjN/Ix4CKKvcRQKa2E3lSUmwB/0tO5wV1+6OF/yTkj5GsEp9DCe16zT
 y+hxD8D2FYPpoBrg9lBKL2vmHKRFTBqMOb1fRfnZ7PdX9zUnMot5sY3a2GyMZyRYM8mx
 7a4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7WKo6qJ2uzlSQ1Ru6qWGqHNXcRzqLC22wSDYkrcmffz41RihGeAJNlNKjyYpBV8QF528ffjHiHv/J@nongnu.org
X-Gm-Message-State: AOJu0YwSinvMjjBklXp/l2QnQfsUXUX5e8k+GP8A+FYHFLhAbiVPAcDT
 Xm1Cmz1oxULyYcT13DtRmeEArylo3N5N+ngEHdmcE3Oi2kBUkanTCE4KTvNXBew29969Ei605Bw
 w8vA9kqnNkfOiNDLI6DVzkjrkDrory3jjYL8qI7O3PT3IazV/nAmm
X-Received: by 2002:adf:ea8d:0:b0:37c:ccad:733a with SMTP id
 ffacd0b85a97d-37d55304285mr1824095f8f.59.1728655134308; 
 Fri, 11 Oct 2024 06:58:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEk15gMzEe4P8XHMOf2C56/s2w6QRls1VLOwO088RY+wHmviv6Ag0LpvFNZmzeyzbBRoxyVXA==
X-Received: by 2002:adf:ea8d:0:b0:37c:ccad:733a with SMTP id
 ffacd0b85a97d-37d55304285mr1824075f8f.59.1728655133822; 
 Fri, 11 Oct 2024 06:58:53 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-431182d7ca3sm43147635e9.2.2024.10.11.06.58.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Oct 2024 06:58:52 -0700 (PDT)
Message-ID: <2d73cfad-50b7-4d21-b3c3-e4d6635bf80d@redhat.com>
Date: Fri, 11 Oct 2024 15:58:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_v2_00/17=5D_Multifd_=F0=9F=94=80_device_st?=
 =?UTF-8?Q?ate_transfer_support_with_VFIO_consumer?=
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>,
 qemu-devel@nongnu.org
References: <cover.1724701542.git.maciej.szmigiero@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <cover.1724701542.git.maciej.szmigiero@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.15,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hello Maciej,

On 8/27/24 19:54, Maciej S. Szmigiero wrote:
> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
> 
> This is an updated v2 patch series of the v1 series located here:
> https://lore.kernel.org/qemu-devel/cover.1718717584.git.maciej.szmigiero@oracle.com/
> 
> Changes from v1:
> * Extended the QEMU thread-pool with non-AIO (generic) pool support,
> implemented automatic memory management support for its work element
> function argument.
> 
> * Introduced a multifd device state save thread pool, ported the VFIO
> multifd device state save implementation to use this thread pool instead
> of VFIO internally managed individual threads.
> 
> * Re-implemented on top of Fabiano's v4 multifd sender refactor patch set from
> https://lore.kernel.org/qemu-devel/20240823173911.6712-1-farosas@suse.de/
> 
> * Moved device state related multifd code to new multifd-device-state.c
> file where it made sense.
> 
> * Implemented a max in-flight VFIO device state buffer count limit to
> allow capping the maximum recipient memory usage.
> 
> * Removed unnecessary explicit memory barriers from multifd_send().
> 
> * A few small changes like updated comments, code formatting,
> fixed zero-copy RAM multifd bytes transferred counter under-counting, etc.
> 
> 
> For convenience, this patch set is also available as a git tree:
> https://github.com/maciejsszmigiero/qemu/tree/multifd-device-state-transfer-vfio
> 
> Based-on: <20240823173911.6712-1-farosas@suse.de>


I must admit, I’m a bit lost in all the discussions. Could you please
resend a v3 on top of the master branch, incorporating the points
discussed and agreed upon ? Many thanks to Peter for leading the
discussion, his expertise in this area is invaluable.

Please include a summary of the proposed design (and alternatives) in
the cover letter. Diagrams of the communication flows between src/dest
threads would be a plus to understand better the proposal. Such level
of details should go under docs/devel/migration at end. So, it might
good to invest some time for that.

Performance figures would be good to have in the cover. The ones from
your presentation at KVM forum 2024 should be fine unless you have
changed the design since.

 From there, we can test and stress to evaluate the benefits of the
changes for mlx5 VF and vGPU migration. Once we have the results,
we can determine how to upstream the changes, either all at once
or splitting the series.


Quoting Peter,

   "I am sorry to ask for this, Fabiano already blames me for this,
   but.. logically it'll be best we use no new thread in the series,
   then one patch on top with your new thread solution to justify its
   performance benefits and worthwhile to having those threads at all."

I fully support this step-by-step approach. VFIO migration is a recent
feature. It can be stressed in a complex environment and is not fully
optimized for certain workloads. However, I would prefer to introduce
changes progressively to ensure stability is maintained. It is now
acceptable to introduce experimental knobs to explore alternative
solutions.

Also, quoting again Peter,

   "PS: I'd suggest if you really need those threads it should still be
    managed by migration framework like the src thread pool. "

yes, I would prefer to see the VFIO subsystem rely on common QEMU APIs
and in this case, a QEMU multifd API too.

Thanks,

C.




