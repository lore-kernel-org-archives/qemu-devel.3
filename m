Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF415E9E2E1
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 10:48:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vq7m4-0008HO-KO; Wed, 11 Feb 2026 05:48:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1vq7m3-0008H7-Eb
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 05:48:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1vq7m1-0003h0-9o
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 05:48:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770806924;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=akZ/GsTkxGoi+GHIBseVAj3BvZZnmql3rbXT4JuCK/E=;
 b=RN/BlwyDq3i/B+VBMfQc7qchKomd3LMjg75jfGTJNE1uce+7vWzB1p0LXseqvgilYuiBMn
 KuhrIPD9Kz31q85UYS7rD30hVUR2WP+QASzHKuVPYjTP/0GuEJK8gOYLxP4Vaq+1EggPNc
 zC+XUBb8FHd5Bdfl5Mfhxidu21UVldc=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-6YLcIiweODqn4LIYkBlq2g-1; Wed, 11 Feb 2026 05:48:42 -0500
X-MC-Unique: 6YLcIiweODqn4LIYkBlq2g-1
X-Mimecast-MFC-AGG-ID: 6YLcIiweODqn4LIYkBlq2g_1770806921
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-896f4dcef67so69318606d6.2
 for <qemu-devel@nongnu.org>; Wed, 11 Feb 2026 02:48:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770806921; cv=none;
 d=google.com; s=arc-20240605;
 b=PS2uWDmq4uQ1PJvpnRyr0CUSM/OoBh0VlF95fUneGuMOKlrGbGShR9WJVDtMKkogCP
 YNddZZT5o/0WDvY3pUIfEBO/OrC1MNwjuSd9DAF+t4vSPb4KkEy9EEqMtSyaVBWfX9ur
 zDmWpZmaREz48RR24uFqrn5cPytFUNUDUt9OWzNu3pQtLPdev92Vybxw3RpAC9KQVlKO
 teY1JdOW8/2zuddDmkVI8tZexhfhDHGFDhKU5ycIBDcYY51P7BZQPOzOCbj+uPkthRbu
 m02/uo5qPbDXsprHOk0KbInUoxdzTk5TfJfMgmWrSOGd9pE4WTh6ZVbuQUSuOq5spK67
 Nl4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=akZ/GsTkxGoi+GHIBseVAj3BvZZnmql3rbXT4JuCK/E=;
 fh=y2IBWUgtcUjG6NJSqP3lV5ogPzGemdHdE6RYndP4ox8=;
 b=gqOZUOLzMK6NrefyIAXsqze6UHrL1tw7SVcVaCV/p9pSZcRIU2+63UTVb3JHzOAsVJ
 /8RS4yWKYarJD4OQNv+NDIgIxqAVID6WDL6NcdNmxfIwaY5Y7pJq5cC+SBiD+o49idJm
 YemHHxhm1OTIa6G6AdWrqSjL0R/4LK8mVqsfvNwuTduVQwaK8uHs7q2iYlzA/ON4DWUJ
 NWOWm4C87Bijyle2hRm8bzDjiIYC2s5o6l1hyAg6B1EgvKmlO9/3rpLioRnnWykEsLZD
 QCF4V48BhkZyVIM+Xy6isFucquKUQ3HbwUCQ6tQbkW3M6qOqfUhoStOo87y7zzsBf9DM
 pXow==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770806921; x=1771411721; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=akZ/GsTkxGoi+GHIBseVAj3BvZZnmql3rbXT4JuCK/E=;
 b=WE9LylrA2xuXyi8vZhFbAWxdfU+U6T8eU1WrJ8UF819+m4ms76qtyjfJu3E2sjJ39v
 pfn6nPnvizCrR6qIEdAq5Qn8ulLkUamrJuPkQm4YS8nLSRsgJLcO3bCHqCvPPtFP3Cmy
 +yZZ7z4413o8GtbFIUomW7eVorkPKgV3zCWMT4o+9sAPbvXw4amhgeLiJXHL9hAFQ/9U
 +rU/8x6J8hRuI8eQH5nAsD93zOrfmnWAMgAkwt9v/YGs3GGdn1+KvzFbBQH4gpxM4GDB
 ZLEP7+ZilVnezs9Np38NX3MPwchTVd8wDkbxgbPc/pAiSGFWTQs5PcgKKiIPbCU3xdLP
 FGmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770806921; x=1771411721;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=akZ/GsTkxGoi+GHIBseVAj3BvZZnmql3rbXT4JuCK/E=;
 b=N1c7R0I7FMDoGNdRqPOF1dOC71Kf/BguXNnp8HU5pqcA58MA2XMnqBkD11RtZmneoo
 n3SnaZI+GDGe5HC0S+tBndk4yfyTJFAKg4vYvt0LRZ74a1miv1b7xPK/wfRhXmbqnlpK
 kvbXYMFV6uES8XmkI9yt6iNQmFrYEmJygMBkkuYoAMjx8bTUgVHGXidnUGOwCo9TLIxY
 MCO+O2fek8QV7CjttpEIF8njK5R0ZsO5iSowtya3guvz1NjGMBvO2TQnIrv+s0vfph8a
 Yl6h90HZKfBT/ljEDRNPLNpjjjQZmahhIoOJtmHTJzZ6v+Lzr1u0fNBlvz8msOmPxbLF
 UgqA==
