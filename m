Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D057FF60D5
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 07:07:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7TCL-00082L-9y; Tue, 31 Mar 2026 03:07:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1w7TCK-00081h-5v
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 03:07:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1w7TCH-00030Z-Pt
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 03:07:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774940852;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Fe3RdMZLpAKw5VdJTEfT3s1P0ZsbNMMzwiiPXkFC0Lo=;
 b=dMI/B7xstR6rVRHwMEFrTIPLj/SughT6xuDArYQhsstxZtsj2ViSgirBLBJCSU7Hpn4TC6
 DKHRXUPz+Zet5fGIRmLVX90gvzqwny/PBAuffvZkq4mPC/+kqTQ8rgHfE4wZKypQgwFa1g
 JeILnOk1T1FXLLmodMj9QrlwygZmg8E=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-21-3JxMdpjjOSejQig8IBZdHw-1; Tue, 31 Mar 2026 03:07:30 -0400
X-MC-Unique: 3JxMdpjjOSejQig8IBZdHw-1
X-Mimecast-MFC-AGG-ID: 3JxMdpjjOSejQig8IBZdHw_1774940850
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2b242b9359aso29371345ad.0
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2026 00:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774940849; x=1775545649; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fe3RdMZLpAKw5VdJTEfT3s1P0ZsbNMMzwiiPXkFC0Lo=;
 b=CEU+1GXl3F4HHPvEMz3ByyLBWz+VdzUhei2iQCBY22ccDR+0Tm6v1lOxEeMbQtUkGu
 J/hZBxhBxqlKuX98sNxEuT+JJN9hq6THX9LkBH8Bw/gJwM3dCWGO+4hpPbukPbgGFU37
 49zxCXVyEGTrv1PgxuVR0goKn7br0Q/CicBT/qn9Y2r77WePW3uqZphclKm9cEt9PRft
 3JK7/KOIE4B0JaC6dC62O/sLwiqkoaWqCvnSUrOwAapdpDKfqO0AQQ2qxeWvyNteYSXf
 N3jMOr4uY2gIW4AN7+U/rPvG9hQBAHLJvSRLnAVjqtAs3dH4FtHwCiJ99/z80xRCelBp
 0ynA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774940849; x=1775545649;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Fe3RdMZLpAKw5VdJTEfT3s1P0ZsbNMMzwiiPXkFC0Lo=;
 b=NE0hpymgp3+KbqROPjmVk+0aAHTR137z9yA8BFjTiCHLKCNrAqSQlb/35sYCIs02mv
 hMnhDsJN3aMpbQcaqUoGbRZuIBhsKNR73srrpAzEp+GjFKDI+Idoyw29+oH1eemm6MOr
 Cs13+xGLfVPfCSwEABswXeddWS+zayJ0TcWaWXUjePKv5ijGA81b8BN8Ka+xd2G3RdDT
 S3131DzBuLGgzTeB9E+yyf0tbhK4sJofsgPDI4u294iLkJN1CSImSfi2aX/8xbLF35LJ
 GOpQGI0i2U3culwy0u2s2tcg8HssDjop0m+JtCeQd5AhbzQjou+np2woJv2CnV5IdSlM
 r8gw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFfuhh0rp4Uv/odBNzMgGdNpNBzjp3pgPF99RPYrDtMeV7WT8F59YNiu+N4dazkalH6p067SEpJybU@nongnu.org
X-Gm-Message-State: AOJu0Yz5ovNH12lQzn5Dx4Wd+AAY5++lbQU5F2cpfmp1IF67TFI30smk
 gmVOkt34ivgSo2S+ygGtqB5860L0gAzwb8TPvuqbfiQjtJ7vms1iYY2dFmmnqO93yZtzWtJFm8Z
 Y1/9hmEpWB+skr/0UxqzOqUbiRPrFyqS5peMUYnGy4oORV+LW4D5WqVHODOiNcorw
