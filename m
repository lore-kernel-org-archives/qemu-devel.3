Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85A0CCCD1AB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 11:51:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBXMn-0007jo-Fc; Wed, 22 Oct 2025 07:50:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vBXMm-0007hU-69
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 07:50:56 -0400
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vBXMi-0003rp-FT
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 07:50:55 -0400
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-784966ad073so45312057b3.1
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 04:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761133850; x=1761738650; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wYNtjsVMvszdoj9Jt0oH1SPp7y+wTPBy9VWR/t5hIgA=;
 b=Uo50Zlvam9cz2+82yY4691DqgFhcj2Iq6/V+Sn345hbmzVlrPvT+mSEkYxIj7YOIKj
 nboqP2Q447gvr03ZMcjVxTrRXI/oNbd6Wt7xNpDZYZE0qWLAP2REWQIzE4g7RkkpiREO
 DfNLt5k7SKifZgopk7CKIsPJD0Q8OljWuU3c6yn4/fTtlnYPZ6B8xEvhyUAYscq7SLr1
 MTTqZ5RXekY/7tWIq9OAF0/J6otAyT3bPuojBnoYwpwytVT6RQn3t7gKj8JUkYLl6npx
 +3QqLIf4wk8n6aRg5PIHp782+y2XjLoKr7fwFKRStgpIxTbCxNDj/h1McjuoJkU3OFSS
 hd4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761133850; x=1761738650;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wYNtjsVMvszdoj9Jt0oH1SPp7y+wTPBy9VWR/t5hIgA=;
 b=LUfHzbUVVCtH3KZxFXMPn4Et3P1HTtFeBTrsWq98oKbYII6DmIOxEaGKgo3Tb9Ufr8
 Snex7buU3IFpWGC66G2wUT/vZUffom9vUSRNMYHLqqlTzIF2TE6q4B+wjSHmKcoyafgK
 7NmWaiOFDZip6/4dczXHFkSodxhMNxL/KGo0Xp3YRIWbgqOTv0bY/n/E6F0wQxJj9hte
 sSedaiC7LIHE91t/q0dK2aNbWumu8osP9sgJD/ehrPLZN933V9YubBqpubQMNiwsV/MK
 LoaWBsP18GDzJcd72QDoeD/YhAYmoufeeVuZIWP9vP/Q0p6eM56fwXyl2aGGGCK43HLu
 L/0A==
X-Gm-Message-State: AOJu0YzBx9LvWDXImOn04f8gfdcnWd3020DvMnQ6uyIJdChIG57n9f+v
 rpSBzB13pp25VRPw57gEE0DVVTd+YW4Ic7Lh55fNUpjtfTD/Od6za7xJ5F2iUmy8Q4lB47UfZaR
 /gKrwI7dESryU/QBAFlvoAeRbsJvHd5P1+noO4WWSYQ==
X-Gm-Gg: ASbGnct0shoHO/st6s9Ovg5MEt8jlVcJVHYWSLKBpBPhKzaczHK0nM+n4sS09fBU5cJ
 kXBzIuP9dMkA99mECbTpcniglJU1CLVtXSPMB4NVopFVTPiQxzzdWap31zR7JBOWjPyJybQi4af
 SxalSmtV0qzT4yYO6nBVOjHHJ7cdj8SECXfqUXwINOzSLEH+b9pixBtROcPBtx0pqcaGA4oRKTj
 SZoLLOLWspWMJKaXvkhoDNniwvEMhc4T1Jt8J5cu/xIPKutiydsVmXS9uzJUg==
X-Google-Smtp-Source: AGHT+IEDjXij1tw5GXjjZseQwbkws1Zpkbm30dNkmjFji58zZKa/tMq3kDeRtoUXQm68u/l4lj9lYAkODgCyS0WiBWg=
X-Received: by 2002:a05:690e:144c:b0:63e:3084:4809 with SMTP id
 956f58d0204a3-63e30844b2fmr10598929d50.33.1761133850423; Wed, 22 Oct 2025
 04:50:50 -0700 (PDT)
MIME-Version: 1.0
References: <20251021205741.57109-1-philmd@linaro.org>
In-Reply-To: <20251021205741.57109-1-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 22 Oct 2025 12:50:38 +0100
X-Gm-Features: AS18NWDnNrVzi40OCE3sR3euJo3fyyOr1VvT4KwJxHaELlmKQullAI18OrBq6Lw
Message-ID: <CAFEAcA8A5xa0nJUczM_BDCvVu+sP-tdbt_CxDGos6hKW27qEZA@mail.gmail.com>
Subject: Re: [PATCH v7 00/19] single-binary: Make hw/arm/ common
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, Anton Johansson <anjo@rev.ng>, 
 Luc Michel <luc.michel@amd.com>, Zhao Liu <zhao1.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1133.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, 21 Oct 2025 at 21:57, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> Series fully reviewed.
>
> Since v6:
> - Addressed Jan comment
> - Removed aspeed/raspi meson patches

I'm assuming you'll take this via your own tree like the
other single-binary stuff -- let me know if you want me
to take it into target-arm instead.

-- PMM

