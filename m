Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4652EE77188
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Dec 2024 11:52:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQmPR-0002Mw-Jv; Thu, 26 Dec 2024 06:52:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yvugenfi@redhat.com>)
 id 1tQmPP-0002MQ-AQ
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 06:52:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yvugenfi@redhat.com>)
 id 1tQmPN-000126-P3
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 06:52:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1735213922;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RuynefNPGfi4mLtAmaI5KZiqGR8WKpZA0C91dFElJW0=;
 b=OD2ZP3YJII5jP5+oGdKZgy3VNSdsCsCQ4P53odjPaH6PipmIvzYXDcaBsWytsPKpyWof8z
 mzHc6XsJ7WYUualKBoff19uN8mz1rBoNZ9/qdE/QUYTVuhl0GddtN+n1c5LC7KMSKNcjWz
 DKGwAfad6hosBO5rp3MDz5koEfAVROw=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-307-AhY22fPSNVW4TqKQHUlchQ-1; Thu, 26 Dec 2024 06:50:24 -0500
X-MC-Unique: AhY22fPSNVW4TqKQHUlchQ-1
X-Mimecast-MFC-AGG-ID: AhY22fPSNVW4TqKQHUlchQ
Received: by mail-yb1-f198.google.com with SMTP id
 3f1490d57ef6-e3c61a11a40so11528913276.2
 for <qemu-devel@nongnu.org>; Thu, 26 Dec 2024 03:50:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735213824; x=1735818624;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RuynefNPGfi4mLtAmaI5KZiqGR8WKpZA0C91dFElJW0=;
 b=Eltf3WZeS1//rQBQBrx10nqTviLzmGFdkN6EEF9J243NUnT3M++wcgHBn/KH46p8Qf
 FFxnfJJhzCZhK69uIsxwP6pE0fIO3gKW5Ta6GAM/8npgI01ptyZqeI1UHSL2oiiSECo6
 a0QK8nIOa50rLI8GEzaUrsSMLKGku03K/BoW5Wnhv9jtdOBLKnuLvh1l8eF8zPUSVTc9
 aeA682cPnr0zBmC7D70omYTRofXO3tdJCMoXzrCnpTt3rmvm8wIfF6b65q6FMdQ1YVlv
 mH7O07z5fzlyerTeLjTscrhvyW4r6H4uriYT4uJItx5dNKNikqc87K2MPabIj2XHEdO/
 JXfQ==
X-Gm-Message-State: AOJu0YwX5dr1RL5evDwGolaquXxM5EWrgJrNVdzKwtI7L5GN/ITnAEGg
 qv1vh4JXvXTstJ41m9AtEED6vAviHRGkqJyWjN+CTdb9MkBGXaJBHeOFMhSyOHK+glSl+LE0RXb
 oyOdDD0ZXohJNx7ZZZncvHdN4b+0iN+e5HqqRHsHkJxT9Ynu8O+5dW/OsHv/GAnPVs3k8iGd914
 Hic0wfc56wbqUEE2/sJmBdDCqnZbk=
X-Gm-Gg: ASbGncu5UJqpbKn/CVEZFgdzpTMrl2muSQ62B/03xSGNpJxJY1SfwBUCLO6c4Cg7cKk
 8VluE8Fur8clqertPqmtHy0BxRNAIn50chyA/
X-Received: by 2002:a25:6889:0:b0:e53:d870:76f6 with SMTP id
 3f1490d57ef6-e53d8707b26mr3612425276.43.1735213824039; 
 Thu, 26 Dec 2024 03:50:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFTRAWT8NB7G0QsDKuVub7X2/DGyuOw1WgoByWTrM/WNe1vHmUoR76m/zxPL4H0OgWJwiDuRYmpZQyy5pvzPAw=
X-Received: by 2002:a25:6889:0:b0:e53:d870:76f6 with SMTP id
 3f1490d57ef6-e53d8707b26mr3612418276.43.1735213823735; Thu, 26 Dec 2024
 03:50:23 -0800 (PST)
