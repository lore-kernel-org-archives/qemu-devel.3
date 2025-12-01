Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A1DBD111A8
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Dec 2025 09:33:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQ0Gq-0006vH-78; Mon, 01 Dec 2025 04:32:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vQ0GR-0006pD-8f
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 04:32:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vQ0GP-0006q6-TF
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 04:32:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764581529;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ggam1p3bDbUrKkAlbW0ViRxlboz+mv+LhL9b/kQ64jc=;
 b=IWSMtX0mPZBjXpZ0Bk0yEpZ1U58hjAsn/KP1bSNUOVAqfPw2yNMj/09YlyPW3nfP3p9eTS
 zZRWzuJD60WRoMzPSDaEbCgN5L230EX3BorV0AOXswsX2CaPpGyfdqa2Cxs46KA6ybM97t
 16V1YmZyacrgC0MECfMFTXjjFRe+fMY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-113-PY0xH_JoNiiVJ2YpYano5w-1; Mon, 01 Dec 2025 04:32:07 -0500
X-MC-Unique: PY0xH_JoNiiVJ2YpYano5w-1
X-Mimecast-MFC-AGG-ID: PY0xH_JoNiiVJ2YpYano5w_1764581526
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-42b2c8fb84fso2203652f8f.2
 for <qemu-devel@nongnu.org>; Mon, 01 Dec 2025 01:32:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764581526; x=1765186326; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ggam1p3bDbUrKkAlbW0ViRxlboz+mv+LhL9b/kQ64jc=;
 b=LvdhoeaTfRYGtgNFBFZEz5oi34pgsTYCDIq1hkdLP1wSRf32jjzfbXXq6CyzUc8/OK
 +LMFhvk4rbvPQEoqisp/l5+wPN6h9p6gcl8PxWnZgbV7ngGtyFQP4elCS1JIfzqdUTnv
 b10j5Tzvsx/RbhiMIn+lOiKmvzG0tXJgIwI4CzpRF8oi8pkx4iOd63xxWPy1i1lyNM+v
 y+ZC/oYtTOWKyo97bet+y5jC0nIKFi7NLRY1v3jedqHtqK4LqAewWN36kF5FyGLglX4q
 12yMQ9LUbNQcz2sHji5EqyhroHffFp9nQ/XFfzQAh1iJcgajAtUffSZadoxVRg3RvLyt
 5mnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764581526; x=1765186326;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ggam1p3bDbUrKkAlbW0ViRxlboz+mv+LhL9b/kQ64jc=;
 b=ZkprrROfTn1f1KlHEXkkej7hef2sbqoj0CML4365MALXuW7J3EpyN56p9Ii6vVSdPP
 WTm56uqi05XvvUOEZxXLFbu14ZCpiYRXMXd5VWz+GrXVyqkp+WQO2lWv44p2B7+m0vwY
 pBoO5xyVSd1iGGWonue/XEGrai7QOHZYwzqnrNV0bSZKx2IhyFSiTV4Vi2o/2ItkE+Kl
 TBue59i5bWchgTP6C1HB8egggBHI/VUrkWFokfMCfEEhG1/dKmpkqsHq+ENlFyhDu2Ra
 4F9szRLd1JNjuE491JJEbiLfFGEki8yeLIvwHOCMC74/iBGlg7m1U9QzW7IwiSMMIXgN
 B7vA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVIYKdbo4eTIlJ7nvsvwDlAvwk4XSKBbfl8G+htIpZhzOqT19ojku4U1tb988ANPiMCMNfsPNPYzEKK@nongnu.org
X-Gm-Message-State: AOJu0YwithYhN+JVRH9/gUOtOlvG6JM/4CWRqQ8jVscqjpacNrKzbvjH
 0tNJIc6r9v3OZa3nY4wCdrD48/x/QHEgxwgWLDiE3uMWceWhBWNKUlmJ3ZXzWDFUHqg65lB0Xou
 OozaCTi4hhmoMRxRaFGwwY+O7oausUp6ahruEE6KiPvdVCnihrYlRYZoa
