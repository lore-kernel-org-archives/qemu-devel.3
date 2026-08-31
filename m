Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4112CC61DE2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 11:36:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x10JM-0007ZK-KU; Mon, 31 Aug 2026 07:36:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1x10JK-0007Wn-Hz
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 07:36:23 -0400
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1x10JI-0006y1-TJ
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 07:36:22 -0400
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-86162c086f8so20107807b3.1
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 04:36:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788176179; cv=none;
 d=google.com; s=arc-20260327;
 b=ZHHfU8nCiZR2UPm5LIEJRML3qp/SEnFqY6FkLCSHVjVvqhVe80QtTeeFNb/Gb9YxVA
 +JwtZWl2mT4lNfTqi7wbxg9YsloEZEFmPp1hF8qBlNPI90XQu1H+McYOXf6SKTNtqu4x
 jB1otansol8FbeM26B9osGaIpSnoBZje4mcQ0wYEZQ0YiBceXXe09jaD1cLd3tYXMnzL
 INKjVUCgOk78w5CDMluckQtwjsrahVCejHYR86ao5mAY5JqsMPbLQr1ocu5+zggAorPX
 Qe2jhCfSj80U0r2p3OXzFacvHc1qWr5WnaQuK4C6hUtt1gqxTFM2WrsHLQtDurRIf7S1
 vNrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=PG9p354toZVh26ejfuxNVjpXc9iuS5rH+HKF405DW2Y=;
 fh=PnYt+qEB9tAfMKoqBm2xjKOFpYyFFGPudh5cVIoieJM=;
 b=n9FzpkdQE6xEgAPuPwKYpUKecBUGv8x+qgECk+a9qDn5EJUgUhRoToNKsCQ18DkhRX
 YRRyl3XAVoHC6lYPB90FHmnI12VcPomGIC6z8DgTFo7e2RJ1eYwDr9ziBpHg3rjda+Up
 rQwe69et+DqIEphbrimVrO8T2UeF22CMAUIJ8Z5DiJeEkWMesUL9dIQuejVxiGo+5Cba
 UcKpSWm8ryHttQWd5nD7EUs2wfU296A5v06z2nlFu8l0JpAZFDyJaSGa2ir4YEQIWCnR
 erKfUVYyvBeABpYAN2hJcRZwlpQtfUrjb2InqcZKr6FW/mHTEnfinoi6WGzXkLND9+c1
 hPFA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788176179; x=1788780979; darn=nongnu.org;
 h=content-transfer-encoding:content-type:to:subject:message-id:date
 :from:in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PG9p354toZVh26ejfuxNVjpXc9iuS5rH+HKF405DW2Y=;
 b=NCxcl0ZYjjAIxCtV3sgBNki+LB5AH8VnDfsLc4wuO6JBfI47vSMuL6jX2dd2VXFD3D
 xfdrOc135B4usuqV8XmBPBCBpciISMPd++Xbm6SV/X9p6p1HjHVlG0CfdSRSRU3wItF4
 wkqf7kWtZNUxu45d5+PnRDV23el1i2OWjetzuYAMeDs2VS04bU8cXScctsnqcqG7zf6X
 PrS4kvIy32utKEDRtODOBOhOOQAJ+hkHYClk60nSt9BJt3M1jTSJUwCF8TeJNAuoBo0r
 AKVNO0gxuUF8cw6P/JuEJ3CYMYxLRvlZoTLORusT1hHPH9B+mGaUCeceHftV2l1FWPSM
 kGxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788176179; x=1788780979;
 h=content-transfer-encoding:content-type:to:subject:message-id:date
 :from:in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=PG9p354toZVh26ejfuxNVjpXc9iuS5rH+HKF405DW2Y=;
 b=EOXPuJNz7H4Cn/7RrMQ+ZC3pXkoHizTEgRNMIVEdjBrpSan+GX7fs1+hfEtCKHoUCY
 ubEbV5F4+qSV6Id0P19orcVhvUgaxyuylPPYD2ArAD+v1qLPPGUbjhtqhXSJ4B8lqIc7
 BR2GApfjtE4L14MPtTP0eKQyxjJsrvDOyAP5hbFXNIz/uFG6CpY5uTlXTf9zF+VSiYRi
 8bRKJcbuNWwBncLzFBAvzRnAO3mm96s9ML8w73grAwVS3kFke1zOLKBMnU/RMrSakRaS
 VG1/TRrnJB/WGl1dv8UW2iBljJ8mDKjM81UQZO8ttP7wPImgBsmiOGq3askB6FExNm6T
 JilQ==
X-Gm-Message-State: AFuF++mPQWRzEWb4fOijnOy+5DU0am9C2QK7jcukm0EEbo85XOsHbhfK
 POw4MF/K8M2+0/xZuTXWkhKDF6uJ4K2tghbfzsQkJ4cy1SQHQAN1/LDXQTMX9NE5Itio9tp4Ub7
 fjZBYPCyYCQlaXrX7007mwTrH+xlsepM0SQ==
X-Gm-Gg: AYBFou3NHBbUpAVbvOHJbog/OKjWvo3zaIb5gC80zzdwq1DI4HGUUzKbDpQqurL57dE
 18ZxT40UKTUZeW9YAPwPB+1hJDjFySLUaor/E33C1yCPkFTfJbpMPtGcYalz7dIFVtAKvErdfJs
 vTf5ZvV+SJ3Af6uFd3lwEb9r+xFAtOF3loj9QfuXXqZDdNunHAPUD2phJJlvL0VbsUPpLBir3Sl
 zQzoG+SrclouxI6JMT623G1dqGxqWMeX8FT+mpNhGwgnkFCs/F/HauCWIDqxuOWiI4NedjljSky
 xka+ttDsk7DejSX9z+ZKgSiVRBxa6ri4MZK+HQNjuN8lKOp7lDuWcb0RaIQAIJX0WM9d4bq/jnw
 S
X-Received: by 2002:a05:690c:6e08:b0:855:f387:98dc with SMTP id
 00721157ae682-864f42404dcmr29615487b3.11.1788176179315; Mon, 31 Aug 2026
 04:36:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260805-smartcard-fixes-v1-0-187ee9122441@redhat.com>
In-Reply-To: <20260805-smartcard-fixes-v1-0-187ee9122441@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 31 Aug 2026 15:36:06 +0400
X-Gm-Features: AcwNN1X8iD384MymCGtBcTKRQAX6h-DmKacMf1txSboDHR6tB8iV1xr2AGKU68E
Message-ID: <CAJ+F1CKfsCkk_dtEd2YXTdT1Bno_5Z5kKJxg-22y69+cXem-qA@mail.gmail.com>
Subject: Re: [PATCH 00/27] CCID smartcard reader fixes
To: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-yw1-x112b.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Hi all

On Wed, Aug 5, 2026 at 3:52=E2=80=AFPM Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> Hi,
>
> While tackling some CVEs issues, I also found several correctness and
> robustness improvements/fixes. The series:
>
> - has 3 CVE fixes (OOB/assert)
> - fixes xHCI compatibility
> - some endianness fixes
> - blocks & fixes migration
> - better spec compliancy
>

almost a month, and no feedback. Should I just send a PR?

