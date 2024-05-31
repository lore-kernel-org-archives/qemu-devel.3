Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1F4DC25B7C
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 11:06:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sD05Y-00035W-Mf; Fri, 31 May 2024 07:06:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sD05W-00034u-OK
 for qemu-devel@nongnu.org; Fri, 31 May 2024 07:06:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sD05V-0000iU-BJ
 for qemu-devel@nongnu.org; Fri, 31 May 2024 07:06:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717153580;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vRRVsxgJ+xlaVE1gMPFs21sTlE+PJ7PzZr1qcVkiRno=;
 b=MOBLjDFa7TsBXz9L0C59AKkmJx8kWp8h4d5WvNbtgY9BuORVQKkXyB7O4zGbCnyuEMJNPx
 6z9I5Y6WMd5083zgmP/GB93/8pYun4OqakKdwd1BbIAgtER4KzzojfZ4yoS3YfXe71IzkK
 x9dWt8qlaiLINHL9pDBD8M1ZBgms2AM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-413-kh4T335NP1CM5jf83A89mg-1; Fri, 31 May 2024 07:06:18 -0400
X-MC-Unique: kh4T335NP1CM5jf83A89mg-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-35e0f445846so350008f8f.0
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 04:06:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717153577; x=1717758377;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vRRVsxgJ+xlaVE1gMPFs21sTlE+PJ7PzZr1qcVkiRno=;
 b=f9si3hLhtaST9zbRGfhHKt1xBxuCtTwLt+bLgthF9Kf/Pse3eCvOJyP9HQ+/xkhM2b
 vpHjD9H2ZWgb3fCuWg09Il3mMaDhTxh4toYJGByYIvGbBoqmaxltbkv/pWtKHlZH7I76
 VIFBjwstC7s3yzzpRbpCNRz3jZnma4Uxh9Jy0YOJ2y8nYMKMad/28F1GOVkywlDghcaY
 lnxl64ZLw7GrPaQN6OJprsTfq+xaV7oEGHNxOG6fu3+xnjJq7GwacAClfuk6LkSHuwaJ
 pbYwd421xgSZFWapMEhN/80pZhVN69F8WZnVgzdGG5O8GYhywUnj/ByxycPeUcl7FGzm
 gHNw==
X-Gm-Message-State: AOJu0Yw8nxfkKrbD4w0PLvhAcw4ruKgwpQc7PmU08ewt+Q8AGnIZHB8G
 SV3zDrCKOYEE4YkGtScbzZDsFaJAfzi5ktXyH8+201GwwprkXFFH3wjnop8fYtoMeVgwE1nBm0t
 x2IiWSd0mJQAV0E+F1YJPxExCx6WgjMz3RCzyLRyWs0DZYxLDbmYNwfiBzpOgceTsdR3IP3kJMT
 xS0QwKnwOjRwS6oPLMyICmv9dnOY4=
X-Received: by 2002:a05:6000:4598:b0:351:c2c1:3682 with SMTP id
 ffacd0b85a97d-35e0f333d40mr885477f8f.62.1717153577386; 
 Fri, 31 May 2024 04:06:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9LhlxVxdWcPVZ7UT4uT/GzA+K2roO4rSI5/qG3wo0fDKKrOV8w5n7Xh5wepQ95vSEE0IxZBrPYOCvWtrXD18=
X-Received: by 2002:a05:6000:4598:b0:351:c2c1:3682 with SMTP id
 ffacd0b85a97d-35e0f333d40mr885454f8f.62.1717153577024; Fri, 31 May 2024
 04:06:17 -0700 (PDT)
MIME-Version: 1.0
References: <20240530111643.1091816-1-pankaj.gupta@amd.com>
 <20240530111643.1091816-8-pankaj.gupta@amd.com>
In-Reply-To: <20240530111643.1091816-8-pankaj.gupta@amd.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 31 May 2024 13:06:05 +0200
Message-ID: <CABgObfZQHq0NOs1BV60-hV=9SLBu+ZfBKTnH4WVg5Vk5LcSxpw@mail.gmail.com>
Subject: Re: [PATCH v4 07/31] i386/sev: Introduce 'sev-snp-guest' object
To: Pankaj Gupta <pankaj.gupta@amd.com>
Cc: qemu-devel@nongnu.org, brijesh.singh@amd.com, dovmurik@linux.ibm.com, 
 armbru@redhat.com, michael.roth@amd.com, xiaoyao.li@intel.com, 
 thomas.lendacky@amd.com, isaku.yamahata@intel.com, berrange@redhat.com, 
 kvm@vger.kernel.org, anisinha@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.085,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Thu, May 30, 2024 at 1:17=E2=80=AFPM Pankaj Gupta <pankaj.gupta@amd.com>=
 wrote:
> +++ b/qapi/qom.json
> @@ -928,6 +928,61 @@
>              '*policy': 'uint32',
>              '*handle': 'uint32',
>              '*legacy-vm-type': 'bool' } }

Nit, missing empty line here.

> +##
> +# @SevSnpGuestProperties:
> +#


[...]

> diff --git a/target/i386/sev.c b/target/i386/sev.c
> index c141f4fed4..841b45f59b 100644
> --- a/target/i386/sev.c
> +++ b/target/i386/sev.c
> @@ -42,6 +42,7 @@
>
>  OBJECT_DECLARE_TYPE(SevCommonState, SevCommonStateClass, SEV_COMMON)
>  OBJECT_DECLARE_TYPE(SevGuestState, SevGuestStateClass, SEV_GUEST)
> +OBJECT_DECLARE_TYPE(SevSnpGuestState, SevSnpGuestStateClass, SEV_SNP_GUE=
ST)

This separate struct is also unnecessary.

Paolo


