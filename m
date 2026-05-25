Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FC31CD5BB1
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2026 13:49:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRVgH-000814-Ga; Mon, 25 May 2026 09:49:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wRVg5-000808-NX
 for qemu-devel@nongnu.org; Mon, 25 May 2026 09:49:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wRVg2-0007y6-4Y
 for qemu-devel@nongnu.org; Mon, 25 May 2026 09:49:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779716943;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g6HziBG1obzse4EJ+ceWxIFYDOCQfj4a5ca/uOLMrW0=;
 b=YTMey/P7j6+o0pj1fRwze2iS+xr5dOa91juJyWkApaVS4/VnnWsZx8ejZ6HgPGeNrt8aK7
 RzHsWtnRoUqicxYs8Pq9JoZMi/nP+DPUy1OZx0HrLh4T18zu78jCMP0bU93BF4kqtwUDWX
 cBnJYyYzrlEjXauhot9X5Oev1k1rzZE=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-DhWFR-1fMkirxRhYXiO-Dw-1; Mon, 25 May 2026 09:49:01 -0400
X-MC-Unique: DhWFR-1fMkirxRhYXiO-Dw-1
X-Mimecast-MFC-AGG-ID: DhWFR-1fMkirxRhYXiO-Dw_1779716940
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c82c4772950so4735116a12.1
 for <qemu-devel@nongnu.org>; Mon, 25 May 2026 06:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779716940; x=1780321740; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g6HziBG1obzse4EJ+ceWxIFYDOCQfj4a5ca/uOLMrW0=;
 b=aQe9Pl6NLbhoMbRzMfCx0aFMcVYwW5cgPvdb7RjMSMkZp1jUFcWRA1VSXD2bfQd77j
 oPRLcHo4YwVcZaeD7SaebhA9l9VCvrwF3O/T6HjnvWrPAfsNIyiwh2glSrIgaeezeONc
 vq5Y/0RPuBwAmgWFy6Qyeko9Ow3t7uGRsS6VCTUXaTVYjwsBMztxaeAM8cwIrPJjzL+L
 LCu1T2EXRou6dDm3pqpWnCHBScyFP4WDw5fAPtk/mIdqovxaIbUILW5WTPf9QcGnsouF
 1PQrsq20/KezzhhXaAQSBxVpmY/D8+aAHDgw8QYJNsDCIKmWvvdGvc/w875CBAWiL5Qh
 hqTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779716940; x=1780321740;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=g6HziBG1obzse4EJ+ceWxIFYDOCQfj4a5ca/uOLMrW0=;
 b=UD5ES90fLBxgAQ2MB5TyJ9cUgwO8ad4n3hQarg2d9FniUUrcKJlWdLdR2Uz5yIQm/X
 xD8W3Jw72YV4wk7GCenKfHjJWAdm5DsftHlRJ33UV2HzISpSVLFi+cIHNiS+6sMvs6Ai
 6L6+TEP/o9g7LZVwW7TaVUCcbhkUq3QzXYSfFNhHlMA//hh6VYXF+PiE1Bun4NCq5Wyh
 D6FWUwA9hflgtR2TjK/pk5vfsJUL8ZyzCX9gJzRfuwrtXSE1a+VbANyMwRl0V5BqRruk
 yPEx9hT63BRwsfwH6YjuzBQnBTxODBvHkD9a0r2comNGK5FZ9AFDdAUckUIfvQFNbrV5
 Lrnw==
X-Gm-Message-State: AOJu0YwdDIqmr6zAUXUMbY3hGS0ReqOKnvhwG6keXGbAZkuwiSWPo3I8
 uS60v1kV0WRnNJQ5BOnIlIj3UhsH56qckTuPq2BxqaYOiqjCdTySs+Vh0x7bAWiqwwTP/b5Qeg9
 wyfDJ8q2E/7nY64BlqyCX1XBPixfiQguZhLd7qcMHYGfzyjL1tMpUKUL5
