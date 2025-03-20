Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C66ECC28B30
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 15:45:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvI4A-00023c-Ga; Thu, 20 Mar 2025 11:44:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1tvI3A-0001zv-L4
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 11:43:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1tvI35-0007DW-24
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 11:43:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742485390;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wPwr5oYVIaghPBmG3tNmTIpiegpJlMIqdWSy5HJcBsQ=;
 b=Vi0QT+Q7vKBQtE/xFnqps8feldhUsW2mPwf1ioaj8V1BMWs9VeogWTxBJ13DOnatm1yB5A
 XYfxGD5+a9dlEOY9EfZsBLhNZifKNfVIrwABxcQa+pI8hP6D90HIgXJZVLeIsknUbhjAv+
 IGxzE+60SubyK8vouRL12//9sL+mheM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-fqLBufWkMHiNkWopu4RiRA-1; Thu, 20 Mar 2025 11:43:07 -0400
X-MC-Unique: fqLBufWkMHiNkWopu4RiRA-1
X-Mimecast-MFC-AGG-ID: fqLBufWkMHiNkWopu4RiRA_1742485386
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43d209dc2d3so5869565e9.3
 for <qemu-devel@nongnu.org>; Thu, 20 Mar 2025 08:43:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742485386; x=1743090186;
 h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wPwr5oYVIaghPBmG3tNmTIpiegpJlMIqdWSy5HJcBsQ=;
 b=ipg11OyT+ikrsC3TL7DS8h8N7AaC38xsbzm7x5UI5/90QCqlYSSJPFnU/jQWAoL+Gz
 CWjQbTBqtQgvBc7X9vKSo5/RdvSQyvx+5+ITKBpPzQC15E0PuG9X9N3ILV6Y3SLiibDT
 tCD3anbeniIysEJZ291AwbFytbHMcuqlAUDsOMYDW+7NaT5lALqFiYM7EuJcJoJ49nRx
 Ca3Aell1NsCpJvTCP2AEIeoRy1iMLbQlF70ZSwiBErqJ+m+YLWbm/IxvF+lugu8Bn70+
 evHyIGV86QlO1MyuFBm1KmlRW2dmlqrF5IACj6gEnfHX56a03wPssDeqqnuFHCb1LOay
 alBw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVR9L7lszdnQpTC4jyzORImdT7CpTK2/JSldhSnUCGQAX9rNlBPzdm2xlwWd5w8gkVMNxF4FSQSnBb@nongnu.org
X-Gm-Message-State: AOJu0Yw0fEDQWVuZJ2XCTiZsiB7WRPp26ckbTnYASJ8NAMYYBC7Tcw0e
 uIqyWyfAjrE7gkp48YY25e/KX5okYFrv4r/6luoFbXP+XBHfQlspmqI06kIFY+obRd+oZtqpxPV
 QuHSacx9EOCXNplhgGY3r/jCmIeqX9MvfVsc7J5v00an9RMSdu/7v
X-Gm-Gg: ASbGncvJNvd4EZTTTV4wifIiwA9Ze5FrvAekHgTosiKI5ViDtFUrmIqHWgcTiSbJONZ
 hclAkSc3uVOz13ph2mUfYZ3fNolcmt3K1d7cjMT0MqdqnOmJBOnZVv7l2gFMobtmaA76o9hxUzr
 2dMHteFyPNTXAW3rJax8WtLhGQezSvtiywgS51te4mfgxa8zDX56o80OHj4SzYSnboMl8ZRo7Bw
 1xLPivoNIVT3FAMMKlRUG9rgJqaftPmQW5Vgh8YSYfzIducM4aWy7RoRHDV3CT9bKjMCFx2+RuS
 aWh6xNmfcJXmx546nfRrW4sQ2r46WD67QdN/q8hhzfdhDPC4oO+erI1mZyTqrmiU
X-Received: by 2002:a05:600c:c8a:b0:43c:f597:d565 with SMTP id
 5b1f17b1804b1-43d437986b6mr60471975e9.12.1742485386052; 
 Thu, 20 Mar 2025 08:43:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHePUYhiOBmwzpVGqlSTNpZrxiZia4aYTokS/lw3ZqG8KN7vuZOThxxGVbUPgfYbV4qWmeqYw==
X-Received: by 2002:a05:600c:c8a:b0:43c:f597:d565 with SMTP id
 5b1f17b1804b1-43d437986b6mr60471645e9.12.1742485385569; 
 Thu, 20 Mar 2025 08:43:05 -0700 (PDT)
Received: from rh (p200300f6af11ec00f9928575aec32536.dip0.t-ipconnect.de.
 [2003:f6:af11:ec00:f992:8575:aec3:2536])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d440ed4cbsm52762105e9.34.2025.03.20.08.43.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Mar 2025 08:43:05 -0700 (PDT)
Date: Thu, 20 Mar 2025 16:43:03 +0100 (CET)
From: Sebastian Ott <sebott@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
cc: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org, 
 qemu-arm@nongnu.org, kvmarm@lists.linux.dev, peter.maydell@linaro.org, 
 richard.henderson@linaro.org, alex.bennee@linaro.org, maz@kernel.org, 
 oliver.upton@linux.dev, shameerali.kolothum.thodi@huawei.com, 
 armbru@redhat.com, berrange@redhat.com, abologna@redhat.com, 
 jdenemar@redhat.com, agraf@csgraf.de, shahuang@redhat.com, 
 mark.rutland@arm.com, philmd@linaro.org, pbonzini@redhat.com
Subject: Re: [PATCH v3 01/14] arm/cpu: Add sysreg definitions in cpu-sysregs.h
In-Reply-To: <20250311162824.199721-2-cohuck@redhat.com>
Message-ID: <7c6ab887-2c9f-6646-4f0c-790671b28c62@redhat.com>
References: <20250311162824.199721-1-cohuck@redhat.com>
 <20250311162824.199721-2-cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sebott@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Tue, 11 Mar 2025, Cornelia Huck wrote:
> +++ b/target/arm/cpu.h
[...]
> +/* REG is ID_XXX */
> +#define FIELD_DP64_IDREG(ISAR, REG, FIELD, VALUE)                       \
> +    ({                                                                  \
> +        ARMISARegisters *i_ = (ISAR);                                   \
> +        uint64_t regval = i_->idregs[REG ## _EL1_IDX];                  \

This won't work for regs that don't fit this naming scheme. Up to this
point in the series that's only CTR_EL0, later with the auto generation it
will be more. But I guess this can be extended when/if there's an actual
need..

Sebastian


