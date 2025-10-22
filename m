Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A34BCCD1BB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 16:19:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBbXp-0007t9-PW; Wed, 22 Oct 2025 12:18:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vBbXm-0007sN-JC
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 12:18:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vBbXk-0000wJ-5P
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 12:18:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761149909;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KtJHFju5dh5UoPc8ZzpOsluppt1/fHSCKD67Jn2S27U=;
 b=K5W1F6oc6bacpKO7IDK83M6Je9jlkxzZFAtlwHsNrrm2vy8A/peBQUAAXq0/CTeWoKl7cf
 KKnJ+Ep1oYzEQ4iduQQ0bqeUF2xJYVpAPg5FTZ+5qnjIAMFrKtiqJd2KN6SjkxbIH3KEkB
 EskeB2vbrW6TQ4jjWCCzQogrt1yRYs8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-345-PGwpJObiP_Kf1BD2i6aUnA-1; Wed, 22 Oct 2025 12:18:27 -0400
X-MC-Unique: PGwpJObiP_Kf1BD2i6aUnA-1
X-Mimecast-MFC-AGG-ID: PGwpJObiP_Kf1BD2i6aUnA_1761149906
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-472ce95ed1dso27901505e9.3
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 09:18:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761149906; x=1761754706;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KtJHFju5dh5UoPc8ZzpOsluppt1/fHSCKD67Jn2S27U=;
 b=WTb+Kvtm2+WlQAyTGZl/Tzt91oG60o98UAa3r8Ie82ZJq63Y3ySVBWE/uKurdXa6ow
 ETwDmaZsT1IXxUROmnPSBhSvY011BZt1t98ByD5t5J7ST2eSSYzFEZ7x60+WF0OAqS6w
 OdGVnzMvaOgGnONQWvTUtao2cAnsdy57+3iu7MjJ66JMvhYzxt/L9JSVg0+cRF8Fugqi
 kOwf+eWOhjttP3Z84RVjDacTk5P7GROxrJndKhNdbwW0r9HnpBIA5Rf1U63b+WwH7no+
 ARgI7SnU4WKvfFB712WjaT4ZMqbzJ/tPaxJKQzWKW4BpFo0E6Qn5zy8enq60a5ho0zPD
 GaXQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVeaCiJkAruZ+F3Z7G4fNM/moZLr490Jr2FmbIYndhO5IN7uiCOxsZZ81Jp+DFKDq40yiLSzu7co+nh@nongnu.org
X-Gm-Message-State: AOJu0YwJRZZJilXHq2HqVEUgjY82ImrJPtEbEL/AqBhEndW2KVam21yk
 9L1C9dPgdrH5RFbpio73rQmI1G7UCn/sW6jyn3Z2GMRpdKrbNriv9itc2U3dxJxPl0P/j1U1wVP
 zweguN50tvBD+oZvDce15Ryu3m+0ONopYs7loXs9G4eZOzMjd1wKPMv+C
X-Gm-Gg: ASbGncubhXa8V5wYmsRfDlw5g5Pw8hq6q03wL9rUKUfrMmDvd+1wykxxAvA5DMG2Tvp
 7NoGWkN+srOVK/P+/CdDtO0QZ6aC80UY0Y0U0SNy6WnLVnSIGR9OOut+IsKOXLqloXtpwY+lBUz
 Y2NRa8xYkpiYRgMoKEm75y1eVFZGXTKHP1jgAvrdD1XB10ZWDsb1SkpX4CvPxIUUBOsR9EilxJi
 5feVU0rhU2TQyeTMfWgryQT+Q2Nt/jFJHccClzxGNa0dUPLvnBTevr2tGjAfNZFn/vrSI+lbuPv
 6RUqj/RHoUopo92NFB4/m+QJO+4ye4YQrUYnulBpcTYfI4fZwL6jEjVn6tdTQH4V1OVRSSK5G7e
 uE8P4tg==
X-Received: by 2002:a05:600c:3492:b0:471:1774:3003 with SMTP id
 5b1f17b1804b1-4711791c88bmr158395665e9.29.1761149905922; 
 Wed, 22 Oct 2025 09:18:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFXRkMyUnbz/mXyKxYqDIwI/WNnomZPVM7UL3L2YrWgCcLq0NDlIl/wDdtUahvfK4wXRumE4g==
X-Received: by 2002:a05:600c:3492:b0:471:1774:3003 with SMTP id
 5b1f17b1804b1-4711791c88bmr158395485e9.29.1761149905557; 
 Wed, 22 Oct 2025 09:18:25 -0700 (PDT)
Received: from [192.168.43.95] ([37.166.198.186])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475c43900e1sm58786955e9.17.2025.10.22.09.18.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Oct 2025 09:18:25 -0700 (PDT)
Message-ID: <268f1047-7e35-42c2-a828-2406d8dcd0e8@redhat.com>
Date: Wed, 22 Oct 2025 18:18:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] tests/qtest/bios-tables-test: Prepare for _DSM change
 in the DSDT table
Content-Language: en-US
To: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com, imammedo@redhat.com, peter.maydell@linaro.org,
 nicolinc@nvidia.com, nathanc@nvidia.com, mochs@nvidia.com,
 jonathan.cameron@huawei.com, zhangfei.gao@linaro.org
References: <20251022080639.243965-1-skolothumtho@nvidia.com>
 <20251022080639.243965-2-skolothumtho@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20251022080639.243965-2-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 10/22/25 10:06 AM, Shameer Kolothum wrote:
> Subsequent patch will fix the GPEX _DSM method. Add the affected DSDT blobs
> to allowed-diff list for bios-table tests.
>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  tests/qtest/bios-tables-test-allowed-diff.h | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
> index dfb8523c8b..e2fce2e972 100644
> --- a/tests/qtest/bios-tables-test-allowed-diff.h
> +++ b/tests/qtest/bios-tables-test-allowed-diff.h
> @@ -1 +1,17 @@
>  /* List of comma-separated changed AML files to ignore */
> +"tests/data/acpi/aarch64/virt/DSDT",
> +"tests/data/acpi/aarch64/virt/DSDT.acpihmatvirt",
> +"tests/data/acpi/aarch64/virt/DSDT.memhp",
> +"tests/data/acpi/aarch64/virt/DSDT.pxb",
> +"tests/data/acpi/aarch64/virt/DSDT.topology",
> +"tests/data/acpi/aarch64/virt/DSDT.acpipcihp",
> +"tests/data/acpi/aarch64/virt/DSDT.hpoffacpiindex",
> +"tests/data/acpi/aarch64/virt/DSDT.viot",
> +"tests/data/acpi/aarch64/virt/DSDT.smmuv3-legacy",
> +"tests/data/acpi/aarch64/virt/DSDT.smmuv3-dev",
> +"tests/data/acpi/riscv64/virt/DSDT",
> +"tests/data/acpi/loongarch64/virt/DSDT",
> +"tests/data/acpi/loongarch64/virt/DSDT.topology",
> +"tests/data/acpi/loongarch64/virt/DSDT.numamem",
> +"tests/data/acpi/loongarch64/virt/DSDT.memhp",
> +"tests/data/acpi/x86/microvm/DSDT.pcie",


