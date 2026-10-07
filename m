Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45E76CA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 09:22:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xENqh-0002G9-1N; Wed, 07 Oct 2026 05:22:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xEN1G-00005z-VJ
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 04:29:02 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xEN1F-0005Pq-5X
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 04:28:58 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-6aaebeadf3cso2835510a12.3
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 01:28:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791361734; cv=none;
 d=google.com; s=arc-20260327;
 b=W8+OOCzn+4n5SFQfm8xeqp3Ji/v7gHGu43sB/jU7HI0hffpdJB5mnjmpUDN3rkaWSl
 FhmKHnCK7WiWAttd07smmRl67kGS0YyWOAzwMxWLV4wootzFtQQINnjBjwaYmGgNMNg3
 3TRpyfeI6w+PZSXBDPkD/8WRX3K8M6LzhpLtamMVgRRu7dh/hLuT/OVMrRyV7e+ZyD29
 hl7DvWCr5W+c03Z/4Q1ipHmO9vRaB3X65yNk1o2YVMKHwqvD4Da2TlzUwXyriRd+y7NB
 4V7tDUzEQ8Oy73F3ZhpLaXMlbzGJKluHON6Ea/dT7+ptBskDPiLiRj7grDJQl09Mr97x
 rsXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=8reDbp3SERMlwQfdTytdF18ukEF4iZ1d1eSqho3mC7o=;
 fh=gw/ZP+CD7zbnFpSub+wk1ew+uvTBbZRAycyPRx8LVNE=;
 b=O2LtiQGoFvrN3T1EE7Tg37eigLCL0G4EsPb3obCSU05Dd3D4mN4azpoIHJMmQk07Wq
 r2femR5cqSi9DTiIH9VXjtqPHuYZSaaxSZXNFFNdF2x1H4oK5CH+n92sd3Dr4zB445+R
 HRHT+XxOttW/yvkY7fYc8YtkBOy9u1shA+tXYJIkM8pxoYAKswBpEIDK0mW3pm0VqpY9
 RNnOCW/SdnU4jR1PWLw7eq3hxgvOPF18JthDYC0Nr0DolTOJisFl0cIhjnEmoPOML4hs
 16YXNPI05mPa1YiCalVUTRxWhguBoh5Ol5nnUVJUwDXuSbphDeQvg2cHi5/y129T4wF0
 HlFg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791361734; x=1791966534; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=8reDbp3SERMlwQfdTytdF18ukEF4iZ1d1eSqho3mC7o=;
 b=dfIPjFNJurYI3BWx8lkZZFgj1XPAsMUxqY+WFJYH4a6VgSL29y9QA85TVMSrqrUZ+L
 dLXb2rvRK2C6KtnJxNn4YS+WrU83q302u6npixGTnNm6pUUaGXOG6plK/w08wGAv1tzd
 MWixuFsyZdbv9et8cQ/+5XGR9l5bc10+SHBTqy49V4ybuXPB4DnoWSmwm7p7yDbeWanp
 kobztQN3djeFxFbd/WSMHqCmaUcX3CUDTvOQrtkWhzRr3MO6qxEpNpNbr1yf8LQS5CHe
 V8xPZk9wzBFaNoNyU46DHUXVpy2uAkUSg3IjVbwSGdJXAqd6e9B0HgYD2tZkNG03O6La
 de4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791361734; x=1791966534;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8reDbp3SERMlwQfdTytdF18ukEF4iZ1d1eSqho3mC7o=;
 b=Gqneovu0HC6SAP3dodmezhCamlgOgLN6MSJQR6hdzxkUYu1yQSMHbu1F2Igl/WoGs2
 yoc3PcGWNAccl+iQk1haVINjEU9eONbP8yxKAfp3TDSAg+MA/MzmLsUtWLBStrS1Ef50
 y7PYI0o/AdpzjiDDyOoeYlvuod6QgvYjjt/jRd50FaeyIWwkzdWqvalNyp4Sx/KiJnQX
 4UbQTYnCmzTQtNgk29izaYDsN5D4HZ1i7WeNfGMrPrkB1fIvIN8y8vI3yAI9cIYxiDT/
 nCA+qBFI+CNvDiAbApycxDhEe28ckPOGqsXynPZfGSSEp0hddDrr/fAJWj204m9Cx7ax
 KhGw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwCcr+cZJH6nOGZKoxnJvwNmbH6LP9qGV4Vlerh/Uo4ceZN4bThlG3OVWk3iljM9py0o+e6zaQgAFbo@nongnu.org
X-Gm-Message-State: AFq9FYImm4bCyNL7rnzXkLYhjoQKkwbnT/v67h1/6bftb2onF7fJKWt6
 4v6v/d9Es0iLWFrryXvQ2nu12G3PAAjeqC9D+NmAgaYtr4lh/3zJyDzIgq7LfPv7MXLM3FLSHtM
 Rsbj+8zci+c1ZAKV9iMEt88iHvRXTVk0=
X-Gm-Gg: AYBFou1gS3gTYvzoLidAWKRUuC7Q1Dxu3cPnWUTJbecj5RpYJmDDH/9go1zYMNQmB+2
 YXbYEwjmccV35OTBdKD1qQtQneV3w+Xyl3se2TBCN1AZjCH54OPRJfWvVROVwWNCPNKINUvgK44
 t5SczjzaUVYVEwQ6M+W0V60lRsUVsps8k1i4fw1BfCQAt0bLEyKASGftYwukmxPvHjYt0K/lWX2
 kCzYTQ7Kc6labsjNcaTIvjZqQT0QGqS4e8mo78tbKgLJqWcGSNYiV2EwzS15oNJhwnCvwjm1sC7
 SXvE9DeqeoY0ifa+O0EmhoO+Jc+/u7+IDKxLoAsZamRDu8mhJRsE2bk=