MIME-Version: 1.0
References: <20241225083744.277374-1-demeng@redhat.com>
In-Reply-To: <20241225083744.277374-1-demeng@redhat.com>
From: Yan Vugenfirer <yvugenfi@redhat.com>
Date: Thu, 26 Dec 2024 13:50:12 +0200
Message-ID: <CAGoVJZz3StFv4Lw0Mzd=7K=f6cxKP8fieiW_bm7xDC35uJZF3w@mail.gmail.com>
Subject: Re: [PATCH] qemu-ga: Optimize freeze-hook script logic of logging
 error
To: Dehan Meng <demeng@redhat.com>
Cc: qemu-devel@nongnu.org, kkostiuk@redhat.com, michael.roth@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=yvugenfi@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Dec 25, 2024 at 10:38=E2=80=AFAM Dehan Meng <demeng@redhat.com> wro=
te:
>
> Make sure the error log of fsfreeze hooks
> when freeze/thaw/snapshot could be logged
> to system logs if the default logfile of
> qga can't be written or other situations
>
> Signed-off-by: Dehan Meng <demeng@redhat.com>
> ---
>  scripts/qemu-guest-agent/fsfreeze-hook | 36 +++++++++++++++++++++++---
>  1 file changed, 32 insertions(+), 4 deletions(-)
>
> diff --git a/scripts/qemu-guest-agent/fsfreeze-hook b/scripts/qemu-guest-=
agent/fsfreeze-hook
> index 13aafd4845..c1feb6f5ce 100755
> --- a/scripts/qemu-guest-agent/fsfreeze-hook
> +++ b/scripts/qemu-guest-agent/fsfreeze-hook
> @@ -19,15 +19,43 @@ is_ignored_file() {
>      return 1
>  }
>
> +USE_SYSLOG=3D0
> +# if log file is not writable, fallback to syslog
> +[ ! -w "$LOGFILE" ] && USE_SYSLOG=3D1
> +# try to update log file and fallback to syslog if it fails
> +touch "$LOGFILE" &>/dev/null || USE_SYSLOG=3D1
> +
> +# Ensure the log file is writable, fallback to syslog if not
> +log_message() {
> +    local message=3D"$1"
> +    if [ "$USE_SYSLOG" -eq 0 ]; then
> +        printf "%s: %s\n" "$(date)" "$message" >>"$LOGFILE"
> +    else
> +        logger -t qemu-ga-freeze-hook "$message"
> +    fi
> +}
> +
>  # Iterate executables in directory "fsfreeze-hook.d" with the specified =
args
>  [ ! -d "$FSFREEZE_D" ] && exit 0
> +
>  for file in "$FSFREEZE_D"/* ; do
>      is_ignored_file "$file" && continue
>      [ -x "$file" ] || continue
> -    printf "$(date): execute $file $@\n" >>$LOGFILE
> -    "$file" "$@" >>$LOGFILE 2>&1
> -    STATUS=3D$?
> -    printf "$(date): $file finished with status=3D$STATUS\n" >>$LOGFILE
> +
> +    log_message "Executing $file $@"
> +    if [ "$USE_SYSLOG" -eq 0 ]; then
> +        "$file" "$@" >>"$LOGFILE" 2>&1
> +        STATUS=3D$?
> +    else
> +        "$file" "$@" 2>&1 | logger -t qemu-ga-freeze-hook
> +        STATUS=3D${PIPESTATUS[0]}
> +    fi
> +
> +    if [ $STATUS -ne 0 ]; then
> +        log_message "Error: $file finished with status=3D$STATUS"
> +    else
> +        log_message "$file finished successfully"
> +    fi
>  done
>
>  exit 0
> --
> 2.40.1
>
>

Reviewed-by: Yan Vugenfirer <yvugenfi@redhat.com>


