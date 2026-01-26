Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82BD6CF65D5
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 10:28:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkJlt-0002m3-8F; Mon, 26 Jan 2026 05:24:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1vkJlp-0002lb-GO
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 05:24:33 -0500
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1vkJlo-0000Xs-4A
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 05:24:33 -0500
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-b886fc047d5so426729566b.3
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 02:24:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769423070; cv=none;
 d=google.com; s=arc-20240605;
 b=KFrwGDn0hKvCLF3theDVkATsxfB+NVqecJR7PPTqJtJOzkOVEPkQW3zUdKEIfaux1l
 d16OtGtHs4evYeD+01HDETcN9awPEh4GerhYKevsYiBkwY7QoS1perRoA7O/ZuPfAGwH
 xtfLMP9O5dAL2MJ+ve+CeYdN11YPaXNnII/uAINDqZfTzp5vwbnIisRb/s8vOATaXYa7
 jdGjrlXk1K8MKdoMKpHz6szmXcKDqp5x3qgccfT1j74wlTvMtcAvqodeineEZyjuEzrJ
 OOWMJtvCXQHcK/VAgO9Mj4U8vmzYEVdkkYMf2mq9vtP+F5KcHopm6GEsoYe5Sy0+7251
 ngUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=+vIx+ceNey7dfXcxKVmHSLkJhcNwDIzAdl9uFXOE1Rg=;
 fh=Q60oc1Mwo+n6KVl0/HzulOCo07LbH2MP95czanFwixA=;
 b=N95c765b2kdGiM8lcttIKy8SmOF1WlDKxMqiFAxw/Oyao9bdE9VYjhp+sKefbXkxWh
 GhxRGs8a6JuIHm/O8kuAjD50aaLwMwkpknmlyrQcX91m574OwkPwNR2VqbgKz6yb7Bbt
 Fz+Ucu305mZtM5zmcIZZq0jSA9YYTz7mjEtDaHHf8oA6GJ9yRT8VbU7UJxl0eosbGm2O
 yUsmCystB6yw2P8x3F+gGYg3Qq3k6V34cdmuhwuu8YZ8PSf9te6esqvYnIy8pOSaADRi
 tU4W33TkeHwW/3+ZibCXlpQEOctIESBOs1oF9seaK7YLaa/mzE8a3E3uwdq3vjh0viXa
 0ddQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769423070; x=1770027870; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+vIx+ceNey7dfXcxKVmHSLkJhcNwDIzAdl9uFXOE1Rg=;
 b=g8irILz/yyYp8RZcOYJ/5Gz1drscObvhN8yoWszqH7veQU5IFURMUpYrx48x/l6KFJ
 o1eJRC2RaDOXadFm9s+HBZFyNAV7OwQLy3wktPTH7Yw//u2eztvq9MO5PjWjgBms7eTN
 EQGX+srnJydqvA1EgWyItSRoLi6nm1QJAPy7bevhvX/YrZ0wXoWbRTLt1FnYO+db0mEg
 2AxDoz/odcDq8R5E5T6pO2vS53wghXp5ZBQ5y1pfgvWuqiEM6zUKQ79PYHMSM1mzbayF
 A186VD3Iyzz0Rem70GCpvaLrq4IyYfnKxyxq28ExjblHHjyjOsI7TkiW+8OKfElRtE/p
 MJVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769423070; x=1770027870;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+vIx+ceNey7dfXcxKVmHSLkJhcNwDIzAdl9uFXOE1Rg=;
 b=bZ1IFHBgEUFwOLgbmU4N9qWVtRbSoGrtuROp1L0AmRUthsVnvRqfZmdf3kGKQYh0mj
 GWxZhti/EmCv78hPQUYBiY/iEfmd7ApmMnvxm1ddk4oiJTUd4qfiqPwhuB9/1IBTupOr
 nCXgp9HiAuKHxaqjllHOSmc2g6x5CfRNrGdMdormx5g94AvqQXu9prHhtkCSAFiFe+8Z
 pCUUebuwz+W4JYmL4QC6dcocupUu9u01LVn8iEX/+WOB1By6CjPumiTmTVxAnlTGGK+q
 sJV1Dy04suvoeZdzYnlfEwnBKlpa/6/TFs2PVZyG3V/JnvGvHJKwG0XBCeK3qwVSeBlr
 1w8g==