X-Gm-Gg: ASbGncuUQ145EjSYXClulmX5pXyu4dGVYqKO4zTYJX7vt4ZwHvrj+q4ODhjtiiz2axj
 DwzplHLJA0lEVxbROu3aKkv+TST9dyz/Kb2YZwsWOdCMSVu8gubkdcSecor8dDE+2uviJnat544
 GCwN9n8HPoNLNYHy3RmUeGpiPgEgA1qpXZ8J4RCWhfbRFGFKJmTnVrD1NQpy2u2Mh9h/qgNKkQx
 83+6pYGTr7ec5iNhQjjzKcepj4OwKZ24Frb1CEqGeeK3gkwPJcSUSj7RZtxOtJaO2zvmbDYBYSB
 DPcXOEbYdi5+CuC7BKT7LWEOOMaKUqZFD2K9OmfOnf5DVLqDi6p0sGNMd/R/FBmV2sy+Aw==
X-Received: by 2002:a05:6000:2f81:b0:425:75c6:7125 with SMTP id
 ffacd0b85a97d-42e0f213a9cmr27425522f8f.16.1764581526318; 
 Mon, 01 Dec 2025 01:32:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEEYHiRpHiZg0CsCP2pRSAbCbekFKXcvVHxZH2gOqrMZE1YiuAgh6kf+L6HoEpouqiPRNcnGA==
X-Received: by 2002:a05:6000:2f81:b0:425:75c6:7125 with SMTP id
 ffacd0b85a97d-42e0f213a9cmr27425473f8f.16.1764581525926; 
 Mon, 01 Dec 2025 01:32:05 -0800 (PST)
Received: from imammedo ([213.175.37.14]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42e1c5c3041sm24106306f8f.6.2025.12.01.01.32.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Dec 2025 01:32:05 -0800 (PST)
Date: Mon, 1 Dec 2025 10:32:04 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Gavin Shan <gshan@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, mchehab+huawei@kernel.org,
 jonathan.cameron@huawei.com, armbru@redhat.com, mst@redhat.com,
 anisinha@redhat.com, gengdongjiu1@gmail.com, peter.maydell@linaro.org,
 pbonzini@redhat.com, shan.gavin@gmail.com
Subject: Re: [PATCH 1/5] acpi/ghes: Automate data block cleanup in
 acpi_ghes_memory_errors()
Message-ID: <20251201103204.19ff614e@imammedo>
In-Reply-To: <20251127004435.2098335-2-gshan@redhat.com>
References: <20251127004435.2098335-1-gshan@redhat.com>
 <20251127004435.2098335-2-gshan@redhat.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, 27 Nov 2025 10:44:31 +1000
Gavin Shan <gshan@redhat.com> wrote:

> Use g_auto_ptr() to automate data block cleanup in the function so
> that it won't be a burden to us.
> 
> Suggested-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Gavin Shan <gshan@redhat.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/acpi/ghes.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> index 06555905ce..6366c74248 100644
> --- a/hw/acpi/ghes.c
> +++ b/hw/acpi/ghes.c
> @@ -565,9 +565,7 @@ int acpi_ghes_memory_errors(AcpiGhesState *ags, uint16_t source_id,
>                    0xED, 0x7C, 0x83, 0xB1);
>      Error *errp = NULL;
>      int data_length;
> -    GArray *block;
> -
> -    block = g_array_new(false, true /* clear */, 1);
> +    g_autoptr(GArray) block = g_array_new(false, true /* clear */, 1);
>  
>      data_length = ACPI_GHES_DATA_LENGTH + ACPI_GHES_MEM_CPER_LENGTH;
>      /*
> @@ -585,8 +583,6 @@ int acpi_ghes_memory_errors(AcpiGhesState *ags, uint16_t source_id,
>      /* Report the error */
>      ghes_record_cper_errors(ags, block->data, block->len, source_id, &errp);
>  
> -    g_array_free(block, true);
> -
>      if (errp) {
>          error_report_err(errp);
>          return -1;


