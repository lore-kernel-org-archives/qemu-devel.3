Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41613EA3F27
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 09:53:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vq6u0-00058L-JE; Wed, 11 Feb 2026 04:52:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1vq6tu-00057s-HY
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 04:52:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1vq6ts-0008MJ-24
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 04:52:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770803566;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TFCTSypbMBgXbUToZkqq105dqFxi2qMftEDIpjYWjiI=;
 b=RCE99xuRp9VtjajVFKoEl2IY0SWH9Jk1qIo26oti2Vvm2dUGXjoxpNOSskWy8ecscrHooz
 XqIO9PEmFakzspT/GX0vat8TeFwLzU3EHDnytJBzD3gLGSMCMt0tBvCM6FN40+NozP5le1
 o+rwQAfVe0f5vc7HHP7h0H/sDlzqjag=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-3YIWOdRbNbOL4GTLOQAxNA-1; Wed, 11 Feb 2026 04:52:44 -0500
X-MC-Unique: 3YIWOdRbNbOL4GTLOQAxNA-1
X-Mimecast-MFC-AGG-ID: 3YIWOdRbNbOL4GTLOQAxNA_1770803564
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-8c6a291e7faso2382181885a.3
 for <qemu-devel@nongnu.org>; Wed, 11 Feb 2026 01:52:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770803564; cv=none;
 d=google.com; s=arc-20240605;
 b=QvzluNKFeHTsTf8g0DcCzbqbDIWPy8dW3R4VLivjTaMZgp4SrrQjNbfbbTgtYaqj3y
 aVjq2PcRURBoCMLMnZzXc/JWyiE06VyB3k9gK9pc1lqC1WhLVRUElhdQveW5NHQl6prM
 1TPkohqc3lMQ45UP/q+e6NGTW4y9xubBgwbeObD1Oyy7sta6vz99PwRqzUZPHDzlKq0D
 IB8RtfhbaxF3rbsuo/EAsueNmusd0LzogRtmmHTZrOE2m3Bu97/c+jJuGRqv4wyqMXSI
 goFcUYTgfEVeic+k0ELoWieHJH7+EOcboJaOtHtQiVZEdYGdUNXswBLE4ij2zfExjapa
 WH/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=TFCTSypbMBgXbUToZkqq105dqFxi2qMftEDIpjYWjiI=;
 fh=y2IBWUgtcUjG6NJSqP3lV5ogPzGemdHdE6RYndP4ox8=;
 b=FviTzJlX44tostWB8ztZuhRZ04bbhaN4/BNxXit4RZhe8gWyiJpuirEixhfZwb+FrR
 eiHJo061GRy/0lH7YZHV8UkNJW1KRE/vhcH3nD3HnJG7+yc7xx8dexUT90YmtX7TNHUx
 KnglkaPk/sa2b62GXJ+G9+7kIeuyMY2QkcF7U8cU09GoL+5OT2gbtgNyU62NAtX13bW+
 wz5mnhXpCy+SdznSQaEwe55JmnDbtwU1peK6f31yInOplL1z2RwSLQ1O/mfN3WELyjkv
 sDBQ3yWD8CGXM/kYeZGxGFYELcbAhtF/dJStrUBc4B2/20w3ayXiKtW2Zqxjh+pGAyT2
 7hxw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770803564; x=1771408364; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TFCTSypbMBgXbUToZkqq105dqFxi2qMftEDIpjYWjiI=;
 b=qiV608EPKVN364aYPbuECfTDKOuovVA76kIZKIXMqHqr4c0AbGHWaCjp6xF2tsrjTy
 Az8wYsruZpnZBbIoucZFtrZFiuASlUmn41L7A59tlISxJbjDBNfIo1hCS7KU/BlEtfhF
 O0HnUaxfalGvx21hAanIoHyASgaTwdOMb4LlTlgGh3z8oLEfidDys1NGp9Nmg5Avt93o
 IuUTNgStFIATa6WTR/iH6Yp/j7aLFyV2aPe1by2UgyxZunhWZeIYjqPucjbOLoq4yueg
 eLy1xZl/LgkVvNTcO47IOX6gUYH5RcLobP9ESNl6f+sit4iB3MJgRZYuVF++2S33NmbP
 l/mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770803564; x=1771408364;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TFCTSypbMBgXbUToZkqq105dqFxi2qMftEDIpjYWjiI=;
 b=XQuQzCaU6UFTlg5KyhfMSuag/eYpDUSSYFCRxkR4Gh7cxC3gT6PrEqpft/+6ELo7H3
 tzGqgCaRiVtQGYkR0Eqt450yeTLkUrYcdy5avvuix56teyUVRanDZwPDy/MAA0dLlmRK
 UV/wARw851hc/k5C0nufZGGrx4UNlHaPnICJf8Uhs5w53tKBHAbi3rKskpz9oE02IrAg
 5jXiZDdVDaAh7wIp73ClFbXxPuUGh0OpbbXbLvaz5ptH5lvvHpg/c27B0vOVctahcqhN
 jeQqhC3/vYdFzj1ApCsF/RAx+bndENLNhItWRWAg/2WwHWltsAtjqih2P7sR/WdzvjOZ
 IVBA==
