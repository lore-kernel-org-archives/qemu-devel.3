Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AD51CCD1A7
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 15:35:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBEO2-0000ra-OU; Tue, 21 Oct 2025 11:34:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vBENs-0000pd-JG
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 11:34:48 -0400
Received: from mail-yx1-xb135.google.com ([2607:f8b0:4864:20::b135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vBENo-0004m1-VY
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 11:34:48 -0400
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-63e393c49f1so2501273d50.0
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 08:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761060883; x=1761665683; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0gOgi7jadNBzCHQfEI9RsHFCcQe3JXhk2fO1mNw4Rs4=;
 b=mclVw7JHxo2lT/6lJxLKLdC8gbccSTz/QpIEBTEyOfWQZ6Ewjd3qBNHMiuu+loRHAk
 7t/CAnyu4IZ86/toNZc8U+g+mMqFcQcWZJQDeMznuciGKy4YtCUgWsIdVvxrgKnuBmkR
 1GVExRLA7Gu6IKyWv3qECAkImG2aNmbopkkrami0s2vpeCUkvvg1rVbZWXcOuDNNnSq8
 EuJZLkeMH9ls+EWL1kvlDs7rACEBYLct+zKFCdQ0MXjHxUdABR1rQhvkeUWUDmnIM9qa
 0zM2qaMCGS5fzhTHVaYqakRxQ0W6Bv2uOjC3zzwe2jahpw35DXQFQEo1XDq3y56KnRMr
 Qm1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761060883; x=1761665683;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0gOgi7jadNBzCHQfEI9RsHFCcQe3JXhk2fO1mNw4Rs4=;
 b=LszoKoF5ikwc6asphShw3m+G4TG52asXvZkld+xjzidmtJ44pdzPVVpW9YuxSNlmXr
 2q57gY31smOSAOwZcbdV7qIvy0JJkpddnDN5g/sNlOp2IlPfHY+9VWJ3QSh/LESQMVRk
 zQEdtiAzIPKTJCzZ0ymrh39urOdL5GI/BfygTHi548haT6HYutPfS9GCbKDIaubgYyCJ
 fZfxX2Tk0d3GdkfV68ImlBGfS/fF+16x9IyxOsq7Viso24ABw+uou13VMmlYPiHWCSEy
 WSGybBoAytQ6VsasyvDxb6Jkv2ol4Xc+NPE1vHIjD/8SJ/kptLNzWObKIVzAs1drZzmf
 p2/g==
X-Gm-Message-State: AOJu0YwnkKyQ/yAGphiXMEi1G1ChI4GCAYHms2KMQKpbfnbQXsbvLux5
 Yhk8/lgEANCKRnYFRddCrF23xxGgAPsi8MAAxXfzPyFyt/kvInkiO/ZcakfHbc36VcWod6hco4x
 cGd65Rv6mjzxi+lBt4DM4+Bpl35LwS3m77qM8SeI0Yg==
X-Gm-Gg: ASbGncvrww+wnedsgqmCzGSNffRjlOyMY3Imv0U8uXQz/zHaNpd3vYw4tPshyxHQRHt
 V95FrRCjqIv4Bh7yywjqOoABD/iBHsEyRr3B7boq29x14BollF2Dje9pbe0zGr+MTRCacNm5B8+
 2IasOTdpgPmsdsMHn6+C4LZyKN809KQHK7/YfS/AtgNF3893cL86vAPMqe69P4MImw3HK+eMl7q
 dMpH3Hwp2XfGnm0Mqhw5aj+B0tW4bLGc3ms/sRH/a4Uv9H5AwAsYCQTDeFfz/WB8XniByKQeJur
 2z4+yWw=
X-Google-Smtp-Source: AGHT+IFKPTIPymKahbrZnMkuCX7GC/X4Cp2rBFGOTgu+TE6gsaGp2Wocreim8DcjEDsuQWmpUYoBlEVNka1ksZ4evso=
X-Received: by 2002:a05:690e:d56:b0:63b:47b3:4fef with SMTP id
 956f58d0204a3-63e160e9866mr12776754d50.14.1761060883263; Tue, 21 Oct 2025
 08:34:43 -0700 (PDT)
MIME-Version: 1.0
References: <20251003153948.1304776-1-peterx@redhat.com>
 <20251003153948.1304776-43-peterx@redhat.com>
In-Reply-To: <20251003153948.1304776-43-peterx@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 Oct 2025 16:34:32 +0100
X-Gm-Features: AS18NWBMMUZGSp6h0bwYquZR9BAWGRM5PG813Ky55z3-GqorAwP1pd0Bw19hVW4
Message-ID: <CAFEAcA82ih8RVCm-u1oxiS0V2K4rV4jMzNb13pAV=e2ivmiDRA@mail.gmail.com>
Subject: Re: [PULL 42/45] migration: cpr-exec mode
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Steve Sistare <steven.sistare@oracle.com>,
 Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb135.google.com
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
> Add the cpr-exec migration mode.  Usage:
>   qemu-system-$arch -machine aux-ram-share=on ...
>   migrate_set_parameter mode cpr-exec
>   migrate_set_parameter cpr-exec-command \
>     <arg1> <arg2> ... -incoming <uri-1> \
>   migrate -d <uri-1>

Hi; Coverity complains about this code (CID 1641397):

> +static void cpr_exec_cb(void *opaque)
> +{
> +    MigrationState *s = migrate_get_current();
> +    char **argv = strv_from_str_list(s->parameters.cpr_exec_command);
> +    Error *err = NULL;
> +
> +    /*
> +     * Clear the close-on-exec flag for all preserved fd's.  We cannot do so
> +     * earlier because they should not persist across miscellaneous fork and
> +     * exec calls that are performed during normal operation.
> +     */
> +    cpr_exec_preserve_fds();
> +
> +    trace_cpr_exec();
> +    execvp(argv[0], argv);
> +
> +    /*
> +     * exec should only fail if argv[0] is bogus, or has a permissions problem,
> +     * or the system is very short on resources.
> +     */
> +    g_strfreev(argv);

Here we free the argv array...

> +    cpr_exec_unpreserve_fds();
> +
> +    error_setg_errno(&err, errno, "execvp %s failed", argv[0]);

...but here we read from the freed memory argv[0].

Presumably we can just move the free down a bit ?

-- PMM

