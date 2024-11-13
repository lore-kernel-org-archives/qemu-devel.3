Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7C9FD637A4
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2024 18:40:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBIHM-0003RF-OC; Wed, 13 Nov 2024 13:39:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tBIHF-0003Py-Vf
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 13:39:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tBIHE-0004C0-Ka
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 13:39:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731523179;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9NGGxQ16BK45p9VSBjrrYc8rcurik7f9vC7s3z+C5ZM=;
 b=MLyQZjpHC650//Rx/kPEd0/5aqiimJR8NZrctz4L0VJkZcJmV9uwpRyXgC/kkrD6T2RvUu
 pxT4ZzosTHNfN3Ly6yN9IDwnvitcQgb1SoXTd6QpL300QC0GNtx0aHrabQzH6MNHzqtvC6
 E3coEy7QL8Cmed7tMNFxh/hy6eaeMqk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-137-EZU_e7IDNdKEttx9jq20ag-1; Wed, 13 Nov 2024 13:39:38 -0500
X-MC-Unique: EZU_e7IDNdKEttx9jq20ag-1
X-Mimecast-MFC-AGG-ID: EZU_e7IDNdKEttx9jq20ag
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4316e2dde9eso66366265e9.2
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2024 10:39:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731523177; x=1732127977;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9NGGxQ16BK45p9VSBjrrYc8rcurik7f9vC7s3z+C5ZM=;
 b=JMw3VDkYa2cS12rHr1ycUOcewrUvzy5sSbtvlHbvbQHsi6j76Tp3Pp4HrnvXBjWR2B
 zXUDmZXR+oKBiaMsY69e6GNQ5j51Nqsyy4iewucH+Hd2HrwPo4aXwgUfe9XTp2HQXeZo
 rM9VFHjV1HELgyQc1ZNSFpp8WGfR9TV5McNxQ8k6uLDtJq5gnZyQv0LnEenPuiM834ik
 VZA8DiFNzG0s2PebzSdUsa72xEa/YV+WU3oUj1DJs9xKTTuLsZomd+mEP/YoU49jnBMt
 SrxkFBAMTW0WfF4uwWKZSLdzy6rQogog0Ft27AFz3CfcNzQEGqOkGdjkifYdqWclUsxQ
 ocQQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWyAoXU64svLCs1K83ODlde7Vu90dawR1U9q9XVuxd5TkkhNgj6tuib4JpNx5sNfWHviPiEUx129Yjg@nongnu.org
X-Gm-Message-State: AOJu0YyfB48+RJNC4MaMz5EMlgkubcxGjsGoMLDecWWi/Ea6QM+EJioK
 7WRZoxfUNrppmw/Jvi7x1MHyWOq+mmB/Bg+MlNhZOeMYyzLdcIfjyuNTxZ1bg3WFnQmsHZ0vuRT
 H/dFN/9HELXNhALKk3VIpqFVz4FAvxU3E2CAuZ25j68cyDKhcJunN0/EizBgbjCFkRkIBKKRiM7
 s+JPd7Zf3SLzfYGYteIBt8pZt7a4g=
X-Received: by 2002:a05:600c:34c8:b0:431:604d:b22 with SMTP id
 5b1f17b1804b1-432b750acc4mr241633765e9.16.1731523177448; 
 Wed, 13 Nov 2024 10:39:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHQkTjNqFFxBwbztI3KElEWR8DIfZgx/lOwPE5mFGWXrnd/2X+JY85/TL2D9FlEeRFluu1DheNxmNl2Ho6uwNY=
X-Received: by 2002:a05:600c:34c8:b0:431:604d:b22 with SMTP id
 5b1f17b1804b1-432b750acc4mr241633555e9.16.1731523177089; Wed, 13 Nov 2024
 10:39:37 -0800 (PST)
MIME-Version: 1.0
References: <20241113144923.41225-1-phil@philjordan.eu>
 <b772f6e7-e506-4f87-98d1-5cbe59402b2b@redhat.com>
 <ed2246ca-3ede-918c-d18d-f47cf8758d8c@amd.com>
In-Reply-To: <ed2246ca-3ede-918c-d18d-f47cf8758d8c@amd.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 13 Nov 2024 19:39:25 +0100
Message-ID: <CABgObfYhQDmjh4MJOaqeAv0=cFUR=iaoLeSoGYh9iMnjDKM2aA@mail.gmail.com>
Subject: Re: [PATCH] i386/kvm: Fix kvm_enable_x2apic link error in non-KVM
 builds
To: "Shukla, Santosh" <santosh.shukla@amd.com>
Cc: Phil Dennis-Jordan <phil@philjordan.eu>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, mtosatti@redhat.com, suravee.suthikulpanit@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.119,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.738,
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

On Wed, Nov 13, 2024 at 7:25=E2=80=AFPM Shukla, Santosh <santosh.shukla@amd=
.com> wrote:
> Same proposed at https://lore.kernel.org/qemu-devel/cebca38a-5896-e2a5-8a=
68-5edad5dc9d8c@amd.com/
> and I think Phil confirmed that it works.

Thanks Santosh, can you post it with commit message and everything?

Paolo


