Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60218109B461
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 12:55:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7Yd0-0001kw-FF; Tue, 31 Mar 2026 08:55:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1w7Ycq-0001h9-MZ
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 08:55:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1w7Ycn-0001Sf-0N
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 08:55:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774961715;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gQFvYVxoYmzK+rJqaZss27zzU2kiKWugPMLE6h9w6l0=;
 b=DCE5SQH8CJkK/WUVs7/+qc2yeU+ZLNsSrhkp9BJvbxYZQcLktV7EbWZ8xD88mUWvffUxdM
 UjPhMU/y1awxZ9PWafmRn3hRber0m8Vv4a6q3RQJmOEVKrAO/qln9g3QwUF+1W3A9D2P7G
 RxFOT7u8Z+LE4yOWy/XAM24VD+k6zt4=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-7--3BZKDGmO5matbmk8TDXUQ-1; Tue, 31 Mar 2026 08:55:13 -0400
X-MC-Unique: -3BZKDGmO5matbmk8TDXUQ-1
X-Mimecast-MFC-AGG-ID: -3BZKDGmO5matbmk8TDXUQ_1774961713
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8a275472d89so26779446d6.1
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2026 05:55:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774961713; cv=none;
 d=google.com; s=arc-20240605;
 b=gupJZG6nm3bVrCWG9FZMmbTjC0STz5KwGO1+l2JWcmAE54DPxzKYTFGklB525DwhY6
 hgd7gmhd4n/elWwms9XlGIg2D7+ut3hOXYp+pka21FPAgC7h/8nJSz97eR1sBOhxPGsB
 VPyAY2mDWdT3J/OW8w/xSC4oI/wN+daEkPE24KQY+ANb/ruIwnU5N3JwKBWBuP6r9bF4
 CM/YKBU4TGiyGE3fLeYSBW0V1pRmVkxiTR292TTvWJOMsBhYnzuK0XlaaSUIBadlx6WG
 T7a8A2nCB0OUdmCpsndVpSR89FkINLbioqUse2/0CtdXX0YcdmiohGQ+BwzJ3KgvA1G1
 Hncw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=gQFvYVxoYmzK+rJqaZss27zzU2kiKWugPMLE6h9w6l0=;
 fh=LJgJKro7Mx7TV24w1cSqaChiM89qA2KA5l8SFiRg+VI=;
 b=gDcOg4Cu0cuvbFaJPWyks0NEnbmcSt2GGZI2nVaoqtqEHE1aRYOQDsfiTsF71OMslp
 shrWi41am1lKvst7QFv415W8M7D5k8daMcAGvcqw0WNwfIYkVbjbUPIxRSSypTFmIOTJ
 T9QNnh/LdQZNm3h8bZEONpzg/3wvqMtT0ZJcyzyQwT9YQtwkwNWm2KG0tVFFXuRFjTN+
 TfIUVgU4BBUS4/rcU3E1QpQIFPRd7s15TleIDcrITUcVnAaLoPClnc4lEtYn6SvypZE/
 snFgXKKxyFA/oijBUeCCzjRWC9XNsi3638v+dgfBJaD9GD+8xEtGoHEhdoGdNCIAA+m5
 bsGA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774961713; x=1775566513; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gQFvYVxoYmzK+rJqaZss27zzU2kiKWugPMLE6h9w6l0=;
 b=TdnYbHN7CGMrv0CJPjsVlCE8WSqYbTruKSTrs+Duft4G6AtOVyPhB0Jc+LCT0LMYzw
 K8Ci9BKnGb54wB6sPXqVEvQuU0SqUQ2u16r7TbxdMFpGjMUv5TkeyiZplqJS4PXKgkW6
 6ulx9ihp8j+XL9dzOXolXk+hZloajh0pNsWdqeq4TTZTfzeK2qj1lS9FsaGOq/Ez01Zq
 1nqkbn+27HTDJMMmnqOBxkN0hbAQVk8mVx3YsTGXnUq3m1nOXG541K0rD9ztGxGfV2jl
 B1fSGvzqxlE634j5B/BJh7OAAeq1jUyfiLs6q8xMY5sJ7/N86CBCeEV1pNrvBSyDSklL
 2i0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774961713; x=1775566513;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gQFvYVxoYmzK+rJqaZss27zzU2kiKWugPMLE6h9w6l0=;
 b=odKi8R//G2+mZTPNA9AgGBibGUbDoPuh57/EawYCiCnCCWQ6dEmk4C7W+LydF1AeMe
 Hnyr1hrQVGpLsAMk9MUO2IoxujgkrDbud/eDnFPPFj2OVxJL5+HdYDHSuDgtXy3Jzz3Z
 IYshPfboKPXyvcVXtHiePdSUT03DP/ZfxwEFurM7sJluXQm1pEqzAo+aT6dPhxnmeog6
 1ESXAh980BEb7QNopR2vaywnSVVswCPtX2iZMYr4mYSd04593ZIDCGCD58S6P1gRkti8
 C4r6NiWt6KpjrfCfVSZ5XsOKQxewrqmFYVWgEwJCShDfzUwhpjpwxFgYK9gcnTRu+QhI
 hYuQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVh7SQZKCC/mdMavyhG0xzj1nhkUsBp7g00mVYeRdIcv7KfIHJdK3HAjHTLeU2nwQJOwPTMcPHGzzNT@nongnu.org
