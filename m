Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45E51D3E77A
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Dec 2025 20:37:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTQvG-0001Zz-PO; Wed, 10 Dec 2025 15:36:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vTQvD-0001ZM-6r
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 15:36:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vTQv7-0005dZ-RF
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 15:36:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765398977;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pJ6uuNT/gXqoPaXvLTqo73XM4geXYs0iV//t6Fp5JJA=;
 b=Suhn2ZVM12sgjNfDUrReRwanhJ5L3aS8dzjZPlP01WUIAJ1uFHXtQUYVkxQw0YzCFkYj13
 Gc8/es84ECg+bp6abnMf+iGWlWsBmkMImImYYtF/6gJpcHsFPqeFtw1zkJdylSjrMhQY9S
 MS4EjqY7P74DQNTbWlNX+QSbBWsDx9U=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685-8RQh_Z4CP2yRi5pJVWQ6rQ-1; Wed, 10 Dec 2025 15:36:15 -0500
X-MC-Unique: 8RQh_Z4CP2yRi5pJVWQ6rQ-1
X-Mimecast-MFC-AGG-ID: 8RQh_Z4CP2yRi5pJVWQ6rQ_1765398974
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-477563a0c75so993175e9.1
 for <qemu-devel@nongnu.org>; Wed, 10 Dec 2025 12:36:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765398974; x=1766003774; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pJ6uuNT/gXqoPaXvLTqo73XM4geXYs0iV//t6Fp5JJA=;
 b=mK+IGa6kbXb1wSa+XvO0O63UScagcFbfRK/XzaOss453mxDtxcCQTWTKQaBzq6DIpT
 sFL/d4+QZWkQnqQAtyAvATX1+2sz7dNuefJxUIm0xAMRqQqVyeGTxbRZW1YRk2lGZ6Ej
 EBXBPgZ8xV+GvEF6MxSddEc2Si5RagMGtpLIQMtojVIdCoVfY5u+LyNd4wP8DYSxU634
 eR1dt7YLth3l5ST52NdDiszoS5PX5i4NHzr2u9TRcXIeeweKRUrHUfRx8KV1mu2p/TJq
 OmmpnhQ9cyFk/tB0XhubdfyEFVv50o3gCUZPA6l3tkcxauCbK5b3qv/bB08AZE9sl5ME
 8Fow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765398974; x=1766003774;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pJ6uuNT/gXqoPaXvLTqo73XM4geXYs0iV//t6Fp5JJA=;
 b=llj5i519OoMM34YDMuV30MgTaIS+Pb6K6i493s7yTI7b8YgZbalephwZiGXSH8VHZL
 aNMsaTyBpKDJU4YE7xXb3IxaZQ+3x8kz6t+oNlm6ZYVwOBsOjLNgEqYoNyZOJj21SZr5
 cj18oUpFzrcfSk5SSzgl0b59DtGBfPi5RZ4fncWHSzp0rb5X0a8h2lMDCfLXwrpAFKAv
 360zEwKI7/2eeqMqDqcwQNEsYbR5lCxJu8xKaXcf123ADfSe5+lzwsbPBd3nh4bfmGGw
 gJWeev5Eplz5cwaBO39G5f2riYNGTLHY1VdLfCw08yRcyoN8EUIUJFAcQU08pY1BKDHN
 h3Uw==
X-Gm-Message-State: AOJu0Yxf63i6dH3TvSroes7rUFxgo3wnQARUcpNk6wRBrYPc4R/GnKQM
 IQTiW4VvCiQBfFo09zS1+m1iJoYBew7PRhKyZuHW34gbfBQ13eBJC8ZGtGoGXo63wQi7k0j/lBE
 ww36L5ysK4YOr/3uOIc5tk1Rz/E8GlnqQKW/TV9Y7PY3tr9HxMwLRqVSwt5GwzlWoGde6Yc+CmJ
 wnMjOXSZofbTvPhircinpWKVzepp/Ao4U=
