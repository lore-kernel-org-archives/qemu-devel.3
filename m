Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AACFE7BD80
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 09:52:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrvGk-0006RL-24; Mon, 16 Feb 2026 04:51:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vrvGj-0006R7-1f
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 04:51:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vrvGh-00076k-Hg
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 04:51:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771235510;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FWUpQhnc8s7yl5iXYvAuEslZ3YZzVUjypZpTLTHqQtY=;
 b=MVwFXEQLv8f7GjH8Q55J0FoGbrT5x9b8Z2Y6S8w6VsGTg1ERMqo5xn21pw3C6Yu0AhL+7K
 JiakKH+KSDlFDWxA0c4gsDVNHVo3u2prqfAGxRzd7NRGy9hI8xcN6wlAfVKKQMozvt6OhE
 GrpIkms8zEB9QZssHoIYxeKY0zsJEPU=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-tIqgOsnaPMCeXzYh8Nl0RA-1; Mon, 16 Feb 2026 04:51:47 -0500
X-MC-Unique: tIqgOsnaPMCeXzYh8Nl0RA-1
X-Mimecast-MFC-AGG-ID: tIqgOsnaPMCeXzYh8Nl0RA_1771235507
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-897021ebe91so217124356d6.0
 for <qemu-devel@nongnu.org>; Mon, 16 Feb 2026 01:51:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771235507; cv=none;
 d=google.com; s=arc-20240605;
 b=e2Q3enVOVskP4pSxnCwl7lU76y6cWp5TulXaPZy3L9sTjuc52fNfxDnuWTqR0Nvs9N
 yfegH9r89AxO8IJv4j1xa12rHBp+vf/8k7ben8nUU5ybmD3wB2RCYsGIFpXlX1MqdG05
 d0ttNtnLgimLCRYlqYgf2lP2Tl9DfFiER641y+P6K8Kma3suYCEP/WIPNLokGTB+n3xJ
 HZdxixuhTXn/+y0Kana2Zzthfr5RIkWA+1xBEi9xrwSmORn8qtLAQRnc9r1a2TPwNn6m
 Um6EvNeASZarnoydeHPNIMhlhc4ddgm0uzI0r7deLKf3VJT/Af79vX1+1KP1crKFDj6h
 3wqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=FWUpQhnc8s7yl5iXYvAuEslZ3YZzVUjypZpTLTHqQtY=;
 fh=sIsIOvEHAUniTyi3GhO91uUMlcdX4avqzqeMhQBuOOs=;
 b=Q3SL1PnfLTI2fTLrJ0kL6Kp8OVqVYYZ4rNYExH9Lnx+svt5V4HGdvT8vYHpQpOZxgs
 pVMB/yVzxItaZyUvTpL8KN4gVmhhLlYE14B/LZ/XC7qZleb8KsE66ttG6NFqxaqh1A3E
 /sxUKb34kSwUT8RKZhkGn6vqhk2HgsGC/+3oj6hyS+oLCLBQCnK9TosNgpfJxUXW4S9C
 Jnn35ja2DHY+Hc2a9NlGrbYpTC5nusA8BxxtN5vfZrPF7X6j9zRMB8kOP3lawsBN/1Cn
 dbKHioxKAu6/gNuyg5n1pK8LGLt/YwQbp4s/609mUe90icgyL2aroDcmQyxYvk/JQcT1
 H2dQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771235507; x=1771840307; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FWUpQhnc8s7yl5iXYvAuEslZ3YZzVUjypZpTLTHqQtY=;
 b=O9k9juRzUvkx7quphZAv4cdqkrSNZQE0vPti7UgiKaucm9DagB9x5mAqEjiosRQK9l
 i4r+0m9sk118d0zNp8jVoP/MvSkqIVcS1WLf5hr5Uc/D36v7plfXzhDWgZgKifo/LDSi
 9YnKnECd7Ngsu6ElnZgj5hiNA1b/q1X6UUV66FliZ2a4x4t8KdfL72iydTEqRvd+B5NK
 I4h2QmpLCC62g+8cvFtGzAxG0jFLU3x82lzDxpy9xlyr3JZWehZWbz78I//zHvMAfLZ6
 a+9sv9pCdhKIOnBsZqxO5CBqZkLP+fmcS4a4MK/rnMmSKGBJAZkfDNOoO6V3GUxPwfAX
 5uEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771235507; x=1771840307;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FWUpQhnc8s7yl5iXYvAuEslZ3YZzVUjypZpTLTHqQtY=;
 b=dcmqtS17lf6ksAnOGKowxDrbMZiC6PFiC1JDLY7q9V+4kPPljbqSslcpzSq9bqKXfV
 fQLibXWZYc3UgwCLGsXBm8D70ReWwBYMWFRxasSnMOwq5jDgQMk4uvB6+mFOJW5hCcuc
 ShQUJjq0mF81bUhG3GNZ7rRbuDevtyE6Fdiys6u2D3y0EuTd2eCRbPJvNDIjbzfzAjWX
 dsPybbUQsVxWgfUz45KQ96W/lgtETdc8l8ULa36mkkKIIz0+V1IRPVtjkj04efTfPB0N
 W5d+dSHzTdmvDPcsY/9ULGuPj92kOC5fjamYB4/WDWgVbFfHHuxsed9TmWgcxAh6YGy+
 OW7Q==
