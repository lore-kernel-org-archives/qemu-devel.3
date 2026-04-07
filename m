Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27F4FFF5134
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2026 19:37:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wABXH-00008D-Fo; Tue, 07 Apr 2026 14:52:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wABTw-0003Gt-MK
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 14:49:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wA1DH-0001LR-4j
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 03:51:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775548266;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RdrQhO95S4U85205xz1Wc4yFHa8mhhW0SsGhPRPQ+eU=;
 b=J7AicINkqTwu5agRSVF+wEn6uduWKLe++ViXOjxCEHyTiVt73WkAXPTQL3nmp50ER2+tJ6
 hmzien3weGxL80ylnZ6g/Co9ONKD/pqjdSNPxjmTpq3kVZpnMxzW/EW+NihjLozV/YTJ8O
 fhnW9kAnjG9EuNxJI31/jkzyoBPtqSQ=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-BG1DGR4ZMC-x8rkIXZciNA-1; Tue, 07 Apr 2026 03:51:05 -0400
X-MC-Unique: BG1DGR4ZMC-x8rkIXZciNA-1
X-Mimecast-MFC-AGG-ID: BG1DGR4ZMC-x8rkIXZciNA_1775548264
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c76c60c74f3so2375630a12.2
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 00:51:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775548264; cv=none;
 d=google.com; s=arc-20240605;
 b=OU6xox5jUr21PH6R46E2FYtapctQOiy6xHesesAlpEaqiWAcs9t6sg5psPeWRIGdrD
 JNHbUky+oEVvn1iFmwd4eMObEDfqQnSE1hYad++5qSN0wL2ZZtaSdFGQIgyE95/RZkbT
 odBMUH1VsVLiCv8h13cHTN09/QTp2n2fqR2MJ+tzoI8J0y++jPwsZaCyIkrofW3RcYqd
 U2laVxQ0yDA0Mw1Z9FH48rW378BWnd49JLRBnlK+609G+agR36VmGzirfpszQJRFwbEF
 Nqq/k1AgfFb/k73iL5J9Gluxf7Ax5Fl2L26Vmb7uJR8kGSy/b89HtydaqDZhCFGN7i3w
 KdaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=RdrQhO95S4U85205xz1Wc4yFHa8mhhW0SsGhPRPQ+eU=;
 fh=I3Rojz7Rj7F7zAuh27Zv7NEdlY6RHgtmEIjZ7Qkr/EI=;
 b=H60/ODUPyQdXA2GzS27GVTekbf+RcvmV73ze+bkilDctlVV/zDC7eqQjnkjn68Hzhe
 F6FbFVfRbejcXQkpuOndoZuGHQHHt3MaTy+RxFbSeIJzLY5x05/mBM3HcE2bhLLFsgyF
 D+WYc5oCbRkqF5Eol59FYB25MJOYvYj2MZ83avzHi/eLt8MkUrZAZ6K8KPOlDDjjsp+i
 +IwchB8L7nnkaLAw03ROraWZbZ6U7BpLVAbf7zZrpyl+sjZ/hlybWU6B2/FJ0+U4AZCc
 GRIH23GZ6LIdyG2f9kU7V+dzRKqBJNVC6HLXtin9cDXD228/yeqc9DWOc33Dhhqbkqca
 nQhA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775548264; x=1776153064; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RdrQhO95S4U85205xz1Wc4yFHa8mhhW0SsGhPRPQ+eU=;
 b=q0fsuk+c10gIBTh5rgLyGYENmmTpFpJDwTHGWmHAR9uKnjmB4zIaDKTbe9jNZUOF/d
 gHYPU8woH6mmo4vfBRIy5xj4QdS4ScfNSHyOPdK7LxveeTlodE2S2vt4p+mPVHQ48YWQ
 2kyj3bprME9zLi4DRdTdfMUjhpdq17zKKw4U5wLYCgv7rwNeWc3YAADqbuXF+pFOpjAI
 CCHzCEfGL0zIK6yCvcQ9VNeSxQ/q2b7SWumwQjx0An1CU+VlLmC9bCbYXgKSBy4Q210B
 Q0JUNDZBGphRggmO8kjsS08iyP5G86vMP3eG3Ic0HXY2FfdVT/J2LeIqMaTJq4jLqRRq
 UgwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775548264; x=1776153064;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RdrQhO95S4U85205xz1Wc4yFHa8mhhW0SsGhPRPQ+eU=;
 b=UVqPLttKYxbIkG2A4SOBJbm+0keTKH3L+0LAfGaJ7qLiaKFjai0aQK2hIQ4SBG5ZgI
 AD4NAi4Kdvy/vu93N7P7XroaegLs4WS4wo1S0cz9H/PIL8mYznVIr6LsYIclP9L2XI/L
 aT4K8ObjJbahOhKc1bD2jt+379fPHJMHu33YLBbiSKFL+XIZ9N14E1t52C113ggSvRXb
 ZaeZrq2YjBMf18VCxac8kIFkq3vsPMlV/gZTvLSjBdS9E4WGxgOAHkLrznd1d2jPWKOy
 D4wEN5sBNU19Y+sUs3oRQNWerFJVCU/XPwPNkIqM4VAd93GutcrICn6P2kg4+YQaHvgL
 0gUw==
