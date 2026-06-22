Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29438CD98F2
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 12:53:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbe9T-0005p2-8U; Mon, 22 Jun 2026 08:53:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1wbe9R-0005oh-FB
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 08:53:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1wbe9Q-0006SX-5q
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 08:53:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782132799;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HI/m1i2j2XBW3o0S1sxY6h3R+4RtH3SDmheAtgJzuIM=;
 b=baT09sbJcm7hy3yDM2k+tpH5X63YxbcuF+9IB8fgbvrO3yxpjJguoTkB8ZObNCFt15U48Q
 a7QssJmdaLyWhBg7cS6tRXbBUoz+PxfFx1k+j++6hOpfNYnoC+C1fMqbeg1lMPlIBfSCul
 tmSuPIXCbA8wS77OuebUandiTizZ0/Q=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-410-IbiSoVRbN3W3g8Ue9p9ZUw-1; Mon, 22 Jun 2026 08:53:18 -0400
X-MC-Unique: IbiSoVRbN3W3g8Ue9p9ZUw-1
X-Mimecast-MFC-AGG-ID: IbiSoVRbN3W3g8Ue9p9ZUw_1782132797
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4923d2f0dedso17307795e9.3
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 05:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782132797; x=1782737597; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HI/m1i2j2XBW3o0S1sxY6h3R+4RtH3SDmheAtgJzuIM=;
 b=j0dhefZVKFao44sHVqG+RT7pb9+p3o6HX0Wx1n5s/PzAY8iqLrbKSj86oh/VUgFCe6
 7wlViXW+OR3tzrSFtluifYob/3xgM39ZcM6NHH+eATa19Wm59oUjYr/KWAhrhZN0XmA3
 fM/WZ7FtD03blBVtz4tffB6jMhzQLCQ4YNe6eZ/uGDygDynewzaZWtf3XGBw9hBBF+LW
 zEEtWU34LSpTfDzd/k6wbgFLK50ZyMZoeSUvBTyEyJ3ROxei5q/2af+7dugD/WsQt8oQ
 pQCWGZsAGz5TDHQYQ/CeuhqQ8cHo+ipYtj4HOBkl86YaO93oBDbpSqiInjTXMP6KxCJ4
 FvCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782132797; x=1782737597;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HI/m1i2j2XBW3o0S1sxY6h3R+4RtH3SDmheAtgJzuIM=;
 b=aeVMb+r309L/xWGmMivip0tQmVZfvLGCzzI9JPreFSCcyQmT2JHbZNUI4DDGIcojwx
 LKbAFamrQ40ztICHvzSsIHj2zc8zZ1FHkjB4DyKpQk9+Y+WkVav8+zp81lP4RkqJpp3/
 eHApkWR4GfHLktTZfoS6GkZMggKB1lgDUeVRxhKnqQ9Yi9n2SbbdVW9N7F18KnJPEKMn
 CTjPspmEsiX/1SrMa+d8cPEbVp59XxBYvK/8JxLInEfWP0tTaVZqVjfYhL6Slgi26+lo
 mvEUYAfPQeD2yOhsdyyvPuZ2LCdhp1grtwb79+FOgh8QrCzVwE5JDnzbCN4a7xDRKf+G
 eXPQ==
X-Gm-Message-State: AOJu0YwuHRl8YDoVSVCIwRqUqGVtqVSsipVBy7kyS8z9lpWTRRLCXeE+
 FI7E6f8tXf4wnplMEpxdDyvs73lOJKqvu0BkJYd+She5unrXhERyyH/G37vukhw9++76UsBHLF9
 jwtX5KFDA5bwthUvJr+1sN1cTLhXHQjnmfdux3QI/WIOiTFi83Lh2InRK
