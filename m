Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D544C28B30
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 08:22:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trYNR-0006Yx-Gl; Mon, 10 Mar 2025 04:20:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1trYNN-0006Ww-P5
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 04:20:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1trYNJ-0004Te-C1
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 04:20:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741594836;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UCM9dXn15rLwLcvlKZl6PXYwnCCp9W+9SEavEczkTNc=;
 b=byGpox+dHcGKOrJazYOb1d3MsJBYhqfHiSei1KuKRQqEGaL8bkKaBwTIC/oIvSLTxz3e7j
 j0eBz5rcbp83zncH8ito+4C0QuwituHTRJM7jy+x3EsoEg1y6DiXiB0+qRY2rSlDMUaS4j
 3yZo5T++8LnNgdxbDmNCBQIs8gX+r/w=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-344-IrwgVTeFOQCvdg-FLHHd0Q-1; Mon, 10 Mar 2025 04:20:35 -0400
X-MC-Unique: IrwgVTeFOQCvdg-FLHHd0Q-1
X-Mimecast-MFC-AGG-ID: IrwgVTeFOQCvdg-FLHHd0Q_1741594834
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43ce8f82e66so6272215e9.3
 for <qemu-devel@nongnu.org>; Mon, 10 Mar 2025 01:20:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741594834; x=1742199634;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UCM9dXn15rLwLcvlKZl6PXYwnCCp9W+9SEavEczkTNc=;
 b=JpbeHYlpzLA6h+pHpnhmeU4foELddc0ocOpRCHQHwDSiljdSZ9xmiUEM27dUTpnUmW
 CF5xxayIuEGE78BWKnwhtu1Bs04lrgCDAk30s/VL6OcO1ehuZTlA4gu534knH3ReE4p9
 19uXTT1LGxEOmip1zqduAgEFG9d7EzKQF3kP4mZqDr78igl5LSIagOjDlw1jqQbkdtTF
 gnZhxLCuJqh+Z+FzaCs6kZ99/uw+/1CBjrvU0TSvXd8nv/j9U1DIREJo9O2mbW3R5OIs
 2wtf6eTYVv8bzxyO4hktmYAmNewaC73IvMlmZAZENz3cjeJkdl0DoCxciqB+JeWfV/dU
 Kwjw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUekvETXUYQ+Vad4huZHyf9LmXC04HRT7MATSI5bIqNCUyijcYby+jSERxu+nzTTuG1mbLWsRDcKST0@nongnu.org
X-Gm-Message-State: AOJu0Yz1eFQyg3WbqbpywMAJC1IcdAW/KTBqJLKwdNNwgNtwmXpNzg3/
 1Dz9B7Zqyei+e+Ce7tJab7oTaIwLw4xSgVm3sGDlGsYYYChSWAu8uLR6vc7gKR0nesKCLk8mRVa
 QQWbIzT5+IFksaHG6Y38XG1C3677yMqudnQilQ8TrOBWpiqvJSoab
X-Gm-Gg: ASbGncuE5txpdPwnsiKnHrqGNzgkqgAVRHrkNPfMg+VCq5W77JcLYsEho0V2O3ZxMOf
 w+QqlRZYN+7DLt/QJvYx+Leuf9UPY/suMU2HYuX/x/rcsNdd54456Q4b5+45k8D5pdzOAin9eRi
 JeoVX4VzEKzncICUbsvktxMu4zGroNZjzK9AKaWQQiquT9nhjU0KEiwass98XaAv+s+QRB0fnMD
 PeADYj0CTdiXuH/sQhaH+P/e+o4OIa96mFRW+xr7zbqDgkxPXSlxLdzyPZQgrtiXyw8r+sihCKW
 IAgWn5unmSjR/oyZGTa2P7qfc1Hcbu0e287/jnz/r8JcjC8hxYbY6qUwPq023h4=
X-Received: by 2002:a05:600c:1c9d:b0:439:86fb:7340 with SMTP id
 5b1f17b1804b1-43c601d19cbmr82007725e9.30.1741594834136; 
 Mon, 10 Mar 2025 01:20:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGWoK4EAIS0nSnutdbr8yrKOmHxyHj64VreYaZSyts7twzU5fEMveCdB0GYj6APXBpf4tzW2g==
X-Received: by 2002:a05:600c:1c9d:b0:439:86fb:7340 with SMTP id
 5b1f17b1804b1-43c601d19cbmr82007575e9.30.1741594833763; 
 Mon, 10 Mar 2025 01:20:33 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43cfac24345sm17644355e9.22.2025.03.10.01.20.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Mar 2025 01:20:32 -0700 (PDT)
Message-ID: <1af5a147-f5ff-48c1-a2d7-ee4d98c12da4@redhat.com>
Date: Mon, 10 Mar 2025 09:20:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/21] hw/vfio: Compile more objects once
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Tony Krowiak <akrowiak@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Halil Pasic <pasic@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Tomita Moeko
 <tomitamoeko@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Eric Farman <farman@linux.ibm.com>, Eduardo Habkost <eduardo@habkost.net>,
 Peter Xu <peterx@redhat.com>, kvm@vger.kernel.org,
 Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-s390x@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Richard Henderson <richard.henderson@linaro.org>
References: <20250308230917.18907-1-philmd@linaro.org>
 <20250308230917.18907-5-philmd@linaro.org>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250308230917.18907-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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




On 3/9/25 12:09 AM, Philippe Mathieu-Daudé wrote:
> These files depend on the VFIO symbol in their Kconfig
> definition. They don't rely on target specific definitions,
> move them to system_ss[] to build them once.
>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  hw/vfio/meson.build | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
> index 8e376cfcbf8..784eae4b559 100644
> --- a/hw/vfio/meson.build
> +++ b/hw/vfio/meson.build
> @@ -14,13 +14,13 @@ vfio_ss.add(when: 'CONFIG_VFIO_PCI', if_true: files(
>  ))
>  vfio_ss.add(when: 'CONFIG_VFIO_CCW', if_true: files('ccw.c'))
>  vfio_ss.add(when: 'CONFIG_VFIO_PLATFORM', if_true: files('platform.c'))
> -vfio_ss.add(when: 'CONFIG_VFIO_XGMAC', if_true: files('calxeda-xgmac.c'))
> -vfio_ss.add(when: 'CONFIG_VFIO_AMD_XGBE', if_true: files('amd-xgbe.c'))
>  vfio_ss.add(when: 'CONFIG_VFIO_AP', if_true: files('ap.c'))
>  vfio_ss.add(when: 'CONFIG_VFIO_IGD', if_true: files('igd.c'))
>  
>  specific_ss.add_all(when: 'CONFIG_VFIO', if_true: vfio_ss)
>  
> +system_ss.add(when: 'CONFIG_VFIO_XGMAC', if_true: files('calxeda-xgmac.c'))
> +system_ss.add(when: 'CONFIG_VFIO_AMD_XGBE', if_true: files('amd-xgbe.c'))
>  system_ss.add(when: 'CONFIG_VFIO', if_true: files(
>    'helpers.c',
>    'container-base.c',


