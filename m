Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C891C5B572
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 13:21:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtmQH-0001oW-7S; Tue, 11 Aug 2026 09:21:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wtmQG-0001nh-6q
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 09:21:40 -0400
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wtmQD-00073y-MF
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 09:21:39 -0400
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-8200b55dc47so41117567b3.3
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 06:21:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786454496; cv=none;
 d=google.com; s=arc-20260327;
 b=gIFrNiPbMBIVwTUanQHE2574RLp3PbwNAOa5pbFwxQT/gLdGyM1f3un8fPhAmI5+US
 8u3Qbi1mI85EM5NCrUShYavfAjS86O9mV1teID5Dt86JiqTyZMBCOemgVCG3s+s052Qu
 EYRHDTBRKFJWcJdSw5TDb9TgNw0Zvu4FEQFDJM47KICUNgltpDTCGFjJf3oZMEdGWd6R
 CZsv+FbJhTyVYAz+bXZx2fD0YKYvF42zyfSQQJF4n/lAuMq+duNrNY11NxUMJdU4ovHV
 l2YxeSiEXGD0KU1s5YVmy5NXssvfRqK66RRq1K3yg3OcJcme0A+iMm2TyWKP4Yw26Tpv
 DqZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Z2R2x1gYsSkkO9yf4+gJGUKBXhfDrKpSSJsTpfkIVDw=;
 fh=Xpa6efb5XshLLxQDMJx+ki/cRscfYHSO5/O4/GqD30Q=;
 b=jyVp7Pm9Gp+FsLcuSfdz23zyrLjS3ynSYjW6KPJFPsPFjAzmud3x1jCwwE+g6XuCUp
 Ptcj7xBDgDK0NyWMMPn3LaeG+AeP1powuvdi5NxMM78mmjsP/F/dzOtsP30j4h+7Zj2l
 zFinOSNS9GtsYnImDUbNKXskSry5JfThnNC/Kf4F4z/Hi2IvptxDVf9yZR1sUaMI0SYT
 sEJzB/gZbxLGWGsn714r22T5+qMTpwvfzG/DdLStPZcnLT6O2fjM5qIabX1QkIPrEBwe
 MoT2GW4ATOv1/Ac5Vjal/FZl47NL+9KRb9tutLayB0V+hPVf+MU/EZ2Km68wbpOZVJVm
 f2zg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786454496; x=1787059296; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Z2R2x1gYsSkkO9yf4+gJGUKBXhfDrKpSSJsTpfkIVDw=;
 b=ocY6weBpeRlyl3ZBO1M/ampHDi7YJkJnBrUygEaT9M4ggvn45/rzLDWNbpFc3agVVZ
 ju7DWPbbfZGVrzMNxSINTnhMdMGbWjyIYZG3GTLfFG6yNz4o1Q/uxabLIR5yQ9xOOs0L
 obUbya2l42WNrpLjqInAo5uY/ECTKp+b3Lr+79E/SMZur17AyANDU4DGunk7R6uRG50P
 cTAyJgpsWKm+oEwrufD/7hotHdE2BYJpFKxNy41btne5e+MdRDtU0FQmdVcJwAyjX3Gm
 q/oVsECU++Cyhn3KwKfnabe4jQuS/6LitDdZoO06YmX2LCm/5mTjIgZlU15wCXBxTyLe
 vZ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786454496; x=1787059296;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Z2R2x1gYsSkkO9yf4+gJGUKBXhfDrKpSSJsTpfkIVDw=;
 b=QryqfUe1EdhIO1q7gInqtj3yurBiCeIRUbtHMRR4G58JpVGwwhAbh/KAuTEijoT/qh
 KvuMQt2vGhi8ff89xPlD5bm0Vi7fr67i+3EOWBPlX0wHoTlb18zNIHrcPQnuxuBTSK/p
 Cg1KlTuqc5SR0wa7Q5Nb0+DCT97pP3fXDKsFLu6alTLtxyGeecIcQvppp4zMw6+ayHf/
 BK4SzOFGTaYyeW+7oY1PnzAe6KlfxeNZpt7oyy7LJ7U83xAItQCMrAlOvcycHrTSKF3S
 qiVQ1BBO+GJjEiMA6UT5BFY1Gvf+welJEUde2wkwN74G3cEYPMqbnZKCXJVxhXkWrZC0
 JWpQ==
X-Gm-Message-State: AOJu0Yx8zsdQWV4uL3yoQ1l01aKTWhtqvGkl87wbryBJT+CIpi7cDyov
 IsTAZR1GuRan5wQDGEuV9YmPK3tiYjxznsLC1zDCoGFFFeeMfr45vwKuoAFULqrFYC9diJaNI/9
 EnxpiLXhA05kEG/qDxKjh7xICSkVqxmWlGAeZdImblg==
X-Gm-Gg: AR+sD11UhSsQn4WP91Oz1V1Qsa3F5Q2wBYF9yQxEOdbL3NvB4emwljsP/JOgy0zWdwT
 qeyzHEDIxkCrsozXq4P5egsWoMHy/cmR63/l4Sd0S0MZgZ1It6Esay7nhmCNCwU9jrMLslGmvG1
 cwnBpOU5XNoIiiphJfYkbsE1qmEMsPzd2XzkEHwTgHOrA2gWYxSzGwUg+VALMI3TkWPvP/Q1Kp4
 Gr562lj+TYDiPPm5rx3BuqRV8LAggCBqHFpW8b3S3TbS5uebrt0U3bRla2+YlQf2YeEn0QqtsKj
 HBx8Fu1A0X5VZROS4j5oVW4fbbeRoIU6swcC71wg7yGKuA6s1nGpV+3T4Dy8axksSQNx4CqDRNa
 nlV+AkfMzBUiFlwS08k9/chTf1ajJ
X-Received: by 2002:a05:690c:c0a:b0:7fe:1333:c745 with SMTP id
 00721157ae682-82f2db9920emr22010437b3.27.1786454496265; Tue, 11 Aug 2026
 06:21:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260811105425.7429-1-philmd@oss.qualcomm.com>
 <20260811105425.7429-4-philmd@oss.qualcomm.com>
In-Reply-To: <20260811105425.7429-4-philmd@oss.qualcomm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 11 Aug 2026 14:21:24 +0100
X-Gm-Features: AUfX_mwKnAXVIy_-TgBj5BbsRNHimFpq5t2oTVQTmR0eGaJuCA_-FLOasSlmY1g
Message-ID: <CAFEAcA_xv8+kzJpfRCxKY7FYZoFpLH34+_ftE_8S50RG8O3Bog@mail.gmail.com>
Subject: Re: [PATCH v3 3/7] hw/nmi: Remove @cpu_index argument from
 NMIClass::nmi_monitor_handler()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 qemu-s390x@nongnu.org, "Dr. David Alan Gilbert" <dave@treblig.org>,
 Thomas Huth <thuth@redhat.com>, 
 qemu-ppc@nongnu.org, Corey Minyard <minyard@acm.org>, 
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, Helge Deller <deller@gmx.de>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Nicholas Piggin <npiggin@gmail.com>, 
 Aditya Gupta <adityag@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, 
 David Hildenbrand <david@kernel.org>, Halil Pasic <pasic@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1134.google.com
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

On Tue, 11 Aug 2026 at 11:56, Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
>
> From: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>
> Only s390x was using the 'cpu_index' argument, but since the
> previous commit it isn't anymore (it use the first cpu).
> Since this argument is now completely unused, remove it.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

