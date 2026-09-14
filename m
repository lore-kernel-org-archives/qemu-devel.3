Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63025C88E64
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 11:34:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x64wE-0007BA-Ux; Mon, 14 Sep 2026 07:33:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x64w4-0007AW-89
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 07:33:20 -0400
Received: from mail-yx2-x11.google.com ([2607:f8b0:4864:41::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x64w0-00006r-7F
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 07:33:20 -0400
Received: by mail-yx2-x11.google.com with SMTP id
 956f58d0204a3-66e56a1fe3fso1392636d50.3
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 04:33:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789385594; cv=none;
 d=google.com; s=arc-20260327;
 b=QMU7kH2/vEsJBbxO9BEIiJNr22vDhQCNBoG5oNm3pYtBvmok9dlGoaeUPqETY3vLA9
 9VhHDSNpmNyepsjMxXJbAJKc+0IDW9XSulUmmbU/YqK1Q1Ph5RZtISlnoBdBIPeVzWoM
 jzsT5kYZqMtJGLIlQgOcksIlrG1i93HbMVGEAiREO9p635iqoAqgOJDCIITWrKUHRASp
 jpx093qnLxAmsPuadpqewvpUq/KbO14SeZE9ck28b7TgpJmsEnz2INbnBwnlKLi76XB4
 Y5+gI8yrcRf1DXkd5xOetHrK9Ez3ve9Ep48YDBRP5mKjT7pkD0q2Cz9RhyZCFxAFtR0i
 4C5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=46tUkjWcsGNE0/IRMnS9oYK/PTTMmBusYPYi2kH+L/w=;
 fh=I4+9jBsawlEC6VYtYQWWbwhwDHCjIcQfIwimnV5OqlQ=;
 b=hGCsqEUl8vLrOjzp/mqwQKxdD0Cu2V1vcKuF9WbRyTe1+PMjKPiJS3gM++b3B07YtT
 CdKyH+HoBosypLrT4XN00yBfuCXpDBVOiN89LXL7fqCmjvwe4nCDw8UFU8y1LJ7bNig6
 +WhUMlvXp5Tj1h2FWqOxW+AcEkFtK3KqhI3UjfblfHZCM2CT2QL3jAkq8BBG2mxZriZ6
 Qw0FyeP3yrQYRlSmv2F63P+lWXmMncanBFJ8JbMKCf9X62CrDsGtE+OsN0KV1MpYe7C0
 X/dJo07mpTXrrFdjjdHiztgamFjA3pSf+gYRG3uqamk1WCGuiKo024kImGb7fUghIKLZ
 MQWQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789385594; x=1789990394; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=46tUkjWcsGNE0/IRMnS9oYK/PTTMmBusYPYi2kH+L/w=;
 b=Vvwbcanhf/SjcVECnsy3Ho+U+sw4zZWOX70lqMeQeU/DSlROBW9FxKTSLnt44zK1lj
 5yr5Ns10qQ6CL0KhWnQuUz+wR5qjOiVNUuoF5wdU+2+Yhn6RRZb8nieJV1OYH9lR+o3l
 K61nXD/msY9/kOfjwwzbS8J6KHgEaQIP0De1CfBRIm9jb8m6Dk/tLYeBKEn7AgtCBAtw
 UYmRlmiXPRmYL7BnxZ5Rmgos0N16SBHAu3mp0Fg+tWv+M1HbROjwnatdMmcKyGZcjouG
 5pLp8qUR5qO54RiqTxu0HvIuRYMYrArLcZHzNczCu7csEnuhfhQ5DKfbUbGzK4hTQEhR
 YNhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789385594; x=1789990394;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=46tUkjWcsGNE0/IRMnS9oYK/PTTMmBusYPYi2kH+L/w=;
 b=NAQtJUMwcax/IDG0lmiVI0dpTVjrYc3nvatJvpJxXJ2dgK+gB45Tm/j0zPkkEqTFhw
 bi0KWXCldHmgqIRyzV+MZV69Mqei9aGIdKcwBJ9CQzPTJnYUmiJtR3ByzNzjrUxDCdkx
 3hq6u5NUkyAeFgJpqPPJNQfC4supWYor972b1ZCXMdlDjC1vuM8hPnA20MW4qCpQpP5M
 1ZyqKgj0QSRvfrLyZv5gbo+TMvrFTf3630QWNIGaRerzIy5ntzZtirFNVDcejgq+STDq
 2nknlu9um0kzEPuwMaWNl787xwK1+Fh6XqZlJpSqSceY+MFb/w86c0YxOAHUnQaUQ8Ck
 VqlA==
X-Gm-Message-State: AFuF++m6WRpkiGiVQZk80yJf2RCiWIFk04IJEnSYOp/lIdOuG9EehO6z
 8yFxKLhu+pfa042+Zi44Gww9m+JSxXaY2FrNYLgqgi9MIqOuW/QHYNtxPLdyshMopLd5YgAcIWj
 cn4AtntLL/WoNwhSyAmliAzipAw3qvgGMwEthfJih2A==
X-Gm-Gg: AYBFou1JJHN7cG5MTqroMEOMG3k8vIWOQasXaLqld4UVVv+6b++bKt4roHJlwkV1ct4
 uDTrjqOvnO0i6c3pmVJHCo3Qc0K/uuEMktRVxIS5g6ygOIZDC2vDMfPZpmSfM9igy7gHoE+/SLd
 sJQ3jcpqYZaR+KvEndroqSz8bL/NWl2pu6gDd+WnTYQHu1nWETT9mEwQxKGDuenSP3QonwWsExq
 mAAx+G6HSpdCI3nFptZ4rT7VNmWOYK2TuKsSAodhMNudWi5aO3wpVcOG/CHmHe01Mk3eGecRTJ0
 xHLtuS8Ff458epmv0pV4dWRCSYuaQzIa+pR46Xps49+72MoDva6fAGO1uTO38yZgSR78Wv1y3Ry
 84ZjVdUb1hjc1l1Sna2z6kfXTnRwebIZEGJq3w77E
X-Received: by 2002:a05:690e:118e:b0:66e:5f04:f755 with SMTP id
 956f58d0204a3-6714dfdb4b6mr367008d50.22.1789385593677; Mon, 14 Sep 2026
 04:33:13 -0700 (PDT)
MIME-Version: 1.0
References: <20260906-nohmp-next-v1-0-2b21e63974f3@redhat.com>
 <20260906-nohmp-next-v1-5-2b21e63974f3@redhat.com>
In-Reply-To: <20260906-nohmp-next-v1-5-2b21e63974f3@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 Sep 2026 12:33:01 +0100
X-Gm-Features: AcwNN1VVWrzTvrwaBlGfxk22-gnj45fSpuFI50FqYw3ztakj9uVsuJjmq3AI4Xs
Message-ID: <CAFEAcA_vhcyjv02=XoLbtJSQzz79mOuBNgerPRnGxyRw6+cAeA@mail.gmail.com>
Subject: Re: [PATCH 5/9] tests/launchupdate-test: correctly release qs
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Brian Cain <brian.cain@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 qemu-arm@nongnu.org, Ani Sinha <anisinha@redhat.com>,
 Gerd Hoffman <kraxel@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Jared Rossi <jrossi@linux.ibm.com>, Zhuoying Cai <zycai@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Jason Herne <jjherne@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Halil Pasic <pasic@linux.ibm.com>, 
 Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>, 
 Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:41::11;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On Sun, 6 Sept 2026 at 09:54, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> QOSState must be released with qtest_shutdown().
>
> Fixes: 0b70c6ce7b31 ("Add functional and unit tests for the vm-launch-upd=
ate device")
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  tests/qtest/launchupdate-test.c | 14 +++++---------
>  tests/qtest/libqos/libqos.h     |  2 ++
>  2 files changed, 7 insertions(+), 9 deletions(-)
>
> diff --git a/tests/qtest/launchupdate-test.c b/tests/qtest/launchupdate-t=
est.c
> index ed007cdce29f..12a09079ae91 100644
> --- a/tests/qtest/launchupdate-test.c
> +++ b/tests/qtest/launchupdate-test.c
> @@ -51,7 +51,7 @@ static void test_vm_launch_update_capability(void)
>  static void test_vm_launch_update_disable(void)
>  {
>      QFWCFG *fw_cfg;
> -    QOSState *qs;
> +    g_autoptr(QOSState) qs =3D NULL;
>      VMLaunchUpdate launch_update;
>      uint64_t control;
>      size_t filesize;
> @@ -95,13 +95,12 @@ static void test_vm_launch_update_disable(void)
>      g_assert_cmpint(VM_LAUNCHUPDATE_CTL_DISABLE & control, =3D=3D, 1);
>
>      pc_fw_cfg_uninit(fw_cfg);
> -    qtest_shutdown(qs);
>  }
>

>  static void check_error(void)
>  {
>      QFWCFG *fw_cfg;
> -    QOSState *qs;
> +    g_autoptr(QOSState) qs =3D NULL;
>      VMLaunchUpdate launch_update;
>      uint16_t status;
>      size_t filesize;
> @@ -149,6 +148,7 @@ static void check_error(void)
>      status =3D le64_to_cpu(launch_update.status);
>      /* should fail with LOAD_FAIL since it was not IGVM format */
>      g_assert_cmpint(status, =3D=3D, VM_LAUNCHUPDATE_LOAD_FAIL);
> +

Stray extra blank line.

>  }

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

