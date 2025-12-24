Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4119DE776C0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 15:37:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYQvW-00075m-PP; Wed, 24 Dec 2025 10:37:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vYQul-00072B-Vw
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 10:36:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vYQui-0007fW-CA
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 10:36:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766590595;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xoR3JM9hywUgWNEAzCeZbWDsQXh9ro37T4fJLNkTV5Y=;
 b=BTB69dMdhWqVgljJYSbZe6kHYo4Zm6b9F3LNsdRQAJ11ErWKpuAeabCNaY+xcCz2GOzUdk
 MEzloNIfq7+SNejp5f2vcW0rqEn+QF/Rfr+467YSw20kHi+TMgRPjnil5qxw1zet/LbITq
 hevppyAN6emBG/G1o8TUty5jEd7/z30=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-325-2UGdBA7YMISWS_NsOP4ZPQ-1; Wed, 24 Dec 2025 10:36:31 -0500
X-MC-Unique: 2UGdBA7YMISWS_NsOP4ZPQ-1
X-Mimecast-MFC-AGG-ID: 2UGdBA7YMISWS_NsOP4ZPQ_1766590591
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-4edad69b4e8so126929841cf.1
 for <qemu-devel@nongnu.org>; Wed, 24 Dec 2025 07:36:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766590591; x=1767195391; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=xoR3JM9hywUgWNEAzCeZbWDsQXh9ro37T4fJLNkTV5Y=;
 b=Rc8ckWvVifEKJ9Cw+rL05oOCrMNnd0pg9/Fd0xYPKwWjc91tLutOqHGiJkfuOdzajt
 XhFktQOyyaODP3qxw9lnz48mTbkU2OgyEPyIPHO+5q/yM7EYSrAMB/uz1W7NWB3ty9n4
 IBMFemPAxSu1BGvT7TNEA3PJFhFgU94b6/91soqnavMh6gAKi8KezHK1+nzPQ88/z3QV
 MjE3jsrA1lA/PNZs6S23opmjWYdp0yqCJCSM9Ux9w7KR5wpwrRYPTvzSIv4RyOiONrZv
 9W42awqVcRqdFRj6280S+ErYwZSjR3STQ8cFaQjdxuh4n0Q9iT479t+pV4byvbZeYsFa
 fOgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766590591; x=1767195391;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xoR3JM9hywUgWNEAzCeZbWDsQXh9ro37T4fJLNkTV5Y=;
 b=UuZPkGg7McGKk7WFeac/koL/dS8MTgZ3nHgaFfDANWG5jb38RK+IqLT/IIYwUp2od2
 ELQsEEbB5dF+EBQrXqksSh+ua43wNoHJ0qQLfMe9J+q1mYm2xyCMftnKxgf2BcbnTLOr
 bhcIsSy6poZYBxGU5XFT+tzlQn/fG20P750K8ncUR5cBLoJLsjl85V05npvgIY1qmpD7
 wOM17gzjvZsFMT29kg4SXYJaGx+L4PIpJEElZpqB11GtjEofym+ZUPv7QY+q8mulH7q+
 WERXCGdR8EaKjr1GG2WW0Dh8HO8YZPWfBMTqJzcH81Ao8rik6e6/79QFJgrY15UJ02S0
 Okpw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXhSlrmTdYaBWRPme/MMRNUoKW9+BVQanuRNPE/oO78hEzwcxF4b3UwURAhxpuSPrbA2UzSAhDcmyiI@nongnu.org
X-Gm-Message-State: AOJu0YxL2LiJS3aoJ2Cj+EAhR0o1/zT0JwE63u2wBJPHqTD0uPxRzL33
 Fsrnmmfh4qh9iE1i/L/b3r4NVOxvxIlSUxU/nnILDmHovkJNFtxss4MNbGb8xO8WE7b4Kuy6EDf
 hNagUChvw0tQw4PFeXmQ0zAMOelPHTckJ4VKOh7rN/xtIf0nZ552+XdmM