X-Gm-Message-State: AOJu0Yx2Jwv+gNwR3ApF8A7nXULwcdIL35oomqkcnNjT1E3rc+zqCK5g
 8jdZltgvyc2H0Jh+d+Zvq1uIBR89wWsjes4+uQRcA5A3aW36wQb/VJWP0nudzCLojvXV7XWZtCw
 Ax65YrDZ7RFZeTRHMslrBEj83hMsm15x1bxFW6ocakq4/WC5CE443TvuUtdU9bzMYYvGR2kgY6B
 mB3XkO2BfjE6D+FVt+xiYJbsIpuHXDAi4=
X-Gm-Gg: AZuq6aIjy8HxbtQasiFUP0Rd081nuF4HdeeJj7ScMiMV5XjCMiQrUyx7HxZowByMGEJ
 +Hvxy1C/v1J2EuDKqrdiQx/i7z20M8qPK+aW+K5U8GPWIf3bqdvS52YBKYwQHw3xO+grRncqq4s
 b66KjPYWBQPlfYbZ0EIbG+j+B/DQ+xSbsAD8NULXUdHuLt0ZsqqWw3HsaWkjlgvVxV24PAxAjQO
 omnj+yL
X-Received: by 2002:a05:620a:1915:b0:8b2:f269:f899 with SMTP id
 af79cd13be357-8cb28041405mr246228785a.56.1770803563875; 
 Wed, 11 Feb 2026 01:52:43 -0800 (PST)
X-Received: by 2002:a05:620a:1915:b0:8b2:f269:f899 with SMTP id
 af79cd13be357-8cb28041405mr246227585a.56.1770803563462; Wed, 11 Feb 2026
 01:52:43 -0800 (PST)
MIME-Version: 1.0
References: <20260211090151.747926-3-eashurov@redhat.com>
In-Reply-To: <20260211090151.747926-3-eashurov@redhat.com>
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Date: Wed, 11 Feb 2026 11:52:32 +0200
X-Gm-Features: AZwV_QgXZRZzQKj1hLaRG7OOTyKgeMU2621uW5HMaBd2iTziFXUGqC6LJJapuso
Message-ID: <CAPMcbCrDJP+yKh5TcnuJqUpEXsbG-ULtJU4_wY33720pJKWVhg@mail.gmail.com>
Subject: Re: [PATCH 1/2] qga: Move CoInitialize/CoInitializeSecurity to main
 process thread
To: Elizabeth Ashurov <eashurov@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000005e159c064a8955bd"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

--0000000000005e159c064a8955bd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Best Regards,
Kostiantyn Kostiuk.


On Wed, Feb 11, 2026 at 11:05=E2=80=AFAM Elizabeth Ashurov <eashurov@redhat=
.com>
wrote:

