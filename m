Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C43DC982F1
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 05:17:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8srf-0004E2-NB; Tue, 22 Sep 2026 01:16:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1x8srd-0004Dg-BH
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 01:16:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1x8srb-0004iQ-P1
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 01:16:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790054178;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=HVFdA97VZP4rXuP/XR+or/06d+2fuFAhQslzPVre1gY=;
 b=f/kO0gkHpl76sAJGCY1DMZfpDko5iK7SmU+2ZMtejpvQCqbPjT5vLNxWOQx31G8JhYPErk
 9DnWkA89ao2kMWnCl9AFH0CJWdlb6t5IQ7ti6Wl+f20k/jVMxQYJjTvzob6Uue3pMijdZ8
 K0cq7OTIFyu7zJmjJWoX+bnxpO0dd/Y=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-203-rj_oNGhdOQKOYB4YkuFhJQ-1; Tue, 22 Sep 2026 01:16:16 -0400
X-MC-Unique: rj_oNGhdOQKOYB4YkuFhJQ-1
X-Mimecast-MFC-AGG-ID: rj_oNGhdOQKOYB4YkuFhJQ_1790054175
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-486f9d150c3so1634204f8f.3
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 22:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790054175; x=1790658975; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=HVFdA97VZP4rXuP/XR+or/06d+2fuFAhQslzPVre1gY=;
 b=PKnj7RDi+tzQoTSLKD6pPhiAgIzFwC7yfPA+0xR/RSbnCbmIb3ivgf4epTlgxoTJEJ
 UdcAWp8GcE7SIuC1HvwoZAtuk+Eondp6bbCeQkKm8z9KNi2+17Rf+ONx4In+FAgT+ZM0
 w9/9OzuncgkzejGvyquJKvpg4vWotiIwPzQtLWMh/Ihbgmk6feCRiPAIBc7rT0WzWPwJ
 qo9/8U8pXduC41iLWTOaPk8n0EIGfnjHEFrWXNh0QuQQLD6d8eXk55mFAlMalDmD76hD
 otZAVAc24wSotKb/U0K8GeAFIhC9K3Nsb+XUFkpBEH0ijhoRcOsEPX8LEvKamef0Uv29
 j11g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790054175; x=1790658975;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HVFdA97VZP4rXuP/XR+or/06d+2fuFAhQslzPVre1gY=;
 b=IV1an3ftAn/Ch4NtJUD0/LEpkAhQ2fsSue7AsjqavHD383M3jz/kedT4QM+y5zGwHj
 tzBvY3VPuxN1Xl0nwIRLlINDht4sFrwFVdxwGfQcoI3Err/LIVvuGzRhuQIJU0XaDMG6
 aPD/OvOsucmHPQVL2hlrkfsALuEus/oRDIM+Fko1XGVPRGOe+ve5AuNB6wkQyPftS7l9
 8EUSsCO2wafpa9yBUK6web9Hhjf6MZlsT3i4zVqNDWoUuU5BAwc3Y8U0IiSbkTVZJ/ji
 Xfxqhvbd5rVlP8Yer8Leng70+xjsf6DNi0CRV73Q+r3j1XLEpRw9iS7dnXdYLfJzlf0O
 il+g==
X-Forwarded-Encrypted: i=1;
 AKwUvBybOMjVvBvK1UKrLZ/yedQ9P8hNp0hpak/nW7RFNKWMGCxtXS2MYfoKPX6Q4RwdNKnc4dTJpz/FtxLu@nongnu.org
X-Gm-Message-State: AFuF++nCOPZndX1BbdeZ/xCGYlPa4aKdt/92GBzB3aFbqhV5gAOL17tj
 e1BPsa4KpD4EqNwM1JAmsAYRCR1Fg9XVFIA1J5g446PtRSFRejTas5bjeVM0z5OMiueRkxSvsoB
 A+D/o0YPO1OUDT2EeX0EtWrgcQbPYVfmyCraLMo1254ZtxX9OdYcWxiQj
X-Gm-Gg: AYBFou3i6mIth/MzT+ayf2Kd+QmbzNN0CydEBvtuaCeIEP5Gtq4BD5S7jhlsaL1eR2v
 4UU4p3P1SYwbgX7R6CSD+q/WEb9gLe2uB6hEoP5UaNQNAhUdxoRiks1cF4iMbqWiDHOmwlAUB95
 st2Ssh1E8f3zX6ktwflYeanj4WkRlehgN+3Ocp+ppvCzlTBXh67RRzPN9k9p1RsWpwx3gzrTUHj
 uhRyBo/2zQCBlgSaC8+ScLaJOhSFNKA/JItjd7kA9HlXt+21LJTKzxbhmCKUmH2wSJ5ZNEFe4lj
 gajrgZnf9EfqW2D4hxm4LuLS7mJZA4B7O6wBV3JE6woMpQ2IleE6r/3ogmJ513TefXkrfd7d
X-Received: by 2002:a5d:64c6:0:b0:487:27f6:a4d4 with SMTP id
 ffacd0b85a97d-48727f6a6f2mr13837400f8f.36.1790054175532; 
 Mon, 21 Sep 2026 22:16:15 -0700 (PDT)
X-Received: by 2002:a5d:64c6:0:b0:487:27f6:a4d4 with SMTP id
 ffacd0b85a97d-48727f6a6f2mr13837380f8f.36.1790054175221; 
 Mon, 21 Sep 2026 22:16:15 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.113.141])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48862793792sm2416162f8f.31.2026.09.21.22.16.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Sep 2026 22:16:14 -0700 (PDT)
Message-ID: <8799d4f0-d2b9-4521-ba37-a295ff7068ce@redhat.com>
Date: Tue, 22 Sep 2026 07:16:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] tests/functional: test_acpi_bits requires TCG
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>
References: <20260921160815.1623803-1-alex.bennee@linaro.org>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260921160815.1623803-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

On 21/09/2026 18.08, Alex Bennée wrote:
> Running a full thorough test suite on a KVM-only build fails due to
> acpi bits needing icount, therefor tcg. Declare the restriction so the
> test harness can skip it.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   tests/functional/x86_64/test_acpi_bits.py | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/tests/functional/x86_64/test_acpi_bits.py b/tests/functional/x86_64/test_acpi_bits.py
> index ec716d643bf..62c57d23f6c 100755
> --- a/tests/functional/x86_64/test_acpi_bits.py
> +++ b/tests/functional/x86_64/test_acpi_bits.py
> @@ -303,6 +303,8 @@ def test_acpi_smbios_bits(self):
>           """The main test case implementation."""
>   
>           self.set_machine('pc')
> +        self.require_accelerator('tcg')
> +
>           iso_file = self.scratch_file('bits-%d.iso' % self.BITS_INTERNAL_VER)
>   
>           self.assertTrue(os.access(iso_file, os.R_OK))

Reviewed-by: Thomas Huth <thuth@redhat.com>


