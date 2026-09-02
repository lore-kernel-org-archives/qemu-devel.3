Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0ECAC61DFD
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 05:51:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1dsO-0003UE-VG; Wed, 02 Sep 2026 01:51:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x1dsN-0003S1-I2
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 01:51:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x1dsL-0001Mj-Ug
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 01:51:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788328269;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=kcii3u8NNNZ27sC6GM1HE6/FlV/7po+Jts/QnPVEp8Y=;
 b=PyANc+LFocIylFl83IiS4DQf+BTxwCPNOciwjRcRReRJR6eEXvR9VvKJEUyYjJHhwCP+Wb
 tJQzIA8owp0HD5wKPtnwO6yLe6/cujgGz78eRXno3Blz60zPwUa9PPX+EzzT/C7YZfdL3Q
 MWISQDmjB65zCC00zNGNXwGZ8SVnkYM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-304-_7_ThT7zMH65UTgIvEwm3g-1; Wed, 02 Sept 2026 01:51:07 -0400
X-MC-Unique: _7_ThT7zMH65UTgIvEwm3g-1
X-Mimecast-MFC-AGG-ID: _7_ThT7zMH65UTgIvEwm3g_1788328267
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4994aebe932so5798475e9.3
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 22:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788328267; x=1788933067; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:references:cc:to:subject:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=kcii3u8NNNZ27sC6GM1HE6/FlV/7po+Jts/QnPVEp8Y=;
 b=rGKTJNHTUwoThqLeI0X5Z70S5vOZgtdWLb3ObpJyankwE/YGQ5DRE8iJNMrVyM9C7W
 NOYxRjqKwgh2ITbTfnyOY1i7moojZeglTYHtkWXptyXEUuZP0cUlK6Eyve5MTrhOv/W2
 dBfGq4xNteEGgGpeAUEa3dT9GBN3Q6//56DfZl5/9LwsSl+WhQhkAjYD3Xe9rODOaUdZ
 jNRKaYkY2lU8awsJ9Pz5rtenv7fVyCbxlWlIg6V6eaeRvK73edplLoUECeYzCzqhCbwm
 3C8YWxudyazkWQEfXyyV8Vss4A4X3OQIQiVURikv/3e1VXZdauk3Iyh+1yXToXIiwdxp
 fYDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788328267; x=1788933067;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:references:cc:to:subject:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=kcii3u8NNNZ27sC6GM1HE6/FlV/7po+Jts/QnPVEp8Y=;
 b=Y/Asm0KTVm0r3Iu8HxtJHnZp8lh5KL4PdgcuJO6XYCG/M7MgeZPFP/RSVvxWZrhTpL
 BebDYJ3dwbT2HyL0qvSURsyxGhRG09iKBf9VXlUfQYLjK7f0f56uGfWOcpvdvbwR8RtX
 OPJ9VYHY6YowvoB0Vi5F/Nq6Qvbz0XpDG94RDIPxzVL7n8IWa6bePGYKX4nVXFUglQjw
 hTrzBfBwNJ1mGCDJEeg7QnSRibl6L+rf16O4r/5l0S4qFdKcIpHi4P8kqq1h71R/1FLn
 p5NdUa5756UA4Tfl9gyf+owX8W2xRD5D+ngdiElrgRTFPkfcSp/P7vHJd9Ajhn0nDgrh
 2Njw==
X-Forwarded-Encrypted: i=1;
 AHgh+RohrXIBM+L+D3aeMbV1bf9huW3/cK6e5NFF1gKUCnWRSS3ffNhl8o7cb5mS55OmiSoQ4G3itG/YGN/c@nongnu.org
X-Gm-Message-State: AFuF++l3YMNV2OohkkalyKR0P6sfDK7papBFkstsvDkW1twu0tYrz+Hw
 ZbUdw1pSEmKel4DXKfQPYJ5Lv5dmoCY27wd2vCdk7kzKjHoTahx3xkD0FDg5iWSA+RfnScAReVN
 LjJWl7OX6+2rUfLw+omy5iioBh48AnbpwQQLDTdzG9HEootmkgDUMSfqW
