Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09191C369A1
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Apr 2025 09:13:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u3Wv5-0005e0-M7; Sat, 12 Apr 2025 05:12:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u3Wv3-0005ci-MB; Sat, 12 Apr 2025 05:12:57 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u3Wv2-0000hT-A7; Sat, 12 Apr 2025 05:12:57 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-b061a06f127so556950a12.2; 
 Sat, 12 Apr 2025 02:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744449174; x=1745053974; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RXCAEsCpdNV1Hq/vICQlZRIZEyF8Nck30VrAqj90PLI=;
 b=jiP7JvIFMdHN64IlNIvtnfGaBT9S6EQFJHde1w3Wl07EsEeQ+qKUTKrvGqKRU6ZTb9
 kEyf2YzR1Rxn+VofV/nQnITx7OWdEZXA+NpOZCyHkN7zEW9UuC/jfP8pg5gJR4Pxhowx
 3iOaq9G5o4sTJXxD8ackq7Q1eRzlIUBg7PckdX0gOmWy47IxPMaW72ZoaewICCYcGzN5
 i2HwxcMyzzMMkBZFyOsbi8D4dEBdOw6ZzHIQGyXnqsMcdUyjWMdMvNND3OgjlKObrgi4
 F11RKrxgI8xk9NZ0Nz2gtPBye3uRlus6tUYNOv3pvGOYRI2ctdG/hYYNDNq3AAiOYMSi
 O1Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744449174; x=1745053974;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RXCAEsCpdNV1Hq/vICQlZRIZEyF8Nck30VrAqj90PLI=;
 b=KaEojsL16wsUhsqnG7XbJCVHH9zlOFHVZvkfPXZwNmyGwe1JMCLhEyIrtiOLtGIRMv
 1aJLpq43PvF4qwNBRa94XNEeIGgwrTnfUp/OGbUOanvRSmtSdFlF6Q0rZd0/Hwcvo/93
 1PRpb9SqYJgkNEN6eZXtdyJSL7agPFThDPzHmOv+2ONolpdcjCj/OqVUpA2kVq2ng+ud
 onijgYDphT+wdYNWR80ABvd7LMo2iJCai2Ezg8rLmV7StfGGNO9ouzKviYrtaKvZVKDN
 giY34qjZPIJ/pzbp4zyN1maYmesdywpWOIs7f69DWd0mbEnNfzedcRMvjWuf9IbDbqqU
 5eVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWhoP/RUkbl/LivZ/g0XZRMHlbSYc9K+yTYLPg+4SAZSfY2ZabMJ5MgHpGzK3/E9CthAdA70drVQ==@nongnu.org,
 AJvYcCVKzHUTOklhJwD9Da9NPCvadSj3WW28AEW9uube188QL+iJUq2IMQtISDLuGKkemHXwjhbtpljc7+T+8Q==@nongnu.org,
 AJvYcCXBZ5zooaiwx2WekaEYsiTph/tyn1Z70s35CbdW3Y0WjVIHFMnrPGFDBPjV6Tk6pY7bof+Um2qpzJ6rDg==@nongnu.org,
 AJvYcCXiesdDQIT08YzVFW+KQ5O3T29oKVqOFwK8gKHDIkMEpOz9zBy31i4n46O0jdczIb4jYhzM5IKansnCDA==@nongnu.org
X-Gm-Message-State: AOJu0YzXOGesjsW5WuMRyL9+/TUsXadxhRUx/+g55/F/3Jio8kQDO+eC
 p9PzmO8UjeWSeku9zm46bhoQdXQc6uLWVPeyhMN3M7URoxrYv//c0xKtTjEqxkkPNi3hNJ1oylS
 Ckx0j2kW13tkDe4skQ606vzoiCAo=
X-Gm-Gg: ASbGncvQRAB0hEP/KfoLYNz9/DYz1HvFGcFJ5O7eq268jcQfTqiVC2VnJCFhqCKqQFv
 ZuCoVedLQG+7yq69AyBZEOmP5eMgQ3kdsideIDtF6bb35HCfk3cZ/Q4NYcWtKqfJJnnkLAJfjeu
 pTjsSF83nWM45OgdBzl48sBUtPbddu+9I+Iuay7xM2d+Jb3CgiaYE=
X-Google-Smtp-Source: AGHT+IHic7FV/mzSdyc8NyBbU7ypE8WT3b1JFUebnq8RCbFEYga+P8u54vha9RzhjoYiUYnU54FqsJT15f87MjLWyZc=
X-Received: by 2002:a17:90b:584b:b0:2fe:7fea:ca34 with SMTP id
 98e67ed59e1d1-308237cedabmr7339114a91.32.1744449173657; Sat, 12 Apr 2025
 02:12:53 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1744032780.git.ktokunaga.mail@gmail.com>
 <24b5ff124d70043aff97dc30aa45f8a502676989.1744032780.git.ktokunaga.mail@gmail.com>
 <264d9113-16ce-4c05-a468-78e1f9921df6@linaro.org>
 <CAEDrbUZO+vJZacBJeE2Od_9Eb+vjX1JYCsNz1QQA4MKFTi9cnw@mail.gmail.com>
In-Reply-To: <CAEDrbUZO+vJZacBJeE2Od_9Eb+vjX1JYCsNz1QQA4MKFTi9cnw@mail.gmail.com>
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
Date: Sat, 12 Apr 2025 18:12:41 +0900
X-Gm-Features: ATxdqUHxyLyTB3UgAf4f1Q4Gzo4a9Tocnl1R5OSC2EaYHQ4IoeCHIoqTp3Gf4m4
Message-ID: <CAEDrbUbgUE2E5u7R4xyASzSpvpFQycDxwEueDpHE6AXuaAtLWA@mail.gmail.com>
Subject: Re: [PATCH 07/10] tcg: Add a TCG backend for WebAssembly
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, 
 Christian Schoenebeck <qemu_oss@crudebyte.com>, Greg Kurz <groug@kaod.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 qemu-riscv@nongnu.org, qemu-arm@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000005323d5063291396d"
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pg1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--0000000000005323d5063291396d
Content-Type: text/plain; charset="UTF-8"

Hi Philippe, let me resend the table as it was corrupted in the last mail.

A: !defined(CONFIG_TCG_INTERPRETER)
B: !defined(EMSCRIPTEN)

                  | A | B | && | || |
------------------+---+---+----+----+
non-emcc + TCI    | F | T | F  | T  |
non-emcc + non-TCI| T | T | T  | T  |
emcc + TCI        | F | F | F  | F  |
emcc + wasm       | T | F | F  | T  |

--0000000000005323d5063291396d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi Philippe, let me resend the table as i=
t was corrupted in the last mail.<br><br>A: !defined(CONFIG_TCG_INTERPRETER=
)<br>B: !defined(EMSCRIPTEN)<br><br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 | A | B | &amp;&amp; | || |<br>------------------+=
---+---+----+----+<br>non-emcc + TCI =C2=A0 =C2=A0| F | T | F =C2=A0| T =C2=
=A0|<br>non-emcc + non-TCI| T | T | T =C2=A0| T =C2=A0|<br>emcc + TCI =C2=
=A0 =C2=A0 =C2=A0 =C2=A0| F | F | F =C2=A0| F =C2=A0|<br>emcc + wasm =C2=A0=
 =C2=A0 =C2=A0 | T | F | F =C2=A0| T =C2=A0|<br><br></div><br><div class=3D=
"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr"><=
br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">
</blockquote></div></div>

--0000000000005323d5063291396d--

