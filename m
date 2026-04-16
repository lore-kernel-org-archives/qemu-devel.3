Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42A21F8DFCC
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 21:42:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDUTb-0007DU-Et; Thu, 16 Apr 2026 17:42:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rafettaskindev@gmail.com>)
 id 1wDUTa-0007DD-0n
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 17:42:18 -0400
Received: from mail-oo1-xc32.google.com ([2607:f8b0:4864:20::c32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rafettaskindev@gmail.com>)
 id 1wDUTY-0003uc-6n
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 17:42:17 -0400
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-68be75dc734so12221eaf.1
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 14:42:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776375735; cv=none;
 d=google.com; s=arc-20240605;
 b=LR1LyPtF53xA+TlIWQBCiNwbcKicj7f4Iz4q90Yuhud2EWndM/zM/mxQUHDGeII+vD
 n27iG5FYCymDhY4wTSTK351LL3URrd96BMdiVXyo2iuhevaR0tdpiZphHzRmpd38gVCo
 8ol7FFmDV7JRvFJjvK7pYm5hkDsXYwqC/Qc1/0lztRbdKHoHzqcAhym3xVNF5WTmwSQZ
 uNO5MwVLICb7SnBA5U9MV7rw2jldbCOTp4bpQnDiW4NBvhBzfNh+76wcLjTrjgoRwhhx
 26ZNh/hdCtpm8kv9ZTgnDfmLBZ+J1MFXh13zKVNhxVY1m1ySTEr503hJSxkPhSZL2504
 EWLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=mEoZrGP3WLfVGUTvEJ19j/ReXmXPSdwHLEFedqzvpwU=;
 fh=thzXvac9Kk3nSBPKBjQdF0CC0tJ/iBA2wDKvogBbYYY=;
 b=VmbeK+Nt9T6z6iAFcZbsu+OwbKDrcu35MwokmOdVc7veHbt/TWFmGKaWuGH82dcKsk
 2qpi4aRtVYHTQCrnQ4k0A33f2ZDZfyRlWiPl3KOlX7Hw27uQDVM6SL12JPVlg6wJTUYD
 DXAW+xNiIRueDXnpomh1NNwXQTf8fvrsnYmHIxX4BsXfyuhGHdcUYJKVov0ZJ3erc9fC
 8gZNZhhwV8gpYY05LwNJ04ESCF9EKpVQ+VcNGfQyJNukCQi5LZbqmKk7r1KwseoBhK+6
 Oxf/8o1cSYuRIXFI79mHs1EEdSvy+rN9hGav7sqTm0vNzU5tts4+KerclaslH1bStSVJ
 5rjA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776375735; x=1776980535; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mEoZrGP3WLfVGUTvEJ19j/ReXmXPSdwHLEFedqzvpwU=;
 b=rcDu9SbO7FTnbFRz1AQnDH2MLjlojZecA9v6KNRJ6dC7aR+YI/XRdXHne9gDywD/x+
 Y8cNBhDsLAKb1hZlm+ubN9+IPk2QGxtSA6of0ZBRERgckotYTVn7AHG6ZHoL9980S7PE
 Rxpo3zO0dmJNJMOb2102tFnFX2ZM2tno1RQz/gUQP8N/ZilzD4Gqp1BoaDes6W83FlhQ
 txQwf0eG8eHewehorYqY7+GiVddwS18DXExRVEt5ISu7zZlkPdkuTG6GYHzSujfXfsqK
 FVTNW6h9c5mJ1ZJ9kcx1SN5T/mIPDja54AUQnoZ4Pn+zuN5JuVTVcvPOTCufHkkFoWLB
 zp+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776375735; x=1776980535;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mEoZrGP3WLfVGUTvEJ19j/ReXmXPSdwHLEFedqzvpwU=;
 b=aEpgO2GyVcHNYbQO/6OMIzIO8fVEw4fDUPbx38tN75egUgA5QvvtFMjXBgnE6zQV5L
 oEqH96w9RmKSIc3YZJQ9wSGDX4ALN0SnsrI0wQSd4LxOmzkF7tK9SuP5Wmo6rd4kQOKc
 /E5c7CMHewCxkliXvMXLcQR0oxUHh+8lUnKu6VcnA7CoCyhEFbe1cDt2dVMeYv84CxRh
 N8lC8KTeITOLIxOJZSeuF1eFiyDf+Ph1Lk1to5byCH0+lLbVQ84Fmgt3OHQ5LRJDyFXO
 7TedEhW+SiPf/aQZym3l5g9MNKSpdPCdXEDN1GvfjryqPws/P+M7MabGX6XlfQN9sBzk
 Hsaw==
X-Gm-Message-State: AOJu0Yw8V+kAIdcrFX09m5ECYC+TmrsTrDp5yrMjbLwcaDZyVUYHh4Q9
 VRa7Y3u41nfkwjq3GQIwh8rJD+cgVKzWF4clZi2jArp9iGqtL8e7QOCALwsjt5nSIh5m6FEnZj0
 WzxXDpwonQEjRZ0w+gzdmynI82f/CIPM=
X-Gm-Gg: AeBDieteNcEwybAx7HD75W+QvW/XyCgX2lqV3fK4cSvLaVPZetbX72dq5mSUSeZqKAJ
 v6bmnA6E2Nt52tyNuLAXE/moIcJ+FhIPJZo8JMiE6Vt4oVeXXsZu4tBjiinbvXXD3bVM3IbyhU+
 oOD+F6T+B8Z2UCRI3TjOn59MOMF0YqG31z83xy3SkEXBaPaYU0NFca2NWj+/CrvZUvC5KclRONk
 B3+BsFsh1hvXhf3xhNasGtaYE4iOSnbDw46gCgVd1Atj91JD1FzdcqZ++T+F6c/dSiYb0u4fmRj
 YzlU0nvKY0bHqh2l
X-Received: by 2002:a05:6820:1686:b0:67d:e9ce:cb23 with SMTP id
 006d021491bc7-69462ee05c3mr209543eaf.38.1776375734992; Thu, 16 Apr 2026
 14:42:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260416173448.88831-1-rafettaskindev@gmail.com>
 <c2ec0a72-8c35-44de-bd7c-cef445c646f4@gmx.de>
In-Reply-To: <c2ec0a72-8c35-44de-bd7c-cef445c646f4@gmx.de>
From: Rafet T <rafettaskindev@gmail.com>
Date: Fri, 17 Apr 2026 00:42:03 +0300
X-Gm-Features: AQROBzD3NuPbel7NPjTWXq_Ra6fozUhlJ30b-TxjvZ5VU2HPiH_vVZAZdBhloDc
Message-ID: <CA+JCratdkXwmk29sZEO-zegSA0kvei2C=x0toZvZQWTjS7DNuA@mail.gmail.com>
Subject: Re: [PATCH RFC] hw/scsi: Add SCSI tape device emulation
To: Helge Deller <deller@gmx.de>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, fam@euphon.net
Content-Type: multipart/alternative; boundary="000000000000ac0542064f9ab4d7"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c32;
 envelope-from=rafettaskindev@gmail.com; helo=mail-oo1-xc32.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--000000000000ac0542064f9ab4d7
Content-Type: text/plain; charset="UTF-8"

Hello Helge,

I honestly didn't give much thought about whether sending patches before
being choosen was okay or not. I was interested in project and wanted to
try something. Sorry if it caused any disturbance, that wasn't my intent.

Thanks, Rafet

--000000000000ac0542064f9ab4d7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><p class=3D"gmail-font-claude-response-body gmail-break-wo=
rds gmail-whitespace-normal gmail-leading-[1.7]">Hello Helge,</p>
<p class=3D"gmail-font-claude-response-body gmail-break-words gmail-whitesp=
ace-normal gmail-leading-[1.7]">I honestly didn&#39;t give much thought abo=
ut whether sending patches before being=C2=A0choosen was okay or not. I was=
 interested in project and=C2=A0wanted to try something. Sorry if it caused=
 any disturbance, that wasn&#39;t my intent.</p>
<p class=3D"gmail-font-claude-response-body gmail-break-words gmail-whitesp=
ace-pre-wrap gmail-leading-[1.7]">Thanks,
Rafet</p></div>

--000000000000ac0542064f9ab4d7--

