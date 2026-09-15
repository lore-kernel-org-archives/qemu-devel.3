Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F121AC88E53
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 14:31:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6UBL-00087L-O5; Tue, 15 Sep 2026 10:30:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x6UBA-00085r-Tw
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 10:30:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x6UB7-0001Nj-78
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 10:30:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789482631;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tjErqrJYDHKRcvTx/TfGCWSx0yK5M6NyHj4g0TjSaYk=;
 b=LI6uXBm46E0UHKcedFqKkFAxDPUN8PPzgXbD5/pX4DDyDOoC8zoczYs6rqfhGubQecB2m6
 T+loANyGLMDWd1LdGwz2JpuyACLHSrGihmpEuKc1OHm5+e5e/zOFkEFoFVp4NJjWQIAOh0
 ylwMKuB8pbbrI7skiJyeKM0/nrrRTAU=
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com
 [74.125.224.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-10-wK0cUt6_N8-oMRg4VzHzIg-1; Tue, 15 Sep 2026 10:30:29 -0400
X-MC-Unique: wK0cUt6_N8-oMRg4VzHzIg-1
X-Mimecast-MFC-AGG-ID: wK0cUt6_N8-oMRg4VzHzIg_1789482629
Received: by mail-yx1-f69.google.com with SMTP id
 956f58d0204a3-6711a336db0so6816576d50.2
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 07:30:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789482629; cv=none;
 d=google.com; s=arc-20260327;
 b=QIMkUupg0PPiNjjsYB1AreEegZSUGso6DdvuWoke1u/+GrlMKhKqgQwHiGm9iKZB1c
 dHaNLKaGP9RiYwFo0khy7OExIxyKA3+sgSL05bTrik/+RBpaG7nYO7rHQbsjt/Pjnjc4
 I4y25LgYaWk0GT0wPGSUS2VbQRoTzRC4G8sf/oZLklcKsLq9uP2kFWOhkGfw2oMWpwrW
 RfEXOPndmfoXDPc58yG7urYtssE5XR03iNW2bjHouydpGBJHIHSvqs1GOYYYjDUNu4C6
 /xZDl3vP7uev3H7JLTH9nJUSJ4SewGCRT5f5Ed4PrS7NB4fOEBmngV5lOMdifu+5viCW
 dZYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=tjErqrJYDHKRcvTx/TfGCWSx0yK5M6NyHj4g0TjSaYk=;
 fh=dFa0GUsD5GokbfMbziB8x6v3mSrfsgy4R+k7qogBrzo=;
 b=J4fuQO96dtdbD3cgJGLpue+yu2p6KxwpYZA80X1Nxq9TJ9w8QUumrSbLNWdpaJO3zS
 XP1Svj+1JN8lufLM0+t50Biey4H0mQGB7s8N/21kByTZKKlBIstxuoFtheC5/901Un3B
 p0Jmv3JE7s/tOAe66/yH1GBEPfebozIooI4bkCJ4xZFpyURyuEDTHrLPYMH+6rp0RCU3
 eu1LpCF7K1DRVTG8ml0VuhEqN7hyNzEKGbNrOswXZWJWwyxTbz5wnXTs/eVR2gqZ/osL
 yoVmleVa+k8p6HIIZaGxWOWvkoI34RA2aaklRxfTrXrubqUTMEfHyEuHgFEm+dDfYN1B
 b/hQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789482629; x=1790087429; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=tjErqrJYDHKRcvTx/TfGCWSx0yK5M6NyHj4g0TjSaYk=;
 b=mfXr/cr6B48sVmyPho0zEKb34hOX8h/In2OxyYRhK0mMlU0vZo5mcxlL1OXUELj5Xa
 hZ3EkHfd8KOYN9h2JEalmEecS85qV6Cw12lW1T/kZHd6vrgKnR1IYpK8YLBXK4iyJeQL
 gGcDHmQDDkbf1QhlqrP9mXaD5piIrAdi64rSpK6jpdnfnXbzG3Oxb0kIsSErkLLUbUKG
 La68nPWJmdGypkszks8FjWeGwqvGfKAG959aYqC1p9PfS6a6Obqk7GyGURQjp6S9+YdE
 76CRxONYAIQTSnwCf0IaCHcMe/ARNMhZ/L5Fn4GXHr2hgP/CrNn1DKvQuLCctbouKv/E
 xyqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789482629; x=1790087429;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tjErqrJYDHKRcvTx/TfGCWSx0yK5M6NyHj4g0TjSaYk=;
 b=p6j3COIERaZrshhweAvBCp7ehz0nvTqI9sFMQ3YQFdt3rYHhjr90sOHE6iS+fChd54
 9W9Lcs4pAyMXkuWBsD2pNo7pSTiRGL+MkYunzxz2u6v8582LOnma4pMJUEu/SF4G8fXA
 dp6sIS6/mKfqYZ/qUQyoMdYTZ7PfBMRdUPPrTcBiZmdbPP4Vp1nXCv+VcQ+TJUea/McF
 sE3U5MvNYQvuE/oAHRBbdwObh/ony4FQhwz0FQmSI4BU0YLYXI1DHAyJqoSYLedmMEX+
 zY04hsMXU/kwStFUDootKHkWhPgHonoTJ6jRh3QeVXwTFXautoXZii3onvdmvagt4lrM
 FJig==
X-Forwarded-Encrypted: i=1;
 AKwUvBytHWP7Zay5ZvxVZOamGxoUvNVVWs4PqQRXmByERHP1LeKGwPwVEFS95Vj+8uxj5hYBNJZlL3ixvVen@nongnu.org
X-Gm-Message-State: AFuF++mZ7ieCKnnzZh5IwwFq8NPuxxGAubqxfVuQPz1+3kvv0GFXf6Qf
 laPHv9o5d67JJp8ZyEVZwgKtv1Q2IzOhK6BUCcwM2FmguyjHp21posYMEQvVqfGwdjXw9vyFsQt
 CfWtOkr3294VEoXunBKJ530P1NkXM/0xhBgRfF9jorUqQy8XwqaLbVYiVJjg7ca36NK17CtOSh3
 X3lPUP1MBrvYEq9jnhQb4xZO3bwP1I+G8=
X-Gm-Gg: AYBFou1cdyksfLysH9oLh2rUCWiREelrROZwOZ7aMDkcyyPfwL88WjqbjKfoD6GqDM6
 /tO3OqRp3LvvOhnVQALaPEoKS53mbgyg9idep0WZn/Y/uqUSQJXW+G/9CExPfHVuL3YZMDvJHtf
 /mdN7SSLhc187sMV9CySe9HMqqmzWxmXNxmiR7o09maY+5AEegxOUrxFufuAireSK4bbZ79UFAq
 7LE3gY0hduVrWAY
X-Received: by 2002:a05:690e:144f:b0:66f:c1be:84e3 with SMTP id
 956f58d0204a3-6714e1ed9dbmr2334590d50.81.1789482628620; 
 Tue, 15 Sep 2026 07:30:28 -0700 (PDT)
X-Received: by 2002:a05:690e:144f:b0:66f:c1be:84e3 with SMTP id
 956f58d0204a3-6714e1ed9dbmr2334548d50.81.1789482627987; Tue, 15 Sep 2026
 07:30:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260824114216.231916-1-christian@quante.one>
 <20260911145309.47164-1-christian@quante.one>
In-Reply-To: <20260911145309.47164-1-christian@quante.one>
From: John Snow <jsnow@redhat.com>
Date: Tue, 15 Sep 2026 10:30:16 -0400
X-Gm-Features: AcwNN1Xitwxk_sDqsaXaobCJ3nDaYocGq5ZVe_neF7-ROvcdJOccneSDp6VknAM
Message-ID: <CAFn=p-Z-b6a5Z7V01pfWAR8gKpdt-v3DzzpkY4et6fpVHUmUHw@mail.gmail.com>
Subject: Re: [PATCH] hw/block/fdc: account for read and write requests
To: Christian Quante <christian@quante.one>
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org, 
 qemu-devel@nongnu.org, "Denis V. Lunev" <den@virtuozzo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Is anyone looking at this, or should I be investigating it?

--js

On Fri, Sep 11, 2026 at 10:54=E2=80=AFAM Christian Quante <christian@quante=
.one> wrote:
>
> Gentle ping.
>
> The patch still applies cleanly on master (209b2afaface) and fdc-test
> passes with it: 16 ok, 1 skipped without --enable-asan.
>
> Thanks,
> Christian
>


