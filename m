Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED9F1FD877B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 14:09:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2V5x-0006Ni-GF; Tue, 17 Mar 2026 10:08:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1w2V5q-0006MI-3f
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 10:08:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1w2V5l-000618-Nj
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 10:08:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773756495;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CXuEFuKxKOf1n9AWSmJS66yd7c7oRKnUjdNpsGMQPkE=;
 b=dxamk78tfgioHwuW/goe/2TBcLJL4k2AyfsxzQiOuomX7AItuUKFTvqoroog9tFDMtYwRR
 7EqdmEh4IBJkxR+HWbPubZ7411dtOqHbdiGrbrs//v7Cz9n6SwwyNYG7SDyIfFTS+kcNXk
 mYbrl0BBmXJwZK2FpjR8k/KM32DgR7g=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-408-z7_fTDeHMVeDXDC6k3Lt4Q-1; Tue, 17 Mar 2026 10:08:14 -0400
X-MC-Unique: z7_fTDeHMVeDXDC6k3Lt4Q-1
X-Mimecast-MFC-AGG-ID: z7_fTDeHMVeDXDC6k3Lt4Q_1773756492
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-89a0013d87bso942903516d6.2
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 07:08:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773756492; cv=none;
 d=google.com; s=arc-20240605;
 b=f9cb61PcQl16xFeNvL41lO6gLkZe2BPBH4Stk9+wodto6ktCiTD13oi7yI+fL4JRTF
 aVfO6GEpBIXQWkU3wjAz+ICHFbdi7yl4kwAAVxNlmkKFPqUS5Jn4CayXCVg1PZlY1oa+
 dd9w5OFDaunQVodwoBwFVWJNJ05fGTfPF2+zeaiD5iICW27EmfunGFF89SgpK0hWjPWh
 uFat31wb+iszGaDfxws3RhRiWvMQJGFN+VuMn4brJsombyPIM32Ww4BdsokdkfOCD9Ai
 JZbC6B0RibYVIjpN325f6oau0774irs7QpFVViL8CcdPnZ9qynQV5M8F7L0q29RatTno
 bn7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=CXuEFuKxKOf1n9AWSmJS66yd7c7oRKnUjdNpsGMQPkE=;
 fh=wZGJy6Be4bECC4yB2hGbYRgyOcM+26fIztlsf0/LmxA=;
 b=Oby5JL3/+g1flDotnpCmlio9ZswNXqQeHEA6GEm8+1MMjw1YGKvA/R/rLhtp5P1VBW
 ikrcaYfk/lnvksirbbD9Gi4BeW/r9KmAOUI6ikWJv2Gvhs6mXdKoq8zyYk0m6ljZDOtj
 0DA/7DKKt0tP3l6cg/aDqHLolhA4l1tNIYQHqKz/YJlnHshhCHfumelIaPUsr7NXZDt4
 tqVckX7NkYZENbyylqOeB16U9OqUokI/uhFpjXosS/iRM3oN20wk7mJmPWWCCAdIDEss
 Mn4ynUzMelqNvZB7180klBD/P5wngCKv6ixOzgxj9990fIGke+RtTExrHgP6ORPgkMNv
 397A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773756492; x=1774361292; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CXuEFuKxKOf1n9AWSmJS66yd7c7oRKnUjdNpsGMQPkE=;
 b=XV7Fq9QGhSQcNafJOy/oTE8SglFBdvkFbAUu/bezWNrtCDsQcC2pE0I0EwUvX7pvSb
 oIqT/c2Cr0rW0ruygIFA9E28KWuhNX38mgBlHWaMXPznW4Ix9wUn87akjK9kAz9Hm9iC
 rsBTC7E+HZjddf4eRCUN8uX+M2NPklZXAcboBZDf4rG8WzQtFx4hRg7BgwzUpQBeMJHk
 DSXCeQEGHk/D1Qxfj/FRZpl2k6O5FBVGn/MVy9n03BnO6s7tQJObX8f0THS9Fuw/PniQ
 sm/OuNCMSEXPZpOjEhhyeHc5CZ0I0FYL5lHW2iwkWbbGQAnXdTgbLMiq5p0hxDWLocAr
 sdzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773756492; x=1774361292;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CXuEFuKxKOf1n9AWSmJS66yd7c7oRKnUjdNpsGMQPkE=;
 b=S9A3F/+AEuZrNcT7feZGLy7IxfZYpxdlXCrwiG/0i+d5qlD7QWmjgK0/Gyf9g0w2rY
 4+13H5xgvQ6YBiQNSeWbzmQJgiJNYYkuTNz3ERFC9nXIumPEK4T9xQbFU/VkPgdQRFJs
 1wDaV94RMCFLxb4NA+UcwPOAUCmZkTRtuHU4xJj1izC7g/OBseJE8KSCHVLnjwAzflIN
 +GS+0FIvBUJ53lc4LM+JK/euXGvRUItjU0FT+0EdEr5qdS5SzLogcNrUmF4OYnUfe+Tx
 7KwDdwcGWwrW6dO3IJDzKudkWmywMoGoWMY35mPBhTCBZd6B6drEF6LgfAijTv2cy0Zr
 +AeA==
X-Gm-Message-State: AOJu0YwAvM4/+xUR5LJE+8Q95kL+3EhcN5xR8Dz888dCEy0tpNltCm2W
 p/t2u8Sr44kXpa16Pynn56V9WTi5YvzeV8/sgVjrQoA8Q7Mr7mw6QXONZgXBuwsbttKYP8P21zZ
 10eprG9VkFQYJT2hJamjmS0JbTr9ISsHsIkzn93j5jVBgErjy+rJHvIIm0VNHvIg+zDsTBdhwLt
 8WiJustu5171aS7inJk2l2k6m1GjtXXR8=
X-Gm-Gg: ATEYQzzv/wcnSxIX3fem24Js1hjmoWEXAnI5j133NthI8lkZ1vfAU94QH+sp8KALQIj
 53NcF8Ouf1+zmqs3jI1HAlG8ezfW/0mw7jKaZrltl/hcYBN+qWJwuMY+7GmCFCSwVdi2gttZ3Is
 igR+NiBg0ZJttmwIduMmLVXFfgODwV3XzMf8Obag0JlXP4MdSSkqsmI872ReQq5ROBk9X+ukyri
 ZxbFuZc
X-Received: by 2002:a05:6214:170c:b0:89c:3f38:a992 with SMTP id
 6a1803df08f44-89c3f38b699mr105931576d6.22.1773756492423; 
 Tue, 17 Mar 2026 07:08:12 -0700 (PDT)
