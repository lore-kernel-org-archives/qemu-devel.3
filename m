Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 888ABC5AD49
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 13:31:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNXAF-0000N3-Qd; Fri, 06 Jun 2025 09:31:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uNXA7-0000Gc-0l
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 09:31:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uNXA3-0003us-Sa
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 09:31:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749216666;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HjlNCyBhNS+RzQcscmyL/13iU54ZnVhdhrrtahCPlow=;
 b=LY1FzblOve4eQ1avE0WxtVsPdQRReZ3ijS+y+XxYPShW3E4xgJd6zuXYxw3b7FklU7qKSO
 fetItTpzmmi4QFDeqUnBnzNapm2q1Eumm2PwlPrOFdc36DLvWYL7IXy70nWM30GaZ6k/lO
 rGVcU9GC6UnMs2ZBw2mERryxSEmGwmU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-QkL4A97oN8GujtGUQrshEw-1; Fri, 06 Jun 2025 09:31:05 -0400
X-MC-Unique: QkL4A97oN8GujtGUQrshEw-1
X-Mimecast-MFC-AGG-ID: QkL4A97oN8GujtGUQrshEw_1749216664
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-450dada0f83so17527685e9.0
 for <qemu-devel@nongnu.org>; Fri, 06 Jun 2025 06:31:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749216664; x=1749821464;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HjlNCyBhNS+RzQcscmyL/13iU54ZnVhdhrrtahCPlow=;
 b=Naokt5YDC4jwp9TnbupZMPLDY6IQVv25NLXt3abc6QE2AOkRyaMKwOmFj7r28y1qIK
 UwnwW6i0N58Ybtp9YxKsjjhoop0QcxYMqWVfYVrjNdEh0++rrPHNPsi5lhzxdmpfKrbN
 x2wVzSIllbg5btc7PYkMH5JdnLA3fP1I2cY5CvIuZHZXiJBRWG0IdeSJqBFMdxpq2AJH
 O/TFqDocbdZW+JTf12C+Mv3PkW/DOCeAAOdF+c58RYVwx+u62cOc/wxRTE/3WCjIWlOC
 cqInX0y5uBzChk6HRf7ZSOGgAAa9IcqI1Fau0eZ9K9rofUZF54P+JSBPjZYC54/65k43
 KKFA==
X-Gm-Message-State: AOJu0YyhD2l8lIsVnhneBlfIPtARNAZXdwarKALuNb2UnwRsJsxBAqIm
 oBSd1W7TkBWjwc5NRQtT79e+gVICzbuQhAJ+TquNdMxzMZkiH7DWnNKYM7ggHWVWicMEpq7yzEd
 xLbY0DYi4Y3I5waaxoFkwQY1VLHf/4CBkhG7amZzUUBzfI3PhX53EcHUX
X-Gm-Gg: ASbGncusmYkpu0gzurofbbcz8wTv1o2Gj08YROkng8yXlMJEnX7fQ7Wx9i7zmUqSxal
 VVn7IIlnr2MbxBp1W9vI8NpIl5uN4hVwX9/SGONR1iQg89Z60h5skNL8b6AYK3MtWyIxB5TUhol
 vX5DyLBj5BUGhYc4ywnuxza4KEk+GekFjwycPirb+NoikGDTYxhCpFPbbYtJ/O+3aoUtNowdp5K
 S2k6YhijJVmv/hLpAggOwJIwAobc397K6OvaYXdJ+fo/NyFQlFCbrQtCBwfjXcuy9yqAiyuNze5
 s2sSxvYXzF4NBbT+kjGnRSH5X6fLDlPg
X-Received: by 2002:a05:6000:250e:b0:3a5:2670:e220 with SMTP id
 ffacd0b85a97d-3a531cb01b7mr2875228f8f.32.1749216663376; 
 Fri, 06 Jun 2025 06:31:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGH0U2oiuP/nRv0SxrzUdWM6J/+HhakNX3Db3CEZHrUXWSfeZ5aI97FCtKW8OHdA9zaxevEBQ==
X-Received: by 2002:a05:6000:250e:b0:3a5:2670:e220 with SMTP id
 ffacd0b85a97d-3a531cb01b7mr2875179f8f.32.1749216662920; 
 Fri, 06 Jun 2025 06:31:02 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com ([85.93.96.130])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a5323ad0c4sm1918500f8f.30.2025.06.06.06.31.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Jun 2025 06:31:02 -0700 (PDT)
Date: Fri, 6 Jun 2025 15:31:01 +0200
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
Subject: Re: [PATCH 14/18] hw/i386/pc: Remove pc_compat_2_9[] array
Message-ID: <20250606153101.7c404398@imammedo.users.ipa.redhat.com>
In-Reply-To: <20250501210456.89071-15-philmd@linaro.org>
References: <20250501210456.89071-1-philmd@linaro.org>
 <20250501210456.89071-15-philmd@linaro.org>
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

On Thu,  1 May 2025 23:04:52 +0200
Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> wrote:

> The pc_compat_2_9[] array was only used by the pc-q35-2.9
> and pc-i440fx-2.9 machines, which got removed. Remove it.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  include/hw/i386/pc.h | 3 ---
>  hw/i386/pc.c         | 5 -----
>  2 files changed, 8 deletions(-)
>=20
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index db02cbc0d65..455b869cce9 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -283,9 +283,6 @@ extern const size_t pc_compat_2_11_len;
>  extern GlobalProperty pc_compat_2_10[];
>  extern const size_t pc_compat_2_10_len;
> =20
> -extern GlobalProperty pc_compat_2_9[];
> -extern const size_t pc_compat_2_9_len;
> -
>  #define DEFINE_PC_MACHINE(suffix, namestr, initfn, optsfn) \
>      static void pc_machine_##suffix##_class_init(ObjectClass *oc, \
>                                                   const void *data) \
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 5f07a44d447..298091932ab 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -227,11 +227,6 @@ GlobalProperty pc_compat_2_10[] =3D {
>  };
>  const size_t pc_compat_2_10_len =3D G_N_ELEMENTS(pc_compat_2_10);
> =20
> -GlobalProperty pc_compat_2_9[] =3D {
> -    { "mch", "extended-tseg-mbytes", "0" },
> -};
> -const size_t pc_compat_2_9_len =3D G_N_ELEMENTS(pc_compat_2_9);
> -
>  /*
>   * @PC_FW_DATA:
>   * Size of the chunk of memory at the top of RAM for the BIOS ACPI tables


