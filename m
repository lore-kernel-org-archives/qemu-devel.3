Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 771E2C5B572
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 08:12:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvsRX-0006jV-JW; Mon, 17 Aug 2026 04:11:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wvsRW-0006jN-R1
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 04:11:38 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wvsRV-0008Ei-CO
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 04:11:38 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-c9aea40d799so1703853a12.0
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 01:11:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786954296; cv=none;
 d=google.com; s=arc-20260327;
 b=boMHzuRpVC/6cjd84iaBfQ5RFX5GlnqVKpWonQEV3f0/64ZWOhQlNtFlaTlJGP4WNA
 hBoXjYUQS6GFMc0Ttcpiu5FMYWFKBFq01g6ezqZKW19uJm+7P+bLjdI6ZF9ODqb9V3Iv
 docCdiRUG8og7pw9o+O5EZulJRvdrEwD0rxsrj34LMt0Ro9fkdQDWguC1H4C6f8PRwiV
 XXwXm9qGmVHjlvZIR+Sq8jUUedFJ95u1tGVdlWKLQaiuRnIlapNZ1/G7wMOJGVRSVh+4
 cdYka2Z+jY1bhDqSN7OreiKFyvBvwQeIxGnnsImDzQ/C5VyUmbsRlgDn+pgDxC0WjaD0
 xyAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=O0t1wXvKytESlmD7qXaQ366CeoYlfo9g4r+9dxpl9qk=;
 fh=xgTexhWpyEwgOWLYa8K9ylcdTJCdzsb5EHWbzq8pvQ4=;
 b=GMMR+x3eQMG3/KS3WEZDhlNqeY69oOSQApFZUFMytKZP9/HsHkzcSvnFJbv0dxiiGN
 etMrKwQL26i85r2Efa28LgAbUXIcUYY1vCUZ9CInr4XIz4HEe5VKiWq6TYdbNv7T1W0J
 bczDDhtDpbNO6XLQXvnf39IVb/2lbweKUme0JN+KX9QyZH5SPIBOPRj9vGiHsxpzQrJR
 zNXnBd7Kp5kQn6SA4URoMupFGit0yIoU+KqEd2yaPqnYM6nqNHJP1/xFyTGMkxw2yrlX
 m0Eubwg7LlPbwlTsiL+P87r/SN+TlMOsm6X16c6Qpq3OrC+jLQEBfb8nsArOrHc/+NGn
 qJ8g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786954296; x=1787559096; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=O0t1wXvKytESlmD7qXaQ366CeoYlfo9g4r+9dxpl9qk=;
 b=cW4NPK71oKo4LcJRW3qtutYfTM0W+08H+arnROKieojKwdntOZgZG/KSUg8ZarQLoq
 OO4O+bacp9lmP910bcMxIUIWCW6okmUita3D4+bgrR7lUR0Mjk3+Gx8WPPYmFNK7vzH4
 LHtEkJdnRK5IjfiwDLjOpT5kzlsqYMuEcOsYpxmWxxJN5B6dpHcdcS9iEEwOQpdg10OI
 wFher0bTqqO5cia1DYp8vH1INQAwZg5g5gB6SCysrZAVY2LAf1DwUC7ogqZLxrRnPkY/
 Rp6rlXU6KYZoA+HHohXY8FCa0zNnP55uPaR27T/jaGfhVjE5V0Ynw0sHHhKpQXuHuPP3
 d9sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786954296; x=1787559096;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=O0t1wXvKytESlmD7qXaQ366CeoYlfo9g4r+9dxpl9qk=;
 b=UJSaqmf2jVdNlKVtV3Qz1oyN/xGypLUT3xxjP8XdqGJRCFabcMrE7kkHKb4FxbwnTS
 NRcf6rGobC5bxD7kLtt3rdIuw3Xt2J51Nk5lFafGR4XJxagAJvJvFT90CyXuqWWACvoJ
 KPxXAzjN93K3W2VSal5/jRvcvkRfurA4lRlr3qRUhEaeOTaqyEI9IGBk+nKKchgI+PBP
 Rkg34RVdrN6VXE4gifONiE7yiccUsZKqVNC3cQLisD/EA+khmDzjk6n37ywutTzFNq5W
 axnFlfCQmmuApBSC2VCsf+6QzvC+/9m+PNKFB3e4QRUp2dGe+yPjXzL+lyIJeTwBKAgV
 fSzw==
X-Gm-Message-State: AOJu0Yw65bSsx8Mw+R+9ieK3YAYwWka4XwULtiYlvPUPYJyLALtgriIV
 LK1OXgVRh9Vu8y92AXmrcUCWMHbOdGPaSm4PtrIHulT00fa4Dgfvwr2UGF3w1OIDolMugDPT7GR
 muXUiOm+vecwOXbY1cZXuVP6QAQ05OSM=
