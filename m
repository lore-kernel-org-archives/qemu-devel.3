Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1363BCAC5B8
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 15:05:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4Kqe-0003Uv-7n; Thu, 02 Oct 2025 11:04:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v4KqP-0003TO-Vk
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 11:03:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v4KqB-0001k0-Mf
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 11:03:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759417401;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=nJAzn8laIOtbU7tfyO/6Kja1MEbrG7oagtEM63Qc1k8=;
 b=XwdzVfkizgDHcRIInFweSw6Idrl5VEJmR4XFLxpVKuajGtaeqKaRCSlMG995qMiUBDV1cX
 Q4BWX/52MTSrJ2S2dqQNsmKyg6jQUvebiCZGopu3eLPC74HaHWuzcAdUtb5KqUnD/w5+fu
 Ijakq1ixAXMfwR7kcAU8bG/DpMFpHAI=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-50-SYIXUfEdM1-X3i66QTHlmA-1; Thu, 02 Oct 2025 11:03:19 -0400
X-MC-Unique: SYIXUfEdM1-X3i66QTHlmA-1
X-Mimecast-MFC-AGG-ID: SYIXUfEdM1-X3i66QTHlmA_1759417398
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-63723f2c1e7so1305116a12.1
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 08:03:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759417398; x=1760022198;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nJAzn8laIOtbU7tfyO/6Kja1MEbrG7oagtEM63Qc1k8=;
 b=gxMUaB0dEDLbslnJbYXRLO/PzR+tT7+6uW8doCsFhYH81nmVo6gxAuon/ThCj+e4Gd
 ktPgBJP/KkI70h+jUGsLTDDUjHHY4g13fDn+di3mGpG42554PyIVMahf1YR+LE3qINqw
 o+UFyGGe4hLHfTl3S1JRXFUqxObLfpGoW+Pm7CXvD++Y6xF/FwY1PSfPX5554WGwZxjY
 WGXpKeluEGck7Z8StANSWszDFXF+0nbSqBjPED3+7jHgFW5Bk/9IpH5xEx81JWay6QNp
 0fq2XrxKWXmWhWIS9asv4VHCLoQwgE9dAyPL/SWjjGnJBsBGLAIbXCW7zsYC0FUJUTrC
 8fnQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVyNhEfRp8/Z8n+DAYeTeGQwTugdJNJvaC4RZCAw4LIPFhlqxcdQs75dsIuYDgm5A7ELQQ4dZ0A9iAP@nongnu.org
X-Gm-Message-State: AOJu0YyQ8IUgrdxv4OZ3o/HMLJN+im0z2GDb7KuuG7k5nzJZE5I2ng+U
 v8zkuy2a8hD3aWHF2EkWmIT9FzAwYZytVx59C1h8Idh9w+1mnsHMBFJHPsKg9a+6DHKTBts2hhk
 SCbm53U8dZAfhn9ieZIFiHdoBYNgDODxNRNt2HSRSxrTbLOUe5goie/rK
X-Gm-Gg: ASbGnctqlz2QfwndxZBEl6kACjdMQWCsBVBuA4cF115r7fp7tlMll762THER6mWFt57
 aRSfzA8nwuA1QEZMKENFT3eiRBzchB+UbBvAj36VIy9e5TbtV7q0JnNSpcOrUMsJ+e/yhiZBytX
 nwEVgwMfCEqxMJrN8Kk5VLV4XBdP8OsS/Dif8tSmyfELNfTmWQj5dA2FE0ATDeHgl7YSMxEh7NO
 T4C3YGwE32xO8n6tWARcZ17Hl6rY9ezoU0MQGO6yvlIQtzTWyWhs4mUevbJ2lRnV8NuGw79Lq+G
 JqeErflTqttlZo2BJljqHTBiVb9zkSlJsxfSooB68Tr9kVCF/CkNgG8+Jrn5OFWVD1NVJhryDU+
 uCc7yL2oZ83YNecJblFfo8FAImqlsi8nJewDogP1WC876fV++
X-Received: by 2002:a05:6402:188:b0:631:bb4e:111a with SMTP id
 4fb4d7f45d1cf-63678e33e1cmr6362572a12.34.1759417398161; 
 Thu, 02 Oct 2025 08:03:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE8yChBem4ToAR5xOq3yFLBKzR6IYasvD1adc6igbrCIFolknx9xaI9rLITZmmMeVvWEASHHg==
X-Received: by 2002:a05:6402:188:b0:631:bb4e:111a with SMTP id
 4fb4d7f45d1cf-63678e33e1cmr6362453a12.34.1759417396663; 
 Thu, 02 Oct 2025 08:03:16 -0700 (PDT)
Received: from [192.168.10.27] ([151.49.91.106])
 by smtp.googlemail.com with ESMTPSA id
 4fb4d7f45d1cf-63788111f1fsm2064741a12.36.2025.10.02.08.03.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Oct 2025 08:03:15 -0700 (PDT)
Message-ID: <4664fcb7-c747-42dd-966f-6f282abece89@redhat.com>
Date: Thu, 2 Oct 2025 17:03:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/14] Fix memory region use-after-finalization
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-block@nongnu.org, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Yanan Wang <wangyanan55@huawei.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Fabiano Rosas <farosas@suse.de>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>, Aleksandar Rikalo
 <arikalo@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
References: <20250917-subregion-v1-0-bef37d9b4f73@rsg.ci.i.u-tokyo.ac.jp>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20250917-subregion-v1-0-bef37d9b4f73@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 9/17/25 12:32, Akihiko Odaki wrote:
> Based-on: <20250917-use-v3-0-72c2a6887c6c@rsg.ci.i.u-tokyo.ac.jp>
> ("[PATCH v3 0/7] Do not unparent in instance_finalize()")
> 
> This patch series was spun off from "[PATCH v2 00/15] Fix memory region
> leaks and use-after-finalization":
> https://lore.kernel.org/qemu-devel/20250915-use-v2-0-f4c7ff13bfe9@rsg.ci.i.u-tokyo.ac.jp/
> 
> When developing the next version of "[PATCH 00/16] memory: Stop
> piggybacking on memory region owners*", I faced multiple memory region
> leaks and use-after-finalization. This series extracts their fixes so
> that the number of Cc: won't explode.
> 
> Patch "qdev: Automatically delete memory subregions" and the succeeding
> patches are for refactoring, but patch "vfio-user: Do not delete the
> subregion" does fix use-after-finalization.
> 
> * https://lore.kernel.org/qemu-devel/20250901-mr-v1-0-dd7cb6b1480b@rsg.ci.i.u-tokyo.ac.jp/
> 
> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

This makes sense, but I think it is not bisectable, because of this in 
memory_region_del_subregion():

     assert(subregion->container == mr);
     subregion->container = NULL;

You would need to add a temporary

     if (subregion->container == NULL) {
         return;
     }

and undo it at the end of the series.  Do you agree?  With this change I 
can apply it.

Paolo


