Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 661A1CD5BCF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 04:15:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRjCY-0004I1-Sz; Tue, 26 May 2026 00:15:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wRjCW-0004Hg-L4
 for qemu-devel@nongnu.org; Tue, 26 May 2026 00:15:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wRjCT-0007f7-Uo
 for qemu-devel@nongnu.org; Tue, 26 May 2026 00:15:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779768928;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ElMZ/vicUbN+TsMfjr9EijaQ3zNqtxaT3mcM9NyM8B0=;
 b=ItTVMRfhJK+UgTIyD+Z9rZuKv466fkEDOA4XiaFOUDHJ4r3t+pPLjav+yV0YjIiCvZ4S0c
 DwXHNkGY29REP7x1jmUzRVNHmjpQWgagPTK0ZWR8yMa9lpmAuLFhXaRyWsPSk1cmUN3IwC
 XqhaNGVgFYEGf9UdFGXo5JQQ7g/oAK8=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-190-GvyJlqYKOlu3_48dFOdAyQ-1; Tue, 26 May 2026 00:15:26 -0400
X-MC-Unique: GvyJlqYKOlu3_48dFOdAyQ-1
X-Mimecast-MFC-AGG-ID: GvyJlqYKOlu3_48dFOdAyQ_1779768925
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-369467ab5bfso8611305a91.0
 for <qemu-devel@nongnu.org>; Mon, 25 May 2026 21:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779768925; x=1780373725; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ElMZ/vicUbN+TsMfjr9EijaQ3zNqtxaT3mcM9NyM8B0=;
 b=r/UwhwEmHP0/AJ4l5DwUb8vU/NgMsPLkPhRKJ/yCgw8tvWqRZURnB7yDO3+8GfnGXh
 eoExfIrwtr6kh8ZvhZOYimCvuv3YBXampwcX5ygx0mIVthaYohI0gjtXCvo2MRGW+n7s
 viUwCU01Y5Bk9v5VCEWI31z4LxpHKD1GdFCZAcIEAQRL9ilLzE/oodGTYzDQ3GVcWFhq
 j+p11HiFDlJYn1Wgx/Dx68pxRJnGmBkRUKTZYKdexjJuq7WqeovPEEWE0aLyrh/YrvOP
 OaK/MJoH02z2eQFBROT/ZOFtAnexlkJhrRW9LMsuK3gljxMansCGtmNR6MdRUBPAv0mP
 6HQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779768925; x=1780373725;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ElMZ/vicUbN+TsMfjr9EijaQ3zNqtxaT3mcM9NyM8B0=;
 b=eBDJowIhJ5uxOGZ1fDUtBZ/w+VmpkEFSbggOVe8v0Wvkm23lDb9zD+6Vrbq8bVaD38
 zu9XdA/frdj07uUmKrvolYLl409rq1SSfrieZNiIOGROZONN5VJG1lwgZEVZxpkBctnx
 eg+pezHzizI+Qfqnl7TIp4zoe7tTsJDINNzwU4cU3XaPpTpm+TeJrSmBiSZBBBuvMwzX
 oMElu7+5qxJZgj0Grt21NFEvDUhjrBmiJZExgiNFGuI7b3DUp5KELlxXYxK+/OMXyIaK
 dMK+ZuwM413wg/60OSt/PRNzpWsvX7YmsfFfsM2DELcczcUPvwSnTMyVCab2WRcZoEbN
 HLuw==
X-Gm-Message-State: AOJu0YxCm3XxzLmB4RYxQYpw5QNlQBjANcRsqQSZ0azDEO+pOPbDRXR4
 BzqqabS5dnwJl7T8F/vPeCCp/krvkN3h4GisUBxkB3a0MQYAxESFnvv74ET7QlwytDmBvMsWo9E
 2ZmZuBmKO2wRLodYCBXYH2aT71dfbBFDHgV2JBgV5JHmVpeC7tLsGvc63ak+NkCrX
