Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 918E1EE3697
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 15:16:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqYQO-0007Zo-B8; Thu, 12 Feb 2026 10:16:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <demeng@redhat.com>) id 1vqYQK-0007Yk-Is
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 10:16:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <demeng@redhat.com>) id 1vqYQH-0005k6-JA
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 10:16:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770909363;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=v5pjV0xiY4ugJ4/TG18bWRnWomE/uyYcqLUKjRe+iY8=;
 b=afXzx4DoYJ+MhNe2xmdmxxvcAv8kTPAZ1W7wlPPzI4hMNFYmM6kuCc9MZmaBZBNpOONKmV
 15CGnRFW6QfKFkCFBn7DWmecPDmLR78GquOrmdD/sSaIWATAPN+13MYsWVCXVGQbvReMxh
 oBv8d92gYKoGUX07xs3ZyLvrt7WMaQg=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-196-61av3QXRMY2lI4OlDPKLJg-1; Thu, 12 Feb 2026 10:14:13 -0500
X-MC-Unique: 61av3QXRMY2lI4OlDPKLJg-1
X-Mimecast-MFC-AGG-ID: 61av3QXRMY2lI4OlDPKLJg_1770909253
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-b8fa71b83a0so1219966b.2
 for <qemu-devel@nongnu.org>; Thu, 12 Feb 2026 07:14:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770909252; cv=none;
 d=google.com; s=arc-20240605;
 b=MYDx4CPHIobaPHEKWQmBKHjQA7eXzQn+hPFtg4ej3RIiapRKU0dEXxJqUmrq2yhSGT
 SKo1hiv4Qvz7OFewAsCsWonCkjpfgKgAabI9ZMdZjCHoKj1QsjqqajJLs30+DX1os3ad
 rZbk0YduLDC2S5+mWVwecCTenBfPIAAUcyosshiXyq4Grsam3nxrO73I3jqpOjwMUJgq
 ZlYLi67D909dz019AAqYlyJcHuRJKLStNAU4OCyGk9/Oii2Nk0ebXPHe1tA+Ekl9JCvX
 /w9qYXGHCm4w97wRG2q2m8JSXNEKV0BDoWmvkYuXfSKcyz9ZkiWDU1caN7roLjq0q0VY
 YAXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=v5pjV0xiY4ugJ4/TG18bWRnWomE/uyYcqLUKjRe+iY8=;
 fh=GBddxWD37//XEYunBDQvzSjKr2LK6Ya8cd32U4ANeSQ=;
 b=JH27zS0tzABMxg0VjcdpbMU9iCnl2vYQKW8AxyAiTABpdPbQ8s1RXZxvO6na5S0YQh
 YYnKe58Jmem9p/gQtxM3EhGRStjdMT1lR34Uizh3IxPPpzJc6eMuT7zKLivuAKF0F0UG
 lAl0esV8dx7zP9kZ5eJc/IT2dhIO1iuld5O+stP80DQHtRICe/mh0/ZJYIyb/sTeapPh
 Auxl2D3iJ45zG/iitiZIal2rmQ8gNbsadO/yFSQHxhQ8rTFkZ8MwIFk0ZL4ZD/bWZhnW
 KCW5zALa/UJm5WaFoOmryih3yJ/EiFjAt2XPFKhG5YU7uYCQQ2t97wO8o01xKfggoUT8
 3ZFg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770909252; x=1771514052; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=v5pjV0xiY4ugJ4/TG18bWRnWomE/uyYcqLUKjRe+iY8=;
 b=cB3HKaOGAe9SduCHFsAo0fSP/S+Uy7S5J/E0TaBc07b/MFQViIqO26OmxM8qm0Z22g
 x5c31S0ZjsGOuiXI0wZ3mGjTIbyxMwAYhSGZht6mA9IV2qepAXNfZkgsuazV6roZ04O4
 rRMprZzA5TJIpeGIZpFh7/JrmTSPV06sjxgio88Fe8csH+tmdg1gXYvts22t/GJl20yM
 et5VMh6mwpQe81KxuPCjlRaKH0EvI03+Xbc6+htoFiSOl34J2nZxVKXHzn8Ae0UbWhTA
 JaKj2tXLct1V3jXsYZnfcKNU5xog3O4qkT0zcLJYLLSAky01XhDTh/Wk67IDVyGWhhoM
 1G0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770909252; x=1771514052;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v5pjV0xiY4ugJ4/TG18bWRnWomE/uyYcqLUKjRe+iY8=;
 b=m2lAgapM0L2JtqvEo8ndqHhUTiiqRuOKHAtNMnCvZ449ieSppvbXRpbCkZUxFOVVsr
 SIQgyuaki5sYWhPwd/p39DOBLQao6baHmTCMRnkE4k7BSEiadFXeh0yxAzf3fP3e1eIE
 2GG+rH6Dh1W6ncGlqgU4ZxTKNvVY9HipX3aBYZ6OegiWKE0ygX7X538syrB0IrY+HETS
 uecpy9zse6Nzw2bCq/APG3eUBwRhZCZp3ls5wyULIPe9OdOWUceqkWLTxXXiuC99G545
 bai6nCy4yJOB7GiJrS+ndAYRff3hJgDHtaIWxZhHsp3oqifNb1mXnKqJUWzZYNfgEfsE
 q1Ww==
