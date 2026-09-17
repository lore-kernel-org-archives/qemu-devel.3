Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B769C88E72
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 16:03:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7EYr-0003uM-7t; Thu, 17 Sep 2026 12:02:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aagbaria@redhat.com>)
 id 1x7EYZ-0003Vn-CC
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 12:01:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aagbaria@redhat.com>)
 id 1x7EYU-00066P-4x
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 12:01:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789660897;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yvXvqxM/xjpFmvZADiRqpUFY3+XcQ/u/yPTWbn8mbso=;
 b=TVrgi3RvCCVtm0ZWcLV1u1BrBZ4saVWRtuxcWjXzEVIX+CvCBVAJWgvHyTh53n2wFxcjp2
 5c9l72UoeGgmv4SmM9B+FpWXFPr7DeRkUBk2Fas+IS/5WoJHiqPlXM4HuYwwt9penGZePp
 GpzM9ItogAKob8UD91O1ah0O1eYVZYE=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-65-TpdkWTY0NMmRnoKg-DemzA-1; Thu, 17 Sep 2026 12:01:36 -0400
X-MC-Unique: TpdkWTY0NMmRnoKg-DemzA-1
X-Mimecast-MFC-AGG-ID: TpdkWTY0NMmRnoKg-DemzA_1789660896
Received: by mail-oi1-f199.google.com with SMTP id
 5614622812f47-4b1bc2e44e0so1234052b6e.0
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 09:01:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789660896; cv=none;
 d=google.com; s=arc-20260327;
 b=CFQygtwFllQnKSW6ZZma13uzzguLBNsMxdidDqUv48VpNT/so3TP3QrvWxDAg8S/2x
 wZZWM1SF8yewr9UqMmSrM4I5scn1jR+oYqr8wbpzFZg8wuLGBQsyX0dMrnOwkF+S9tHT
 XT0Ej7LKEki8MzwPym6/0aE/AUWJblbwJTrh24jZX9kZ4Nui+xLZMEKkNsMuWSJCPOHX
 UAaAO/Z+vTryT/1hjK3NYC1cFIH7/1swJtkNbi2F/1zpgju3X9QSdm8ju1RIqX29jJgL
 ADkXUU2eaGnCOxI+z5rqdyIfYsFtr9o0SAoNRc4PeeCSI1RlLpreh2VfZVNvYHwegxi9
 Eusg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=yvXvqxM/xjpFmvZADiRqpUFY3+XcQ/u/yPTWbn8mbso=;
 fh=X/zqn7d5N5+aMUG78wD6+MA8oVnuZMLaoUrrYwzwmeY=;
 b=JINlXejRnZbY4r+koKr+AOwFwwihMlcaQmWSkjXhZ+2SlZ/EHvS9xJ55qeJeR5SCsW
 KKeHvHJI5mZpwL+D7fIkSRp1XBJJ1DdIG/8MCFohng5AcCp5KmPWrXLnDjAwGUjspSgX
 wllIIA24GAydGUVg+mPx2Moxa5+P79s9z44IvROPWVRmR7dhpR1KxazOPt6S9YeSvkBt
 apk/zQ4PC/xuOK4gbCIydg/k9C+r2+eoh/yLrzgUX3Ay+usxKjj9Q6Na8I8mFz69bVG0
 ilMrc7hgQ5j6lz/OkWlykBrpITMVaglw40IdGhW3W6dpzp0ae9TazUlWr3YhGlqxTcvL
 d9tg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789660896; x=1790265696; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=yvXvqxM/xjpFmvZADiRqpUFY3+XcQ/u/yPTWbn8mbso=;
 b=RFPVPM7SiZG5IrjHrZRVDrOoVtEiYwv6mEJcm1Jo/RQPhE2uRm9iObnfCnJVf+QFSn
 F2k9/XGoDuqIsReFwvo/1+LGS95f4vPyrAgRycTRVeqjgtBMennsadDekfgkCf0lG515
 t6UyLYonG6+zg6Ir0VWmNyqbXVbJVgK/pWuRgs9D9cvlrJ3/8LJTHC7bRLV29IPmRPN6
 saMFhfQW5/5KuqW570FthtPZhAnbZgFCWBKeMJTbuhPyWofDjMJwAJLKrfRegsIYwUI+
 PvE0nHXn1bWHytzGHyrBiBRVfLaO82XmZHrrt6iiDZULAw2QAkyPWJV/+Hv03u/FEDdZ
 Gl6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789660896; x=1790265696;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yvXvqxM/xjpFmvZADiRqpUFY3+XcQ/u/yPTWbn8mbso=;
 b=P2Np7k4Mmm2SvAXNZDMKg3lw6QA5Zr+R+vl8xVFt0VlbN7GSzpFNXRu3bvS6puBRBi
 sPbCYEYXjNOZnnk1IzI0oqdYgTMWadx3i+kdzh3dDb4xKJi9RqErRWOPam5X7kQfD6ZD
 8h0tEX9tXPkf/y2jAJsuy7ihYGxPEeJ2hqKg27ZnXhMIuMMHNeDKE6T0ierxw0v5Cp7S
 TuWtdgZM8UQGiotCtKJzI7INMn2SGJNEclL/WNhS9uVi12YQ07R3I2oh79dSY63BW54D
 vB10mBLD3urUGwpTEcRMP0uRRba5c6yUXi7aGPcXsOc1V2Gv9ZEot8/kx0bb62IAACEI
 Ue+A==
