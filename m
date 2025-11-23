Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79A37CFC518
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Nov 2025 06:11:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vN3Fq-0005rt-P3; Sun, 23 Nov 2025 01:07:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vN3Fi-0005mp-Ml
 for qemu-devel@nongnu.org; Sun, 23 Nov 2025 01:07:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vN3FZ-0003Bm-1D
 for qemu-devel@nongnu.org; Sun, 23 Nov 2025 01:07:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763878009;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z1g/k8dt6+5zEFwDpRN9RrBRBY6uqZQa7CRGlGdgP8Q=;
 b=T0cT3Nhf1qw82s2al0oJI6m+cvCUH9JxUurJFLfTfglpNxrhenTOdTdSVumilP0XslmijE
 7a1FyA8Yy5LZZuP/hR33xdK9Xt3CkmrI1EQ87InYETKsj3HzV/pZl0y2LKwTuTZ3hJzKfA
 2DUACvpyUeSsXWZj8f7kwI+ZVxXDxn0=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-t3tCCihKPPeHtn9KBRQKkg-1; Sun, 23 Nov 2025 01:06:46 -0500
X-MC-Unique: t3tCCihKPPeHtn9KBRQKkg-1
X-Mimecast-MFC-AGG-ID: t3tCCihKPPeHtn9KBRQKkg_1763878006
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-295915934bfso54183145ad.0
 for <qemu-devel@nongnu.org>; Sat, 22 Nov 2025 22:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763878005; x=1764482805; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z1g/k8dt6+5zEFwDpRN9RrBRBY6uqZQa7CRGlGdgP8Q=;
 b=Euf8cZwejypNDIN0LGlqVImU4dndDuY00J4RsJEPTC25lGXpKuMzWeFGJIYvYyJgNA
 HAofeu5es8dkf++8/r0WAz4nw13HXFq+W0Rk34qB/yKd0r2MpFuuVt6+ylgzxwpGHXHa
 6ViFCaMxTFYjowZLPAZTeDvwUD9iJ9a3l9+DsE3fwhU29DDq3MF3BcfRqKrBPi+iXY23
 5fJ4Dj+YWYr7kraRkRJYY+b13SQ6mWwcpyutARbbWFsBv2q9syZy0GjujlvvgWlJqliB
 oahJJqJJTUGmar2DrKS3pAkg3Z2YP272ZM/T+eyM2EuY1BDpwoQ4B6iQrgwl8/HDtxYW
 OZWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763878005; x=1764482805;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=z1g/k8dt6+5zEFwDpRN9RrBRBY6uqZQa7CRGlGdgP8Q=;
 b=bm3ibCEgygB/2yn2X6OAQ+Yaga2A9bIEhV32p83pNSwFBfzaVxFawyT+BJfzySWDIk
 uCFoVkP5SHG39gizaTYxt6f0VDjiL1qwg8wU+GQz5+1gam1SwKuhRZctcXoCAuatST8q
 ptBccHW/o+lW6b21J/mrjXfjo8YCsw2LUFfvluhA3Wer26Q5b+SU996/NkhQmEfDqWuK
 6rOW+3naWHIfoWbKlcwe//00ImoQsyT+A1l13iIQsg9VjPF4KQI+scw5Z9sOtMSIiAhM
 pJ3HewxbIgsSTAZFNTy02Jp3Juuj2WKfHZBjZFm1uPF8DR7z1ClGUIibHaRDuL5WyXoG
 iguQ==
X-Gm-Message-State: AOJu0YziVCug1pVJnfGgYh7FXc0XXygRdcpyBJBcZpNMHYII/fSzfiYW
 GeV9woY3Ht9GtCeIYaQbTHwaTw3LJkRGIqXQ+amxLgMzkShEbsxl1Zu94gK3rU9u9FIo5PfCj23
 tZltilpJscZm5WdVxDQltZEZCrwDZLyG0kKkl3Sx3WHMIHiMQ479JdH74
X-Gm-Gg: ASbGncvo1PPAtCkjEwcWU6AzTkP9V66ho1C1vS5A0p8z5dpAZKc0rxQsW0Nm0g4YU5d
 hR0gv1plKtleBydXgk80sMIhIfkGYMXLE9dVujEV5kcHuyv1IdDGQF8G19z9d+9XA0gZDlUXBDM
 fIWxHsJPb64gFZ5nIP6UyOGY7K1I2Ij+lWyIDFZHBzMVbMrGMpSxOwjw7f0bbjwJdce6qe5N1SP
 n9BCHbLVQ0MmFhUo/j/gR36YPcnqcLpDaXZpaffHs6ZxQ3jaaJuOuiX4Riy5VuJQPEmnJATW/rZ
 q34UWKJFTlwqL881az0YiSwH0qxdOnJ5oaSbJoBjARcZu6ICH9V8MrFHvAx8lopllNSoJpG/ddL
 NxtTnnPGV7Tzku6zRx6oLesKl/G9GICTYJbEGmXdTppCfx+LdfQq1zbDAoQ==
X-Received: by 2002:a17:903:384d:b0:297:dade:456e with SMTP id
 d9443c01a7336-29b6c6a621emr80416225ad.44.1763878005620; 
 Sat, 22 Nov 2025 22:06:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGF/q2Jpo5kXkEaXg67v1lhEYtBsAH73xEYatHuFhyrIz1aWhdAxM4BdpP04iqoXnexJVkDAQ==
X-Received: by 2002:a17:903:384d:b0:297:dade:456e with SMTP id
 d9443c01a7336-29b6c6a621emr80416035ad.44.1763878005170; 
 Sat, 22 Nov 2025 22:06:45 -0800 (PST)
Received: from smtpclient.apple ([122.163.54.167])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-bd760dbc99asm9614811a12.30.2025.11.22.22.06.42
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 22 Nov 2025 22:06:44 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.7\))
Subject: Re: [PATCH 0/4] igvm: rework igvm file loading + processing, fix reset
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <20251118122133.1695767-1-kraxel@redhat.com>
Date: Sun, 23 Nov 2025 11:36:29 +0530
Cc: qemu-devel <qemu-devel@nongnu.org>, Eduardo Habkost <eduardo@habkost.net>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Luigi Leonardi <leonardi@redhat.com>, Oliver Steffen <osteffen@redhat.com>,
 Michael Tsirkin <mst@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <2B721FD4-1A76-4C90-B957-7D109957526D@redhat.com>
References: <20251118122133.1695767-1-kraxel@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
X-Mailer: Apple Mail (2.3776.700.51.11.7)
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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



> On 18 Nov 2025, at 5:51=E2=80=AFPM, Gerd Hoffmann <kraxel@redhat.com> =
wrote:
>=20
>=20
>=20
> Gerd Hoffmann (4):
>  igvm: make igvm-cfg object resetable
>  igvm: move file load to complete callback
>  igvm: add trace point for igvm file loading and processing
>  igvm: move igvm file processing to reset callbacks
>=20
> include/system/igvm-cfg.h |  5 ++++
> include/system/igvm.h     |  1 +
> backends/igvm-cfg.c       | 53 ++++++++++++++++++++++++++++++++++++++-
> backends/igvm.c           | 14 +++++++----
> hw/i386/pc_piix.c         | 10 --------
> hw/i386/pc_q35.c          | 10 --------
> backends/trace-events     |  7 ++++++
> 7 files changed, 74 insertions(+), 26 deletions(-)


For the context, this is related to the work I am doing in supporting =
resets for confidential guests.=20=