X-Received: by 2002:a05:6214:170c:b0:89c:3f38:a992 with SMTP id
 6a1803df08f44-89c3f38b699mr105930996d6.22.1773756491844; Tue, 17 Mar 2026
 07:08:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260316123144.1758888-1-eashurov@redhat.com>
In-Reply-To: <20260316123144.1758888-1-eashurov@redhat.com>
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Date: Tue, 17 Mar 2026 16:07:59 +0200
X-Gm-Features: AaiRm50vIJtbKV9c2vwCTOCezpUsmMGUJDFGnDHrgjqB2n87dKK6BRG0H8I3ycY
Message-ID: <CAPMcbCr1XmSnHG_KUvDekU=OzKWhuD7=PjHcxB6VmCYrZCqY4Q@mail.gmail.com>
Subject: Re: [PATCH v1] qga: add guest-get-windows-security-info command
To: Elizabeth Ashurov <eashurov@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Yan Vugenfirer <yvugenfi@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000009d6b3b064d38ddda"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_PASS=-0.001,
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

--0000000000009d6b3b064d38ddda
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 16, 2026 at 2:32=E2=80=AFPM Elizabeth Ashurov <eashurov@redhat.=
com>
wrote:

> Add a new Windows-only QGA command to retrieve Windows security
> features status including VBS, Secure Boot, and TPM information
> from the guest.
>
> The implementation queries Win32_DeviceGuard and Win32_Tpm via
> WMI, and reads the SecureBoot UEFI variable through
> GetFirmwareEnvironmentVariable().
>
> Signed-off-by: Elizabeth Ashurov <eashurov@redhat.com>
> ---
>  qga/commands-win32.c | 404 +++++++++++++++++++++++++++++++++++++++++++
>  qga/qapi-schema.json |  56 ++++++
>  2 files changed, 460 insertions(+)
>
> diff --git a/qga/commands-win32.c b/qga/commands-win32.c
> index c0bf3467bd..8da9ef521f 100644
> --- a/qga/commands-win32.c
> +++ b/qga/commands-win32.c
> @@ -28,6 +28,7 @@
>  #include <wtsapi32.h>
>  #include <wininet.h>
>  #include <pdh.h>
> +#include <wbemidl.h>
>
>  #include "guest-agent-core.h"
>  #include "vss-win32.h"
> @@ -2764,3 +2765,406 @@ GuestNetworkRouteList
> *qmp_guest_network_get_route(Error **errp)
>      g_hash_table_destroy(interface_metric_cache);
>      return head;
>  }
> +
> +/*
> + * WMI GUIDs
> + */
> +static const GUID qga_CLSID_WbemLocator =3D {
> +    0x4590f811, 0x1d3a, 0x11d0,
> +    {0x89, 0x1f, 0x00, 0xaa, 0x00, 0x4b, 0x2e, 0x24}
> +};
> +static const GUID qga_IID_IWbemLocator =3D {
> +    0xdc12a687, 0x737f, 0x11cf,
> +    {0x88, 0x4d, 0x00, 0xaa, 0x00, 0x4b, 0x2e, 0x24}
> +};
> +
> +static IWbemServices *wmi_connect_to_namespace(const wchar_t
> *namespace_path,
> +                                               Error **errp)
> +{
> +    HRESULT hr;
> +    IWbemLocator *locator =3D NULL;
> +    IWbemServices *services =3D NULL;
> +    BSTR bstr_ns =3D SysAllocString(namespace_path);
> +
> +    if (!bstr_ns) {
> +        error_setg(errp, "failed to allocate WMI namespace string");
> +        return NULL;
> +    }
> +
> +    hr =3D CoCreateInstance(&qga_CLSID_WbemLocator, NULL,
> CLSCTX_INPROC_SERVER,
> +                          &qga_IID_IWbemLocator, (LPVOID *)&locator);
> +    if (FAILED(hr)) {
> +        error_setg_win32(errp, hr, "failed to create IWbemLocator");
> +        goto out;
> +    }
> +
> +    hr =3D locator->lpVtbl->ConnectServer(locator, bstr_ns, NULL, NULL,
> NULL,
> +                                        0, NULL, NULL, &services);
> +    if (FAILED(hr)) {
> +        error_setg_win32(errp, hr, "failed to connect to WMI namespace")=
;
> +        goto out;
> +    }
> +
> +    hr =3D CoSetProxyBlanket((IUnknown *)services,
> +                           RPC_C_AUTHN_WINNT, RPC_C_AUTHZ_NONE, NULL,
> +                           RPC_C_AUTHN_LEVEL_CALL,
> +                           RPC_C_IMP_LEVEL_IMPERSONATE,
> +                           NULL, EOAC_NONE);
> +    if (FAILED(hr)) {
> +        error_setg_win32(errp, hr, "failed to set WMI proxy blanket");
> +        services->lpVtbl->Release(services);
> +        services =3D NULL;
> +    }
> +
> +out:
> +    SysFreeString(bstr_ns);
> +    if (locator) {
> +        locator->lpVtbl->Release(locator);
> +    }
> +    return services;
> +}
> +
> +static IEnumWbemClassObject *wmi_exec_query(IWbemServices *services,
> +                                            const wchar_t *query,
> +                                            Error **errp)
> +{
> +    HRESULT hr;
> +    IEnumWbemClassObject *enumerator =3D NULL;
> +    BSTR bstr_wql =3D SysAllocString(L"WQL");
> +    BSTR bstr_query =3D SysAllocString(query);
> +
> +    if (!bstr_wql || !bstr_query) {
> +        error_setg(errp, "failed to allocate WMI query strings");
> +        goto out;
> +    }
> +
> +    hr =3D services->lpVtbl->ExecQuery(services, bstr_wql, bstr_query,
> +                                     WBEM_FLAG_RETURN_IMMEDIATELY |
> +                                     WBEM_FLAG_FORWARD_ONLY,
> +                                     NULL, &enumerator);
> +    if (FAILED(hr)) {
> +        error_setg_win32(errp, hr, "WMI query failed");
> +    }
> +
> +out:
> +    SysFreeString(bstr_wql);
> +    SysFreeString(bstr_query);
> +    return enumerator;
> +}
> +
> +static HRESULT wmi_get_property(IWbemClassObject *obj, const wchar_t
> *name,
> +                                VARIANT *var)
> +{
> +    return obj->lpVtbl->Get(obj, name, 0, var, NULL, NULL);
> +}
> +
> +/* Read a WMI integer property (VT_I4 or VT_UI4). */
> +static bool wmi_get_int_property(IWbemClassObject *obj,
> +                                 const wchar_t *name,
> +                                 int64_t *out)
> +{
> +    VARIANT var;
> +    bool ret =3D false;
> +
> +    VariantInit(&var);
> +    if (SUCCEEDED(wmi_get_property(obj, name, &var))) {
> +        if (V_VT(&var) =3D=3D VT_I4) {
> +            *out =3D V_I4(&var);
> +            ret =3D true;
> +        } else if (V_VT(&var) =3D=3D VT_UI4) {
> +            *out =3D V_UI4(&var);
> +            ret =3D true;
> +        }
> +    }
> +    VariantClear(&var);
> +    return ret;
> +}
> +
> +/* Read an integer SAFEARRAY WMI property into a QAPI intList. */
> +static bool wmi_safearray_to_int_list(IWbemClassObject *obj,
> +                                      const wchar_t *prop_name,
> +                                      intList **list)
> +{
> +    VARIANT var;
> +    HRESULT hr;
> +    LONG lb, ub, i;
> +    uint32_t *data =3D NULL;
> +
> +    VariantInit(&var);
> +    hr =3D wmi_get_property(obj, prop_name, &var);
> +    if (FAILED(hr) || V_VT(&var) =3D=3D VT_NULL) {
> +        VariantClear(&var);
> +        return false;
> +    }
> +
> +    if (!(V_VT(&var) & VT_ARRAY)) {
> +        VariantClear(&var);
> +        return false;
> +    }
> +
> +    SAFEARRAY *sa =3D V_ARRAY(&var);
> +    if (FAILED(SafeArrayGetLBound(sa, 1, &lb)) ||
> +        FAILED(SafeArrayGetUBound(sa, 1, &ub))) {
> +        VariantClear(&var);
> +        return false;
> +    }
> +
> +    if (FAILED(SafeArrayAccessData(sa, (void **)&data))) {
> +        VariantClear(&var);
> +        return false;
> +    }
> +
> +    intList **tail =3D list;
> +    for (i =3D 0; i <=3D ub - lb; i++) {
> +        QAPI_LIST_APPEND(tail, (int64_t)data[i]);
> +    }
> +
> +    SafeArrayUnaccessData(sa);
> +    VariantClear(&var);
> +    return true;
> +}
> +
> +/*
> + * Query Win32_DeviceGuard WMI class for VBS and related properties.
> + */
> +static void get_device_guard_info(GuestWindowsSecurityInfo *info,
> +                                  Error **errp)
> +{
> +    Error *local_err =3D NULL;
> +    IWbemServices *services =3D NULL;
> +    IEnumWbemClassObject *enumerator =3D NULL;
> +    IWbemClassObject *obj =3D NULL;
> +    ULONG count =3D 0;
> +    HRESULT hr;
> +    int64_t val;
> +
> +    services =3D wmi_connect_to_namespace(
> +        L"ROOT\\Microsoft\\Windows\\DeviceGuard", &local_err);
> +    if (!services) {
> +        error_propagate(errp, local_err);
> +        return;
> +    }
> +
> +    enumerator =3D wmi_exec_query(services,
> +        L"SELECT * FROM Win32_DeviceGuard", &local_err);
> +    if (!enumerator) {
> +        error_propagate(errp, local_err);
> +        goto out;
> +    }
> +
> +    hr =3D enumerator->lpVtbl->Next(enumerator, WBEM_INFINITE, 1,
> +                                   &obj, &count);
> +    if (FAILED(hr)) {
> +        error_setg_win32(errp, hr, "failed to enumerate
> Win32_DeviceGuard");
> +        goto out;
> +    }
> +    if (count =3D=3D 0) {
> +        error_setg(errp, "no Win32_DeviceGuard instance found");
> +        goto out;
> +    }
> +
> +    if (wmi_get_int_property(obj, L"VirtualizationBasedSecurityStatus",
> +                             &val)) {
> +        info->vbs_status =3D val;
> +    }
> +
> +    if (wmi_get_int_property(obj, L"CodeIntegrityPolicyEnforcementStatus=
",
> +                             &val)) {
> +        info->has_code_integrity_policy_enforcement_status =3D true;
> +        info->code_integrity_policy_enforcement_status =3D val;
> +    }
> +
> +    if (wmi_get_int_property(obj,
> +
>  L"UsermodeCodeIntegrityPolicyEnforcementStatus",
> +                             &val)) {
> +        info->has_usr_cfg_code_integrity_policy_enforcement_status =3D t=
rue;
> +        info->usr_cfg_code_integrity_policy_enforcement_status =3D val;
> +    }
> +
> +    if (wmi_safearray_to_int_list(obj, L"AvailableSecurityProperties",
> +                                  &info->available_security_properties))=
 {
> +        info->has_available_security_properties =3D true;
> +    }
> +
> +    if (wmi_safearray_to_int_list(obj, L"RequiredSecurityProperties",
> +                                  &info->required_security_properties)) =
{
> +        info->has_required_security_properties =3D true;
> +    }
> +
> +    if (wmi_safearray_to_int_list(obj, L"SecurityServicesConfigured",
> +                                  &info->security_services_configured)) =
{
> +        info->has_security_services_configured =3D true;
> +    }
> +
> +    if (wmi_safearray_to_int_list(obj, L"SecurityServicesRunning",
> +                                  &info->security_services_running)) {
> +        info->has_security_services_running =3D true;
> +    }
> +
> +    obj->lpVtbl->Release(obj);
> +    obj =3D NULL;
> +
> +    /* Drain remaining results */
> +    while (true) {
> +        hr =3D enumerator->lpVtbl->Next(enumerator, WBEM_INFINITE, 1,
> +                                      &obj, &count);
> +        if (FAILED(hr) || count =3D=3D 0) {
> +            break;
> +        }
> +        obj->lpVtbl->Release(obj);
> +        obj =3D NULL;
> +    }
> +
> +out:
> +    if (obj) {
> +        obj->lpVtbl->Release(obj);
> +    }
> +    if (enumerator) {
> +        enumerator->lpVtbl->Release(enumerator);
> +    }
> +    if (services) {
> +        services->lpVtbl->Release(services);
> +    }
> +}
> +
> +/*
> + * Read the SecureBoot UEFI variable to determine whether Secure Boot
> + * is enabled.  Returns false on legacy BIOS systems.
> + */
> +static bool get_secure_boot_status(Error **errp)
> +{
> +    Error *local_err =3D NULL;
> +    BYTE value =3D 0;
> +    DWORD ret;
> +
> +    acquire_privilege(SE_SYSTEM_ENVIRONMENT_NAME, &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        return false;
> +    }
> +
> +    ret =3D GetFirmwareEnvironmentVariableA("SecureBoot",
> +        "{8be4df61-93ca-11d2-aa0d-00e098032b8c}", &value, sizeof(value))=
;
>
+
> +    if (ret =3D=3D 0) {
> +        DWORD err =3D GetLastError();
> +        if (err =3D=3D ERROR_INVALID_FUNCTION || err =3D=3D
> ERROR_ENVVAR_NOT_FOUND) {
> +            return false;
> +        }
> +        error_setg_win32(errp, err,
> +                         "failed to read SecureBoot UEFI variable");
> +        return false;
> +    }
> +
> +    return value =3D=3D 1;
> +}
> +
> +/*
> + * Query Win32_Tpm WMI class for TPM presence and version.
> + */
> +static void get_tpm_info(GuestWindowsSecurityInfo *info, Error **errp)
> +{
> +    Error *local_err =3D NULL;
> +    IWbemServices *services =3D NULL;
> +    IEnumWbemClassObject *enumerator =3D NULL;
> +    IWbemClassObject *obj =3D NULL;
> +    ULONG count =3D 0;
> +    HRESULT hr;
> +    VARIANT var;
> +
> +    services =3D wmi_connect_to_namespace(
> +        L"ROOT\\CIMV2\\Security\\MicrosoftTpm", &local_err);
> +    if (!services) {
> +        /* TPM namespace may not exist -- not an error */
>
This is a case for the missing "tpm_present" field


> +        error_free(local_err);
> +        info->tpm_present =3D false;
> +        return;
> +    }
> +
> +    enumerator =3D wmi_exec_query(services,
> +        L"SELECT * FROM Win32_Tpm", &local_err);
> +    if (!enumerator) {
> +        error_free(local_err);
> +        info->tpm_present =3D false;
> +        goto out;
> +    }
> +
> +    hr =3D enumerator->lpVtbl->Next(enumerator, WBEM_INFINITE, 1,
> +                                   &obj, &count);
> +    if (FAILED(hr) || count =3D=3D 0) {
> +        info->tpm_present =3D false;
> +        goto out;
> +    }
> +
> +    info->tpm_present =3D true;
> +
> +    VariantInit(&var);
> +    if (SUCCEEDED(wmi_get_property(obj, L"SpecVersion", &var)) &&
> +        V_VT(&var) =3D=3D VT_BSTR && V_BSTR(&var)) {
> +        info->tpm_version =3D g_utf16_to_utf8(
> +            (const gunichar2 *)V_BSTR(&var), -1, NULL, NULL, NULL);
> +        if (info->tpm_version) {
> +            /* keep only the part before the first comma */
> +            char *comma =3D strchr(info->tpm_version, ',');
> +            if (comma) {
> +                *comma =3D '\0';
> +            }
> +        }
> +    }
> +    VariantClear(&var);
> +
> +    obj->lpVtbl->Release(obj);
> +    obj =3D NULL;
> +
> +    /* Drain remaining results */
> +    while (true) {
> +        hr =3D enumerator->lpVtbl->Next(enumerator, WBEM_INFINITE, 1,
> +                                      &obj, &count);
> +        if (FAILED(hr) || count =3D=3D 0) {
> +            break;
> +        }
> +        obj->lpVtbl->Release(obj);
> +        obj =3D NULL;
> +    }
> +
> +out:
> +    if (obj) {
> +        obj->lpVtbl->Release(obj);
> +    }
> +    if (enumerator) {
> +        enumerator->lpVtbl->Release(enumerator);
> +    }
> +    if (services) {
> +        services->lpVtbl->Release(services);
> +    }
> +}
> +
> +GuestWindowsSecurityInfo *qmp_guest_get_windows_security_info(Error
> **errp)
> +{
> +    Error *local_err =3D NULL;
> +    GuestWindowsSecurityInfo *info =3D g_new0(GuestWindowsSecurityInfo, =
1);
> +
> +    get_device_guard_info(info, &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        goto err;
> +    }
> +
> +    info->secure_boot =3D get_secure_boot_status(&local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        goto err;
> +    }
> +
> +    get_tpm_info(info, &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        goto err;
> +    }
> +
> +    return info;
> +
> +err:
> +    qapi_free_GuestWindowsSecurityInfo(info);
> +    return NULL;
> +}
> diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
> index c57bc9a02f..f54fdf942f 100644
> --- a/qga/qapi-schema.json
> +++ b/qga/qapi-schema.json
> @@ -1952,3 +1952,59 @@
>    'returns': ['GuestNetworkRoute'],
>    'if': { 'any': ['CONFIG_LINUX', 'CONFIG_WIN32'] }
>  }
> +
> +##
> +# @GuestWindowsSecurityInfo:
> +#
> +# Windows security features status.
> +#
> +# @vbs-status: VirtualizationBasedSecurityStatus
> +#
> +# @available-security-properties: AvailableSecurityProperties
> +#
> +# @code-integrity-policy-enforcement-status:
> +#     CodeIntegrityPolicyEnforcementStatus
> +#
> +# @required-security-properties: RequiredSecurityProperties
> +#
> +# @security-services-configured: SecurityServicesConfigured
> +#
> +# @security-services-running: SecurityServicesRunning
> +#
> +# @usr-cfg-code-integrity-policy-enforcement-status:
> +#     UsermodeCodeIntegrityPolicyEnforcementStatus
> +#
> +# @secure-boot: Whether UEFI Secure Boot is enabled
> +#
> +# @tpm-present: Whether a TPM device is present
> +#
> +# @tpm-version: TPM specification version string (e.g. "2.0")
> +#
> +# Since: 10.3
> +##
> +{ 'struct': 'GuestWindowsSecurityInfo',
> +  'data': {
> +      'vbs-status': 'int',
> +      '*available-security-properties': ['int'],
> +      '*code-integrity-policy-enforcement-status': 'int',
> +      '*required-security-properties': ['int'],
> +      '*security-services-configured': ['int'],
> +      '*security-services-running': ['int'],
> +      '*usr-cfg-code-integrity-policy-enforcement-status': 'int',
> +      'secure-boot': 'bool',
> +      'tpm-present': 'bool',
> +      '*tpm-version': 'str' },
> +  'if': 'CONFIG_WIN32' }
>
>
Let's make this more generic
command guest-get-security-info
use 'union' to describe OS specific option like VBS
{ 'tmp_present': false, 'secure_boot': true, 'os': { 'type': 'windows',
'vbs': false, .... } }

