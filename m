Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9286FC021A7
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2024 13:03:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqXqb-0002Cb-Uu; Tue, 17 Sep 2024 09:02:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sqXpZ-0001v3-6O
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 09:01:34 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sqXpU-0004yF-Dy
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 09:01:17 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5c40942358eso2195149a12.1
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2024 06:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726578075; x=1727182875; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hKrds9Pvrtw7WZEpg2BKFIbZ7fhWxT/IWcJURY19Hz4=;
 b=iD0luUjpIXxrWeOoulgN6a7Dwh/laNf7jB6XdEwbOLbKgl/BgjRC+zXMhlf6Cd/Myw
 UN7sqtY1FLcSJi7zBqUUWkslLHMmo53wFEwy4o/CoRT+CcLoF79TEmbRMDxV+0xcTfYc
 AdlzO5JnKi0w0PfTp5q0ItgoMFTXK13anzU6X6kxIwrhN+1Y9ZuSKk8Ok5Wr9wJmkhQS
 SbzmMm5zlXLscZtJ7sWAS7ycf2phaCFWwRTjbRLiu9BFbgq+LXAcirwMmkCLYNskh+0T
 WBKwAMC80aTe0itjHSx/YZBIk70itvKFKM0WqT2Kej04dji56iQusq08nH2twPYGXSSP
 sapg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726578075; x=1727182875;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hKrds9Pvrtw7WZEpg2BKFIbZ7fhWxT/IWcJURY19Hz4=;
 b=ufB1eoMprV6d6mcRviR/+V9WnQd3o0hopX40FF7qaS8nykjpm8SaFKB7lGkZ26HWBI
 /Xn42X27bcKs/bZYS23FSJHXOZGMooEeZbwAPsZBGudinSYEjVPJusc36Uz6UXXk1UIH
 ZmJY5rvJsJG7ovpRCyBoowJZsp7nzYL4OS3ZnTWQ/6KwYhsxusuXTUkyrnw+8W6KykiF
 tobSOPR9Nktur7BoulHTI3w53b7cFgIXSnTCY0iyC4QCOEu3oZpNd6oIRO0sQOUyVDmf
 TR+zX2y4r3ebfZu8AZTox7CbSQ5siS4olJFD9fApK5ZJP76ayWJmj2SGWITr+vg3sCVb
 OnIQ==
X-Gm-Message-State: AOJu0Ywpaswct4FkYueH9nL8VZs2qpWecezWRyFrJa+ceWCg7Vuis3V9
 I8aCTlD8xyoDM+sXmC1+KwMZmWbSNrglRDzAp34QBjXKcqL5Lw29T5cyyZ6CqqhE/GhhySg+RjF
 q6a2Jsc41MpGXnkAusnzyAJnpf9yWLg/k5fwklg==
X-Google-Smtp-Source: AGHT+IG8HhY7OmCg5LIGqTYcKUO8nOaHPUS1XZ1Q4+ovc0KMDNXfaAgDZVWoHisO8+jGASknvowO1zw9qXrqKMomA3E=
X-Received: by 2002:a05:6402:5004:b0:5c4:156:7edd with SMTP id
 4fb4d7f45d1cf-5c401602770mr27935888a12.14.1726578074435; Tue, 17 Sep 2024
 06:01:14 -0700 (PDT)
MIME-Version: 1.0
References: <20240917083709.571436-1-kraxel@redhat.com>
In-Reply-To: <20240917083709.571436-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Sep 2024 14:01:03 +0100
Message-ID: <CAFEAcA_rzq9E8i42p=NOvX=Z9SfTsASOzy9fS1BGOrGm3o_U6Q@mail.gmail.com>
Subject: Re: [PULL 0/7] Edk2 stable202408 20240917 patches
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>, Song Gao <gaosong@loongson.cn>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Tue, 17 Sept 2024 at 09:38, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> The following changes since commit ea9cdbcf3a0b8d5497cddf87990f1b39d8f3bb0a:
>
>   Merge tag 'hw-misc-20240913' of https://github.com/philmd/qemu into staging (2024-09-15 18:27:40 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/kraxel/qemu.git tags/edk2-stable202408-20240917-pull-request
>
> for you to fetch changes up to 265c40becab72485caa1f4b1911ce96a98657f84:
>
>   tests/acpi: disallow acpi test data updates (2024-09-17 10:26:27 +0200)
>
> ----------------------------------------------------------------
> edk2: update to 2024-08 stable tag.
> acpi: update test data (address changed due to firmware size change).
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.2
for any user-visible changes.

-- PMM