X-Gm-Message-State: AFuF++mdMfZ8V6i0NQyUlwB26X/iru8J49Enl8H89iDVzDT5wgy26AfO
 IVhmN3AJbZKfh1yA2IXwgj3lryVhJf5s1EuPQJI2cHpZFw59R/Dx77CT9fYANICz7cWNcIwkHcr
 w6+nLNWOoip5EuC2Hx7svtOGnCzOFCiSdIzFgaXdMYK72IcYo0J46HNiIesfLWVn43BbgSwxllb
 +19Fp3wvtfzzSjk3EPCgV87KpXd8gifOk=
X-Gm-Gg: AYBFou0dL5FP7DJv2ZQdrXhsGJhmGo30NDge1ZBAT9EzJzwqTcRsa3lcluLRVqT90+s
 eT/phZiSrQHr8JbUo7X6S+Zad5lugKnSPTK8tXBqnrWoDmMfwAe2QcqNS+KRnvBiytE1sOJJnM+
 bXuoebh2TEruOQrQvBI2LAwoiXLal7C9oxKWNDzqTRdGd6SBrPToF2g3J50z/dkRjrnTfdtzDLp
 ZMeO+kz2FIMW6EVmw==
X-Received: by 2002:a05:6808:28b:b0:4cb:f21b:6f96 with SMTP id
 5614622812f47-4cbf21b73d7mr1601819b6e.41.1789660895394; 
 Thu, 17 Sep 2026 09:01:35 -0700 (PDT)
X-Received: by 2002:a05:6808:28b:b0:4cb:f21b:6f96 with SMTP id
 5614622812f47-4cbf21b73d7mr1601756b6e.41.1789660894634; Thu, 17 Sep 2026
 09:01:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260915145320.215663-1-aagbaria@redhat.com>
 <CAJ+F1CLyzZePL0-MaXHoXWsi6gaoodCGxxxQLn97OcuX9tSdHQ@mail.gmail.com>
In-Reply-To: <CAJ+F1CLyzZePL0-MaXHoXWsi6gaoodCGxxxQLn97OcuX9tSdHQ@mail.gmail.com>
From: Abed Agbaria <aagbaria@redhat.com>
Date: Thu, 17 Sep 2026 19:01:23 +0300
X-Gm-Features: AcwNN1XBlDvHtfmfNSrtnhNiA3rUQa9w_e7JF0aduY2hWCG9JyprEDPR7sp74p4
Message-ID: <CALn8900HdLPaEuG58Yce=njGMf1qE4vQPPDSxHg4yrViiEGwkQ@mail.gmail.com>
Subject: Re: [PATCH] qga/vss-win32/install.cpp: remove orphaned VSS provider
 service
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org, kkostiuk@redhat.com, michael.roth@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=aagbaria@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

