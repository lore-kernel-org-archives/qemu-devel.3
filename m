Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54801FF60CF
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 06:16:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7SOk-0006Bv-KS; Tue, 31 Mar 2026 02:16:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1w7SOf-00069l-7d
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 02:16:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1w7SOc-0003P1-MJ
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 02:16:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774937773;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xwSTjmxOqzSs8Ym3BrnjUX2LlqVOKTiadNNhypWKqyM=;
 b=R29ZDlL35SsuTsWpWraW5xQ4GzUj2pZt03a/Fd4cNP26NXJq0Va5/ILxLi4H360I65OP8H
 5Q5Ey4Rl8epUXDsz1/TwsSDMxHyzsHBWZ8MehBzlEM3wFAbWYYpS8PBKFFXpw+wo0L/f22
 Xd2/CcDe7Bp3uViGZ+qroRqum1wNdCY=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-495-dITMbWvMOW21CWX5Xc3rsA-1; Tue, 31 Mar 2026 02:16:11 -0400
X-MC-Unique: dITMbWvMOW21CWX5Xc3rsA-1
X-Mimecast-MFC-AGG-ID: dITMbWvMOW21CWX5Xc3rsA_1774937770
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c70f19f0f37so3290254a12.0
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2026 23:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774937770; x=1775542570; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xwSTjmxOqzSs8Ym3BrnjUX2LlqVOKTiadNNhypWKqyM=;
 b=rRTh/eFWjed+Rz+TU+JoHfi2/bbDfrGgSD+68gs3iO8JdwCnlNgoiP/ee6ZPzhYfbS
 FmsO5OWb5r19whbTL26yhdLXSt+kMoNOF0AlqOv7BXtpcCVDf+mwRpqcqqRDGewoj/mr
 kobA/L/ifgW8jQ1g+ha4rqAE4fWYNQ4SljEm4z6WKdP3YEMoOONlLAI3UN/DRk1XT9vl
 ISI9PU88CHae0jgcvylq3S0n3V2bQGZuXrAYR0HHvQYGmMzg/RP1ECWpc8gaNYfJj64q
 ADuH1kSg79ZOIN+j1+SUo2+UgCjd9k1edGVRqSVJEnEIHYZnlJ6jtYOPIeBMHU7rKbi+
 BMfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774937770; x=1775542570;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xwSTjmxOqzSs8Ym3BrnjUX2LlqVOKTiadNNhypWKqyM=;
 b=nHJ/dP6Q6kgFLAzdKGbMpbQ6zwsS/zsCS+SOnRXxf9bnIgPyhA19HMrXhW79Nxh1M8
 QTToEFZAa0PDjz4R3BO1kTCVoMEMoFfglPUxdnXr6niqTsgUIZe+RWzf3x8thx2Kp1iV
 +r9Bt65HTk3gc4uEUGXSJRyy35GSY2c6Pi7oKrg3sJJEGGcZwUTT3z2aS9x5+aP10Zl5
 kVf72c+MscCty1Mv5OUdNE9Lb951BWZ4d3VylTRFoSaUwkPbdHjz+ia5L8/Q3wQqb776
 QFBXbzLLh7IDmQQiwnB+zhoRvBlG/ULOx5J+gnmtq+MH1NgvQiWGuhcK+cIKEDOTKhWF
 VUfA==
X-Gm-Message-State: AOJu0YwVvVVxNCnZGXMMKw+x864BbbV2VdBA94X+m4zdNK9a/mAcojti
 Xl5KuzWqe0fEovWiuBvB5TOT+iQvfV5hB/ubp0giVwBtVqs1IbP2OyoNDhyFDwTKkJDz4G64NY6
 ag6cQ8RQapD3ad1uLOUQaof6IRT5SkJ3gtIQ726dmzhGqzLedvO5KNoInaWsCXub8