X-Gm-Gg: AR+sD13aZPM84PWvcvbGp2M1QSBIJ/rvUxc/Z6hmJ/D8e51wB/TNO4TbhakutHoau3/
 /ZI2fa/+nI2W3RdoPBymzUAr63+vLlmhnIJBN6rw/KjnsNHVUnGq4GIvATimsFK5GLBEaPMx8Qq
 SR983FlwMVRmiouuuPbpEEXIvOHnZh2vwi31AK5Yj66PtrpXFiDUFAdgdL8tzdH2QOZe2e3KY5g
 KYLz6HPxkAvLPDbLuNXxUyf6KUeaSZrJcG8wcGYGX/3yo1rIgSNe7xvVCyyQxekPf9da+Pv2S2W
 R5lD6uIK3n8uxJU8LKNpSPOdPvUqcUFFLQvtCcPg3gtOKvAbJKxQyejCX03xGzbHkKtu0DQ5OZQ
 rMEq29rUXc3v2wENEM76T7CN878JgdB8Q+2eX694=
X-Received: by 2002:a05:600c:3e0a:b0:499:a277:e8b5 with SMTP id
 5b1f17b1804b1-49ce5810b5dmr48071425e9.3.1788328266701; 
 Tue, 01 Sep 2026 22:51:06 -0700 (PDT)
X-Received: by 2002:a05:600c:3e0a:b0:499:a277:e8b5 with SMTP id
 5b1f17b1804b1-49ce5810b5dmr48070895e9.3.1788328266250; 
 Tue, 01 Sep 2026 22:51:06 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:2cd2:7ace:8238:f7f4?
 ([2a01:e0a:280:24f0:2cd2:7ace:8238:f7f4])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48448e81718sm4063952f8f.16.2026.09.01.22.51.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Sep 2026 22:51:05 -0700 (PDT)
Message-ID: <50333c38-00f3-48de-9ec4-cf5a4da98e5a@redhat.com>
Date: Wed, 2 Sep 2026 07:51:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Subject: Re: [PATCH v2 17/25] tests/functional: give the set_machine probe VM
 the test workdir
To: Emmanuel Blot <emmanuel.blot@free.fr>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Jamin Lin
 <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 qemu-arm@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <th.huth+qemu@posteo.eu>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Emmanuel Blot <eblot@meta.com>
References: <20260731-sanmiguel-bmc-locator-v2-0-1266926ba769@free.fr>
 <20260731-sanmiguel-bmc-locator-v2-17-1266926ba769@free.fr>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260731-sanmiguel-bmc-locator-v2-17-1266926ba769@free.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 7/31/26 12:45, Emmanuel Blot wrote:
> set_machine() launches a throwaway QEMUMachine to query the available
> machine types, but constructs it without base_temp_dir, so it falls back
> to the hardcoded "/var/tmp" default instead of the writable per-test
> workdir that the actual test VM already uses. Pass base_temp_dir=
> self.workdir for consistency; this also fixes VM launch on hosts where
> /var/tmp is not writable.
> 
> Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
> ---
>   tests/functional/qemu_test/testcase.py | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/functional/qemu_test/testcase.py b/tests/functional/qemu_test/testcase.py
> index e4179d165c..ed861709e1 100644
> --- a/tests/functional/qemu_test/testcase.py
> +++ b/tests/functional/qemu_test/testcase.py
> @@ -317,7 +317,7 @@ def set_machine(self, machinename):
>           cls = type(self)
>   
>           if not hasattr(cls, "_machines"):
> -            tmp_vm = QEMUMachine(self.qemu_bin)
> +            tmp_vm = QEMUMachine(self.qemu_bin, base_temp_dir=self.workdir)
>               tmp_vm.set_machine('none')
>   
>               try:
> 

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


