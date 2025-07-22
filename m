Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37174C83F1A
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Jul 2025 03:29:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ue3gP-0007jZ-5m; Mon, 21 Jul 2025 23:28:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1ue3gC-0007fS-FG
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 23:28:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1ue3gA-00007c-1n
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 23:28:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753154911;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kmUwcUNpKfMSj45JIYsMihvx/HG4LEaZWOzwO6m+LdU=;
 b=GsaGxWHmHSumg81rmW940i/+8PPAAcM1DNP1VCS8hoEyKs7Mt878FofWfoh/fx48sIRGUF
 SRgE0dTuHaCyBOc2hAhkaur4WAjutXpFdMCQ4vJDBH61PhPsMWm5D0/kE1Zm/ZCbu6Ufyi
 7sd6VblCAmDtQKazcGPbc/O6ZZaxceg=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-xscy3BaePOCynrQoD-jUdA-1; Mon, 21 Jul 2025 23:28:29 -0400
X-MC-Unique: xscy3BaePOCynrQoD-jUdA-1
X-Mimecast-MFC-AGG-ID: xscy3BaePOCynrQoD-jUdA_1753154908
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-235e1d70d67so46747575ad.0
 for <qemu-devel@nongnu.org>; Mon, 21 Jul 2025 20:28:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753154908; x=1753759708;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kmUwcUNpKfMSj45JIYsMihvx/HG4LEaZWOzwO6m+LdU=;
 b=FAGQxp+OoNcLZaZFgYLVvdDs5fYbQToGUmRGI9YmxEdHa7tFSy6nfMJLKGKAbFJmRp
 RFvIyqHFOqd0gPFvgKGodG4WOZwF+SAUUVvlyZh5dI8Skf6FPQJg49CZR3X4Rg0Awxw+
 uPh0Lze8FB7obSVzsmf/rEBRomV48JlTe8HfQpN4bV8g5ggjqNVd/xJEawM5Ic6QxpS/
 Ji4pnGGMqb7XLRhhQ4HrNYtp9Db4iG1ETbwxSmvqkdbxEOJHxFjrqF5JxP1EvMe2RXnI
 EiB7tf5giO+FzefukRFBN8q/kS+ox5KLxpgSybFjbShwtU49Ta2H6Kv4vXQsN2nvSiBK
 LLzA==
X-Gm-Message-State: AOJu0YxS2ZlX8rYO0Yu4auYVQ5Q7iDbteXsXdRRguaEWvOibjFOnfp2F
 Q7Vmubmz0OUXslcQWYm/40GfSDbApaRZ565X6z0F8vpFh0Hjg7F/JOj9uX2UbRdJ3q+ikA53j7/
 ur617Asol3JOLKg461k4ZMa7h4ZISRZPtsdma7Z7N/bhzMWws/y2jUMeSPcK8iM7ofAYCmBKcYp
 IpFf1c2M9Zspr5z2eg7txK63poAsFsr1A=
X-Gm-Gg: ASbGncsgVQJKPsHb5ucdc+uKRCurw8tlwtIMu6vYwq82omRKjrWTPS1QDBoSZZ9OHgA
 tYmmxjOax7ijRXNNXjoUvxwLHIEzD7c6G1tvLjfj4v/kwPpQvzX3IIZZ/lC+SBSSlWWsVUey4ag
 /mvPsDAxPxkEx1zPkMBBg2Mg==
X-Received: by 2002:a17:903:faf:b0:235:ef67:b5a0 with SMTP id
 d9443c01a7336-23e257597eemr297535825ad.36.1753154908230; 
 Mon, 21 Jul 2025 20:28:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFTY5jp4FrOFRbuRZWxun/62JPeZUop5YbLySO3NaKx50Ij6Erf/FAB5qep3kNAAkWmjZOof5GGgtmasnJtoqY=
X-Received: by 2002:a17:903:faf:b0:235:ef67:b5a0 with SMTP id
 d9443c01a7336-23e257597eemr297535505ad.36.1753154907848; Mon, 21 Jul 2025
 20:28:27 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1752828082.git.pabeni@redhat.com>
 <253cd85bc76ded8259fc9d12ed3764e2507bcb75.1752828082.git.pabeni@redhat.com>
In-Reply-To: <253cd85bc76ded8259fc9d12ed3764e2507bcb75.1752828082.git.pabeni@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 22 Jul 2025 11:28:16 +0800
X-Gm-Features: Ac12FXwWi_2dgqmgB70fJmQgTMsYeFYWVUXKjzEo0VHbJjrS8fxLPj7KuMrHIuI
Message-ID: <CACGkMEvBr0dQdNqtYNdOT+oN13aOWh1Hob7C6NLbSKCcEDPtLg@mail.gmail.com>
Subject: Re: [PATCH RFC v3 06/13] virtio-pci: implement support for extended
 features
To: Paolo Abeni <pabeni@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Luigi Rizzo <lrizzo@google.com>, 
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>,
 Vincenzo Maffione <v.maffione@gmail.com>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.926,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Fri, Jul 18, 2025 at 4:53=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> Extend the features configuration space to 128 bits, and allow the
> common read/write operation to access all of it.
>
> On migration, save the 128 bit version of the features only if the
> upper bits are non zero. Relay reset to clear all the feature
> space before load.
>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

This is a guest noticeable behaviour change. I wonder if we need a
command line option to enable and disable this feature for migration
compatibility.

Thanks


