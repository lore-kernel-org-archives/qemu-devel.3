Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAAECD767FA
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 19:22:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6ajX-0002sj-NE; Thu, 31 Oct 2024 15:21:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t6ajV-0002rI-2D
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 15:21:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t6ajT-00005D-7Y
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 15:21:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730402482;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bFEq2LOocrK5arOpHd1ZiKXHPlbj1j917u/UJG1NIzk=;
 b=QvfosG63SjyWFTaN0vFox0VRHSNr14Cy8odw3W4RqWCJ9fumxpCupyRf6qbvr5SzTd8Nv+
 mRzkSqtYRf59RctvVwaRjbima33W7M9/g5cypgAKoUUgVHLRGzYjeu1GP0YuimWwB9LOQ7
 LuN8ILoh24Y3ozy7SgaRU9iQboWI2v0=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-UCtoB_yQPduGTdZBAktT_A-1; Thu, 31 Oct 2024 15:21:20 -0400
X-MC-Unique: UCtoB_yQPduGTdZBAktT_A-1
Received: by mail-yb1-f197.google.com with SMTP id
 3f1490d57ef6-e30b8fd4ca1so2370164276.3
 for <qemu-devel@nongnu.org>; Thu, 31 Oct 2024 12:21:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730402480; x=1731007280;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bFEq2LOocrK5arOpHd1ZiKXHPlbj1j917u/UJG1NIzk=;
 b=t8UAgy6beP3fEmt196WIlpmCZ3aqyzLo5lfnd1+BGZOd+RYRTl+MbA8P20RBVF70WV
 x9f/PQuRGrarPIC5ASz3IpsSdbLTl3F03z86cqOC5yWaQF7gzW6rdiUQdCSx9naqIhjr
 YktFIWySUbZb/hV76ALo3vexEHgP8dIHe/K7suc/XncJcATmM2Po28sAar6AENO/SOw3
 iy6N/9g3t+c3Hi2LCXH2jv0YUhrmEm9tS7Pfj2so2U0nnuu9gGeChbzu9jpfWd3TDA9v
 KTo6jOkrIwAQcwXRsfWV+syomHEXaVOsQjVK4rMFG/WmdXZp4H5mJh1NVuFR+XTrwgpm
 ILzQ==
X-Gm-Message-State: AOJu0YwFh6ErWFiSwsrbFPq4gzV7rlQV6J0o8Uuf4gNllUhwbzyZHQdD
 79qGwXsndw90UJmQwIZxbzoUcQ+gQQr4/sgwZBJZQugZF5CfULgQvhIW/yiZs796/AbBlU31SAV
 MNCYnK9PQuWrmMmqQdpgrczBu57lhoHqAuVblh1HAkR8cimAtGB/D
X-Received: by 2002:a05:6902:70d:b0:e30:dc66:5877 with SMTP id
 3f1490d57ef6-e30dc665a41mr6390472276.17.1730402480095; 
 Thu, 31 Oct 2024 12:21:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFygJe08RzRJf0StU505K7SW2GPacgaJlbLW54zNNKkNYEp8XFW1qBEv9IrklMHrQQAK2ykXw==
X-Received: by 2002:a05:6902:70d:b0:e30:dc66:5877 with SMTP id
 3f1490d57ef6-e30dc665a41mr6390461276.17.1730402479745; 
 Thu, 31 Oct 2024 12:21:19 -0700 (PDT)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-462ad08a8b1sm10572601cf.19.2024.10.31.12.21.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Oct 2024 12:21:19 -0700 (PDT)
Date: Thu, 31 Oct 2024 15:21:17 -0400
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC 3/5] convert code to object_new_dynamic() where appropriate
Message-ID: <ZyPYreQWvtG7bH3P@x1n>
References: <20241031155350.3240361-1-berrange@redhat.com>
 <20241031155350.3240361-4-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241031155350.3240361-4-berrange@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.366,
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

On Thu, Oct 31, 2024 at 03:53:48PM +0000, Daniel P. Berrangé wrote:
> In cases where object_new() is not being passed a static, const
> string, the caller cannot be sure what type they are instantiating.
> There is a risk that instantiation could fail, if it is an abstract
> type.
> 
> Convert such cases over to use object_new_dynamic() such that they
> are forced to expect failure. In some cases failure can be easily
> propagated, but in others using &error_abort maintainers existing
> behaviour.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  chardev/char.c                   |  5 ++++-
>  hw/core/bus.c                    |  2 +-
>  hw/core/cpu-common.c             |  2 +-
>  hw/core/qdev.c                   |  4 ++--
>  hw/i386/x86-common.c             |  5 ++++-
>  hw/i386/xen/xen-pvh.c            |  2 +-
>  hw/vfio/common.c                 |  6 +++++-
>  hw/vfio/container.c              |  6 +++++-
>  qom/object_interfaces.c          |  7 ++-----
>  qom/qom-qmp-cmds.c               | 15 +++++++++------
>  tests/unit/check-qom-interface.c |  3 ++-
>  tests/unit/test-smp-parse.c      | 20 ++++++++++----------
>  12 files changed, 46 insertions(+), 31 deletions(-)

I think we could leave the test cases alone without _dynamic(), because
they do test static types (even if they used "opaque"..), and they should
really (and forever) assert on failures..

IMHO we should keep _dynamic() usages small if we'd like to introduce it,
only in the paths where its failure will be properly handled.  Basically, I
think we shouldn't use _dynamic() if we know it'll be error_abort.. because
that's fundamentally identical to object_new().

A small set of _dynamic() usages also keep us easy to track all the paths
where QEMU can create some totally random objects too.

-- 
Peter Xu


