Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EA9FC5B555
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 13:31:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNX9r-0008Sm-Ov; Fri, 06 Jun 2025 09:30:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uNX9W-0008Kd-MW
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 09:30:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uNX9T-0003qz-V9
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 09:30:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749216629;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h3xXtWezYMRvyAsLjww8YoI9t3KLwtLkkknvQVmHYqI=;
 b=IbkF7/BF3cNpHq1NpwhoKFv0bStiB8GJDgpMQ4NG8DV3Pg6QuxtErxCIHfOvbFHYbJ9vik
 xrps34hLFtraXPeFAEeB80eVffXO0/3Msa268J+u5+GttlWNLiJiSW+LF3l9SSbOfOkTUF
 SFrBGxLwL8m3S9gD+0MUv5BX04Gnibg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-311-5TRzIIyGNbib8eCcR6JGOg-1; Fri, 06 Jun 2025 09:30:11 -0400
X-MC-Unique: 5TRzIIyGNbib8eCcR6JGOg-1
X-Mimecast-MFC-AGG-ID: 5TRzIIyGNbib8eCcR6JGOg_1749216610
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-39ee4b91d1cso1608503f8f.0
 for <qemu-devel@nongnu.org>; Fri, 06 Jun 2025 06:30:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749216610; x=1749821410;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h3xXtWezYMRvyAsLjww8YoI9t3KLwtLkkknvQVmHYqI=;
 b=BDlTlJmU/v4y35tmaiAbFh28GChkRnkO6dsSBUcXqmvtgqDoCM4u3+AnoP9ic5DxSC
 5ktXgif9F1mYgTeVthZdVvcZaYL8RfHp0uQbalFHoqGKXU8d72eRpaWXPCp2Imu/DdHA
 JtvWPi7JOqVhbjIlLsB8U1ekPO9s8FWbjxZgRGIrAK/9Woqgae+ovOyxdrhzRj3muQoS
 2MJ92Sp8HfR/EN6GpZEWA4fASTfiQleTB3hYg10S0lk+nzKfjQxOQKrsuUJydSW4/1er
 tpOsTh37sJ0Gl0cYBuvQi6hYP6AzyOYhE802NLphwkNzwFffn6NsmvQVOr8qatUUQpLS
 9X9g==
X-Gm-Message-State: AOJu0Yz/fVTNIIxuJrUaDaLMBEXep4X3vvQQaBm9qydw0HeMqaU+gpD1
 0zKsb/VgSyDOZjf4h3vqRlFXvxTeqVHgijopYAmYkvce+rlCjS6Yc4/retJ8WMj5yTG9H1A3eYE
 HaFGs8iTzK6Cy7cyjJGumVpWd5V0KZgTN/t4m1KL90ehoNX6rW1Cs+WyA
X-Gm-Gg: ASbGncvLw6nr/mFfV8dm/lm/ZrzMTzJeuquKzLa2XhNYwuL3uenfSp7DN53bicuvZeb
 u+6rr0AIh8Jcs6Bc/UIw/7zFJ6N3zh6C8yByZTjaZM4F28+o24LXHUf0Smf+RX2VbWJZbJlCLz9
 jUUtWp6eSi5r3DUcJcS4ayoua4CpwpWbqvIwJ7qwLENWOIwoRb6slJGZJC5iLf3vbh8ua/HLikX
 UKuFR7llA1Doxw/bH0OKSXYuP9z2QnxTcNGty+TBU+Y7PasNNoyxVHy7Ix/Fhg4kc5uxHRyMOyT
 HhAQWfqLS3XINPI06DDqPGo7uSx4+mZk
X-Received: by 2002:a05:6000:22ca:b0:3a4:e624:4ec9 with SMTP id
 ffacd0b85a97d-3a531315a5cmr3073656f8f.3.1749216610506; 
 Fri, 06 Jun 2025 06:30:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFEsq4ozQq6x6J37EF9J/c7vzivVYSWdEWNJE04FsHaN+RRbeJUXt42r2z71ea2UJq0BRUdug==
X-Received: by 2002:a05:6000:22ca:b0:3a4:e624:4ec9 with SMTP id
 ffacd0b85a97d-3a531315a5cmr3073616f8f.3.1749216610094; 
 Fri, 06 Jun 2025 06:30:10 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com ([85.93.96.130])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a53229de7csm1929381f8f.14.2025.06.06.06.30.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Jun 2025 06:30:09 -0700 (PDT)
Date: Fri, 6 Jun 2025 15:30:08 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?B?Q2zDqW1lbnQ=?= Mathieu--Drif
 <clement.mathieu--drif@eviden.com>, Zhao Liu <zhao1.liu@intel.com>, Hanna
 Reitz <hreitz@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 qemu-block@nongnu.org, Jason Wang <jasowang@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Yanan Wang <wangyanan55@huawei.com>, Ani
 Sinha <anisinha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Thomas
 Huth <thuth@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Kevin Wolf
 <kwolf@redhat.com>, Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH 13/18] hw/i386/pc: Remove deprecated pc-q35-2.9 and
 pc-i440fx-2.9 machines
Message-ID: <20250606153008.618cfe25@imammedo.users.ipa.redhat.com>
In-Reply-To: <20250501210456.89071-14-philmd@linaro.org>
References: <20250501210456.89071-1-philmd@linaro.org>
 <20250501210456.89071-14-philmd@linaro.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.104,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu,  1 May 2025 23:04:51 +0200
Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> wrote:

> These machines has been supported for a period of more than 6 years.
> According to our versioned machine support policy (see commit
> ce80c4fa6ff "docs: document special exception for machine type
> deprecation & removal") they can now be removed.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

>  hw/i386/pc_piix.c | 9 ---------
>  hw/i386/pc_q35.c  | 9 ---------
>  2 files changed, 18 deletions(-)
>=20
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index 0d6ad9db627..5c7d0c50f8e 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -737,15 +737,6 @@ static void pc_i440fx_machine_2_10_options(MachineCl=
ass *m)
> =20
>  DEFINE_I440FX_MACHINE(2, 10);
> =20
> -static void pc_i440fx_machine_2_9_options(MachineClass *m)
> -{
> -    pc_i440fx_machine_2_10_options(m);
> -    compat_props_add(m->compat_props, hw_compat_2_9, hw_compat_2_9_len);
> -    compat_props_add(m->compat_props, pc_compat_2_9, pc_compat_2_9_len);
> -}
> -
> -DEFINE_I440FX_MACHINE(2, 9);
> -
>  #ifdef CONFIG_ISAPC
>  static void isapc_machine_options(MachineClass *m)
>  {
> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> index 54c18100122..d66d64b3b62 100644
> --- a/hw/i386/pc_q35.c
> +++ b/hw/i386/pc_q35.c
> @@ -630,12 +630,3 @@ static void pc_q35_machine_2_10_options(MachineClass=
 *m)
>  }
> =20
>  DEFINE_Q35_MACHINE(2, 10);
> -
> -static void pc_q35_machine_2_9_options(MachineClass *m)
> -{
> -    pc_q35_machine_2_10_options(m);
> -    compat_props_add(m->compat_props, hw_compat_2_9, hw_compat_2_9_len);
> -    compat_props_add(m->compat_props, pc_compat_2_9, pc_compat_2_9_len);
> -}
> -
> -DEFINE_Q35_MACHINE(2, 9);


