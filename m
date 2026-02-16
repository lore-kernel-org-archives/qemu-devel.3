Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77F0EE63F3D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 09:51:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrvFe-0005wC-MY; Mon, 16 Feb 2026 04:50:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vrvFX-0005vm-J3
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 04:50:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vrvFU-0006RG-SI
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 04:50:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771235434;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MQYgE6XEbsdS+XOpkXvH8ab6fn5uSG821/53ECZNjoM=;
 b=a6La8HTDVdH8d2GsJU8GQwBtegSlSeRByATHRdPnvL84XjXPZeXswpZCnxJFGVsZRqDQL8
 F90GHHVA2aFy0l7fwSX5RqITQtTDJJZNaCMCTDf0Tk7WHGcXMRNVVvdRcU62sBUJ5J2oH/
 mhZW20AqvtKLUtCGFbSsrtc8LgOC7/U=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-372-r9dyiipgNo6vtHOuRdVurg-1; Mon, 16 Feb 2026 04:50:32 -0500
X-MC-Unique: r9dyiipgNo6vtHOuRdVurg-1
X-Mimecast-MFC-AGG-ID: r9dyiipgNo6vtHOuRdVurg_1771235432
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-506c0da79c5so150443511cf.1
 for <qemu-devel@nongnu.org>; Mon, 16 Feb 2026 01:50:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771235432; cv=none;
 d=google.com; s=arc-20240605;
 b=XI8I4rjxYi0vmfhOO3v/bQybcMrJRMbDw0KygeivqPovkG2mo0D5JCNW4S16zwF8cv
 2wr3IV8wAw69J0YLLscHGhwCa4Epmxcb3loMy0eCsyuecwzqOW04ZarMfMg2L5tGo7AN
 IzaTK5ldjZ2paEicFAK7mABOYhurG/FIya53uxwb4IXYm1hgjCjysUJB60TKdPvfH7Jl
 4hGHTfhRNW+y0D9cgu+L85hcALMmlgjjWETDFyglh3ophrLyYST6ffhnROuT4tQ0GQq8
 CqDNGXz8vjXKFUdlTxcjISYm4k9+snw4m8UyQ+t23vak2kUp/Xio6CcZ9H7SnQSGdMJD
 Tz8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=MQYgE6XEbsdS+XOpkXvH8ab6fn5uSG821/53ECZNjoM=;
 fh=sIsIOvEHAUniTyi3GhO91uUMlcdX4avqzqeMhQBuOOs=;
 b=B8YpRdJQYbmcDmRNSCn5otQmd0jMJI+27cyDKrBfFVbjNFP4oeFCttqzU4KfVcTu8/
 GxubToImFMU3WYFx0yqCq4/vWDgEH2D2Kak7HBK6ZJ3BaIcf+3+RTVfthvMLjxjawxSd
 JOI8P/8UUUEr2d/sZr8+pLm4ALMOb4wQhOm4/8izoXD5rdxqEnNDr6RPnX4DdS2fkLal
 rzSn1VTfHaj+kXWeV50hv+gx/DmQhlFEuVyn5dWK4lrWsI2enpowOOpU0QxiXHx5aPtC
 hIuORDE4fIItX2OQWMqIsLXLnqY4rUENVvChdEMQhmR65jkJab1XWQ+ydHqdzUI0BQh/
 jZeQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771235432; x=1771840232; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MQYgE6XEbsdS+XOpkXvH8ab6fn5uSG821/53ECZNjoM=;
 b=C2LIsMXDGLyv+ZuNWTj18R6LiDXConVV0WhwKmVrf6S6m25Hl36FrrIoT0OXeLEE4E
 dj9fGEQE1XvxzY9Rk2vyIqI6x8OGR+uD45Epv1Qsf9/Sc003NqxoejNboqCNwq2azbRC
 nVjlSvFLl5gP3JRidtc1lgIkIK7uRrJjj2QOIg1JvFXdg+8x+Bh4L5x3orqtFFNunE+V
 6G2Gl5+j2ggojTMvGOmIxFhuhG76GTfrtUuKhftvE1Wpx4s9PDoRMns3QEEndaZ8JEVC
 UpSjUAuC9MFvbxjCpxmJVbHQRygnYbJNUiXaul86jv1vU3e3X6gCxnPppJz+gHZd6gKu
 zzpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771235432; x=1771840232;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MQYgE6XEbsdS+XOpkXvH8ab6fn5uSG821/53ECZNjoM=;
 b=i/1hKYGnvfEW+nN8//D/QhA9rxs8Ew5H/Z4C73L8kKEV9+G5jLOF+8NdSoBsd/uaR2
 DmHq/eaW2082+ZMHljSsps9rp/uEpJvV+AZaseiM0OijNjSOpZlnsZCwV5wYM9Xjh6xJ
 LULLBsF3ccehLnOpbaf2YZAwxBU0wyGmQvfmb3l9jv7kV1dBv5oG3d6SsAFHbsTuYEFH
 0Am3x+F0yTaaowD+9Zqxt+/5Yw2I3Q+nNNIf8u7qejcv7nWir0rfE4YIyjn/hCaHf17J
 BuNP0+524f49Gv/p1XO1E+IyScig5ckaoe3Ps4fwGhwwo8QQFzH8DLCbfb4Hz5qcZYm1
 HH/A==
