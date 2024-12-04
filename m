Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6F59E7716B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 03:28:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIg3b-0001OQ-KW; Tue, 03 Dec 2024 22:28:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1tIg3X-0001O5-7b
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 22:28:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1tIg3V-0005XR-4A
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 22:28:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733282878;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TjQ8zFsYJSl8Um0gvyPB4v9WvdgdLLOsNRM/YUSjH+Q=;
 b=NNNl64KNl+TCEijvHAOwJIk8LIzPrZpAoamxwUKOLprFkuRV/dwt7RCRLQB8JquWklRO2L
 JitGXymuNMypl9AsIMoOkzBLG9AE/G0QQX3B8ACrOuHamSo2FFFJ92bf8yV4LCIlv4eiEx
 3ktpkDvFtsrwe9Ak3pyOi3MOjTaA3FI=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-202-cIAudSYgP12ixjoUQnynqg-1; Tue, 03 Dec 2024 22:27:57 -0500
X-MC-Unique: cIAudSYgP12ixjoUQnynqg-1
X-Mimecast-MFC-AGG-ID: cIAudSYgP12ixjoUQnynqg
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2ee76edbb51so4517936a91.2
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 19:27:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733282876; x=1733887676;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TjQ8zFsYJSl8Um0gvyPB4v9WvdgdLLOsNRM/YUSjH+Q=;
 b=Q/DEGHPT9OQSqg6eH0KtZt35PozIr+FGgqHK6Xapl5mzNbWNUEhhhqVITwdws7rT2f
 phBq5xGvhzcWw9C+evl2vpbsxiPnGsPgMoiqwwo4fqkSAklNrbv2lwZP+ChfJcCxDFUf
 I9yQOVRY7W6qY/qfbyV2HngDKikKspxsq+nTJgpEuCXLAI4Ls7EoW9kRHZWWlL5GbMBk
 okQpUcXdzgmCnCJJc+XULpVAXHKgrwQKxq8CkgTDUFBLz5aEGkZzB7ElnRcPi25nX4zq
 ZqwxqG0VRijHXKHjFJjdOTIbCroKDSKevlLdmKQ4Ok4V+E1IYUd+Ph802EyRcG0XIA15
 9dYw==
X-Gm-Message-State: AOJu0YzJSg2hONNdaYAE5dQeP4G2UDQj2ajnCEGbRRRPV+fKekqnyssl
 qdYWtpSJVs2vWyFSI+qq/zCD/9D13KnU3Tzd/Ab8zXzcqkdO8K70+fRZC9ShCGPjy8yWYoVLExm
 MnC7t4IKbIvAYMuxrnQCaEG8bcS45k/27bfQ1DXMdKD+qi4iTCzQ5fLfR3DeAs1EFdrdT5pXUZK
 ZfvOldOT+VRnsHUKF1OFOeFSYPMrKk/jddD5Y=
X-Gm-Gg: ASbGncuUAZlYPPyzrJSvIQgTBiiAKdLTeVvPhkeMJc2k7ys8lwFOoCkfnjoxj0rdmP3
 HhxtdpGyr8Tx5yoDzeBPXio/xv/XoIB2B
X-Received: by 2002:a17:90b:384c:b0:2ee:9b09:7d3d with SMTP id
 98e67ed59e1d1-2ef01215443mr6683991a91.19.1733282876274; 
 Tue, 03 Dec 2024 19:27:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF5IiDIek81ZoOZUJJjfhv+tmhfWo9nJ5qjcZxTOww+OUqb3BemHVpdlQKhwbCxgpTBferXwsA8mLa+UtfLVls=
X-Received: by 2002:a17:90b:384c:b0:2ee:9b09:7d3d with SMTP id
 98e67ed59e1d1-2ef01215443mr6683950a91.19.1733282875886; Tue, 03 Dec 2024
 19:27:55 -0800 (PST)
MIME-Version: 1.0
References: <20241111083457.2090664-1-zhenzhong.duan@intel.com>
 <20241111083457.2090664-16-zhenzhong.duan@intel.com>
In-Reply-To: <20241111083457.2090664-16-zhenzhong.duan@intel.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 4 Dec 2024 11:27:44 +0800
Message-ID: <CACGkMEsWZbA_PeRJLSLtSFgKtFPXymP28XZoTUtK=WWA95mykg@mail.gmail.com>
Subject: Re: [PATCH v5 15/20] tests/acpi: q35: allow DMAR acpi table changes
To: Zhenzhong Duan <zhenzhong.duan@intel.com>
Cc: qemu-devel@nongnu.org, alex.williamson@redhat.com, clg@redhat.com, 
 eric.auger@redhat.com, mst@redhat.com, peterx@redhat.com, jgg@nvidia.com, 
 nicolinc@nvidia.com, joao.m.martins@oracle.com, 
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com, 
 chao.p.peng@intel.com, Igor Mammedov <imammedo@redhat.com>, 
 Ani Sinha <anisinha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
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

On Mon, Nov 11, 2024 at 4:39=E2=80=AFPM Zhenzhong Duan <zhenzhong.duan@inte=
l.com> wrote:
>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>  tests/qtest/bios-tables-test-allowed-diff.h | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


