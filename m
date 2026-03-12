Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F66D106ACC1
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 16:06:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0iY1-00053d-Vz; Thu, 12 Mar 2026 12:06:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mvaralar@redhat.com>)
 id 1w0iXw-00051N-Vg
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 12:06:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mvaralar@redhat.com>)
 id 1w0iXt-0006Ja-1q
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 12:06:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773331554;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t92hgX7rQBMb97pIHYHdjNFQmVytKSos6WWM62IRmss=;
 b=PDwGbKd/tr/Ag/MpIEk4DuHOmOKDrprCrJE6TftE/D01wkYcUD3S/rVmbPhZnbYKaU5rdn
 kDlvs6imW8jVx5u3OF0EGT8WhhoZYw+/W+CmetQ7jfvPitIHm7cE638N0eZM5i2PWJQ355
 ylMbSLm2bhfQd3se/PvL0I156mnyYgc=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-426-P2tzgoXJMaSLn_hvJfqlyA-1; Thu, 12 Mar 2026 12:04:48 -0400
X-MC-Unique: P2tzgoXJMaSLn_hvJfqlyA-1
X-Mimecast-MFC-AGG-ID: P2tzgoXJMaSLn_hvJfqlyA_1773331487
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-b934e96af9dso108917566b.3
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 09:04:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773331487; cv=none;
 d=google.com; s=arc-20240605;
 b=Rsw7hiTvue6MWDsP8gbmpElhmFMhm5aPQZ2aErEOJorg67YDePNs/XxpoX5VaOu/VU
 K13wNQYwaMtoYNzNYsC0nJ0E2UMoLrbXtNutgcKIfxsMaolKYwIyUzrhu5oUR2D9bOmN
 fgF39Aed6pv0XCmYulnE1TlDNpBXuvyeyoFEhzCqTjC2YSIsK//Vc0fqlUVHl3H+Encn
 +9MpxcP9boAu5Ce7gAhHpVZOlkVQ4FI7MiFiNnfXFMuu5omJcioPLJaeTC8nRv3IpXB3
 p+ho1MeSWedpGe2T6jOqW/3imgusdBjxwSp7Z+npNHuc6fgziUmOzYgkkPDXtfX4zSlZ
 emxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=t92hgX7rQBMb97pIHYHdjNFQmVytKSos6WWM62IRmss=;
 fh=6fICvFPfZMin+45bH5Av4QXeL9LcvG8yJkzpPDhFCJY=;
 b=G2QDS5CyCobk86NCumBLBM7C6UfCujTfe86fpFKK3CST0k74rgdilOGNd6deTmwThb
 juXOVzw6/X3/aZ8IQ2hQYhQXRY6VOVhoM1moNB0ZyE9HI4HWj9jta1IlllES2Pb1Q72Z
 /KFe+wmGXsLSh7QNnvP/E4oSrf5iokA6OTtluUnh8Rq2bATDJQN1iYoVSlCRx0MqYeTp
 zzFc84z1VzOlATEqUY825BIq8+Egpf09Gt7EBK8ZoF4aSFqk/XPUIgveM3qPv+HJcBqh
 qPMyc46oUbicfZa9EHm5nR+aa4ELj4RDQufzRKyQwdObMAvJaD298IOrpHuz/+uRKMEG
 MOGw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773331487; x=1773936287; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t92hgX7rQBMb97pIHYHdjNFQmVytKSos6WWM62IRmss=;
 b=K8jGmwj3xc0/wkYWo6qvn5QoRn1iWT5bHptSCg57hS41RJa/fki1N8oitllZd3M58w
 m/pleraESDUcjyRTZGvd5NI0gA/8fd4hQCStzNJggBU/13QNoKs6Po1FvsetNrMImO0w
 wxMFvXy7u65IgPOJ8Ibnw77974x3TqvXRWV8DX+yQs5gvUBH57fzlT7F0FxJ7Hqxiwx2
 xKV1mng83SgQ71zQfmazzcU4e7VUs9gZOKNbONDCkB/q407KmAI57jQ0k60iQ/nwDEP5
 spC9NtzEXx7m1o2fFxjZXAlMB3RYcfTrGHRmTJJABprYtWpwb1q+VqMa97sV0ii905eM
 dm3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773331487; x=1773936287;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=t92hgX7rQBMb97pIHYHdjNFQmVytKSos6WWM62IRmss=;
 b=rkcJ0UfnOC89xuE3kkxXdaVmZ/XbF60ky8yu9zJ6RattwkiF519ig9eOXsVY4LB52j
 vbMk2+t3QP/Cob/5xyIez3gQVLiMh6TLohDIwhfoJpMAyW1KaDF1aGigqCEmJ6KZT6QH
 XJlsRHlswtkN4d7TKw4N4EPjUuoMCyWYt6ZlTDqXc+pPgxwm6F8zmqCsBHQjD4utc2Mb
 HJBZjlawVQ5+L806tlXUl4X4ijdYV0rx5DFPSeVpmFQhqZHpa30WcRLIywA8JGnMl3AI
 0qEBL/D79Urk+b4McE4S8GZh4xqEbC548UpE3E//q+QcKUHigXyFzM/eRq1faaLWqf8D
 6/FA==