X-Gm-Gg: AR+sD105cwF4oulI7Af0UAu6WaOkMwJiUSSVJaN6HI6ZFcNoUaSUM967YUD8vibCjFa
 /TsHt6GF5ieZ0NuXYtO3UqB7ql7TXhSn575VzGBlGntclV+O/TtbgKkbHf3XXBl4YMwbPTpTgxz
 ehtTD1wVc5wlq0ALzRvMS20oDP3vYmuSk9LAMuNWuZBSjMp7W/wrdn0R8eHQGqjIahZ6e2VmfwO
 bVLv/bplzBT0EAwmzc9rhaCY/k2WKcJoXZ2x5EVFOhATQ+2KAzzD3/oZeujS0IW1/n4HMRLnKBM
 kMEwv+irhgH/5bOYdFwBrwiQ9uBs5Ko3XNAB6HPnAVANXZ6ZuLWIQ6M5S703RkcoG7jVjsQ5u9o
 Y
X-Received: by 2002:a05:6a20:9143:b0:3c3:76a8:c0f with SMTP id
 adf61e73a8af0-3cc7196e809mr21977099637.4.1786954295522; Mon, 17 Aug 2026
 01:11:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260816-qemu-no-hmp-v3-0-e53fc35bc550@redhat.com>
 <20260816-qemu-no-hmp-v3-13-e53fc35bc550@redhat.com>
 <d7121bfe-a2be-45fe-b933-70190e6a369c@oss.qualcomm.com>
In-Reply-To: <d7121bfe-a2be-45fe-b933-70190e6a369c@oss.qualcomm.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 17 Aug 2026 12:11:23 +0400
X-Gm-Features: AcwNN1Uc-rr3ngzzQTek4XCITnh2PQoE8Xxl3N0fiVsX8yiEiuGMgAondaxDBIs
Message-ID: <CAJ+F1CLhPJiWQR5JsYPCfKpugx3zvKAXDZkM=5vjSdAbNr3+4w@mail.gmail.com>
Subject: Re: [PATCH v3 13/49] tests/qtest/qmp-test: don't depend on
 human-monitor-command
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-pg1-x52b.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Mon, Aug 17, 2026 at 7:56=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
>
> On 16/8/26 21:12, Marc-Andr=C3=83=C2=A9 Lureau wrote:
> > The test was using 'human-monitor-command' (which requires HMP) to
> > verify that an integer 'id' is echoed back on failure. Replace with
> > 'query-name' for the success case and 'block_resize' (missing
> > required args) for the failure case, so the test works regardless of
> > HMP availability.
> >
> > Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >   tests/qtest/qmp-test.c | 13 +++++++++++--
> >   1 file changed, 11 insertions(+), 2 deletions(-)
> >
> > diff --git a/tests/qtest/qmp-test.c b/tests/qtest/qmp-test.c
> > index 3a325a04e07b..927ab053f8ab 100644
> > --- a/tests/qtest/qmp-test.c
> > +++ b/tests/qtest/qmp-test.c
> > @@ -151,9 +151,14 @@ static void test_qmp_protocol(void)
> >       g_assert_cmpstr(qdict_get_try_str(resp, "id"), =3D=3D, "cookie#1"=
);
> >       qobject_unref(resp);
> >
> > -    /* Test command failure with 'id' */
> > -    resp =3D qtest_qmp(qts, "{ 'execute': 'human-monitor-command', 'id=
': 2 }");
> > +    /* Test integer 'id' is echoed back on success */
> > +    resp =3D qtest_qmp(qts, "{ 'execute': 'query-name', 'id': 2 }");
> >       g_assert_cmpint(qdict_get_int(resp, "id"), =3D=3D, 2);
> > +    qobject_unref(resp);
> > +
> > +    /* Test integer 'id' is echoed back on failure */
> > +    resp =3D qtest_qmp(qts, "{ 'execute': 'block_resize', 'id': 3 }");
> > +    g_assert_cmpint(qdict_get_int(resp, "id"), =3D=3D, 3);
> >       qmp_expect_error_and_unref(resp, "GenericError");
> >
> >       qtest_quit(qts);
> > @@ -487,6 +492,7 @@ static void test_qmp_monitor_remove_cli(void)
> >       qtest_quit(qts);
> >   }
> >
> > +#ifdef CONFIG_HMP
> >   static void test_qmp_monitor_remove_hmp(void)
> >   {
> >       QTestState *qts;
> > @@ -504,6 +510,7 @@ static void test_qmp_monitor_remove_hmp(void)
> >
> >       qtest_quit(qts);
> >   }
> > +#endif
> >
> >   int main(int argc, char *argv[])
> >   {
> > @@ -521,7 +528,9 @@ int main(int argc, char *argv[])
> >       qtest_add_func("qmp/monitor-chardev-in-use",
> >                       test_qmp_monitor_chardev_in_use);
> >       qtest_add_func("qmp/monitor-remove-cli", test_qmp_monitor_remove_=
cli);
> > +#ifdef CONFIG_HMP
> >       qtest_add_func("qmp/monitor-remove-hmp", test_qmp_monitor_remove_=
hmp);
> > +#endif
>
> Should we re-order #26 "build-sys: add 'hmp' option" or add a temporary
> #define CONFIG_HMP?

Let's add a temporary CONFIG_HMP, rather than a temporary non-working
--disable-hmp. That should also help with ordering of other later
patches which may not be optimal.

