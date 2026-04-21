Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B85EF94CAB
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 20:20:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFHZN-0000LX-Ht; Tue, 21 Apr 2026 16:19:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wFHZL-0000LB-KV
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 16:19:39 -0400
Received: from mail-dy1-x1330.google.com ([2607:f8b0:4864:20::1330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wFHZK-0007Ru-6M
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 16:19:39 -0400
Received: by mail-dy1-x1330.google.com with SMTP id
 5a478bee46e88-2bd9a485bd6so3495708eec.1
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2026 13:19:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776802776; cv=none;
 d=google.com; s=arc-20240605;
 b=i4cxebf2oZHX7ew4HdWBCC+8P2VBrJFqT46Kd3K/ikBPWIgrfkzcHqfIVE23dsUMuN
 c8rOoeiRHPUlkh4IGflN7Xw1MXdIFudkQ7WdHb4oqTFzRhxTzy4MiBdfQFNVKS1fw325
 IhmDMlGZq+N+/bX/hi2L6TKplHmEDRYZqDM1RANFJnEo16lE41xU0gI9CZEyx3H6ENnK
 GU0HV7eEaOkmB8zdjhJVK+PhG2bBcY7mndOtH1Ga5f3LTo0QafeFICqmom7d3hqx7xQs
 T+25egbdMkWfYD0pVihoR5Hc/QoCC3IXqpdool4yI+LkszWlExPBsTr6gw14VZofD4af
 kLgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=lhbXI71BLQbXf1zR2tGFqtPIWad9g5+JM2XVGQ23hyo=;
 fh=f5E/eXbABplc4UmKfkwN8PaFFZEYUlpwsNE0wcaG5p0=;
 b=Y/9fcY1yt8Uw7ti583EzbsqHI460Q4LhhXOpHFA/Q7rtc+1QGSC3//CCtdXTweuGOu
 bM1RaUtjok8rmShuGS/iTKycVA1PYBQGj951TkrXNCJzuvhRjllebcnjm6wP5dlVaS+f
 +NVbitAX8sXvJtvA43n4SKXSHPq8HLIW6FbO4guMGKumuAcz+O97tigb1/EYv4bv94c/
 dSo1arxYLkMKLrfDyXzjLmeU18scPt03ygLM67IaXIJZhFaXB4+DL95A8P19cr+ZVcEJ
 qmDKWhYVq91zmNBBpZOqdrG9DEYtFU05laZj53jhJyTz9sFXpIVxBkCqyT2ILebGRHeU
 xxqw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776802776; x=1777407576; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lhbXI71BLQbXf1zR2tGFqtPIWad9g5+JM2XVGQ23hyo=;
 b=ZK0M+DyNg/o09SsMrLXBk7B31Hoxc2BfBaQ68zil8YKUmoBPAG9fvwgeO1fGFU2/tD
 yldNdYwcygbYACf1Qpy4AGbI44hv5PrXArHQZanJ6fG7ud2zqH+TJa6Lh+Y2nEUr+lvt
 drWUyB9PD6s7ystan6W7GIbRkzleQLIfeZZ1NGudcXzXY1teIjVz1AVbGxpXyO9+uUrG
 R+BxtEL+1i//omTFhHib1MiEAv4/pgp2lJXWv1EAfHLcmKcOlaj1iPKfV2dNHC/rCDO/
 87Y/rLG7yzOPZ6vpaf0iVvf3aBTQ+ZPSuImcxJgOPV5wEFf+c5QGHpCNRWh9uYLHIMp8
 NaGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776802776; x=1777407576;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lhbXI71BLQbXf1zR2tGFqtPIWad9g5+JM2XVGQ23hyo=;
 b=MgcA9ZeQZx770BX2725zK6dNZ+e8XN7ximLvFLCEgGftBm3rQ+oxuujhK1UYm9PW8B
 1Og0MAWmrdp9jx1HUcytD+rZwkxvxT79827w2YDr8djDViVEDSelxtac8Vi8h59ES7vE
 9XCcK8BaSuJLy2vxeU7fmhgh45m3BXCw6qoaCtIHdSi3k01vK2vPPvuWGcHELQ01sJUR
 fVP32hEvji1jxfEI6LPCjGgyjK7NBSHkhWcz6evLDId8asH/jhp8RlI1PsMsnopfodiS
 ryWx+tREKTZ11AAR6E+37S45zWGp6agtSLh0VCt1Ama49PVZh6PWa1ZS2cuYZCKEb9w7
 r8iw==
X-Gm-Message-State: AOJu0YwCprhV6n1v8D6mimDDOxlaNtPSFiNFxHa1OdPsiolNWaSPMjIM
 naecYTVFE21jMva4JjnuoW220i0M9cgmf2jzUkJbsN1o4HDwf7DifwqQZcf6dpLmjomtJCqlvZg
 mUt1n4JhrCeBT97AlRxgZG6HpRjqeqQsfMw==
X-Gm-Gg: AeBDieu33xEUbdwPGVM8W+H9i182psouzK3Arv4vzqrDnIxyiPVqCXTRrF0ShiKj9Kh
 U6Rk3LuXkEP6Ch0Wm73sIosfwKj6F9hI2UVaQbOU3Ck23TiuzacrBVOWKiEwDMkuBu9YN4OUAO1
 qcrZh33vuy3roAorA+YoxQawsVyn/b0jXcn6Dojlpjwr9dM7eHevsh1g3AwtFFMPBNYVFrhwGXj
 tSEzO2+jvivIjXlUTQOqBKE60O0IiiocGcFqGhTpf21DHwFXbjtw4FYG2SD5DSfq7bGIf4gWEQi
 YLMwmNHR+Oi0mj+I94BZOVR3czHxeorApmy6kEXHLTOFTFWQ/tk=
X-Received: by 2002:a05:7300:d512:b0:2c7:3a7:c7a7 with SMTP id
 5a478bee46e88-2e47951866bmr11484033eec.25.1776802775601; Tue, 21 Apr 2026
 13:19:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ+F1C+ukA5ZBDLaeTmjwKXdiOdG6Ob11+nUG0Ct_SpAaUx+Mw@mail.gmail.com>
In-Reply-To: <CAJ+F1C+ukA5ZBDLaeTmjwKXdiOdG6Ob11+nUG0Ct_SpAaUx+Mw@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 22 Apr 2026 00:19:23 +0400
X-Gm-Features: AQROBzAdrBl33h-34HqDgUBsuFYwNStIEzgufJpi6D2e_CzAP7TlxbnfxUB8Bps
Message-ID: <CAJ+F1CLQjQ5_FrCyxiQoxGFiU7m_pdqsKY+4P2GsRS1yKCdu+Q@mail.gmail.com>
Subject: Re: About query-qmp-schema
To: QEMU <qemu-devel@nongnu.org>
Cc: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1330;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-dy1-x1330.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi

On Tue, Apr 21, 2026 at 12:11=E2=80=AFPM Marc-Andr=C3=A9 Lureau
<marcandre.lureau@gmail.com> wrote:
>
> Hi
>
> The query-qmp-schema returns a stripped-down version, removing types
> unused by commands and events. It also renames types with integers.
>
> That makes it impractical for a client to know which values are
> acceptable for a generic qom-set commands: qom-list returns the real
> "unmasked" type name, and it may be a type that is not even used by
> qmp commands/events. A quick test shows the current schema is about
> ~243kb of json. With all types, it grows to ~273kb. Unmask it grows to
> ~308kb.
>
> Could we send the full version? Eventually, we could have a "flavour":
> "full" argument.
>
> Another option is to compress the schema. A "full-gz" in baes64 would be =
51kb.

After some experiments and some thoughts, here is what I propose:
- Replace QLit representation with a compressed JSON - the JSON is
built-evaluated at compile time to handle the #if conditions and
produce the per-target schema
- At runtime, query-qmp-schema decompresses it and parses the JSON to
keep compatibility with existing commands, applying filtering and
typename substitution
- Add a query-qmp-schema-data, which returns the unmodified compressed
JSON schema blob (~35kb in base64)
- additionally, I'd like a way for the client to query the
documentation. Having a similar query-qmp-schema-doc would result in
shipping ~135kb of gz content, which could be shared by all binaries
(since the doc doesn't have configuration).

Please comment, thanks

--=20
Marc-Andr=C3=A9 Lureau

