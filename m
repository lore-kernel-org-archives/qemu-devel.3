Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D86DCAC5A8
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 08:52:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzAMt-0005MS-1P; Thu, 18 Sep 2025 04:51:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1uzAMr-0005Lk-0v
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 04:51:53 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1uzAMk-0003qR-Ut
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 04:51:52 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-45f2f7ae386so4866915e9.3
 for <qemu-devel@nongnu.org>; Thu, 18 Sep 2025 01:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758185503; x=1758790303; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=TSut7jC223KcQ28OwKjoeYzAZ+HRkIOvvblOwLHh6ls=;
 b=B4BmomWXoTUqxUDDoYEu9aKiGF7qMAUTc1EIUVEYHRJ+NOYl/lgzA6Mh3BOmea3TeM
 73mB6Drku5pI84GYuCEgygdGJGP/Kef6Iwl306+GGv2bRIQImDrCNayvxtWh1v6eFLhW
 LgucW/7L6MfYKeAKYw/XNgBVdMP+gRFRNqW+V+p6nD0EwpgvZh2VUX7ifASP2kEHrMD+
 oeEVo6e/TWAvqfczb06EuruYC+mHgkvpKnHrzCg0gLsFfwxGclTewlJfDRx9hkpXEc33
 rl0oVR38iL9vHJQpbNQC244s97P/5yswdoSTPG04hkrghw7ULfDwknZM/W8FnaO1HAg4
 aVYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758185503; x=1758790303;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TSut7jC223KcQ28OwKjoeYzAZ+HRkIOvvblOwLHh6ls=;
 b=UlMf1LalCS8Boe5KxmnuKTM82oZrfLmCGaRaQKhF7XNaO2bwWoQwG1yuWHK2xHL7ap
 3Xn11Xn99o6HSUd9HeHzzmDF8fqKoxkuRl9gs2UOBIBv0OnpT9YjalrnWe02DBPs6yQ6
 IW3TYEKLdFTTY8AAgxzFcg3bAXVciSlZRapsvqnEX87CPuglqcmQ4EMrKWHhFOUqA6jl
 dwO0tfD/teLmNNtyvaRjCnCNb43xpnlJ+bPHJhK9peKEsmZMn4rpEtRRreofYtarXyYu
 hdSYiBHeTOswv/FnuACe2+a49j3rpWv4sbO8KsfqMCeCLiXVk9ICZNN83ggUxR6UzVzW
 QQZg==
X-Gm-Message-State: AOJu0Ywvwe6r3CNm8cx1I5/WULAGV/4dlUjE3zfZ015Ul7ej92+wmJ7n
 1IUsKrGimvQ0lhKeGlj6Bqm5cXNLBFyq8OqA/ZlTY73kz4C02zp6yMe1
X-Gm-Gg: ASbGncvNrncYjXfpKxQFJOkF8FsriGb7qLHuVPMSQG5oA2DYv+P9gEas2EqG+5m/7MJ
 3KfmUQgx79zYzuw0j0W8J8W5/cvKy/gjAy3OzCE1KrvNX6LMs2kNyv1gPzD3+z1ZbqI0ifXcQ1/
 uO08U1YxxDrhdeTfSMNNRwh71m8sOJODBBSnRZBW+28Rx3bfCUlG9I+UZWAkZj+/c+DtGdO2pzi
 WwfpAtIavrBl9W6gSXT4DC1rSDL+NgQp9/JCKVWJobDc7JT5LOMpphi+CYwYM1mQsdsNDv6Lwjw
 G6nFk3HyHbF68zY6sO22JohLAat5n2Vyf/MfRSR2+EspgGrHE0Ynb4ME1JAKsYVqXZSgGJZXHPX
 zmTzrc6DopdmVHOrPG4YERgHb7XsQdLpeMdM9ihFeI2+oE+Myz7SbL7GtGtayn35eue97hHxRys
 HJhB9D
X-Google-Smtp-Source: AGHT+IE5uikpqxy3TYJz0Ju4VzM0PvWit03x57v7mL/1K3QOBiBw4uI3Ip6HqESU4X37GEYqV5GRww==
X-Received: by 2002:a05:600c:470d:b0:45d:5c71:76a9 with SMTP id
 5b1f17b1804b1-46205eb16bfmr52300295e9.24.1758185503273; 
 Thu, 18 Sep 2025 01:51:43 -0700 (PDT)
Received: from ehlo.thunderbird.net (37-48-56-34.nat.epc.tmcz.cz.
 [37.48.56.34]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4613dccb5e2sm70546865e9.17.2025.09.18.01.51.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Sep 2025 01:51:42 -0700 (PDT)
Date: Thu, 18 Sep 2025 10:51:43 +0200
From: Filip Hejsek <filip.hejsek@gmail.com>
To: =?ISO-8859-1?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>
CC: qemu-devel@nongnu.org,
 =?ISO-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Szymon Lukasz <noh4hss@gmail.com>
Subject: Re: [PATCH v4 08/10] virtio-serial-bus: add terminal resize messages
User-Agent: Thunderbird for Android
In-Reply-To: <aMvBbkwaB2efBqRO@redhat.com>
References: <20250912-console-resize-v4-0-7925e444afc4@gmail.com>
 <20250912-console-resize-v4-8-7925e444afc4@gmail.com>
 <aMvBbkwaB2efBqRO@redhat.com>
Message-ID: <E502CAA9-4C94-4BE6-8F44-3C65C08C024A@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=filip.hejsek@gmail.com; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On September 18, 2025 10:23:33 AM GMT+02:00, "Daniel P=2E Berrang=C3=A9" <b=
errange@redhat=2Ecom> wrote:
> On Fri, Sep 12, 2025 at 05:39:53AM +0200, Filip Hejsek wrote:
> > From: Szymon Lukasz <noh4hss@gmail=2Ecom>
> >=20
> > Implement the part of the virtio spec that allows to notify the virtio
> > driver about terminal resizes=2E The virtio spec contains two methods =
to
> > achieve that:
> >=20
> > For legacy drivers, we have only one port and we put the terminal size
> > in the config space and inject the config changed interrupt=2E
> >=20
> > For multiport devices, we use the control virtqueue to send a packet
> > containing the terminal size=2E Note that old versions of the Linux ke=
rnel
> > used an incorrect order for the fields (rows then cols instead of cols
> > then rows), until it was fixed by commit 5326ab737a47278dbd16ed3ee7380=
b26c7056ddd=2E
> >=20
> > As a result, when using a Linux kernel older than 6=2E15, the number o=
f rows
> > and columns will be swapped=2E
> >=20
> > Signed-off-by: Szymon Lukasz <noh4hss@gmail=2Ecom>
> > Reviewed-by: Michael S=2E Tsirkin <mst@redhat=2Ecom>
> > Signed-off-by: Filip Hejsek <filip=2Ehejsek@gmail=2Ecom>
> > ---
> >  [=2E=2E=2E]
> > +        vser->port0_cols =3D cols;
> > +        vser->port0_rows =3D rows;
> > +        virtio_notify_config(vdev);
>=20
> IIUC, we should skip sending this if port->id does NOT reflect
> the primary port 0, as the virtio spec indicates F_SIZE only
> applies to port 0 unless we have F_MULTIPORT  set=2E

I have already changed this in my working version=2E I'm on a phone
and don't have access to it right now, but it was something like this pseu=
docode:

if "console-size" enabled:
  if port id =3D=3D 0:
    port0_{cols,rows} =3D {cols,rows}
  if multiport:
    send VIRTIO_CONSOLE_RESIZE
  else:
    notify config

I guess I should make the config notification conditional on port 0 too=2E