X-Forwarded-Encrypted: i=1;
 AJvYcCWly+LWV695e1m/bTIVZeFWBV/X4QqdVRJd3CQJdXzEFeez7hUfKnzyUgWT9vBvvrZG7KoPVVgmTKAw@nongnu.org
X-Gm-Message-State: AOJu0Yxxv2NhhJIsqzYAuA8ks4Z0tpYfn1RA4ZHo10zu2PssarcEjM+Q
 mUQ8sCqweDi4m3SuKlPNfyci7xH7gIv5hYPau+l+dA7nr1PK/MHGkiwmnlVrobJ5Z5kYLGdjYzi
 VsXK+CMsr+dW7t3inRF8N0ih1UTmlM/mczY1eqKGC977ceCXAyxrmyzcI6PjqorxEU8k7IIPdcN
 XtYa8v8MbWbmbxIDNa82lIFcH9bToGFVw=
X-Gm-Gg: AZuq6aKnB9QwRG6QJ9zJqleXzGlY2eReArWMHOnTPrbcowkIdOQb/ehr8fTsO57RcTY
 x9tO9ksvrCkvqhD+UmW1uLA8hFJ+NJSDMlUL7xWbu+d/nzJiD2RwCqKXZlw/kYWfclajuXi6Gk8
 4dE1Tu+rjtFCMd1jMY8h7F4rTpUbqHzBc7h30FHugievG86MMfgu6dbh9goxoMDDzXrX6ZJOkAr
 raz7XQ=
X-Received: by 2002:a17:906:478c:b0:b8e:6d3:ecf9 with SMTP id
 a640c23a62f3a-b8f92b7fd52mr154576466b.40.1770909252533; 
 Thu, 12 Feb 2026 07:14:12 -0800 (PST)
X-Received: by 2002:a17:906:478c:b0:b8e:6d3:ecf9 with SMTP id
 a640c23a62f3a-b8f92b7fd52mr154574066b.40.1770909251874; Thu, 12 Feb 2026
 07:14:11 -0800 (PST)
MIME-Version: 1.0
References: <20260211101744.757548-1-eashurov@redhat.com>
 <CAPMcbCrk6kHh+CvEWcNUYOcwEeSmChU2jC60baOAAgaXKtEx5g@mail.gmail.com>
In-Reply-To: <CAPMcbCrk6kHh+CvEWcNUYOcwEeSmChU2jC60baOAAgaXKtEx5g@mail.gmail.com>
From: Dehan Meng <demeng@redhat.com>
Date: Thu, 12 Feb 2026 23:14:00 +0800
X-Gm-Features: AZwV_Qgw80SahEpEREdPdoEl6kQcwFcesKSIoGf86s7CKDWkxECD3m4LdFWj2O8
Message-ID: <CA+kPPJxRLPYP7=XPBHgEwbsBEVe7cXd1TzfVx85y0RBX+PB0OA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] qga: Move CoInitialize/CoInitializeSecurity to
 main process thread
To: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Cc: Elizabeth Ashurov <eashurov@redhat.com>, qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000e3a8cd064aa1f006"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=demeng@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

--000000000000e3a8cd064aa1f006
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Tested-by: Dehan Meng <demeng@redhat.com>

On Wed, Feb 11, 2026 at 6:49=E2=80=AFPM Kostiantyn Kostiuk <kkostiuk@redhat=
.com>
wrote:

