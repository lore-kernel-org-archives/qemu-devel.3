Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E58A0CD343B
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 07:55:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKtZO-0000jN-Qv; Thu, 07 May 2026 03:54:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wKtZM-0000gA-Ra
 for qemu-devel@nongnu.org; Thu, 07 May 2026 03:54:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wKtZL-0002Dx-7j
 for qemu-devel@nongnu.org; Thu, 07 May 2026 03:54:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778140490;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=9nEqXQIpDAAUM4QmBWfMK4xpa0WyRLB2GLpqptQygQA=;
 b=M0C4QmU/DwBeOLyj/550KCjw8dD2yq8nni7wgVOb2p71dx7cu11yA6iaqWOeTDIJ3S3Pcv
 bkEkaPb1W3940Cs8hhMsjZbQVnK6XuUuGSBvc7L3z4ooacYSlbSJ+rA3gPey6z7ndioPXE
 /Fq5EMayT3bQjjRokkEbLdYhGba5BhY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-436--niWY5SHP7WdgQVh77kvMg-1; Thu, 07 May 2026 03:54:47 -0400
X-MC-Unique: -niWY5SHP7WdgQVh77kvMg-1
X-Mimecast-MFC-AGG-ID: -niWY5SHP7WdgQVh77kvMg_1778140486
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-48d0889c1ecso3644525e9.0
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 00:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1778140486; x=1778745286; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=9nEqXQIpDAAUM4QmBWfMK4xpa0WyRLB2GLpqptQygQA=;
 b=ktcGIOfVJMrrbkdAaUa3jknwkCvTpSoD49aAcFL5spaRB0AxKr6jEQoFpQP07MD6Ra
 RxY0+3tL7XcYIRHJknd4lv6uWkOinGJtbjUwzKaTmXjHndEulgeXwOVmFcT8S6HTqI2z
 r+2oJ1gB/gD0lqTbvBzSiAsIeYVHXFlY5n/gELgF93jc1bNqjvGmde+fcx2le52piM+r
 N5bqjSgCmTHYKuQBjanHg4WuBoN2OSEXWz/Jbqx4qMdi/0+jhuDdCpH9zp7J9g3abSJv
 Ze4IL3zSWvifbUksfrJ/UxfaAQi2f9x4J6OXiYvUxy+xy+Fdx2uBw0gmon/HOXx50tZR
 v0Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778140486; x=1778745286;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9nEqXQIpDAAUM4QmBWfMK4xpa0WyRLB2GLpqptQygQA=;
 b=VKjyXDuJfNNHAIvQKD9XNye1YAaHlo4B8x6sdZaaT5OpTN8pja6uRXWoVRiEQR/2PI
 oGB8q8o+10d1uLBOMkX13xRM1bbZrgvHw79bYEXvNOIqriDen8RNybK1lGXBwvUmvfga
 Uu0HGYfgN2u+NrRmdy+mEATXmL6lALulm+hxEMQG3lvhffkV7Clj5e8st5VzA8Elx6pS
 QDUpMrMp8BVaSxlaCTOzkBR+XNM1jwGdN0dh8Kch99iqkf1mocGsl/KSheMBMyYkTtdD
 y4VA1QpsAbWBVXmRr3SgMeAakalgNLSZhBdwx2T2GDUddtRc21UCSoct8F9GN7sJ+6d3
 fYAQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/i3FddvOAH/h01sd3QsqrCdhjH9QK1blbwStcz82+AqA1QASPpZ/v3J/qV8KhPoP464p8Bdry1fBfw@nongnu.org
X-Gm-Message-State: AOJu0YzAi7AUiPY3iyIvUkIKanZ2U31dkPgcJiNINRwmisr6Floh3WsS
 6GNVDewByytf0LKR0b0zEuDNeY+uy71cFNay5lppga1KgHOPyr32MB2zURME2Qk3TCGeiskWGAh
 KphaPa9XaIXNXHn2z2DBdg0vDRfDu7L/fpK03ciNYMmwJV+hlGUap7Mkp
