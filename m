Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAAD0CD5BB1
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 14:42:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRszX-0004nu-NZ; Tue, 26 May 2026 10:42:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1wRszV-0004nH-UG
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:42:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1wRszU-0007YJ-DM
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:42:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779806562;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a255s164HAm9o7qkW3oCTBTqj2pDeTqJeUB4WXZ70ic=;
 b=cGgARliG5TDGwTLibc/3dlpFtcLKxswY4uyOyf/5E3MG5oyiNcjj/uJmiY0BV6kQaJszmK
 EbzjpwD/4pIfDtzR0DU4l63F3EVnbxFYrt+/1K9YIj0Bgxo/dL+zOLdDlaGjbsIZ8B4FV7
 ID8f4MNEKjyaFE4MZWHIUbiWEOT2Cyc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-dlNdh9AgOfqQW_QbfEb9Mw-1; Tue, 26 May 2026 10:42:40 -0400
X-MC-Unique: dlNdh9AgOfqQW_QbfEb9Mw-1
X-Mimecast-MFC-AGG-ID: dlNdh9AgOfqQW_QbfEb9Mw_1779806560
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-45e73a4f1dfso7669226f8f.0
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 07:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779806559; x=1780411359; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=a255s164HAm9o7qkW3oCTBTqj2pDeTqJeUB4WXZ70ic=;
 b=UZCbwM+Cg9GnqV43ob5Wh+OdwsePNghzEvP9dph9ZbrNmCV/iOZiiSIiFeiEMOZH61
 IVX1sJBAC2QOEfolv4vyr+BYM8z2PQFyoh0GzGIt1x/b4z25HAa+O2cssoGFN+hWSyU6
 6f5/6yHntOiD8WqPdAquWmHrNGpyplaUwbhFppp8cRpoVTPkcU1z3JS98AigYvNsdZkO
 Au7oyBe5R/3StvXSk2SCEzqAA5yjLdKZzSkaHQ3lDHzLsMNA/UpMnD1eEgVbcKj+BO/C
 DiKot9Ky+Tn4bmxujmbbZ1yT00bs6HwTdD2ZDbzm0vwBydGjrFqb+1AhUWQGOZrGX28C
 kCSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779806559; x=1780411359;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=a255s164HAm9o7qkW3oCTBTqj2pDeTqJeUB4WXZ70ic=;
 b=bwY06Pspjb5jc9XkzoZAPv4LYgMPYOuQZkjclxTgoobPPxx4oGdzKSajQlL1z7uq78
 uBJD1V3RNUtFdFjMY35aMO3Fbi2aFolRMZuD+ImHgDu520bG8+z2FxG6dFFlU+/4yd06
 yN0SeXbylU356ShQUghTxBrUJB7FB7YK4ujVHO+Mrz6Ljf8ZKoaVQPMkTFYGLe4uLK5u
 5EH7o0XCpK1U79eBMQr4gZBmAt3jpGazmP4e1SBBKWvVGUe0PK/ZqRUHPBhPlgXRRpLe
 vZxSx/x51a1cNDazROBwRrp03XJ/gCXgmmUTzQPFRdQA4rYTUcXpt/AaaqZh7N2ww56T
 cgcg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/jRbIS24WQGw222uGD6w2TZRUNlG2+6Rj3pPKk/F7PL0EFfDrjSIK5LmuKmHR/RBxxPfiFtw59VzwF@nongnu.org
X-Gm-Message-State: AOJu0Yz9qNM38N27YtPJUbY7QaSezTKDhg1QrAj1wPAML7vM2tw/AZ+7
 UuTs6zwFeFuWLVi+PHI2UvVEeN0bDVAxnQOQ2HSMYvTaBl5fK+SFmuPSZCLC0/6s88Hh/kKuk+q
 JcBZ2pYySZNxFrhcCvyFjzSbMS+XegAVBYXA9Ku7iodCzg9nv56ye5AQ1
X-Gm-Gg: Acq92OFz1qzAmxMYjfq72NSmWcyqG91VLRzKWOjZBBZYp408/Btzl73Q2IH7UBbOhNc
 FbibYWDkkXDXKEWBXS9VkzWCN3X0D/UTAxvGpa2CuUDWgHhgFlHmpjeUOk7OIGphaKTfJLpolkV
 EiI9fgTrgKcnBBs14U1q87+7MBlQMb80TEOM4MDENAqbXzDuaqMc9rQEQXZ1AL8owNyxvtdxorY
 FhQpq2jePGXV3pu3ijaplRClp8BZg1JKhSvFBgRkInqxW3TeavHEfQ+atOifmyAG2yBPW4PBnKG
 BK1Ucp9zSfISbwfCiUVIdz8ezAakCTawsU4MY2Qf7sNaZ28vn2oNWAQ3f74eBQs35t7zpQESNpu
 HXGzXjQlG/JIRJ4kpX9L9AGHWeB+i1t+Kcl4hLTsufumdqpoWKvvxbuLa8rIuPIre
X-Received: by 2002:a05:6000:430b:b0:43d:75a2:44aa with SMTP id
 ffacd0b85a97d-45eb38e4db6mr31398736f8f.43.1779806559634; 
 Tue, 26 May 2026 07:42:39 -0700 (PDT)
X-Received: by 2002:a05:6000:430b:b0:43d:75a2:44aa with SMTP id
 ffacd0b85a97d-45eb38e4db6mr31398673f8f.43.1779806559122; 
 Tue, 26 May 2026 07:42:39 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6c9f58dsm35464125f8f.5.2026.05.26.07.42.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 May 2026 07:42:38 -0700 (PDT)
Message-ID: <06ae19c4-5f92-4d5e-8ed5-55543cccca8d@redhat.com>
Date: Tue, 26 May 2026 16:42:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/21] tests: acpi: arm/virt: whitelist new WDAT table
Content-Language: en-US
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com, anisinha@redhat.com, pbonzini@redhat.com,
 peter.maydell@linaro.org, shannon.zhaosl@gmail.com, philmd@linaro.org,
 zhao1.liu@intel.com, rad@semihalf.com, leif.lindholm@oss.qualcomm.com,
 qemu-arm@nongnu.org
References: <20260303092532.2410177-1-imammedo@redhat.com>
 <20260303092532.2410177-13-imammedo@redhat.com>
From: Eric Auger <eauger@redhat.com>
In-Reply-To: <20260303092532.2410177-13-imammedo@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eauger@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



On 3/3/26 10:25 AM, Igor Mammedov wrote:
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  tests/qtest/bios-tables-test-allowed-diff.h | 1 +
>  tests/data/acpi/aarch64/virt/WDAT.wdat      | 0
>  2 files changed, 1 insertion(+)
>  create mode 100644 tests/data/acpi/aarch64/virt/WDAT.wdat
> 
> diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
> index dfb8523c8b..135186b40b 100644
> --- a/tests/qtest/bios-tables-test-allowed-diff.h
> +++ b/tests/qtest/bios-tables-test-allowed-diff.h
> @@ -1 +1,2 @@
>  /* List of comma-separated changed AML files to ignore */
> +"tests/data/acpi/aarch64/virt/WDAT.wdat",
> diff --git a/tests/data/acpi/aarch64/virt/WDAT.wdat b/tests/data/acpi/aarch64/virt/WDAT.wdat
> new file mode 100644
> index 0000000000..e69de29bb2