X-Gm-Gg: ATEYQzwUt16pJ8KsLWv4ITlrxYAz8AK+Fva2iJhrBs5yFqIzxxredC6C0m4+SBxgtFA
 Jdhg6r9L7Px5uVGkU6CDmBhpDJPQhMDwlIQ9wi8pmF9MYFzQk+wcu/ZwX8U6OhFhWuzr4o5ymSB
 XnpqPuFazUKPIGt5KYsNRSkS3EdyRmXcEU890xffUSN1VX8jmglmGjtoFGk3SogTjHggz7T16aE
 4/lYZv2XHv2/FVxErEQO4a7+isVZcmikJ385tn7O+s/kiHV5nSK1IbPSl60LCEO1jUuVMSLDPGr
 SuHksFunygIIlN6+jt1rCE8Ru+Rg8Sph6whHlPn1yM6AiSGgRd4ntH4PkJlhdzEQfrJOU+GMrsu
 raHW/CXsRfldbzeQSCbT/n4OYqdeacKif9HkWaeEuPiQpmZ9+CBcS4rvnKCQSI7HLGBT41xpBq2
 M=
X-Received: by 2002:a17:902:fc4e:b0:2ad:9b86:ddc2 with SMTP id
 d9443c01a7336-2b0cdc4361bmr164479345ad.22.1774940849447; 
 Tue, 31 Mar 2026 00:07:29 -0700 (PDT)
X-Received: by 2002:a17:902:fc4e:b0:2ad:9b86:ddc2 with SMTP id
 d9443c01a7336-2b0cdc4361bmr164479125ad.22.1774940848944; 
 Tue, 31 Mar 2026 00:07:28 -0700 (PDT)
Received: from smtpclient.apple ([122.163.114.34])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b2427ae07fsm104596555ad.69.2026.03.31.00.07.26
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 31 Mar 2026 00:07:28 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.400.21\))
Subject: Re: [PATCH 2/3] igvm: fix memory leak on failed memory region init
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <actsWgsnHAuQ2lf9@sirius.home.kraxel.org>
Date: Tue, 31 Mar 2026 12:37:14 +0530
Cc: Luigi Leonardi <leonardi@redhat.com>, qemu-devel@nongnu.org,
 Stefano Garzarella <sgarzare@redhat.com>,
 Oliver Steffen <osteffen@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <FF77CA5D-E208-4CF7-A4A9-714FFF605C6E@redhat.com>
References: <20260330-igvm_fixes-v1-0-03587a5a808b@redhat.com>
 <20260330-igvm_fixes-v1-2-03587a5a808b@redhat.com>
 <F98D82E4-5C4B-4A36-A386-1B2FF91034DD@redhat.com>
 <actsWgsnHAuQ2lf9@sirius.home.kraxel.org>
To: Gerd Hoffmann <kraxel@redhat.com>
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



> On 31 Mar 2026, at 12:11=E2=80=AFPM, Gerd Hoffmann <kraxel@redhat.com> =
wrote:
>=20
> On Tue, Mar 31, 2026 at 11:45:55AM +0530, Ani Sinha wrote:
>>=20
>>=20
>>> On 30 Mar 2026, at 6:13=E2=80=AFPM, Luigi Leonardi =
<leonardi@redhat.com> wrote:
>>>=20
>>> When memory_region_init_* fail, `igvm_pages` is not freed causing a =
leak.
>>>=20
>>> Free `igvm_pages` in the error path.
>>>=20
>>> Fixes: c1d466d267cf ("backends/igvm: Add IGVM loader and =
configuration")
>>> Signed-off-by: Luigi Leonardi <leonardi@redhat.com>

Reviewed-by: Ani Sinha <anisinha@redhat.com>

>>> ---
>>> backends/igvm.c | 2 ++
>>> 1 file changed, 2 insertions(+)
>>>=20
>>> diff --git a/backends/igvm.c b/backends/igvm.c
>>> index =
50f0d6fb9a7bacddce91f095b6e2710ecbc79c6f..c347d0c17e7ee744e450d42e677946ab=
ad8a7211 100644
>>> --- a/backends/igvm.c
>>> +++ b/backends/igvm.c
>>> @@ -216,11 +216,13 @@ static void *qigvm_prepare_memory(QIgvm *ctx, =
uint64_t addr, uint64_t size,
>>>            ctx->machine_state->cgs->require_guest_memfd) {
>>>            if (!memory_region_init_ram_guest_memfd(igvm_pages, NULL,
>>>                                                    region_name, =
size, errp)) {
>>> +                g_free(igvm_pages);
>>=20
>> Why not use g_autofree? That way you do not need to explicitly free =
it.
>=20
> autofree does not work because it must be freed in the error case =
only.
>=20
> take care,
>  Gerd
>=20


