Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0137CD2E009
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Dec 2025 06:20:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRPAU-0004hQ-Od; Fri, 05 Dec 2025 01:19:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vRPAT-0004h3-CR
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 01:19:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vRPAS-0008Rm-4C
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 01:19:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764915587;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fyrbJxebtpi7hClNkdZAeqk08Z+JUfzm1YUmhz3bYO4=;
 b=McdmJndeSvIt+2Go1peZDaSqX1/lN/OyIvYWQ8EE946sC6k4ok3Obp9W4S1eyGJisQBKvX
 zLN5Sn0OTwzxuCyknGUWvvqRgzVBvChckI4JGj94TU3Ii7HwLRCaRzQkmCyDj318iafD5/
 snn0/CSUl2AwmxPl+xEEXjHS9qagL1k=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-471-fxs6txT3PQC8VTDsCNAlDw-1; Fri, 05 Dec 2025 01:19:45 -0500
X-MC-Unique: fxs6txT3PQC8VTDsCNAlDw-1
X-Mimecast-MFC-AGG-ID: fxs6txT3PQC8VTDsCNAlDw_1764915584
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3438744f12fso4490022a91.2
 for <qemu-devel@nongnu.org>; Thu, 04 Dec 2025 22:19:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764915584; x=1765520384; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fyrbJxebtpi7hClNkdZAeqk08Z+JUfzm1YUmhz3bYO4=;
 b=lkngh0G88YhFOo7ZRGTyCcA8MA3DQmcDsZimyG1BLwR7DDNd15ZUti61ksfWSdcDXf
 rdwS6Af//jCprQM8rg6cFgER1dHECn9xpefcsvHm4TN5CnyMmXTExgd9qw2RdD7r5N/U
 ZvJveotRJdUeWbN1OEeFzpBJbg+7R5/2hNTKJmzhpJkMo44evfLLcP2r1bQ8bBNyqa3G
 c7xEf6PKzQ4FyjlIHo5wAFjUAl/yP+aL1/r5061p4iFGhNzeORWQrMR8KDdSEOqMjKFN
 D2w8hIjapmxB+3m6Hjz/7pUMTnT8nkk7Dh1FMY0dcUlyrUva3QAgMwCNbLxfxhhOP3WZ
 fMbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764915584; x=1765520384;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fyrbJxebtpi7hClNkdZAeqk08Z+JUfzm1YUmhz3bYO4=;
 b=hXsNnPfom4yFcUivWFVwSvReL/vqi3926VEaGDkUL0Q3Sru9WSE6p4+/ZkW3u+imZ0
 4HZTqziOtw+LRvZyoUaJH/sWuSAAA0dARiGlP0ccm/d0cG6UAf+pZsNtzh/fAaF9a+FD
 KNpX53DvwF5uFz7yV2t01Izh+3i3rfmUtJDpnULBN2qRSIOkpwrK2DwPdCdsVrFcePXB
 NGDBAB7+pGD+KeDupP1G+u88tP7u+MtGFG+4RoOpCWM/UjbmO8c4YpXX1wDFayke/P5d
 MH1e80xPxi9eJ37d0pRe08yMBDooe0OAJ2fxnxBAO9/LJrc0jtcH5wt7g7WlAWiP1Os0
 wVrA==
X-Gm-Message-State: AOJu0YwiMYVBTYKZuvG7eTDRxZB2LVIu1KIPM/WUZEPTLakhGMjFEdNu
 +4LTsq6Kfd5OpxyTL1tL/CvkVLxReIxG4fxGFfFRFaca/+DndzmO8SpSvqQcEyuC2rz97p/sKxK
 d25lafdIK1CaHVQxKOSm7/dHMS8AykvQTnL+ixVp3ZIQ0sKFloXMPtvNF4FQp+XQUx8bV3R3n9Q
 f9uRvhaP4TkSuZQkB6GdAHqhqvuA+joFk=
X-Gm-Gg: ASbGnctkUtnBMJydS0Nh2y95ZgPmBA1H7CPI5hLf5Js4+Uv9/XI1BaaFrFSCFph2RvU
 vUsL6tJthOuRz2wkPRb79RIYpVSaYMsfuRpke0e3Mb//IRNDHkbsD1oMkNW71XRtWWU0hno6Cyf
 xy3kinKloBLbiH/fhoONYSOcmgYLF/RzQRPnGVZPAkCd+3ftN296TT1P8vAE0Dk1rj3Q==
X-Received: by 2002:a17:90b:350e:b0:343:5f43:933e with SMTP id
 98e67ed59e1d1-34947efa122mr6227800a91.19.1764915584548; 
 Thu, 04 Dec 2025 22:19:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEigJx5uiS36Mp46TT2kfzShSXIGHEvjkFXjQjUZw+Q3Cz2dxG8wAuqfe14JqSMaUPsgznaAcHTJPP+6AW3IXs=
X-Received: by 2002:a17:90b:350e:b0:343:5f43:933e with SMTP id
 98e67ed59e1d1-34947efa122mr6227772a91.19.1764915584114; Thu, 04 Dec 2025
 22:19:44 -0800 (PST)
MIME-Version: 1.0
References: <20251030164023.710048-1-vsementsov@yandex-team.ru>
 <a8dcf37b-f7c1-486b-bc7d-5877c4d9ccfe@yandex-team.ru>
In-Reply-To: <a8dcf37b-f7c1-486b-bc7d-5877c4d9ccfe@yandex-team.ru>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 5 Dec 2025 14:19:32 +0800
X-Gm-Features: AWmQ_bk7TIAhe56Xl0zjAqwr9CKhSZolug9ZkCohYUPIarFczzyrsrpgi8fpxpQ
Message-ID: <CACGkMEtUn8aLApCu5RCF2tpNgMskOYycp4jjrNCvgNe3aWuTLA@mail.gmail.com>
Subject: Re: [PATCH v9 0/7] net/tap: simple refactoring
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org, leiyang@redhat.com, davydov-max@yandex-team.ru, 
 yc-core@yandex-team.ru
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Fri, Dec 5, 2025 at 4:05=E2=80=AFAM Vladimir Sementsov-Ogievskiy
<vsementsov@yandex-team.ru> wrote:
>
> ping
>
> (now as 11.0 material)
>

I've queued this.

Thanks


