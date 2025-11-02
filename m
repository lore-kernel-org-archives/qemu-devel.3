Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B442CCFA02
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Nov 2025 11:42:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFWTI-000700-Hx; Sun, 02 Nov 2025 06:42:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vFWTF-0006zm-Or
 for qemu-devel@nongnu.org; Sun, 02 Nov 2025 06:42:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vFWTC-00037G-Qv
 for qemu-devel@nongnu.org; Sun, 02 Nov 2025 06:42:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762083720;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zTq8sVfYftr7drjs7CwcghLt5QB5dH/fHXapdX89UmA=;
 b=UC4SP/NCScDk+hFbWEL2aFKS287fvdcDAVt865GGz5e5tUQTnAg5MM86NNRhGH33FA5psr
 qAT/cRUQHTZ/uXR9wzijCWLFtB8XF+mfqNH/yNJm5jZZOIS15lLxhJ2sxRWGWNtW8xHFkZ
 1aR9q20Wv1LKRp4sQ+RxD+l0T1CSyIE=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-270-4Ij6AimWM_-RhUbS2NVL5A-1; Sun, 02 Nov 2025 06:41:08 -0500
X-MC-Unique: 4Ij6AimWM_-RhUbS2NVL5A-1
X-Mimecast-MFC-AGG-ID: 4Ij6AimWM_-RhUbS2NVL5A_1762083663
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-336b646768eso3976058a91.1
 for <qemu-devel@nongnu.org>; Sun, 02 Nov 2025 03:41:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762083662; x=1762688462; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zTq8sVfYftr7drjs7CwcghLt5QB5dH/fHXapdX89UmA=;
 b=lmiDRztr57X7cF+2brGYJzl5zpj49fbxAkq+vMUJ+TNotv/eVDTudIri5Hbssf/mIM
 VK/yJ67d4uipmFWoYN4AunAF/c0RMUZt2aSDofPuDIunfK6LnBh99lS1z3TJHSPNF3BV
 cdzCdGV+KBy9XZBfAwd/wqJmf8Mp6IfSnnyXRCFqhbnaD4EP0CXYnsg/YOdUnRp9Eofj
 zMbpotX+XLPD3wrKrG4qiqt+mK9+U3I5IjtKvB7Ncr+xqn2KC40MtYlKb446fP9Dwv3d
 o8m+JSow6TK4DLmiaDj+8yonxLaAXGy0jJLDdnOQLKg+hvSGxBko5mNxET9MSeExWM0j
 Vyzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762083662; x=1762688462;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zTq8sVfYftr7drjs7CwcghLt5QB5dH/fHXapdX89UmA=;
 b=SIl+l0ZwPNKhR2QjhFg7g4gqxmSRdx0bqHCcLBeH6+vP4KgEYkEyXI4duNr3o+IwLJ
 tys12GmQTgkr3z1HMtt6Ee3/Q/ySqgpEj1QZoEwOZftxzEbQy3ZXdjhZsspCMdxYlggA
 gJqRmF26qFIeBKt9XSCiEaOJ/8H9rMW/gHePHulNTErSZ7g9ULsZZKJDtkR1I6wTJRWn
 efj86Bq6ipGMuLZ98tWlYbFDL+aDiV96EnMzj1z53XlkHFArw4TJUSWEPPQWccLOY13c
 zkgR9JHn20s10nWwki3KVUx9S3Rmxgk6l2Mo4hMAPANYNYUHfWy4d2vUmMRuNzHunfLX
 1Klg==
X-Gm-Message-State: AOJu0YyPkOCk3k/x+pMtWHW5EeHOS/Cvv/OMPl0Hs6zo232H3YCv7hYV
 nz9Qb/cize1cwjlQ8toWjF01HPjsmnWmedFY4LLoXnyRdxBk3+53UtHywWwIzDJXEKaBfEeSGvm
 hvX2Y3JepHOTskkRPTfl36enKgxexIV4FwzUxxFk4Qmq2C1rYQ3MHckHEcK0agACs0IqcUhwLQ7
 UPOkPGRvnhvW2eFzuisXZUNMP5H601DKcZfJY1CeZZNQ==
