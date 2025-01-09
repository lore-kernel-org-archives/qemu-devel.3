Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9B84E77197
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 14:20:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVtNj-0004mn-1g; Thu, 09 Jan 2025 09:19:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tVtNg-0004lw-LL
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 09:19:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tVtNf-0001tH-3F
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 09:19:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736432364;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lkmqkv2mprE5t/ET+K44GrDuoaHXToS6/lVM0sWGRGs=;
 b=adTBddNeJ+UkYEY0vh3hZmrTu9HYA2iEYdLlTMbjOlH2cfVGWtI5aPNJ0giUhno3loZBDj
 95dtTCq+DG7NJSH3uelX2HGGilE+mBWSWIoGytIgDlW/Unkkzjlt2jes0AJCNwwhPKXVfK
 YoptxtabdGDBjnx8LNkEzsCe9tlPvnE=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-CqiiVujOO--EpCgz775O3A-1; Thu, 09 Jan 2025 09:18:12 -0500
X-MC-Unique: CqiiVujOO--EpCgz775O3A-1
X-Mimecast-MFC-AGG-ID: CqiiVujOO--EpCgz775O3A
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-468f6f2f57aso11942591cf.0
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 06:18:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736432292; x=1737037092;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lkmqkv2mprE5t/ET+K44GrDuoaHXToS6/lVM0sWGRGs=;
 b=C5STiEcDkTi51w5zgjssk/gCJC5AdtSK3dYxgQyO8Q8HDuCr02WvS2PqUIPQW7Sm4z
 3w71IlLrgsSD4hxb9w78mlC2Y6edVZEFZblomFbThaF9evsdGg0ncOdJQfPevpR3qg1G
 ectCBZFlPkBazdmFHPwNyc+COruH3kHFRBM+ZqblwMCFbM52tgvuMTx2ibU0/AEU/7AQ
 UANwXpB3pw6swhuNQLHPFcHduzAGj8lwJOr9qbmbRBBeRzC6S2L4Xb8dUJ5sHL+h2Iqu
 9pnQ/sEQ1Y8Zk3C+PFeJylGwoKYgzQVyJrOxTUrZ8gzB6iC4P9IMAfrQLy8DkheH2eOD
 XD2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVcGpgewLHh+qOwygbGsDJZ5nICzGfwpM4RzP0NCiCoqnUUYAfcf6Pvx9+NmhLSK+rAwDvUVzCnj/B+@nongnu.org
X-Gm-Message-State: AOJu0YzlXD30d0Y0JQDXU4eXD6Khs10bcM5oRh8HO2gLXWK8Gn5Z6PeI
 xfyE3FNDxm4R0qb6mum3+hi4063gJI/I6ceoS4tIym3Oy4ZCcvn4xmFAVlVtnKkAOJ9G0JeK3Jv
 Ktow1H5gfEP9DVbNHEaV9dn6sHvJlisSdkc81mCBGP4QS6M3FFotA
X-Gm-Gg: ASbGncuEb4Qcyk3rLpK5qh71C6mUryZByU62dsfyn1FTBTtrnNiiXPr2j2Tfu52gFKF
 WzR1mPWg5EX60pQD45Xk+j9y8tNacAlJBCsDEUXFovTxrbmwkCnBWOl4Ogcyz+TiFoWqQXvJ3Lo
 UahxPU/anFtv3VWiB7DPKWXlfQQoDJ0AngoIjC5gwlX2epaex7dpyKm94LsFGjYRN7CwW1AV9dY
 69M3rDdHX29/95ntQr6fUrz17JhG8o3ZbTfNd+/IoVU4EKIpNPUsv7BoeHA2IRwM3h1Op+YE25V
 tUafBEP4bA51xlNwwA==
X-Received: by 2002:a05:620a:28d6:b0:7b6:ce4c:69d2 with SMTP id
 af79cd13be357-7bcd9718591mr1043466785a.36.1736432292501; 
 Thu, 09 Jan 2025 06:18:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IErNc8Zp51CPNFPjkle5K527uLhYlVBs6hGYfc1F2zwkK78rIJesoNHfzL0/vR2pj0OIJC35g==
X-Received: by 2002:a05:620a:28d6:b0:7b6:ce4c:69d2 with SMTP id
 af79cd13be357-7bcd9718591mr1043462085a.36.1736432292100; 
 Thu, 09 Jan 2025 06:18:12 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7bce3502ac6sm70863885a.75.2025.01.09.06.18.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jan 2025 06:18:11 -0800 (PST)
Date: Thu, 9 Jan 2025 09:18:08 -0500
From: Peter Xu <peterx@redhat.com>
To: Daniil Tatianin <d-tatianin@yandex-team.ru>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 4/4] overcommit: introduce mem-lock=on-fault
Message-ID: <Z3_aoLOjzQ8M0h81@x1n>
References: <20241211230433.1371327-1-d-tatianin@yandex-team.ru>
 <20241211230433.1371327-5-d-tatianin@yandex-team.ru>
 <Z1sNV-kHCJw9S9Di@x1n>
 <b5ec2f53-4a03-499b-be17-49729a6efca9@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b5ec2f53-4a03-499b-be17-49729a6efca9@yandex-team.ru>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.436,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Jan 09, 2025 at 11:47:40AM +0300, Daniil Tatianin wrote:
> On 12/12/24 7:20 PM, Peter Xu wrote:
> 
> > On Thu, Dec 12, 2024 at 02:04:33AM +0300, Daniil Tatianin wrote:
> > > Locking the memory without MCL_ONFAULT instantly prefaults any mmaped
> > > anonymous memory with a write-fault, which introduces a lot of extra
> > > overhead in terms of memory usage when all you want to do is to prevent
> > > kcompactd from migrating and compacting QEMU pages. Add an option to
> > > only lock pages lazily as they're faulted by the process by using
> > > MCL_ONFAULT if asked.
> > > 
> > > Signed-off-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
> > Reviewed-by: Peter Xu <peterx@redhat.com>
> 
> Hi there! This series has 2 reviewed-bys, is there any way you could queue
> it?

I think this part belongs to mainloop/posix.. so maybe Paolo?

Also copied Phil and Peter Maydell.

-- 
Peter Xu


