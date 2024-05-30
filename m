Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61D3BC25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 06:04:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCYsZ-0002s8-KF; Thu, 30 May 2024 02:03:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sCYsY-0002rV-05
 for qemu-devel@nongnu.org; Thu, 30 May 2024 02:03:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sCYsS-0000tc-Nd
 for qemu-devel@nongnu.org; Thu, 30 May 2024 02:03:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717048983;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=X1xR87sRpGdB2Y+rEAjNo3TAeYICpNRvIsgyWm9tsdw=;
 b=STXj0k0yRshFRJjzAUepG+IpUZWDuAPI2udR83Iujevta/obX71pi/1VVk++BmYVOip8O2
 BViUYCZRd+wgwP7f7nnegmErNFtTAqnf59YfCcza7g7+q6dl13N67hM90YkfPAnAZNcYwd
 axjSq/4SUUqm34G1NU4SnYA8PMNCUG8=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-CwKcj9UfOz2Bs14hLjvLuQ-1; Thu, 30 May 2024 02:03:00 -0400
X-MC-Unique: CwKcj9UfOz2Bs14hLjvLuQ-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-52b80898d50so18467e87.0
 for <qemu-devel@nongnu.org>; Wed, 29 May 2024 23:02:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717048978; x=1717653778;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X1xR87sRpGdB2Y+rEAjNo3TAeYICpNRvIsgyWm9tsdw=;
 b=age02qGGbJga82koFsmoAOAGcDsg+CkiQUfWUdMeLSAdoJGHnkebjhYM6e2XiSezSW
 zhwW29QtBtlCxVIpc//k2+GPB2FM8JiowMSzPL8e7m4EhblritoH9KuL+SSIxtrkmtaT
 xBxFHk4xF94NM40v0jnmLFsrTYt1lOOtkfY6FJfLjmIILwKRFBYMnVsv9Ep4cnNYviva
 YeF60NgUtALuII50pZGDfv0es/CHvEr4UuoZtssX+XU3dvwU31lydIL51fwdC+y+q8d9
 7Tz9z/4lcxPrHPRF0dufc7iyhtmA2C/O7P6ZPQSeT54UkOz55rSz7nLKO1haKhZpTh3p
 tH7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXoX9tykxD/7QTfKzQvFRsc6a3s90JXa/JOiEyDNE72wXD0hlYIcIV3OXRVkL01IlPTY8PaSEBc8LFboZ2WtpG8mpBb+40=
X-Gm-Message-State: AOJu0YxdH1NKvQ9OU4gje+nphWqXUVv615mCAm3cTSlw8iBtkJxnbQgI
 I3j+DEyVEe3PU9bjQiZvkyUA1eCLQi4h1qBQ1OvIAGfaW1Y+QJc4tM0GkOu19c4TlzJpfrlWgAP
 DmlyMBlVroxBBbtlSMRzdr19xx0YEPiEAN+C02e76jrPPznXOWoua
X-Received: by 2002:ac2:5ec8:0:b0:51d:7d5a:af05 with SMTP id
 2adb3069b0e04-52b7d4323c2mr564506e87.32.1717048978312; 
 Wed, 29 May 2024 23:02:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHM8nMYGZy+DJH8z6gPgi4giO79/fmHgNqgE9zNsWTLjaNqGmEYxLeWuRDvvM5y3g4MHz9Gyw==
X-Received: by 2002:ac2:5ec8:0:b0:51d:7d5a:af05 with SMTP id
 2adb3069b0e04-52b7d4323c2mr564477e87.32.1717048977690; 
 Wed, 29 May 2024 23:02:57 -0700 (PDT)
Received: from redhat.com ([2.55.191.38]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42127059769sm13928555e9.5.2024.05.29.23.02.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 May 2024 23:02:56 -0700 (PDT)
Date: Thu, 30 May 2024 02:02:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH] scripts/update-linux-headers.sh: Fix the path of
 setup_data.h
Message-ID: <20240530020213-mutt-send-email-mst@kernel.org>
References: <20240527060126.12578-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240527060126.12578-1-thuth@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.036,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Mon, May 27, 2024 at 08:01:26AM +0200, Thomas Huth wrote:
> When running the update-linx-headers.sh script, it currently fails with:
> 
> scripts/update-linux-headers.sh: line 73: .../qemu/standard-headers/asm-x86/setup_data.h: No such file or directory
> 
> The "include" folder is obviously missing here - no clue how this could
> have worked before?
> 
> Fixes: 66210a1a30 ("scripts/update-linux-headers: Add setup_data.h to import list")
> Signed-off-by: Thomas Huth <thuth@redhat.com>


Reviewed-by: Michael S. Tsirkin <mst@redhat.com>



Paolo you merged the offending patch wanna merge this one?

> ---
>  scripts/update-linux-headers.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/update-linux-headers.sh b/scripts/update-linux-headers.sh
> index fbf7e119bc..23afe8c08a 100755
> --- a/scripts/update-linux-headers.sh
> +++ b/scripts/update-linux-headers.sh
> @@ -159,7 +159,7 @@ for arch in $ARCHLIST; do
>          cp_portable "$hdrdir/bootparam.h" \
>                      "$output/include/standard-headers/asm-$arch"
>          cp_portable "$hdrdir/include/asm/setup_data.h" \
> -                    "$output/standard-headers/asm-x86"
> +                    "$output/include/standard-headers/asm-x86"
>      fi
>      if [ $arch = riscv ]; then
>          cp "$hdrdir/include/asm/ptrace.h" "$output/linux-headers/asm-riscv/"
> -- 
> 2.45.1


