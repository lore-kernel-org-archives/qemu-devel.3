Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6284C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 13:12:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwias-0003SE-7A; Tue, 16 Apr 2024 09:11:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rwiao-0003Rm-3b
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 09:11:23 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rwial-0001ue-PX
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 09:11:21 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-516d3a470d5so5023650e87.3
 for <qemu-devel@nongnu.org>; Tue, 16 Apr 2024 06:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713273074; x=1713877874; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ro2fMHnjeUthqpsIxFUUg3EH8LaFn/o6R+MVUCk18Pk=;
 b=zDFhOvOV4Y0o2cmw1cJ5UaIFEqcS7jLJHrK1HyhRWqH9L6VcqWSEZHs2A2IqpAMYxG
 O7EnMHspYgpDs74O9PewX/M4cW4ZoHfey3t5fJe4/I+1acLH7Kotfysse8FoQfLWCGDC
 F6YBaSjLtsTQIyOstVeaGb7TRH0zhA68SthhlnFX7SE8rOdGVn9+7w5swBvfWvAMaIQ1
 EHfyYGpzzM6wI8V5qcd3wGmsr3p4t4mvIgCyrdN+cs+9uuiOG87drIMqXHNL3auIirdA
 mOjPMOVQhNhghLKLfZpRY5OppFyF9GfU+umfYHZu6YcuTetTuhmdMhgNgU1Dneldkco/
 bqCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713273074; x=1713877874;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ro2fMHnjeUthqpsIxFUUg3EH8LaFn/o6R+MVUCk18Pk=;
 b=uumdCy0uA+ml/g8HiaPAmas8I+1QjNBoV27IgXhZ7R0TbjTSsdLzjnSosGb0bl6w71
 bPjwoxeGRo5+0MP97AqprJ7XLu2K2aqvBUVhTbDRpghyc80ycMGY5b31cdwpXLziJi0i
 dGECx1gjqj742OucCJiZJiUtnabFG4bMGMJw6aHGTckvZk2L2/pyUspvVH1adpiDZDGg
 l5yQcYigZeUZRwdmLSfIAhsvaYVASJW7Y140KttblDJcGkXFsGqK+lMyuh0kBzWxYRku
 ySxKBlexEJX5MlnwQmWguyUCaZfh/WwSaOq4bI1Xs5dgeDz6WVQXlyqvSP/Kl3JvP7Ix
 TuZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWlGVrf14KRPGP3TrJUnNZYuNTa4GNZpJ2cNS3nDJI0x7LvWlZEXdlAovAdpQ+Jx421clB8lyvMSShwhuV3JmaCau50MeU=
X-Gm-Message-State: AOJu0YwsFVbzDFWSibnYGUBi0+iFCWlRFgD/4b/wbz79a4fA8pg/iUjg
 YZyAnIM5ioE0IS+sADfwCa79m2TDuGFjJmgaHQvk0MQyDE/mkmdJ0vGHtgct0tvMjh55D5H8sJf
 MM1nGMz5oA229gFJhUUeMdbN4yopg7luxbQH6Dg==
X-Google-Smtp-Source: AGHT+IEATC39Bld0haR37qPYF2C5uMd4/GAeVkHG5t9Uho3G7q7GxiVfxE148Horuectu7Yw3h0iUx9WsGKxaFGATWE=
X-Received: by 2002:ac2:5931:0:b0:515:99f6:2ca4 with SMTP id
 v17-20020ac25931000000b0051599f62ca4mr8513146lfi.36.1713273074529; Tue, 16
 Apr 2024 06:11:14 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1713178348.git.mst@redhat.com>
 <2ce6cff94df2650c460f809e5ad263f1d22507c0.1713178348.git.mst@redhat.com>
 <CAFEAcA9Hs+05ux3SkJqZQ5RyAkwbgmDGMm5gn+GYZL76CJCYkQ@mail.gmail.com>
 <CACLfguX73rN77rK92xboF6hxERoO2F7kdqUgBohrURt7-38C2A@mail.gmail.com>
 <CAFEAcA_WxhOpjtZ5r-CfoOaf1aiKeaEV9eX=drb1JaBCiBoDKA@mail.gmail.com>
 <CAFEAcA_AcKdOXO3+ez6J+hQ4NmGoUa+fBUNK3XL_YSvRk09Gcg@mail.gmail.com>
 <CACLfguWfxarkB2qtn4Dt5JS01t-tFUsOfbX486exvNo8vOM1AA@mail.gmail.com>
In-Reply-To: <CACLfguWfxarkB2qtn4Dt5JS01t-tFUsOfbX486exvNo8vOM1AA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Apr 2024 14:11:03 +0100
Message-ID: <CAFEAcA_B=Nauddj6_chxQQugDtsF1oRcjt1kE38ZY3y1TYh77g@mail.gmail.com>
Subject: Re: [PULL 1/1] virtio-pci: fix use of a released vector
To: Cindy Lu <lulu@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org, 
 Lei Yang <leiyang@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x129.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Tue, 16 Apr 2024 at 14:06, Cindy Lu <lulu@redhat.com> wrote:
>
> On Tue, Apr 16, 2024 at 8:22=E2=80=AFPM Peter Maydell <peter.maydell@lina=
ro.org> wrote:
> > Paolo's comment on CID 1468940 was to suggest "virtio_queue_vector
> > should check VIRTIO_CONFIG_IRQ_IDX just like virtio_pci_get_notifier",
> > incidentally.
> >
> Hi peter=EF=BC=8C
> Really sorry all these mess, but I still have a stuipid question,
> where can I get
> this CID result ?maybe there are a mailing list=EF=BC=9FI just wonder may=
be I can fix
> these code earlier next time, Really thanks for your help

These CID numbers are the identifiers of the issues in the
Coverity Scan online UI: https://scan.coverity.com/projects/qemu
You need to apply for access but we give that to anybody who's
a QEMU developer.

Unfortunately we can only do a very limited amount of Coverity
Scan runs (about one a day), so we run them only on code that
has been committed to QEMU already, and we aren't able to use
it to find problems in patches before we apply them.

thanks
-- PMM

