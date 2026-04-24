Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4886AFED3FA
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 20:03:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGMjc-0005vc-OB; Fri, 24 Apr 2026 16:02:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wGMja-0005u2-7s
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 16:02:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wGMjY-0005fO-OI
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 16:02:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777060959;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a2zR6YYxbx26ruwwyPFncFSQbtpKRWyRpDI5EBDDrDQ=;
 b=ObmTctPyPlEmV0+BZz+hvv33YmlPb0j2fXKMT5Ngo4tB++USlaSRZFIOcYvpYjUMSTEViP
 wzFBupGup39oILQhh00n38Q2veFCzvunDSCWLBItmpbChGfwd3ZG8R/57Glxd2eCb3oYEc
 97LEsWkUr0aQILeLIEWv48H5wCvKVtU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-454-KXa9A7vEOYePY6M-5Ictng-1; Fri, 24 Apr 2026 16:02:38 -0400
X-MC-Unique: KXa9A7vEOYePY6M-5Ictng-1
X-Mimecast-MFC-AGG-ID: KXa9A7vEOYePY6M-5Ictng_1777060957
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-43ff0eb2b2aso5327019f8f.2
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 13:02:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777060957; cv=none;
 d=google.com; s=arc-20240605;
 b=kL9lZ8qQrKaBAEv3Jt7QacqD1RI//2zOs/IgOR4uc8JCd/nmXSuHNzLUJ617jRGrtR
 NScEEHzlTKBrMOixEkskDRtEAYjReZIg2LYHphyu/jYw8q/Wr0EZdT9xg31+Po9OkGy+
 9R+/PAgeUjThFqv5Wuv7qs3yVQapJA1PQF4mMt1ZL7Ka1FHTZP62Ai+eWjTcaNTzIlJ/
 ZZPgKrQjrBiKB/xERXuNkFHLXDSaZF+atL8rbz4+oj7zAcnbow6vO0v++Ik1zudEk4gT
 Jt2f/WdOo4Sj1ZfctD7uv7/DNiYUp+++iw1uUgauSQCpqXr0vleJf+dQkv9+QdjeMCsI
 StCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=a2zR6YYxbx26ruwwyPFncFSQbtpKRWyRpDI5EBDDrDQ=;
 fh=k/ERWuvEcUiMq/m5FKiZGPdmE3b9qOyxtPmn65Bdf0A=;
 b=WLeRAcT18tsIqX1VQqjxX6v+hiwcTjFwu4qVLM96K8roBZ67bByDKQB9IXssb3c9CC
 ToCH7hc1W/HO7qUvkJCmHekFb6Iy7+6ubepclc9yXBvOmu9Mu7IKF5m9oP6S/XQBsfLo
 GrZQRvLHV5XECz+kbM9Zh54nSuBkcBHP2cnTPnozpQAac+4neWkaVJ4aKks2wRpD8GvO
 bpa+qF9QS1a2D++QksTwQaTpTEds2CSQgUBvrw2bWmjBrdH7RrIioxoD+HMmMt2DL+Ii
 f8WKtrJij67jdQNnYNRdVbPLW4P4Qh/C0XJ86SRPAK2WBJ5hPps4ShLKtr8cBbf4RDhn
 6hNA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777060957; x=1777665757; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a2zR6YYxbx26ruwwyPFncFSQbtpKRWyRpDI5EBDDrDQ=;
 b=ThKsgNq5w6BJyPWzlvtariReFXEyYipj/Vvr9a+pFp5YLWUVgG4VLwzRbbWF9Z+nEG
 lZVQW0rw8esAqWVyPiTbjfyzkcedcEugBksBvQQ0wsHgM3WY1qylrqa+3+S7GTQLiY3k
 WrF1gZMzFNJWK0CXRcRE7xbIJuIlokIK6OVxuKcYfguiX3ffJWPUMG9lrQbl5IxdIt3o
 qu8kgS2HxegE+4YxYNynM6Sx6x9AMZ9zDrcDNKMvPCf2v1QZWOiukHxgF9YgTXQf/zZ4
 HNmX1VgFh/L2x6YXamsCs/8rWw5++EBngAHSBDf3PJNXFlHbdRt13zb7vecnUxkrA+Ja
 0Uqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777060957; x=1777665757;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=a2zR6YYxbx26ruwwyPFncFSQbtpKRWyRpDI5EBDDrDQ=;
 b=c1C+iyQbwo3bcMISD70rmDub1EEhIMe/HI05phVA1q8CcdpDWQEiFzAbFeZsBwV1OA
 YkDVeu6xVGIoGw3dk5UHJlZZr7/rUQqmM27fOwNvgDTRofnYxTy5oi4OUCCCbvtaoUv0
 ZYHKQe4ZR+RpVwELJ5yh3MqMkh2c0DxPTUel3/6ouqvhMrfWuJ4ozTq8j0ntlLtsPrOk
 PoM2TlWr9/SZ5LsLej5V21LUJhyTm4gvfOXG6+/ugGgexJjrFNMndmt1BlvrU9jzpjL5
 pu5PX/vK7pTSSMnUiUxOZpDWGL5TBxVZlwa0Mjs4gM/ouu8mz1ENEeMzsi4v0ALRFONR
 ZOOQ==
