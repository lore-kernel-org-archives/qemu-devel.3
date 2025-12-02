Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0FCAD116F6
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Dec 2025 13:21:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQQJ8-0005z6-2T; Tue, 02 Dec 2025 08:20:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vQQJ7-0005yh-28
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 08:20:41 -0500
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vQQJ5-00066f-Gi
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 08:20:40 -0500
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-789524e6719so79065567b3.1
 for <qemu-devel@nongnu.org>; Tue, 02 Dec 2025 05:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764681638; x=1765286438; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZbS46Le7oyh4pfgHIhx3/EKDWw+WzT5lTC3ChbRBoFw=;
 b=Rits9/2HmtRnXv2QZa/OhHF1XHzOz6EyNYSADUOri4LLv7CMwmXcbm4GPqDREVtQt7
 YyCh71Vy9ipSsuu3hg1WEHXmnmT8gUJLmhQ0TkVnaVehwImP3DwKEjqMn8c8lWwL7XC6
 TUm7LeFzq/II8NGmJAmNE3Bs1iYJjohGfUA43Iihu4eHY5m+yez7v2n8l2BlrRe3KTFo
 XF0i6Qvi66WRnNHqjr8IhLa8u7Aml60QavrD0UgForCcm1Rz+zYzzflac+hrunEqj3I5
 sULpZmal9fEshb5PPSm9h7Im0uB7wZelZL5zaSJtB/KAv52MpQbIyC9AFJrSw097cqrD
 t6IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764681638; x=1765286438;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZbS46Le7oyh4pfgHIhx3/EKDWw+WzT5lTC3ChbRBoFw=;
 b=oURL94Ui896Knn09otrzqukzC664yRqPXub5eZBP87gvYVQBc6WGfQypdPE2bClR77
 yDfhISQA/h/3b864st9xArTXGl4Yoj/V6W9CkJUw54D8NeUvm8br/hCJAfIwg6aMQSfX
 bUvye1OhH3sNk9HGev7LkdStxiRx7dD3jJbO/d+LYwHm5JKcQMt9X+s6WgYREQX0J+g5
 onC6z18OJhtavgMA8aMkOEikBKHp5zK0id0ikYTUTcNE9QJ/I/l4XSsre30sMFC2EUla
 Sm4+tBAFo6LLgtzGZi/toUwnauXyvNxEIyoM1IFoDd2r2+Y+cTRWG1eQ58cJbJ4zD3p8
 FdjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXMFK5kofgnbHA8klumO6Qx1XbYHpsRkZM+GTw3Kq8Vl5GndSJ/pQ3oPzIBzaTToiBpNJgXd80kE4NV@nongnu.org
X-Gm-Message-State: AOJu0YwTfFF0QYJFc359ODb8a3Qb077FFVZaFyywC4Jo1nc/rQwx20lt
 RaUqMjN4e2ZNOFM84cMPnI57jQSS+/XLracT6rbRvdMt96CmWExN0QL2ItEriGigRJc0DNUI+Bx
 wW0ojT2lxlcrQP71DMkpgvNx5pqxORp/11KMh29v7EA==
X-Gm-Gg: ASbGncthu2+2ZF+JCvUd3hKcAOtIDDhaJktY5k5q/C55M0MJgBbQtxSrwkg7LgW9W8Y
 uwolKK/C6EvtrBkErgpb37Dlfz994fG2bOeiOPGRaSqnqegx56pHVd3vyzRBt5SwDUUU5lajdOF
 Tta9eW1/LQFcxM5M7shbc8dymkd6/w6o6msHN82+Arl262dELd5ge81fnLsZl6ihdd3l2wxBumz
 0WaKneCriIaulDcu76ML+1or/qLmDCp2YnkAMKMxL8lSlLo82OUdiPzXJkNqH19EAU7nKJk
X-Google-Smtp-Source: AGHT+IFbDdIwWx7XVhFZ2HYqK7MJWY/IQ5E8pWk4PvWwI/wIh4twpVg7DgGfekCeIYkrIG4Uo7UsxOyC/vyQAR7v52A=
X-Received: by 2002:a05:690c:399:b0:78a:834e:b106 with SMTP id
 00721157ae682-78bff634c32mr18700467b3.25.1764681638096; Tue, 02 Dec 2025
 05:20:38 -0800 (PST)
MIME-Version: 1.0
References: <20251127004435.2098335-1-gshan@redhat.com>
 <20251201131729.615abe68@foz.lan>
 <12b7baee-1d6d-440a-a119-971b47d7f3ad@redhat.com>
 <20251201153121.190c22ec@foz.lan>
 <dd43197e-ff56-4adf-a413-03f63d5f5078@redhat.com>
In-Reply-To: <dd43197e-ff56-4adf-a413-03f63d5f5078@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 2 Dec 2025 13:20:26 +0000
X-Gm-Features: AWmQ_bkqFgNduGew7C_ZevHLFJ_sGthu2wIX_qkiURLvF6gbo8GKmy9qMz0-CfU
Message-ID: <CAFEAcA8P9sRUWgKmxrdCiOsMKtVu8gzLUorhR7HLG+ZtzNOL0A@mail.gmail.com>
Subject: Re: [PATCH 0/5] acpi/ghes: Error object handling improvement
To: Gavin Shan <gshan@redhat.com>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, 
 jonathan.cameron@huawei.com, armbru@redhat.com, mst@redhat.com, 
 imammedo@redhat.com, anisinha@redhat.com, gengdongjiu1@gmail.com, 
 pbonzini@redhat.com, shan.gavin@gmail.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112e.google.com
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

On Mon, 1 Dec 2025 at 14:38, Gavin Shan <gshan@redhat.com> wrote:
>
> Hi Mauro,
>
> On 12/2/25 12:31 AM, Mauro Carvalho Chehab wrote:
> > On Tue, 2 Dec 2025 00:13:06 +1000
> > Gavin Shan <gshan@redhat.com> wrote:
> >> On 12/1/25 10:17 PM, Mauro Carvalho Chehab wrote:
> >>> On Thu, 27 Nov 2025 10:44:30 +1000
> >>> Gavin Shan <gshan@redhat.com> wrote:
>
> [...]
>
> >>>
> >>> Btw, what setup are you using to test memory errors? It would be
> >>> nice to have it documented somewhere, maybe at
> >>> docs/specs/acpi_hest_ghes.rst.
> >>>
> >>
> >> I don't think docs/specs/acpi_hest_ghes.rst is the right place for that
> >> as it's for specifications.
> >
> > Perhaps not, but it would be nice to have it documented somewhere,
> > either there or at QEMU wiki.
> >
>
> QEMU wiki may be the best place for it. I never updated to QEMU wiki and
> any guiding steps on how to do that?

I think in general we should prefer to document things in docs/
if we think users would want to know them. If it's just a
test setup then perhaps docs/devel, or if feasible actually
make it a test in tests/. The wiki is largely unused except
for the changelog and planning docs.

(In an ideal world we'd check for parts of the wiki that still
have useful-to-users up to date information, and fold them into
our manuals.)

thanks
-- PMM