X-Gm-Gg: AeBDietDpLWBYks6IP4a+wRIv+La1iqeoPhD4mQsJNKWGGNsgBpYrFe3YCRpBS2W7Yz
 kvukIssBuqVNkBvneKYl4s4FuwcWY5uYrhPMuVxWTNDcD70wfO9SnAc2TArSPmD0QTFwutf8m1f
 vJssvKUfvZejoRAedYjYV6gn0/YEfPweI0H1aeEvnczRfcvfsbn1AlQPwjU5n2EUdErhvXqyIBn
 yMY1l1vl/V7H7L+7b2S0Cuoz60WVI8OusicvN4XhHCEw4po7hX/zUUEiy0hzAmrcXNI8+PT6/RS
 5J0UF+facQE1CI5lPcT3CzQbCZtbQ6fOmUfQDxFK6owg4vZvnTh1WF+GTM0vvfM3cf5JAwhUWHI
 WzAIIUbpE216ryD1zPNzdfWZY70+NKZNStf4+6mivJrueiKrdHMyH3/yqpgSDBzY6CItwWNY=
X-Received: by 2002:a05:600c:4e0c:b0:48a:54fd:54ea with SMTP id
 5b1f17b1804b1-48e51e21378mr123353215e9.12.1778140485891; 
 Thu, 07 May 2026 00:54:45 -0700 (PDT)
X-Received: by 2002:a05:600c:4e0c:b0:48a:54fd:54ea with SMTP id
 5b1f17b1804b1-48e51e21378mr123352545e9.12.1778140485403; 
 Thu, 07 May 2026 00:54:45 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e538c4ae1sm100766955e9.12.2026.05.07.00.54.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 May 2026 00:54:44 -0700 (PDT)
Message-ID: <2145c818-53f3-4c05-9e96-c070ad5a2429@redhat.com>
Date: Thu, 7 May 2026 09:54:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/14] scripts/update-linux-headers: Add typelimits.h
To: Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Maor Gottlieb <maorg@nvidia.com>, gaosong <gaosong@loongson.cn>
References: <20260505081423.28326-1-avihaih@nvidia.com>
 <20260505081423.28326-2-avihaih@nvidia.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260505081423.28326-2-avihaih@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
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

+ Song Gao

On 5/5/26 10:14, Avihai Horon wrote:
> Upstream Linux added include/uapi/linux/typelimits.h and includes it
> from ethtool.h [1][2].
> 
> Teach update-linux-headers.sh to install that header into
> standard-headers to be able to update kernel headers to versions that
> include the above changes.
> 
> [1] ca9d74eb5f6a ("uapi: add INT_MAX and INT_MIN constants")
> [2] a8a11e5237ae ("ethtool: uapi: Use UAPI definition of INT_MAX")
> 
> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
> ---
>   scripts/update-linux-headers.sh | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/scripts/update-linux-headers.sh b/scripts/update-linux-headers.sh
> index 386d7a38e7..da367acee7 100755
> --- a/scripts/update-linux-headers.sh
> +++ b/scripts/update-linux-headers.sh
> @@ -60,6 +60,7 @@ cp_portable() {
>                                        -e 'drm.h' \
>                                        -e 'limits' \
>                                        -e 'linux/const' \
> +                                     -e 'linux/typelimits' \
>                                        -e 'linux/kernel' \
>                                        -e 'linux/sysinfo' \
>                                        -e 'asm/setup_data.h' \
> @@ -250,6 +251,7 @@ for i in "$hdrdir"/include/linux/*virtio*.h \
>            "$hdrdir/include/linux/pci_regs.h" \
>            "$hdrdir/include/linux/ethtool.h" \
>            "$hdrdir/include/linux/const.h" \
> +         "$hdrdir/include/linux/typelimits.h" \
>            "$hdrdir/include/linux/kernel.h" \
>            "$hdrdir/include/linux/kvm_para.h" \
>            "$hdrdir/include/linux/vhost_types.h" \


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