X-Gm-Gg: ASbGncvsPg4+t1PEOBnheBiYpRICWm/6r8q6hh6y9FBLqjMjSFcGstkX9G3PCTfYZu6
 Ir/EvQNE94wL+8oIJt2VXCkitAQS6YeTRJI7WgjKZXvYy66dzEogtbffnFLJzD38gDAoeVZcFbB
 2hqfE3j2Q+sC+mU1EFaewRIiSd7Cn1898hsZSLv19ospuSTX6SZ4qDgzRL1Rm54Q==
X-Received: by 2002:a17:90b:55cc:b0:32e:5d87:8abc with SMTP id
 98e67ed59e1d1-3408308a934mr10458281a91.36.1762083662174; 
 Sun, 02 Nov 2025 03:41:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGPbyneSZJ+J3+eFZyXN5cHTyGgVfonefvoboyBRohdiV70gF4wNl/SEdWuNhbqx0aRvA5vKz5AO7DZLRMRo4E=
X-Received: by 2002:a17:90b:55cc:b0:32e:5d87:8abc with SMTP id
 98e67ed59e1d1-3408308a934mr10458263a91.36.1762083661798; Sun, 02 Nov 2025
 03:41:01 -0800 (PST)
MIME-Version: 1.0
References: <20251030144927.2241109-1-berrange@redhat.com>
 <20251030144927.2241109-22-berrange@redhat.com>
In-Reply-To: <20251030144927.2241109-22-berrange@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Sun, 2 Nov 2025 15:40:50 +0400
X-Gm-Features: AWmQ_bkvlYZxZLVPMQY-sOXlN8r6eOfuysaiwsCaPZNa9SKZGdTgQlfKjXL6wb0
Message-ID: <CAMxuvax0ha3wUY_A+gxVuCfjD9=rmgoW+7OY9hC-puw8j9uyig@mail.gmail.com>
Subject: Re: [PATCH 21/21] docs: creation of x509 certs compliant with
 post-quantum crypto
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, devel@lists.libvirt.org
Content-Type: multipart/alternative; boundary="000000000000b9f66006429b1275"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--000000000000b9f66006429b1275
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 6:50=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com>
wrote:

