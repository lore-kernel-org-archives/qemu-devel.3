Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15B34CF64B3
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 12:59:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svFzp-0007Iz-TU; Mon, 30 Sep 2024 08:59:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1svFzn-00079R-1s
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 08:59:23 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1svFzl-0006we-6o
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 08:59:22 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a8d43657255so682106866b.0
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2024 05:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727701159; x=1728305959; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hu9HUgBcQ/Kv4Aeg/YwfxVUNBMJ0SUJuHaSqrAAB2r8=;
 b=KqcJACo4wF4gU5O+pia9PcrGWdQd6DCfLAu8AUppWnSfNFlHU/bxdtSjMWbE7+V1qy
 SuKugaTB9Xo5jmpHqwm9tzmg8InfJpRBq+swTNad9cuXq5R4qrcBR1eh8rcmFxoy0YwL
 P3DrEArzydYSgi+8776DZ3bfvJchzifoSmg1FBny63nJVbFEdssg4hFccXGIl84AO5tM
 z9BDIyJkqlOuKx+VlJ2qeOrV1IQ/pwUqcLF+EpvHrqlacpPC5MPaOPSC9QGO+hJwiL6C
 Pn1WJ4lATOC5eHD4lmT01V7+4khbdfi9eSaxSbNOIp6zYj81i1NMGHgckIuSYrDlgaPc
 F/yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727701159; x=1728305959;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Hu9HUgBcQ/Kv4Aeg/YwfxVUNBMJ0SUJuHaSqrAAB2r8=;
 b=tlf2KLHRnmNttfDZHJI+0LVbwZv/gwDrEeC1sYpE80SU6CrioeE7/XIuvezLIcY2N+
 krwZNx0FON1292YUW2SrLq3bF4wmzUgYzulJtJCJ1h8PbgY8XAc5MgzS7Rq+Hs8DnLJl
 GlmsbGop2nyEsuwXcDDXR4PZNC3dDFzGpoXJHXayryjIKqb8w6Mw9y5tCBSxMC4hQvNA
 P3HHJ/kWbKHnAoOdwSh1zCGOdIAvyCiZQojfd6SEjBFnkkQMDzDdbekgNdVN00R5q+uH
 jZpRn6eCv+oiFEbUbolxtdkhDGRPzr+/c/A7+g5vE1R0kyviArt31J4Nz4qdm7H3at4L
 Emnw==
X-Gm-Message-State: AOJu0Yw0SxLz+WE2fpqJ/UO5mc6zquzlK0pKZz2UOQrxrc3t7ozmR4dA
 vP2iVwdHYl+G3EcePp0pU6DIb0TA4BWxr9Ao6toVKF/Pq54wQkGcX59AKj3ysBU=
X-Google-Smtp-Source: AGHT+IHYvIPuGqNmggNnyX+xtMpvOU4CzSqq00ZcUtc+prsmO5numk+pHHNBwWMNWAewmYzKV8nhTw==
X-Received: by 2002:a17:906:fd86:b0:a8d:1655:a42c with SMTP id
 a640c23a62f3a-a93c48e8f73mr1398101466b.1.1727701159306; 
 Mon, 30 Sep 2024 05:59:19 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a93c297a2absm531234066b.150.2024.09.30.05.59.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Sep 2024 05:59:18 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D1EC75F716;
 Mon, 30 Sep 2024 13:59:17 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org,  Hanna Reitz <hreitz@redhat.com>,  Christian
 Schoenebeck <qemu_oss@crudebyte.com>,  Fam Zheng <fam@euphon.net>,  Song
 Gao <gaosong@loongson.cn>,  Pierrick Bouvier
 <pierrick.bouvier@linaro.org>,  Mahmoud Mandour <ma.mandourr@gmail.com>,
 qemu-block@nongnu.org,  Laurent Vivier <laurent@vivier.eu>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Vladimir
 Sementsov-Ogievskiy
 <vsementsov@yandex-team.ru>,  Greg Kurz <groug@kaod.org>,  Eugenio
 =?utf-8?Q?P=C3=A9rez?=
 <eperezma@redhat.com>,  Gerd Hoffmann <kraxel@redhat.com>,  Bin Meng
 <bmeng.cn@gmail.com>,  Fabiano Rosas <farosas@suse.de>,  Eric Blake
 <eblake@redhat.com>,  Hyman Huang <yong.huang@smartx.com>,  Kevin Wolf
 <kwolf@redhat.com>,  Stefano Garzarella <sgarzare@redhat.com>,  "Michael
 S. Tsirkin" <mst@redhat.com>,  Alexandre Iooss <erdnaxe@crans.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,  John Snow
 <jsnow@redhat.com>,  Eduardo Habkost <eduardo@habkost.net>,  Jesper
 Devantier <foss@defmacro.it>,  Peter Xu <peterx@redhat.com>,  Stefan
 Hajnoczi <stefanha@redhat.com>,  Klaus Jensen <its@irrelevant.dk>,  Keith
 Busch <kbusch@kernel.org>,  Paolo Bonzini <pbonzini@redhat.com>,  Daniel
 P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Yuval Shaia
 <yuval.shaia.ml@gmail.com>,  Bin Meng <bin.meng@windriver.com>
Subject: Re: [PATCH v3 10/22] hw/sdhci: fix -Werror=maybe-uninitialized
 false-positive
In-Reply-To: <20240930081458.1926382-11-marcandre.lureau@redhat.com>
 (marcandre lureau's message of "Mon, 30 Sep 2024 12:14:45 +0400")
References: <20240930081458.1926382-1-marcandre.lureau@redhat.com>
 <20240930081458.1926382-11-marcandre.lureau@redhat.com>
User-Agent: mu4e 1.12.6; emacs 29.4
Date: Mon, 30 Sep 2024 13:59:17 +0100
Message-ID: <87sethnvq2.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

marcandre.lureau@redhat.com writes:

> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> ../hw/sd/sdhci.c:846:16: error: =E2=80=98res=E2=80=99 may be used uniniti=
alized [-Werror=3Dmaybe-uninitialized]
>
> False-positive, because "length" is non-null.

I certainly get that:

  length =3D dscr.length ? dscr.length : 64 * KiB;

means we always have something. Although get_adma_description() is
deserving of a g_assert_not_reached() lest we end up re-using a previous
descr.

I guess wider re-factoring is out of scope for this series though:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

