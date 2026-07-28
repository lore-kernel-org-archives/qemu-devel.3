Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1411C54F4C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 08:33:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wodFp-0007Fe-ON; Tue, 28 Jul 2026 04:33:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wodFd-0007DA-Qw
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 04:33:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wodFS-000171-Up
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 04:33:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785227592;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NGotaTdj+KrTnZZOt7ewDiOQxo0Uc4LTH1dViwMTBJA=;
 b=TQRfK3dQcor0Aw8YFREPvp1rlPrPjRpjbtj//oecT5RmSs8bMRH/9ZlreX0prJIb72OdN1
 E+SeUgBNuPZ1W8SCctfbfXeQqDzhG61nD4kFr1uFC6EeQBiUXpNd7c3K+9GeNGOZGXiQ0M
 uxta3wugRuueUtEB262Nj3VkwFqpHnw=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-303-pBG410YcOgGl8wHLubzaAg-1; Tue, 28 Jul 2026 04:33:11 -0400
X-MC-Unique: pBG410YcOgGl8wHLubzaAg-1
X-Mimecast-MFC-AGG-ID: pBG410YcOgGl8wHLubzaAg_1785227590
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-8487ed7f7beso3881690b3a.0
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 01:33:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785227590; cv=none;
 d=google.com; s=arc-20260327;
 b=OWhG+B0iZ5m6WnY0rKIwVovIQ22WWvuKIlc8rV2cpg82/5jl3HakmrkD48MqO0BKmv
 lg3uRAu4yatPAyMM3aUTP3gBz9w7iSxeV++GMXqQ550XHDvPaYdlMRYpX1NySkWUOmIb
 9O2mbW43tK2GRCK0c0lVVnBUHZXQ2bh+vyZDmmjqPxyTYiRZHQlXXniYh8sXjYK6QXIU
 AZp04sbyoh5hdwcpVED65E4tSsM4bkI3rH9RFchNqbzULyBFB8n7aRKzxZA2wez6Bkf2
 tCxm0H1ka8RD6eXJEFCNeqaThYOu+pDkutJzZj1ERYCMtbL6k67vlncRKcO9Oj8YcpJm
 vIDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=NGotaTdj+KrTnZZOt7ewDiOQxo0Uc4LTH1dViwMTBJA=;
 fh=/dMNiWP/UJp0ib95kJpEXmCAYazcCM53J8+UCiPYHqE=;
 b=eSbMw/+H4YiYRRqLtsUUuiXxbW/z9o3hn1OyCjtS96JscKgP2ILk3lNZmQCxxmUtS0
 8yvzQUrg56IYJpiUm2kDOIySwfaz92PQr1S1aX7hxB1ROl4fKA8GzPvtrGIdjTeB2mOM
 0/YvIkiMI/sBKQgGJvBFonnVMgHJDS8MPakY5gK8M5lsezWH4fGxE1Y6wrq/xEtU57Tk
 6Cyc97Cxw3S4a9qPgbnhzAHRnY0M2blLlASgKuuPKRX5l5T70bRqq6K5mBP1Abf3YpUt
 oTaFi2NA3FfQwfKxB1vQixhNx49Cszy3yf+EhP0k/HAy890d5lkBG3GKc/u2sQNuVOwW
 AHBQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785227590; x=1785832390; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=NGotaTdj+KrTnZZOt7ewDiOQxo0Uc4LTH1dViwMTBJA=;
 b=EtzcarvU6tlo7z+BJg2pp5lx7lJlvQ8IGkBpJcZ1DZLqIr3jlcvjD6OyhpoUyrzuI3
 iEWiey6sMx09bCbpzcb7R/wy83A9G2D/eMlnejORdJYACUdFbhY50e/lVkFfa0p7dUrc
 280qg6kaV+lDMF55szjbF1F5CGmHkzSnMlv8bg5x472P2AG4py0Fr96v+KrZ0/ay88lc
 zOhvl3sRJ3Vre0H/OVp8Glg/Z5iMeTfP3szQ+uButONHE3eOm7G0nVV7DR2oWv+f6zHG
 LnuGr9FfhSfRFubREBJiprBz3eWxaiMAVby0TyMtnNuwMs1cDjwooAScxidGypw/IDNf
 a4JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785227590; x=1785832390;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NGotaTdj+KrTnZZOt7ewDiOQxo0Uc4LTH1dViwMTBJA=;
 b=FmQXTFrnVuIiDk5yYkacv+PNnEgsdPAaCUriGsYoEPkxrCSJls4r7FN33/cQ7ObX+F
 eDzO2+Et9XHTm9MBwL3nifjAz7pqpCEaM/gZaV0BrUR0CINUR6C7FhwPjY8T086VrfBd
 KAvpd4cndaEJFmVnKeqv8Pb5eHUYNiQmJpoMzW+FlT2oLsDOPKW1iEdxyxuZFAI1vTt1
 Y4S3Sa6aBytJAEJRWQKdizzHwNCypk2C/n+WyBfFZ5faFMNPqHFKnlExO/YJkz+hKc7Q
 FCmfQZoJ/lVvXKx7KRzkUeEAgI9KRlrCMCA1A7igDpMXacEdl1gBHALohudeGi5RYTLc
 BvRQ==