X-Gm-Message-State: AOJu0YwXJF4rDjgBoF+YUiMbhxZXrS3h95mDZfMihD2DcTmY9Jmo1JIL
 RO5YIMezTuOoGirPBxEKTxAjsKuRarP0BNBFISehEWGlqbjLAKT5De6wOxK8GCJ4SKT+m8poXWj
 QybKp5Leu58x/ZZKhqWcC8Wn6QIe4ztzJfkm5woSXDb+lJTGSUDPdALEIfv5j5W/XLjPhXYJblc
 3ScxTWBT+Y9IsDw6SsutH/2GW3ux2GiSQ=
X-Gm-Gg: AZuq6aJN6MBNlK+z1TmAe4QmQCfH2FDaoqNIzzgx1XJrQ/R23pM6QJJr3mOsoG1G5da
 UsDNWYOj72zOW2uqINV4ZQcv6mxJMAZslicYImQ4DCsJTsaPQHxy39mD5ak7WCNYxiHwjI5FynR
 9W6E0MnRr4Bw6nk8PJL8JPYFgMcafCdSlIlUSLqfRrhfGrCF8zn/wQ5sw1PydxH+C/btvWzStwq
 VPvdKjdrVZmEl6EQkUqKDmEolzO8B3RZ2U8
X-Received: by 2002:a05:6214:21a7:b0:88e:b33f:dc08 with SMTP id
 6a1803df08f44-8974047bc8bmr112606586d6.39.1771235507130; 
 Mon, 16 Feb 2026 01:51:47 -0800 (PST)
X-Received: by 2002:a05:6214:21a7:b0:88e:b33f:dc08 with SMTP id
 6a1803df08f44-8974047bc8bmr112606406d6.39.1771235506685; Mon, 16 Feb 2026
 01:51:46 -0800 (PST)
MIME-Version: 1.0
References: <20260206131438.1857182-1-imammedo@redhat.com>
 <20260206131438.1857182-6-imammedo@redhat.com>
In-Reply-To: <20260206131438.1857182-6-imammedo@redhat.com>
From: Ani Sinha <anisinha@redhat.com>
Date: Mon, 16 Feb 2026 15:21:33 +0530
X-Gm-Features: AaiRm527P547kHWAU-9wXS8fjB09es__pSa30Gbc0N6a1Z3mqGich4HBLWBMgrA
Message-ID: <CAK3XEhOSLVF5+XoNykscxsNKYYYQ6ECw1X6_h8a+-YE27E+z0Q@mail.gmail.com>
Subject: Re: [PATCH 05/11] tests: acpi: x86/q35: add WDAT table test case
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

Reviewed-by: Ani Sinha <anisinha@redhat.com>

> ---
>  tests/qtest/bios-tables-test.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-tes=
t.c
> index e489d94331..25345dd035 100644
> --- a/tests/qtest/bios-tables-test.c
> +++ b/tests/qtest/bios-tables-test.c
> @@ -2511,6 +2511,18 @@ static void test_acpi_isapc_smbios_legacy(void)
>      free_test_data(&data);
>  }
>
> +static void test_acpi_q35_wdat(void)
> +{
> +    test_data data =3D {
> +        .machine =3D MACHINE_Q35,
> +        .arch    =3D "x86",
> +        .variant =3D ".wdat",
> +    };
> +
> +    test_acpi_one("-machine acpi-watchdog=3Don", &data);
> +    free_test_data(&data);
> +}
> +
>  static void test_oem_fields(test_data *data)
>  {
>      int i;
> @@ -2805,6 +2817,7 @@ int main(int argc, char *argv[])
>              qtest_add_func("acpi/q35/cxl", test_acpi_q35_cxl);
>  #endif
>              qtest_add_func("acpi/q35/slic", test_acpi_q35_slic);
> +            qtest_add_func("acpi/q35/wdat", test_acpi_q35_wdat);
>          }
>          if (qtest_has_machine("microvm")) {
>              qtest_add_func("acpi/microvm", test_acpi_microvm_tcg);
> --
> 2.47.3
>


