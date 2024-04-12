Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F657C04FF8
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 06:43:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvAcQ-0005a3-KF; Fri, 12 Apr 2024 02:42:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rvAcP-0005Zp-Dl
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 02:42:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rvAcN-0007NX-SR
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 02:42:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712904154;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CEiQUIx9E6nfgVzmmqkaRGVkStbKAxVFGlY8ntClksA=;
 b=OmbkI14pPp+6IFLTOrHKXPo7HUrKJnzH7u86sVHhwmY91Jlxk2BA1j5Hr9tek3xb2v9saS
 RRqZSh+8mlKMeY/o22Rwzr8RLTyuy+lEmqciIPmZ8N6CdxkEuvZhDzQQaNbQKkJpjGYuf3
 mgnJu74iZ/EiUpBhyQ5/HG9LybVSVtI=
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-226-rFMXpPiTNH6YMNQ1MhN59w-1; Fri, 12 Apr 2024 02:42:32 -0400
X-MC-Unique: rFMXpPiTNH6YMNQ1MhN59w-1
Received: by mail-vk1-f197.google.com with SMTP id
 71dfb90a1353d-4dac09fcdb8so255408e0c.1
 for <qemu-devel@nongnu.org>; Thu, 11 Apr 2024 23:42:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712904152; x=1713508952;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CEiQUIx9E6nfgVzmmqkaRGVkStbKAxVFGlY8ntClksA=;
 b=fYwSx9DNJp56egF6nefvGgG5/1WGBNxbodyUr8shVh7j5g6A4fanNrSvVyOKiIIGUi
 lK8sj2dmpxRD0lpUCnZ2jc9wRyEQ04gY9qB2ar2qBztN+tSA/lguTrjnFLBIfORkddvM
 Ez9+uOnG2qvnp68kTgX4EdgQJkGdO9H2Xad5Ahm7F1hJuTpnJO4+7Vvq9aY1nAv5tBWM
 rCqjQwYC1iFTDjMsV/xI9trOxamTGp2SZfn/WugA/ElAGYne1Nqrsgy/aTSoyKhRZyDh
 C6f+10HDL3c7GCzXly9As7kJ3L1An+cMVdU+4oY9opV+9APZG94wt0Eb4cqbBnQorEzq
 B22w==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6gRZtOfyJBZNBYQ+tcLEQ0rWSemnxWyZpdIDPYoFzS4ez3W/CbGr0SBuuICy5E/Tsp4UHVKhUWFN7ko+tsC3B8nrJ6HQ=
X-Gm-Message-State: AOJu0YxWqxxXpR1QeLRobxGFeDlsNqgwhX6TJ3odRd/Cbrb5nP2sWQgL
 Qu7wK8U5dRPNpajTTi2XFvTdfYzWam5x0V+9MJp0pRKm8XGKyCMHLkRHlcYKLbTfdON2wxDSvBt
 r8L5YZZAHLZeLIb1UxU5aYrMciRj+AYzX8btZDViNeb7CMFlARbM99n8x6czI4zq4Elil1AyXUf
 x78dfA6z6ZauzUizGO9hXQM2iNOW0=
X-Received: by 2002:a05:6102:3a06:b0:47a:47a0:3b68 with SMTP id
 b6-20020a0561023a0600b0047a47a03b68mr1051590vsu.30.1712904152109; 
 Thu, 11 Apr 2024 23:42:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGS9J1LMf963u709wpOYoG+3Ab66rdiMMrmQrjgQ0Sa+zcY19HZXg9CirlRetuC+fXlVr1+Ov7mPJPJipuS9ds=
X-Received: by 2002:a05:6102:3a06:b0:47a:47a0:3b68 with SMTP id
 b6-20020a0561023a0600b0047a47a03b68mr1051578vsu.30.1712904151870; Thu, 11 Apr
 2024 23:42:31 -0700 (PDT)
MIME-Version: 1.0
References: <20240328103903.408290-1-Jiqian.Chen@amd.com>
 <20240328103903.408290-3-Jiqian.Chen@amd.com>
 <20240328065606-mutt-send-email-mst@kernel.org>
 <BL1PR12MB5849ACCD6602EAB88BE2FED9E73B2@BL1PR12MB5849.namprd12.prod.outlook.com>
 <20240328083503-mutt-send-email-mst@kernel.org>
 <BL1PR12MB5849C37A0B0E1AF02644C203E73A2@BL1PR12MB5849.namprd12.prod.outlook.com>
 <CACGkMEt=V4V4JgT08o5_f7tj-eNZDi2GB4=H_Qp7xALrRxBWhQ@mail.gmail.com>
 <20240329064431-mutt-send-email-mst@kernel.org>
 <BL1PR12MB5849AA89DC28465714590B56E73E2@BL1PR12MB5849.namprd12.prod.outlook.com>
 <CACGkMEu6uEF+4P3_3Q5tw4TNZ9dj3GwJh+h_BtWDfq3WeUhKJQ@mail.gmail.com>
 <20240407074848-mutt-send-email-mst@kernel.org>
 <BL1PR12MB5849D4F87AEA6059CE71AE34E7042@BL1PR12MB5849.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB5849D4F87AEA6059CE71AE34E7042@BL1PR12MB5849.namprd12.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 12 Apr 2024 14:41:56 +0800
Message-ID: <CACGkMEvqZYrXiWmwOLvna_JjxqNCVzKc3tmYF6LLniQAmL0NrQ@mail.gmail.com>
Subject: Re: [RFC QEMU PATCH v8 2/2] virtio-pci: implement No_Soft_Reset bit
To: "Chen, Jiqian" <Jiqian.Chen@amd.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
 "Huang, Ray" <Ray.Huang@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.49,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Apr 12, 2024 at 2:05=E2=80=AFPM Chen, Jiqian <Jiqian.Chen@amd.com> =
wrote:
>
> On 2024/4/7 19:49, Michael S. Tsirkin wrote:
> >>> I will set the default value of No_Soft_Reset bit to true in next ver=
sion according to your opinion.
> >>> About the compatibility of old machine types, which types should I co=
nsider? Does the same as x-pcie-pm-init(hw_compat_2_8)?
> >>> Forgive me for not knowing much about compatibility.
> >>
> >> "x" means no compatibility at all, please drop the "x" prefix. And it
> >> looks more safe to start as "false" by default.
> >>
> >> Thanks
> >
> >
> > Not sure I agree. External flags are for when users want to tweak them.
> > When would users want it to be off?
> > What is done here is I feel sane, just add machine compat machinery
> > to change to off for old machine types.
> Do you know which old machines should I consider to compatible with?
> Or which guys should I add to "CC" and can get answer from them?
> I have less knowledge about compatibility.

If you make it off by default, you don't need otherwise, it's one
release before.

Thanks

>
> >
>
> --
> Best regards,
> Jiqian Chen.