X-Gm-Message-State: AOJu0YwPMedeL2FOiveVBaV7whW66VZSCSIYFM4QtxhkH/IJ0mwHHDa9
 +NQk7UX1FUUcDahsZfI2M8RcjP8neI9XHn1NEmP0HcHRC5AVD6ymDd9OPZCOJR9EM6Zt0lSyzIj
 2Q21tkCAXBJAESJ2LvCaQRekm68zK2Uk=
X-Gm-Gg: AZuq6aLMnYS/xoKj7TBQZIztTD6W0c/eZCOXe6DpSXYhPz5OcZ/8QjfqRsGxY/8FdKa
 v54OmiEuiCaqIDYCA5scFe+WnHmlQMhI/assxGFXVHuAS34UP4Znn82z39W7ygRH4MvxzZEsfdM
 PXQD4wVuS4GnWIZNnG/Q8aVsyFcOz1jP3dBadMW3Hj6Vk2TH1JTfdxwvfLrRNe4VWxAuUQIgqSy
 9196aSrvxAbYaAxBhFDZ3vo+pPRFGOz71GmAGF3E38g6kZZ1cSrvt9npxFkgeEzemSAQ87H
X-Received: by 2002:a17:907:1b24:b0:b87:173f:61b with SMTP id
 a640c23a62f3a-b8d0a73a450mr253822866b.9.1769423069558; Mon, 26 Jan 2026
 02:24:29 -0800 (PST)
MIME-Version: 1.0
References: <20260125-colo_unit_test_multifd-v3-0-ae926ccd8eae@web.de>
 <20260125-colo_unit_test_multifd-v3-9-ae926ccd8eae@web.de>
In-Reply-To: <20260125-colo_unit_test_multifd-v3-9-ae926ccd8eae@web.de>
From: Zhang Chen <zhangckid@gmail.com>
Date: Mon, 26 Jan 2026 18:23:49 +0800
X-Gm-Features: AZwV_QgW3UBsjMdo1sB-6XaN--T_pzjd7RPLaUYqN-Ktc0Eyx9I4qdQSu524MIU
Message-ID: <CAK3tnvLzvzZ9N59ypYEqqBncRhrX=tzKx7tS=Oq4dBVUJYa8JQ@mail.gmail.com>
Subject: Re: [PATCH v3 09/10] qemu-colo.rst: Add my copyright
To: Lukas Straub <lukasstraub2@web.de>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Hailiang Zhang <zhanghailiang@xfusion.com>,
 Markus Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=zhangckid@gmail.com; helo=mail-ej1-x631.google.com
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

On Mon, Jan 26, 2026 at 4:41=E2=80=AFAM Lukas Straub <lukasstraub2@web.de> =
wrote:
>
> I have so far contributed 61 commits to the colo project, waranting
> the addition of my copyright to this file.
>
> Signed-off-by: Lukas Straub <lukasstraub2@web.de>

Reviewed-by: Zhang Chen <zhangckid@gmail.com>

Thanks
Chen

> ---
>  docs/system/qemu-colo.rst | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/docs/system/qemu-colo.rst b/docs/system/qemu-colo.rst
> index a70e61aa09391cda933031535fa982d27cf6654b..75abbd80298df79223cb8e700=
64a5dc83d70f4eb 100644
> --- a/docs/system/qemu-colo.rst
> +++ b/docs/system/qemu-colo.rst
> @@ -356,6 +356,7 @@ Wait until disk is synced, then::
>  | Copyright (c) 2016 Intel Corporation
>  | Copyright (c) 2016 HUAWEI TECHNOLOGIES CO., LTD.
>  | Copyright (c) 2016 Fujitsu, Corp.
> +| Copyright (c) 2026 Lukas Straub <lukasstraub2@web.de>
>
>  This work is licensed under the terms of the GNU GPL, version 2 or later=
.
>  See the COPYING file in the top-level directory.
>
> --
> 2.39.5
>