> Problem:
> Two issues with COM initialization:
>
> Issue #1: Incorrect call order
> - requester_init() called CoInitializeSecurity first
> - Per Microsoft documentation, CoInitialize() must be called BEFORE
>   CoInitializeSecurity()
>
> Issue #2: Incorrect call location
> - CoInitializeSecurity was called from dll instead of the main process
> - Per Microsoft documentation, CoInitializeSecurity() must be called
> exactly once per process from
>   the main executable, not from a DLL
>
> Reference:
>
> https://learn.microsoft.com/en-us/windows/win32/api/combaseapi/nf-combase=
api-coinitializesecurity
>
> https://learn.microsoft.com/en-us/windows/win32/api/objbase/nf-objbase-co=
initialize
>
> This caused incorrect COM initialization, preventing VSS Writers from
> calling back via IVssWriterCallback (hr =3D 0x80070005, Access denied,
> Event ID 8194).
>
> Fix:
> - Initialize COM in main.c for both service and CLI modes
> - Call CoInitialize() followed by CoInitializeSecurity() in correct order
>   in the main thread before any VSS operations
> - Add proper CoUninitialize() cleanup
>
> Result:
> VSS Writers can now successfully call back to the agent. Event ID 8194
> error is resolved.
>
> Signed-off-by: Elizabeth Ashurov <eashurov@redhat.com>
> ---
>  qga/main.c                  | 43 +++++++++++++++++++++++++++++++++++++
>  qga/vss-win32/requester.cpp | 15 ++-----------
>  2 files changed, 45 insertions(+), 13 deletions(-)
>
> diff --git a/qga/main.c b/qga/main.c
> index dd1c216f9a..210d9983ab 100644
> --- a/qga/main.c
> +++ b/qga/main.c
> @@ -32,6 +32,8 @@
>  #include "qemu/systemd.h"
>  #include "qemu-version.h"
>  #ifdef _WIN32
> +#include <windows.h>
> +#include <objbase.h>
>  #include <dbt.h>
>  #include <pdh.h>
>  #include "qga/service-win32.h"
> @@ -842,6 +844,24 @@ VOID WINAPI service_main(DWORD argc, TCHAR *argv[])
>          return;
>      }
>
> +    /* Initialize COM for VSS operations in the service thread */
> +    HRESULT hr_com =3D CoInitialize(NULL);
> +    if (FAILED(hr_com)) {
> +        g_critical("Failed to initialize COM in service thread: 0x%lx",
> hr_com);
> +        return;
> +    }
> +
> +    hr_com =3D CoInitializeSecurity(
> +        NULL, -1, NULL, NULL,
> +        RPC_C_AUTHN_LEVEL_PKT_PRIVACY,
> +        RPC_C_IMP_LEVEL_IDENTIFY,
> +        NULL, EOAC_NONE, NULL);
> +    if (FAILED(hr_com)) {
> +        g_critical("Failed to initialize COM security in service thread:
> 0x%lx", hr_com);
> +        CoUninitialize();
> +        return;
> +    }
> +
>

Lets preven code duplication and definitely for CoInitializeSecurity with a
huge amount of arguments,
so wrap this into a new function.


>      service->status.dwServiceType =3D SERVICE_WIN32;
>      service->status.dwCurrentState =3D SERVICE_RUNNING;
>      service->status.dwControlsAccepted =3D SERVICE_ACCEPT_STOP |
> SERVICE_ACCEPT_SHUTDOWN;
> @@ -866,6 +886,8 @@ VOID WINAPI service_main(DWORD argc, TCHAR *argv[])
>
>      run_agent(ga_state);
>
> +    CoUninitialize();
> +
>      UnregisterDeviceNotification(service->device_notification_handle);
>      service->status.dwCurrentState =3D SERVICE_STOPPED;
>      SetServiceStatus(service->status_handle, &service->status);
> @@ -1714,12 +1736,33 @@ int main(int argc, char **argv)
>
>  #ifdef _WIN32
>      if (config->daemonize) {
> +        /* Service mode */
>          SERVICE_TABLE_ENTRY service_table[] =3D {
>              { (char *)QGA_SERVICE_NAME, service_main }, { NULL, NULL } }=
;
>          StartServiceCtrlDispatcher(service_table);
>          ret =3D EXIT_SUCCESS;
>      } else {
> +        HRESULT hr_com =3D CoInitialize(NULL);
> +        if (FAILED(hr_com)) {
> +            g_critical("Failed to initialize COM: 0x%lx", hr_com);
> +            ret =3D EXIT_FAILURE;
> +            goto end;
> +        }
> +
> +        hr_com =3D CoInitializeSecurity(
> +            NULL, -1, NULL, NULL,
> +            RPC_C_AUTHN_LEVEL_PKT_PRIVACY,
> +            RPC_C_IMP_LEVEL_IDENTIFY,
> +            NULL, EOAC_NONE, NULL);
> +        if (FAILED(hr_com)) {
> +            g_critical("Failed to initialize COM security: 0x%lx",
> hr_com);
> +            CoUninitialize();
> +            ret =3D EXIT_FAILURE;
> +            goto end;
> +        }
> +
>          ret =3D run_agent(s);
> +        CoUninitialize();
>      }
>  #else
>      ret =3D run_agent(s);
> diff --git a/qga/vss-win32/requester.cpp b/qga/vss-win32/requester.cpp
> index 74489fcd0a..9d978759f1 100644
> --- a/qga/vss-win32/requester.cpp
> +++ b/qga/vss-win32/requester.cpp
> @@ -60,15 +60,6 @@ STDAPI requester_init(void)
>  {
>      qga_debug_begin;
>
> -    COMInitializer initializer; /* to call CoInitializeSecurity */
> -    HRESULT hr =3D CoInitializeSecurity(
> -        NULL, -1, NULL, NULL, RPC_C_AUTHN_LEVEL_PKT_PRIVACY,
> -        RPC_C_IMP_LEVEL_IDENTIFY, NULL, EOAC_NONE, NULL);
> -    if (FAILED(hr)) {
> -        qga_debug("failed to CoInitializeSecurity (error %lx)", hr);
> -        return hr;
> -    }
> -
>      hLib =3D LoadLibraryA("VSSAPI.DLL");
>      if (!hLib) {
>          qga_debug("failed to load VSSAPI.DLL");
> @@ -320,8 +311,6 @@ void requester_freeze(int *num_vols, void
> *mountpoints, ErrorSet *errset)
>          return;
>      }
>
> -    CoInitialize(NULL);
> -
>      /* Allow unrestricted access to events */
>      InitializeSecurityDescriptor(&sd, SECURITY_DESCRIPTOR_REVISION);
>      SetSecurityDescriptorDacl(&sd, TRUE, NULL, FALSE);
> @@ -562,7 +551,7 @@ out:
>
>  out1:
>      requester_cleanup();
> -    CoUninitialize();
> +    /* COM is managed at process level in main.c - don't call
> CoUninitialize here */
>
>      qga_debug_end;
>  }
> @@ -643,7 +632,7 @@ void requester_thaw(int *num_vols, void *mountpints,
> ErrorSet *errset)
>      *num_vols =3D vss_ctx.cFrozenVols;
>      requester_cleanup();
>
> -    CoUninitialize();
> +    /* COM is managed at process level in main.c - don't call
> CoUninitialize here */
>      StopService();
>
>      qga_debug_end;
> --
> 2.51.0
>
>
>

--0000000000005e159c064a8955bd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div><br clear=3D"all"></div><div><div di=
r=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><div>Best Regards,</di=
v><div>Kostiantyn Kostiuk.</div></div></div></div><br></div><br><div class=
=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr=
">On Wed, Feb 11, 2026 at 11:05=E2=80=AFAM Elizabeth Ashurov &lt;<a href=3D=
"mailto:eashurov@redhat.com">eashurov@redhat.com</a>&gt; wrote:<br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">Problem:<br>
Two issues with COM initialization:<br>
<br>
Issue #1: Incorrect call order<br>
- requester_init() called CoInitializeSecurity first<br>
- Per Microsoft documentation, CoInitialize() must be called BEFORE<br>
=C2=A0 CoInitializeSecurity()<br>
<br>
Issue #2: Incorrect call location<br>
- CoInitializeSecurity was called from dll instead of the main process<br>
- Per Microsoft documentation, CoInitializeSecurity() must be called exactl=
y once per process from<br>
=C2=A0 the main executable, not from a DLL<br>
<br>
Reference:<br>
<a href=3D"https://learn.microsoft.com/en-us/windows/win32/api/combaseapi/n=
f-combaseapi-coinitializesecurity" rel=3D"noreferrer" target=3D"_blank">htt=
ps://learn.microsoft.com/en-us/windows/win32/api/combaseapi/nf-combaseapi-c=
oinitializesecurity</a><br>
<a href=3D"https://learn.microsoft.com/en-us/windows/win32/api/objbase/nf-o=
bjbase-coinitialize" rel=3D"noreferrer" target=3D"_blank">https://learn.mic=
rosoft.com/en-us/windows/win32/api/objbase/nf-objbase-coinitialize</a><br>
<br>
This caused incorrect COM initialization, preventing VSS Writers from<br>
calling back via IVssWriterCallback (hr =3D 0x80070005, Access denied,<br>
Event ID 8194).<br>
<br>
Fix:<br>
- Initialize COM in main.c for both service and CLI modes<br>
- Call CoInitialize() followed by CoInitializeSecurity() in correct order<b=
r>
=C2=A0 in the main thread before any VSS operations<br>
- Add proper CoUninitialize() cleanup<br>
<br>
Result:<br>
VSS Writers can now successfully call back to the agent. Event ID 8194<br>
error is resolved.<br>
<br>
Signed-off-by: Elizabeth Ashurov &lt;<a href=3D"mailto:eashurov@redhat.com"=
 target=3D"_blank">eashurov@redhat.com</a>&gt;<br>
---<br>
=C2=A0qga/main.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 | 43 +++++++++++++++++++++++++++++++++++++<br>
=C2=A0qga/vss-win32/requester.cpp | 15 ++-----------<br>
=C2=A02 files changed, 45 insertions(+), 13 deletions(-)<br>
<br>
diff --git a/qga/main.c b/qga/main.c<br>
index dd1c216f9a..210d9983ab 100644<br>
--- a/qga/main.c<br>
+++ b/qga/main.c<br>
@@ -32,6 +32,8 @@<br>
=C2=A0#include &quot;qemu/systemd.h&quot;<br>
=C2=A0#include &quot;qemu-version.h&quot;<br>
=C2=A0#ifdef _WIN32<br>
+#include &lt;windows.h&gt;<br>
+#include &lt;objbase.h&gt;<br>
=C2=A0#include &lt;dbt.h&gt;<br>
=C2=A0#include &lt;pdh.h&gt;<br>
=C2=A0#include &quot;qga/service-win32.h&quot;<br>
@@ -842,6 +844,24 @@ VOID WINAPI service_main(DWORD argc, TCHAR *argv[])<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
+=C2=A0 =C2=A0 /* Initialize COM for VSS operations in the service thread *=
/<br>
+=C2=A0 =C2=A0 HRESULT hr_com =3D CoInitialize(NULL);<br>
+=C2=A0 =C2=A0 if (FAILED(hr_com)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_critical(&quot;Failed to initialize COM in s=
ervice thread: 0x%lx&quot;, hr_com);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 hr_com =3D CoInitializeSecurity(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 NULL, -1, NULL, NULL,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 RPC_C_AUTHN_LEVEL_PKT_PRIVACY,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 RPC_C_IMP_LEVEL_IDENTIFY,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 NULL, EOAC_NONE, NULL);<br>
+=C2=A0 =C2=A0 if (FAILED(hr_com)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_critical(&quot;Failed to initialize COM secu=
rity in service thread: 0x%lx&quot;, hr_com);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 CoUninitialize();<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 }<br>
+<br></blockquote><div><br></div><div>Lets preven code duplication and defi=
nitely for=C2=A0CoInitializeSecurity with a huge amount of arguments,</div>=
<div>so wrap this into a new function.</div><div>=C2=A0</div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">
=C2=A0 =C2=A0 =C2=A0service-&gt;status.dwServiceType =3D SERVICE_WIN32;<br>
=C2=A0 =C2=A0 =C2=A0service-&gt;status.dwCurrentState =3D SERVICE_RUNNING;<=
br>
=C2=A0 =C2=A0 =C2=A0service-&gt;status.dwControlsAccepted =3D SERVICE_ACCEP=
T_STOP | SERVICE_ACCEPT_SHUTDOWN;<br>
@@ -866,6 +886,8 @@ VOID WINAPI service_main(DWORD argc, TCHAR *argv[])<br>
<br>
=C2=A0 =C2=A0 =C2=A0run_agent(ga_state);<br>
<br>
+=C2=A0 =C2=A0 CoUninitialize();<br>
+<br>
=C2=A0 =C2=A0 =C2=A0UnregisterDeviceNotification(service-&gt;device_notific=
ation_handle);<br>
=C2=A0 =C2=A0 =C2=A0service-&gt;status.dwCurrentState =3D SERVICE_STOPPED;<=
br>
=C2=A0 =C2=A0 =C2=A0SetServiceStatus(service-&gt;status_handle, &amp;servic=
e-&gt;status);<br>
@@ -1714,12 +1736,33 @@ int main(int argc, char **argv)<br>
<br>
=C2=A0#ifdef _WIN32<br>
=C2=A0 =C2=A0 =C2=A0if (config-&gt;daemonize) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Service mode */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SERVICE_TABLE_ENTRY service_table[] =3D {=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{ (char *)QGA_SERVICE_NAME,=
 service_main }, { NULL, NULL } };<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0StartServiceCtrlDispatcher(service_table)=
;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D EXIT_SUCCESS;<br>
=C2=A0 =C2=A0 =C2=A0} else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 HRESULT hr_com =3D CoInitialize(NULL);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (FAILED(hr_com)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_critical(&quot;Failed to initi=
alize COM: 0x%lx&quot;, hr_com);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D EXIT_FAILURE;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto end;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 hr_com =3D CoInitializeSecurity(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 NULL, -1, NULL, NULL,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 RPC_C_AUTHN_LEVEL_PKT_PRIVACY,<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 RPC_C_IMP_LEVEL_IDENTIFY,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 NULL, EOAC_NONE, NULL);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (FAILED(hr_com)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_critical(&quot;Failed to initi=
alize COM security: 0x%lx&quot;, hr_com);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 CoUninitialize();<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D EXIT_FAILURE;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto end;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D run_agent(s);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 CoUninitialize();<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0#else<br>
=C2=A0 =C2=A0 =C2=A0ret =3D run_agent(s);<br>
diff --git a/qga/vss-win32/requester.cpp b/qga/vss-win32/requester.cpp<br>
index 74489fcd0a..9d978759f1 100644<br>
--- a/qga/vss-win32/requester.cpp<br>
+++ b/qga/vss-win32/requester.cpp<br>
@@ -60,15 +60,6 @@ STDAPI requester_init(void)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0qga_debug_begin;<br>
<br>
-=C2=A0 =C2=A0 COMInitializer initializer; /* to call CoInitializeSecurity =
*/<br>
-=C2=A0 =C2=A0 HRESULT hr =3D CoInitializeSecurity(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 NULL, -1, NULL, NULL, RPC_C_AUTHN_LEVEL_PKT_PR=
IVACY,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 RPC_C_IMP_LEVEL_IDENTIFY, NULL, EOAC_NONE, NUL=
L);<br>
-=C2=A0 =C2=A0 if (FAILED(hr)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 qga_debug(&quot;failed to CoInitializeSecurity=
 (error %lx)&quot;, hr);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return hr;<br>
-=C2=A0 =C2=A0 }<br>
-<br>
=C2=A0 =C2=A0 =C2=A0hLib =3D LoadLibraryA(&quot;VSSAPI.DLL&quot;);<br>
=C2=A0 =C2=A0 =C2=A0if (!hLib) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qga_debug(&quot;failed to load VSSAPI.DLL=
&quot;);<br>
@@ -320,8 +311,6 @@ void requester_freeze(int *num_vols, void *mountpoints,=
 ErrorSet *errset)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 CoInitialize(NULL);<br>
-<br>
=C2=A0 =C2=A0 =C2=A0/* Allow unrestricted access to events */<br>
=C2=A0 =C2=A0 =C2=A0InitializeSecurityDescriptor(&amp;sd, SECURITY_DESCRIPT=
OR_REVISION);<br>
=C2=A0 =C2=A0 =C2=A0SetSecurityDescriptorDacl(&amp;sd, TRUE, NULL, FALSE);<=
br>
@@ -562,7 +551,7 @@ out:<br>
<br>
=C2=A0out1:<br>
=C2=A0 =C2=A0 =C2=A0requester_cleanup();<br>
-=C2=A0 =C2=A0 CoUninitialize();<br>
+=C2=A0 =C2=A0 /* COM is managed at process level in main.c - don&#39;t cal=
l CoUninitialize here */<br>
<br>
=C2=A0 =C2=A0 =C2=A0qga_debug_end;<br>
=C2=A0}<br>
@@ -643,7 +632,7 @@ void requester_thaw(int *num_vols, void *mountpints, Er=
rorSet *errset)<br>
=C2=A0 =C2=A0 =C2=A0*num_vols =3D vss_ctx.cFrozenVols;<br>
=C2=A0 =C2=A0 =C2=A0requester_cleanup();<br>
<br>
-=C2=A0 =C2=A0 CoUninitialize();<br>
+=C2=A0 =C2=A0 /* COM is managed at process level in main.c - don&#39;t cal=
l CoUninitialize here */<br>
=C2=A0 =C2=A0 =C2=A0StopService();<br>
<br>
=C2=A0 =C2=A0 =C2=A0qga_debug_end;<br>
-- <br>
2.51.0<br>
<br>
<br>
</blockquote></div></div>

--0000000000005e159c064a8955bd--


