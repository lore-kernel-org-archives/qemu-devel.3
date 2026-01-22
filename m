Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 208FAD3EE65
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 13:24:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viuf8-00062D-4O; Thu, 22 Jan 2026 08:23:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1viuf6-0005yj-2q
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 08:23:48 -0500
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1viuf4-0007MV-D9
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 08:23:47 -0500
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-79028cb7f92so8671507b3.2
 for <qemu-devel@nongnu.org>; Thu, 22 Jan 2026 05:23:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769088225; cv=none;
 d=google.com; s=arc-20240605;
 b=FYI/GXEma7wkeGFN1qJCKB2OnrFUApAyaDSeFQgWhdFEBMJh6e2dKM6Xw6ARpIMpRS
 n8bh5nhwK6EwbdBDzNb/8Kkzv9QmypM2eR47eWinjjwh2AvYEvAyaVw7Rpdvyr7BL4Bl
 LiiIcpU5F7cjmfCNX5lB5iX9HQiTu0ww3OlX8jm4SoRU3XmOjyz1qWxAgpSfJvXPXU0T
 Nwu/ouhctbiW+F2LPg4WcFiHs4rnTNwWKbCkkN5dLtnt9//b/LJ9NVuJkgJ6TGnIzK1f
 BQXSMwWTy1A12dvqQx+XodR042JClQXuLvnV7yxt4R/ZBGHghX858pN+HqRWDTITmIwq
 gR7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=jnBqA/cCAD7oPixGvH9Y2ugbwS+WZr2smMQ6aAuVXvE=;
 fh=l34yKrB0yromHHDUji8ziQOfQo4HrJ0cM0LWNUDHuFA=;
 b=kXzjTgvSgJVXr/JeGAOdskQlsZDpfeJWMzXpPYrESG7Qu+x2HsbsgZh+2BY1NbWMz6
 naunNy9tszeW/rvWoQIbiZ+CnxXnSQf8nb35/L+ZgKZbKujDLILw00EOW0au5XBwN/hA
 +N7X3ixenZu4WS7CHH0oICas4K+mNmKmvmZXcrW7KhdvagYKjxDUld7ThAOmvCNi0uka
 TIpxRHFWtF43XI/0LpEnAjAgdz5ViAE0HdNhNZ+5hKunw+la/RKxUAB7H0yTECrAHzpH
 qdym0IkkCIUZ9PPuNXAc9CgrQfm8Zl77/OKRKj7Up6KRW7fsl79Tx8MVALeKdh7jXI2Y
 3BNg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769088225; x=1769693025; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jnBqA/cCAD7oPixGvH9Y2ugbwS+WZr2smMQ6aAuVXvE=;
 b=hIau9SNK7X80A14XjFawm2vrNeeCjNyI0/fC9lkrPGYi7DF8GcKMvhQLs84DDdBswh
 iZyRIzkv8jgcXwcbl+DSOXfzZVE9WNSgbRUjApH3uGPcUjMZCoUvkmpj+DUNMH1p/K4F
 MupHAJxsRyi53vFc89kIpHEjKAePRlJAa7lg8vJsNGEnz0BGjC5t36SYNXxS+d8Vt0Tn
 QPn0Z4ZLiVb/m+TYUvWGcRaXvH58sZ/b8kb5ofApua7EB6sFwhyCc9hEfldIxo9FFfbp
 NagjFNRYLOMB38WmWorvOy4N7/1NkK+WNON9xw/XTI425P0C3lvCii7fHp452iENRurv
 o9Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769088225; x=1769693025;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jnBqA/cCAD7oPixGvH9Y2ugbwS+WZr2smMQ6aAuVXvE=;
 b=MD2q6dAgSBWL2jrHdLbq8RoU1Ra+dtBzWAi+5Vsz9a5b98ndzepBOzPZhgaUyDEM/i
 ihdNp2IRGjLoZQc3Jv2IX4JMfWUKOJnfLfd338N/i7BbAAAteuIBPPDWlY/6yCc1IpSJ
 e3wvvLhYgbpTjpu7XIgfqu0o++p/bV8DLkZFmMRMfpSbEImX+YRlyhPG597cxQRkIE0+
 Xnnj49k30nbFpt+NG3YYKA7b9r2Zm0Y+h8RPExc/bEb4QenMCQLT0U4qSXZqhfRx5+IA
 mExGCDTriUkU+kH9ehFdlJx2b1c11xoT6orQ4jOIyXXCkWgbd/8JziiGtWDRKVlEX9Fx
 I3wA==
