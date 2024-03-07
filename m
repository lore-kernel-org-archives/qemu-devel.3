Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3712FC54798
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 12:48:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riDAD-0006lD-T4; Thu, 07 Mar 2024 07:47:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1riDAB-0006fk-Ft
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 07:47:55 -0500
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1riDA7-0002Zv-Qr
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 07:47:55 -0500
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5654f700705so1015343a12.1
 for <qemu-devel@nongnu.org>; Thu, 07 Mar 2024 04:47:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709815669; x=1710420469; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zU8cJaohj3KsBqdHds23YRLEC8mn1sEBx34ESoVa04o=;
 b=rwcbcQeRpo1H/J6Ra+W3ungM3vybPYa7aSQLZCp426/uelDucYQVus1nbpHvrI+gFU
 y4yeYubl0WL+G1LZXzVapwsr/6BLMlrMuzsLMNZiEZdNxIB5axPV+vufvlfymf6Cz5kf
 Od2jlqqnqWwZJCMXwoCED9Ca1UrjjLDFg4yGPc0ew2AF46+mS+5S2HpEfHqHSNQVq+PJ
 cnMvTLn+Kb6QrznM4zI/K4WdFKhSGgClzdrhYhaxjRcXbuxLLmRVB4kB+oNlOrOTYZUM
 wqxsoTd5NN5QcZ62RAh1srhJzEJKKNUC+cm6sHVAjJMU+28j+mo/DH8es4klLrANfYy1
 MQ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709815669; x=1710420469;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zU8cJaohj3KsBqdHds23YRLEC8mn1sEBx34ESoVa04o=;
 b=EFMVId8wdyWYiqo4BlcCIIuy4go5y+3cxEe7S/4xDLRygoIRerTSvxRF4rdl8mLmu9
 TPWVTa9TB4jCArXpz2Uj3VISAgJEhkjM+QjHSVbxFYZIrI1tUYdKi3znMtEP98HhIssy
 HgJWrSF573MrfoIdZ7XFRwhjOUTgZFHw7s6k5VACDFZyOdbOI/85I6Sk8d7qhd0c+2DM
 yGaaqe4gAlTw5YmoqeR1SgJa8Ln8BsnVF34cFvKNuePllHo5n39yZKsHZ2PyR1PMSKdn
 pQgXCcU1SPAew8eUcjC6d9y1KYD/z/VEQ4GpYOpAzaXSmGHWddTie/4NIlK//0/XpbVe
 SnbA==
X-Gm-Message-State: AOJu0Yzjg9U8A778vKgA91lBqabHG/fCbGm+g8FstIC03aNeAzmSPYMr
 IVaHSROnwYsF8Jha6aW2wwTChEp9BBpKvihhopVMOjD4L5tLoRm72Q6j4w8Cxq+o/wdZ3nmocU6
 L0t5uXoe0HH5fwniTy0qlTCXpDMvN/g8SY9qQDw==
X-Google-Smtp-Source: AGHT+IEFMVzFY6sTKLUKUFr9wPAxsJ1doVheir7D9go0L2P3zXfzrNcRsBPRTe6ogrxIdKgNI6UA4m4gJNPOmRJRuHc=
X-Received: by 2002:a05:6402:2152:b0:566:ef8:a81a with SMTP id
 bq18-20020a056402215200b005660ef8a81amr14141990edb.7.1709815669261; Thu, 07
 Mar 2024 04:47:49 -0800 (PST)
MIME-Version: 1.0
References: <20240305190902.364753-1-pbonzini@redhat.com>
 <20240305190902.364753-2-pbonzini@redhat.com>
In-Reply-To: <20240305190902.364753-2-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 7 Mar 2024 12:47:38 +0000
Message-ID: <CAFEAcA9fbCT=i2b0KnZW1HDb5giCxsehvVbMK4-+RYpCX_yoOQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] run-coverity-scan: add --check-upload-only option
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
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

On Tue, 5 Mar 2024 at 19:09, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> Add an option to check if upload is permitted without actually
> attempting a build.  This can be useful to add a third outcome
> beyond success and failure---namely, a CI job can self-cancel
> if the uploading quota has been reached.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  scripts/coverity-scan/run-coverity-scan | 51 ++++++++++++++++++-------
>  1 file changed, 38 insertions(+), 13 deletions(-)
>
> diff --git a/scripts/coverity-scan/run-coverity-scan b/scripts/coverity-scan/run-coverity-scan
> index d56c9b66776..4bc991f70fd 100755
> --- a/scripts/coverity-scan/run-coverity-scan
> +++ b/scripts/coverity-scan/run-coverity-scan
> @@ -28,6 +28,7 @@
>  # project settings, if you have maintainer access there.
>
>  # Command line options:
> +#   --check-upload-only : return success if upload is possible
>  #   --dry-run : run the tools, but don't actually do the upload
>  #   --docker : create and work inside a container
>  #   --docker-engine : specify the container engine to use (docker/podman/auto);
> @@ -57,18 +58,18 @@
>  # putting it in a file and using --tokenfile. Everything else has
>  # a reasonable default if this is run from a git tree.
>
> -check_upload_permissions() {
> +upload_permitted() {
>      # Check whether we can do an upload to the server; will exit the script
>      # with status 1 if the check failed (usually a bad token);

This comment says we exit with status 1 on a failed check...

>      # will exit the script with status 0 if the check indicated that we
>      # can't upload yet (ie we are at quota)
> -    # Assumes that COVERITY_TOKEN, PROJNAME and DRYRUN have been initialized.
> +    # Assumes that COVERITY_TOKEN and PROJNAME have been initialized.
>
>      echo "Checking upload permissions..."
>
>      if ! up_perm="$(wget https://scan.coverity.com/api/upload_permitted --post-data "token=$COVERITY_TOKEN&project=$PROJNAME" -q -O -)"; then
>          echo "Coverity Scan API access denied: bad token?"
> -        exit 1
> +        exit 99

...but these changes switch to exit 99 instead. It's not clear to
me why -- the commit message doesn't say anything about changing
the exit status.

>      fi
>
>      # Really up_perm is a JSON response with either

Otherwise this looks OK.

thanks
-- PMM