X-Gm-Message-State: AOJu0YxfcxYqQMmTTio+kq7pGwXqj85e/hb95eg+S35V9PdKeq3mcYv8
 b5v342BCiwPRvtBO606LWzCvhAaS7ywHRBJnS11jgp2pL0qc8tW+zqGVp7pyJ/MK5WrP0CPpFkZ
 +S2orJ9egfcI3oqKlfkAYube9UhWrai+2GIcEcuqxvDTOqM8ld2kg0ItGFR9CJ1SehvnxbBD1ho
 630OcWh5Cb/nbY0ZjzbAzl9ZQ69pwYNzA=
X-Gm-Gg: AeBDietMtMIjkziHXZGTrHcfpXdPnfefJWwb/IXAzjrU/iAyagq8NJN6+xlXLbhx6eW
 +jGSVnZ8cmJB0tDofMS322zYEA2NzX/4lwvnYJyfMwvbpmy4OB6D7FLkr1A+L70Z63BKWHkz+sL
 cCpusU3EPUW44f1K3AdyB4TiQU+6TEXnibsNKI///1BzA+l0hbUfao2CJtNPtrZF3IDZd39xqMR
 uLrL6kU1SjIR09yEE2sab60yiGjBOM2ynX6bDK7kfEtT+x7NAIIx/B/Op2tZM+4eGyIpgpzrYYm
 edXMde9DjmrLhLg=
X-Received: by 2002:a05:6000:22ca:b0:43d:50c:6f33 with SMTP id
 ffacd0b85a97d-43fe3e0bde7mr51830830f8f.26.1777060956610; 
 Fri, 24 Apr 2026 13:02:36 -0700 (PDT)
X-Received: by 2002:a05:6000:22ca:b0:43d:50c:6f33 with SMTP id
 ffacd0b85a97d-43fe3e0bde7mr51830798f8f.26.1777060956145; Fri, 24 Apr 2026
 13:02:36 -0700 (PDT)
MIME-Version: 1.0
References: <69eb98cd.050a0220.35705d.4552@mx.google.com>
In-Reply-To: <69eb98cd.050a0220.35705d.4552@mx.google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 24 Apr 2026 22:02:24 +0200
X-Gm-Features: AQROBzA1Yg8zyChHC2NaQlew8oqFMVCQHUNzNrJa1hD4yZ-FoAVT6hIa3rG-fGY
Message-ID: <CABgObfaXUPQfz72m8FCxxfdKo-Mx=WG-ETgGwrvTcN_fBzC9Eg@mail.gmail.com>
Subject: Re: [PATCH] build: prefer sigaltstack over ucontext on Linux
To: "elisey.konstantinov" <elisey.konstantinov@gmail.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, philmd@linaro.org, 
 berrange@redhat.com, marcandre.lureau@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Apr 24, 2026 at 6:22=E2=80=AFPM elisey.konstantinov
<elisey.konstantinov@gmail.com> wrote:
>
> A special thanks for the patch; I=E2=80=99ll definitely give it a go, tho=
ugh I=E2=80=99m not sure about x86, as the bug doesn=E2=80=99t occur on x86
> This patch should work on PPC as well, shouldn=E2=80=99t it?

The patch is for x86 hosts, and any guest including PPC.

Paolo