X-Gm-Message-State: AOJu0YxXkWAoOMJCezX0lkpe7SiFl9zXsENyIWMQXNLI9I7lAhplIPGM
 OaD0d4NeVujlS+z957DVx92GnV5PTMD9VJnnYD+F8UWm+L0F33nvJaId6x+UymEG7dBSFjaB2xY
 QuHP/RQNCgf9c3+xPviRNI5AC2piMXH2/LScldJSQ/6n/DOgtpW0JadcRE7YIyq6+GVBAV2DqKF
 GYakvs7Wm8AU4peMLbxmSy6YT5XbSQ4IE=
X-Gm-Gg: AeBDiesdmDleHg7oTYK56PtPb8PRuuzWHgfO9M4cHjfNNg4a6x1ExzeDnSOhcybRvuK
 bzjtPj4LK9DF/NMDjcNgVcGEjYi9QRvDyt8GNTTteyE222VLJGGpkmhPJIzC2AKlRDKh34YvfuS
 3Rp8Sk6sKtv0JVisW/VA2rB3OMfAhskCqUsXKLiQ2EOA6rlY/jNhfNYnvOHS/xLKhtSYSOGnhX7
 pQL3y8Bjkm3+2Sp9dnAGMSH9bgEfagTLuwQ6aBJm6LKU+saO7ttgetZntYS5za8It3QAO1dS6Vc
 D3M5eAZ1X6sLpQfZI46k6cI=
X-Received: by 2002:a05:6a20:2595:b0:398:abe1:eaac with SMTP id
 adf61e73a8af0-39f2f060b86mr15259264637.27.1775548263751; 
 Tue, 07 Apr 2026 00:51:03 -0700 (PDT)
X-Received: by 2002:a05:6a20:2595:b0:398:abe1:eaac with SMTP id
 adf61e73a8af0-39f2f060b86mr15259230637.27.1775548263326; Tue, 07 Apr 2026
 00:51:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260406141735.25844-1-armenon@redhat.com>
 <20260406141735.25844-3-armenon@redhat.com>
In-Reply-To: <20260406141735.25844-3-armenon@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 7 Apr 2026 11:50:51 +0400
X-Gm-Features: AQROBzDxderAXKoCorFDXfHCCe2AtaxkBMIVVJCe19F0dVpjP86G6mfCI2tMUi4
Message-ID: <CAMxuvax06YTyHxUiH+hd4rssVbmyqea-SFCQn_4KTNoQjphz0w@mail.gmail.com>
Subject: Re: [PATCH v3 02/10] hw/tpm: Refactor CRB_CTRL_START register access
To: Arun Menon <armenon@redhat.com>
Cc: qemu-devel@nongnu.org, Ani Sinha <anisinha@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Yanan Wang <wangyanan55@huawei.com>, 
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Stefan Berger <stefanb@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Apr 6, 2026 at 6:18=E2=80=AFPM Arun Menon <armenon@redhat.com> wrot=
e:
>
> From: Arun Menon <armenon@redhat.com>
>
> Replace manual bitwise operations with ARRAY_FIELD_DP32 macros
> No functional changes.
>
> Signed-off-by: Arun Menon <armenon@redhat.com>
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

(even if we decide to rename invoke->Start)

> ---
>  hw/tpm/tpm_crb.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
> index 0a1c7ecdc6..bc55908786 100644
> --- a/hw/tpm/tpm_crb.c
> +++ b/hw/tpm/tpm_crb.c
> @@ -145,7 +145,7 @@ static void tpm_crb_mmio_write(void *opaque, hwaddr a=
ddr,
>              tpm_crb_get_active_locty(s) =3D=3D locty) {
>              void *mem =3D memory_region_get_ram_ptr(&s->cmdmem);
>
> -            s->regs[R_CRB_CTRL_START] |=3D CRB_START_INVOKE;
> +            ARRAY_FIELD_DP32(s->regs, CRB_CTRL_START, invoke, 1);
>              s->cmd =3D (TPMBackendCmd) {
>                  .in =3D mem,
>                  .in_len =3D MIN(tpm_cmd_get_size(mem), s->be_buffer_size=
),
> @@ -194,7 +194,7 @@ static void tpm_crb_request_completed(TPMIf *ti, int =
ret)
>  {
>      CRBState *s =3D CRB(ti);
>
> -    s->regs[R_CRB_CTRL_START] &=3D ~CRB_START_INVOKE;
> +    ARRAY_FIELD_DP32(s->regs, CRB_CTRL_START, invoke, 0);
>      if (ret !=3D 0) {
>          ARRAY_FIELD_DP32(s->regs, CRB_CTRL_STS,
>                           tpmSts, 1); /* fatal error */
> --
> 2.53.0
>


