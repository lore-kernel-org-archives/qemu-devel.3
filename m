Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A8EEC982C9
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 20:29:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6wFb-0006JM-76; Wed, 16 Sep 2026 16:29:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1x6wFX-0006J9-TJ
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 16:28:59 -0400
Received: from mail-pj2-x2a.google.com ([2607:f8b0:4864:39::2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1x6wFW-0002Hm-4n
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 16:28:59 -0400
Received: by mail-pj2-x2a.google.com with SMTP id
 d9443c01a7336-2d747ec6185so923545ad.0
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 13:28:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789590536; cv=none;
 d=google.com; s=arc-20260327;
 b=O1eQPxIVKDRLV2DZrEQFQQrFIUih2Ccr/1Gn5keMwLLtdM0wxRq8CPgLCwQvSRrstB
 t8TnPaFtfkGzRy5a7bMbGnUnUnIwIu0+748fVYuqfU+UzNc9m2QzMkg4mKHxXTNyVI0Q
 rr4CUVax+gAktFhMz27a9qUkT0BjdLzf838nA788RhrRt5nsEkRjc5WSMaViNQkrpGBX
 oR9pINzjXfTWGb1DhmcualyqV2GkxGMHT03s5YgdBbToxddADT50K5mYF94z8r2p81TA
 aNTcMXs75LaJnGRyZWasvuprDWzYHbWkz1wYCweUN7yzrXvuUGUxutsZ/O4R9TftLmHF
 V5bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=6Tohiv/51cmVzVUxmL4O1n8IYrU8XI1CzhHvlvTR54g=;
 fh=5k2b0/n15VPsmIXH49PxIvFxtutXfoPYJqVHOWDgVXs=;
 b=SSRhEPGVmV1Bmlr2EJDeCA6gDJ5SpYd5rUt9Ejf29i4yW+hyIk62eD1ZVqqyAsidnK
 iRZN91XIvYFycuk7JePh+FwURdAcz9oD0jVKtJMuDQBbv+h0dxR5f5OwdH2Ay3bZxMvi
 XRwy3kRb/6MKih6UsWR3fgnBcLkU+Nfr04Te/yQB9nqit+wue1nz9lPzZfTLGcKURJFi
 fezxpwjF6nvSkEkKHEt5/jPszhy/0ofHnPwK8x3k6Fw/yUSJ7OzV18z0rllkcWUugkGn
 pRP/pvMJIvqvofcDNX6izgZ60Lj//igN/e7QBJYxAkHEJBCHZryRNmv/xL4uSoIafBnR
 eGJg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789590536; x=1790195336; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6Tohiv/51cmVzVUxmL4O1n8IYrU8XI1CzhHvlvTR54g=;
 b=P7bRsOpGYxBtJ8jCfBap5ZTYdJUmfKioRibGSPRPaaKvv+igcOZQqcL47I7BC6h8++
 mZ8zGP9MoecDqeoeXrgXCvASpoiLhIKWdNd8OZYYHCaGtYxTcRyV/bAcn1ZytgoSihk4
 boRDKPD3N+ll9tRu7fHOkcoN7GPoZbtRbfgm4S27hWkSOCI6UhAvfbpeMEfhzxzuQ/1O
 L6msvTS+BPZEaWS9Aea+wSx13/YZse/WrgStXk1C8DhvnJmHvEYliOZpFa+TgYJtBxmj
 GoAM6AC/oxE4g6tcO+kuIxpgxsvRA/DxoTIkqQWbiQr+CbtM1aAxLlOfxLrw+YzW8aIi
 BswQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789590536; x=1790195336;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6Tohiv/51cmVzVUxmL4O1n8IYrU8XI1CzhHvlvTR54g=;
 b=b5aZdHMNiL3FI9jV2mtwtjdwtJfAStCoT3Snx1/cN1xZbgtK3ykBo1RJptGYHExOM0
 ykyjAMWeg5UCM4UOaqXsM5E3a8wlH1m+fzt3/oqK8JlovVmfSS6ROiL7up/jqSTgkWK0
 i7eEl/rJpkN078loTZYQt6pC+tWMp2vpZFR/5ds2VtXdhin+zeP+D+KR4PI1aDbpAZLL
 U0KY5dlazsaZA6nl+7tQgprXBZvtIOjp0uNsu8O99P9RuAa6PktRn/EC0oY8Bg1KXLZ9
 Ve+loHQhz9LZ54El3rIRKMQOkeO2y3IvH6nJvVJfomNUjwZxjNGeSpWY8eUV6xNxF96+
 NNrg==
X-Gm-Message-State: AFuF++kvN0F75U++0o1490Ru06SLmSuOfJMfSb5z22Q8xdqTToTqbPoZ
 XSWvZ2Y1BsIfrV+KC4kkiXkX9PqkrfQAKbQcTLB7D8niBTNfDtyxxfgrl9Vwlp+tNw7o+lDkye6
 LNegHpl7larj1Pc6JRIC7ZLl/jk1pk3k=
X-Gm-Gg: AYBFou0K3ICjpwbFQhpU7Znh9XsV4FTeqrxrvUo4F5KmKzIm3DFMcY5ke81VCTFU+11
 6bChhY1p+nixUinZQ6Q+WarWe2reB1PRAFdMFU5wo3Wi/uNiN+yyQ9LvF1k2D0L43Jqrpp233cC
 6mbPaUNFimrL6OPvgcbQf8DwVR5xOOUe2fCg6L41bo7UzE3oaAeRSV2NkK/y/Ec4v3WYtKFyaVy
 fjIy8RBU+3YtOLxfLPX24PS7BvFTxPS7TdyxWbmANB1pB2kSG0hMYZzuk5lyE7X2RNN1kY2a3lQ
 oLkuRP6ttJrfB9FtLTtSh5cd3tpEfCoqESF34WrImOOPnbnclwDmnYyqTickZmOsgtTvyr2td9I
 ycc+nNy3u+5s=
X-Received: by 2002:a17:902:ffcb:b0:2bf:27b2:4b80 with SMTP id
 d9443c01a7336-2dd8e40607cmr91515785ad.14.1789590536187; Wed, 16 Sep 2026
 13:28:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260915145320.215663-1-aagbaria@redhat.com>
In-Reply-To: <20260915145320.215663-1-aagbaria@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 17 Sep 2026 00:28:43 +0400
X-Gm-Features: AcwNN1VHpywqI6GwPUwXiephq62-UrgWxNA9Fu8t28T6YDqLeTKue4uV6YMLFww
Message-ID: <CAJ+F1CLyzZePL0-MaXHoXWsi6gaoodCGxxxQLn97OcuX9tSdHQ@mail.gmail.com>
Subject: Re: [PATCH] qga/vss-win32/install.cpp: remove orphaned VSS provider
 service
To: Abed Agbaria <aagbaria@redhat.com>
Cc: qemu-devel@nongnu.org, kkostiuk@redhat.com, michael.roth@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:39::2a;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-pj2-x2a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Sep 15, 2026 at 7:03=E2=80=AFPM Abed Agbaria <aagbaria@redhat.com> =
wrote:
>
> COMRegister() probes the COM+ catalog to decide whether to unregister
> first, but it is the SCM that blocks installation when a service of the
> same name is left over.  If the COM+ application is gone and the service
> survives, install fails with 0x80070431 and never recovers.
>
>  - Check the SCM as well as the COM+ catalog in COMRegister().
>  - Delete the provider service in COMUnregister() and at the
>    DllUnregisterServer() call sites in DllRegisterServer().
>
> Signed-off-by: Abed Agbaria <aagbaria@redhat.com>
> ---
>  qga/vss-win32/install.cpp | 88 ++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 87 insertions(+), 1 deletion(-)
>
> diff --git a/qga/vss-win32/install.cpp b/qga/vss-win32/install.cpp
> index 5b7a8e9bc5..0e4f2ac009 100644
> --- a/qga/vss-win32/install.cpp
> +++ b/qga/vss-win32/install.cpp
> @@ -241,6 +241,89 @@ out:
>      return hr;
>  }
>
> +/* Check whether the QGA VSS provider service is registered with the SCM=
.*/
> +static bool QGAProviderServiceExists(void)
> +{
> +    qga_debug_begin;
> +
> +    bool exists =3D false;
> +    DWORD err;
> +    SC_HANDLE manager =3D OpenSCManager(NULL, NULL, SC_MANAGER_CONNECT);
> +    SC_HANDLE service =3D NULL;
> +
> +    if (!manager) {
> +        errmsg(GetLastError(), "Failed to open service manager");
> +        goto out;
> +    }
> +
> +    service =3D OpenService(manager, QGA_PROVIDER_NAME, SERVICE_QUERY_CO=
NFIG);
> +    if (service) {
> +        exists =3D true;
> +    } else {
> +        err =3D GetLastError();
> +        if (err !=3D ERROR_SERVICE_DOES_NOT_EXIST) {
> +            errmsg(err, "Failed to open service");
> +        }
> +    }
> +
> +out:
> +    if (service) {
> +        CloseServiceHandle(service);
> +    }
> +    if (manager) {
> +        CloseServiceHandle(manager);
> +    }
> +    qga_debug_end;
> +    return exists;
> +}
> +
> +/* Delete a QGA VSS provider service that COM+ no longer owns.*/
> +static HRESULT QGAProviderRemoveService(void)
> +{
> +    qga_debug_begin;
> +
> +    HRESULT hr =3D S_OK;
> +    DWORD err;
> +    SC_HANDLE manager =3D OpenSCManager(NULL, NULL, SC_MANAGER_CONNECT);
> +    SC_HANDLE service =3D NULL;
> +
> +    if (!manager) {
> +        hr =3D HRESULT_FROM_WIN32(GetLastError());
> +        errmsg(hr, "Failed to open service manager");

errmsg is called with win32 error code and HRESULT. This is already
inconsistent. Imho it should be fixed first before introducing more
inconsistency.



> +        goto out;
> +    }
> +
> +    service =3D OpenService(manager, QGA_PROVIDER_NAME, DELETE);

you are adding 2 more places to open a service, when there is already
similar code in  StopService(). I think it could be factored out.

> +    if (!service) {
> +        err =3D GetLastError();
> +        if (err !=3D ERROR_SERVICE_DOES_NOT_EXIST) {
> +            hr =3D HRESULT_FROM_WIN32(err);
> +            errmsg(hr, "Failed to open service");
> +        }
> +        goto out;
> +    }
> +
> +    qga_debug("Removing service: %s", QGA_PROVIDER_NAME);
> +
> +    if (!DeleteService(service)) {
> +        err =3D GetLastError();
> +        if (err !=3D ERROR_SERVICE_MARKED_FOR_DELETE) {
> +            hr =3D HRESULT_FROM_WIN32(err);
> +            errmsg(hr, "Failed to delete service");
> +        }
> +    }
> +
> +out:
> +    if (service) {
> +        CloseServiceHandle(service);
> +    }
> +    if (manager) {
> +        CloseServiceHandle(manager);
> +    }
> +    qga_debug_end;
> +    return hr;
> +}
> +
>  /* Unregister this module from COM+ Applications Catalog */
>  STDAPI COMUnregister(void);
>  STDAPI COMUnregister(void)
> @@ -251,6 +334,7 @@ STDAPI COMUnregister(void)
>
>      DllUnregisterServer();
>      chk(QGAProviderFind(QGAProviderRemove, NULL));
> +    chk(QGAProviderRemoveService());
>  out:
>      qga_debug_end;
>      return hr;
> @@ -286,7 +370,7 @@ STDAPI COMRegister(void)
>      }
>
>      chk(QGAProviderFind(QGAProviderCount, (void *)&count));
> -    if (count) {
> +    if (count || QGAProviderServiceExists()) {
>          qga_debug("QGA VSS Provider is already installed. Attempting to =
unregister first.");
>          hr =3D COMUnregister();
>          if (FAILED(hr)) {
> @@ -499,6 +583,7 @@ STDAPI DllRegisterServer(void)
>                                       g_gProviderVersion);
>      if (hr =3D=3D (long int) VSS_E_PROVIDER_ALREADY_REGISTERED) {
>          DllUnregisterServer();
> +        QGAProviderRemoveService();
>          hr =3D pVssAdmin->RegisterProvider(g_gProviderId, CLSID_QGAVSSPr=
ovider,
>                                           const_cast<WCHAR * >
>                                           (QGA_PROVIDER_LNAME),
> @@ -515,6 +600,7 @@ STDAPI DllRegisterServer(void)
>  out:
>      if (FAILED(hr)) {
>          DllUnregisterServer();
> +        QGAProviderRemoveService();
>      }
>
>      qga_debug_end;
> --
> 2.55.0
>
>


--=20
Marc-Andr=C3=A9 Lureau

