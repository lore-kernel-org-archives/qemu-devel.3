Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08FF8C27C77
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 17:08:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHRST-00089N-2N; Wed, 12 Jun 2024 13:08:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sHRSR-000891-Pc
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 13:08:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sHRSQ-00062f-5v
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 13:08:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718212101;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IC0SRCK34YXIKmGmpvg6bgEGAM/WOdl5Y1ZYnG2THKk=;
 b=dcjS3O1m2xM4zemXW79UA0/TkWFdbZDkRQLvvRSc393La/M3LEnIrcrBirwWyBO+L454RO
 mQpdFlY+/CwtVBIfxGhsinqY7qP05irS4aYyS0bQILvEo3Tk2MCsIcIzCgdUOQYsVjP7P1
 DzIzPqi1g1yqNjmSU9nPca+TH+eKle0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-602-iltOc-gBNveAasrqFhBVrA-1; Wed, 12 Jun 2024 13:08:19 -0400
X-MC-Unique: iltOc-gBNveAasrqFhBVrA-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-35f27bfa618so38738f8f.2
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2024 10:08:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718212098; x=1718816898;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IC0SRCK34YXIKmGmpvg6bgEGAM/WOdl5Y1ZYnG2THKk=;
 b=VclHxjJ1t1d/SDoe0MGCa8mHob10KFZuccSnPqSm9FbOh19NjXM8ymtbz3pG7kF3ZU
 MdqmF0LKoqy8Hn01RWFs6jE8aDv6Py3EN/1uUgOHBnq944KcFdWtppXu0xAnH55zLZOW
 JGpVe5X3LI20KauymnUwXfMUwGNA/gcdqzzBOlNc4aDPxz94yFFOhkIQwQ6dpiTIkyvp
 OAZw0OZkidFtDSeV3Gnb7jjhMgSZmILhL+/Yqw6rAmnQzn/xbUKgPBvs6fbiPWkGUFLo
 tkJW9lFNI1e3ZMgZGFX0Biu6Rv6eQconxJ9+Ct6ogk4O3k/8Krn+f26uypoX4Nw5gxvm
 I6yA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUprwwPOpMA25Xc+D2qtPfj/mn+DBJ+K+UTdT/VrKKY1ZqG4pzOrtrA1bvyiOjGtZ0At+i1UJEgHin45eXsW7vgVN+Z6Ds=
X-Gm-Message-State: AOJu0Yz5fTQd8gTe/78+Ifl1CjwhCzjZF0QBV1ckB4YzRcxNX7rgHLCU
 HX/EQXFyFlf6cVuTmKTZ0+MiL/L3sXVCLbsexIgY9rK4QRGGRUmXeO81V3c2EAWUU8u7++Jjg6H
 acPr5Pqt7+0BMdJuoaMTRJz9/ZKaT2YIFnZ8wLEZT7me18nolxvZ9px+f7Y26UtSegD27PWyEIH
 I5VP9A5wemuGtgDuT8ll0owLvwlIE=
X-Received: by 2002:adf:a3ce:0:b0:357:4c8f:ef8 with SMTP id
 ffacd0b85a97d-35fe89395a6mr1662978f8f.70.1718212098018; 
 Wed, 12 Jun 2024 10:08:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEDVkH2e9ybxHU88ol7WhkPoXY1kJxqYc58tOyLEiwCoh/np9MmwYeo+XReTWA+30m2k7XzMEnb00n9aPLY8Aw=
X-Received: by 2002:adf:a3ce:0:b0:357:4c8f:ef8 with SMTP id
 ffacd0b85a97d-35fe89395a6mr1662969f8f.70.1718212097673; Wed, 12 Jun 2024
 10:08:17 -0700 (PDT)
MIME-Version: 1.0
References: <20240612105525.8795-1-amonakov@ispras.ru>
 <ZmmAq8fbJLuaX4Qg@redhat.com>
 <CABgObfbGa=xpp9-cLwzqCpPFsf27qM+K-svfXEvc6ffjb=_VAg@mail.gmail.com>
 <ZmmIpr5f0sQy-VGl@redhat.com>
 <CABgObfZHBGxS-D9LdM1v0oDXBHoKm2-A4FknixmqjfJeQR1YLw@mail.gmail.com>
 <ZmnUPZ0fDZBok6YQ@redhat.com>
In-Reply-To: <ZmnUPZ0fDZBok6YQ@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 12 Jun 2024 19:08:04 +0200
Message-ID: <CABgObfYHj262scR8TgjOXKcXsCXZzXs7naZkXR7-j2tnPpWWWQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] Reinstate ability to use Qemu on pre-SSE4.1 x86 hosts
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Alexander Monakov <amonakov@ispras.ru>, qemu-devel@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, Jun 12, 2024 at 7:00=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
> > I guess that, because these helpers are called by TCG, you wouldn't
> > pay the price of the indirect call. However, adding all this
> > infrastructure for 13-15 year old CPUs is not very enthralling.
>
> Rather than re-introducing a runtime check again for everyone, could
> we make it a configure time argument whether to assume x86_64-v2 ?

Fair enough, I'll work on it.

Paolo