X-Gm-Gg: ASbGncttqVsk7AlG3P/1t//uK2T7seCIFtSP5akfCAhHJqlutrH9iCRMhFUA+rNtLMv
 A4YyK9tE0Os/jSkmod7hkkYjsecZPbV1X5V53BfmxWWY0JhVYRyPfy1zKPStj/18zSMszB8YZ6l
 153yEQmTX95cG2JXp/0R+qUPzBLCUJu7J4wZF9jCB6EIFXg606dHmJDsH1EDdwu1IcdJ9vcTqpU
 rnfUsM0P1sR9yFKH0bU+EfcJXngiWTJeHqeXfU22Fb+Ff1HMdM4YEFw2Zv2H1it2XjdLPY=
X-Received: by 2002:a05:600c:8010:b0:479:3046:6bb3 with SMTP id
 5b1f17b1804b1-47a837aca24mr32661875e9.23.1765398974249; 
 Wed, 10 Dec 2025 12:36:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF6TKgoJIREN449EA2b36kjFpim1Cd6rscCxoZyiY/6/sErcSwFaHuyE6TXfvzZbBdlaQzh5vS8KKy8MYh1ZPw=
X-Received: by 2002:a05:600c:8010:b0:479:3046:6bb3 with SMTP id
 5b1f17b1804b1-47a837aca24mr32661695e9.23.1765398973867; Wed, 10 Dec 2025
 12:36:13 -0800 (PST)
MIME-Version: 1.0
References: <20251210160544.2265437-1-berrange@redhat.com>
In-Reply-To: <20251210160544.2265437-1-berrange@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 10 Dec 2025 21:36:01 +0100
X-Gm-Features: AQt7F2rhweN6Gcf01K8tiv0T8nY6ynJNyMLW50QmlA5AN9-Y7Y7n1Qn-li02grY
Message-ID: <CABgObfakC_t5MdO3-+iJVOaTz4i=SjE2yd5AGdY0RNn02eEuMg@mail.gmail.com>
Subject: Re: [PATCH] run: introduce a script for running devel commands
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, John Snow <jsnow@redhat.com>, 
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000b97ec706459efaf5"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

--000000000000b97ec706459efaf5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il mer 10 dic 2025, 17:05 Daniel P. Berrang=C3=A9 <berrange@redhat.com> ha
scritto:

> Various aspects of the development workflow are complicated by the need
> to set env variables ahead of time, or use specific paths. Introduce a
> $BUILD_DIR/run script that will do a number of things
>
>  * Set $PATH to point to $BUILD_DIR/qemu-bundle/$PREFIX/$BIN_DIR
>  * Set $PYTHONPATH to point to $SRC_DIR/tests/functional
>  * Source $BUILD_DIR/pyvenv/bin/activate
>

Most of this should be obtainable with meson.add_devenv() (
https://mesonbuild.com/Reference-manual_builtin_meson.html). Even
activating the venv is just manipulating the VIRTUAL_ENV and PATH
environment variables; for completeness you could also unset PYTHONHOME.

Then the script becomes just

exec @build_dir@/pyvenv/bin/meson devenv -- "$@"

Paolo

--000000000000b97ec706459efaf5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il mer 10 dic 2025, 17:05 Daniel=
 P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.com">berrange@redha=
t.com</a>&gt; ha scritto:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">Various aspects of the development workflow are complicated by t=
he need<br>
to set env variables ahead of time, or use specific paths. Introduce a<br>
$BUILD_DIR/run script that will do a number of things<br>
<br>
=C2=A0* Set $PATH to point to $BUILD_DIR/qemu-bundle/$PREFIX/$BIN_DIR<br>
=C2=A0* Set $PYTHONPATH to point to $SRC_DIR/tests/functional<br>
=C2=A0* Source $BUILD_DIR/pyvenv/bin/activate<br></blockquote></div></div><=
div dir=3D"auto"><br></div><div dir=3D"auto">Most of this should be obtaina=
ble with meson.add_devenv() (<a href=3D"https://mesonbuild.com/Reference-ma=
nual_builtin_meson.html">https://mesonbuild.com/Reference-manual_builtin_me=
son.html</a>). Even activating the venv is just manipulating the VIRTUAL_EN=
V and PATH environment variables; for completeness you could also unset PYT=
HONHOME.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Then the script=
 becomes just</div><div dir=3D"auto"><br></div><div dir=3D"auto">exec @buil=
d_dir@/pyvenv/bin/meson devenv -- &quot;$@&quot;</div><div dir=3D"auto"><br=
></div><div dir=3D"auto">Paolo</div></div>

--000000000000b97ec706459efaf5--


