Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A98BC5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 14:50:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ribYM-0000yz-2o; Fri, 08 Mar 2024 09:50:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ribYK-0000yc-7g
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 09:50:28 -0500
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ribYH-0003bH-UT
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 09:50:27 -0500
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2d21cdbc85bso26342171fa.2
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 06:50:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709909422; x=1710514222; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tmqbgbR/mT5D6Lyac4AzKNDo2CwRc6TbYyKg1TjCqug=;
 b=xZNm1FXQzbA2b5GKQYrsCzWle3cCOqfoI6RcvrS5xNys+XAGmK9BrAVGJUdxBETRXO
 TunjKXxvzjpDkPlW+jKrtFXNvxaU0cLK/MxG+YLIKPHSe4B/CxCaREv2lVxb07ZwupV2
 7BifQwyEuWHQB9E794G2a7w+/riwdvFtP4ALIQxue5uLEGMVnZ84E2sXwdU6xXbtRYJE
 p5Bvy1Jr846E2sydUfoFkZJCihIrEJy8cfl4+Wxi19mtIg59GvspYK1l+s7jSvHdZ4kR
 jdsHcuVVtRZ2aulxmg5fhOo6PnGooXqcGs9qu6SeI7ciyV2QnQPm1NHGTjkhUD5iYnzS
 /s2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709909422; x=1710514222;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tmqbgbR/mT5D6Lyac4AzKNDo2CwRc6TbYyKg1TjCqug=;
 b=ZJT2IOJBZLVqo5JLsGmMXDbdDt0wPsJiGuylT3YtwXoQab/3HbWMBxB454tknaCYft
 TwyFxfOrfOe6xdoa1VuPSbbzJwz5G1cltM26+kEZO7SGoXxwl/9h2zV5irCprdRePffz
 HJN+m5G9x7SKclIPlZ4PKH8ZtBl3FXHtFr0GNxQxcvOWBGknLzhs33X9+0oDZZOI9bLM
 bji5YlZitmFJkmSr6ZVfmWDLi/3XYc++OTCtkF2//8y4TVXvlo3QlyjQ9UFSCxMyI6fg
 EIcGpax//KBncMqNA4i8H4I/zw5xMZ5BmRjcr/ytqPuEvOkBkjjg7UFRyoETXB0s0USU
 D03A==
X-Gm-Message-State: AOJu0YxPWzQSuqQNdMbP/IqP4ktejfWMik0fEUuxgZYeSJQ16fk2oaE/
 VbkEI2Pi6h4oyYcL0tl3Qd5vV1jb9NT33kqIun31iGrwNW8clWXhqyBIjcZBPWdnpTBBxoGF7Tw
 6gw6vhcd7mSXSMldQCUE2SO2GTQwz6FbL2LFZBg==
X-Google-Smtp-Source: AGHT+IFO0qJ6hSogmdVTq/ShQ/xdd3vsnkPpQ3MnoA/UlFZAH9bVzWwbejbqGHASCsbvli/O1Kk8c6mu9f+Z4G/nc9U=
X-Received: by 2002:a05:651c:232:b0:2d2:d32b:dabf with SMTP id
 z18-20020a05651c023200b002d2d32bdabfmr3182879ljn.22.1709909422062; Fri, 08
 Mar 2024 06:50:22 -0800 (PST)
MIME-Version: 1.0
References: <20240308130507.582097-1-pbonzini@redhat.com>
 <20240308130507.582097-2-pbonzini@redhat.com>
In-Reply-To: <20240308130507.582097-2-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 8 Mar 2024 14:50:11 +0000
Message-ID: <CAFEAcA8FefcKHPAny5CN3bZLz9s4+5X93O_M0Sr6nnJ-Lzvx6Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] run-coverity-scan: add --check-upload-only option
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::236;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x236.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, 8 Mar 2024 at 13:05, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> Add an option to check if upload is permitted without actually
> attempting a build.  This can be useful to add a third outcome
> beyond success and failure---namely, a CI job can self-cancel
> if the uploading quota has been reached.
>
> There is a small change here in that a failure to do the upload
> check changes the exit code from 1 to 99.  99 was chosen because
> it is what Autotools and Meson use to represent a problem in the
> setup (as opposed to a failure in the test).
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

> -check_upload_permissions() {
> -    # Check whether we can do an upload to the server; will exit the script
> -    # with status 1 if the check failed (usually a bad token);
> -    # will exit the script with status 0 if the check indicated that we
> -    # can't upload yet (ie we are at quota)
> -    # Assumes that COVERITY_TOKEN, PROJNAME and DRYRUN have been initialized.
> +upload_permitted() {
> +    # Check whether we can do an upload to the server; will exit *the script*
> +    # with status 99 if the check failed (usually a bad token);
> +    # will return from the function with status 1 if the check indicated
> +    # that we can't upload yet (ie we are at quota)
> +    # Assumes that COVERITY_TOKEN and PROJNAME have been initialized.
>
>      echo "Checking upload permissions..."
>
>      if ! up_perm="$(wget https://scan.coverity.com/api/upload_permitted --post-data "token=$COVERITY_TOKEN&project=$PROJNAME" -q -O -)"; then
>          echo "Coverity Scan API access denied: bad token?"
> -        exit 1
> +        exit 99
>      fi
>
>      # Really up_perm is a JSON response with either
> @@ -76,25 +77,40 @@ check_upload_permissions() {
>      # We do some hacky string parsing instead of properly parsing it.
>      case "$up_perm" in
>          *upload_permitted*true*)
> -            echo "Coverity Scan: upload permitted"
> +            return 0
>              ;;
>          *next_upload_permitted_at*)
> -            if [ "$DRYRUN" = yes ]; then
> -                echo "Coverity Scan: upload quota reached, continuing dry run"
> -            else
> -                echo "Coverity Scan: upload quota reached; stopping here"
> -                # Exit success as this isn't a build error.
> -                exit 0
> -            fi
> +            return 1
>              ;;
>          *)
>              echo "Coverity Scan upload check: unexpected result $up_perm"
> -            exit 1
> +            exit 99
>              ;;
>      esac
>  }
>
>
> +check_upload_permissions() {
> +    # Check whether we can do an upload to the server; will exit the script
> +    # with status 1 if the check failed (usually a bad token);

This should also be "status 99", I think.

> +    # will exit the script with status 0 if the check indicated that we
> +    # can't upload yet (ie we are at quota)
> +    # Assumes that COVERITY_TOKEN, PROJNAME and DRYRUN have been initialized.
> +
> +    if upload_permitted; then
> +        echo "Coverity Scan: upload permitted"
> +    else
> +        if [ "$DRYRUN" = yes ]; then
> +            echo "Coverity Scan: upload quota reached, continuing dry run"
> +        else
> +            echo "Coverity Scan: upload quota reached; stopping here"
> +            # Exit success as this isn't a build error.
> +            exit 0
> +        fi
> +    fi
> +}

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

