Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D00FC3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 10:44:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTfek-0005df-BD; Tue, 16 Jul 2024 06:43:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sTfeh-0005Tk-Ok
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 06:43:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sTfeg-0002fg-71
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 06:43:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721126613;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y7T37hxSKB6t67sQbFNhYZWsWeqk5u1KrPjLA32hH84=;
 b=D/YjpmluuO/ms/5x8ol0PZlHHXfH4+Wqv6bfaLBZfQdq/7GNvW7uVFxM8BcHQW+2KytDt0
 jVGETxXgO6VNa1PGCcZqxZaqZKWBY4d/HopqxMRLAuTA0X2UwTo/m/03+mKJNPCZY7iV7Q
 6Dx7H3bxyBIeS1HRrcsJDqbZxn5JAD8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-8_ibMnIgNiiTfyvpUH-V4g-1; Tue, 16 Jul 2024 06:43:30 -0400
X-MC-Unique: 8_ibMnIgNiiTfyvpUH-V4g-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-368255d4bd8so412859f8f.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 03:43:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721126610; x=1721731410;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y7T37hxSKB6t67sQbFNhYZWsWeqk5u1KrPjLA32hH84=;
 b=eTPAK1INIubQQltrLsEwhgF3P6O5EE71KMmqEUkVOWd8NydZ4ChXuFzQlVqXWr3WlC
 cZHxDM7UJPB9+TEQnE3WOftvEGFsZw1Dhu1iob6YGzpvz2BEeeaZ8IdCFuGZ0iNlTrxx
 BIWwyjMQZprNSjjxjMia7WciIN08ElOjF+onn615DV9o4Wy0aMdGhvmlFJxohiazlrje
 PvesZyIeVWe5VZvf940T0CGfbaFyezqWSrz7XYtDU2YBeipwZSdAj7r41gREugp3Ly16
 LG55Y8ZTidCZ3vX0S+4ld7cxNLyyzY34o9oB7AwWaUSyhpTl84mpwvx+CS/JpmAGkghL
 /ghQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXcB4rBOgsVun15j+tLzWpbO8sqGjfHtCJ2qeMxSBctQsGlBwzUc2GWlAC+bxLPFdTiGPcWnMncPToujDRIxqGZN6Xy+XA=
X-Gm-Message-State: AOJu0YzJINLJzzdtEITz7rx3PKglEVMhpezY4OYBvGBfbdSlJ67hWt2Q
 Wr/hg0Qb/5pZ9bG/VedgI/n99quBPXq3BX3xK7dN6G4l/6kbqOjFW7Vmh3cjN7bJp9Oa+Le1I0F
 UmWdvHEN7Ke+uAZFZdMqXoWoA0XTkHgkP3LZI/+NB/zjvDuAOt4Vs57Y9wD89vxjw5ez0jiTARp
 xwe/hlPUQULdzasoEwJiGSzzjsv8o=
X-Received: by 2002:adf:f6c1:0:b0:35f:2366:12c5 with SMTP id
 ffacd0b85a97d-36826100106mr1142838f8f.23.1721126609831; 
 Tue, 16 Jul 2024 03:43:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGErQa8NEGyAvr/KHbghEFeTtgdBjLn9YcoEkl37nYGTfdT8oR9jzST5A0sLiYcrF2K0PLCAm0awGLpd9B7NCM=
X-Received: by 2002:adf:f6c1:0:b0:35f:2366:12c5 with SMTP id
 ffacd0b85a97d-36826100106mr1142825f8f.23.1721126609478; Tue, 16 Jul 2024
 03:43:29 -0700 (PDT)
MIME-Version: 1.0
References: <20240716-run-v4-0-5f7a29631168@daynix.com>
 <bca5bd94-d6af-450b-a023-0bbe57fdba3f@tls.msk.ru>
 <ZpZDseDnUD39cBzE@redhat.com>
In-Reply-To: <ZpZDseDnUD39cBzE@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 16 Jul 2024 12:43:17 +0200
Message-ID: <CABgObfasdAS443K6+2hHE1chWXei_1ytyRTOi7tX+ma8hZEC6A@mail.gmail.com>
Subject: Re: [PATCH v4 0/7] util: Introduce qemu_get_runtime_dir()
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Michael Tokarev <mjt@tls.msk.ru>, Akihiko Odaki <akihiko.odaki@daynix.com>,
 qemu-devel@nongnu.org, 
 qemu-block@nongnu.org, Yuval Shaia <yuval.shaia.ml@gmail.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, Fam Zheng <fam@euphon.net>, 
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, 
 Gerd Hoffmann <kraxel@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Yan Vugenfirer <yan@daynix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Jul 16, 2024 at 11:56=E2=80=AFAM Daniel P. Berrang=C3=A9 <berrange@=
redhat.com> wrote:
>
> On Tue, Jul 16, 2024 at 11:06:57AM +0300, Michael Tokarev wrote:
> > 16.07.2024 10:27, Akihiko Odaki wrote:
> > > qemu_get_runtime_dir() returns a dynamically allocated directory path
> > > that is appropriate for storing runtime files. It corresponds to "run=
"
> > > directory in Unix.
> >
> > Since runtime dir is always used with a filename within, how about
> >
> >   char *qemu_get_runtime_path(const char *filename)
> >
> > which return RUNTIME_DIR/filename instead of just RUNTIME_DIR ?
>
> Yeah, I agree, every single caller of the function goes on to call
> g_build_filename with the result. The helper should just be building
> the filename itself.

That would mean using variable arguments and g_build_filename_valist().

Paolo