X-Gm-Message-State: AOJu0Yw7VCpS5JvBb0RgRZVmHJsDDDpCAO7dvHceQl/JpkaWEORjEK0g
 Q78fw1bFeQYOy7Vn0pc5E0Q8M0zK3R2Otz9Nd0P+nRiVnizl3TFZNGZHLMC0N99u0U61MTA/k5M
 4XnBoccZA3rAaSgCB6HQz9AY1q+euxJKxnffkUDa9h8ropnA4m7roc1IhZD8uEpiQT925zCBBKt
 cX098QNEhHH61aTOqk/DZ43mDrNd2bdTA=
X-Gm-Gg: AZuq6aLW57TijWPfQUHu84CJqytq97EvMT+zJ9VDXolfXXO7sQzalmi/MLhrOFGpGhY
 aBhPyDrk2ENJfFfz2SnNxVLq5pr/bwTE0EBYoCGGC2meya+r2t7b4Q9Jz6Uc87JUiloBKUVCKrd
 x8Mhe/XF/RBeHLRzfm61TBhegDyZ1bc7eoFDF/wSjl++LPNBHUoX2H3mDQk/iB13QigFGOLS+LX
 7+WLA7w
X-Received: by 2002:a05:6214:485:b0:894:3c3c:adf9 with SMTP id
 6a1803df08f44-8953cf9777bmr248229126d6.59.1770806921570; 
 Wed, 11 Feb 2026 02:48:41 -0800 (PST)
X-Received: by 2002:a05:6214:485:b0:894:3c3c:adf9 with SMTP id
 6a1803df08f44-8953cf9777bmr248228996d6.59.1770806921174; Wed, 11 Feb 2026
 02:48:41 -0800 (PST)
MIME-Version: 1.0
References: <20260211101744.757548-1-eashurov@redhat.com>
In-Reply-To: <20260211101744.757548-1-eashurov@redhat.com>
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Date: Wed, 11 Feb 2026 12:48:30 +0200
X-Gm-Features: AZwV_Qhcpp2XWiPjVB-rcnW9Kcxt7-_ZPufx_-gWrCpH4lrZ9j53wl3JFTJhM2E
Message-ID: <CAPMcbCrk6kHh+CvEWcNUYOcwEeSmChU2jC60baOAAgaXKtEx5g@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] qga: Move CoInitialize/CoInitializeSecurity to
 main process thread
To: Elizabeth Ashurov <eashurov@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="00000000000080b46a064a8a1dcb"
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

--00000000000080b46a064a8a1dcb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>