X-Gm-Gg: Acq92OGcKweJl/WcEoMI807981m9pI2vOyweuhUOm24FwQwolJXBrrAKrvKFk4EU0xy
 D3UEf7O9J/w5XE5NRejQr+YYLXcwLg8pCLFh+8+mv/sJdJc5ckwlvMWWwhpmriFBAb4MWml/1vY
 HKt8kwPS4ayXlChrOx0PQwMJixO1U7cestLT4UEw2Px2c3v57ixelz1ENY3Ko2iCzJKJatf0qOV
 kM9pbcqgB4MDNKsnXl91G3VKrdYiVgGwot0ND4DpN15uoB0h4jvUOZrYKeyTqHlgcI/zgHq8rh3
 JcpKsISuyabUAGZrkwUJv4x0it6SUglXFP1phcme54ic4CTP4ov8ykZNs5/7/1z854V7kJnggDH
 BtUJfcis1GMIsHGy3zOlErtRtzlbqFCyUrI2j1mPPK4OQYCuarvRL2b5QK2rk7snGbX7VEX4KLI
 LWMdt4u7bXoA==
X-Received: by 2002:a17:90b:56cd:b0:367:bc89:546e with SMTP id
 98e67ed59e1d1-36a6778bc05mr14879108a91.12.1779768924925; 
 Mon, 25 May 2026 21:15:24 -0700 (PDT)
X-Received: by 2002:a17:90b:56cd:b0:367:bc89:546e with SMTP id
 98e67ed59e1d1-36a6778bc05mr14879086a91.12.1779768924415; 
 Mon, 25 May 2026 21:15:24 -0700 (PDT)
Received: from smtpclient.apple ([122.163.114.34])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c85205855dasm10221642a12.31.2026.05.25.21.15.22
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 25 May 2026 21:15:24 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [PATCH] igvm: fix handling of optional variable header types
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <ahRZH2bUbuQnirr_@leonardi-redhat>
Date: Tue, 26 May 2026 09:45:18 +0530
Cc: qemu-devel <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <8AFE933D-028C-44FC-802A-604298107627@redhat.com>
References: <20260525-igvm_optional-v1-1-28edc607acfd@redhat.com>
 <4ED1F4C8-B56E-4997-99CB-C509629F13C7@redhat.com>
 <ahRZH2bUbuQnirr_@leonardi-redhat>
To: Luigi Leonardi <leonardi@redhat.com>
X-Mailer: Apple Mail (2.3864.600.51.1.1)
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



> On 25 May 2026, at 7:46=E2=80=AFPM, Luigi Leonardi =
<leonardi@redhat.com> wrote:
>=20
> On Mon, May 25, 2026 at 07:37:55PM +0530, Ani Sinha wrote:
>>=20
>>=20
>>> On 25 May 2026, at 4:26=E2=80=AFPM, Luigi Leonardi =
<leonardi@redhat.com> wrote:
>>>=20
>>> The IGVM spec defines bit 31 of the variable header type as an
>>> optional flag: if set, a loader that does not recognize the header
>>> type may safely skip it. If clear, the loader must reject the file.


This description is very confusing. Where is this text written? I =
can=E2=80=99t find it.

