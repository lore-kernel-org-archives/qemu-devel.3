Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27567CF9C6B
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2024 14:13:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1st6Gx-0000H8-UJ; Tue, 24 Sep 2024 10:12:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1st6Gv-0000Fm-Uu
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 10:12:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1st6Gt-0007t2-UA
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 10:12:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727187126;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hVquTE6hlP3PXCOl1TWNHsEejRtJiU9SN+2dy3HqL/8=;
 b=dyOeNptiez9RJ2cWiHNQOJtMAqhw5HlmfgpUp++Zh+k6SzB/T3Rc82Ad1tFemYmOY3O2VR
 CKGxQmoS7qVmwr/ClWei1yyIsmjx9SdavaNG3sz5QA01PEkDE8hnlepEUtB4+YvlIcmH2O
 g7Amm3MmC9jXPA2okwC+vJ2Eb5uLX2s=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-KE86mtqbPF-UZ4bdCcFHgg-1; Tue, 24 Sep 2024 10:12:02 -0400
X-MC-Unique: KE86mtqbPF-UZ4bdCcFHgg-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-42caca7215dso37423095e9.2
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2024 07:12:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727187121; x=1727791921;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hVquTE6hlP3PXCOl1TWNHsEejRtJiU9SN+2dy3HqL/8=;
 b=WIIvRVKhn/BXHxZV8iZzFNjXz9fnTVZe7CXTKqKCNoFJHY6l1V+nGWt7p1U+jrBWC+
 azzZk+VCZgx0bIRvPeZC9aK7iUcpTra6dnfPh2JmtSiWK4IPSIil8hBB9AySxEBIHpCr
 beMuiS5DbgbStmtCEbDJsJq9LAk0VRWdOoBzeqgdBD7xHIkjN7eRitWLS7kUzpWn50eU
 s5b5YsRVmONdqImbS36avtkQnK6TFGLiGX/nMRumt0cculv+N4SclnbNX9UG+p0iD4/1
 3ACP1p1NRjHPCEcddtk+bKkwiNXuPH0NbsCkV6HNVqViv9xu3m3eeFT3eYqybAwwV1+s
 dQCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVBBLJorupTx/gbWJXU+GP/As/MU+syRAHJFWGRpNYMUan3cz4z3ULE08wRRxjT+fqtPK9oWECe2slw@nongnu.org
X-Gm-Message-State: AOJu0YyWQvngL+fUBLPCslEvpmb5yTTEUuWsF3v11xXvwM7zGWKF3IKP
 c4RkX15Ot8MBLeSnIkceJJ1HDh8M87Eegwkxy7SZPMCeuYmPgTeuU3A+05VPtlErL5fcwTx5dyG
 6FjhzDSkh0ea/JM43Y0tKtSzw8vGWIo3yRPw+yVUjBdi9xltymrZe
X-Received: by 2002:a5d:5f83:0:b0:374:c977:363 with SMTP id
 ffacd0b85a97d-37a43154e86mr10605603f8f.24.1727187121207; 
 Tue, 24 Sep 2024 07:12:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHauz/5KH6yAD2lcHRhO+EICPyUmEjrlLUJOxp23UlW0mlv/rqXLM5VtuD0I1DmioSW8oyBw==
X-Received: by 2002:a5d:5f83:0:b0:374:c977:363 with SMTP id
 ffacd0b85a97d-37a43154e86mr10605590f8f.24.1727187120849; 
 Tue, 24 Sep 2024 07:12:00 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cbc318803sm1678465f8f.94.2024.09.24.07.11.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Sep 2024 07:12:00 -0700 (PDT)
Date: Tue, 24 Sep 2024 16:11:58 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-devel@nongnu.org, Mark
 Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: Re: [PATCH v2 1/3] tests/acpi: pc: allow DSDT acpi table changes
Message-ID: <20240924161158.1212f1a8@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240924132417.739809-2-ribalda@chromium.org>
References: <20240924132417.739809-1-ribalda@chromium.org>
 <20240924132417.739809-2-ribalda@chromium.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.09,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Tue, 24 Sep 2024 13:24:10 +0000
Ricardo Ribalda <ribalda@chromium.org> wrote:

> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

Acked-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  tests/qtest/bios-tables-test-allowed-diff.h | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
> index dfb8523c8b..f81f4e2469 100644
> --- a/tests/qtest/bios-tables-test-allowed-diff.h
> +++ b/tests/qtest/bios-tables-test-allowed-diff.h
> @@ -1 +1,16 @@
>  /* List of comma-separated changed AML files to ignore */
> +"tests/data/acpi/x86/pc/DSDT",
> +"tests/data/acpi/x86/pc/DSDT.acpierst",
> +"tests/data/acpi/x86/pc/DSDT.acpihmat",
> +"tests/data/acpi/x86/pc/DSDT.bridge",
> +"tests/data/acpi/x86/pc/DSDT.cphp",
> +"tests/data/acpi/x86/pc/DSDT.dimmpxm",
> +"tests/data/acpi/x86/pc/DSDT.hpbridge",
> +"tests/data/acpi/x86/pc/DSDT.hpbrroot",
> +"tests/data/acpi/x86/pc/DSDT.ipmikcs",
> +"tests/data/acpi/x86/pc/DSDT.memhp",
> +"tests/data/acpi/x86/pc/DSDT.nohpet",
> +"tests/data/acpi/x86/pc/DSDT.numamem",
> +"tests/data/acpi/x86/pc/DSDT.roothp",
> +"tests/data/acpi/x86/q35/DSDT.cxl",
> +"tests/data/acpi/x86/q35/DSDT.viot",


