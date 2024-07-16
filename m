Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECD69C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 13:30:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTiFb-0002iS-QT; Tue, 16 Jul 2024 09:29:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sTiFa-0002hf-9N
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 09:29:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sTiFV-0003p6-HF
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 09:29:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721136584;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vRg/z9OA72c3JjyTF6wOH7XQTE5k8Cx5BGSXMBf+eVI=;
 b=Tplp57Z7RVl0yPpT9viMR6I7Dh4FpmMob89+beOaFpNAsGMk+GZF/o0f5Kdiys0l7i2dKs
 XIyT7Cc25FsK1zDf8HBDqQnQiAgPTBnX3rXe0MO68nrSLJSfYH1eELDYERsm0hv3iKiA8M
 UE+R0vL90COwKORo6vdB3dAfvpkP1Zg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-wdzJBeJbM1u3es5T2X2kNw-1; Tue, 16 Jul 2024 09:29:41 -0400
X-MC-Unique: wdzJBeJbM1u3es5T2X2kNw-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-367987e6ebcso4104429f8f.2
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 06:29:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721136581; x=1721741381;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vRg/z9OA72c3JjyTF6wOH7XQTE5k8Cx5BGSXMBf+eVI=;
 b=eip9Jl3oeVY/rvCjb5AmmJorWKn1oyKnIWv/YRl4U1k0lqRSKUOzoEpV3+24F11ctH
 Xkt1u0PoWipwUUo9nNshaP7uNtH6iNnXbE5nPKoq+txx2FNPfQ1O+dZWKzvQ2bXk6dIk
 EIIhDbVPQfvNTqPKxoqbYBnNQzqAcwOnuXbJR57/nJ06GA0Pd4D41cruAy1ubv4WKrsb
 uwb0R8PLkcUbnN6AOYq7rvEYSalD+L2DZ2TPoUgfjj/lEpdXGkAs7AI4dQTH5LW/wU/X
 BK4N5x+utD9JqdgBIRKn2g3/WmpL1H4ld2/lG4SdH2zs0L0M1kyqfF1hGAx5ZqPS95Iq
 +nqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMvHGcwVhJbfqefb+DVp9uUMOnNNH6lT65NMswSC3BtWNuy8vSmFRESSOF31NDvTBa9bD7A4A/Yl24fj2HVSYUFt6iYTg=
X-Gm-Message-State: AOJu0Yy6nx/mRYJHU0gQkZzP95KLjuVfMyma4bh2PeE/M51VmHrCyhwk
 Lmx1hrcMfHFeJPBPIh+11IqWs8UDSKNO9IH35lQU1o2wQE5Ml7aBsb41PkBnvHeBAexDmCdrlXm
 ngIeyBlwynvf3OuOOEJjESJAMp5pxog82DaX9Qyp4z5asXjeOf4NAoNjJDmWH5+8MA0K2cjNLmz
 8TCeacgj3HQhkMO5IZWmx6Jsz9N+Y=
X-Received: by 2002:a5d:47a4:0:b0:366:eb61:b45 with SMTP id
 ffacd0b85a97d-368260c0bb3mr1675416f8f.1.1721136580910; 
 Tue, 16 Jul 2024 06:29:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF4tJV1t6fbWXWSYopoYBu+A47PqwQ7TAr26XB0WDbUh/3nLek1QNRBlEV1VXK5S3TOrKDjc8znmmSLlkWxv0o=
X-Received: by 2002:a5d:47a4:0:b0:366:eb61:b45 with SMTP id
 ffacd0b85a97d-368260c0bb3mr1675396f8f.1.1721136580610; Tue, 16 Jul 2024
 06:29:40 -0700 (PDT)
MIME-Version: 1.0
References: <20240716-run-v4-0-5f7a29631168@daynix.com>
 <bca5bd94-d6af-450b-a023-0bbe57fdba3f@tls.msk.ru>
 <ZpZDseDnUD39cBzE@redhat.com>
 <CABgObfasdAS443K6+2hHE1chWXei_1ytyRTOi7tX+ma8hZEC6A@mail.gmail.com>
 <3a74c242-2510-4ae0-8ac7-02b6cf7dde69@daynix.com>
In-Reply-To: <3a74c242-2510-4ae0-8ac7-02b6cf7dde69@daynix.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 16 Jul 2024 15:29:27 +0200
Message-ID: <CABgObfab1xUc8bz7Sr4zs+tiKwLBmPK-App+iULE2AHhz2-rbw@mail.gmail.com>
Subject: Re: [PATCH v4 0/7] util: Introduce qemu_get_runtime_dir()
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Yuval Shaia <yuval.shaia.ml@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Konstantin Kostiuk <kkostiuk@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Fam Zheng <fam@euphon.net>, 
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Jul 16, 2024 at 2:46=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix=
.com> wrote:
>
> On 2024/07/16 19:43, Paolo Bonzini wrote:
> > On Tue, Jul 16, 2024 at 11:56=E2=80=AFAM Daniel P. Berrang=C3=A9 <berra=
nge@redhat.com> wrote:
> >>
> >> On Tue, Jul 16, 2024 at 11:06:57AM +0300, Michael Tokarev wrote:
> >>> 16.07.2024 10:27, Akihiko Odaki wrote:
> >>>> qemu_get_runtime_dir() returns a dynamically allocated directory pat=
h
> >>>> that is appropriate for storing runtime files. It corresponds to "ru=
n"
> >>>> directory in Unix.
> >>>
> >>> Since runtime dir is always used with a filename within, how about
> >>>
> >>>    char *qemu_get_runtime_path(const char *filename)
> >>>
> >>> which return RUNTIME_DIR/filename instead of just RUNTIME_DIR ?
> >>
> >> Yeah, I agree, every single caller of the function goes on to call
> >> g_build_filename with the result. The helper should just be building
> >> the filename itself.
> >
> > That would mean using variable arguments and g_build_filename_valist().
>
> We can't prepend an element to va_list.

You could do it in two steps, with g_build_filename(runtime_dir,
first) followed by g_build_filename_valist(result, ap); doing these
steps only if if first !=3D NULL of course.

But I agree that leaving the concatenation in the caller is not
particularly worse, and makes qemu_get_runtime_dir() more readable.

Paolo


Paolo