> Explain how to alter the certtool commands for creating certficates,
> so that they can use algorithms that are compliant with post-quantum
> crytography standards.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  docs/system/tls.rst | 68 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 68 insertions(+)
>
> diff --git a/docs/system/tls.rst b/docs/system/tls.rst
> index 7cec4ac3df..03fa1d8166 100644
> --- a/docs/system/tls.rst
> +++ b/docs/system/tls.rst
> @@ -345,6 +345,74 @@ example with VNC:
>
>  .. _tls_005fpsk:
>
> +TLS certificates for Post-Quantum Cryptography
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +Given a new enough gnutls release, suitably integrated & configured with
> the
> +operating system crypto policies, QEMU is able to support post-quantum
> +crytography on TLS enabled services, either exclusively or in a hybrid
> mode.
> +
> +In exclusive mode, only a single set of certificates need to be configur=
ed
> +for QEMU, with PQC compliant algorithms. Such a QEMU configuration will
> only
> +be able to interoperate with other services (including other QEMU's) tha=
t
> +also have PQC enabled. This can result in compatibility concerns during
> the
> +period of transition over to PQC compliant algorithms.
> +
> +In hybrid mode, multiple sets of certificates need to be configured for
> QEMU,
> +at least one set with traditional (non-PQC compliant) algorithms, and at
> least
> +one other set with modern (PQC compliant) algorithms. At time of the TLS
> +handshake, the GNUTLS algorithm priorities should ensure that PQC
> compliant
> +algorithms are negotiated if both sides of the connection support PQC. I=
f
> one
> +side lacks PQC, the TLS handshake should fallback to the non-PQC
> algorithms.
> +This can assist with interoperability during the transition to PQC, but
> has a
> +potential weakness wrt downgrade attacks forcing use of non-PQC
> algorithms.
> +Exclusive PQC mode should be preferred where both peers in the TLS
> connections
> +are known to support PQC.
> +
> +Key generation parameters
> +^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +To create certificates with PQC compliant algorithms, the ``--key-type``
> +argument must be passed to ``certtool`` when creating private keys. No
> +extra arguments are required for the other ``certtool`` commands, as
> +their behaviour will be determined by the private key type.
> +
> +The typical PQC compliant algorithms to use are ``ML-DSA-44``,
> ``ML-DSA-65``
> +and ``ML-DSA-87``, with ``ML-DSA-65`` being a suitable default choice in
> +the absence of explicit requirements.
> +
> +Taking the example earlier, for creating a key for a client certificate,
> +to use ``ML-DSA-65`` the command line would be modified to look like::
> +
> +   # certtool --generate-privkey --key-type=3Dmldsa65 >
> client-hostNNN-key.pem
> +
> +The equivalent modification applies to the creation of the private keys
> +used for server certs, or root/intermediate CA certs.
> +
> +For hybrid mode, the additional indexed certificate naming must be used.
> +If multiple configured certificates are compatible with the mutually
> +supported crypto algorithms between the client and server, then the
> +first matching certificate will be used.
> +
> +IOW, to ensure that PQC certificates are preferred, they must use a
> +non-index based filename, or use an index that is smaller than any
> +non-PQC certificates. ie, ``server-cert.pem`` for PQC and
> ``server-cert-0.pem``
> +for non-PQC, or ``server-cert-0.pem`` for PQC and ``server-cert-1.pem``
> for
> +non-PQC.
> +
> +Force disabling PQC via crypto priority
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +In the OS configuration for system crypto algorithm priorities has
> +enabled PQC, this can (optionally) be overriden in QEMU configuration
> +disable use of PQC using the ``priority`` parameter to the
> ``tls-creds-x509``
> +object::
> +
> +  NO_MLDSA=3D"-SIGN-ML-DSA-65:-SIGN-ML-DSA-44:-SIGN-ML-DSA-87"
> +
> NO_MLKEM=3D"-GROUP-X25519-MLKEM768:-GROUP-SECP256R1-MLKEM768:-GROUP-SECP3=
84R1-MLKEM1024"
> +  # qemu-nbd --object
> tls-creds-x509,id=3Dtls0,endpoint=3Dserver,dir=3D....,priority=3D@SYSTEM:=
$NO_MLDSA:$NO_MLKEM
> +
> +
>  TLS Pre-Shared Keys (PSK)
>  ~~~~~~~~~~~~~~~~~~~~~~~~~
>
> --
> 2.51.1
>
>

--000000000000b9f66006429b1275
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Oct 30,=
 2025 at 6:50=E2=80=AFPM Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berr=
ange@redhat.com">berrange@redhat.com</a>&gt; wrote:<br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">Explain how to alter the certtool comma=
nds for creating certficates,<br>
so that they can use algorithms that are compliant with post-quantum<br>
crytography standards.<br>
<br>
Signed-off-by: Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redha=
t.com" target=3D"_blank">berrange@redhat.com</a>&gt;<br></blockquote><div><=
br></div><div>Reviewed-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:mar=
candre.lureau@redhat.com">marcandre.lureau@redhat.com</a>&gt;</div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">
---<br>
=C2=A0docs/system/tls.rst | 68 ++++++++++++++++++++++++++++++++++++++++++++=
+<br>
=C2=A01 file changed, 68 insertions(+)<br>
<br>
diff --git a/docs/system/tls.rst b/docs/system/tls.rst<br>
index 7cec4ac3df..03fa1d8166 100644<br>
--- a/docs/system/tls.rst<br>
+++ b/docs/system/tls.rst<br>
@@ -345,6 +345,74 @@ example with VNC:<br>
<br>
=C2=A0.. _tls_005fpsk:<br>
<br>
+TLS certificates for Post-Quantum Cryptography<br>
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~<br>
+<br>
+Given a new enough gnutls release, suitably integrated &amp; configured wi=
th the<br>
+operating system crypto policies, QEMU is able to support post-quantum<br>
+crytography on TLS enabled services, either exclusively or in a hybrid mod=
e.<br>
+<br>
+In exclusive mode, only a single set of certificates need to be configured=
<br>
+for QEMU, with PQC compliant algorithms. Such a QEMU configuration will on=
ly<br>
+be able to interoperate with other services (including other QEMU&#39;s) t=
hat<br>
+also have PQC enabled. This can result in compatibility concerns during th=
e<br>
+period of transition over to PQC compliant algorithms.<br>
+<br>
+In hybrid mode, multiple sets of certificates need to be configured for QE=
MU,<br>
+at least one set with traditional (non-PQC compliant) algorithms, and at l=
east<br>
+one other set with modern (PQC compliant) algorithms. At time of the TLS<b=
r>
+handshake, the GNUTLS algorithm priorities should ensure that PQC complian=
t<br>
+algorithms are negotiated if both sides of the connection support PQC. If =
one<br>
+side lacks PQC, the TLS handshake should fallback to the non-PQC algorithm=
s.<br>
+This can assist with interoperability during the transition to PQC, but ha=
s a<br>
+potential weakness wrt downgrade attacks forcing use of non-PQC algorithms=
.<br>
+Exclusive PQC mode should be preferred where both peers in the TLS connect=
ions<br>
+are known to support PQC.<br>
+<br>
+Key generation parameters<br>
+^^^^^^^^^^^^^^^^^^^^^^^^^<br>
+<br>
+To create certificates with PQC compliant algorithms, the ``--key-type``<b=
r>
+argument must be passed to ``certtool`` when creating private keys. No<br>
+extra arguments are required for the other ``certtool`` commands, as<br>
+their behaviour will be determined by the private key type.<br>
+<br>
+The typical PQC compliant algorithms to use are ``ML-DSA-44``, ``ML-DSA-65=
``<br>
+and ``ML-DSA-87``, with ``ML-DSA-65`` being a suitable default choice in<b=
r>
+the absence of explicit requirements.<br>
+<br>
+Taking the example earlier, for creating a key for a client certificate,<b=
r>
+to use ``ML-DSA-65`` the command line would be modified to look like::<br>
+<br>
+=C2=A0 =C2=A0# certtool --generate-privkey --key-type=3Dmldsa65 &gt; clien=
t-hostNNN-key.pem<br>
+<br>
+The equivalent modification applies to the creation of the private keys<br=
>
+used for server certs, or root/intermediate CA certs.<br>
+<br>
+For hybrid mode, the additional indexed certificate naming must be used.<b=
r>
+If multiple configured certificates are compatible with the mutually<br>
+supported crypto algorithms between the client and server, then the<br>
+first matching certificate will be used.<br>
+<br>
+IOW, to ensure that PQC certificates are preferred, they must use a<br>
+non-index based filename, or use an index that is smaller than any<br>
+non-PQC certificates. ie, ``server-cert.pem`` for PQC and ``server-cert-0.=
pem``<br>
+for non-PQC, or ``server-cert-0.pem`` for PQC and ``server-cert-1.pem`` fo=
r<br>
+non-PQC.<br>
+<br>
+Force disabling PQC via crypto priority<br>
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^<br>
+<br>
+In the OS configuration for system crypto algorithm priorities has<br>
+enabled PQC, this can (optionally) be overriden in QEMU configuration<br>
+disable use of PQC using the ``priority`` parameter to the ``tls-creds-x50=
9``<br>
+object::<br>
+<br>
+=C2=A0 NO_MLDSA=3D&quot;-SIGN-ML-DSA-65:-SIGN-ML-DSA-44:-SIGN-ML-DSA-87&qu=
ot;<br>
+=C2=A0 NO_MLKEM=3D&quot;-GROUP-X25519-MLKEM768:-GROUP-SECP256R1-MLKEM768:-=
GROUP-SECP384R1-MLKEM1024&quot;<br>
+=C2=A0 # qemu-nbd --object tls-creds-x509,id=3Dtls0,endpoint=3Dserver,dir=
=3D....,priority=3D@SYSTEM:$NO_MLDSA:$NO_MLKEM<br>
+<br>
+<br>
=C2=A0TLS Pre-Shared Keys (PSK)<br>
=C2=A0~~~~~~~~~~~~~~~~~~~~~~~~~<br>
<br>
-- <br>
2.51.1<br>
<br>
</blockquote></div></div>

--000000000000b9f66006429b1275--


