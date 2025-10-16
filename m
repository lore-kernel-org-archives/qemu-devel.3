Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54361CCD185
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 05:03:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9G8T-00047X-Sy; Thu, 16 Oct 2025 01:02:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1v9G8S-00046r-9f
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 01:02:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1v9G8P-000089-Jp
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 01:02:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760590959;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y+M1d7C1E2JshZ7CHhROOA4cr7tTxPknQy2xzCLDpFU=;
 b=Vp414tm/pSTX1EJOYu7203TMe5FUMmj0tnIHypqWgyJLkfw0PX6EToX6H8uoOH84HRT5g/
 hIWXbrSmuUvhm4fO9GIwO2MZrttfNkiwjD5Y7tfrBCg5vylXHB0AIdxJ9+RWjdmAgFAJtA
 BNBqIT1EpRAdIyPrJ1fnPTCFe7GUL0w=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-55-xzTNuhDvPwm_K4AmtXcQ5w-1; Thu, 16 Oct 2025 01:02:37 -0400
X-MC-Unique: xzTNuhDvPwm_K4AmtXcQ5w-1
X-Mimecast-MFC-AGG-ID: xzTNuhDvPwm_K4AmtXcQ5w_1760590956
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-33428befc49so530137a91.0
 for <qemu-devel@nongnu.org>; Wed, 15 Oct 2025 22:02:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760590956; x=1761195756;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y+M1d7C1E2JshZ7CHhROOA4cr7tTxPknQy2xzCLDpFU=;
 b=s5SzVWcH/DzWk1vjNj8YV0Y5eHRJhhN38J8E0LiVWAuMW9b26HNeU7KMq4JhAeVelK
 5ZtSabqIVtVdzFtgQF8w86w+mcIihaMzzAUWokdubXMfuVrKiFcIAodUz5xGxIsPp+4l
 /JEtBzKfi6wv8Gm/Ik/WPYqkZqMii43CAy6IY7kLjYG7eLeTNmtkh4y2onVQDPZqb6M4
 syJ6oT4frro95vPbDMJl/g3twgWHAuuKX5yi5OnpcPuVoiAbflJaD3Ap524ZEG3q/cj5
 bgj+TC5ZUR42NsK3qQS3vr+OLQ87L/yHTFB/THXFaKuiWCyKKqf9474VRH/Nxz7ZAiLT
 CV5Q==
X-Gm-Message-State: AOJu0Yz+cdndt8rlTHT8MbD6axRz/+9jtTusogItahWzCcZ4/7ZLkXoc
 nQO4pbZZ4Jh3oFLb6fznqQIbdjq7WMORXU0AFAA4cuHm02dILlmkfqu3NpVepyyQQnSshNvJ4YL
 JZMT61SiVR8DGPM/1bvOHiF0/xyuDnAoXD4YVXLgQFYMsikIoYp+crz2x
X-Gm-Gg: ASbGnctT2yOwEEhL8AQMaPfKv1hXqZlAv56yBqY7ctYoUxgA9cEezMRlg7sYYj1ShOT
 7vZoyCRVOOlY9rJYY2T6+qDoKU/e6X09q/cTUn35AmxyrvogfcbL+r0jWpuudBwBmOOEuiqcMpO
 nmidZPZ34L24FfBH8P8SBf/QtweZoa5xRfQxvIBgTQK/T/Sd4gtT6gajSnBgz8UZ9kyE12pE06n
 G4F/0vEc1FfcBix39nUdOtjHHuHTq1Q+TTTLPvoW15zPM3p8EhbxccDKrLQeOz5skhW9sV6t4U4
 QjlQyApoGt1bJ2nToyBlrCWbheFu4z4ms9kYVQfcMVyKeUxXw0vBz3TAbUoIaFCOO724xHpqofa
 7Ef6pQYYnDhsCUv0=
X-Received: by 2002:a17:90b:3d4:b0:33b:a351:4bc3 with SMTP id
 98e67ed59e1d1-33ba3514bd1mr1875824a91.12.1760590956153; 
 Wed, 15 Oct 2025 22:02:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVNomwaGBlNqcA7iAzW+U81/Qu45AlL2ah6wyZOT3hQ3i00iM/0vx0BD3fsSk+S1jCz/E7mg==
X-Received: by 2002:a17:90b:3d4:b0:33b:a351:4bc3 with SMTP id
 98e67ed59e1d1-33ba3514bd1mr1875797a91.12.1760590955805; 
 Wed, 15 Oct 2025 22:02:35 -0700 (PDT)
Received: from smtpclient.apple ([122.162.208.81])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-33bb651936esm227504a91.5.2025.10.15.22.02.33
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 15 Oct 2025 22:02:35 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.4\))
Subject: Re: [PATCH v3 5/5] igvm: add MAINTAINERS entry
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <20251015112342.1672955-6-kraxel@redhat.com>
Date: Thu, 16 Oct 2025 10:32:21 +0530
Cc: qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Roy Hopkins <roy.hopkins@randomman.co.uk>,
 Stefano Garzarella <sgarzare@redhat.com>, Zhao Liu <zhao1.liu@intel.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <D41722C0-0F23-4804-88DC-1FAEB4272345@redhat.com>
References: <20251015112342.1672955-1-kraxel@redhat.com>
 <20251015112342.1672955-6-kraxel@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
X-Mailer: Apple Mail (2.3776.700.51.11.4)
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



> On 15 Oct 2025, at 4:53=E2=80=AFPM, Gerd Hoffmann <kraxel@redhat.com> =
wrote:
>=20
> Add Roy (being the original author) as maintainer.  Add myself as
> reviewer.  Status to be decided.
>=20
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
> MAINTAINERS | 9 +++++++++
> 1 file changed, 9 insertions(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 84cfd85e1fa1..3ebcbcdfdb04 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3893,6 +3893,15 @@ F: roms/edk2-*
> F: tests/data/uefi-boot-images/
> F: tests/uefi-test-tools/
>=20
> +IGVM Firmware
> +M: Roy Hopkins <roy.hopkins@randomman.co.uk>
> +R: Gerd Hoffmann <kraxel@redhat.com>

I would also like to add myself as a reviewer as well.

R: Ani Sinha <anisinha@redhat.com>

> +S: TBD
> +F: backends/igvm*.c
> +F: include/system/igvm*.h
> +F: stubs/igvm.c
> +F: target/i386/igvm.c
> +
> VT-d Emulation
> M: Michael S. Tsirkin <mst@redhat.com>
> R: Jason Wang <jasowang@redhat.com>
> --=20
> 2.51.0
>=20