X-Gm-Message-State: AOJu0Yx2yE5Enh/2uM7EOw6vaHyg9qxqh8RX+RLIlsizOCJEkN9CU2wY
 WKleiwW7FYNPuZ9W5z1eQv0lcn5fBnlBjezObKmDfHqsVtEsaRGsHWlLtrgBTaG+ck6yWKJrOEX
 vqYTvEHVfB3R49sKT8ABBgBPQTShWPdHWf3e9AH60peNHpiLAAdfRfLrcFjq/C23HFrPY0Yi4r8
 mFmOAYvcDASFry2bszYtiYfc3b83np01U=
X-Gm-Gg: ATEYQzxCthzpF4Xq86MvUiPZ4pQjiixKi8oyo4tBxOYF8juukD3ekaGHZvT1UfycZI9
 P666MiEkGIKYs0Bw/hrb/fNSdIIVi5PQ4T902pgGC0ji0rwFkti1VJmuximqGTcawx5Dx4v7EmP
 5tgL8VxHfsVLlkrPCQORjCsxz/sx0QXNmoAlrU4lg5IdKAU07YSdpCNdtLpIXiof9x3P6HwI4ZL
 h6dazWb
X-Received: by 2002:a05:6214:478a:b0:89c:4d3e:fa41 with SMTP id
 6a1803df08f44-89ce8d42241mr222821906d6.12.1774961713061; 
 Tue, 31 Mar 2026 05:55:13 -0700 (PDT)
X-Received: by 2002:a05:6214:478a:b0:89c:4d3e:fa41 with SMTP id
 6a1803df08f44-89ce8d42241mr222821476d6.12.1774961712447; Tue, 31 Mar 2026
 05:55:12 -0700 (PDT)
MIME-Version: 1.0
References: <20260330151941.2207789-1-eashurov@redhat.com>
 <acu5ORMkk3q0Zt4b@redhat.com>
In-Reply-To: <acu5ORMkk3q0Zt4b@redhat.com>
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Date: Tue, 31 Mar 2026 15:55:01 +0300
X-Gm-Features: AQROBzCZrLk3WjD9uEtRjQItq3WF-PBYJExAYi3HiuO7ttLOBfJMvWbf4nVxTrg
Message-ID: <CAPMcbCpzzte9dvR5-PJpyYipYEyWaPKjC+HMP-jQJUAAnhORsw@mail.gmail.com>
Subject: Re: [PATCH v2] qga: add security info to guest-get-osinfo
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Elizabeth Ashurov <eashurov@redhat.com>, qemu-devel@nongnu.org,
 yvugenfi@redhat.com
Content-Type: multipart/alternative; boundary="0000000000005c574b064e517a8e"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

--0000000000005c574b064e517a8e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Best Regards,
Kostiantyn Kostiuk.


On Tue, Mar 31, 2026 at 3:08=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com>
wrote:

