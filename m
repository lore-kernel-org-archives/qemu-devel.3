Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AA3ACA0EEB
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 19:50:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoSL7-00060v-DH; Tue, 19 Aug 2025 15:49:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uoSL5-0005zg-OP
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 15:49:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uoSL3-0001SK-UH
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 15:49:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755632985;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EFX1VRZdPxXZmQd9+d/Xze49bENWr75d2M/OHLl1Jko=;
 b=WHexaT+yA5Bg3ww8ujbNHzmKNgus37Kedj2heS41LSrWEscDPW8vMreNc2d4hbMOtGem0k
 9krNxf7nM3032xW4Rzq4M9z1N0CYoH6yFfK6eDwOMl443TKcovOk11lRmGjoNPHybtXXO+
 YwT8A2yu92pHs5eewXTFw7tQqfyxdlQ=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-sa0ubsqkOIiEpfjVzJIlUQ-1; Tue, 19 Aug 2025 15:49:43 -0400
X-MC-Unique: sa0ubsqkOIiEpfjVzJIlUQ-1
X-Mimecast-MFC-AGG-ID: sa0ubsqkOIiEpfjVzJIlUQ_1755632983
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-24457fe8844so67284815ad.0
 for <qemu-devel@nongnu.org>; Tue, 19 Aug 2025 12:49:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755632982; x=1756237782;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EFX1VRZdPxXZmQd9+d/Xze49bENWr75d2M/OHLl1Jko=;
 b=G5PASXKTBvIMpKc3r3qqQRujdtWPFRo7OrmnuQp+0zi/gnvDuXYRQ4GaIhprEk+SxD
 B9/W5LArrqdNbFJezcB4HdvKvTZzWCsnn9FOQZmS3fLpQa07lYcJSjA3PmvhtkcyOATB
 RagnBnJfSzyQsnoMJg4MAXCj/znq0JCxW0hLw8OSRa6qCaX84I0H8/XHyulcGziuH9xT
 Ql8SmvSYK8m2B2bbiv7Xe9/maQLcfz9GljYKm+80Ln6eV6FAvBeogCKHn3kQWb/kurGB
 OYwiONCDzgT6wp6aDFFDLkit1Jma48SA8PZChSKQfyRqoE8M9yoTUFq02AqvImGVECF+
 7JUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLVWh/pirIBKa+zLwR2nE4G1Tx6vHSUqB0TgWd4JMgB3pcc875ydPV6tBAyZfDOymd1pkI2luktoZl@nongnu.org
X-Gm-Message-State: AOJu0YwOKHTd1GPsJg6bmmFjYLssYD16hIfS9jbEUnG+3eEF1EiUnXem
 qu82gJNFlZ7O/VPGVRld63hAQ+Vhwke3ObUwmUSZJiVh9CBvA+mbpTOPenTjeNpVE/zno+VQhne
 2hEVU12poH5sBf945DtMOaenMwGilyIXpfFJLfAG1vJ8UfqKFZVzAZuT0t4Ysw5yjDsu7gwXJRh
 wwrPhp8kN/08d8xGlzQLKlDpYYvzQfkVk=
X-Gm-Gg: ASbGncsELHhnHoEFVHO2nZCXka1xaNkEWhL+YdFoLSRu74H6slj/BMkHM1rLOKF7Gey
 fcLjUgJsn5Z84R20LFkKbAnpuoRCd0n+P8sAgZPxdzqvRuZyd9IvSXKioc+06sbpp2LUZtTDI/v
 kL45DDG8xCawvqomMGReGw7NpAh3Qt/1dmSUgm8jeEIj0RaXukB19i
X-Received: by 2002:a17:902:da82:b0:240:2efe:c384 with SMTP id
 d9443c01a7336-245ef11b069mr2550185ad.19.1755632982389; 
 Tue, 19 Aug 2025 12:49:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHpQwD7cyaAppY6las1xVvvYcw7FKdjZMO/heLFthgjINO/WdEeq6DVTk6UcA7a5By/LTKo8nmhpte+K+fKMR4=
X-Received: by 2002:a17:902:da82:b0:240:2efe:c384 with SMTP id
 d9443c01a7336-245ef11b069mr2549845ad.19.1755632981811; Tue, 19 Aug 2025
 12:49:41 -0700 (PDT)
MIME-Version: 1.0
References: <20250715143023.1851000-1-berrange@redhat.com>
 <20250715143023.1851000-3-berrange@redhat.com>
 <2hga6d4rth5t3ed5dn7d23dppk3tzanixzhhcmmll6e5zcicri@whlsonighvvu>
In-Reply-To: <2hga6d4rth5t3ed5dn7d23dppk3tzanixzhhcmmll6e5zcicri@whlsonighvvu>
From: John Snow <jsnow@redhat.com>
Date: Tue, 19 Aug 2025 15:49:30 -0400
X-Gm-Features: Ac12FXxbMG30kaXZyi5A5e-xKMFMlfar9b_IBesUauyhgO__QE1hNDCohBtud_8
Message-ID: <CAFn=p-a89AUC1ceG6fC0D4fNCN0r-kPrbMXpbduAFYG1usGtsA@mail.gmail.com>
Subject: Re: [PATCH 02/14] python: avoid deprecation warning with
 get_event_loop
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, 
 Hanna Reitz <hreitz@redhat.com>, Jagannathan Raman <jag.raman@oracle.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Elena Ufimtseva <elena.ufimtseva@oracle.com>, Thomas Huth <thuth@redhat.com>, 
 Cleber Rosa <crosa@redhat.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Jul 23, 2025 at 5:25=E2=80=AFPM Eric Blake <eblake@redhat.com> wrot=
e:
>
> On Tue, Jul 15, 2025 at 03:30:11PM +0100, Daniel P. Berrang=C3=A9 wrote:
> > We need to call get_event_loop but have no way of knowing ahead
> > of time whether the current thread has an event loop of not. We
>
> s/of not /or not /
>
> > can handle a missing event loop, but we need to hide the warning
> > python will emit to avoid tripping up iotests expected output.
> >
> > Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Reviewed-by: John Snow <jsnow@redhat.com>

Do you mind if I collect this patch and apply it against the standalone tre=
e?

--js

> > ---
> >  python/qemu/qmp/legacy.py | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >
>
> Reviewed-by: Eric Blake <eblake@redhat.com>
>
> --
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.
> Virtualization:  qemu.org | libguestfs.org
>


