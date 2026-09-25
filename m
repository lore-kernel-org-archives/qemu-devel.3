Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D000FC9830D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 07:03:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9zx6-0001BI-8e; Fri, 25 Sep 2026 03:02:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1x9zwe-0001Ac-GM
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 03:02:15 -0400
Received: from mail-dy2-x10.google.com ([2607:f8b0:4864:36::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1x9zwZ-0004qT-3i
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 03:02:07 -0400
Received: by mail-dy2-x10.google.com with SMTP id
 5a478bee46e88-3396cec93b6so592766eec.3
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 00:02:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790319721; cv=none;
 d=google.com; s=arc-20260327;
 b=L0yZXJ6MfVNLNvsAVA/Z3Kyydcd4PFwbH8Md51R+bCWyDpY0WGWS/+SeLVhmuTSKF6
 /t0CoX0EDtA7Bw6uDRtnLP+uFEnGbCF0uTzlvupRw6sbArO3XinDy5E+8TuliitHQkrX
 jbmXyVgd8MFN185ue4xQJ3FSxkQez0cFN7krTtnX6UXT8TvLPL0Kfrg3mzt9HEnIBa67
 yljMaQ9eKnPZWZZgzWu0mJeFr40IFIceiEoEf++WySl82OTSyBPtk8/Dtny7e3s+ckiG
 hrP9tDlmWVF7I36Zi34pcm5lBga7Afx4PLNgVeauYlXJjgNI0dNvAQailUhSvzYMAtDc
 JkVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=MBvYWmiuhg/vnxlFOxP/1GR1/JHWwAhFuIoviofeAvU=;
 fh=D9VG/L00r1mQI9nuDCsKGgYqRVNYOKww3AuKS33NJKE=;
 b=ecdSoPsdidXP24yacqMRS/rsxpG9+PBRkMNDGsvOavMiWVGdE5W+TYnVAdyCTAWzTf
 2hkFI9rOO+U8LulhmbxJT4woKY72hXIvvd8wea3vIhO0QDqR+/Oy1N5DX2EZFYUVFJr3
 uhMOdyEs1lxsfj+MvwV7Joe+nxivchpjHI87+2G3s54Zdu4FEgKAoRyQlnlYChmhxW/9
 zuWxBbQTLM3vRYJSOuiX0Il3zj9WQzUZuJcMLzkA6r0d1AvYI06LSWxzJbqZMQyTfS2d
 Oa1p7l4Ef2dPDSVSbvnufPjiSx8NeAZasTtxVOja2VD3xEvwjvwKH6w2UuTpy+lX1atu
 c/ig==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790319721; x=1790924521; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=MBvYWmiuhg/vnxlFOxP/1GR1/JHWwAhFuIoviofeAvU=;
 b=i/r5ligvBQBYJ9kvkH2qU+HEMa92LyB14gbrkAEvb72QlvLC+fTQq7z/T6rR+3fDZc
 oxu2uYXaAdzGGOorueDBG6/F4UwkCfF8Y8bJJnWHZR5ZRVh63J2J5p7Px4ogTg1Ktdiw
 RzTNDJ1Gr/ywMIp3GtENxDKC/zOqiBgZnuKLUl4mAnDICRzmv9b8fN6flhjVWxZV4gak
 2ukBPTkjBQhQo+R2O6cc9zlT9Cz3KTbCA6LYHLZQ3//cnZtx1f2o3XobTQAuunnTZ73D
 9ICQfmCbiC6XMgapAXHOpjGqpB67tuP0GmX/7GpKFZ7HdvrNPkH5cm6Nc9+pPbVXumml
 Lk9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790319721; x=1790924521;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MBvYWmiuhg/vnxlFOxP/1GR1/JHWwAhFuIoviofeAvU=;
 b=uuQRVsIgwXv8XnQp4EyinUEAtj09Sf+KMttcMCN9V6VFO1ArrSZC07+8D7JkME+7Nb
 76s7s0TTg3wSiEUYa/izNKYG8ki40TKBiTWo9B2szS8XWRftPVRi0hSKdnxqMvdyKbKm
 yiniWukUPCuaijqq+ssBXxqWtZ7E+TqtKGbIVRl13lP3yEupUmwEALf8Ge0Nou1wTaAI
 2qUzZGLE3WktweRiAPuY/dYdlOEZde2KUlBYSuipe8bcflQNxYwNS4gYiJr9+kfKx3Aa
 YtEpDPd62s/U9BKJl1qX90h4SdrefpQ1wAhY/WnVtxtQ69zVk7xkVNLcQh6xTgs9mJqc
 PshQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxBwHdOCWAmObK+BQUQll9OBRCBKhuM4v2BfB7JMXPz/RQ/wN4lG+T+py8UvLJxJlorN3TYMjSaezq2@nongnu.org
X-Gm-Message-State: AFuF++my7ZO7INxyKzYOTpq3KFOpMAGYl0RuMdeMU0tXJ6nrLlXl1PrD
 a48g3kVrLUWOrSXqerAVq/f9Z7sd20Rr830WH2Gdh8WnpM5k4EwGic3XLYNMbQyWv8AsAmmijc8
 zloEjyDaGQIdufx/SWtaeqpecKioFuFA=
X-Gm-Gg: AYBFou2DRu5+JALlKoRtvtTw2T8tfC+QkRmEPqokIgv4wvWeDwu4Povfx9URtTCgxoe
 U0JOUoYAgFZkqQQyPQlyGmPMFlKXpZQ8/DOsaqdo9klB543AZeIezLgxjKC/QuIzmPWDtSr62TG
 4xR2HNHtF6UT8qxNln7DPEEoOa9dkE4ayYRPRtkG86sxMpf51+Wd7+eAbgs4np34QNaXDoRKQBx
 IALLMB8zo0emzujOxF8bG7FOdpvlj6Zj3aExM5GomPDO1Pf1Veiu7flk7bQo+iqBZ6SGeyDrbso
 Kn5hAtsSkfLYTfe1LGfRtUCrIzN+kzBip8R9NTItfQfS7j6Ham+gBSKAEtcwXrNCtDl36vs/jol
 /GE2W2aniWuM=
X-Received: by 2002:a05:693c:87d8:b0:33e:bbcc:eb99 with SMTP id
 5a478bee46e88-34001eff31fmr3460448eec.18.1790319720705; Fri, 25 Sep 2026
 00:02:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260924154424.3786199-1-eashurov@redhat.com>
 <179027887067.2199270.3360769883164272952.b4-review@b4>
 <CAPMcbCo0YzSVJtrYoOO80-vRB=qDmjT-sbbaEANbyED7phUVww@mail.gmail.com>
In-Reply-To: <CAPMcbCo0YzSVJtrYoOO80-vRB=qDmjT-sbbaEANbyED7phUVww@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Fri, 25 Sep 2026 11:01:48 +0400
X-Gm-Features: AclHuK-nid0_c8BWylAc2j5ZoMO0doM12ZuRFGo4Tsvf82QElLCuogL7OrbwtvI
Message-ID: <CAJ+F1C+3QX6iab99WY1zYsmDruDHG3ynmRyZ4+T3HYzRZEi7cQ@mail.gmail.com>
Subject: Re: [PATCH] qga: Add guest-get-drivers command for Windows
To: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Cc: Elizabeth Ashurov <eashurov@redhat.com>, qemu-devel@nongnu.org,
 dholler@redhat.com, 
 armbru@redhat.com, fdeutsch@redhat.com, yvugenfi@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:36::10;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-dy2-x10.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249, SPF_HELO_NONE=0.001,
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

Hi

On Fri, Sep 25, 2026 at 10:54=E2=80=AFAM Kostiantyn Kostiuk <kkostiuk@redha=
t.com> wrote:
>
>
>
>
> On Thu, Sep 24, 2026 at 10:41=E2=80=AFPM <marcandre.lureau@redhat.com> wr=
ote:
>>
>> > Add a new guest-get-drivers command that reports two independent lists
>> > of Windows driver information:
>> >
>> >  - packages: out-of-box driver packages enumerated with the DISM API
>> >    (DismGetDrivers). Each entry includes the published INF name,
>> >    original INF name, version, and provider.
>> >  - services: registered driver services enumerated with the Service
>> >    Control Manager (EnumServicesStatusExW). Each entry includes the
>> >    service name, configured binary path, current SCM status, and
>> >    FileVersion and CompanyName metadata from the driver binary.
>> >
>> > Load DismApi.dll dynamically with LoadLibraryExW so that its absence
>> > does not prevent qemu-ga from starting. Initialize DISM lazily once pe=
r
>> > QGA process and open a separate online DISM session for each command
>> > invocation, with process cleanup registered through ga_command_state_a=
dd.
>> >
>> > Normalize driver binary paths from the service database before reading
>> > version resources, including SystemRoot, environment-variable, NT-pref=
ix,
>> > and relative path forms.
>> >
>> > Link against version.dll (-lversion) for the GetFileVersionInfo and
>> > VerQueryValue APIs.
>> >
>> > Signed-off-by: Elizabeth Ashurov <eashurov@redhat.com>
>> > Message-ID: <20260924154424.3786199-1-eashurov@redhat.com>
>> >
>> > diff --git a/qga/commands-win32.c b/qga/commands-win32.c
>> > index 2bf5581aaa72..0dc94d808e35 100644
>> > --- a/qga/commands-win32.c
>> > +++ b/qga/commands-win32.c
>> > @@ -28,6 +28,8 @@
>> >  #include <wtsapi32.h>
>> >  #include <wininet.h>
>> >  #include <pdh.h>
>> > +#include <dismapi.h>
>> > +#include <winver.h>
>> >
>> >  #include "guest-agent-core.h"
>> >  #include "vss-win32.h"
>> > @@ -1981,12 +1983,15 @@ done:
>> >      g_free(rawpasswddata);
>> >  }
>> >
>> > +static void ga_cleanup_dism_api(void);
>> > +
>> >  /* register init/cleanup routines for stateful command groups */
>> >  void ga_command_state_init(GAState *s, GACommandState *cs)
>> >  {
>> >      if (!vss_initialized()) {
>> >          ga_command_state_add(cs, NULL, guest_fsfreeze_cleanup);
>> >      }
>> > +    ga_command_state_add(cs, NULL, ga_cleanup_dism_api);
>> >  }
>> >
>> >  /* MINGW is missing two fields: IncomingFrames & OutgoingFrames */
>> > @@ -2455,6 +2460,684 @@ GuestDeviceInfoList *qmp_guest_get_devices(Err=
or **errp)
>> >      return head;
>> >  }
>> >
>> > +static void error_setg_dism(Error **errp, HRESULT hr, const char *msg=
)
>> > +{
>> > +    if (HRESULT_FACILITY(hr) =3D=3D FACILITY_WIN32) {
>> > +        error_setg_win32(errp, HRESULT_CODE(hr), "%s", msg);
>> > +    } else {
>> > +        error_setg(errp, "%s (HRESULT 0x%08" PRIx32 ")", msg,
>> > +                   (uint32_t)hr);
>> > +    }
>> > +}
>> > +
>> > +static void ga_log_dism_error(HRESULT hr, const char *msg)
>> > +{
>> > +    Error *local_err =3D NULL;
>> > +
>> > +    error_setg_dism(&local_err, hr, msg);
>> > +    slog("%s", error_get_pretty(local_err));
>> > +    error_free(local_err);
>> > +}
>> > +
>> > +typedef HRESULT WINAPI QGADismInitializeFunc(
>> > +    DismLogLevel log_level, PCWSTR log_file_path, PCWSTR scratch_dire=
ctory);
>> > +typedef HRESULT WINAPI QGADismShutdownFunc(void);
>> > +typedef HRESULT WINAPI QGADismOpenSessionFunc(
>> > +    PCWSTR image_path, PCWSTR windows_directory, PCWSTR system_drive,
>> > +    DismSession *session);
>> > +typedef HRESULT WINAPI QGADismCloseSessionFunc(DismSession session);
>> > +typedef HRESULT WINAPI QGADismGetDriversFunc(
>> > +    DismSession session, WINBOOL all_drivers,
>> > +    DismDriverPackage **driver_package, unsigned int *driver_count);
>> > +typedef HRESULT WINAPI QGADismDeleteFunc(void *dism_structure);
>> > +
>> > +typedef struct QGADismApi {
>> > +    HMODULE module;
>> > +    QGADismInitializeFunc *initialize;
>> > +    QGADismShutdownFunc *shutdown;
>> > +    QGADismOpenSessionFunc *open_session;
>> > +    QGADismCloseSessionFunc *close_session;
>> > +    QGADismGetDriversFunc *get_drivers;
>> > +    QGADismDeleteFunc *delete;
>> > +} QGADismApi;
>> > +
>> > +static QGADismApi dism_api;
>> > +static bool dism_initialized;
>> > +
>> > +static FARPROC ga_get_dism_function(HMODULE module, const char *name,
>> > +                                    Error **errp)
>> > +{
>> > +    FARPROC function =3D GetProcAddress(module, name);
>> > +
>> > +    if (function =3D=3D NULL) {
>> > +        error_setg_win32(errp, GetLastError(),
>> > +                         "failed to resolve %s from DismApi.dll", nam=
e);
>> > +    }
>> > +    return function;
>> > +}
>> > +
>> > +static void ga_unload_dism_api(QGADismApi *api)
>> > +{
>> > +    if (api->module !=3D NULL && !FreeLibrary(api->module)) {
>> > +        slog("failed to unload DismApi.dll, error=3D%lu", GetLastErro=
r());
>> > +    }
>> > +    memset(api, 0, sizeof(*api));
>> > +}
>> > +
>> > +/*
>> > + * Load DISM from System32 and resolve its entry points at runtime, s=
o a
>> > + * missing DismApi.dll prevents only this command rather than QGA sta=
rtup.
>> > + */
>> > +static bool ga_load_dism_api(QGADismApi *api, Error **errp)
>> > +{
>> > +    api->module =3D LoadLibraryExW(L"DismApi.dll", NULL,
>> > +                                 LOAD_LIBRARY_SEARCH_SYSTEM32);
>> > +    if (api->module =3D=3D NULL) {
>> > +        error_setg_win32(errp, GetLastError(),
>> > +                         "failed to load DismApi.dll");
>> > +        return false;
>> > +    }
>> > +
>> > +    api->initialize =3D (QGADismInitializeFunc *)
>> > +        ga_get_dism_function(api->module, "DismInitialize", errp);
>> > +    if (api->initialize =3D=3D NULL) {
>> > +        goto fail;
>> > +    }
>> > +    api->shutdown =3D (QGADismShutdownFunc *)
>> > +        ga_get_dism_function(api->module, "DismShutdown", errp);
>> > +    if (api->shutdown =3D=3D NULL) {
>> > +        goto fail;
>> > +    }
>> > +    api->open_session =3D (QGADismOpenSessionFunc *)
>> > +        ga_get_dism_function(api->module, "DismOpenSession", errp);
>> > +    if (api->open_session =3D=3D NULL) {
>> > +        goto fail;
>> > +    }
>> > +    api->close_session =3D (QGADismCloseSessionFunc *)
>> > +        ga_get_dism_function(api->module, "DismCloseSession", errp);
>> > +    if (api->close_session =3D=3D NULL) {
>> > +        goto fail;
>> > +    }
>> > +    api->get_drivers =3D (QGADismGetDriversFunc *)
>> > +        ga_get_dism_function(api->module, "DismGetDrivers", errp);
>> > +    if (api->get_drivers =3D=3D NULL) {
>> > +        goto fail;
>> > +    }
>> > +    api->delete =3D (QGADismDeleteFunc *)
>> > +        ga_get_dism_function(api->module, "DismDelete", errp);
>> > +    if (api->delete =3D=3D NULL) {
>> > +        goto fail;
>> > +    }
>> > +
>> > +    return true;
>> > +
>> > +fail:
>> > +    ga_unload_dism_api(api);
>> > +    return false;
>> > +}
>> > +
>> > +static bool ga_ensure_dism_api(Error **errp)
>> > +{
>> > +    HRESULT hr;
>> > +
>> > +    if (dism_initialized) {
>> > +        return true;
>> > +    }
>> > +
>> > +    if (!ga_load_dism_api(&dism_api, errp)) {
>> > +        return false;
>> > +    }
>> > +
>> > +    hr =3D dism_api.initialize(DismLogErrors, NULL, NULL);
>> > +    if (FAILED(hr)) {
>> > +        error_setg_dism(errp, hr, "failed to initialize DISM");
>> > +        ga_unload_dism_api(&dism_api);
>> > +        return false;
>> > +    }
>> > +
>> > +    dism_initialized =3D true;
>> > +    return true;
>> > +}
>> > +
>> > +static void ga_cleanup_dism_api(void)
>> > +{
>> > +    HRESULT hr;
>> > +
>> > +    if (dism_initialized) {
>> > +        hr =3D dism_api.shutdown();
>> > +        if (FAILED(hr)) {
>> > +            ga_log_dism_error(hr, "failed to shut down DISM");
>> > +        }
>> > +        dism_initialized =3D false;
>> > +    }
>> > +
>> > +    ga_unload_dism_api(&dism_api);
>> > +}
>> > +
>> > +static char *ga_utf16_to_utf8_required(const WCHAR *str, const char *=
name,
>> > +                                       Error **errp)
>> > +{
>> > +    g_autoptr(GError) gerr =3D NULL;
>> > +    char *ret;
>> > +
>> > +    if (str =3D=3D NULL || str[0] =3D=3D L'\0') {
>> > +        error_setg(errp, "driver %s is missing", name);
>> > +        return NULL;
>> > +    }
>> > +
>> > +    ret =3D g_utf16_to_utf8(str, -1, NULL, NULL, &gerr);
>> > +    if (ret =3D=3D NULL) {
>> > +        error_setg(errp, "failed to convert driver %s to UTF-8: %s",
>> > +                   name, gerr->message);
>> > +    }
>> > +    return ret;
>> > +}
>> > +
>> > +static const WCHAR *ga_windows_path_basename(const WCHAR *path)
>> > +{
>> > +    const WCHAR *name =3D path;
>> > +
>> > +    while (*path !=3D L'\0') {
>> > +        if (*path =3D=3D L'\\' || *path =3D=3D L'/') {
>> > +            name =3D path + 1;
>> > +        }
>> > +        path++;
>> > +    }
>> > +    return name;
>> > +}
>> > +
>> > +static GuestDriverPackageList *ga_get_driver_packages(Error **errp)
>> > +{
>> > +    GuestDriverPackageList *head =3D NULL, **tail =3D &head;
>> > +    DismSession session =3D DISM_SESSION_DEFAULT;
>> > +    DismDriverPackage *drivers =3D NULL;
>> > +    Error *local_err =3D NULL;
>> > +    HRESULT hr;
>> > +    UINT count =3D 0;
>> > +    UINT i;
>> > +
>> > +    if (!ga_ensure_dism_api(&local_err)) {
>> > +        goto out;
>> > +    }
>> > +
>> > +    hr =3D dism_api.open_session(DISM_ONLINE_IMAGE, NULL, NULL, &sess=
ion);
>> > +    if (FAILED(hr)) {
>> > +        error_setg_dism(&local_err, hr,
>> > +                        "failed to open online DISM session");
>> > +        goto out;
>> > +    }
>> > +
>> > +    /*
>> > +     * FALSE retrieves only out-of-box drivers, meaning drivers that =
were
>> > +     * not originally included in the Windows image. See:
>> > +     * https://learn.microsoft.com/en-us/windows-hardware/manufacture=
/desktop/dism/dismgetdrivers-function
>> > +     */
>> > +    hr =3D dism_api.get_drivers(session, FALSE, &drivers, &count);
>> > +    if (FAILED(hr)) {
>> > +        error_setg_dism(&local_err, hr,
>> > +                        "failed to enumerate driver packages");
>> > +        goto out;
>> > +    }
>> > +
>> > +    for (i =3D 0; i < count; i++) {
>> > +        g_autoptr(GuestDriverPackage) package =3D NULL;
>> > +
>> > +        package =3D g_new0(GuestDriverPackage, 1);
>> > +        package->name =3D ga_utf16_to_utf8_required(drivers[i].Publis=
hedName,
>> > +                                                  "package name", &lo=
cal_err);
>> > +        if (package->name =3D=3D NULL) {
>> > +            goto out;
>> > +        }
>> > +
>> > +        if (drivers[i].OriginalFileName !=3D NULL &&
>> > +            drivers[i].OriginalFileName[0] !=3D L'\0') {
>> > +            const WCHAR *original_name =3D ga_windows_path_basename(
>> > +                drivers[i].OriginalFileName);
>> > +
>> > +            if (original_name[0] !=3D L'\0') {
>> > +                package->original_name =3D g_utf16_to_utf8(
>> > +                    original_name, -1, NULL, NULL, NULL);
>> > +            }
>> > +        }
>> > +
>> > +        package->version =3D g_strdup_printf("%u.%u.%u.%u",
>> > +                                           drivers[i].MajorVersion,
>> > +                                           drivers[i].MinorVersion,
>> > +                                           drivers[i].Build,
>> > +                                           drivers[i].Revision);
>> > +
>> > +        if (drivers[i].ProviderName !=3D NULL &&
>> > +            drivers[i].ProviderName[0] !=3D L'\0') {
>> > +            package->vendor =3D g_utf16_to_utf8(drivers[i].ProviderNa=
me, -1,
>> > +                                              NULL, NULL, NULL);
>> > +        }
>> > +
>> > +        QAPI_LIST_APPEND(tail, g_steal_pointer(&package));
>> > +    }
>> > +
>> > +out:
>> > +    if (drivers !=3D NULL) {
>> > +        hr =3D dism_api.delete(drivers);
>> > +        if (FAILED(hr)) {
>> > +            if (local_err =3D=3D NULL) {
>> > +                error_setg_dism(&local_err, hr,
>> > +                                "failed to release driver package dat=
a");
>> > +            } else {
>> > +                ga_log_dism_error(hr,
>> > +                                  "failed to release driver package d=
ata");
>> > +            }
>> > +        }
>> > +    }
>> > +    if (session !=3D DISM_SESSION_DEFAULT) {
>> > +        hr =3D dism_api.close_session(session);
>> > +        if (FAILED(hr)) {
>> > +            if (local_err =3D=3D NULL) {
>> > +                error_setg_dism(&local_err, hr,
>> > +                                "failed to close online DISM session"=
);
>> > +            } else {
>> > +                ga_log_dism_error(hr,
>> > +                                  "failed to close online DISM sessio=
n");
>> > +            }
>> > +        }
>> > +    }
>> > +    if (local_err !=3D NULL) {
>> > +        qapi_free_GuestDriverPackageList(head);
>> > +        head =3D NULL;
>> > +        error_propagate(errp, local_err);
>> > +    }
>> > +    return head;
>> > +}
>> > +
>> > +static bool ga_driver_service_status(DWORD state,
>> > +                                     GuestDriverServiceStatus *status=
)
>> > +{
>> > +    switch (state) {
>> > +    case SERVICE_STOPPED:
>> > +        *status =3D GUEST_DRIVER_SERVICE_STATUS_STOPPED;
>> > +        return true;
>> > +    case SERVICE_START_PENDING:
>> > +        *status =3D GUEST_DRIVER_SERVICE_STATUS_START_PENDING;
>> > +        return true;
>> > +    case SERVICE_STOP_PENDING:
>> > +        *status =3D GUEST_DRIVER_SERVICE_STATUS_STOP_PENDING;
>> > +        return true;
>> > +    case SERVICE_RUNNING:
>> > +        *status =3D GUEST_DRIVER_SERVICE_STATUS_RUNNING;
>> > +        return true;
>> > +    case SERVICE_CONTINUE_PENDING:
>> > +        *status =3D GUEST_DRIVER_SERVICE_STATUS_CONTINUE_PENDING;
>> > +        return true;
>> > +    case SERVICE_PAUSE_PENDING:
>> > +        *status =3D GUEST_DRIVER_SERVICE_STATUS_PAUSE_PENDING;
>> > +        return true;
>> > +    case SERVICE_PAUSED:
>> > +        *status =3D GUEST_DRIVER_SERVICE_STATUS_PAUSED;
>> > +        return true;
>> > +    default:
>> > +        return false;
>> > +    }
>> > +}
>> > +
>> > +/* Convert an SCM driver path into a path usable by Win32 file APIs. =
*/
>> > +static WCHAR *ga_resolve_driver_path(const WCHAR *path)
>> > +{
>> > +    WCHAR windows_dir[MAX_PATH + 1];
>> > +    g_autofree WCHAR *trimmed =3D NULL;
>> > +    g_autofree WCHAR *expanded =3D NULL;
>> > +    const WCHAR *start =3D path;
>> > +    const WCHAR *end;
>> > +    const WCHAR *remainder =3D NULL;
>> > +    size_t prefix_len;
>> > +    size_t path_len;
>> > +    size_t windows_len;
>> > +    DWORD expanded_len;
>> > +    UINT windows_dir_len;
>> > +
>> > +    while (*start !=3D L'\0' && iswspace(*start)) {
>> > +        start++;
>> > +    }
>> > +    end =3D start + wcslen(start);
>> > +    while (end > start && iswspace(end[-1])) {
>> > +        end--;
>> > +    }
>> > +    if (end - start >=3D 2 && start[0] =3D=3D L'"' && end[-1] =3D=3D =
L'"') {
>> > +        start++;
>> > +        end--;
>> > +    }
>> > +    if (end =3D=3D start) {
>> > +        return NULL;
>> > +    }
>> > +
>> > +    path_len =3D end - start;
>> > +    trimmed =3D g_new(WCHAR, path_len + 1);
>> > +    memcpy(trimmed, start, path_len * sizeof(WCHAR));
>> > +    trimmed[path_len] =3D L'\0';
>> > +
>> > +    expanded_len =3D ExpandEnvironmentStringsW(trimmed, NULL, 0);
>> > +    if (expanded_len =3D=3D 0) {
>> > +        return NULL;
>> > +    }
>> > +    expanded =3D g_new(WCHAR, expanded_len);
>> > +    path_len =3D ExpandEnvironmentStringsW(trimmed, expanded, expande=
d_len);
>> > +    if (path_len =3D=3D 0 || path_len > expanded_len) {
>> > +        return NULL;
>> > +    }
>> > +
>> > +    prefix_len =3D wcslen(L"\\SystemRoot");
>> > +    if (_wcsnicmp(expanded, L"\\SystemRoot", prefix_len) =3D=3D 0 &&
>> > +        (expanded[prefix_len] =3D=3D L'\0' ||
>> > +         expanded[prefix_len] =3D=3D L'\\' ||
>> > +         expanded[prefix_len] =3D=3D L'/')) {
>> > +        remainder =3D expanded + prefix_len;
>> > +    } else {
>> > +        prefix_len =3D wcslen(L"SystemRoot");
>> > +        if (_wcsnicmp(expanded, L"SystemRoot", prefix_len) =3D=3D 0 &=
&
>> > +            (expanded[prefix_len] =3D=3D L'\0' ||
>> > +             expanded[prefix_len] =3D=3D L'\\' ||
>> > +             expanded[prefix_len] =3D=3D L'/')) {
>> > +            remainder =3D expanded + prefix_len;
>> > +        }
>> > +    }
>> > +
>> > +    windows_dir_len =3D GetWindowsDirectoryW(windows_dir,
>> > +                                            ARRAY_SIZE(windows_dir));
>> > +    if (windows_dir_len =3D=3D 0 || windows_dir_len >=3D ARRAY_SIZE(w=
indows_dir)) {
>> > +        return NULL;
>> > +    }
>> > +    windows_len =3D windows_dir_len;
>> > +
>> > +    if (remainder !=3D NULL) {
>> > +        WCHAR *ret =3D g_new(WCHAR, windows_len + wcslen(remainder) +=
 1);
>> > +
>> > +        memcpy(ret, windows_dir, windows_len * sizeof(WCHAR));
>> > +        wcscpy(ret + windows_len, remainder);
>> > +        return ret;
>> > +    }
>> > +
>> > +    if (wcsncmp(expanded, L"\\??\\", 4) =3D=3D 0) {
>> > +        return g_memdup2(expanded + 4,
>> > +                         (wcslen(expanded + 4) + 1) * sizeof(WCHAR));
>> > +    }
>> > +
>> > +    if ((iswalpha(expanded[0]) && expanded[1] =3D=3D L':') ||
>> > +        expanded[0] =3D=3D L'\\') {
>> > +        return g_steal_pointer(&expanded);
>> > +    }
>> > +
>> > +    path_len =3D wcslen(expanded);
>> > +    start =3D expanded;
>> > +    while (*start =3D=3D L'\\' || *start =3D=3D L'/') {
>> > +        start++;
>> > +        path_len--;
>> > +    }
>> > +    {
>> > +        WCHAR *ret =3D g_new(WCHAR, windows_len + path_len + 2);
>> > +
>> > +        memcpy(ret, windows_dir, windows_len * sizeof(WCHAR));
>> > +        ret[windows_len] =3D L'\\';
>> > +        wcscpy(ret + windows_len + 1, start);
>> > +        return ret;
>> > +    }
>> > +}
>> > +
>> > +typedef struct QGAVersionTranslation {
>> > +    WORD language;
>> > +    WORD code_page;
>> > +} QGAVersionTranslation;
>> > +
>> > +/* Return CompanyName from a localized file-version string table. */
>> > +static char *ga_get_file_vendor(const void *version_info)
>> > +{
>> > +    QGAVersionTranslation *translations =3D NULL;
>> > +    static const QGAVersionTranslation fallback =3D { 0x0409, 0x04b0 =
};
>> > +    UINT translations_len =3D 0;
>> > +    UINT count =3D 0;
>> > +    UINT i;
>> > +
>> > +    if (VerQueryValueW(version_info, L"\\VarFileInfo\\Translation",
>> > +                       (void **)&translations, &translations_len) &&
>> > +        translations !=3D NULL) {
>> > +        count =3D translations_len / sizeof(*translations);
>> > +    }
>> > +
>> > +    for (i =3D 0; i <=3D count; i++) {
>> > +        const QGAVersionTranslation *translation;
>> > +        WCHAR query[64];
>> > +        WCHAR *company =3D NULL;
>> > +        UINT company_len =3D 0;
>> > +        char *vendor;
>> > +
>> > +        translation =3D i < count ? &translations[i] : &fallback;
>> > +        swprintf(query, ARRAY_SIZE(query),
>> > +                 L"\\StringFileInfo\\%04x%04x\\CompanyName",
>> > +                 translation->language, translation->code_page);
>> > +        if (!VerQueryValueW(version_info, query, (void **)&company,
>> > +                            &company_len) || company_len <=3D 1) {
>> > +            continue;
>> > +        }
>> > +        vendor =3D g_utf16_to_utf8(company, -1, NULL, NULL, NULL);
>> > +        if (vendor !=3D NULL && vendor[0] !=3D '\0') {
>> > +            return vendor;
>> > +        }
>> > +        g_free(vendor);
>> > +    }
>> > +    return NULL;
>> > +}
>> > +
>> > +/* Add optional FileVersion and CompanyName data from a driver binary=
. */
>> > +static bool ga_get_driver_file_metadata(const WCHAR *path,
>> > +                                        GuestDriverService *service,
>> > +                                        Error **errp)
>> > +{
>> > +    g_autofree void *version_info =3D NULL;
>> > +    VS_FIXEDFILEINFO *fixed_info =3D NULL;
>> > +    PVOID old_redirection =3D NULL;
>> > +    DWORD ignored;
>> > +    DWORD version_size;
>> > +    UINT fixed_info_len;
>> > +    bool redirection_disabled;
>> > +    bool version_loaded =3D false;
>> > +
>> > +    redirection_disabled =3D
>> > +        Wow64DisableWow64FsRedirection(&old_redirection);
>> > +
>> > +    version_size =3D GetFileVersionInfoSizeW(path, &ignored);
>> > +    if (version_size !=3D 0) {
>> > +        version_info =3D g_malloc(version_size);
>> > +        version_loaded =3D GetFileVersionInfoW(path, 0, version_size,
>> > +                                             version_info);
>> > +    }
>> > +
>> > +    if (redirection_disabled &&
>> > +        !Wow64RevertWow64FsRedirection(old_redirection)) {
>> > +        error_setg_win32(errp, GetLastError(),
>> > +                         "failed to restore WOW64 filesystem redirect=
ion "
>> > +                         "for driver service '%s'", service->name);
>> > +        return false;
>> > +    }
>> > +
>> > +    if (!version_loaded) {
>> > +        return true;
>> > +    }
>> > +
>> > +    if (VerQueryValueW(version_info, L"\\", (void **)&fixed_info,
>> > +                       &fixed_info_len) &&
>> > +        fixed_info_len >=3D sizeof(*fixed_info) &&
>> > +        fixed_info->dwSignature =3D=3D VS_FFI_SIGNATURE) {
>> > +        service->version =3D g_strdup_printf(
>> > +            "%u.%u.%u.%u",
>> > +            HIWORD(fixed_info->dwFileVersionMS),
>> > +            LOWORD(fixed_info->dwFileVersionMS),
>> > +            HIWORD(fixed_info->dwFileVersionLS),
>> > +            LOWORD(fixed_info->dwFileVersionLS));
>> > +    }
>> > +
>> > +    service->vendor =3D ga_get_file_vendor(version_info);
>> > +    return true;
>> > +}
>> > +
>> > +/*
>> > + * Add optional configuration and binary metadata for one driver serv=
ice.
>> > + * Ordinary per-service lookup failures leave optional fields unset.
>> > + */
>> > +static bool ga_get_driver_service_config(SC_HANDLE manager,
>> > +                                         const WCHAR *name,
>> > +                                         GuestDriverService *service,
>> > +                                         Error **errp)
>> > +{
>> > +    SC_HANDLE handle;
>> > +    g_autofree QUERY_SERVICE_CONFIGW *config =3D NULL;
>> > +    g_autofree WCHAR *resolved_path =3D NULL;
>> > +    DWORD size =3D 0;
>> > +    DWORD err;
>> > +    bool success =3D true;
>> > +
>> > +    handle =3D OpenServiceW(manager, name, SERVICE_QUERY_CONFIG);
>> > +    if (handle =3D=3D NULL) {
>> > +        slog("failed to open configuration for driver service '%s', "
>> > +             "error=3D%lu", service->name, GetLastError());
>> > +        return true;
>> > +    }
>> > +
>> > +    QueryServiceConfigW(handle, NULL, 0, &size);
>> > +    err =3D GetLastError();
>> > +    if (err !=3D ERROR_INSUFFICIENT_BUFFER) {
>> > +        slog("failed to get configuration size for driver service '%s=
', "
>> > +             "error=3D%lu", service->name, err);
>> > +        goto out;
>> > +    }
>> > +
>> > +    config =3D g_malloc(size);
>> > +    if (!QueryServiceConfigW(handle, config, size, &size)) {
>> > +        slog("failed to get configuration for driver service '%s', "
>> > +             "error=3D%lu", service->name, GetLastError());
>> > +        goto out;
>> > +    }
>> > +
>> > +    if (config->lpBinaryPathName =3D=3D NULL ||
>> > +        config->lpBinaryPathName[0] =3D=3D L'\0') {
>> > +        goto out;
>> > +    }
>> > +
>> > +    service->driver_path =3D g_utf16_to_utf8(config->lpBinaryPathName=
, -1,
>> > +                                           NULL, NULL, NULL);
>> > +
>> > +    resolved_path =3D ga_resolve_driver_path(config->lpBinaryPathName=
);
>> > +    if (resolved_path !=3D NULL &&
>> > +        !ga_get_driver_file_metadata(resolved_path, service, errp)) {
>> > +        success =3D false;
>> > +    }
>> > +
>> > +out:
>> > +    CloseServiceHandle(handle);
>> > +    return success;
>> > +}
>> > +
>> > +static GuestDriverServiceList *ga_get_driver_services(Error **errp)
>> > +{
>> > +    GuestDriverServiceList *head =3D NULL, **tail =3D &head;
>> > +    g_autofree BYTE *buffer =3D NULL;
>> > +    SC_HANDLE manager =3D NULL;
>> > +    DWORD buffer_size =3D 256 * 1024;
>> > +    DWORD bytes_needed;
>> > +    DWORD services_returned;
>> > +    DWORD resume =3D 0;
>> > +    DWORD err;
>> > +    bool complete;
>> > +    bool success =3D false;
>> > +
>> > +    manager =3D OpenSCManagerW(NULL, NULL, SC_MANAGER_ENUMERATE_SERVI=
CE);
>> > +    if (manager =3D=3D NULL) {
>> > +        error_setg_win32(errp, GetLastError(),
>> > +                         "failed to open service control manager");
>> > +        goto out;
>> > +    }
>> > +
>> > +    buffer =3D g_malloc(buffer_size);
>> > +    do {
>> > +        ENUM_SERVICE_STATUS_PROCESSW *services;
>> > +        DWORD i;
>> > +
>> > +        bytes_needed =3D 0;
>> > +        services_returned =3D 0;
>> > +        complete =3D EnumServicesStatusExW(manager, SC_ENUM_PROCESS_I=
NFO,
>> > +                                         SERVICE_DRIVER, SERVICE_STAT=
E_ALL,
>> > +                                         buffer, buffer_size, &bytes_=
needed,
>> > +                                         &services_returned, &resume,=
 NULL);
>> > +        if (!complete) {
>> > +            err =3D GetLastError();
>> > +            if (err !=3D ERROR_MORE_DATA) {
>> > +                error_setg_win32(errp, err,
>> > +                                 "failed to enumerate driver services=
");
>> > +                goto out;
>> > +            }
>> > +            if (services_returned =3D=3D 0) {
>> > +                error_setg(errp, "driver service enumeration made no =
"
>> > +                           "progress (buffer needs %lu bytes)", bytes=
_needed);
>> > +                goto out;
>> > +            }
>> > +        }
>> > +
>> > +        services =3D (ENUM_SERVICE_STATUS_PROCESSW *)buffer;
>> > +        for (i =3D 0; i < services_returned; i++) {
>> > +            g_autoptr(GuestDriverService) service =3D NULL;
>> > +
>> > +            service =3D g_new0(GuestDriverService, 1);
>> > +            service->name =3D ga_utf16_to_utf8_required(
>> > +                services[i].lpServiceName, "service name", errp);
>> > +            if (service->name =3D=3D NULL) {
>> > +                goto out;
>> > +            }
>> > +            if (!ga_driver_service_status(
>> > +                    services[i].ServiceStatusProcess.dwCurrentState,
>> > +                    &service->status)) {
>> > +                error_setg(errp, "driver service '%s' has unknown sta=
te %lu",
>> > +                           service->name,
>> > +                           services[i].ServiceStatusProcess.dwCurrent=
State);
>> > +                goto out;
>> > +            }
>>
>> An unknown dwCurrentState aborts the entire service enumeration. The sta=
tes
>> listed in GuestDriverServiceStatus cover all documented SCM values today=
, but a
>> future Windows version could add new states.
>>
>> Consider skipping the service with a slog warning instead, or adding an
>> "unknown" enum value to GuestDriverServiceStatus.
>>
>> > +
>> > +            if (!ga_get_driver_service_config(manager,
>> > +                                              services[i].lpServiceNa=
me,
>> > +                                              service, errp)) {
>> > +                goto out;
>> > +            }
>> > +            QAPI_LIST_APPEND(tail, g_steal_pointer(&service));
>> > +        }
>> > +    } while (!complete);
>> > +    success =3D true;
>> > +
>> > +out:
>> > +    if (manager !=3D NULL) {
>> > +        CloseServiceHandle(manager);
>> > +    }
>> > +    if (!success) {
>> > +        qapi_free_GuestDriverServiceList(head);
>> > +        head =3D NULL;
>> > +    }
>> > +    return head;
>> > +}
>> > +
>> > +GuestDriverInfo *qmp_guest_get_drivers(Error **errp)
>> > +{
>> > +    g_autoptr(GuestDriverInfo) info =3D g_new0(GuestDriverInfo, 1);
>> > +    Error *local_err =3D NULL;
>> > +
>> > +    info->packages =3D ga_get_driver_packages(&local_err);
>> > +    if (local_err) {
>> > +        error_propagate(errp, local_err);
>> > +        return NULL;
>> > +    }
>>
>> If DismApi.dll is missing or DismInitialize fails, it returns an error, =
even if
>> listing services could work. That's probably ok, but worth noting.
>
>
> what if we add an "error" field to the package structure, then we can ret=
urn services and package with an error about DismInitialize
>

Let's have two commands in that case. I think it makes sense anyway,
there is not much reason to aggregate the two results.

>>
>>
>> > +
>> > +    info->services =3D ga_get_driver_services(&local_err);
>> > +    if (local_err) {
>> > +        error_propagate(errp, local_err);
>> > +        return NULL;
>> > +    }
>> > +
>> > +    return g_steal_pointer(&info);
>> > +}
>> > +
>> >  char *qga_get_host_name(Error **errp)
>> >  {
>> >      wchar_t tmp[MAX_COMPUTERNAME_LENGTH + 1];
>> > diff --git a/qga/meson.build b/qga/meson.build
>> > index cfa2157efb23..15860d938d4b 100644
>> > --- a/qga/meson.build
>> > +++ b/qga/meson.build
>> > @@ -94,8 +94,9 @@ qga_ss =3D qga_ss.apply({})
>> >  gen_tlb =3D []
>> >  qga_libs =3D []
>> >  if host_os =3D=3D 'windows'
>> > -  qga_libs +=3D ['-lws2_32', '-lwinmm', '-lpowrprof', '-lwtsapi32', '=
-lwininet', '-liphlpapi', '-lnetapi32',
>> > -               '-lsetupapi', '-lcfgmgr32', '-luserenv', '-lpdh' ]
>> > +  qga_libs +=3D ['-lws2_32', '-lwinmm', '-lpowrprof', '-lwtsapi32',
>> > +               '-lwininet', '-liphlpapi', '-lnetapi32', '-lsetupapi',
>> > +               '-lcfgmgr32', '-luserenv', '-lpdh', '-lversion' ]
>> >    if have_qga_vss
>> >      qga_libs +=3D ['-lole32', '-loleaut32', '-lshlwapi', '-Wl,--enabl=
e-stdcall-fixup']
>> >      subdir('vss-win32')
>> > diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
>> > index 8cd0ba048b8d..b20cf7135a4c 100644
>> > --- a/qga/qapi-schema.json
>> > +++ b/qga/qapi-schema.json
>> > @@ -1590,6 +1590,95 @@
>> >    'returns': ['GuestDeviceInfo'],
>> >    'if': 'CONFIG_WIN32' }
>> >
>> > +##
>> > +# @GuestDriverServiceStatus:
>> > +#
>> > +# @stopped: the service is stopped
>> > +#
>> > +# @start-pending: the service is starting
>> > +#
>> > +# @stop-pending: the service is stopping
>> > +#
>> > +# @running: the service is running
>> > +#
>> > +# @continue-pending: the service is resuming
>> > +#
>> > +# @pause-pending: the service is pausing
>> > +#
>> > +# @paused: the service is paused
>> > +#
>> > +# Since: 11.2
>> > +##
>> > +{ 'enum': 'GuestDriverServiceStatus',
>> > +  'data': [ 'stopped', 'start-pending', 'stop-pending', 'running',
>> > +            'continue-pending', 'pause-pending', 'paused' ],
>> > +  'if': 'CONFIG_WIN32' }
>> > +
>> > +##
>> > +# @GuestDriverPackage:
>> > +#
>> > +# An out-of-box driver package installed in the guest.
>> > +#
>> > +# @name: published INF name
>> > +#
>> > +# @original-name: base name of the original INF file
>> > +#
>> > +# @version: four-part version from the package INF DriverVer entry
>> > +#
>> > +# @vendor: package provider from the INF metadata
>> > +#
>> > +# Since: 11.2
>> > +##
>> > +{ 'struct': 'GuestDriverPackage',
>> > +  'data': { 'name': 'str', '*original-name': 'str', 'version': 'str',
>> > +            '*vendor': 'str' },
>> > +  'if': 'CONFIG_WIN32' }
>> > +
>> > +##
>> > +# @GuestDriverService:
>> > +#
>> > +# @name: service name
>> > +#
>> > +# @driver-path: driver binary path configured in the service database
>> > +#
>> > +# @version: four-part FileVersion from the driver binary
>> > +#
>> > +# @vendor: CompanyName from the driver binary
>> > +#
>> > +# @status: current service status
>> > +#
>> > +# Since: 11.2
>> > +##
>> > +{ 'struct': 'GuestDriverService',
>> > +  'data': { 'name': 'str', '*driver-path': 'str', '*version': 'str',
>> > +            '*vendor': 'str', 'status': 'GuestDriverServiceStatus' },
>> > +  'if': 'CONFIG_WIN32' }
>> > +
>> > +##
>> > +# @GuestDriverInfo:
>> > +#
>> > +# @packages: out-of-box driver packages installed in the guest
>> > +#
>> > +# @services: registered driver services
>> > +#
>> > +# Since: 11.2
>> > +##
>> > +{ 'struct': 'GuestDriverInfo',
>> > +  'data': { 'packages': ['GuestDriverPackage'],
>> > +            'services': ['GuestDriverService'] },
>> > +  'if': 'CONFIG_WIN32' }
>> > +
>> > +##
>> > +# @guest-get-drivers:
>> > +#
>> > +# Retrieve information about Windows driver packages and services.
>> > +#
>> > +# Since: 11.2
>> > +##
>> > +{ 'command': 'guest-get-drivers',
>> > +  'returns': 'GuestDriverInfo',
>> > +  'if': 'CONFIG_WIN32' }
>> > +
>> >  ##
>> >  # @GuestAuthorizedKeys:
>> >  #
>>
>> otherwise, lgtm
>>
>> --
>> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>>