X-Gm-Message-State: AOJu0YwHy9u/DYAOFTRQ/loFP+JjczZc/1Rt9WCQWaJdI5Dc+YPyIrvV
 4PK1U2b5i6+1ukdYBEQ0LQDJeiE055yeVBcypOyEmJPjwt/cxFiyMywCu2VrczAlea3NQavA/Yq
 0DJnJIqbZ8cy58xB+Ii9H36kGwgTm+2Dw3WChMCusdTqoc53Ek2p4XUV9C5WscecArulsj7Jy1g
 bo/c9tyMFL+OKrnQ8s8CdxIXxqXH637+U=
X-Gm-Gg: AR+sD13347/QDtUPlgvBaQ7dHW3is5YBwZKq2Jbmue/XDg+DzGmGlWzHreeie5v+hox
 lTw46ffBDRG4DIpFYlKXG4PqgRdMvDI5ZP4acnJp0ias+X0i39+nEDFZ8bvoZsCVf+OsCZoM5DK
 qelgtG2If/8oJq7hioLF0opUryKzkHeLpdeVVcXX7quqgbdBLBisLdcdt3n+DDg2aPlB5yke16h
 H2rKFAp5uMEtT7+KNMJP0ircE7Hq9ywbQodc4mJE6BlWLvQ13mOS1rESIPGYJOWuEWo2RdtHjN+
 pw==
X-Received: by 2002:a05:6a00:b4e:b0:84c:1cd2:142b with SMTP id
 d2e1a72fcca58-84e932ca245mr1413439b3a.9.1785227589904; 
 Tue, 28 Jul 2026 01:33:09 -0700 (PDT)
X-Received: by 2002:a05:6a00:b4e:b0:84c:1cd2:142b with SMTP id
 d2e1a72fcca58-84e932ca245mr1413409b3a.9.1785227589359; Tue, 28 Jul 2026
 01:33:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260616-qom-qapi-v2-0-cc9396b9c18c@redhat.com>
 <20260616-qom-qapi-v2-50-cc9396b9c18c@redhat.com>
 <87wlufword.fsf@pond.sub.org> <87jyqfwmgu.fsf@pond.sub.org>
In-Reply-To: <87jyqfwmgu.fsf@pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 28 Jul 2026 12:32:58 +0400
X-Gm-Features: AUfX_myVhbqtF54hNcVyZPxIyQKs7P-bf6UT7u1LrkLIEMiGTAevpAt1B2TlTqU
Message-ID: <CAMxuvawA6Yzcr2nC5pMzHAYX7ZGv4V6VP3bJ64Gq_Pwo43wf0w@mail.gmail.com>
Subject: Re: [PATCH v2 50/53] qdev: simplify DEFINE_PROP_ARRAY and remove
 generic array PropertyInfo
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Michael Roth <michael.roth@amd.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
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

Hi Markus

On Tue, Jul 28, 2026 at 12:24=E2=80=AFPM Markus Armbruster <armbru@redhat.c=
om> wrote:
>
> Markus Armbruster <armbru@redhat.com> writes:
>
> > Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
> >
> >> Change DEFINE_PROP_ARRAY, the macro now uses _arrayprop##_list to
> >> resolve the typed list PropertyInfo (introduced in the previous patch)
> >> instead of the generic qdev_prop_array.
> >>
> >> This means the element type and size information is carried by the
> >> PropertyInfo itself rather than duplicated at each callsite. Since
> >> the typed list PropertyInfos encode element_info and element_size,
> >> the .arrayinfo and .arrayfieldsize fields are no longer set by the
> >> macro (they will be removed from the Property struct in the next patch=
).
> >>
> >> Remove qdev_prop_array, which is now unused.
> >>
> >> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > [...]
> >
> >> diff --git a/hw/intc/arm_gicv5_common.c b/hw/intc/arm_gicv5_common.c
> >> index b155486af65..61c8ae49302 100644
> >> --- a/hw/intc/arm_gicv5_common.c
> >> +++ b/hw/intc/arm_gicv5_common.c
> >> @@ -191,9 +191,9 @@ static void gicv5_common_realize(DeviceState *dev,=
 Error **errp)
> >>
> >>  static const Property arm_gicv5_common_properties[] =3D {
> >>      DEFINE_PROP_LINK_ARRAY("cpus", GICv5Common, num_cpus,
> >> -                           cpus, TYPE_ARM_CPU, ARMCPU *),
> >> +                           cpus, TYPE_ARM_CPU),
> >>      DEFINE_PROP_ARRAY("cpu-iaffids", GICv5Common, num_cpu_iaffids,
> >> -                      cpu_iaffids, qdev_prop_uint32, uint32_t),
> >> +                      cpu_iaffids, qdev_prop_uint32),
> >>      DEFINE_PROP_UINT32("irsid", GICv5Common, irsid, 0),
> >>      DEFINE_PROP_UINT32("spi-range", GICv5Common, spi_range, 0),
> >>      DEFINE_PROP_UINT32("spi-base", GICv5Common, spi_base, 0),
> >
> > Doesn't compile for me.  I applied the series at merge commit
> > 8333dba732.  If it compiles for you, could you push it to where I can
> > pull?
>
> I just found base-commit: 2f28d34ea0aead9830478cd1d3d0dd9d9191d82e in
> your cover letter, and I'm going to try it.
>

I did a rebase
https://gitlab.com/marcandre.lureau/qemu.git qom-qapi

Waiting for your feedback before sending a v3

thanks!