Hi Marc-Andr=C3=A9,

Thanks for the review.

v2: https://lore.kernel.org/qemu-devel/20260917154901.321702-1-aagbaria@red=
hat.com/

On Wed, Sep 16, 2026 at 11:29=E2=80=AFPM Marc-Andr=C3=A9 Lureau
<marcandre.lureau@gmail.com> wrote:
>
> Hi
>
> On Tue, Sep 15, 2026 at 7:03=E2=80=AFPM Abed Agbaria <aagbaria@redhat.com=
> wrote:
> >
> > COMRegister() probes the COM+ catalog to decide whether to unregister
> > first, but it is the SCM that blocks installation when a service of the
> > same name is left over.  If the COM+ application is gone and the servic=
e
> > survives, install fails with 0x80070431 and never recovers.
> >
> >  - Check the SCM as well as the COM+ catalog in COMRegister().
> >  - Delete the provider service in COMUnregister() and at the
> >    DllUnregisterServer() call sites in DllRegisterServer().
> >
> > Signed-off-by: Abed Agbaria <aagbaria@redhat.com>
> > ---
> >  qga/vss-win32/install.cpp | 88 ++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 87 insertions(+), 1 deletion(-)
> >
> > diff --git a/qga/vss-win32/install.cpp b/qga/vss-win32/install.cpp
> > index 5b7a8e9bc5..0e4f2ac009 100644
> > --- a/qga/vss-win32/install.cpp
> > +++ b/qga/vss-win32/install.cpp
> > @@ -241,6 +241,89 @@ out:
> >      return hr;
> >  }
> >
> > +/* Check whether the QGA VSS provider service is registered with the S=
CM.*/
> > +static bool QGAProviderServiceExists(void)
> > +{
> > +    qga_debug_begin;
> > +
> > +    bool exists =3D false;
> > +    DWORD err;
> > +    SC_HANDLE manager =3D OpenSCManager(NULL, NULL, SC_MANAGER_CONNECT=
);
> > +    SC_HANDLE service =3D NULL;
> > +
> > +    if (!manager) {
> > +        errmsg(GetLastError(), "Failed to open service manager");
> > +        goto out;
> > +    }
> > +
> > +    service =3D OpenService(manager, QGA_PROVIDER_NAME, SERVICE_QUERY_=
CONFIG);
> > +    if (service) {
> > +        exists =3D true;
> > +    } else {
> > +        err =3D GetLastError();
> > +        if (err !=3D ERROR_SERVICE_DOES_NOT_EXIST) {
> > +            errmsg(err, "Failed to open service");
> > +        }
> > +    }
> > +
> > +out:
> > +    if (service) {
> > +        CloseServiceHandle(service);
> > +    }
> > +    if (manager) {
> > +        CloseServiceHandle(manager);
> > +    }
> > +    qga_debug_end;
> > +    return exists;
> > +}
> > +
> > +/* Delete a QGA VSS provider service that COM+ no longer owns.*/
> > +static HRESULT QGAProviderRemoveService(void)
> > +{
> > +    qga_debug_begin;
> > +
> > +    HRESULT hr =3D S_OK;
> > +    DWORD err;
> > +    SC_HANDLE manager =3D OpenSCManager(NULL, NULL, SC_MANAGER_CONNECT=
);
> > +    SC_HANDLE service =3D NULL;
> > +
> > +    if (!manager) {
> > +        hr =3D HRESULT_FROM_WIN32(GetLastError());
> > +        errmsg(hr, "Failed to open service manager");
>
> errmsg is called with win32 error code and HRESULT. This is already
> inconsistent. Imho it should be fixed first before introducing more
> inconsistency.

Fixed in v2: every win32 path now passes the GetLastError() code to
errmsg(). StopService() was the remaining offender - it passed E_FAIL
three times and discarded the real error; it now logs the win32 code
and returns HRESULT_FROM_WIN32(). errmsg() still receives HRESULTs from
the COM paths via chk(), which I left alone.
>
>
>
> > +        goto out;
> > +    }
> > +
> > +    service =3D OpenService(manager, QGA_PROVIDER_NAME, DELETE);
>
> you are adding 2 more places to open a service, when there is already
> similar code in  StopService(). I think it could be factored out.

Factored into QGAProviderOpenService(access, &err), and StopService()
is converted to it - v2 removes more of this boilerplate than it adds.
I also replaced SC_MANAGER_ALL_ACCESS there with the minimal rights:
SC_MANAGER_CONNECT plus SERVICE_QUERY_CONFIG / DELETE / SERVICE_STOP.

>
>
> > +    if (!service) {
> > +        err =3D GetLastError();
> > +        if (err !=3D ERROR_SERVICE_DOES_NOT_EXIST) {
> > +            hr =3D HRESULT_FROM_WIN32(err);
> > +            errmsg(hr, "Failed to open service");
> > +        }
> > +        goto out;
> > +    }
> > +
> > +    qga_debug("Removing service: %s", QGA_PROVIDER_NAME);
> > +
> > +    if (!DeleteService(service)) {
> > +        err =3D GetLastError();
> > +        if (err !=3D ERROR_SERVICE_MARKED_FOR_DELETE) {
> > +            hr =3D HRESULT_FROM_WIN32(err);
> > +            errmsg(hr, "Failed to delete service");
> > +        }
> > +    }
> > +
> > +out:
> > +    if (service) {
> > +        CloseServiceHandle(service);
> > +    }
> > +    if (manager) {
> > +        CloseServiceHandle(manager);
> > +    }
> > +    qga_debug_end;
> > +    return hr;
> > +}
> > +
> >  /* Unregister this module from COM+ Applications Catalog */
> >  STDAPI COMUnregister(void);
> >  STDAPI COMUnregister(void)
> > @@ -251,6 +334,7 @@ STDAPI COMUnregister(void)
> >
> >      DllUnregisterServer();
> >      chk(QGAProviderFind(QGAProviderRemove, NULL));
> > +    chk(QGAProviderRemoveService());
> >  out:
> >      qga_debug_end;
> >      return hr;
> > @@ -286,7 +370,7 @@ STDAPI COMRegister(void)
> >      }
> >
> >      chk(QGAProviderFind(QGAProviderCount, (void *)&count));
> > -    if (count) {
> > +    if (count || QGAProviderServiceExists()) {
> >          qga_debug("QGA VSS Provider is already installed. Attempting t=
o unregister first.");
> >          hr =3D COMUnregister();
> >          if (FAILED(hr)) {
> > @@ -499,6 +583,7 @@ STDAPI DllRegisterServer(void)
> >                                       g_gProviderVersion);
> >      if (hr =3D=3D (long int) VSS_E_PROVIDER_ALREADY_REGISTERED) {
> >          DllUnregisterServer();
> > +        QGAProviderRemoveService();
> >          hr =3D pVssAdmin->RegisterProvider(g_gProviderId, CLSID_QGAVSS=
Provider,
> >                                           const_cast<WCHAR * >
> >                                           (QGA_PROVIDER_LNAME),
> > @@ -515,6 +600,7 @@ STDAPI DllRegisterServer(void)
> >  out:
> >      if (FAILED(hr)) {
> >          DllUnregisterServer();
> > +        QGAProviderRemoveService();
> >      }
> >
> >      qga_debug_end;
> > --
> > 2.55.0
> >
> >
>
>
> --
> Marc-Andr=C3=A9 Lureau
>


Abed Agbaria