>>>=20
>>> Currently, all the types with the optional bit set are not
>>> recognized as valid headers.
>>>=20
>>> Implement optional header handling by masking bit 31 before matching
>>> against the handler table, and skip with a warning any unrecognized
>>> header that has the optional bit set.
>>>=20
>>> Fixes: c1d466d267cf ("backends/igvm: Add IGVM loader and =
configuration")
>>> Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
>>> ---
>>> backends/igvm.c | 24 +++++++++++++++++++++---
>>> 1 file changed, 21 insertions(+), 3 deletions(-)
>>>=20
>>> diff --git a/backends/igvm.c b/backends/igvm.c
>>> index c347d0c17e..408917f826 100644
>>> --- a/backends/igvm.c
>>> +++ b/backends/igvm.c
>>> @@ -26,6 +26,7 @@
>>> #include <igvm/igvm.h>
>>> #include <igvm/igvm_defs.h>
>>>=20
>>> +#define IGVM_VHT_OPTIONAL_BIT (1U << 31)
>>>=20
>>> /*
>>> * Some directives are specific to particular confidential computing =
platforms.
>>> @@ -139,8 +140,16 @@ static int qigvm_handler(QIgvm *ctx, uint32_t =
type, Error **errp)
>>>    const uint8_t *header_data;
>>>    int result;
>>>=20
>>> +    /*
>>> +     * Bit 31 of the variable header type indicates that the header =
is
>>> +     * optional and can be safely ignored by a loader that does not
>>> +     * support it. If the bit is clear, the file cannot be loaded.
>>> +     * =
https://docs.rs/igvm_defs/0.4.0/igvm_defs/struct.IgvmVariableHeaderType.ht=
ml
>>> +     */
>>> +    IgvmVariableHeaderType base_type =3D type & =
~IGVM_VHT_OPTIONAL_BIT;
>>> +
>>>    for (handler =3D 0; handler < G_N_ELEMENTS(handlers); handler++) =
{
>>> -        if (handlers[handler].type !=3D type) {
>>> +        if (handlers[handler].type !=3D base_type) {
>>>            continue;
>>>        }
>>>        header_handle =3D igvm_get_header(ctx->file, =
handlers[handler].section,
>>> @@ -166,6 +175,13 @@ static int qigvm_handler(QIgvm *ctx, uint32_t =
type, Error **errp)
>>>        igvm_free_buffer(ctx->file, header_handle);
>>>        return result;
>>>    }
>>> +
>>> +    if (type & IGVM_VHT_OPTIONAL_BIT) {
>>> +        warn_report("IGVM: Skipping unsupported optional header =
type 0x%"
>>> +                    PRIX32, type);
>>> +        return 0;
>>> +    }
>>> +
>>=20
>> I think this check should be at the top of the loop. If the bit is =
set, simply return with that warning message. No further processing is =
needed.
>=20
> IIUC, in this way we would always skip optional parameter, right? My =
idea is to
> always process optional parameters if we support it.

The spec says:

"The top bit of this type may be set to indicate a loader may safely =
ignore that structure.=E2=80=9D

So if the bit is set, the way I understand it, there is no need for =
further processing.

>=20
>>=20
>>=20
>>>    error_setg(errp,
>>>               "IGVM: Unknown header type encountered when processing =
file: "
>>>               "(type 0x%X)",
>>> @@ -787,7 +803,8 @@ static int =
qigvm_supported_platform_compat_mask(QIgvm *ctx, Error **errp)
>>>         header_index++) {
>>>        IgvmVariableHeaderType typ =3D igvm_get_header_type(
>>>            ctx->file, IGVM_HEADER_SECTION_PLATFORM, header_index);
>>> -        if (typ =3D=3D IGVM_VHT_SUPPORTED_PLATFORM) {
>>> +        IgvmVariableHeaderType base_type =3D typ & =
~IGVM_VHT_OPTIONAL_BIT;
>>> +        if (base_type =3D=3D IGVM_VHT_SUPPORTED_PLATFORM) {
>>>            header_handle =3D igvm_get_header(
>>>                ctx->file, IGVM_HEADER_SECTION_PLATFORM, =
header_index);
>>>            if (header_handle < 0) {
>>> @@ -947,7 +964,8 @@ int qigvm_process_file(IgvmCfg *cfg, =
MachineState *machine_state,
>>>         ctx.current_header_index++) {
>>>        IgvmVariableHeaderType type =3D igvm_get_header_type(
>>>            ctx.file, IGVM_HEADER_SECTION_DIRECTIVE, =
ctx.current_header_index);
>>> -        if (!onlyVpContext || (type =3D=3D IGVM_VHT_VP_CONTEXT)) {
>>> +        IgvmVariableHeaderType base_type =3D type & =
~IGVM_VHT_OPTIONAL_BIT;
>>> +        if (!onlyVpContext || base_type =3D=3D IGVM_VHT_VP_CONTEXT) =
{
>>>            if (qigvm_handler(&ctx, type, errp) < 0) {
>>>                goto cleanup_parameters;
>>>            }
>>>=20
>>> ---
>>> base-commit: cbf877d67a812be17a9ce404a589e1bdf722c1f6
>>> change-id: 20260525-igvm_optional-ca1592b613be
>>>=20
>>> Best regards,
>>> --
>>> Luigi Leonardi <leonardi@redhat.com>