X-Gm-Gg: ATEYQzxvDobXfTQRPWlFPOJXDAhTdTIUWx8/9oCQqSDSkqXtLxvtn8QNR7LRz8iN1Ow
 mMbQxNoEXizaHV2NkFuA2dLkMeraMCWrIG/BERdaY28L6K8mtIckI8YWe/OHDVO5JGbAsjV40p0
 mdDtZStq9ANhHiFBSn6+G/cOpx1+obM+RHabn72LK9+9I9ffhNO8Hnv2eCL6m+KPX0fzZm1jcgi
 59Jdtk8OfSc28NQKPk6yd5F9rPX3AJhCf+ZFBXVUnqo5ddPrug0mCH8kI3riZnbwlXSFwsgb7bh
 0hFujwWiILMBBPqAIxxOsx2h/A9iAlnjPGoicvJrodK5cWRfkNLwPQEkJuUqFL4HGYrsF4Ez2nh
 eCpyUU2sUIc89D4lR37z6tZkWNnCSDKaKr9GNmEIRNF8Lcf+jGPsU/XPm9C15y08KWOCxKfgJew
 8=
X-Received: by 2002:a05:6a00:2da8:b0:82a:146d:36a3 with SMTP id
 d2e1a72fcca58-82cd65ed997mr2182447b3a.21.1774937770130; 
 Mon, 30 Mar 2026 23:16:10 -0700 (PDT)
X-Received: by 2002:a05:6a00:2da8:b0:82a:146d:36a3 with SMTP id
 d2e1a72fcca58-82cd65ed997mr2182420b3a.21.1774937769654; 
 Mon, 30 Mar 2026 23:16:09 -0700 (PDT)
Received: from smtpclient.apple ([122.163.114.34])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82caa8be173sm8326144b3a.55.2026.03.30.23.16.07
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 30 Mar 2026 23:16:09 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.400.21\))
Subject: Re: [PATCH 2/3] igvm: fix memory leak on failed memory region init
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <20260330-igvm_fixes-v1-2-03587a5a808b@redhat.com>
Date: Tue, 31 Mar 2026 11:45:55 +0530
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Oliver Steffen <osteffen@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <F98D82E4-5C4B-4A36-A386-1B2FF91034DD@redhat.com>
References: <20260330-igvm_fixes-v1-0-03587a5a808b@redhat.com>
 <20260330-igvm_fixes-v1-2-03587a5a808b@redhat.com>
To: Luigi Leonardi <leonardi@redhat.com>
X-Mailer: Apple Mail (2.3864.400.21)
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



> On 30 Mar 2026, at 6:13=E2=80=AFPM, Luigi Leonardi =
<leonardi@redhat.com> wrote:
>=20
> When memory_region_init_* fail, `igvm_pages` is not freed causing a =
leak.
>=20
> Free `igvm_pages` in the error path.
>=20
> Fixes: c1d466d267cf ("backends/igvm: Add IGVM loader and =
configuration")
> Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
> ---
> backends/igvm.c | 2 ++
> 1 file changed, 2 insertions(+)
>=20
> diff --git a/backends/igvm.c b/backends/igvm.c
> index =
50f0d6fb9a7bacddce91f095b6e2710ecbc79c6f..c347d0c17e7ee744e450d42e677946ab=
ad8a7211 100644
> --- a/backends/igvm.c
> +++ b/backends/igvm.c
> @@ -216,11 +216,13 @@ static void *qigvm_prepare_memory(QIgvm *ctx, =
uint64_t addr, uint64_t size,
>             ctx->machine_state->cgs->require_guest_memfd) {
>             if (!memory_region_init_ram_guest_memfd(igvm_pages, NULL,
>                                                     region_name, size, =
errp)) {
> +                g_free(igvm_pages);

Why not use g_autofree? That way you do not need to explicitly free it.


>                 return NULL;
>             }
>         } else {
>             if (!memory_region_init_ram(igvm_pages, NULL, region_name, =
size,
>                                         errp)) {
> +                g_free(igvm_pages);
>                 return NULL;
>             }
>         }
>=20
> --=20
> 2.53.0
>=20


