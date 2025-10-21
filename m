Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C483CCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 15:00:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBDpv-0007Im-SA; Tue, 21 Oct 2025 10:59:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vBDpt-0007I9-5M
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 10:59:41 -0400
Received: from mail-yx1-xb131.google.com ([2607:f8b0:4864:20::b131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vBDpq-00009R-Ni
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 10:59:40 -0400
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-63cd60ca2b2so5830783d50.2
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 07:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761058776; x=1761663576; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UfFg5PlSt7LSn+H9hWmSgczeXynUhTKK7p9zMvIXt7I=;
 b=hp4cx/DMks46AE14bftIXtkdIxLGtOBiVQVK2sKRvER2AHrW3avTmRWwqhz7NNM4A2
 mL2E9IjWhQsTjwronBlMtmalBeO2kd4SD83HNa024cbYNG3sv3xg6AqYonNxn+Plf05W
 16+mUplEpP8BRVkuwfnfUdvvvj5/TH7aufRVDFJN0UZXYB5YO76jiZ1SoHfYYhVvRou/
 KgWsjnYKmHH7etiuGgxKuBT6Xg8KOLPm8P260nFrplyS8XzkIgWw59F3K5mRkpPY1KuL
 /fodahQtbn8DQYWJnsMo94sE3BSz9AB6vN6XIcbClfty585Zrck1IG0yBT39xKQtTAXq
 N/Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761058776; x=1761663576;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UfFg5PlSt7LSn+H9hWmSgczeXynUhTKK7p9zMvIXt7I=;
 b=IeYZQGQWVi8pZE+Ex9flmnagRu5rNlrftAVxh69IP3rs7SBFrNz19RrarQoTCV7ehQ
 QnkN8hVl/YYqvpvLmixW3tiKDawbboKwvj6UxzTsmwpZ9JrelamjYsLe/m0rNV18AM9G
 8K4EKdxo5/cXhnv8Wf9T1ZyXmp06PbTezNlD3+zKImyFL89kNKuaEc5zSAcK1qhd/+OH
 L0d7VGdBG6dpAOgfEZM05ltHxYmcFta/qJSqSLmde3RcMX/bByaA1QBO8KHiW53jWMED
 3V97uOXMof03eSypTAXESTAoD2BMrbY9wCt6MBD8zR0tAsb9CJW35Kfc1idm2CWIJQqU
 /BHw==
X-Gm-Message-State: AOJu0YxLnm0wkIzss6v9iydaM19sFyJJAVAB/lGPJodkRiJGttd/TGNG
 ckDq7ARNAYWQEq1aIkinXRkvraVZH2h+0C4W9IIWLYLhdJNQBBZbtNIgfQ0ry/RwMkFGEyuTvRC
 YiWRMx5vd3xrYHOFZ2ulUKWR5wjqAKgLNq+mD3iqXFA==
X-Gm-Gg: ASbGncu9SoOEvlCVItZtGUt7X05SUxsi38Oq3wzMy0cpuehPzVBFCimNF7foTZE5+iM
 JQIUxtS1wO0ZzA1+ehtcWZmNauVkD04bgCCiWiLs/D48S7Pd+fyFWGvj1/MgPdVFyUISiFrF0/1
 XFFTvW4vriXPSLsUpG+Zra7sNE6o8EWnWR8z0n7zke33enU6gY8BOVAKdVuUdZZB1H7McCiRj1D
 EtQcPOmXY+2LFKDEFMLxkwe77i/XrNjM34waSCywaTIYPk10Ma7ZIikhZ4Mgw==
X-Google-Smtp-Source: AGHT+IGDd/QIe8foDLEnObJBx817B3MFWVIx9DeSwo8BLT3XfV67KWSfxqmad1t209e+ukqwuDkhb2ZEnwtJBgHqtfI=
X-Received: by 2002:a05:690e:144c:b0:63e:3084:4809 with SMTP id
 956f58d0204a3-63e30844b2fmr8212093d50.33.1761058776506; Tue, 21 Oct 2025
 07:59:36 -0700 (PDT)
MIME-Version: 1.0
References: <20251003153948.1304776-1-peterx@redhat.com>
 <20251003153948.1304776-42-peterx@redhat.com>
In-Reply-To: <20251003153948.1304776-42-peterx@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 Oct 2025 15:59:25 +0100
X-Gm-Features: AS18NWAqAcXEwEXTveKNAW19fVjDmKupZmZzxJS3aCbaUcvPMMHMRzgq_95Y-gc
Message-ID: <CAFEAcA_mUQ2NeoguR5efrhw7XYGofnriWEA=+Dg+Ocvyam1wAw@mail.gmail.com>
Subject: Re: [PULL 41/45] migration: cpr-exec save and load
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Steve Sistare <steven.sistare@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb131.google.com
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

On Fri, 3 Oct 2025 at 16:40, Peter Xu <peterx@redhat.com> wrote:
>
> From: Steve Sistare <steven.sistare@oracle.com>
>
> To preserve CPR state across exec, create a QEMUFile based on a memfd, and
> keep the memfd open across exec.  Save the value of the memfd in an
> environment variable so post-exec QEMU can find it.
>
> These new functions are called in a subsequent patch.
>

Hi; Coverity complains about this function:

> +void cpr_exec_persist_state(QEMUFile *f)
> +{
> +    QIOChannelFile *fioc = QIO_CHANNEL_FILE(qemu_file_get_ioc(f));
> +    int mfd = dup(fioc->fd);

CID 1641392: we open an fd here, but we don't return it
and we don't close it, so Coverity thinks we leak it.
Judging by the commit message, this is a false positive.

> +    char val[16];
> +
> +    /* Remember mfd in environment for post-exec load */
> +    qemu_clear_cloexec(mfd);
> +    snprintf(val, sizeof(val), "%d", mfd);
> +    g_setenv(CPR_EXEC_STATE_NAME, val, 1);

CID 1641391: g_setenv() can fail, but we ignore the return
value here.

> +}

thanks
-- PMM