> On Mon, Mar 30, 2026 at 06:19:41PM +0300, Elizabeth Ashurov wrote:
> > Extend guest-get-osinfo to include security features status
> > (VBS, Secure Boot, TPM) in a nested 'security' field.
> > OS-specific data (e.g. Windows DeviceGuard) is separated
> > using a union to allow future per-OS extensions.
> >
> > The implementation queries Win32_DeviceGuard and Win32_Tpm via
> > WMI, and reads the SecureBoot UEFI variable through
> > GetFirmwareEnvironmentVariable().
> >
> > Signed-off-by: Elizabeth Ashurov <eashurov@redhat.com>
> > ---
> >  qga/commands-win32.c | 421 +++++++++++++++++++++++++++++++++++++++++++
>
> This should also provide a Linux impl for the TPM and secureboot info as
> that is platform portable and easily available.
>
> >  qga/qapi-schema.json |  91 +++++++++-
> >  2 files changed, 511 insertions(+), 1 deletion(-)
>
> > +
> > +/*
> > + * Read the SecureBoot UEFI variable.  On legacy BIOS systems the fiel=
d
> > + * is omitted (not applicable).
> > + */
> > +static void get_secure_boot_status(GuestSecurityInfo *info,
> > +                                   Error **errp)
> > +{
> > +    Error *local_err =3D NULL;
> > +    BYTE value =3D 0;
> > +    DWORD ret;
> > +
> > +    acquire_privilege(SE_SYSTEM_ENVIRONMENT_NAME, &local_err);
> > +    if (local_err) {
> > +        error_propagate(errp, local_err);
> > +        return;
> > +    }
> > +
> > +    ret =3D GetFirmwareEnvironmentVariableA("SecureBoot",
> > +        "{8be4df61-93ca-11d2-aa0d-00e098032b8c}", &value,
> sizeof(value));
> > +
> > +    if (ret =3D=3D 0) {
> > +        DWORD err =3D GetLastError();
> > +        if (err =3D=3D ERROR_INVALID_FUNCTION) {
> > +            return;
> > +        }
> > +        if (err =3D=3D ERROR_ENVVAR_NOT_FOUND) {
> > +            info->has_secure_boot =3D true;
> > +            info->secure_boot =3D false;
> > +            return;
> > +        }
> > +        error_setg_win32(errp, err,
> > +                         "failed to read SecureBoot UEFI variable");
> > +        return;
> > +    }
> > +
> > +    info->has_secure_boot =3D true;
> > +    info->secure_boot =3D (value =3D=3D 1);
>
> Is that comparison of 'value =3D=3D 1' definitely correct ?  My
> understanding was that secure boot state is indicated by the 5th byte
> in that EFI variable.
>

In MSFT sample
https://github.com/microsoft/Windows-universal-samples/blob/main/Samples/Cu=
stomCapability/Service/Client/uefi.cpp
the reverse logic is used.
But from our testing on Windows, this comparison is correct.


>
>
>
> > +}
> > +
> > +/*
> > + * Query Win32_Tpm WMI class for TPM presence and version.
> > + */
> > +static void get_tpm_info(GuestSecurityInfo *info, Error **errp)
> > +{
> > +    Error *local_err =3D NULL;
> > +    IWbemServices *services =3D NULL;
> > +    IEnumWbemClassObject *enumerator =3D NULL;
> > +    IWbemClassObject *obj =3D NULL;
> > +    ULONG count =3D 0;
> > +    HRESULT hr;
> > +    VARIANT var;
> > +
> > +    services =3D wmi_connect_to_namespace(
> > +        L"ROOT\\CIMV2\\Security\\MicrosoftTpm", &local_err);
> > +    if (!services) {
> > +        /* TPM namespace may not exist -- field omitted (unknown) */
> > +        error_free(local_err);
> > +        return;
> > +    }
> > +
> > +    enumerator =3D wmi_exec_query(services,
> > +        L"SELECT * FROM Win32_Tpm", &local_err);
> > +    if (!enumerator) {
> > +        error_free(local_err);
> > +        goto out;
> > +    }
> > +
> > +    hr =3D enumerator->lpVtbl->Next(enumerator, WBEM_INFINITE, 1,
> > +                                   &obj, &count);
> > +    if (FAILED(hr) || count =3D=3D 0) {
> > +        info->has_tpm_present =3D true;
> > +        info->tpm_present =3D false;
> > +        goto out;
> > +    }
> > +
> > +    info->has_tpm_present =3D true;
> > +    info->tpm_present =3D true;
> > +
> > +    VariantInit(&var);
> > +    if (SUCCEEDED(wmi_get_property(obj, L"SpecVersion", &var)) &&
> > +        V_VT(&var) =3D=3D VT_BSTR && V_BSTR(&var)) {
> > +        info->tpm_version =3D g_utf16_to_utf8(
> > +            (const gunichar2 *)V_BSTR(&var), -1, NULL, NULL, NULL);
> > +        if (info->tpm_version) {
> > +            /* keep only the part before the first comma */
> > +            char *comma =3D strchr(info->tpm_version, ',');
>
> It would be helpful if the comment included a full example string
> from "SpecVersion", so we can see what we're parsing here.
>
> > +            if (comma) {
> > +                *comma =3D '\0';
> > +            }
> > +        }
> > +    }
> > +    VariantClear(&var);
>
>
> > diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
> > index c57bc9a02f..2247f77cff 100644
> > --- a/qga/qapi-schema.json
> > +++ b/qga/qapi-schema.json
> > @@ -1490,6 +1490,8 @@
> >  #     * POSIX: as defined by os-release(5)
> >  #     * Windows: contains string "server" or "client"
> >  #
> > +# @security: Security features status (since 10.3)
> > +#
> >  # .. note:: On POSIX systems the fields @id, @name, @pretty-name,
> >  #    @version, @version-id, @variant and @variant-id follow the
> >  #    definition specified in os-release(5).  Refer to the manual page
> > @@ -1508,7 +1510,8 @@
> >        '*kernel-release': 'str', '*kernel-version': 'str',
> >        '*machine': 'str', '*id': 'str', '*name': 'str',
> >        '*pretty-name': 'str', '*version': 'str', '*version-id': 'str',
> > -      '*variant': 'str', '*variant-id': 'str' } }
> > +      '*variant': 'str', '*variant-id': 'str',
> > +      '*security': 'GuestSecurityInfo' } }
> >
> >  ##
> >  # @guest-get-osinfo:
> > @@ -1952,3 +1955,89 @@
> >    'returns': ['GuestNetworkRoute'],
> >    'if': { 'any': ['CONFIG_LINUX', 'CONFIG_WIN32'] }
> >  }
> > +
> > +##
> > +# @GuestSecurityInfoWindows:
> > +#
> > +# Windows-specific security features from Win32_DeviceGuard.
> > +#
> > +# @vbs-status: VirtualizationBasedSecurityStatus
> > +#
> > +# @available-security-properties:
> > +#     AvailableSecurityProperties
> > +#
> > +# @code-integrity-policy-enforcement-status:
> > +#     CodeIntegrityPolicyEnforcementStatus
> > +#
> > +# @required-security-properties: RequiredSecurityProperties
> > +#
> > +# @security-services-configured:
> > +#     SecurityServicesConfigured
> > +#
> > +# @security-services-running: SecurityServicesRunning
> > +#
> > +# @usr-cfg-code-integrity-policy-enforcement-status:
> > +#     UsermodeCodeIntegrityPolicyEnforcementStatus
>
> None of these docs are actually useful. Can you explain in plain
> language what they each mean.
>
> > +#
> > +# Since: 10.3
> > +##
> > +{ 'struct': 'GuestSecurityInfoWindows',
> > +  'data': {
> > +      '*vbs-status': 'int',
> > +      '*available-security-properties': ['int'],
> > +      '*code-integrity-policy-enforcement-status': 'int',
> > +      '*required-security-properties': ['int'],
> > +      '*security-services-configured': ['int'],
> > +      '*security-services-running': ['int'],
> > +      '*usr-cfg-code-integrity-policy-enforcement-status':
> > +          'int' } }
>
> I'm guessing there that the are all largely reflecting enumerated
> values from the Windows API. I'm wondering how they will be
> consumed by whatever calls this command. Would they be better off
> as enums, instead of plain ints, or arrays of ints ?
>