make tmp_present, secure_boot, vbs_status optiononal
missing =3D unknown - as we can have it unimplemented for some POSIX/BSD OS=
es

vbs_status is Win10+ only feature, so it can be unknown for Win8


+
> +##
> +# @guest-get-windows-security-info:
> +#
> +# Retrieve Windows security features status (VBS, Secure Boot, TPM).
> +#
> +# Returns: @GuestWindowsSecurityInfo
> +#
> +# Since: 10.3
>

11.1


> +##
> +{ 'command': 'guest-get-windows-security-info',
> +  'returns': 'GuestWindowsSecurityInfo',
> +  'if': 'CONFIG_WIN32' }
> --
> 2.51.0
>
>

--0000000000009d6b3b064d38ddda
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Mar 16,=
 2026 at 2:32=E2=80=AFPM Elizabeth Ashurov &lt;<a href=3D"mailto:eashurov@r=
edhat.com">eashurov@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(2=
04,204,204);padding-left:1ex"><div><div><div>Add a new Windows-only QGA com=
mand to retrieve Windows security<br>
features status including VBS, Secure Boot, and TPM information<br>
from the guest.<br>
<br>
The implementation queries Win32_DeviceGuard and Win32_Tpm via<br>
WMI, and reads the SecureBoot UEFI variable through<br>
GetFirmwareEnvironmentVariable().<br>
<br>
Signed-off-by: Elizabeth Ashurov &lt;<a href=3D"mailto:eashurov@redhat.com"=
 target=3D"_blank">eashurov@redhat.com</a>&gt;<br>
