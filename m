Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88E1ACA5FEF
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 15:27:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDO7J-0006L8-UY; Sun, 04 Oct 2026 11:27:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1xDO79-000664-Kw
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 11:27:04 -0400
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1xDO77-000616-HJ
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 11:26:58 -0400
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-8ab3fd8adb1so7737607b3.1
 for <qemu-devel@nongnu.org>; Sun, 04 Oct 2026 08:26:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791127614; cv=none;
 d=google.com; s=arc-20260327;
 b=akAuIwGyrxD0wSMcPOgT1YFLVokKYbMjOm9Wv/HObmGLhmzJZ0dpui6KOZFZkG/CUy
 9ijWxJHUSMiPlM6tmHNbXeaayt/u6WmTBxFh74jvlq1/8QLRuMjpD/B1lk82JOOl7aeZ
 9QM84j8IN8BxE6A3hvVK1tXsahZDcJFMHVjRHL7jB+3bo9J4haF7BQRz424XCv8uUV7D
 zAL7PGemSEuB0+tJVKTOJv02Af3KXaTIs881pJs13bz+VMN0kx3Sz84y0GxmW2V3QWtX
 HVlzRoBRW7WufoOfEvkSEzUUf4mTCo99Ka3bWiYgWOrHrSdzCo1qJhZQamgorc34Mpqg
 jTnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=OYCf/3IiB3r6J5jKmU00e9JY0kvGwGvWihTLOwfnIzI=;
 fh=/0IC5dMyt1pYrKG8Th8uxNlasmylZbudYuns8eU0grQ=;
 b=lugCddcydLTdj92PtbIpUrhDkxSh+fQ2DJEYUyjY86xJzZc50XO6BPpuSqIFrYBO+y
 OCGaSUpkbnwattPi7KgdM4M3t7Hn0dZJRjtG9v813cu9ZAX9YnFNmEnVKH0DJ1aNDm2y
 iXgIB47ICm9igLsN4loy++QB7ywTVxEAktv/4Qh7fShV+7ujn0MPPqHJb6lloj6Ez8gp
 vPhuj0D8RYZr042LjH0tj6P522Jv0ykQxevRstROwQG2f+RG5PqIfOJVugNL9266bwgP
 hUwm5vyawd6QK/Yah5yrz3rGI11jqkzZ01NUvwYK6bvf0onOLm6aWBJvysY39q+BKcOz
 Eozg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791127614; x=1791732414; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=OYCf/3IiB3r6J5jKmU00e9JY0kvGwGvWihTLOwfnIzI=;
 b=hHx4YbnS9UMsGMELhCRbe6IMDIMIUSkLW1yJJwW7YkifJLnMM/ln0OSoV+Q5R6g6WX
 WzosdsZzKTuqJt+CMvqBO6Ym9qsOuWzgepy0TlYgCowHG2e0E1psG301X+gc4oRlQN/8
 jrKIT4IbxA1H5rIyRzHvTyAaoG/dZTkXSwkb9FaceYZTQPhkJc0hF6WCFhvtLzfZwnf+
 hkD5DFcJ5nq9QKgS2w3vS3LX8L2LnBq/jhZigJp7loi12dcPyXYYioUWuhFkNbB/P8jS
 xb750RXdc4Ie1hkj7pN4MQ6jWdWnS/4cMAR8UhU/jbmWPQmNqDHD0huMCNsO7OQ95Qe/
 X3wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791127614; x=1791732414;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OYCf/3IiB3r6J5jKmU00e9JY0kvGwGvWihTLOwfnIzI=;
 b=BRcL509AyaDJounj1AncfVG470yj2TBO1ttzKTNRbDrDsJeUqWaphaJHTsXYocyfXV
 OtkT5Ueq/oZidmZ6qlMPC425pNdbTbj8LMbnoURcHCylbOSVwlVTo6JepNNnvdRtC5tw
 Vt0ltePz+ngNdM9jx0TiYvsdVehk3NA9ex2tlUfCoOWUFx1FUVeg1uoXOxZ6lItZtYGM
 /8EpMyxz8yifBUl7OdSWMEFcbl5zAzWAoAgKv0J6wsnv1RgHHsV+mz6Q7sIP0S0F3+Js
 w4GjsKOj4WH/YHmx8Trk+msmxS4663LEsacznYlgpXjFsaT/7Exd8UCoFMUiDookRwaH
 EjCQ==
X-Gm-Message-State: AFq9FYJHaToViC24ln62sjmYynxsvXRdN9upH1HCOaSPMAohXE0yaE1k
 L7D6sISQaDTn7GOhHhXVxMdO9jNl6+dg5kprn12CfdpTMCn+ziWZTbZ4AnPsY6duQguxVq6dBqN
 b568A5fXwzBI3ZaMzkWzxfOua7ndLChY=
X-Gm-Gg: AYBFou2SZ9dm/pra/D11EIJJY0EzT+NZDzhle3I5ynCXbs8bJ+hpUgY3EcjwsszIi7l
 dPhCAuQZYiHBkqcXehaAVNA6DwEZ982cp5xrwUIrIfUcoUHivrSVWhnzUJkTuLTLjnwKL161+cV
 UHz4uZn6Gb/C7eoaaPQGcDQ6pN41FDY0TjOa1gXFEmrXJVN6MHi0VLuXSd7KZ+L+9LYarAdyise
 OtWERxMeqX/HQVddYhrQfc0CaQHDFJdKWlR1vN+HwF3LW6OaL5FxxM17xelTA32v+bjcGl1u0xj
 ukTuDBzlpQX8WCL2WkBrdx6DC+ZKuJ1Q5Du8ijEF6VvYqyfJs8sYChgmJtgwMAxus5dOqJYEtG8
 tlbRPduRDhjfZ7PEk
X-Received: by 2002:a05:690c:f04:b0:8a9:8021:5cc0 with SMTP id
 00721157ae682-8ae951f455emr16778057b3.21.1791127614473; Sun, 04 Oct 2026
 08:26:54 -0700 (PDT)
MIME-Version: 1.0
References: <20261004122647.3913-1-shentey@gmail.com>
 <20261004122647.3913-7-shentey@gmail.com>
In-Reply-To: <20261004122647.3913-7-shentey@gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Sun, 4 Oct 2026 23:26:41 +0800
X-Gm-Features: AclHuK9hyi-xQl_dfCb6JkYFBIL0ffw9g2vr7wWM1Qp5GNM04tZBkwxSkG1va3Q
Message-ID: <CAEUhbmX0+nuoRxutdXQvfM02AAMRnazkPv=ZpqA6o9REaUX7wA@mail.gmail.com>
Subject: Re: [PATCH v2 06/30] hw/arm/sabrelite: Have 4 CPUs and 1 GiB of RAM
 by default
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>, 
 Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Jason Wang <jasowangio@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Bin Meng <bin.meng@processmission.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112d;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yw1-x112d.google.com
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

On Sun, Oct 4, 2026 at 8:36=E2=80=AFPM Bernhard Beschow <shentey@gmail.com>=
 wrote:
>
> Having four CPUs and 1 GiB of RAM matches real hardware. Fix the machine
> defaults to make its use more ergonomic and less error-prone. Also
> reflect this in the board documentation.
>
> To reproduce the old default behavior for e.g. migration purposes,
> `-smp 1 -m 128M` needs to be passed on the command line.
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>  docs/system/arm/sabrelite.rst | 4 ++--
>  hw/arm/sabrelite.c            | 3 +++
>  2 files changed, 5 insertions(+), 2 deletions(-)
>

Reviewed-by: Bin Meng <bin.meng@processmission.com>