On Wed, Feb 11, 2026 at 12:18=E2=80=AFPM Elizabeth Ashurov <eashurov@redhat=
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
>  qga/main.c                  | 42 +++++++++++++++++++++++++++++++++++++
>  qga/vss-win32/requester.cpp | 13 ------------
>  2 files changed, 42 insertions(+), 13 deletions(-)
>
> diff --git a/qga/main.c b/qga/main.c
> index dd1c216f9a..fd19c7037d 100644
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
> @@ -830,6 +832,29 @@ DWORD WINAPI service_ctrl_handler(DWORD ctrl, DWORD
> type, LPVOID data,
>      return ret;
>  }
>
> +/* Initialize COM for VSS operations */
> +static HRESULT init_com(void)
> +{
> +    HRESULT hr;
> +
> +    hr =3D CoInitialize(NULL);
> +    if (FAILED(hr)) {
> +        return hr;
> +    }
> +
> +    hr =3D CoInitializeSecurity(
> +        NULL, -1, NULL, NULL,
> +        RPC_C_AUTHN_LEVEL_PKT_PRIVACY,
> +        RPC_C_IMP_LEVEL_IDENTIFY,
> +        NULL, EOAC_NONE, NULL);
> +    if (FAILED(hr)) {
> +        CoUninitialize();
> +        return hr;
> +    }
> +
> +    return S_OK;
> +}
> +
>  VOID WINAPI service_main(DWORD argc, TCHAR *argv[])
>  {
>      GAService *service =3D &ga_state->service;
> @@ -842,6 +867,13 @@ VOID WINAPI service_main(DWORD argc, TCHAR *argv[])
>          return;
>      }
>
> +    /* Initialize COM for VSS operations in the service thread */
> +    HRESULT hr_com =3D init_com();
> +    if (FAILED(hr_com)) {
> +        g_critical("Failed to initialize COM in service thread: 0x%lx",
> hr_com);
> +        return;
> +    }
> +
>      service->status.dwServiceType =3D SERVICE_WIN32;
>      service->status.dwCurrentState =3D SERVICE_RUNNING;
>      service->status.dwControlsAccepted =3D SERVICE_ACCEPT_STOP |
> SERVICE_ACCEPT_SHUTDOWN;
> @@ -866,6 +898,8 @@ VOID WINAPI service_main(DWORD argc, TCHAR *argv[])
>
>      run_agent(ga_state);
>
> +    CoUninitialize();
> +
>      UnregisterDeviceNotification(service->device_notification_handle);
>      service->status.dwCurrentState =3D SERVICE_STOPPED;
>      SetServiceStatus(service->status_handle, &service->status);
> @@ -1719,7 +1753,15 @@ int main(int argc, char **argv)
>          StartServiceCtrlDispatcher(service_table);
>          ret =3D EXIT_SUCCESS;
>      } else {
> +        HRESULT hr_com =3D init_com();
> +        if (FAILED(hr_com)) {
> +            g_critical("Failed to initialize COM: 0x%lx", hr_com);
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
> index 74489fcd0a..626d6ab1ff 100644
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
> @@ -562,7 +551,6 @@ out:
>
>  out1:
>      requester_cleanup();
> -    CoUninitialize();
>
>      qga_debug_end;
>  }
> @@ -643,7 +631,6 @@ void requester_thaw(int *num_vols, void *mountpints,
> ErrorSet *errset)
>      *num_vols =3D vss_ctx.cFrozenVols;
>      requester_cleanup();
>
> -    CoUninitialize();
>      StopService();
>
>      qga_debug_end;
> --
> 2.51.0
>
>

--00000000000080b46a064a8a1dcb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Reviewed-by: Kostiantyn Kostiuk &lt;<a href=3D"mailto:kkos=
tiuk@redhat.com" target=3D"_blank">kkostiuk@redhat.com</a>&gt;</div><br><di=
v class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gma=
il_attr">On Wed, Feb 11, 2026 at 12:18=E2=80=AFPM Elizabeth Ashurov &lt;<a =
href=3D"mailto:eashurov@redhat.com">eashurov@redhat.com</a>&gt; wrote:<br><=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex">Problem:<br>
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
=A0 | 42 +++++++++++++++++++++++++++++++++++++<br>
=C2=A0qga/vss-win32/requester.cpp | 13 ------------<br>
=C2=A02 files changed, 42 insertions(+), 13 deletions(-)<br>
<br>
diff --git a/qga/main.c b/qga/main.c<br>
index dd1c216f9a..fd19c7037d 100644<br>
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
@@ -830,6 +832,29 @@ DWORD WINAPI service_ctrl_handler(DWORD ctrl, DWORD ty=
pe, LPVOID data,<br>
=C2=A0 =C2=A0 =C2=A0return ret;<br>
=C2=A0}<br>
<br>
+/* Initialize COM for VSS operations */<br>
+static HRESULT init_com(void)<br>
+{<br>
+=C2=A0 =C2=A0 HRESULT hr;<br>
+<br>
+=C2=A0 =C2=A0 hr =3D CoInitialize(NULL);<br>
+=C2=A0 =C2=A0 if (FAILED(hr)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return hr;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 hr =3D CoInitializeSecurity(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 NULL, -1, NULL, NULL,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 RPC_C_AUTHN_LEVEL_PKT_PRIVACY,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 RPC_C_IMP_LEVEL_IDENTIFY,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 NULL, EOAC_NONE, NULL);<br>
+=C2=A0 =C2=A0 if (FAILED(hr)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 CoUninitialize();<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return hr;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 return S_OK;<br>
+}<br>
+<br>
=C2=A0VOID WINAPI service_main(DWORD argc, TCHAR *argv[])<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0GAService *service =3D &amp;ga_state-&gt;service;<br>
@@ -842,6 +867,13 @@ VOID WINAPI service_main(DWORD argc, TCHAR *argv[])<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
+=C2=A0 =C2=A0 /* Initialize COM for VSS operations in the service thread *=
/<br>
+=C2=A0 =C2=A0 HRESULT hr_com =3D init_com();<br>
+=C2=A0 =C2=A0 if (FAILED(hr_com)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_critical(&quot;Failed to initialize COM in s=
ervice thread: 0x%lx&quot;, hr_com);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
=C2=A0 =C2=A0 =C2=A0service-&gt;status.dwServiceType =3D SERVICE_WIN32;<br>
=C2=A0 =C2=A0 =C2=A0service-&gt;status.dwCurrentState =3D SERVICE_RUNNING;<=
br>
=C2=A0 =C2=A0 =C2=A0service-&gt;status.dwControlsAccepted =3D SERVICE_ACCEP=
T_STOP | SERVICE_ACCEPT_SHUTDOWN;<br>
@@ -866,6 +898,8 @@ VOID WINAPI service_main(DWORD argc, TCHAR *argv[])<br>
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
@@ -1719,7 +1753,15 @@ int main(int argc, char **argv)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0StartServiceCtrlDispatcher(service_table)=
;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D EXIT_SUCCESS;<br>
=C2=A0 =C2=A0 =C2=A0} else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 HRESULT hr_com =3D init_com();<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (FAILED(hr_com)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_critical(&quot;Failed to initi=
alize COM: 0x%lx&quot;, hr_com);<br>
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
index 74489fcd0a..626d6ab1ff 100644<br>
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
@@ -562,7 +551,6 @@ out:<br>
<br>
=C2=A0out1:<br>
=C2=A0 =C2=A0 =C2=A0requester_cleanup();<br>
-=C2=A0 =C2=A0 CoUninitialize();<br>
<br>
=C2=A0 =C2=A0 =C2=A0qga_debug_end;<br>
=C2=A0}<br>
@@ -643,7 +631,6 @@ void requester_thaw(int *num_vols, void *mountpints, Er=
rorSet *errset)<br>
=C2=A0 =C2=A0 =C2=A0*num_vols =3D vss_ctx.cFrozenVols;<br>
=C2=A0 =C2=A0 =C2=A0requester_cleanup();<br>
<br>
-=C2=A0 =C2=A0 CoUninitialize();<br>
=C2=A0 =C2=A0 =C2=A0StopService();<br>
<br>
=C2=A0 =C2=A0 =C2=A0qga_debug_end;<br>
-- <br>
2.51.0<br>
<br>
</blockquote></div>

--00000000000080b46a064a8a1dcb--


