Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3A55D116F1
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Dec 2025 13:41:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQ49b-0006P0-Gj; Mon, 01 Dec 2025 08:41:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1vQ49U-0006Jr-S8
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 08:41:17 -0500
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1vQ49T-0002oI-3C
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 08:41:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=dBfYrPfxweRn6UjvLAK8p8V9ZP8fUFLyM1QeAMgbyBQ=; b=HD0N7/s2mE/oJFk+erLqbYgX+0
 uyN6AmgrT7n6fT04reV2lV7DCDCgezDO7AXvanf1mvYZKiozrCh0eegj1jVajR49ofJkixqDJUit/
 K9iEY2zn6vlJDzF3uHEZqa0tSMrjmdplBPfwfy0XnGW2uji13fvSuOnnKlAqvv25YfKWNXaIkGeY5
 0ogyjikwGID/E8ejuz7XMxqpiAlJvHCiY4Yb71xL3ghsG7nKkLTFEkIuX0MuJs5z8MUPjFbl5nZ62
 WUCWq3B19xrrcsPTGEN/HEyix5t4Qbpjpjp5yxY4ECymxeQCtTvH/OotKchngEs8bybVUfhh72u+k
 chjhARj6oBBgJxpmw0s6/aug4nwSM+cpp7LZYo2XOTtLDGcfU/iGn5u8IaGJsVMEj0bIbtLrykh2e
 7J5uNzirmWE+ique1kqGP5jqHwDy06sZ1cjj15UUoKeGDtol+rlWQ0vcVCxJD8Y0Oe/FBye4yj/i9
 z8Csk+MtMSq5dsZBUku/o8+hZJNysd0tbKX9PG2Ja9oav5SBKlY63Gtcyoh0hYDVKPMedkBHq8noI
 bVEtqW9ivuFJ7Uh2BpBGdP8qDmHSDeaAG+VYXTTWGwFGrm5VAdcxsyezw6QRZI0AOdIsUJItH/UIl
 tdO6u5MJLJyKjm66F/Yu0GJtgZ0jt+SfQa4cYinlE=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Cc: Thomas Huth <huth@tuxfamily.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Alexandre Ratchov <alex@caoua.org>, dirty.ice.hu@gmail.com,
 Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>,
 Volker =?UTF-8?B?UsO8bWVsaW4=?= <vr_qemu@t-online.de>,
 BALATON Zoltan <balaton@eik.bme.hu>
Subject: Re: [RFC 00/24] audio: add GStreamer backend
Date: Mon, 01 Dec 2025 14:41:08 +0100
Message-ID: <17303071.geO5KgaWL5@weasel>
In-Reply-To: <e6ada475-da8a-4643-4986-2ffc1d5b9c66@eik.bme.hu>
References: <20251201112309.4163921-1-marcandre.lureau@redhat.com>
 <e6ada475-da8a-4643-4986-2ffc1d5b9c66@eik.bme.hu>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=qemu_oss@crudebyte.com; helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Monday, 1 December 2025 14:02:41 CET BALATON Zoltan wrote:
> On Mon, 1 Dec 2025, marcandre.lureau@redhat.com wrote:
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
[...]
> > The following patch series provides a GStreamer-based audio backend, wh=
ich
> > could ultimately allow QEMU to leverage the framework to support the
> > various audio subsystems and simplify the audio handling logic (timing,
> > resampling, mixing etc), as well as allow greater pipeline flexibility
> > and customization.
>
> While it's good to have a GStreamer backend to integrate well into systems
> already using that, this should not replace existing audio backends in
> QEMU. The reason is that GStreamer has extensive dependencies that I would
> like to avoid and still be able to use QEMU with just an ALSA or SDL audio
> backend that are much leaner and provide the needed functionality for most
> cases. Also when using jack you'd want to have a QEMU backend for it not
> going through multiple layers. So adding a GStreamer backend has its use
> as another audio backend but not as a replacement for QEMU's audio
> handling logic and backends.
>=20
> Regards,
> BALATON Zoltan

I agree with Zoltan on this. GStreamer is nice as new backend, but I would=
=20
also preserve the existing audio backends for the same reasons already=20
described by Zoltan.

/Christian