> Reviewed-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
>
> On Wed, Feb 11, 2026 at 12:18=E2=80=AFPM Elizabeth Ashurov <eashurov@redh=
at.com>
> wrote:
>
>> Problem:
>> Two issues with COM initialization:
>>
>> Issue #1: Incorrect call order
>> - requester_init() called CoInitializeSecurity first
>> - Per Microsoft documentation, CoInitialize() must be called BEFORE
>>   CoInitializeSecurity()
>>
>> Issue #2: Incorrect call location
>> - CoInitializeSecurity was called from dll instead of the main process
>> - Per Microsoft documentation, CoInitializeSecurity() must be called
>> exactly once per process from
>>   the main executable, not from a DLL
>>
>> Reference:
>>
>> https://learn.microsoft.com/en-us/windows/win32/api/combaseapi/nf-combas=
eapi-coinitializesecurity
>>
>> https://learn.microsoft.com/en-us/windows/win32/api/objbase/nf-objbase-c=
oinitialize
>>
>> This caused incorrect COM initialization, preventing VSS Writers from
>> calling back via IVssWriterCallback (hr =3D 0x80070005, Access denied,
>> Event ID 8194).
>>
>> Fix:
>> - Initialize COM in main.c for both service and CLI modes
>> - Call CoInitialize() followed by CoInitializeSecurity() in correct orde=
r
>>   in the main thread before any VSS operations
>> - Add proper CoUninitialize() cleanup
>>
>> Result:
>> VSS Writers can now successfully call back to the agent. Event ID 8194
>> error is resolved.
>>
>> Signed-off-by: Elizabeth Ashurov <eashurov@redhat.com>
>> ---
>>  qga/main.c                  | 42 +++++++++++++++++++++++++++++++++++++
>>  qga/vss-win32/requester.cpp | 13 ------------
>>  2 files changed, 42 insertions(+), 13 deletions(-)
>>
>> diff --git a/qga/main.c b/qga/main.c
>> index dd1c216f9a..fd19c7037d 100644
>> --- a/qga/main.c
>> +++ b/qga/main.c
>> @@ -32,6 +32,8 @@
>>  #include "qemu/systemd.h"
>>  #include "qemu-version.h"
>>  #ifdef _WIN32
>> +#include <windows.h>
>> +#include <objbase.h>
>>  #include <dbt.h>
>>  #include <pdh.h>
>>  #include "qga/service-win32.h"
>> @@ -830,6 +832,29 @@ DWORD WINAPI service_ctrl_handler(DWORD ctrl, DWORD
>> type, LPVOID data,
>>      return ret;
>>  }
>>
>> +/* Initialize COM for VSS operations */
>> +static HRESULT init_com(void)
>> +{
>> +    HRESULT hr;
>> +
>> +    hr =3D CoInitialize(NULL);
>> +    if (FAILED(hr)) {
>> +        return hr;
>> +    }
>> +
>> +    hr =3D CoInitializeSecurity(
>> +        NULL, -1, NULL, NULL,
>> +        RPC_C_AUTHN_LEVEL_PKT_PRIVACY,
>> +        RPC_C_IMP_LEVEL_IDENTIFY,
>> +        NULL, EOAC_NONE, NULL);
>> +    if (FAILED(hr)) {
>> +        CoUninitialize();
>> +        return hr;
>> +    }
>> +
>> +    return S_OK;
>> +}
>> +
>>  VOID WINAPI service_main(DWORD argc, TCHAR *argv[])
>>  {
>>      GAService *service =3D &ga_state->service;
>> @@ -842,6 +867,13 @@ VOID WINAPI service_main(DWORD argc, TCHAR *argv[])
>>          return;
>>      }
>>
>> +    /* Initialize COM for VSS operations in the service thread */
>> +    HRESULT hr_com =3D init_com();
>> +    if (FAILED(hr_com)) {
>> +        g_critical("Failed to initialize COM in service thread: 0x%lx",
>> hr_com);
>> +        return;
>> +    }
>> +
>>      service->status.dwServiceType =3D SERVICE_WIN32;
>>      service->status.dwCurrentState =3D SERVICE_RUNNING;
>>      service->status.dwControlsAccepted =3D SERVICE_ACCEPT_STOP |
>> SERVICE_ACCEPT_SHUTDOWN;
>> @@ -866,6 +898,8 @@ VOID WINAPI service_main(DWORD argc, TCHAR *argv[])
>>
>>      run_agent(ga_state);
>>
>> +    CoUninitialize();
>> +
>>      UnregisterDeviceNotification(service->device_notification_handle);
>>      service->status.dwCurrentState =3D SERVICE_STOPPED;
>>      SetServiceStatus(service->status_handle, &service->status);
>> @@ -1719,7 +1753,15 @@ int main(int argc, char **argv)
>>          StartServiceCtrlDispatcher(service_table);
>>          ret =3D EXIT_SUCCESS;
>>      } else {
>> +        HRESULT hr_com =3D init_com();
>> +        if (FAILED(hr_com)) {
>> +            g_critical("Failed to initialize COM: 0x%lx", hr_com);
>> +            ret =3D EXIT_FAILURE;
>> +            goto end;
>> +        }
>> +
>>          ret =3D run_agent(s);
>> +        CoUninitialize();
>>      }
>>  #else
>>      ret =3D run_agent(s);
>> diff --git a/qga/vss-win32/requester.cpp b/qga/vss-win32/requester.cpp
>> index 74489fcd0a..626d6ab1ff 100644
>> --- a/qga/vss-win32/requester.cpp
>> +++ b/qga/vss-win32/requester.cpp
>> @@ -60,15 +60,6 @@ STDAPI requester_init(void)
>>  {
>>      qga_debug_begin;
>>
>> -    COMInitializer initializer; /* to call CoInitializeSecurity */
>> -    HRESULT hr =3D CoInitializeSecurity(
>> -        NULL, -1, NULL, NULL, RPC_C_AUTHN_LEVEL_PKT_PRIVACY,
>> -        RPC_C_IMP_LEVEL_IDENTIFY, NULL, EOAC_NONE, NULL);
>> -    if (FAILED(hr)) {
>> -        qga_debug("failed to CoInitializeSecurity (error %lx)", hr);
>> -        return hr;
>> -    }
>> -
>>      hLib =3D LoadLibraryA("VSSAPI.DLL");
>>      if (!hLib) {
>>          qga_debug("failed to load VSSAPI.DLL");
>> @@ -320,8 +311,6 @@ void requester_freeze(int *num_vols, void
>> *mountpoints, ErrorSet *errset)
>>          return;
>>      }
>>
>> -    CoInitialize(NULL);
>> -
>>      /* Allow unrestricted access to events */
>>      InitializeSecurityDescriptor(&sd, SECURITY_DESCRIPTOR_REVISION);
>>      SetSecurityDescriptorDacl(&sd, TRUE, NULL, FALSE);
>> @@ -562,7 +551,6 @@ out:
>>
>>  out1:
>>      requester_cleanup();
>> -    CoUninitialize();
>>
>>      qga_debug_end;
>>  }
>> @@ -643,7 +631,6 @@ void requester_thaw(int *num_vols, void *mountpints,
>> ErrorSet *errset)
>>      *num_vols =3D vss_ctx.cFrozenVols;
>>      requester_cleanup();
>>
>> -    CoUninitialize();
>>      StopService();
>>
>>      qga_debug_end;
>> --
>> 2.51.0
>>
>>

--000000000000e3a8cd064aa1f006
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Tested-by: Dehan Meng &lt;<a href=3D"mailto:demeng@redhat.=
com" target=3D"_blank">demeng@redhat.com</a>&gt;=C2=A0</div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Feb 11, 2026=
 at 6:49=E2=80=AFPM Kostiantyn Kostiuk &lt;<a href=3D"mailto:kkostiuk@redha=
t.com" target=3D"_blank">kkostiuk@redhat.com</a>&gt; wrote:<br></div><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr">Reviewed-by: K=
ostiantyn Kostiuk &lt;<a href=3D"mailto:kkostiuk@redhat.com" target=3D"_bla=
nk">kkostiuk@redhat.com</a>&gt;</div><br><div class=3D"gmail_quote"><div di=
r=3D"ltr" class=3D"gmail_attr">On Wed, Feb 11, 2026 at 12:18=E2=80=AFPM Eli=
zabeth Ashurov &lt;<a href=3D"mailto:eashurov@redhat.com" target=3D"_blank"=
>eashurov@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex">Problem:<br>
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
</blockquote></div>

--000000000000e3a8cd064aa1f006--


