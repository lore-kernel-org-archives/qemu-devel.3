Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DCD5C25B7E
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 15:42:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sD4OE-0002xc-Od; Fri, 31 May 2024 11:41:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sD4OD-0002xH-Lr
 for qemu-devel@nongnu.org; Fri, 31 May 2024 11:41:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sD4OC-00027w-3R
 for qemu-devel@nongnu.org; Fri, 31 May 2024 11:41:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717170114;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qC/cbC73nnhbl/cIc7rPGNWp9f24AP4IKiaTi5mFi/w=;
 b=eIwPqh6okd58mrUclZem1stBBuaKRf/W1JPTuDFLZqVk3vCpXZ8JjrIqk/7507W1mT5JTP
 xAWm58DV2CfhUfjYzVvn0oZCAMfHDNHxxBiHTXEoUq+km2OabL10jFZL3XpUB8ESP1CKaU
 3ueIveZR1+RGcpyLvGj8EHXTp+6V0yU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-302-5bz-tyLCMnGOwaIXfap5bw-1; Fri, 31 May 2024 11:41:52 -0400
X-MC-Unique: 5bz-tyLCMnGOwaIXfap5bw-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-420fe1575bbso16576975e9.2
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 08:41:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717170111; x=1717774911;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qC/cbC73nnhbl/cIc7rPGNWp9f24AP4IKiaTi5mFi/w=;
 b=ZCWv4w22lzmXvwgsdj3Z2fgW0G4eNSCKu/orRp7bMi3RzndZkwEuNwwkHZsY24oiaB
 fQu0KUlYAVmx0nXXkLLEWtcHzSeAHorafdcBaqti6vRLYQNmPnJq0I17W6/yh2Ojq0rh
 0r9rKjmCoDLS6HVxOVlZqGaFIqaD5F3CkJikTUw9XDLY1qi1slo3Y+s085drN5uOYikX
 7+DLQ8FLh4nJMLRHqQe3L0W0PTSIZIA7MYWETgCQHfjrUkXMKv++mTECCBJ15qVtl9Ix
 uYLUfUV7w+o+jnaD83TnUZN4lV1K+bNZYz3lAV8isNvd2Wh2/AqZPNnD4cukCuzfqBfC
 ww8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0PC6C+UrV0BrB189OHh1IS72Vzu+2G9wq7TaAjUNRhiyvrPRdC//B2YE76UerZfOTUyI84X/mX30dREUJOGnAp+HgNoM=
X-Gm-Message-State: AOJu0YyAthSi3FNxjhPHvOgHe/scWvbsJVVqXu50h6m51ThItdOIDnSM
 /XVhymLATgHFtmhGYRGnA5H0O1mdOQqpjH7rp2CRJBvCtsoVt3hbRbDD++FKnSfpVFBZfxf7UU7
 BxPR2ViKJ1Y2il9e5/fqbrNz7Ifa3gyHbff8COeVFH+NHnyn+Sp8PjFQ+7z9ixUpf6FdMED4p16
 74YnOjMxNzKd6tG9JQeuiLMKOneHk=
X-Received: by 2002:a5d:5612:0:b0:354:f38f:6e68 with SMTP id
 ffacd0b85a97d-35e0f25a669mr1673430f8f.13.1717170111485; 
 Fri, 31 May 2024 08:41:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHknQ24Wh1IuFhonT/McTlo0E1nMXrNxyPrEBrtjYxAoupsAnVtFwjKPxe/rVPXxm/1l8CCQGALu5V3ireduR8=
X-Received: by 2002:a5d:5612:0:b0:354:f38f:6e68 with SMTP id
 ffacd0b85a97d-35e0f25a669mr1673409f8f.13.1717170111158; Fri, 31 May 2024
 08:41:51 -0700 (PDT)
MIME-Version: 1.0
References: <20240530111643.1091816-1-pankaj.gupta@amd.com>
 <20240530111643.1091816-19-pankaj.gupta@amd.com>
 <792b99d5-9d18-42f4-a9f4-5621e2ae6a70@oracle.com>
In-Reply-To: <792b99d5-9d18-42f4-a9f4-5621e2ae6a70@oracle.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 31 May 2024 17:41:39 +0200
Message-ID: <CABgObfbHvj_GiX-+E3zhLfrrw7S02-VcE0sEmj_nfuXWnwmrhQ@mail.gmail.com>
Subject: Re: [PATCH v4 18/31] hw/i386/sev: Add function to get SEV metadata
 from OVMF header
To: Liam Merwick <liam.merwick@oracle.com>
Cc: Pankaj Gupta <pankaj.gupta@amd.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
 "brijesh.singh@amd.com" <brijesh.singh@amd.com>,
 "dovmurik@linux.ibm.com" <dovmurik@linux.ibm.com>, 
 "armbru@redhat.com" <armbru@redhat.com>,
 "michael.roth@amd.com" <michael.roth@amd.com>, 
 "xiaoyao.li@intel.com" <xiaoyao.li@intel.com>,
 "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>, 
 "isaku.yamahata@intel.com" <isaku.yamahata@intel.com>,
 "berrange@redhat.com" <berrange@redhat.com>, 
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "anisinha@redhat.com" <anisinha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.085,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, May 31, 2024 at 5:20=E2=80=AFPM Liam Merwick <liam.merwick@oracle.c=
om> wrote:
> > +    metadata =3D (OvmfSevMetadata *)(flash_ptr + flash_size - data->of=
fset);
> > +    if (memcmp(metadata->signature, "ASEV", 4) !=3D 0) {
> > +        return;
> > +    }
> > +
> > +    ovmf_sev_metadata_table =3D g_malloc(metadata->len);
>
> There should be a bounds check on metadata->len before using it.

You mean like:

    if (metadata->len <=3D flash_size - data->offset) {
        ovmf_sev_metadata_table =3D g_memdup2(metadata, metadata->len);
    }

?

Paolo