X-Gm-Message-State: AOJu0Yy8oYaIf6hSRlhAPPMAccZVKyA8go2uwsZBKYTrSiG1PGjMZsCA
 sJUjsAx41sM514cfJ+3suLkNeGNldsgq86USwG6tgqOVKdtTLhvvx9GJj07SBxSyN69hIpzl0gF
 ibmp/HTXEdnCLZ8E/nlKjtKro7HTIUDriczTp/xkLcI52NKqNXyk2sZvNSqsy9xJ9q20PRdm1SR
 XxAY5oyy2/U0x4WMCMMb/Gygt/hBunV0g=
X-Gm-Gg: ATEYQzwi4HltKjLHR7Spay2lh4Jp8b/xdly/HlcJrkDoJHhiczZd2WwQxRR8I2kGOXu
 zWADlI9H7ctF8x25Dt5tL6U0ALhQrI7a4v33CEKwv2TOZ9UWZJLDq2YDJBohf0h54iVqkRw1rzG
 64wwL5AHa/zZrK5OOThkhTY+HfKynxUtBQBVh2tN6SmgPIOJlGiAUUsRLX3uzG/L/Z7JHPjUutP
 p4rwfHQosNzsWkxxRb7YI/LRcK6fmPv9YftZQ==
X-Received: by 2002:a17:907:70c:b0:b8e:2a8a:4312 with SMTP id
 a640c23a62f3a-b972e58e860mr386186766b.28.1773331487116; 
 Thu, 12 Mar 2026 09:04:47 -0700 (PDT)
X-Received: by 2002:a17:907:70c:b0:b8e:2a8a:4312 with SMTP id
 a640c23a62f3a-b972e58e860mr386183066b.28.1773331486483; Thu, 12 Mar 2026
 09:04:46 -0700 (PDT)
MIME-Version: 1.0
References: <TYCP286MB22415F5CDD24530319DC4D4EC844A@TYCP286MB2241.JPNP286.PROD.OUTLOOK.COM>
In-Reply-To: <TYCP286MB22415F5CDD24530319DC4D4EC844A@TYCP286MB2241.JPNP286.PROD.OUTLOOK.COM>
From: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
Date: Thu, 12 Mar 2026 17:04:33 +0100
X-Gm-Features: AaiRm51J6NZrFTp9cp2wSPh6HqTG5LcKnKdSzZlr0-AjTTEkaxDphwvPVUyswuY
Message-ID: <CAHYGQ0zdcjs8nXnyCLva7GqeRAByWRJ-myT+fEEDCmjxpx35kA@mail.gmail.com>
Subject: Re: vhost-user implementation of virtio-rtc
To: =?UTF-8?B?TWl0c3V5YSBJa3V5YSAo5LiJ44OE5bGLIOmDgeWTiSk=?=
 <mitsuya.ikuya@jp.panasonic.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
 "rust-vmm@lists.opendev.org" <rust-vmm@lists.opendev.org>,
 Francesco Valla <francesco@valla.it>, 
 Stefano Garzarella <sgarzare@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
 =?UTF-8?B?S1VaVSBLQVpVS0kgKOiRm+eUnyDkuIDmqLkp?=
 <kuzu.kazuki@jp.panasonic.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mvaralar@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Thu, Mar 12, 2026 at 3:03=E2=80=AFPM Mitsuya Ikuya (=E4=B8=89=E3=83=84=
=E5=B1=8B =E9=83=81=E5=93=89)
<mitsuya.ikuya@jp.panasonic.com> wrote:
>
> Hi QEMU/rust-vmm projects members,
>
>
>
> This is Mitsuya from PAS(Panasonic Automotive Systems).
>
>
>
> Form Google SoC page (Home | Google Summer of Code),
>
> we find the below page related with VirtIO-RTC.
>
> Internships/ProjectIdeas/VhostUserRTC - QEMU
>
>
> For that, PAS has already implemented VirtIO-RTC components
>
> and plans to contribute them in Beginning of April soon.
>
>

Hello, we learned that two days ago. We just closed the project.

Matias


> Thanks.
>
>
> Regards,
> Mitsuya