X-Received: by 2002:a05:6402:21cc:b0:6ac:8de4:2804 with SMTP id
 4fb4d7f45d1cf-6aff375d5d3mr1120579a12.1.1791361733761; Wed, 07 Oct 2026
 01:28:53 -0700 (PDT)
MIME-Version: 1.0
References: <20261004072927.1142-1-luoyonggang@gmail.com>
 <0b84bf4d-3b98-4f52-8847-9f89bef92c1e@oss.qualcomm.com>
 <CAE2XoE-joWZwrBy-jLe+=ZP7OGM9cyDrF_5hz7koVPODeys+JA@mail.gmail.com>
 <b2297f92-a685-4399-a755-bbe5a37b9b3f@oss.qualcomm.com>
 <CAE2XoE-4Pdp_n3RgpqJ5se_KTHniMAJAodTLmkfV+0jjou=M5w@mail.gmail.com>
 <c6bd8e8d-3160-46c2-ba4a-2f5a4b93cf38@oss.qualcomm.com>
 <CAE2XoE9PKNgE1Zz_frOq_DrgqrPL4B8hcq0xO6ywCNTeUnFLvA@mail.gmail.com>
 <63d20cc8-8003-489c-9f08-28369a2f71e2@oss.qualcomm.com>
 <CAE2XoE9uqEcjMsqJXu6Cr+MrposPjq7O6Lnj5cj7uW2nF38uAg@mail.gmail.com>
 <15e9a768-95bf-45aa-8175-1dbd73d5ee04@oss.qualcomm.com>
 <asT-GoQ6xH4-dLET@redhat.com>
 <95c99cac-ae83-4bd2-ab09-51c2ef9f1259@oss.qualcomm.com>
In-Reply-To: <95c99cac-ae83-4bd2-ab09-51c2ef9f1259@oss.qualcomm.com>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Wed, 7 Oct 2026 16:28:38 +0800
X-Gm-Features: AclHuK-SPEjB26qksQvd6pErtU-9619E7jTUfk-8RZI8SA8ncZ6YEkpqaALUodM
Message-ID: <CAE2XoE8fU_dkJ+SgUoRoS0F9=OJL3P0+x4-E2aOTcYbda9uaPw@mail.gmail.com>
Subject: Re: [PATCH 0/4] target-info: preserve full softmmu target identity
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org, 
 Philippe Mathieu-Daude <philmd@mailo.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=luoyonggang@gmail.com; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_SBL=1.623 autolearn=no autolearn_force=no
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
Reply-To: luoyonggang@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Oct 7, 2026 at 3:42=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
>
> On 6/10/26 15:56, Daniel P. Berrang=C3=A9 wrote:
>
> > Current git master is exhibiting a regression compared to previous
> > releases.
> >
> > For example on 10.1.0:
> >
> > $ for i in /usr/bin/qemu-system-* ; do echo -n "$i: " ; echo -e '{"exec=
ute":"qmp_capabilities"}\r\n{"execute":"query-target"}\r\n{"execute":"quit"=
}\r\n' | $i -qmp stdio -display none -M none | jq .return.arch | grep -v nu=
ll ; done
>
> > /usr/bin/qemu-system-xtensa: "xtensa"
> > /usr/bin/qemu-system-xtensaeb: "xtensaeb"
> >
> >
> > but on git master:
> >
> > $ for i in $(find ./build -type f -name 'qemu-system-*') ; do echo -n "=
$i: " ; echo -e '{"execute":"qmp_capabilities"}\r\n{"execute":"query-target=
"}\r\n{"execute":"quit"}\r\n' | $i -qmp stdio -display none -M none | jq .r=
eturn.arch | grep -v null ; done
>
>
> > ./build/qemu-system-xtensa: "xtensa"
> > ./build/qemu-system-xtensaeb: "xtensa"
>
> > so we need to fix that behaviour change for query-target.
> On a side note it would be helpful to have such test in CI :)

I have already done that in
https://patchew.org/QEMU/20261004072927.1142-1-luoyonggang@gmail.com/202610=
04072927.1142-4-luoyonggang@gmail.com/

Check that query-target reports the target identity selected by the qtest
binary, including softmmu variants.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 tests/qtest/qmp-test.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tests/qtest/qmp-test.c b/tests/qtest/qmp-test.c
index 927ab053f8..c70f6a681c 100644
--- a/tests/qtest/qmp-test.c
+++ b/tests/qtest/qmp-test.c
@@ -164,6 +164,18 @@ static void test_qmp_protocol(void)
     qtest_quit(qts);
 }

+static void test_query_target(void)
+{
+    QTestState *qts =3D qtest_init(common_args);
+    QDict *target;
+
+    target =3D qtest_qmp_assert_success_ref(qts,
+                                          "{ 'execute': 'query-target' }")=
;
+    g_assert_cmpstr(qdict_get_try_str(target, "arch"), =3D=3D, qtest_get_a=
rch());
+    qobject_unref(target);
+    qtest_quit(qts);
+}
+
 #ifndef _WIN32

 /* Out-of-band tests */
@@ -517,6 +529,7 @@ int main(int argc, char *argv[])
     g_test_init(&argc, &argv, NULL);

     qtest_add_func("qmp/protocol", test_qmp_protocol);
+    qtest_add_func("qmp/query-target", test_query_target);
 #ifndef _WIN32
     /* This case calls mkfifo() which does not exist on win32 */
     qtest_add_func("qmp/oob", test_qmp_oob);
--=20
2.55.0.windows.3

--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

