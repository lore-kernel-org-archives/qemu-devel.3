Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7076ECA600B
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 13:23:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEo5U-0001Hp-VH; Thu, 08 Oct 2026 09:23:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1xEo5Q-0001HT-Nz
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 09:23:05 -0400
Received: from mail-dy1-x1335.google.com ([2607:f8b0:4864:20::1335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1xEo5N-0003Mf-RP
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 09:23:04 -0400
Received: by mail-dy1-x1335.google.com with SMTP id
 5a478bee46e88-351767ef18cso328621eec.1
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2026 06:23:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791465780; cv=none;
 d=google.com; s=arc-20260327;
 b=IJO/MqsrUz5oJMTbgnKtPId1WdVdq/rsCMSrg668pg4a7digm5f+pGV64uWoeq9k9e
 etpYxgZuWEdkVhnvVv7lSUzSQ4Tc1eAcnzZAsOsPLt4cmOADRGmJDx5P/tk7q2C6iaPR
 EPr8XBS3PQFLE7ytVeJXUJci2d1jidWiwZe3Inlqk26aWa7C9rlZ/1BVVfkPnZiLR4sz
 74VswAjpjj2zE4ndSwIAEfVztcx0/xhOXqVOJNQjPwb8HQDQAWtOFFi+UjSZBatElJ3y
 VOgSU7p0pAP+zztVhyulvD7Fu33ItKeh5/jSLIPx2/DQoe7J6XjBwz2OFho8xe6UN9la
 ed7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=hgMdjjudu6hq9h5AT55fXVP2ed9tEhnq6MhUoLAdhAI=;
 fh=x6As2FjKho653MANCXfOAl64DTgjyGV9kXNBx6ZNDA8=;
 b=XtfoWBwsqFhPiKZaSwSv3Jy/Rwp4hPpJw0zXXYDN4aErYbFjC/n56Xsp2gxrTQQgor
 Nf1AVAqJrcFzLDCpkUp3LGdQZ/DQc9auCNxiztfYDjLRBBHSrfx8L9Oksb1oevIW6vN3
 8Fa6gMDLl0ZY6D7S20vuE+CQir3+Pv3zMkFzpxCvEfzfGgeiU8q2DT5grb+XePxH20GJ
 fNHW0bgumJNGjDN+JdiPHtpfqMEn6xqawrYsu3nskYYLlaDTNuyJ/1Fe+H9YnRVAF/7E
 6V499YCuXhz8lIqbghkYjaTHY/oEAM4oH7xFS0aRCDe3nhGwTjtsEEI2IenBIV+g37kJ
 DhPg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791465780; x=1792070580; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=hgMdjjudu6hq9h5AT55fXVP2ed9tEhnq6MhUoLAdhAI=;
 b=hTGMJ0RnYcrqpPPwvzzOP3/PnYS9TBj+N19eDPNlrg16zbg6fYhq0FECPfCdRftGnw
 Wj6YcwJBm2wrv3LWl3nFIMSafXpiEmNutmUooctXwY2Xdvy8721P50nBi+wlkZUX7jHw
 Z76ueh6vWB0b1of9HESQ1ZwbKPLIRqNgoK5xCimsD52o1oPSG5QLCMXCoWV+yElWOqul
 qxY9sNy3FAnRB0LqOSFbg9sECiwMfrI+ZQMuHF1mnRwUsiuk5nWd6r6NCm/j1cLPu6KN
 wUQGCw0qY7CLIq/fgq1WecUmsyPfSjKvWUVkTRGxjB8F0jNihT5gFDQbHysEB4pSwh6H
 DJkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791465780; x=1792070580;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hgMdjjudu6hq9h5AT55fXVP2ed9tEhnq6MhUoLAdhAI=;
 b=RfDbNehAIBDkHtpz+AZViAZ5ZiK6xze3hiPMZQAWre9CfA2/bPNHakQrMOFHCFCT22
 hf2OloFyUewWJ/9EzmNX1ByAGHGMp+iDaiNTrAKpClZWHCIyArpioiRI55vp5CtonXm2
 v6srQpq6AXVCr/Q6MpwcgbLpwgwJXA4B2vdDKoOpRN3W3Llj6ddxYGoiO3/Vm/tFnSyk
 Oiu4fNgMUAzlTPwa12bIWTQLu6veZfIa9x73+H/l2Zn8ZMz3ldjLcThbLBBSRUvJPOYo
 sFqqGxjjwJEqFSSTH4Ps68d1VM/9YIUH5XjWMMhjEIhO9ruMEuxR8uLFEpyLAvm7gkOf
 xaUA==
X-Gm-Message-State: AFuF++m/TDpCKjgloHMiia1u/la2S3exHmBpauZk4HGzvyic5glTjeUN
 2L5UwsmkEo76pSgvoLRl5iCUmpWkrZwVKUhaX2Y0w9g5EEXEtSvifs8ERJ/ngblXzmgPX5FQwm1
 HqmVTHS10GV1FNh7u6M9DMsAKWE5rMag=
X-Gm-Gg: AYBFou2LE9VwFR0A/LhSoUECh1jN6niiwz99XfVEwmggg3qqcoWcqBMolfRgaNQ02+S
 Jca+ww9VrTgbd1y3kQJY2mIRVdOworB8qQhcQ9ag4JdEuetOB8pqK44Jn4AUUlkUE4luP7uYkNj
 ZJvhOnX0m5JjcSqvs0iMYHM59lbQ6FY9tTqvsjjeJeT5jREVkGKamWbNltzv+QGs7+xG1S5IXCq
 apBdHMFYIPvvD/hzKEy1ex9wjJy6vJ/FRidx0mOjQPkwkOJz+oRBqWJFSVUSGb+cIMRcnM3MAow
 aKAyxwReANhw+TU0utrS1B5HjxzDtGqF8QFUwW7CZRe4oTU/0CNmBBZ5hJUnGXV/dKOhcRkKQ5v
 9qObQhzYEg6w=
X-Received: by 2002:a05:7300:f542:b0:34e:f5c3:96a with SMTP id
 5a478bee46e88-3515deca0d3mr6553974eec.39.1791465779941; Thu, 08 Oct 2026
 06:22:59 -0700 (PDT)
MIME-Version: 1.0
References: <20261008123920.3861059-1-eashurov@redhat.com>
 <20261008123920.3861059-2-eashurov@redhat.com>
In-Reply-To: <20261008123920.3861059-2-eashurov@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 8 Oct 2026 17:22:47 +0400
X-Gm-Features: AclHuK_Qqs3piIF7kRtmFd8ohKbiLPAcvVkof2zcP4p-uitdAiae2XzPzkehRZY
Message-ID: <CAJ+F1CKr+F4w=D2njOjWDC329rnO-n+NrkfXQZG7H2zmFM3_cQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] qga: Add guest-get-driver-services command for
 Windows
To: Elizabeth Ashurov <eashurov@redhat.com>
Cc: qemu-devel@nongnu.org, kkostiuk@redhat.com, michael.roth@amd.com, 
 dholler@redhat.com, armbru@redhat.com, fdeutsch@redhat.com, 
 yvugenfi@redhat.com, kramdoss@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1335;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-dy1-x1335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi

On Thu, Oct 8, 2026 at 4:43=E2=80=AFPM Elizabeth Ashurov <eashurov@redhat.c=
om> wrote:
>
> Add a new guest-get-driver-services command that returns registered
> driver services from the Service Control Manager
> (EnumServicesStatusExW).  Each entry includes the service name,
> configured binary path, current SCM status, and FileVersion and
> CompanyName metadata extracted from the driver binary.
>
> Normalize driver binary paths from the service database before
> reading version resources, including SystemRoot,
> environment-variable, NT-prefix, and relative path forms.
>
> Unrecognized SCM service states are reported as "unknown" with a
> log message rather than aborting the enumeration, so that future
> Windows versions do not break the command.
>
> Link against version.dll (-lversion) for the GetFileVersionInfo
> and VerQueryValue APIs.
>
> Signed-off-by: Elizabeth Ashurov <eashurov@redhat.com>
> ---
>  qga/commands-win32.c | 363 +++++++++++++++++++++++++++++++++++++++++++
>  qga/meson.build      |   5 +-
>  qga/qapi-schema.json |  58 +++++++
>  3 files changed, 424 insertions(+), 2 deletions(-)
>
> diff --git a/qga/commands-win32.c b/qga/commands-win32.c
> index e01033d8c5..1031fd52d9 100644
> --- a/qga/commands-win32.c
> +++ b/qga/commands-win32.c
> @@ -29,6 +29,7 @@
>  #include <wininet.h>
>  #include <pdh.h>
>  #include <dismapi.h>
> +#include <winver.h>
>
>  #include "guest-agent-core.h"
>  #include "vss-win32.h"
> @@ -2747,6 +2748,368 @@ out:
>      return head;
>  }
>
> +static GuestDriverServiceStatus ga_driver_service_status(DWORD state)
> +{
> +    switch (state) {
> +    case SERVICE_STOPPED:
> +        return GUEST_DRIVER_SERVICE_STATUS_STOPPED;
> +    case SERVICE_START_PENDING:
> +        return GUEST_DRIVER_SERVICE_STATUS_START_PENDING;
> +    case SERVICE_STOP_PENDING:
> +        return GUEST_DRIVER_SERVICE_STATUS_STOP_PENDING;
> +    case SERVICE_RUNNING:
> +        return GUEST_DRIVER_SERVICE_STATUS_RUNNING;
> +    case SERVICE_CONTINUE_PENDING:
> +        return GUEST_DRIVER_SERVICE_STATUS_CONTINUE_PENDING;
> +    case SERVICE_PAUSE_PENDING:
> +        return GUEST_DRIVER_SERVICE_STATUS_PAUSE_PENDING;
> +    case SERVICE_PAUSED:
> +        return GUEST_DRIVER_SERVICE_STATUS_PAUSED;
> +    default:
> +        return GUEST_DRIVER_SERVICE_STATUS_UNKNOWN;
> +    }
> +}
> +
> +/* Convert an SCM driver path into a path usable by Win32 file APIs. */
> +static WCHAR *ga_resolve_driver_path(const WCHAR *path)
> +{
> +    WCHAR windows_dir[MAX_PATH + 1];
> +    g_autofree WCHAR *trimmed =3D NULL;
> +    g_autofree WCHAR *expanded =3D NULL;
> +    const WCHAR *start =3D path;
> +    const WCHAR *end;
> +    const WCHAR *remainder =3D NULL;
> +    size_t prefix_len;
> +    size_t path_len;
> +    size_t windows_len;
> +    DWORD expanded_len;
> +    UINT windows_dir_len;
> +
> +    while (*start !=3D L'\0' && iswspace(*start)) {
> +        start++;
> +    }
> +    end =3D start + wcslen(start);
> +    while (end > start && iswspace(end[-1])) {
> +        end--;
> +    }
> +    if (end - start >=3D 2 && start[0] =3D=3D L'"' && end[-1] =3D=3D L'"=
') {
> +        start++;
> +        end--;
> +    }
> +    if (end =3D=3D start) {
> +        return NULL;
> +    }
> +
> +    path_len =3D end - start;
> +    trimmed =3D g_new(WCHAR, path_len + 1);
> +    memcpy(trimmed, start, path_len * sizeof(WCHAR));
> +    trimmed[path_len] =3D L'\0';
> +
> +    expanded_len =3D ExpandEnvironmentStringsW(trimmed, NULL, 0);
> +    if (expanded_len =3D=3D 0) {
> +        return NULL;
> +    }
> +    expanded =3D g_new(WCHAR, expanded_len);
> +    path_len =3D ExpandEnvironmentStringsW(trimmed, expanded, expanded_l=
en);
> +    if (path_len =3D=3D 0 || path_len > expanded_len) {
> +        return NULL;
> +    }
> +
> +    prefix_len =3D wcslen(L"\\SystemRoot");
> +    if (_wcsnicmp(expanded, L"\\SystemRoot", prefix_len) =3D=3D 0 &&
> +        (expanded[prefix_len] =3D=3D L'\0' ||
> +         expanded[prefix_len] =3D=3D L'\\' ||
> +         expanded[prefix_len] =3D=3D L'/')) {
> +        remainder =3D expanded + prefix_len;
> +    } else {
> +        prefix_len =3D wcslen(L"SystemRoot");
> +        if (_wcsnicmp(expanded, L"SystemRoot", prefix_len) =3D=3D 0 &&
> +            (expanded[prefix_len] =3D=3D L'\0' ||
> +             expanded[prefix_len] =3D=3D L'\\' ||
> +             expanded[prefix_len] =3D=3D L'/')) {
> +            remainder =3D expanded + prefix_len;
> +        }
> +    }
> +
> +    windows_dir_len =3D GetWindowsDirectoryW(windows_dir,
> +                                            ARRAY_SIZE(windows_dir));
> +    if (windows_dir_len =3D=3D 0 || windows_dir_len >=3D ARRAY_SIZE(wind=
ows_dir)) {
> +        return NULL;
> +    }
> +    windows_len =3D windows_dir_len;
> +
> +    if (remainder !=3D NULL) {
> +        WCHAR *ret =3D g_new(WCHAR, windows_len + wcslen(remainder) + 1)=
;
> +
> +        memcpy(ret, windows_dir, windows_len * sizeof(WCHAR));
> +        wcscpy(ret + windows_len, remainder);
> +        return ret;
> +    }
> +
> +    if (wcsncmp(expanded, L"\\??\\", 4) =3D=3D 0) {
> +        return g_memdup2(expanded + 4,
> +                         (wcslen(expanded + 4) + 1) * sizeof(WCHAR));

Removing `\??\` works for ordinary drive paths, but breaks volume GUID
paths. For example, `\??\Volume{GUID}\drivers\foo.sys` becomes a
relative path after stripping the prefix. Converting `\??\` to `\\?\`
preserves the address for Win32 file APIs.

See also similar fix in rust:
https://github.com/rust-lang/rust/commit/068807a5b8072349363c33918c41f4d7dd=
fde600

     if (wcsncmp(expanded, L"\\??\\", 4) =3D=3D 0) {
-        return g_memdup2(expanded + 4,
-                         (wcslen(expanded + 4) + 1) * sizeof(WCHAR));
+        expanded[1] =3D L'\\';
+        return g_steal_pointer(&expanded);
     }


> +    }
> +
> +    if ((iswalpha(expanded[0]) && expanded[1] =3D=3D L':') ||
> +        expanded[0] =3D=3D L'\\') {
> +        return g_steal_pointer(&expanded);
> +    }
> +
> +    path_len =3D wcslen(expanded);
> +    start =3D expanded;
> +    while (*start =3D=3D L'\\' || *start =3D=3D L'/') {
> +        start++;
> +        path_len--;
> +    }
> +    {
> +        WCHAR *ret =3D g_new(WCHAR, windows_len + path_len + 2);
> +
> +        memcpy(ret, windows_dir, windows_len * sizeof(WCHAR));
> +        ret[windows_len] =3D L'\\';
> +        wcscpy(ret + windows_len + 1, start);
> +        return ret;
> +    }
> +}
> +
> +typedef struct QGAVersionTranslation {
> +    WORD language;
> +    WORD code_page;
> +} QGAVersionTranslation;
> +
> +/* Return CompanyName from a localized file-version string table. */
> +static char *ga_get_file_vendor(const void *version_info)
> +{
> +    QGAVersionTranslation *translations =3D NULL;
> +    static const QGAVersionTranslation fallback =3D { 0x0409, 0x04b0 };
> +    UINT translations_len =3D 0;
> +    UINT count =3D 0;
> +    UINT i;
> +
> +    if (VerQueryValueW(version_info, L"\\VarFileInfo\\Translation",
> +                       (void **)&translations, &translations_len) &&
> +        translations !=3D NULL) {
> +        count =3D translations_len / sizeof(*translations);
> +    }
> +
> +    for (i =3D 0; i <=3D count; i++) {
> +        const QGAVersionTranslation *translation;
> +        WCHAR query[64];
> +        WCHAR *company =3D NULL;
> +        UINT company_len =3D 0;
> +        char *vendor;
> +
> +        translation =3D i < count ? &translations[i] : &fallback;
> +        swprintf(query, ARRAY_SIZE(query),
> +                 L"\\StringFileInfo\\%04x%04x\\CompanyName",
> +                 translation->language, translation->code_page);
> +        if (!VerQueryValueW(version_info, query, (void **)&company,
> +                            &company_len) || company_len <=3D 1) {
> +            continue;
> +        }
> +        vendor =3D g_utf16_to_utf8(company, -1, NULL, NULL, NULL);
> +        if (vendor !=3D NULL && vendor[0] !=3D '\0') {
> +            return vendor;
> +        }
> +        g_free(vendor);
> +    }
> +    return NULL;
> +}
> +
> +/* Add optional FileVersion and CompanyName data from a driver binary. *=
/
> +static bool ga_get_driver_file_metadata(const WCHAR *path,
> +                                        GuestDriverService *service,
> +                                        Error **errp)
> +{
> +    g_autofree void *version_info =3D NULL;
> +    VS_FIXEDFILEINFO *fixed_info =3D NULL;
> +    PVOID old_redirection =3D NULL;
> +    DWORD ignored;
> +    DWORD version_size;
> +    UINT fixed_info_len;
> +    bool redirection_disabled;
> +    bool version_loaded =3D false;
> +
> +    redirection_disabled =3D
> +        Wow64DisableWow64FsRedirection(&old_redirection);
> +
> +    version_size =3D GetFileVersionInfoSizeW(path, &ignored);
> +    if (version_size !=3D 0) {
> +        version_info =3D g_malloc(version_size);
> +        version_loaded =3D GetFileVersionInfoW(path, 0, version_size,
> +                                             version_info);
> +    }
> +
> +    if (redirection_disabled &&
> +        !Wow64RevertWow64FsRedirection(old_redirection)) {
> +        error_setg_win32(errp, GetLastError(),
> +                         "failed to restore WOW64 filesystem redirection=
 "
> +                         "for driver service '%s'", service->name);
> +        return false;
> +    }
> +
> +    if (!version_loaded) {
> +        return true;
> +    }
> +
> +    if (VerQueryValueW(version_info, L"\\", (void **)&fixed_info,
> +                       &fixed_info_len) &&
> +        fixed_info_len >=3D sizeof(*fixed_info) &&
> +        fixed_info->dwSignature =3D=3D VS_FFI_SIGNATURE) {
> +        service->version =3D g_strdup_printf(
> +            "%u.%u.%u.%u",
> +            HIWORD(fixed_info->dwFileVersionMS),
> +            LOWORD(fixed_info->dwFileVersionMS),
> +            HIWORD(fixed_info->dwFileVersionLS),
> +            LOWORD(fixed_info->dwFileVersionLS));
> +    }
> +
> +    service->vendor =3D ga_get_file_vendor(version_info);
> +    return true;
> +}
> +
> +/*
> + * Add optional configuration and binary metadata for one driver service=
.
> + * Ordinary per-service lookup failures leave optional fields unset.
> + */
> +static bool ga_get_driver_service_config(SC_HANDLE manager,
> +                                         const WCHAR *name,
> +                                         GuestDriverService *service,
> +                                         Error **errp)
> +{
> +    SC_HANDLE handle;
> +    g_autofree QUERY_SERVICE_CONFIGW *config =3D NULL;
> +    g_autofree WCHAR *resolved_path =3D NULL;
> +    DWORD size =3D 0;
> +    DWORD err;
> +    bool success =3D true;
> +
> +    handle =3D OpenServiceW(manager, name, SERVICE_QUERY_CONFIG);
> +    if (handle =3D=3D NULL) {
> +        slog("failed to open configuration for driver service '%s', "
> +             "error=3D%lu", service->name, GetLastError());
> +        return true;
> +    }
> +
> +    QueryServiceConfigW(handle, NULL, 0, &size);
> +    err =3D GetLastError();
> +    if (err !=3D ERROR_INSUFFICIENT_BUFFER) {
> +        slog("failed to get configuration size for driver service '%s', =
"
> +             "error=3D%lu", service->name, err);
> +        goto out;
> +    }
> +
> +    config =3D g_malloc(size);
> +    if (!QueryServiceConfigW(handle, config, size, &size)) {
> +        slog("failed to get configuration for driver service '%s', "
> +             "error=3D%lu", service->name, GetLastError());
> +        goto out;
> +    }
> +
> +    if (config->lpBinaryPathName =3D=3D NULL ||
> +        config->lpBinaryPathName[0] =3D=3D L'\0') {
> +        goto out;
> +    }
> +
> +    service->driver_path =3D g_utf16_to_utf8(config->lpBinaryPathName, -=
1,
> +                                           NULL, NULL, NULL);
> +
> +    resolved_path =3D ga_resolve_driver_path(config->lpBinaryPathName);
> +    if (resolved_path !=3D NULL &&
> +        !ga_get_driver_file_metadata(resolved_path, service, errp)) {
> +        success =3D false;
> +    }
> +
> +out:
> +    CloseServiceHandle(handle);
> +    return success;
> +}
> +
> +GuestDriverServiceList *qmp_guest_get_driver_services(Error **errp)
> +{
> +    GuestDriverServiceList *head =3D NULL, **tail =3D &head;
> +    g_autofree BYTE *buffer =3D NULL;
> +    SC_HANDLE manager =3D NULL;
> +    DWORD buffer_size =3D 256 * 1024;
> +    DWORD bytes_needed;
> +    DWORD services_returned;
> +    DWORD resume =3D 0;
> +    DWORD err;
> +    bool complete;
> +    bool success =3D false;
> +
> +    manager =3D OpenSCManagerW(NULL, NULL, SC_MANAGER_ENUMERATE_SERVICE)=
;
> +    if (manager =3D=3D NULL) {
> +        error_setg_win32(errp, GetLastError(),
> +                         "failed to open service control manager");
> +        goto out;
> +    }
> +
> +    buffer =3D g_malloc(buffer_size);
> +    do {
> +        ENUM_SERVICE_STATUS_PROCESSW *services;
> +        DWORD i;
> +
> +        bytes_needed =3D 0;
> +        services_returned =3D 0;
> +        complete =3D EnumServicesStatusExW(manager, SC_ENUM_PROCESS_INFO=
,
> +                                         SERVICE_DRIVER, SERVICE_STATE_A=
LL,
> +                                         buffer, buffer_size, &bytes_nee=
ded,
> +                                         &services_returned, &resume, NU=
LL);
> +        if (!complete) {
> +            err =3D GetLastError();
> +            if (err !=3D ERROR_MORE_DATA) {
> +                error_setg_win32(errp, err,
> +                                 "failed to enumerate driver services");
> +                goto out;
> +            }
> +            if (services_returned =3D=3D 0) {
> +                error_setg(errp, "driver service enumeration made no "
> +                           "progress (buffer needs %lu bytes)", bytes_ne=
eded);
> +                goto out;
> +            }
> +        }
> +
> +        services =3D (ENUM_SERVICE_STATUS_PROCESSW *)buffer;
> +        for (i =3D 0; i < services_returned; i++) {
> +            g_autoptr(GuestDriverService) service =3D NULL;
> +
> +            service =3D g_new0(GuestDriverService, 1);
> +            service->name =3D ga_utf16_to_utf8_required(
> +                services[i].lpServiceName, "service name", errp);
> +            if (service->name =3D=3D NULL) {
> +                goto out;
> +            }
> +            service->status =3D ga_driver_service_status(
> +                services[i].ServiceStatusProcess.dwCurrentState);
> +            if (service->status =3D=3D GUEST_DRIVER_SERVICE_STATUS_UNKNO=
WN) {
> +                slog("driver service '%s' has unknown state %lu",
> +                     service->name,
> +                     services[i].ServiceStatusProcess.dwCurrentState);
> +            }
> +
> +            if (!ga_get_driver_service_config(manager,
> +                                              services[i].lpServiceName,
> +                                              service, errp)) {
> +                goto out;
> +            }
> +            QAPI_LIST_APPEND(tail, g_steal_pointer(&service));
> +        }
> +    } while (!complete);
> +    success =3D true;
> +
> +out:
> +    if (manager !=3D NULL) {
> +        CloseServiceHandle(manager);
> +    }
> +    if (!success) {
> +        qapi_free_GuestDriverServiceList(head);
> +        head =3D NULL;
> +    }
> +    return head;
> +}
> +
> +
>  char *qga_get_host_name(Error **errp)
>  {
>      wchar_t tmp[MAX_COMPUTERNAME_LENGTH + 1];
> diff --git a/qga/meson.build b/qga/meson.build
> index cfa2157efb..15860d938d 100644
> --- a/qga/meson.build
> +++ b/qga/meson.build
> @@ -94,8 +94,9 @@ qga_ss =3D qga_ss.apply({})
>  gen_tlb =3D []
>  qga_libs =3D []
>  if host_os =3D=3D 'windows'
> -  qga_libs +=3D ['-lws2_32', '-lwinmm', '-lpowrprof', '-lwtsapi32', '-lw=
ininet', '-liphlpapi', '-lnetapi32',
> -               '-lsetupapi', '-lcfgmgr32', '-luserenv', '-lpdh' ]
> +  qga_libs +=3D ['-lws2_32', '-lwinmm', '-lpowrprof', '-lwtsapi32',
> +               '-lwininet', '-liphlpapi', '-lnetapi32', '-lsetupapi',
> +               '-lcfgmgr32', '-luserenv', '-lpdh', '-lversion' ]
>    if have_qga_vss
>      qga_libs +=3D ['-lole32', '-loleaut32', '-lshlwapi', '-Wl,--enable-s=
tdcall-fixup']
>      subdir('vss-win32')
> diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
> index 081c99bc74..913fe25924 100644
> --- a/qga/qapi-schema.json
> +++ b/qga/qapi-schema.json
> @@ -1590,6 +1590,33 @@
>    'returns': ['GuestDeviceInfo'],
>    'if': 'CONFIG_WIN32' }
>
> +##
> +# @GuestDriverServiceStatus:
> +#
> +# @stopped: the service is stopped
> +#
> +# @start-pending: the service is starting
> +#
> +# @stop-pending: the service is stopping
> +#
> +# @running: the service is running
> +#
> +# @continue-pending: the service is resuming
> +#
> +# @pause-pending: the service is pausing
> +#
> +# @paused: the service is paused
> +#
> +# @unknown: SCM returned a service state not recognized by this
> +#     QGA version
> +#
> +# Since: 11.2
> +##
> +{ 'enum': 'GuestDriverServiceStatus',
> +  'data': [ 'stopped', 'start-pending', 'stop-pending', 'running',
> +            'continue-pending', 'pause-pending', 'paused', 'unknown' ],
> +  'if': 'CONFIG_WIN32' }
> +
>  ##
>  # @GuestDriverPackage:
>  #
> @@ -1610,6 +1637,26 @@
>              '*vendor': 'str' },
>    'if': 'CONFIG_WIN32' }
>
> +##
> +# @GuestDriverService:
> +#
> +# @name: service name
> +#
> +# @driver-path: driver binary path configured in the service database
> +#
> +# @version: four-part FileVersion from the driver binary
> +#
> +# @vendor: CompanyName from the driver binary
> +#
> +# @status: current service status
> +#
> +# Since: 11.2
> +##
> +{ 'struct': 'GuestDriverService',
> +  'data': { 'name': 'str', '*driver-path': 'str', '*version': 'str',
> +            '*vendor': 'str', 'status': 'GuestDriverServiceStatus' },
> +  'if': 'CONFIG_WIN32' }
> +
>  ##
>  # @guest-get-driver-packages:
>  #
> @@ -1621,6 +1668,17 @@
>    'returns': ['GuestDriverPackage'],
>    'if': 'CONFIG_WIN32' }
>
> +##
> +# @guest-get-driver-services:
> +#
> +# Retrieve registered driver services in the guest.
> +#
> +# Since: 11.2
> +##
> +{ 'command': 'guest-get-driver-services',
> +  'returns': ['GuestDriverService'],
> +  'if': 'CONFIG_WIN32' }
> +
>  ##
>  # @GuestAuthorizedKeys:
>  #
> --
> 2.55.0
>
>


--=20
Marc-Andr=C3=A9 Lureau