X-Gm-Message-State: AOJu0YzYV9KD/Dbn+Eswtg7Ed2gqpG3zYd/QcSmsgMg0cOiMoROv25s2
 63RMoJaPbJeILg2EqzkyuL/nrRgpKVKp04/LfLwSy35WWB7O19YZZVi6sYJUFAEKEDsjah/kZb2
 gOMreMCYy1f+gDciLFToiNBop3S/jLLQKuNalT90ubQ==
X-Gm-Gg: AZuq6aJYwIFPFeOmMgk49tI9IyAOylo5trIiS3RrNwZVcbE0XntJhMu5uNvLvZ046gc
 5QWQZ0UnUyfkqCMvb7PJ7XP/QGZ82ju5CMeyUQeYLvpgOVsShMmDkATVcCAyrlaCnJVMH5zspum
 5iPkCgvZ04OiG09lv5jf2fMz4xEOLOmxQnE0p2NZ57sypMhY/9ttpznBVwN+eYwtD4frOVw0fcE
 GOoX+LWbMAah5e4eROp5v7/UKJV+wqQPikVRd7JejPax9/CvgcCyflJB5/mqB/1PvySBQ==
X-Received: by 2002:a05:690c:6c8c:b0:794:1811:32ad with SMTP id
 00721157ae682-79418113bf3mr48774207b3.51.1769088224861; Thu, 22 Jan 2026
 05:23:44 -0800 (PST)
MIME-Version: 1.0
References: <20251223142959.1460293-1-peterx@redhat.com>
 <20251223142959.1460293-18-peterx@redhat.com>
In-Reply-To: <20251223142959.1460293-18-peterx@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Jan 2026 13:23:33 +0000
X-Gm-Features: AZwV_QhTWgtk4oHFVdFM32-LFKHztfzWJ7_CcFgC_2koWV8qHmRAzJhGfFfP0FM
Message-ID: <CAFEAcA89vswCip53OAPFzLwz5EMnWBtsM61YD0Nc_kYrM4NuCw@mail.gmail.com>
Subject: Re: [PULL 17/31] migration: Add a qdev property for StrOrNull
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1136.google.com
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

On Tue, 23 Dec 2025 at 14:32, Peter Xu <peterx@redhat.com> wrote:
>
> From: Fabiano Rosas <farosas@suse.de>
>
> The MigrationState is a QOM object with TYPE_DEVICE as a parent. This
> was done about eight years ago so the migration code could make use of
> qdev properties to define the defaults for the migration parameters
> and to be able to expose migration knobs for debugging via the
> '-global migration' command line option.
>
> Due to unrelated historical reasons, three of the migration parameters
> (TLS options) received different types when used via the
> query-migrate-parameters QMP command than with the
> migrate-set-parameters command. This has created a lot of duplication
> in the migration code and in the QAPI documentation because the whole
> of MigrationParameters had to be duplicated as well.
>
> The migration code is now being fixed to remove the duplication and
> for that to happen the offending fields need to be reconciled into a
> single type. The StrOrNull type is going to be used.
>
> To keep the command line compatibility, the parameters need to
> continue being exposed via qdev properties accessible from the command
> line. Introduce a qdev property StrOrNull just for that.
>
> Note that this code is being kept in migration/options.c as this
> version of StrOrNull doesn't need to handle QNULL because it was never
> a valid option in the previous command line, which took a string.
>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> Acked-by: Peter Xu <peterx@redhat.com>
> Link: https://lore.kernel.org/r/20251215220041.12657-4-farosas@suse.de
> Signed-off-by: Peter Xu <peterx@redhat.com>

Coverity also suspects a leak in the get function (CID 1643920):

> +static void get_StrOrNull(Object *obj, Visitor *v, const char *name,
> +                          void *opaque, Error **errp)
> +{
> +    const Property *prop = opaque;
> +    StrOrNull **ptr = object_field_prop_ptr(obj, prop);
> +    StrOrNull *str_or_null = *ptr;
> +
> +    if (!str_or_null) {
> +        str_or_null = g_new0(StrOrNull, 1);

We allocate memory here, but we never pass this pointer
on to anybody else, and we don't free it either.

> +        str_or_null->type = QTYPE_QSTRING;
> +        str_or_null->u.s = g_strdup("");
> +    } else {
> +        /* the setter doesn't allow QNULL */
> +        assert(str_or_null->type != QTYPE_QNULL);
> +    }
> +    visit_type_str(v, name, &str_or_null->u.s, errp);
> +}
> +

thanks
-- PMM