X-Gm-Gg: AfdE7claJDAJoVthBGBlS6SUxSVZBHwAXPSuKzcmjcwWjva4nN6MTvuBfCHBy16dXv1
 v2pA+bA8HYOamcUXvXjef+sPBfU+xW3eUtgkD8Xm4OHg/ehaGPyJZD5WvpskaOtYnahwtsUdF1c
 8P8n2ny72zPv1bACvqCO2RO/bYQbdWUiwpn6ZEW13kiWEJdwt35hfQ/ZW130/GmmGuQJelJUI3T
 f9CfxpYBTu3DpVHPwNB2A+Z9BtrxzxKC0SqvtvU6cOQiKriXr60zL0bEmNWeRSZ3sreRGqgfilP
 i6ahtgXYuXx0J67bx5PWjHZWoiR11+aprIX46/mFpKFmwEWVe9txua4WdXmjnK+7VHX0tr8=
X-Received: by 2002:a05:600c:820b:b0:490:b202:4772 with SMTP id
 5b1f17b1804b1-4924231417amr231389495e9.2.1782132796922; 
 Mon, 22 Jun 2026 05:53:16 -0700 (PDT)
X-Received: by 2002:a05:600c:820b:b0:490:b202:4772 with SMTP id
 5b1f17b1804b1-4924231417amr231388655e9.2.1782132796130; 
 Mon, 22 Jun 2026 05:53:16 -0700 (PDT)
Received: from imammedo ([213.175.46.86]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49240eef2basm313174815e9.2.2026.06.22.05.53.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 05:53:15 -0700 (PDT)
Date: Mon, 22 Jun 2026 14:53:13 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: fanhuang <FangSheng.Huang@amd.com>
Cc: <qemu-devel@nongnu.org>, <david@kernel.org>, <mst@redhat.com>,
 <gourry@gourry.net>, <philmd@mailo.com>, <peterx@redhat.com>,
 <Zhigang.Luo@amd.com>, <Lianjie.Shi@amd.com>
Subject: Re: [PATCH v13 06/10] tests/acpi: add empty expected blobs for
 sp-mem SRAT test
Message-ID: <20260622145313.220880ca@imammedo>
In-Reply-To: <20260619111136.3481329-7-FangSheng.Huang@amd.com>
References: <20260619111136.3481329-1-FangSheng.Huang@amd.com>
 <20260619111136.3481329-7-FangSheng.Huang@amd.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, 19 Jun 2026 19:11:32 +0800
fanhuang <FangSheng.Huang@amd.com> wrote:

> Add empty SRAT.spmem and DSDT.spmem stubs and list them in
> bios-tables-test-allowed-diff.h.
> 
> Signed-off-by: FangSheng Huang <FangSheng.Huang@amd.com>

Acked-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  tests/qtest/bios-tables-test-allowed-diff.h | 2 ++
>  tests/data/acpi/x86/q35/DSDT.spmem          | 0
>  tests/data/acpi/x86/q35/SRAT.spmem          | 0
>  3 files changed, 2 insertions(+)
>  create mode 100644 tests/data/acpi/x86/q35/DSDT.spmem
>  create mode 100644 tests/data/acpi/x86/q35/SRAT.spmem
> 
> diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
> index dfb8523c8b..188003fa90 100644
> --- a/tests/qtest/bios-tables-test-allowed-diff.h
> +++ b/tests/qtest/bios-tables-test-allowed-diff.h
> @@ -1 +1,3 @@
>  /* List of comma-separated changed AML files to ignore */
> +"tests/data/acpi/x86/q35/DSDT.spmem",
> +"tests/data/acpi/x86/q35/SRAT.spmem",
> diff --git a/tests/data/acpi/x86/q35/DSDT.spmem b/tests/data/acpi/x86/q35/DSDT.spmem
> new file mode 100644
> index 0000000000..e69de29bb2
> diff --git a/tests/data/acpi/x86/q35/SRAT.spmem b/tests/data/acpi/x86/q35/SRAT.spmem
> new file mode 100644
> index 0000000000..e69de29bb2