X-Gm-Message-State: AOJu0YyKIr5YndPCkLpNZ8bPXYWOdoFDXucptfWMKcTrO+RtmK7/J7QQ
 fvtuZEO49KYoHNRAIG5dAL8RcvXmbWsrvq+aJ8wZWwBaFU0n3pWCAvmzsgUM4qJ5lE1yVqXoEo3
 nHF5JXnIkAgWxMU6nNtKkin56PWCeLP+/KrpfYilrmUaRBjcrpC00SOVoWWr+pI4HxmjUTRipNo
 noiM4YxefYts6k1o9qvzwj7qIGx9uydQk=
X-Gm-Gg: AZuq6aI4Ct+f4KP+R+BPOTixQst3iRusnG92osOMXu6GjuGlvZc+lJCUMV02yrxNan0
 StbmPIZlph9YulANK21ufguSFY1heWXkRSuPAdzww5ADqEsqHS2+QSN6c8BxH1hqG+slD7WUJA6
 VKtYqIslyinKvLirM8eqVBRpYA1sJa1i1qPmqb/QfdJWKvCAxgp03HcVR8qEw20I9asy9cKXB9F
 d+IChqmXdBiLk1MlGAVI6yZ4j55zNCg7IRt
X-Received: by 2002:a05:622a:d3:b0:506:9d3e:67e4 with SMTP id
 d75a77b69052e-506b3f7e2a4mr100464791cf.5.1771235431780; 
 Mon, 16 Feb 2026 01:50:31 -0800 (PST)
X-Received: by 2002:a05:622a:d3:b0:506:9d3e:67e4 with SMTP id
 d75a77b69052e-506b3f7e2a4mr100464641cf.5.1771235431442; Mon, 16 Feb 2026
 01:50:31 -0800 (PST)
MIME-Version: 1.0
References: <20260206131438.1857182-1-imammedo@redhat.com>
 <20260206131438.1857182-5-imammedo@redhat.com>
In-Reply-To: <20260206131438.1857182-5-imammedo@redhat.com>
From: Ani Sinha <anisinha@redhat.com>
Date: Mon, 16 Feb 2026 15:20:19 +0530
X-Gm-Features: AaiRm5034mBBpQTh0tRO7QhR4LJfmn8ymxYh_82WTeROBodfCRvI_myoeyWoiCU
Message-ID: <CAK3XEhMrtqzhXdA-WsR_01WzbuVXSsTyCho56JBr2mkxyJuhgg@mail.gmail.com>
Subject: Re: [PATCH 04/11] tests: acpi: x86/q35: whitelist new WDAT table
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, pbonzini@redhat.com, 
 peter.maydell@linaro.org, shannon.zhaosl@gmail.com, philmd@linaro.org, 
 zhao1.liu@intel.com, rad@semihalf.com, leif.lindholm@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

On Fri, Feb 6, 2026 at 6:45=E2=80=AFPM Igor Mammedov <imammedo@redhat.com> =
wrote:
>
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Acked-by: Ani Sinha <anisinha@redhat.com>

> ---
>  tests/qtest/bios-tables-test-allowed-diff.h | 1 +
>  tests/data/acpi/x86/q35/WDAT.wdat           | 0
>  2 files changed, 1 insertion(+)
>  create mode 100644 tests/data/acpi/x86/q35/WDAT.wdat
>
> diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bi=
os-tables-test-allowed-diff.h
> index dfb8523c8b..14b680debe 100644
> --- a/tests/qtest/bios-tables-test-allowed-diff.h
> +++ b/tests/qtest/bios-tables-test-allowed-diff.h
> @@ -1 +1,2 @@
>  /* List of comma-separated changed AML files to ignore */
> +"tests/data/acpi/x86/q35/WDAT.wdat",
> diff --git a/tests/data/acpi/x86/q35/WDAT.wdat b/tests/data/acpi/x86/q35/=
WDAT.wdat
> new file mode 100644
> index 0000000000..e69de29bb2
> --
> 2.47.3
>


