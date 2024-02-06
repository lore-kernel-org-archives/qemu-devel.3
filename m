Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A162C4828D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 07:52:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXGEY-0003wA-UJ; Tue, 06 Feb 2024 02:51:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhw2101024@gmail.com>)
 id 1rXGEU-0003ve-Vt; Tue, 06 Feb 2024 02:51:07 -0500
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhw2101024@gmail.com>)
 id 1rXGET-0003Wx-GK; Tue, 06 Feb 2024 02:51:06 -0500
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a38291dbe65so26902766b.3; 
 Mon, 05 Feb 2024 23:51:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707205863; x=1707810663; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=W6noDplANQXEE71GbQLBWRGpMuIKNOLW7Z0s33eTMSw=;
 b=ha6R644NEfkVP86scX3uu2cO0z3k9zj8noVbhUs/YE7jsoGYFT28itnq8RwIfNQc3O
 QnbW6plml1oXwOMTirg3EW8YpOJj/VtXSr1p1QsLz2XP0C21AwXoqP+zaf98LgK5dEk1
 iXa/iWsH9qvQ/m3ZtzeZ6MtUMr0MRS6lQZErLKVP1zX+Iz+YAeVm2HzBr++1DAZw9sW/
 xEa2XazdDnH0eSE0Nfe5uj6fxLaL77zNqUzN6SouhB3djK7ykFwNbKda7xXXpbCFjj1U
 tRMnfkkwMKDXEXhd47V0y7bjpagF1s0/l+23A8C+7SdJhbCcyYIa644rjUU0tfmGWIwm
 4h0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707205863; x=1707810663;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=W6noDplANQXEE71GbQLBWRGpMuIKNOLW7Z0s33eTMSw=;
 b=dKnxHxMU4Vh4P35HtShTV1mjfyjR1mhx9eAr0nFwr4OTNzagm0rFuFUvOEdTZE6fx6
 eVOzD51KVA0812pa/6weyeUSBoRNibG4vVi9q3/v4DCg5GKQH9cpASt33rHGs629io1p
 oWUomO3ieoNAir2kASxYwSP93jUmlGkdc1p9OSfxeb+bRRDfGhj/43hc5I9TWwbZZm0C
 YDKC1mi8yHUmTV8ah8aC5dGksGsy4N7KbaS3Pofj16M7OuswzkzNYR/gvWavyQYehjxN
 ffAlMQDBZcNRGeqJnhW3ltRG9NE0TgaviO/mhMAP/CdECSWfhj+9P83uw3HuCJhPHyIa
 WPOg==
X-Gm-Message-State: AOJu0YzCzph6s0zf8UapCbdFt/+OKsY9kYIAifcLxSsyUDURWmlY9LSE
 O7/gHaP6AFGFppuA05sKuBPAVYev3CoVPWGZmdis91vtK9mKsiMnZBHICNd4krgjqXv5mowyo8y
 ZUok8RcqUK7X6j9r08Rh2rBGkMI8=
X-Google-Smtp-Source: AGHT+IGQ67tv+w3bdMqm5RG12mpuM2sul/wlIgkUeIr7W55E02V1R/Mapd0obgJl4a6BvQ9SqD36Aeb3WP00BgJWZo0=
X-Received: by 2002:a17:906:2898:b0:a35:fdf9:e7e4 with SMTP id
 o24-20020a170906289800b00a35fdf9e7e4mr871785ejd.20.1707205863250; Mon, 05 Feb
 2024 23:51:03 -0800 (PST)
MIME-Version: 1.0
References: <94cf974b-05ec-41c2-8d0b-43ffbc8bdeac@gmail.com>
 <904ef958-0e3d-48da-a4a7-5c1514c04472@tls.msk.ru>
 <e441b771-0a08-4f2c-b7a7-f6fdd787bc1c@tls.msk.ru>
 <CAFEAcA-C-pGGYY1bfE0ZatZP-imGmq=4-579TEnEZWFLeLxZLQ@mail.gmail.com>
 <CAKjfnjrCu1R6LE46AYf0+SGXs6994APhRvgSNWR8wfp=mnp3Fw@mail.gmail.com>
 <e292f18b-18cb-4b67-9db4-df938aa19d3d@tls.msk.ru>
In-Reply-To: <e292f18b-18cb-4b67-9db4-df938aa19d3d@tls.msk.ru>
From: Zhang Wen <zhw2101024@gmail.com>
Date: Tue, 6 Feb 2024 15:50:51 +0800
Message-ID: <CAKjfnjpCz=hrpZXj7uS=OQdpvkKPEFa24s3QYS4TqNZALcykJQ@mail.gmail.com>
Subject: Re: building qemu on a system with libxkbcommon installed but not
 xkeyboard-config produces an core dump
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-trivial@nongnu.org,
 pbonzini@redhat.com, 
 marcandre.lureau@redhat.com, berrange@redhat.com, thuth@redhat.com, 
 philmd@linaro.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=zhw2101024@gmail.com; helo=mail-ej1-x635.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

> So how the problem manifests itself?  What the actual error message is?
> You mentioned some segfault iirc, care to share some details?
I'm doing a rebuild, and will attach the error message and coredump
file here in one or two days.

-- 
Key fingerprint:
419F 72F3 F3A9 36EE 1B72  B00B C1C3 4BD4 FDA3 362F