There is no any existing enum in the Win32 API, as I know.
If we introduce it, we should care about any updates from the MSFT side.
Explanation of these numbers
https://learn.microsoft.com/en-us/windows/security/hardware-security/enable=
-virtualization-based-protection-of-code-integrity?tabs=3Dsecurity

looks complicated, and I am not sure whether it is better to return
"HardwareEnforcedStackProtectionInAuditMode" is better than 6.

Currently, QGA returns data in the same format as MSFT provides it.
I think the management system should make a decision based on this.


>
> > +
> > +##
> > +# @GuestSecurityInfoType:
> > +#
> > +# Guest operating system type for security info.
> > +#
> > +# @windows: Microsoft Windows
> > +#
> > +# Since: 10.3
> > +##
> > +{ 'enum': 'GuestSecurityInfoType',
> > +  'data': ['windows'] }
> > +
> > +##
> > +# @GuestSecurityInfoOs:
> > +#
> > +# OS-specific security information.
> > +#
> > +# @type: guest operating system type
> > +#
> > +# Since: 10.3
> > +##
> > +{ 'union': 'GuestSecurityInfoOs',
> > +  'base': { 'type': 'GuestSecurityInfoType' },
> > +  'discriminator': 'type',
> > +  'data': {
> > +      'windows': 'GuestSecurityInfoWindows' } }
> > +
> > +##
> > +# @GuestSecurityInfo:
> > +#
> > +# Guest security features status.  Fields are optional; a missing
> > +# field means the information is not available on this platform.
> > +#
> > +# @tpm-present: Whether a TPM device is present
> > +#
> > +# @tpm-version: TPM specification version (e.g. "2.0")
> > +#
> > +# @secure-boot: Whether UEFI Secure Boot is enabled
> > +#
> > +# @os: OS-specific security information
> > +#
> > +# Since: 10.3
> > +##
> > +{ 'struct': 'GuestSecurityInfo',
> > +  'data': {
> > +      '*tpm-present': 'bool',
> > +      '*tpm-version': 'str',
>
> Should we have a GuestSecurityTPMInfo struct ?
>
>     '*tpm': 'GuestSecurityTPMInfo'
>
> We would not need a "present" value, as the mere existence of the struct
> data would indicate presence. Meanwhile this struct would contain a
> mandatory version field:
>
>    { 'struct': 'GuestSecurityTPMInfo',
>      'data': {
>          'major-version': 'int'
>      }
>    }
>
> I suggest only reporting major version, as an int, not an arbitrary
> string as that's ambiguous IMHO.  We could later add other TPM info
> to this struct if needed.
>
> For Linux you can provide this TPM info by checking whether
> /sys/class/tpm/tpm0 exists, and reading
> /sys/class/tpm/tpm0/tpm_version_major
>
> > +      '*secure-boot': 'bool',
>
> For Linux you can provide this secureboot info by reading
> /sys/firmware/efi/efivars/SecureBoot-8be4df61-93ca-11d2-aa0d-00e098032b8c
>
> This bool only tells us whether secureboot is enabled or not. I wonder
> if we should allow for other info here too. Systemd's bootctl reads
> various other secureboot fields "AuditMode", "DeployedMode", 'SetupMode'
> and 'MokSBStateRT'.
>
> https://github.com/systemd/systemd/blob/main/src/basic/efivars.c#L381
>
> We could represent each as bools within a struct, eg
>
>   '*secure-boot': 'GuestSecuritySecureBootInfo'
>
> which would have several mandatory fields
>
>    { 'struct': 'GuestSecuritySecureBootInfo',
>      'data': {
>          'enabled': 'bool',
>          'audit-mode': 'bool',
>          'deployed-mode': 'bool',
>          'setup-mode': 'bool',
>          'mok-sb-state': 'bool',
>

Any real use cases for all other fields?
Or just get it because all of them are related to SB?


>      }
>    }
>
> These are again all available from EFI variables in sysfs, or the
> equivalent API you have already used on Windows.
>
> Any missing variable can be assumed "false", or we would make all
> the variables except 'enabled' be optional.
>
> > +      '*os': 'GuestSecurityInfoOs' } }
>
> With regards,
> Daniel
> --
> |: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
> |: https://libvirt.org          ~~          https://entangle-photo.org :|
> |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|
>
>

