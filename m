Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 401F2D6DDF2
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2024 11:49:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBupT-0005FE-7o; Fri, 15 Nov 2024 06:49:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tBupS-0005F5-5M
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 06:49:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tBupQ-00049W-Pu
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 06:49:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731671369;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R7baADe/SUCoyjRTjAD3nC8YeSM55GDpaxcArsGEWGw=;
 b=bh4TX4MpWOk4MH6Hv7K6RMKlqxlQXJfS2CHks6zI7Bw+5K645T9L94x+zeFCATLpfObBwe
 XWHzPCGBY4cwJcRLh4uxiLmnlQNaEN9jxiN3QeCZimNj+/rdRwP9t/HF6FWj7TjCccW7PD
 a1CvELc6Q/lASX/D5hv2rjnyjFbKdnA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-UHKRBaWXMqSluowj0xxbCg-1; Fri, 15 Nov 2024 06:49:28 -0500
X-MC-Unique: UHKRBaWXMqSluowj0xxbCg-1
X-Mimecast-MFC-AGG-ID: UHKRBaWXMqSluowj0xxbCg
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43164f21063so11222935e9.2
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2024 03:49:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731671367; x=1732276167;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R7baADe/SUCoyjRTjAD3nC8YeSM55GDpaxcArsGEWGw=;
 b=ezvkCbrDlO6TsYrhixktVrg5YRYnEuDnMFdUUSDmxIac0RGGFCFn2I19td+dFe5ObV
 1arK8GAB/NlGtRxdgEumtnMU2zxHZdYhhGlnnxM5M7l40G80aBLd6LWu19gdStQ1uMHq
 +IB3HEx8+BPFNh6gr+IdYt3sEI4et6kGZzyg/Nxd+gkerhZDsEAmmIljaCL/CiuCfUsV
 rs/wGh9oME3KpcnixruCONmICwJ3FCfxe/37Jx013DzfR/lK9ayn+msfzFupjxh/00im
 xuysPJ6K+ydE0qCSaqxtoK0kUqDFwbcbLli7tSfUwRcNhaSGad0FKthCCRZrFHpcVofZ
 2RHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWsD6a2bW53muJdWAOUQPgCzl870TCT5m08daXk/J+4RNX3Jx6eJiTH15QkSQ3q/tCD3WKFTdGAvN/J@nongnu.org
X-Gm-Message-State: AOJu0Yyh5iY5U0+BpIhmmUujBvHS8dClqIuhZzcg35EFeqh16m24z3wa
 kXD7gOuKbkjJFarRl/0VMoJ0vK9kp+aln2LwoKoqm+K5Qdoyn+4wq6jMeuFaee8ZfNidolYvCun
 gqlbnUU7jxY+MMQ7Zjkc16lXk+El5Guvox44eKqscFYVs6vEzvG/j71IdfFJOrTdPD2JXDmnbyA
 ttsmOjUK5aLugzsfZ8AvEVrdyk1Lo=
X-Received: by 2002:a5d:47a6:0:b0:382:22f4:777c with SMTP id
 ffacd0b85a97d-38225a05b99mr1826102f8f.24.1731671367337; 
 Fri, 15 Nov 2024 03:49:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHkWouosBQ326L+O4x/HanFvKVV+4fCHXwxLi5Oh3vLna9k5wkcZLmtkoGYcoNj9fsMLwj4+Sz1Bbtsu4o/Yuk=
X-Received: by 2002:a5d:47a6:0:b0:382:22f4:777c with SMTP id
 ffacd0b85a97d-38225a05b99mr1826087f8f.24.1731671367021; Fri, 15 Nov 2024
 03:49:27 -0800 (PST)
MIME-Version: 1.0
References: <20241114122919.973930-1-thuth@redhat.com>
 <9e7cb217-a33e-48aa-b030-efb991ca33f3@linux.ibm.com>
 <f0315077-eb61-4134-b81a-7d33906c6d31@redhat.com>
 <31889800-47fc-4ee0-8016-58a9d82b2719@linux.ibm.com>
 <0e9b5272-2aa9-41a4-b0bb-43f0c89751e7@redhat.com>
In-Reply-To: <0e9b5272-2aa9-41a4-b0bb-43f0c89751e7@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 15 Nov 2024 12:49:13 +0100
Message-ID: <CABgObfZ5VqJUd9+HvoRkBqeg=pMo_WaZDop_jiRnrCz=gfTRfw@mail.gmail.com>
Subject: Re: [PATCH] hw: Add "loadparm" property to scsi disk devices for
 booting on s390x
To: Thomas Huth <thuth@redhat.com>
Cc: Jared Rossi <jrossi@linux.ibm.com>, qemu-devel@nongnu.org, 
 Boris Fiuczynski <fiuczy@linux.ibm.com>, qemu-s390x@nongnu.org, 
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Fam Zheng <fam@euphon.net>, Eric Farman <farman@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.122,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.69,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, Nov 15, 2024 at 7:30=E2=80=AFAM Thomas Huth <thuth@redhat.com> wrot=
e:
> Ok, great! Sounds like we have a passable solution for QEMU 9.2. We still
> can refine the loadparm handling of the scsi devices in future QEMU
> releases, but this will now at least solve the present problem that Boris
> reported from the libvirt side.

Please put in the release notes that in the future loadparm might be
limited to s390 emulators... Not sure how, but we'll come up with
something.

Paolo


