Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D59DEE7719F
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2025 13:00:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXK2e-0007Fv-PM; Mon, 13 Jan 2025 07:59:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tXK2d-0007Fk-3h
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 07:59:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tXK2a-0006jP-7n
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 07:59:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736773175;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T8lWUeti1iR/7LXpJdRlgTQsBRt1ESJ+StJPeZp5l7c=;
 b=QuhvGyqzyLVB1AlXUeCv9vGTsRLIYsQUQLts7yMjo3WlODUq16ijnPcPR8Zj+t5M3TOd7P
 fL6yHZZ4+9Fe4ns6TWailnaXExmDxTgaY2EM3eq7PoP8LxPOG0e4XNVqrsfNPy4OBBT7mr
 XKOueKCbR/b4QzgVLjwyd18/PRJuq+E=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-342-mVXbTX-7NY-UZUGdZ3ndEg-1; Mon, 13 Jan 2025 07:59:33 -0500
X-MC-Unique: mVXbTX-7NY-UZUGdZ3ndEg-1
X-Mimecast-MFC-AGG-ID: mVXbTX-7NY-UZUGdZ3ndEg
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3862b364578so2429610f8f.1
 for <qemu-devel@nongnu.org>; Mon, 13 Jan 2025 04:59:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736773172; x=1737377972;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T8lWUeti1iR/7LXpJdRlgTQsBRt1ESJ+StJPeZp5l7c=;
 b=XX4a89N99KLvLf4kzGXMDDwG4toO34V7sG9dL7OfIiotg8HUOVGgShBSBMp2A0VBnT
 pDOancWry1zBgaUgovy5HeuNid1Z/8fVfB2O3/b6UspWuM7JOkfT4FSRzx1r86mq5zgx
 eI5YiBPhBl0jMCwv9fL6jQRTNlmkEuc+j8JtG2I+btJmYHKERsri6D/h1KYLOarGwsRJ
 cGLjDwyIigH2/h9KSfcaqKJZ5WtqZN+GK2hTdVHAV9Yq7RCdb1BCCgLnz0KacmUiDY49
 5BDbNPwjhiR1hpkkPNIQFLwxYYV8smJ5TA+CRD+h0szUBfZ2fP4OQK1OZi/nRSUo5m5u
 XSRw==
X-Gm-Message-State: AOJu0YxGUUDKAW58XPCV7fQod0Z5BqCxRtobD5Idf789Y8ZKb2GXJHGs
 iEb7yKrmlZsh3/VsU8do+O2seT9EKUXEdd0lSO0mCYcr7n5hvqgnv8/VUouBS0E/9uf8Er5YvcI
 JL+/Nth/wwpwrotCod6aKv9EKPwb0DTuDAuAYpt4ncXC3gdsZ/zyz
X-Gm-Gg: ASbGncufQ1gB2mBHmSCcyEn2ndpFZ4blqfv9Sn1glfH0RZQGCUsr+iVxhUZgQxhyhzA
 +ZfI9mvr7XVb3Ju6hZIl1sWLun9tTc+UhCJrvYAlOJAn0OnLaCoHqKSX5yijiAQQEC6MmMVYJix
 xDCcxYe4w8/TslRUF4aPykcJQQHgnXQ8cQm1cLCjf5pidlN8mPjR43qBpii8dyqurKh6gEpuQGV
 M2tcnx+KL6WlTacK8ZhslaNpziF9XEuRlmjRAW89m26Nmqz6lZDIF8Q9+CChLC1nx0Kzyqdeeee
 BNfcDtu2G4dv+vmN5hXbOLR4nlH3
X-Received: by 2002:a5d:6daf:0:b0:385:f64e:f177 with SMTP id
 ffacd0b85a97d-38a8b0dafa2mr13293715f8f.11.1736773172621; 
 Mon, 13 Jan 2025 04:59:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEe4I9dm7i1lfI5KXwRZ0S1LH+aTt3A4DYQBvR2E6Fvcfl9WZSxGCAj+mxd5E2tCu7xEdIqHQ==
X-Received: by 2002:a5d:6daf:0:b0:385:f64e:f177 with SMTP id
 ffacd0b85a97d-38a8b0dafa2mr13293696f8f.11.1736773172234; 
 Mon, 13 Jan 2025 04:59:32 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e4b80besm11860116f8f.83.2025.01.13.04.59.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jan 2025 04:59:31 -0800 (PST)
Date: Mon, 13 Jan 2025 13:59:31 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Eduardo
 Habkost <eduardo@habkost.net>, "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?="
 <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v5 0/6] hw/core: Unify hotplug decision logic
Message-ID: <20250113135931.67f28681@imammedo.users.ipa.redhat.com>
In-Reply-To: <20250110091908.64454-1-philmd@linaro.org>
References: <20250110091908.64454-1-philmd@linaro.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.019,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.787,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, 10 Jan 2025 10:19:02 +0100
Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> wrote:

> Akihiko's v4 patch was doing too many things at once to
> my taste, so I split it to follow dumbly each steps.
> https://lore.kernel.org/qemu-devel/20250104-bus-v4-1-244cf1c6e2aa@daynix.=
com/

refactoring in some cases would lead to device being created
and then deleted, where as before it we were bailing out earlier
without creating a device.
I guess there is no much harm in that overhead and we get
consolidated handling instead of scattered checks.

Just make checkpatch happy, with that
Reviewed-by: Igor Mammedov <imammedo@redhat.com>

>=20
> Akihiko Odaki (6):
>   hw/qdev: Pass bus argument to qdev_hotplug_allowed()
>   hw/qdev: Factor qdev_hotunplug_allowed() out
>   hw/qdev: Introduce qdev_hotplug_unplug_allowed_common()
>   hw/qdev: Check DevClass::hotpluggable in hotplug_unplug_allowed_common
>   hw/qdev: Check qbus_is_hotpluggable in hotplug_unplug_allowed_common
>   hw/qdev: Check machine_hotplug_handler in
>     hotplug_unplug_allowed_common
>=20
>  include/hw/qdev-core.h |  3 ++-
>  hw/core/qdev-hotplug.c | 42 +++++++++++++++++++++++++++++++++++++++++-
>  system/qdev-monitor.c  | 37 +++++--------------------------------
>  3 files changed, 48 insertions(+), 34 deletions(-)
>=20


