Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5FB4CCFA13
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 10:59:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIP6V-0006zR-BA; Thu, 30 Apr 2026 06:58:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wIP6L-0006yQ-GN
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 06:58:37 -0400
Received: from mail-yx1-xb131.google.com ([2607:f8b0:4864:20::b131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wIP6J-0000DN-KM
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 06:58:37 -0400
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-6563f83ae9fso843004d50.1
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 03:58:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777546714; cv=none;
 d=google.com; s=arc-20240605;
 b=e0m1Zem76ChxHtqREYhrLHc4RNBHBRLYBknok5TFr6YGvAkuHAQL8zjqIIjVlUVxJX
 q2h7NJGw4BfY+7H9ISXFPovR0CvOwBXmxi9RCZ/qJG88/W8KiAG9bGpQVEXbFTtMymOz
 DVnDCN04EQHNR3vPBSFCJPiEaL7iKRM5gJAcSGfjUoUfBr4SAMM0+miO0xEgMZIjuTjq
 5GwZqiVHPKh4JkV6G6U/RkndkejXPv5beNv1KHbRzZDsl6sdkZdiyRgcU4iC8a+Mr+Nl
 mznPpo5THd/Bqi0ZI1AjsNxFX54eiLy0K+CMEUXRcYArbpSblVe8gyppd0JCQzeKVzeS
 Jdmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=jPSxtL6gUHm/KeScKjAHVZDuKSG3q6q2SErUdUcQGDw=;
 fh=L0+NiO1dk2svgH8TdO1hLVvvgiN+SVSZdG3CsBcLNBc=;
 b=BBsQr8YchititGcQrs6dA+j0YNxJOcRLcnZxO5cWBoiczau0Rg8N/njQS66thWC9EH
 vIrsh4PmdUuK2Kz3YtaE22zZjnK/HNieUAnx7/G962FuFKSLQEmTEjVg3NstebsDikw2
 6kfBypaxabBnebLX/thWCVMvbbb3boB+JPKvVRkBxnTY6Cx2+zmfLRyYJ2iBPugbZgFX
 K1dvx6eV9yuXTr41Z+MkYuNY2A2psD/4os+kfjiKxDVAfL+JNBFCRTPCZcuB6Mb8tC+x
 GWDaFcChvlNL9T+7xkXUmdnWu3QZdOOCzXCuHsQaFplR/MrBcSi/HQ4tdZgNkQzJkgiK
 1aaQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777546714; x=1778151514; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jPSxtL6gUHm/KeScKjAHVZDuKSG3q6q2SErUdUcQGDw=;
 b=ZvY4rIO26vDX3zl1pKYMpWcGKP/W86rGepPfSCqHXoA7kxWz/SQi4kvpZU+IGlm1ue
 OtNWhdHR8FrX/ruWNpEvY+s5TOr1fbg/fVvYAPMOkujrzvf9/fnn/Eo0X5wn0qgk3vom
 hVGOsBVJTUBnuSa/57RaZoK6bvrlsR3lo+ruBjGvVc77XTjWzHi5C5ieolRLXsUHhoWB
 NRI+220rI/U9zLTBUi5K7DuXnrevJgvn8aV8GZ0POYs+oCT7HaCnIMhg7p2WAghvy0Hn
 yEjcnXsLWFoLU1JTODOE6/q2YmEPcrlTdm2JfeyjwkD4hofhrpxOE04BghKuXi9FxdW/
 NYnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777546714; x=1778151514;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jPSxtL6gUHm/KeScKjAHVZDuKSG3q6q2SErUdUcQGDw=;
 b=a+X3c7gKHIUe3oHVnnlgdjPiNVnTSMGfhyM4qNtQ7petMdwndERAkq1sfOg7+V1fAO
 HZcQdT91gX6u9XmZk9UnAu4DKRBlx09UFF79zITGkd8eVT4KwHwfgjj63WAA2tpQnT1X
 IwT/iRvkXdmDMIZrGETwGAvz9heJtf53p7KklnWs1s4b1vDSwL4GAiCwX/8lyhCvzy4h
 CCNQGOLyZ4wlBmReJ+q3e91E+IO487LZ/rHQ2mbMK5rbLfBT8g75tSvd4CbK6BAQJBre
 QVzY3YF8v1LTTvkK9xOYBsUuUSbQPxwWyI36s0nd78TrFFYZpJ1MY72sK2Vwu0ne/PDn
 y7hA==
X-Gm-Message-State: AOJu0Yz61wU9xnsi5hqyp9E2GPg/kc+q0bSKgXKss94kYGavaEwCIld/
 FA1mht2VSq0ItNMNVwUuBcx/2tscT9vb2zWJNCTxWTr75no8j8nlor0+q7a2DcXq+XT/GdeFzal
 50jIITQLmlhwfYeWAQTSCOoSFWkTsj9/lZXFy4dkEmg==
X-Gm-Gg: AeBDieuIclHzd04LKR1sZ6cfir83j1BwHx02pzIE00ZO1rT+IKDLBbnIOuflDzPCr+e
 E6EyJcTQ0tsLj4lhLMTNOhOPuag1iKKaGgsUFREZ+yoT4FPJz8hBGY1o+aazOhrQD3/zCn+NqpB
 sfp2ko8JNmJNvzl4UodTAFytG7198qNn/K4JP6gu7fwKw2TdodmkzFNrxdtbf1g22dloBWyA2jt
 35WmNMMVmbL9K4oxBklSsQGII5nMwcYo5+q1+hR4KXbXVcHp4Gxy9uRU19h1DGFOq7ZadB0Wg64
 1oTcO5+ndHljs9ikpaLq9wuRPYxjjTwZBkPoGEh+d0DdCPYab3EmFR9PGMEZCLPPQVedKev1+2J
 y8g==
X-Received: by 2002:a53:c059:0:20b0:654:2820:f657 with SMTP id
 956f58d0204a3-65c18f55f9cmr1277807d50.47.1777546714124; Thu, 30 Apr 2026
 03:58:34 -0700 (PDT)
MIME-Version: 1.0
References: <20250802110549.23438-1-pali@kernel.org>
 <20250810130948.3yzymcxtkmfkgk67@pali>
 <20251109134141.ur2s3bk5e6dgquxv@pali>
 <CAFEAcA8+cycE_JvFDEtAmbJtXwRVwU026rOBYNV+cZaq5wZ+XQ@mail.gmail.com>
 <20260418012012.by2qdlkbryjf2ugv@pali>
In-Reply-To: <20260418012012.by2qdlkbryjf2ugv@pali>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 Apr 2026 11:58:21 +0100
X-Gm-Features: AVHnY4LRW9_lSvGP8hJ9qpGtiLE0o7efvrngVKNmkkYY9BnUgK351duQNnAIyIY
Message-ID: <CAFEAcA8VcTN1ANX0EpCqCiyBVDckCp-D99TxabAghxtLdnMkgA@mail.gmail.com>
Subject: Re: [PATCH] qemu-options: Improve description for -smb option
To: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc: qemu-devel@nongnu.org, Samuel Thibault <samuel.thibault@ens-lyon.org>, 
 Jason Wang <jasowang@redhat.com>, Mohamed Mediouni <mohamed@unpredictable.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb131.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Sat, 18 Apr 2026 at 02:20, Pali Roh=C3=A1r <pali@kernel.org> wrote:
> Yes, this is a good idea to mention. Finding those information would be
> harder in future, specially when Microsoft already removed those KB
> articles from own servers and web archive does not have copies of them.
>
>
> About about path to LMHOSTS file. On 3x/9x/Me systems it is <WIN>\LMHOSTS
> and on NT systems it is <WIN>\SYSTEM32\DRIVERS\ETC\LMHOSTS
> <WIN> is the Windows directly which can chosen during installation of
> Windows itself. 3x/9x/Me has default C:\Windows; NT 3.1-2000 has default
> C:\WINNT and since Windows XP it is default C:\Windows. So path to the
> LMHOSTS file depends on installation and default path was changed more
> times.
>
> Note that Microsoft Network Client 3.0 and Microsoft LAN Manager Client
> (both are DOS based) also need that adjustment of the LMHOSTS file.
> Default location for Network Client is C:\NET\LMHOSTS and for LAN Manager
> is C:\LANMAN\ETC\LMHOSTS. I check Network Client 3.0 and it is working
> fine with and also without #PRE #NOFNR.
>
> Maybe the documentation could be extended and mention something like:
>
>     must be added in the file ``C:\NET\LMHOSTS`` (for DOS Network Client)
>     or ``C:\LANMAN\ETC\LMHOSTS`` (for DOS LAN Manager)
>     or ``C:\WINDOWS\LMHOSTS`` (for Windows 3x/9x/Me)
>     or ``C:\WINNT\SYSTEM32\DRIVERS\ETC\LMHOSTS`` (for Windows NT/2000)
>     or ``C:\WINDOWS\SYSTEM32\DRIVERS\ETC\LMHOSTS`` (for Windows XP and ne=
w)

Thanks for doing the testing on different Windows versions. Based
on this conversation, I'm going to take this patch, with some
expansion of it, like this, so we explain what #PRE and #NOFNR do,
and list LMHOSTS locations for newer Windows. Let me know if you're
OK with this or you'd prefer some other changes.

diff --git a/qemu-options.hx b/qemu-options.hx
index e780bc2ac0..98e39a1ad4 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -3415,7 +3415,7 @@ SRST

     ``smb=3Ddir[,smbserver=3Daddr]``
         When using the user mode network stack, activate a built-in SMB
-        server so that Windows OSes can access to the host files in
+        server so that Windows OSes can access the host files in
         ``dir`` transparently. The IP address of the SMB server can be
         set to addr. By default the 4th IP in the guest network is used,
         i.e. x.x.x.4.
@@ -3424,11 +3424,20 @@ SRST

         ::

-            10.0.2.4 smbserver
+            10.0.2.4 smbserver #PRE #NOFNR

-        must be added in the file ``C:\WINDOWS\LMHOSTS`` (for windows
-        9x/Me) or ``C:\WINNT\SYSTEM32\DRIVERS\ETC\LMHOSTS`` (Windows
-        NT/2000).
+        must be added in the ``LMHOSTS`` file. In this line, ``#PRE``
+        requests pre-caching of the mapping, which speeds up the initial
+        connection on some Windows versions. ``#NOFNR`` is necessary for
+        Windows NT 3.1 to tell it not to send QEMU NBNS query packets that
+        QEMU does not handle, and is harmlessly ignored on other versions.
+
+        The ``LMHOSTS`` file may be in different locations depending on
+        the Windows version:
+
+        -  ``C:\WINDOWS\LMHOSTS`` for Windows 3x/9x/Me
+        -  ``C:\WINNT\SYSTEM32\DRIVERS\ETC\LMHOSTS`` for Windows NT/2000
+        -  ``C:\WINDOWS\SYSTEM32\DRIVERS\ETC\LMHOSTS`` for Windows XP and =
newer

         Then ``dir`` can be accessed in ``\\smbserver\qemu``.

thanks
-- PMM