X-Gm-Gg: AY/fxX57bvORjDcEjDvDH0za5YaUQfRZRazp2F1WNcybgD1q+huWpBJIiokX9ACK5b1
 Yahjx7KqYULS+sj38NjnXDeUkb38kfP2xJ5H/iDGOu0fLc7iwyct0nSo0aAd0Upnqm6yipryh35
 2foqpycs938hvZYY88RDiG0TImhMUNqA0CzMhZzE9ZOsHoTXoZXLquqhx2bTXrU00BD+PcXJ5+L
 hrzptuh4KsHspmpGf9DerivcRyVz/NzRChm2TqP+xeqXLLXh7Bhjc+sCAb0/71GkKQ6fF4i6TCF
 LSb7wHVfQqO3crJTS+7ESv4iDS+KWW1+RLLqfC+LP7b8zc7IrYKYRpLKHGMatLeDxMGEc8ZJL1I
 rzYY=
X-Received: by 2002:a05:622a:411b:b0:4f0:31bd:2aaa with SMTP id
 d75a77b69052e-4f4aac5db91mr291484041cf.4.1766590591326; 
 Wed, 24 Dec 2025 07:36:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEtHpcbE/SDDgcOrEMELG55Zz/p0ER7K6NCN9h7+miBYtWhgdNDU5P9aQDjkupQhVbIbmz6tQ==
X-Received: by 2002:a05:622a:411b:b0:4f0:31bd:2aaa with SMTP id
 d75a77b69052e-4f4aac5db91mr291483771cf.4.1766590590925; 
 Wed, 24 Dec 2025 07:36:30 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4f4d5f042a7sm54515841cf.27.2025.12.24.07.36.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Dec 2025 07:36:30 -0800 (PST)
Date: Wed, 24 Dec 2025 10:36:29 -0500
From: Peter Xu <peterx@redhat.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, philmd@linaro.org
Subject: Re: [PATCH 0/6] Implement memory_region_new_* functions
Message-ID: <aUwIfYGUXSMOeVUg@x1.local>
References: <cover.1766525089.git.balaton@eik.bme.hu>
 <3a1bf99d-e011-4589-b7e9-662107befdc1@rsg.ci.i.u-tokyo.ac.jp>
 <a9a43db6-1a1f-58f1-39c8-06213e9e610e@eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a9a43db6-1a1f-58f1-39c8-06213e9e610e@eik.bme.hu>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Wed, Dec 24, 2025 at 02:47:20PM +0100, BALATON Zoltan wrote:
> On Wed, 24 Dec 2025, Akihiko Odaki wrote:
> > On 2025/12/24 6:49, BALATON Zoltan wrote:
> > > Our documentation says that memory regions are automatically freed
> > > when the owner dies and the reference counting to do this is also
> > > implemented. However this relies on the QOM free funtion that can only
> > > be set by creating objects with object_new but memory API only
> > > provides constructors that call object_initialize which clears the
> > > free function that prevents QOM to manage the memory region lifetime.
> > > Implement corresponding memory_region_new_* functions that do the same
> > > as the memory_region_init_* functions but create the memory region
> > > with object_new so the lifetime can be automatically managed by QOM as
> > > documented.
> > 
> > The documentation explains the existing functions so the discrepancy
> > between them you see should be fixed by updating them, not adding new
> > ones.
> 
> Do you mean replacing memory_region_init_* with these memory_region_new_*
> functions? The memory_region_init_* is still useful for embedded memory
> regions that are managed by some other way which is also mentioned in the
> documentation as an alternative so I think both of them are useful for
> different cases. If you mean we need to update docs to refer to
> memory_region_new instead of memory_region_init at some places then I think
> you're right, the docs may also need to be updated or clarified.

To me, it's less convincing to add new APIs without a solid user.

IMHO we can go either (1) leave patch 6 for later, making this series a
cleanup first, or, (2) add users for every new functions introduced, so at
least we know why each of the new functions are introduced and necessary.

Thanks,

-- 
Peter Xu