--0000000000005c574b064e517a8e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div><br clear=3D"all"></div><div><div di=
r=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><div>Best Regards,</di=
v><div>Kostiantyn Kostiuk.</div></div></div></div><br></div><br><div class=
=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr=
">On Tue, Mar 31, 2026 at 3:08=E2=80=AFPM Daniel P. Berrang=C3=A9 &lt;<a hr=
ef=3D"mailto:berrange@redhat.com">berrange@redhat.com</a>&gt; wrote:<br></d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bord=
er-left:1px solid rgb(204,204,204);padding-left:1ex">On Mon, Mar 30, 2026 a=
t 06:19:41PM +0300, Elizabeth Ashurov wrote:<br>
&gt; Extend guest-get-osinfo to include security features status<br>
&gt; (VBS, Secure Boot, TPM) in a nested &#39;security&#39; field.<br>
&gt; OS-specific data (e.g. Windows DeviceGuard) is separated<br>
&gt; using a union to allow future per-OS extensions.<br>
&gt; <br>
&gt; The implementation queries Win32_DeviceGuard and Win32_Tpm via<br>
&gt; WMI, and reads the SecureBoot UEFI variable through<br>
&gt; GetFirmwareEnvironmentVariable().<br>
&gt; <br>
&gt; Signed-off-by: Elizabeth Ashurov &lt;<a href=3D"mailto:eashurov@redhat=
.com" target=3D"_blank">eashurov@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 qga/commands-win32.c | 421 +++++++++++++++++++++++++++++++++++++=
++++++<br>
<br>
This should also provide a Linux impl for the TPM and secureboot info as<br=
>
that is platform portable and easily available.<br>
<br>
&gt;=C2=A0 qga/qapi-schema.json |=C2=A0 91 +++++++++-<br>
&gt;=C2=A0 2 files changed, 511 insertions(+), 1 deletion(-)<br>
<br>
&gt; +<br>
&gt; +/*<br>
&gt; + * Read the SecureBoot UEFI variable.=C2=A0 On legacy BIOS systems th=
e field<br>
&gt; + * is omitted (not applicable).<br>
&gt; + */<br>
&gt; +static void get_secure_boot_status(GuestSecurityInfo *info,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Error **errp)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 Error *local_err =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 BYTE value =3D 0;<br>
&gt; +=C2=A0 =C2=A0 DWORD ret;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 acquire_privilege(SE_SYSTEM_ENVIRONMENT_NAME, &amp;loca=
l_err);<br>
&gt; +=C2=A0 =C2=A0 if (local_err) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_propagate(errp, local_err);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 ret =3D GetFirmwareEnvironmentVariableA(&quot;SecureBoo=
t&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;{8be4df61-93ca-11d2-aa0d-00e098032b=
8c}&quot;, &amp;value, sizeof(value));<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (ret =3D=3D 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 DWORD err =3D GetLastError();<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (err =3D=3D ERROR_INVALID_FUNCTION) {<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (err =3D=3D ERROR_ENVVAR_NOT_FOUND) {<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 info-&gt;has_secure_boot =
=3D true;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 info-&gt;secure_boot =3D fa=
lse;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg_win32(errp, err,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0&quot;failed to read SecureBoot UEFI variable&quot;);<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 info-&gt;has_secure_boot =3D true;<br>
&gt; +=C2=A0 =C2=A0 info-&gt;secure_boot =3D (value =3D=3D 1);<br>
<br>
Is that comparison of &#39;value =3D=3D 1&#39; definitely correct ?=C2=A0 M=
y<br>
understanding was that secure boot state is indicated by the 5th byte<br>
in that EFI variable.<br></blockquote><div><br></div><div>In MSFT sample=C2=
=A0<a href=3D"https://github.com/microsoft/Windows-universal-samples/blob/m=
ain/Samples/CustomCapability/Service/Client/uefi.cpp">https://github.com/mi=
crosoft/Windows-universal-samples/blob/main/Samples/CustomCapability/Servic=
e/Client/uefi.cpp</a><br></div><div>the reverse logic is used.=C2=A0<br></d=
iv><div>But from our testing on Windows, this=C2=A0comparison is correct.=
=C2=A0</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">
<br>
<br>
<br>
&gt; +}<br>
&gt; +<br>
&gt; +/*<br>
&gt; + * Query Win32_Tpm WMI class for TPM presence and version.<br>
&gt; + */<br>
&gt; +static void get_tpm_info(GuestSecurityInfo *info, Error **errp)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 Error *local_err =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 IWbemServices *services =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 IEnumWbemClassObject *enumerator =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 IWbemClassObject *obj =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 ULONG count =3D 0;<br>
&gt; +=C2=A0 =C2=A0 HRESULT hr;<br>
&gt; +=C2=A0 =C2=A0 VARIANT var;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 services =3D wmi_connect_to_namespace(<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 L&quot;ROOT\\CIMV2\\Security\\MicrosoftTp=
m&quot;, &amp;local_err);<br>
&gt; +=C2=A0 =C2=A0 if (!services) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* TPM namespace may not exist -- field o=
mitted (unknown) */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_free(local_err);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 enumerator =3D wmi_exec_query(services,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 L&quot;SELECT * FROM Win32_Tpm&quot;, &am=
p;local_err);<br>
&gt; +=C2=A0 =C2=A0 if (!enumerator) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_free(local_err);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 hr =3D enumerator-&gt;lpVtbl-&gt;Next(enumerator, WBEM_=
INFINITE, 1,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;obj, &amp;coun=
t);<br>
&gt; +=C2=A0 =C2=A0 if (FAILED(hr) || count =3D=3D 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 info-&gt;has_tpm_present =3D true;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 info-&gt;tpm_present =3D false;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 info-&gt;has_tpm_present =3D true;<br>
&gt; +=C2=A0 =C2=A0 info-&gt;tpm_present =3D true;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 VariantInit(&amp;var);<br>
&gt; +=C2=A0 =C2=A0 if (SUCCEEDED(wmi_get_property(obj, L&quot;SpecVersion&=
quot;, &amp;var)) &amp;&amp;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 V_VT(&amp;var) =3D=3D VT_BSTR &amp;&amp; =
V_BSTR(&amp;var)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 info-&gt;tpm_version =3D g_utf16_to_utf8(=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (const gunichar2 *)V_BSTR(&=
amp;var), -1, NULL, NULL, NULL);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (info-&gt;tpm_version) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* keep only the part befor=
e the first comma */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 char *comma =3D strchr(info=
-&gt;tpm_version, &#39;,&#39;);<br>
<br>
It would be helpful if the comment included a full example string<br>
from &quot;SpecVersion&quot;, so we can see what we&#39;re parsing here.<br=
>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (comma) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *comma =3D &#=
39;\0&#39;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 VariantClear(&amp;var);<br>
<br>
<br>
&gt; diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json<br>
&gt; index c57bc9a02f..2247f77cff 100644<br>
&gt; --- a/qga/qapi-schema.json<br>
&gt; +++ b/qga/qapi-schema.json<br>
&gt; @@ -1490,6 +1490,8 @@<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0* POSIX: as defined by os-release(5)<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0* Windows: contains string &quot;server&quo=
t; or &quot;client&quot;<br>
&gt;=C2=A0 #<br>
&gt; +# @security: Security features status (since 10.3)<br>
&gt; +#<br>
&gt;=C2=A0 # .. note:: On POSIX systems the fields @id, @name, @pretty-name=
,<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 @version, @version-id, @variant and @variant-id f=
ollow the<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 definition specified in os-release(5).=C2=A0 Refe=
r to the manual page<br>
&gt; @@ -1508,7 +1510,8 @@<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;*kernel-release&#39;: &#39;str&#39;, &=
#39;*kernel-version&#39;: &#39;str&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;*machine&#39;: &#39;str&#39;, &#39;*id=
&#39;: &#39;str&#39;, &#39;*name&#39;: &#39;str&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;*pretty-name&#39;: &#39;str&#39;, &#39=
;*version&#39;: &#39;str&#39;, &#39;*version-id&#39;: &#39;str&#39;,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 &#39;*variant&#39;: &#39;str&#39;, &#39;*variant=
-id&#39;: &#39;str&#39; } }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 &#39;*variant&#39;: &#39;str&#39;, &#39;*variant=
-id&#39;: &#39;str&#39;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 &#39;*security&#39;: &#39;GuestSecurityInfo&#39;=
 } }<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 ##<br>
&gt;=C2=A0 # @guest-get-osinfo:<br>
&gt; @@ -1952,3 +1955,89 @@<br>
&gt;=C2=A0 =C2=A0 &#39;returns&#39;: [&#39;GuestNetworkRoute&#39;],<br>
&gt;=C2=A0 =C2=A0 &#39;if&#39;: { &#39;any&#39;: [&#39;CONFIG_LINUX&#39;, &=
#39;CONFIG_WIN32&#39;] }<br>
&gt;=C2=A0 }<br>
&gt; +<br>
&gt; +##<br>
&gt; +# @GuestSecurityInfoWindows:<br>
&gt; +#<br>
&gt; +# Windows-specific security features from Win32_DeviceGuard.<br>
&gt; +#<br>
&gt; +# @vbs-status: VirtualizationBasedSecurityStatus<br>
&gt; +#<br>
&gt; +# @available-security-properties:<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0AvailableSecurityProperties<br>
&gt; +#<br>
&gt; +# @code-integrity-policy-enforcement-status:<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0CodeIntegrityPolicyEnforcementStatus<br>
&gt; +#<br>
&gt; +# @required-security-properties: RequiredSecurityProperties<br>
&gt; +#<br>
&gt; +# @security-services-configured:<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0SecurityServicesConfigured<br>
&gt; +#<br>
&gt; +# @security-services-running: SecurityServicesRunning<br>
&gt; +#<br>
&gt; +# @usr-cfg-code-integrity-policy-enforcement-status:<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0UsermodeCodeIntegrityPolicyEnforcementStatus<br>
<br>
None of these docs are actually useful. Can you explain in plain<br>
language what they each mean.<br>
<br>
&gt; +#<br>
&gt; +# Since: 10.3<br>
&gt; +##<br>
&gt; +{ &#39;struct&#39;: &#39;GuestSecurityInfoWindows&#39;,<br>
&gt; +=C2=A0 &#39;data&#39;: {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 &#39;*vbs-status&#39;: &#39;int&#39;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 &#39;*available-security-properties&#39;: [&#39;=
int&#39;],<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 &#39;*code-integrity-policy-enforcement-status&#=
39;: &#39;int&#39;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 &#39;*required-security-properties&#39;: [&#39;i=
nt&#39;],<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 &#39;*security-services-configured&#39;: [&#39;i=
nt&#39;],<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 &#39;*security-services-running&#39;: [&#39;int&=
#39;],<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 &#39;*usr-cfg-code-integrity-policy-enforcement-=
status&#39;:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;int&#39; } }<br>
<br>
I&#39;m guessing there that the are all largely reflecting enumerated<br>
values from the Windows API. I&#39;m wondering how they will be<br>
consumed by whatever calls this command. Would they be better off<br>
as enums, instead of plain ints, or arrays of ints ?<br></blockquote><div><=
br></div><div>There is no any existing enum in=C2=A0the Win32 API, as I kno=
w.<br></div><div>If we introduce it, we should care about any updates from =
the MSFT side.</div><div>Explanation of these numbers=C2=A0<a href=3D"https=
://learn.microsoft.com/en-us/windows/security/hardware-security/enable-virt=
ualization-based-protection-of-code-integrity?tabs=3Dsecurity">https://lear=
n.microsoft.com/en-us/windows/security/hardware-security/enable-virtualizat=
ion-based-protection-of-code-integrity?tabs=3Dsecurity</a>=C2=A0</div><div>=
looks complicated, and I am not sure whether it is=C2=A0better to return=C2=
=A0</div><div>&quot;HardwareEnforcedStackProtectionInAuditMode&quot; is bet=
ter than 6.<br><br></div><div>Currently, QGA returns data in the same forma=
t as MSFT provides=C2=A0it.<br></div><div>I think the management system sho=
uld make a decision based on this.</div><div>=C2=A0</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
<br>
&gt; +<br>
&gt; +##<br>
&gt; +# @GuestSecurityInfoType:<br>
&gt; +#<br>
&gt; +# Guest operating system type for security info.<br>
&gt; +#<br>
&gt; +# @windows: Microsoft Windows<br>
&gt; +#<br>
&gt; +# Since: 10.3<br>
&gt; +##<br>
&gt; +{ &#39;enum&#39;: &#39;GuestSecurityInfoType&#39;,<br>
&gt; +=C2=A0 &#39;data&#39;: [&#39;windows&#39;] }<br>
&gt; +<br>
&gt; +##<br>
&gt; +# @GuestSecurityInfoOs:<br>
&gt; +#<br>
&gt; +# OS-specific security information.<br>
&gt; +#<br>
&gt; +# @type: guest operating system type<br>
&gt; +#<br>
&gt; +# Since: 10.3<br>
&gt; +##<br>
&gt; +{ &#39;union&#39;: &#39;GuestSecurityInfoOs&#39;,<br>
&gt; +=C2=A0 &#39;base&#39;: { &#39;type&#39;: &#39;GuestSecurityInfoType&#=
39; },<br>
&gt; +=C2=A0 &#39;discriminator&#39;: &#39;type&#39;,<br>
&gt; +=C2=A0 &#39;data&#39;: {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 &#39;windows&#39;: &#39;GuestSecurityInfoWindows=
&#39; } }<br>
&gt; +<br>
&gt; +##<br>
&gt; +# @GuestSecurityInfo:<br>
&gt; +#<br>
&gt; +# Guest security features status.=C2=A0 Fields are optional; a missin=
g<br>
&gt; +# field means the information is not available on this platform.<br>
&gt; +#<br>
&gt; +# @tpm-present: Whether a TPM device is present<br>
&gt; +#<br>
&gt; +# @tpm-version: TPM specification version (e.g. &quot;2.0&quot;)<br>
&gt; +#<br>
&gt; +# @secure-boot: Whether UEFI Secure Boot is enabled<br>
&gt; +#<br>
&gt; +# @os: OS-specific security information<br>
&gt; +#<br>
&gt; +# Since: 10.3<br>
&gt; +##<br>
&gt; +{ &#39;struct&#39;: &#39;GuestSecurityInfo&#39;,<br>
&gt; +=C2=A0 &#39;data&#39;: {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 &#39;*tpm-present&#39;: &#39;bool&#39;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 &#39;*tpm-version&#39;: &#39;str&#39;,<br>
<br>
Should we have a GuestSecurityTPMInfo struct ?<br>
<br>
=C2=A0 =C2=A0 &#39;*tpm&#39;: &#39;GuestSecurityTPMInfo&#39;<br>
<br>
We would not need a &quot;present&quot; value, as the mere existence of the=
 struct<br>
data would indicate presence. Meanwhile this struct would contain a<br>
mandatory version field:<br>
<br>
=C2=A0 =C2=A0{ &#39;struct&#39;: &#39;GuestSecurityTPMInfo&#39;,<br>
=C2=A0 =C2=A0 =C2=A0&#39;data&#39;: {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;major-version&#39;: &#39;int&#39;<br=
>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0}<br>
<br>
I suggest only reporting major version, as an int, not an arbitrary<br>
string as that&#39;s ambiguous IMHO.=C2=A0 We could later add other TPM inf=
o<br>
to this struct if needed.<br>
<br>
For Linux you can provide this TPM info by checking whether<br>
/sys/class/tpm/tpm0 exists, and reading /sys/class/tpm/tpm0/tpm_version_maj=
or<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 &#39;*secure-boot&#39;: &#39;bool&#39;,<br>
<br>
For Linux you can provide this secureboot info by reading<br>
/sys/firmware/efi/efivars/SecureBoot-8be4df61-93ca-11d2-aa0d-00e098032b8c<b=
r>
<br>
This bool only tells us whether secureboot is enabled or not. I wonder<br>
if we should allow for other info here too. Systemd&#39;s bootctl reads<br>
various other secureboot fields &quot;AuditMode&quot;, &quot;DeployedMode&q=
uot;, &#39;SetupMode&#39;<br>
and &#39;MokSBStateRT&#39;.<br>
<br>
<a href=3D"https://github.com/systemd/systemd/blob/main/src/basic/efivars.c=
#L381" rel=3D"noreferrer" target=3D"_blank">https://github.com/systemd/syst=
emd/blob/main/src/basic/efivars.c#L381</a><br>
<br>
We could represent each as bools within a struct, eg<br>
<br>
=C2=A0 &#39;*secure-boot&#39;: &#39;GuestSecuritySecureBootInfo&#39;<br>
<br>
which would have several mandatory fields<br>
<br>
=C2=A0 =C2=A0{ &#39;struct&#39;: &#39;GuestSecuritySecureBootInfo&#39;,<br>
=C2=A0 =C2=A0 =C2=A0&#39;data&#39;: {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;enabled&#39;: &#39;bool&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;audit-mode&#39;: &#39;bool&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;deployed-mode&#39;: &#39;bool&#39;,<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;setup-mode&#39;: &#39;bool&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;mok-sb-state&#39;: &#39;bool&#39;,<b=
r></blockquote><div><br></div><div>Any real use cases for all other fields?=
=C2=A0</div><div>Or just get it because all of them are related to SB?</div=
><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0}<br>
<br>
These are again all available from EFI variables in sysfs, or the<br>
equivalent API you have already used on Windows.<br>
<br>
Any missing variable can be assumed &quot;false&quot;, or we would make all=
<br>
the variables except &#39;enabled&#39; be optional.<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 &#39;*os&#39;: &#39;GuestSecurityInfoOs&#39; } }=
<br>
<br>
With regards,<br>
Daniel<br>
-- <br>
|: <a href=3D"https://berrange.com" rel=3D"noreferrer" target=3D"_blank">ht=
tps://berrange.com</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0~~=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 <a href=3D"https://hachyderm.io/@berrange" rel=3D"noreferrer" target=3D=
"_blank">https://hachyderm.io/@berrange</a> :|<br>
|: <a href=3D"https://libvirt.org" rel=3D"noreferrer" target=3D"_blank">htt=
ps://libvirt.org</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ~~=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 <a href=3D"https://entangle-photo.org" rel=3D"noreferrer"=
 target=3D"_blank">https://entangle-photo.org</a> :|<br>
|: <a href=3D"https://pixelfed.art/berrange" rel=3D"noreferrer" target=3D"_=
blank">https://pixelfed.art/berrange</a>=C2=A0 =C2=A0~~=C2=A0 =C2=A0 <a hre=
f=3D"https://fstop138.berrange.com" rel=3D"noreferrer" target=3D"_blank">ht=
tps://fstop138.berrange.com</a> :|<br>
<br>
</blockquote></div></div>

--0000000000005c574b064e517a8e--