X-Gm-Gg: Acq92OGoQBW5j3FS1Oo8z+eB73OZ2yWi31tweLB5qUK583XgX4tQ5+F1FhdBVv12pNu
 b2xGkXA7JsIiiseTnS4W7kkihpHd2qncFCeqush0mDH8ZpNAadWlBW0HbG+bVFnW67C/MtO1oPW
 9h4v6tw1lods5mR+EerqMneJe0PDuc4kF5BJl4mC7xeCvkFNs1NXRN8qqwg9aKzq24OSCUdh46f
 9aQUPa6/sO3FglyhnR/B1BgoY/+HkHCX0G9BEsjryWd6kig1FSfgheZjvb7Iuqt7m5SeuwNlSYW
 Ve3RSUECPdmlgFFs4uNfcRuLfE+7CA6MUoljk0JdeXPCp7Q19msSC4qCrn+Hz0Ulp2HgyNyWmEr
 ZEc9ummauAU7iMIir6PF4hUFDHTMIC1q+wCO/rQ6gWE/zUAOz5rbVxMQSt/SD2L8BcTjESmEVv9
 7HpcnJveIzQw==
X-Received: by 2002:a05:6a00:2d20:b0:82f:49b5:cfc3 with SMTP id
 d2e1a72fcca58-8416116fed6mr10044677b3a.18.1779716940356; 
 Mon, 25 May 2026 06:49:00 -0700 (PDT)
X-Received: by 2002:a05:6a00:2d20:b0:82f:49b5:cfc3 with SMTP id
 d2e1a72fcca58-8416116fed6mr10044653b3a.18.1779716939836; 
 Mon, 25 May 2026 06:48:59 -0700 (PDT)
Received: from smtpclient.apple ([2401:4900:1c00:31c5:adbe:82eb:af87:7a11])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84164fb28d5sm10007050b3a.41.2026.05.25.06.48.57
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 25 May 2026 06:48:59 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [PATCH] igvm: replace raw uint32_t with igvm library types
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <20260525-igvm_types-v1-1-df2907c1815a@redhat.com>
Date: Mon, 25 May 2026 19:18:45 +0530
Cc: qemu-devel <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Oliver Steffen <osteffen@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <8B8A20FD-D7FF-4440-AAE7-CFD0CA01D9C7@redhat.com>
References: <20260525-igvm_types-v1-1-df2907c1815a@redhat.com>
To: Luigi Leonardi <leonardi@redhat.com>
X-Mailer: Apple Mail (2.3864.600.51.1.1)
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



> On 25 May 2026, at 5:26=E2=80=AFPM, Luigi Leonardi =
<leonardi@redhat.com> wrote:
>=20
> Use IgvmVariableHeaderType and IgvmHeaderSection in QIGVMHandler and
> qigvm_handler() instead of plain uint32_t, so that each field's =
purpose
> is clear from its type.
>=20
> Signed-off-by: Luigi Leonardi <leonardi@redhat.com>

Reviewed-by: Ani Sinha <anisinha@redhat.com>

> ---
> backends/igvm.c | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/backends/igvm.c b/backends/igvm.c
> index c347d0c17e..8bb5750768 100644
> --- a/backends/igvm.c
> +++ b/backends/igvm.c
> @@ -102,8 +102,8 @@ static int qigvm_initialization_guest_policy(QIgvm =
*ctx,
>                                        Error **errp);
>=20
> struct QIGVMHandler {
> -    uint32_t type;
> -    uint32_t section;
> +    IgvmVariableHeaderType type;
> +    IgvmHeaderSection section;
>     int (*handler)(QIgvm *ctx, const uint8_t *header_data, Error =
**errp);
> };
>=20
> @@ -132,7 +132,7 @@ static struct QIGVMHandler handlers[] =3D {
>       qigvm_directive_madt },
> };
>=20
> -static int qigvm_handler(QIgvm *ctx, uint32_t type, Error **errp)
> +static int qigvm_handler(QIgvm *ctx, IgvmVariableHeaderType type, =
Error **errp)
> {
>     size_t handler;
>     IgvmHandle header_handle;
>=20
> ---
> base-commit: cbf877d67a812be17a9ce404a589e1bdf722c1f6
> change-id: 20260525-igvm_types-4b24d233e6bb
>=20
> Best regards,
> --=20
> Luigi Leonardi <leonardi@redhat.com>
>=20