---<br>
=C2=A0qga/commands-win32.c | 404 ++++++++++++++++++++++++++++++++++++++++++=
+<br>
=C2=A0qga/qapi-schema.json |=C2=A0 56 ++++++<br>
=C2=A02 files changed, 460 insertions(+)<br>
<br>
diff --git a/qga/commands-win32.c b/qga/commands-win32.c<br>
index c0bf3467bd..8da9ef521f 100644<br>
--- a/qga/commands-win32.c<br>
+++ b/qga/commands-win32.c<br>
@@ -28,6 +28,7 @@<br>
=C2=A0#include &lt;wtsapi32.h&gt;<br>
=C2=A0#include &lt;wininet.h&gt;<br>
=C2=A0#include &lt;pdh.h&gt;<br>
+#include &lt;wbemidl.h&gt;<br>
<br>
=C2=A0#include &quot;guest-agent-core.h&quot;<br>
=C2=A0#include &quot;vss-win32.h&quot;<br>
@@ -2764,3 +2765,406 @@ GuestNetworkRouteList *qmp_guest_network_get_route(=
Error **errp)<br>
=C2=A0 =C2=A0 =C2=A0g_hash_table_destroy(interface_metric_cache);<br>
=C2=A0 =C2=A0 =C2=A0return head;<br>
=C2=A0}<br>
+<br>
+/*<br>
+ * WMI GUIDs<br>
+ */<br>
+static const GUID qga_CLSID_WbemLocator =3D {<br>
+=C2=A0 =C2=A0 0x4590f811, 0x1d3a, 0x11d0,<br>
+=C2=A0 =C2=A0 {0x89, 0x1f, 0x00, 0xaa, 0x00, 0x4b, 0x2e, 0x24}<br>
+};<br>
+static const GUID qga_IID_IWbemLocator =3D {<br>
+=C2=A0 =C2=A0 0xdc12a687, 0x737f, 0x11cf,<br>
+=C2=A0 =C2=A0 {0x88, 0x4d, 0x00, 0xaa, 0x00, 0x4b, 0x2e, 0x24}<br>
+};<br>
+<br>
+static IWbemServices *wmi_connect_to_namespace(const wchar_t *namespace_pa=
th,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0Error **errp)<br>
+{<br>
+=C2=A0 =C2=A0 HRESULT hr;<br>
+=C2=A0 =C2=A0 IWbemLocator *locator =3D NULL;<br>
+=C2=A0 =C2=A0 IWbemServices *services =3D NULL;<br>
+=C2=A0 =C2=A0 BSTR bstr_ns =3D SysAllocString(namespace_path);<br>
+<br>
+=C2=A0 =C2=A0 if (!bstr_ns) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;failed to allocate WMI =
namespace string&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 hr =3D CoCreateInstance(&amp;qga_CLSID_WbemLocator, NULL, CL=
SCTX_INPROC_SERVER,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 &amp;qga_IID_IWbemLocator, (LPVOID *)&amp;locator);<br>
+=C2=A0 =C2=A0 if (FAILED(hr)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg_win32(errp, hr, &quot;failed to cre=
ate IWbemLocator&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 hr =3D locator-&gt;lpVtbl-&gt;ConnectServer(locator, bstr_ns=
, NULL, NULL, NULL,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0, NULL,=
 NULL, &amp;services);<br>
+=C2=A0 =C2=A0 if (FAILED(hr)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg_win32(errp, hr, &quot;failed to con=
nect to WMI namespace&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 hr =3D CoSetProxyBlanket((IUnknown *)services,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0RPC_C_AUTHN_WINNT, RPC_C_AUTHZ_NONE, NULL,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0RPC_C_AUTHN_LEVEL_CALL,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0RPC_C_IMP_LEVEL_IMPERSONATE,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0NULL, EOAC_NONE);<br>
+=C2=A0 =C2=A0 if (FAILED(hr)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg_win32(errp, hr, &quot;failed to set=
 WMI proxy blanket&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 services-&gt;lpVtbl-&gt;Release(services);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 services =3D NULL;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+out:<br>
+=C2=A0 =C2=A0 SysFreeString(bstr_ns);<br>
+=C2=A0 =C2=A0 if (locator) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 locator-&gt;lpVtbl-&gt;Release(locator);<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 return services;<br>
+}<br>
+<br>
+static IEnumWbemClassObject *wmi_exec_query(IWbemServices *services,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 const wchar_t *query,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 Error **errp)<br>
+{<br>
+=C2=A0 =C2=A0 HRESULT hr;<br>
+=C2=A0 =C2=A0 IEnumWbemClassObject *enumerator =3D NULL;<br>
+=C2=A0 =C2=A0 BSTR bstr_wql =3D SysAllocString(L&quot;WQL&quot;);<br>
+=C2=A0 =C2=A0 BSTR bstr_query =3D SysAllocString(query);<br>
+<br>
+=C2=A0 =C2=A0 if (!bstr_wql || !bstr_query) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;failed to allocate WMI =
query strings&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 hr =3D services-&gt;lpVtbl-&gt;ExecQuery(services, bstr_wql,=
 bstr_query,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0WBEM_FLAG_RETURN=
_IMMEDIATELY |<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0WBEM_FLAG_FORWAR=
D_ONLY,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NULL, &amp;enume=
rator);<br>
+=C2=A0 =C2=A0 if (FAILED(hr)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg_win32(errp, hr, &quot;WMI query fai=
led&quot;);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+out:<br>
+=C2=A0 =C2=A0 SysFreeString(bstr_wql);<br>
+=C2=A0 =C2=A0 SysFreeString(bstr_query);<br>
+=C2=A0 =C2=A0 return enumerator;<br>
+}<br>
+<br>
+static HRESULT wmi_get_property(IWbemClassObject *obj, const wchar_t *name=
,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VARIANT *var)<br>
+{<br>
+=C2=A0 =C2=A0 return obj-&gt;lpVtbl-&gt;Get(obj, name, 0, var, NULL, NULL)=
;<br>
+}<br>
+<br>
+/* Read a WMI integer property (VT_I4 or VT_UI4). */<br>
+static bool wmi_get_int_property(IWbemClassObject *obj,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const wchar_t *name,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int64_t *out)<br>
+{<br>
+=C2=A0 =C2=A0 VARIANT var;<br>
+=C2=A0 =C2=A0 bool ret =3D false;<br>
+<br>
+=C2=A0 =C2=A0 VariantInit(&amp;var);<br>
+=C2=A0 =C2=A0 if (SUCCEEDED(wmi_get_property(obj, name, &amp;var))) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (V_VT(&amp;var) =3D=3D VT_I4) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *out =3D V_I4(&amp;var);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D true;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (V_VT(&amp;var) =3D=3D VT_UI4) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *out =3D V_UI4(&amp;var);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D true;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 VariantClear(&amp;var);<br>
+=C2=A0 =C2=A0 return ret;<br>
+}<br>
+<br>
+/* Read an integer SAFEARRAY WMI property into a QAPI intList. */<br>
+static bool wmi_safearray_to_int_list(IWbemClassObject *obj,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const wchar_t *=
prop_name,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 intList **list)=
<br>
+{<br>
+=C2=A0 =C2=A0 VARIANT var;<br>
+=C2=A0 =C2=A0 HRESULT hr;<br>
+=C2=A0 =C2=A0 LONG lb, ub, i;<br>
+=C2=A0 =C2=A0 uint32_t *data =3D NULL;<br>
+<br>
+=C2=A0 =C2=A0 VariantInit(&amp;var);<br>
+=C2=A0 =C2=A0 hr =3D wmi_get_property(obj, prop_name, &amp;var);<br>
+=C2=A0 =C2=A0 if (FAILED(hr) || V_VT(&amp;var) =3D=3D VT_NULL) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 VariantClear(&amp;var);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 if (!(V_VT(&amp;var) &amp; VT_ARRAY)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 VariantClear(&amp;var);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 SAFEARRAY *sa =3D V_ARRAY(&amp;var);<br>
+=C2=A0 =C2=A0 if (FAILED(SafeArrayGetLBound(sa, 1, &amp;lb)) ||<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 FAILED(SafeArrayGetUBound(sa, 1, &amp;ub))) {<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 VariantClear(&amp;var);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 if (FAILED(SafeArrayAccessData(sa, (void **)&amp;data))) {<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 VariantClear(&amp;var);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 intList **tail =3D list;<br>
+=C2=A0 =C2=A0 for (i =3D 0; i &lt;=3D ub - lb; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 QAPI_LIST_APPEND(tail, (int64_t)data[i]);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 SafeArrayUnaccessData(sa);<br>
+=C2=A0 =C2=A0 VariantClear(&amp;var);<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+/*<br>
+ * Query Win32_DeviceGuard WMI class for VBS and related properties.<br>
+ */<br>
+static void get_device_guard_info(GuestWindowsSecurityInfo *info,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Error **errp)<br>
+{<br>
+=C2=A0 =C2=A0 Error *local_err =3D NULL;<br>
+=C2=A0 =C2=A0 IWbemServices *services =3D NULL;<br>
+=C2=A0 =C2=A0 IEnumWbemClassObject *enumerator =3D NULL;<br>
+=C2=A0 =C2=A0 IWbemClassObject *obj =3D NULL;<br>
+=C2=A0 =C2=A0 ULONG count =3D 0;<br>
+=C2=A0 =C2=A0 HRESULT hr;<br>
+=C2=A0 =C2=A0 int64_t val;<br>
+<br>
+=C2=A0 =C2=A0 services =3D wmi_connect_to_namespace(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 L&quot;ROOT\\Microsoft\\Windows\\DeviceGuard&q=
uot;, &amp;local_err);<br>
+=C2=A0 =C2=A0 if (!services) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_propagate(errp, local_err);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 enumerator =3D wmi_exec_query(services,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 L&quot;SELECT * FROM Win32_DeviceGuard&quot;, =
&amp;local_err);<br>
+=C2=A0 =C2=A0 if (!enumerator) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_propagate(errp, local_err);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 hr =3D enumerator-&gt;lpVtbl-&gt;Next(enumerator, WBEM_INFIN=
ITE, 1,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;obj, &amp;count);<=
br>
+=C2=A0 =C2=A0 if (FAILED(hr)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg_win32(errp, hr, &quot;failed to enu=
merate Win32_DeviceGuard&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 if (count =3D=3D 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;no Win32_DeviceGuard in=
stance found&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 if (wmi_get_int_property(obj, L&quot;VirtualizationBasedSecu=
rityStatus&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;val)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 info-&gt;vbs_status =3D val;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 if (wmi_get_int_property(obj, L&quot;CodeIntegrityPolicyEnfo=
rcementStatus&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;val)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 info-&gt;has_code_integrity_policy_enforcement=
_status =3D true;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 info-&gt;code_integrity_policy_enforcement_sta=
tus =3D val;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 if (wmi_get_int_property(obj,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0L&quot;UsermodeCodeIntegrityPolicyEnforcemen=
tStatus&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;val)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 info-&gt;has_usr_cfg_code_integrity_policy_enf=
orcement_status =3D true;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 info-&gt;usr_cfg_code_integrity_policy_enforce=
ment_status =3D val;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 if (wmi_safearray_to_int_list(obj, L&quot;AvailableSecurityP=
roperties&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;info-&gt;available_secur=
ity_properties)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 info-&gt;has_available_security_properties =3D=
 true;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 if (wmi_safearray_to_int_list(obj, L&quot;RequiredSecurityPr=
operties&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;info-&gt;required_securi=
ty_properties)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 info-&gt;has_required_security_properties =3D =
true;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 if (wmi_safearray_to_int_list(obj, L&quot;SecurityServicesCo=
nfigured&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;info-&gt;security_servic=
es_configured)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 info-&gt;has_security_services_configured =3D =
true;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 if (wmi_safearray_to_int_list(obj, L&quot;SecurityServicesRu=
nning&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;info-&gt;security_servic=
es_running)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 info-&gt;has_security_services_running =3D tru=
e;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 obj-&gt;lpVtbl-&gt;Release(obj);<br>
+=C2=A0 =C2=A0 obj =3D NULL;<br>
+<br>
+=C2=A0 =C2=A0 /* Drain remaining results */<br>
+=C2=A0 =C2=A0 while (true) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 hr =3D enumerator-&gt;lpVtbl-&gt;Next(enumerat=
or, WBEM_INFINITE, 1,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;obj, &amp;=
count);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (FAILED(hr) || count =3D=3D 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 obj-&gt;lpVtbl-&gt;Release(obj);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 obj =3D NULL;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+out:<br>
+=C2=A0 =C2=A0 if (obj) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 obj-&gt;lpVtbl-&gt;Release(obj);<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 if (enumerator) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 enumerator-&gt;lpVtbl-&gt;Release(enumerator);=
<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 if (services) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 services-&gt;lpVtbl-&gt;Release(services);<br>
+=C2=A0 =C2=A0 }<br>
+}<br>
+<br>
+/*<br>
+ * Read the SecureBoot UEFI variable to determine whether Secure Boot<br>
+ * is enabled.=C2=A0 Returns false on legacy BIOS systems.<br>
+ */<br>
+static bool get_secure_boot_status(Error **errp)<br>
+{<br>
+=C2=A0 =C2=A0 Error *local_err =3D NULL;<br>
+=C2=A0 =C2=A0 BYTE value =3D 0;<br>
+=C2=A0 =C2=A0 DWORD ret;<br>
+<br>
+=C2=A0 =C2=A0 acquire_privilege(SE_SYSTEM_ENVIRONMENT_NAME, &amp;local_err=
);<br>
+=C2=A0 =C2=A0 if (local_err) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_propagate(errp, local_err);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 ret =3D GetFirmwareEnvironmentVariableA(&quot;SecureBoot&quo=
t;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;{8be4df61-93ca-11d2-aa0d-00e098032b8c}&q=
uot;, &amp;value, sizeof(value));=C2=A0</div></div></div></blockquote><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex"><div><div><div>
+<br>
+=C2=A0 =C2=A0 if (ret =3D=3D 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 DWORD err =3D GetLastError();<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (err =3D=3D ERROR_INVALID_FUNCTION || err =
=3D=3D ERROR_ENVVAR_NOT_FOUND) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg_win32(errp, err,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0&quot;failed to read SecureBoot UEFI variable&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 return value =3D=3D 1;<br>
+}<br>
+<br>
+/*<br>
+ * Query Win32_Tpm WMI class for TPM presence and version.<br>
+ */<br>
+static void get_tpm_info(GuestWindowsSecurityInfo *info, Error **errp)<br>
+{<br>
+=C2=A0 =C2=A0 Error *local_err =3D NULL;<br>
+=C2=A0 =C2=A0 IWbemServices *services =3D NULL;<br>
+=C2=A0 =C2=A0 IEnumWbemClassObject *enumerator =3D NULL;<br>
+=C2=A0 =C2=A0 IWbemClassObject *obj =3D NULL;<br>
+=C2=A0 =C2=A0 ULONG count =3D 0;<br>
+=C2=A0 =C2=A0 HRESULT hr;<br>
+=C2=A0 =C2=A0 VARIANT var;<br>
+<br>
+=C2=A0 =C2=A0 services =3D wmi_connect_to_namespace(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 L&quot;ROOT\\CIMV2\\Security\\MicrosoftTpm&quo=
t;, &amp;local_err);<br>
+=C2=A0 =C2=A0 if (!services) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* TPM namespace may not exist -- not an error=
 */<br></div></div></div></blockquote><div>This is a case for the missing &=
quot;tpm_present&quot; field</div><div>=C2=A0</div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex"><div><div><div>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_free(local_err);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 info-&gt;tpm_present =3D false;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 enumerator =3D wmi_exec_query(services,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 L&quot;SELECT * FROM Win32_Tpm&quot;, &amp;loc=
al_err);<br>
+=C2=A0 =C2=A0 if (!enumerator) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_free(local_err);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 info-&gt;tpm_present =3D false;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 hr =3D enumerator-&gt;lpVtbl-&gt;Next(enumerator, WBEM_INFIN=
ITE, 1,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;obj, &amp;count);<=
br>
+=C2=A0 =C2=A0 if (FAILED(hr) || count =3D=3D 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 info-&gt;tpm_present =3D false;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 info-&gt;tpm_present =3D true;<br>
+<br>
+=C2=A0 =C2=A0 VariantInit(&amp;var);<br>
+=C2=A0 =C2=A0 if (SUCCEEDED(wmi_get_property(obj, L&quot;SpecVersion&quot;=
, &amp;var)) &amp;&amp;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 V_VT(&amp;var) =3D=3D VT_BSTR &amp;&amp; V_BST=
R(&amp;var)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 info-&gt;tpm_version =3D g_utf16_to_utf8(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (const gunichar2 *)V_BSTR(&amp;v=
ar), -1, NULL, NULL, NULL);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (info-&gt;tpm_version) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* keep only the part before the=
 first comma */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 char *comma =3D strchr(info-&gt;=
tpm_version, &#39;,&#39;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (comma) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *comma =3D &#39;\0=
&#39;;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 VariantClear(&amp;var);<br>
+<br>
+=C2=A0 =C2=A0 obj-&gt;lpVtbl-&gt;Release(obj);<br>
+=C2=A0 =C2=A0 obj =3D NULL;<br>
+<br>
+=C2=A0 =C2=A0 /* Drain remaining results */<br>
+=C2=A0 =C2=A0 while (true) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 hr =3D enumerator-&gt;lpVtbl-&gt;Next(enumerat=
or, WBEM_INFINITE, 1,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;obj, &amp;=
count);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (FAILED(hr) || count =3D=3D 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 obj-&gt;lpVtbl-&gt;Release(obj);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 obj =3D NULL;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+out:<br>
+=C2=A0 =C2=A0 if (obj) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 obj-&gt;lpVtbl-&gt;Release(obj);<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 if (enumerator) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 enumerator-&gt;lpVtbl-&gt;Release(enumerator);=
<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 if (services) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 services-&gt;lpVtbl-&gt;Release(services);<br>
+=C2=A0 =C2=A0 }<br>
+}<br>
+<br>
+GuestWindowsSecurityInfo *qmp_guest_get_windows_security_info(Error **errp=
)<br>
+{<br>
+=C2=A0 =C2=A0 Error *local_err =3D NULL;<br>
+=C2=A0 =C2=A0 GuestWindowsSecurityInfo *info =3D g_new0(GuestWindowsSecuri=
tyInfo, 1);<br>
+<br>
+=C2=A0 =C2=A0 get_device_guard_info(info, &amp;local_err);<br>
+=C2=A0 =C2=A0 if (local_err) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_propagate(errp, local_err);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 info-&gt;secure_boot =3D get_secure_boot_status(&amp;local_e=
rr);<br>
+=C2=A0 =C2=A0 if (local_err) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_propagate(errp, local_err);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 get_tpm_info(info, &amp;local_err);<br>
+=C2=A0 =C2=A0 if (local_err) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_propagate(errp, local_err);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 return info;<br>
+<br>
+err:<br>
+=C2=A0 =C2=A0 qapi_free_GuestWindowsSecurityInfo(info);<br>
+=C2=A0 =C2=A0 return NULL;<br>
+}<br>
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json<br>
index c57bc9a02f..f54fdf942f 100644<br>
--- a/qga/qapi-schema.json<br>
+++ b/qga/qapi-schema.json<br>
@@ -1952,3 +1952,59 @@<br>
=C2=A0 =C2=A0&#39;returns&#39;: [&#39;GuestNetworkRoute&#39;],<br>
=C2=A0 =C2=A0&#39;if&#39;: { &#39;any&#39;: [&#39;CONFIG_LINUX&#39;, &#39;C=
ONFIG_WIN32&#39;] }<br>
=C2=A0}<br>
+<br>
+##<br>
+# @GuestWindowsSecurityInfo:<br>
+#<br>
+# Windows security features status.<br>
+#<br>
+# @vbs-status: VirtualizationBasedSecurityStatus<br>
+#<br>
+# @available-security-properties: AvailableSecurityProperties<br>
+#<br>
+# @code-integrity-policy-enforcement-status:<br>
+#=C2=A0 =C2=A0 =C2=A0CodeIntegrityPolicyEnforcementStatus<br>
+#<br>
+# @required-security-properties: RequiredSecurityProperties<br>
+#<br>
+# @security-services-configured: SecurityServicesConfigured<br>
+#<br>
+# @security-services-running: SecurityServicesRunning<br>
+#<br>
+# @usr-cfg-code-integrity-policy-enforcement-status:<br>
+#=C2=A0 =C2=A0 =C2=A0UsermodeCodeIntegrityPolicyEnforcementStatus<br>
+#<br>
+# @secure-boot: Whether UEFI Secure Boot is enabled<br>
+#<br>
+# @tpm-present: Whether a TPM device is present<br>
+#<br>
+# @tpm-version: TPM specification version string (e.g. &quot;2.0&quot;)<br=
>
+#<br>
+# Since: 10.3<br>
+##<br>
+{ &#39;struct&#39;: &#39;GuestWindowsSecurityInfo&#39;,<br>
+=C2=A0 &#39;data&#39;: {<br>
+=C2=A0 =C2=A0 =C2=A0 &#39;vbs-status&#39;: &#39;int&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 &#39;*available-security-properties&#39;: [&#39;int&#=
39;],<br>
+=C2=A0 =C2=A0 =C2=A0 &#39;*code-integrity-policy-enforcement-status&#39;: =
&#39;int&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 &#39;*required-security-properties&#39;: [&#39;int&#3=
9;],<br>
+=C2=A0 =C2=A0 =C2=A0 &#39;*security-services-configured&#39;: [&#39;int&#3=
9;],<br>
+=C2=A0 =C2=A0 =C2=A0 &#39;*security-services-running&#39;: [&#39;int&#39;]=
,<br>
+=C2=A0 =C2=A0 =C2=A0 &#39;*usr-cfg-code-integrity-policy-enforcement-statu=
s&#39;: &#39;int&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 &#39;secure-boot&#39;: &#39;bool&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 &#39;tpm-present&#39;: &#39;bool&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 &#39;*tpm-version&#39;: &#39;str&#39; },<br>
+=C2=A0 &#39;if&#39;: &#39;CONFIG_WIN32&#39; }<br><br></div></div></div></b=
lockquote><div>=C2=A0</div><div>Let&#39;s make this more generic<br>command=
 guest-get-security-info<br>use &#39;union&#39; to describe OS specific opt=
ion like VBS<br>{ &#39;tmp_present&#39;: false, &#39;secure_boot&#39;: true=
, &#39;os&#39;: { &#39;type&#39;: &#39;windows&#39;, &#39;vbs&#39;: false, =
.... } }<br><br>make tmp_present, secure_boot, vbs_status optiononal <br>mi=
ssing =3D unknown - as we can have it unimplemented for some POSIX/BSD OSes=
<br><br>vbs_status is Win10+ only feature, so it can be unknown for Win8</d=
iv><div><br><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><di=
v><div>+<br>
+##<br>
+# @guest-get-windows-security-info:<br>
+#<br>
+# Retrieve Windows security features status (VBS, Secure Boot, TPM).<br>
+#<br>
+# Returns: @GuestWindowsSecurityInfo<br>
+#<br>
+# Since: 10.3</div></div></blockquote><div><br>11.1</div><div>=C2=A0</div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">
+##<br>
+{ &#39;command&#39;: &#39;guest-get-windows-security-info&#39;,<br>
+=C2=A0 &#39;returns&#39;: &#39;GuestWindowsSecurityInfo&#39;,<br>
+=C2=A0 &#39;if&#39;: &#39;CONFIG_WIN32&#39; }<br>
-- <br>
2.51.0<br>
<br>
</blockquote></div></div>

--0000000000009d6b3b064d38ddda--


