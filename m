Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19509C54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 06:39:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rp0Sv-0002xg-Gc; Tue, 26 Mar 2024 02:39:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rp0St-0002xP-Ch
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 02:39:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rp0Ss-0003h3-02
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 02:39:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711435157;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=du6tmNgdzFjH7qRLTqw/IKs0rnNXss0jLa/qSxlnOyw=;
 b=TmAoys8bIghl4aAjgqKEw5IVw43EUJEqrJM8f+6kv9KxHuNJiaoisjEdpy7LVlgQzo8HgN
 AYo+poXSNwfisaMtBYey+/bgMITjneLx1DRt8xw91kvwd79nbFhjE26shLeEobnqHYx8Tq
 YHEIxxf5MVfq6fShPBU7rjJVSPUIJZM=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-456-1lEfVHtHNI6ZHv92RvednA-1; Tue, 26 Mar 2024 02:39:14 -0400
X-MC-Unique: 1lEfVHtHNI6ZHv92RvednA-1
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-5f034b4db5bso1816201a12.0
 for <qemu-devel@nongnu.org>; Mon, 25 Mar 2024 23:39:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711435153; x=1712039953;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=du6tmNgdzFjH7qRLTqw/IKs0rnNXss0jLa/qSxlnOyw=;
 b=XK/FP8rnu/AoQnghV2A6J2kaQPvonckSo55hRxiCBxcxWkB0ehNRpxSGwLyJFP3c/r
 RXm70DIo5C4W/MiAZsCH2MOaL72xFZaVO5vSJ69VT19gmwumGU2vu37o/GlvsA4btuAn
 qcjFcirGAnyPBqC0NEXih0y4HaAE9OOqbEjiFBTqVaRiUdT/FgcjKX1olX1Z03qofXC2
 OCJ9DF08nDIsVBf6sqqrELZA7HRnIL+nxqMweOkhsmEvJosDAxbWIY7JhCzMNgKRwzur
 A4ZrSwsxDBqmmq/t6SmNk4gyHFd4C29oIk6UjI9/osjhL4EPBwWGUb6ULws303l4K0Gw
 HwJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWV9PUH3qjpGAkRrg2iDAPTMyjaQmiCHWb4uiZXnJcyUsitaJJFPuY6gn3oQFJOX9NT5pCjjTPxjADkNdD1GzhSHULgHfI=
X-Gm-Message-State: AOJu0YwEjzGVjGlPQp1KJwYmRc0zv1Kb6Fp2xZF8UueGuaM8OCvVKrN8
 S009zZJNFcVXh9T5uAQaihkRdRlWXn/Bhti8/ppUep/s5E5fgQKFuZ0VcNneXkPvEqh0hS4+zzZ
 AGnySnL4eLaCyVare15o9L4Dd4Y0u33sHTN7YVzv+bK+SiVV+ZybKsZUUv9RE73pgUEqYgwi59Y
 GILYOEbGDzGzj9p7hteiRqMAutUE11Vw5O8b4=
X-Received: by 2002:a05:6a20:da82:b0:1a3:a775:25b0 with SMTP id
 iy2-20020a056a20da8200b001a3a77525b0mr9929401pzb.4.1711435153353; 
 Mon, 25 Mar 2024 23:39:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPf3V0NKOksuKhkPEtQkU9D5qsusohsD4RBs59gxKfHTHJFKwfjULFwr/cXTgIzgUfrL1WrW1NLeWVc4u6xGU=
X-Received: by 2002:a05:6a20:da82:b0:1a3:a775:25b0 with SMTP id
 iy2-20020a056a20da8200b001a3a77525b0mr9929393pzb.4.1711435153038; Mon, 25 Mar
 2024 23:39:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230921094851.36295-1-akihiko.odaki@daynix.com>
In-Reply-To: <20230921094851.36295-1-akihiko.odaki@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 26 Mar 2024 14:39:02 +0800
Message-ID: <CACGkMEsL7jWRJM-vqBtQq2q9-qbfYmvdR9BqL6tPbCgnPZnyVg@mail.gmail.com>
Subject: Re: [PATCH v2] Revert "tap: setting error appropriately when calling
 net_init_tap_one()"
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Konstantin Kostiuk <konstantin@daynix.com>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.065,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Thu, Sep 21, 2023 at 5:48=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix=
.com> wrote:
>
> This reverts commit 46d4d36d0bf2b24b205f2f604f0905db80264eef.
>
> The reverted commit changed to emit warnings instead of errors when
> vhost is requested but vhost initialization fails if vhostforce option
> is not set.
>
> However, vhostforce is not meant to change the error handling. It was
> once introduced as an option to commit 5430a28fe4 ("vhost: force vhost
> off for non-MSI guests") to force enabling vhost for non-MSI guests,
> which will have worse performance with vhost. It was deprecated with
> commit 1e7398a140 ("vhost: enable vhost without without MSI-X") and
> changed to behave identical with the vhost option for compatibility.
>
> Worse, commit bf769f742c ("virtio: del net client if net_init_tap_one
> failed") changed to delete the client when vhost fails even when the
> failure only results in a warning. The leads to an assertion failure
> for the -netdev command line option.
>
> The reverted commit was intended to ensure that the vhost initialization
> failure won't result in a corrupted netdev. This problem should have
> been fixed by deleting netdev when the initialization fails instead of
> ignoring the failure by converting it into a warning. Fortunately,
> commit bf769f742c ("virtio: del net client if net_init_tap_one failed"),
> mentioned earlier, implements this behavior.
>
> Restore the correct semantics and fix the assertion failure for the
> -netdev command line option by reverting the problematic commit.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
> V1 -> V2: Corrected the message.
>

Queued.

Thanks


