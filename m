Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61085CCF9E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 12:23:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDiix-0004SG-Kt; Tue, 28 Oct 2025 08:22:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vDiip-0004Rl-6M
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 08:22:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vDiij-00035f-Rp
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 08:22:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761654153;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rQxrJjaHdmIGxVZ+mnSLk1J/7v+mV75WnBz1eoEkNS4=;
 b=Eu+lA/E4GNBNgZazPCfGVr3M/AtEWoGt7cFeo0dFxWBhT1d33O7td4BIsy0XMvSRaJP42O
 bs61+B5/1yHbXXmqAe0vofb9bN/XOCNObsnsXztYGDEmpko1TTOk/r2LZ3HoU8URYc4fZR
 L7rWfog9RGozKJOO7oxsvlXR5uGV+b8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-380-63V35y9TMtyLMWrbQrf9zg-1; Tue, 28 Oct 2025 08:22:32 -0400
X-MC-Unique: 63V35y9TMtyLMWrbQrf9zg-1
X-Mimecast-MFC-AGG-ID: 63V35y9TMtyLMWrbQrf9zg_1761654151
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-429a7f1ed1bso559299f8f.1
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 05:22:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761654151; x=1762258951;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rQxrJjaHdmIGxVZ+mnSLk1J/7v+mV75WnBz1eoEkNS4=;
 b=snXzlpBP/ZztK8DdP9HHL1RZTxHlQyxTPeZFlK32uMjSFq7kqQc1c4bMynxNlmdjmQ
 aULO0LzZeNzkpmzIr1Q3R0srh5/Y6FZPmFQljpqNMqGDyJ88EbjdALz/5IozMuar74Om
 dpyZSGupxSnLlpI2yPnMA6nveKYu/iHyaf14c+fiGcJmftnh24nHc4pTVaxdm45lcy0o
 pDjF9dk3U5il29bevQzG671l7ljTQhB0pjw0OrhcYNUb7Z7hJrYymUIow4b7Mp7rBL2q
 Jts3dzlVT1fsMrUIDlok/rNYgAfLb753UDLUfI9KCIrOVVgjcRdrwPi0/1erE8XbGtvp
 C0zw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWXmHYgqml2Cb2/YShyiVDdnBw90+LeAgOBQYgU7qJboBcTkDYec7maaDNNd6QWcqBMJUPE6VkrzNQ0@nongnu.org
X-Gm-Message-State: AOJu0YwekdHEsK42IWa/bZFfcZTmR/9MvIO2hdpmMnRg9xBm6Q1+nt+e
 toGnP4oj2h+Qt/D8kXAYvFveaGhIgqk/L6bNQ9LEtpn1b2cf+8syosVyfktjlmVX3fbGNnsbNsT
 QUSQOhzAB6jrImLnyYdlcTWDGerUNea5zoEXPbNJuqQ3UKND+gqWpX3KFua+hihpXs1uwcia94g
 wqmy4Y9NKRrHicMQhmZzft9uShxzE/A8s=
X-Gm-Gg: ASbGncs28vEqUcYsG6qJ1t6hGd/tgSlrKaexmrYCHEGykKzZIN7jPOHaBBEixM/nzxZ
 pGi7AWdoSq02LvNC4LbK/dPRgXEcUSgtH0bieZv7xc54YtuDelSFi6h2zizymAQ8RobWbVhd4mT
 C7lDhb2ENJSKC5dMArEmQcpaUeGgHbfMFlM0lkyx/6YI7+mDVu1R+mR9hBP/aUYQZs/OBXXgwf7
 KYiSz4BVkXr+JR2Ta6scvPpvlC9xvJm1VsXPWmL/yHAGwKxFPev0MgA2luD
X-Received: by 2002:a5d:5f51:0:b0:429:8bd9:571f with SMTP id
 ffacd0b85a97d-429a7e52b12mr2368713f8f.23.1761654151015; 
 Tue, 28 Oct 2025 05:22:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYzSJCo8HU8c/HjVqDhOwZezdkZQGyl7gHbiinR/87QAgWCA93Rg3NOk5kzOjx/z8Jre7QkhRw6bzGS637JCk=
X-Received: by 2002:a5d:5f51:0:b0:429:8bd9:571f with SMTP id
 ffacd0b85a97d-429a7e52b12mr2368691f8f.23.1761654150630; Tue, 28 Oct 2025
 05:22:30 -0700 (PDT)
MIME-Version: 1.0
References: <ec836b4e6e7521806eba90c4218593c144b103a7.1761644606.git.chenmiao@openatom.club>
 <CABgObfYiUkoS=0f603T-Aqs732j+2_VqopvgRFe-4Q6DJbrK-g@mail.gmail.com>
 <CABgObfZLCMEqvFyT+SL=_8tJRvcj6+XX8Yd4ZgLuToO45Siv0g@mail.gmail.com>
 <b4da05f2-b9eb-46f2-9117-9b3989083a9f@openatom.club>
In-Reply-To: <b4da05f2-b9eb-46f2-9117-9b3989083a9f@openatom.club>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 28 Oct 2025 13:22:18 +0100
X-Gm-Features: AWmQ_bl8B8AiH-UHcoylqEquLVAVQkSYu0u1rPQnIVp5Dquptmlr0-_WpTCRCSU
Message-ID: <CABgObfbXGC8gnp6EJC5f1wC22n6FXds5t6E-M306jjBnBz5+5g@mail.gmail.com>
Subject: Re: [RFC PATCH v2 5/5] rust/hw/gpio: Add the the first gpio device
 pcf8574
To: Chen Miao <chenmiao@openatom.club>
Cc: zhao1.liu@intel.com, manos.pitsidianakis@linaro.org, 
 richard.henderson@linaro.org, philmd@linaro.org, chao.liu@openatom.club, 
 qemu-rust@nongnu.org, qemu-devel@nongnu.org, 
 hust-os-kernel-patches@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Oct 28, 2025 at 1:19=E2=80=AFPM Chen Miao <chenmiao@openatom.club> =
wrote:
>
> On 10/28/2025 8:14 PM, Paolo Bonzini wrote:
> > On Tue, Oct 28, 2025 at 12:26=E2=80=AFPM Paolo Bonzini <pbonzini@redhat=
.com> wrote:
> >> If you were implementing a new serial device, for example, you would
> >> just write a new directory in rust/hw/char.
> >>
> >> Even in that case, creating the meson.build file is more complex than
> >> in C; I'm working on simplifying that by adding new features to Meson.
> >>
> >> In other words, you're not wrong at all but note that you are not
> > Very important typo: you are *now* seeing the code from the point of
> > view of someone implementing the Rust-to-C bridges.
> >
> > Paolo
>
> Yes, I' ve come to realize this very clearly; I' ve found that many of th=
e
> suggestions you gave actually stem from my failure to fully grasp the
> underlying design principles!

Even more than that, you thought that the work would be easy. :)  The
good news is that you were still able to do it.

Paolo


