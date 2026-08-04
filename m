Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB36DC5518F
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2026 10:47:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrCfa-0001TI-ST; Tue, 04 Aug 2026 06:46:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1wrCfZ-0001Sl-Bi
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 06:46:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1wrCfX-0007Gd-QA
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 06:46:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785840406;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oh8GXVHC+JPt5ZoIGK/cVqk909kbAfgYo5EeomlA70o=;
 b=PBzq3s3Fbmj+OV4CD+fuTtw4fziFqaEXPaqVOV3RkZYEYcUwUBh84Z4VYvUwk5LONRRqNC
 kO8KLYfj7y+X9ySLnIlJhjL9N+S0CTx4Im31e9c1UAiVwim+ZaQRK2+FBa1e1SvnuN3ddO
 6sVHkqLcb8rWrYnze+6axpr/0ZbNAQ4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-451-0U7HI4ysMB-G1nuqNJgdLw-1; Tue, 04 Aug 2026 06:46:45 -0400
X-MC-Unique: 0U7HI4ysMB-G1nuqNJgdLw-1
X-Mimecast-MFC-AGG-ID: 0U7HI4ysMB-G1nuqNJgdLw_1785840404
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-47f83450a8eso4348792f8f.0
 for <qemu-devel@nongnu.org>; Tue, 04 Aug 2026 03:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785840404; x=1786445204; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=oh8GXVHC+JPt5ZoIGK/cVqk909kbAfgYo5EeomlA70o=;
 b=K2675Q+PoKO9uw4LA4M4S/xddMckR01a9Zjh11GJNIiCSbNoQk4eEaUHoCxV6PGUlM
 DZuxeai1LPSOVxXQXsUNuG1y5uXyW9R2vyrA0oVYr68rRA0fleNopRU6A02Dpw06qvTg
 PoRKhCsWveUYJxxjSVFkCcs42Fp0vQbNEiVKtr0zZjIUS20FXptCUiK9rYAZjYsowzxr
 T8oFSvMKJPkF9J4gbiw7NOvAL4tMhVITn21zshFkZoPQCDXn1LzWvuVTZVxKRV5iPsO0
 L3leCbfq/Pmw3hZEkbpPEdBW0gHWyIYCqq3MeXN9r1Yo4ycvfRi85FOra+pLmQDugUkg
 pANg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785840404; x=1786445204;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oh8GXVHC+JPt5ZoIGK/cVqk909kbAfgYo5EeomlA70o=;
 b=OM3wvVuRtQOkeg9WVvL0wnInPMDHC8YVySFEUj/mgbqBvp7LS6Bq+ngJmdTSarv+++
 TqZ+O3y8io0FM+1HLJHTLp9mcW+CWdcNGJqSnTPLWZNisTK7K7d8/t1N05QMrLRhRNNP
 /J//kIZEr7FEwh5uy4EhAt7kt1f4yLAyTdrxUqFYI1d7v3mgEEtlBaYtV0v2a9bMOv1G
 WhZ5rz97vCYrlLrWyroh5nR1/9SiWwZmh1L2uIYRwdhOgU2tPa2+HEVbo43M9WP4O0ys
 m/w+R5O/y4xL6UZbSyYDgZbLdqSwMuzSNE0AYk//qdKrnINGVWSguGv4Poqozsv7Oq/M
 4Fqg==
X-Gm-Message-State: AOJu0YwlE81q35lKbrN/dHkZKflNy4kzxrfAwfQX0Du4XoBa2EVjxcFW
 2uun2hY2sUJ4dyCwGzDG1RTpKVmYDPdz7cTJE5e2es6kP4R6CZawXX+L14X/cov8gQi7a6PwW3b
 Y73G2veC4ZsCO+BV1uJ2fH3l7VW10DQvUoKpm1kXZgeWhvfn+xg+/nrpG
X-Gm-Gg: AR+sD11AhQ9Cch8WkrueL89pczCLpMru13xma918+Jv9+tzW51ALVf9t8puMsxPZf1u
 afiY6fOE/qGoJ9eZkw/TTODkKb5Y8GJWcdfeovVO+vVRMb1IX9/ceTNpW7q2TM2mHv4qs84TT0i
 dzFJVRveKNU7pS/2U+WnWFawzNShl42PAIpp9JHOAzJyvvb6LZn4mRpHGY+w9+QPbHyrzDOIJUA
 zODxj+TSN1UzU+mhHtN1hunzQMCtq0D1IDEjhmjYcXbwc0zYjn+ucAZaaHKt9m/a6vXn3u4veY7
 zrm+thujJHGAYWIcslhSrzhlIBaaKOmPms3aaMzgGNg9zRdDk0/ZFdmEsdKQSM+KDVIFQd0WhQk
 mA87Wp/KkBdJX7ABgdT1nR4urDbC/MoewSisbaETP075Lg4jwbRVXpqeAj3TPgd+VhDnMQooMbV
 xJ7hIvNe/nfX2jitoiBmJlMfqNCDJRsw==
X-Received: by 2002:a05:6000:c90:b0:47f:d0fb:ea40 with SMTP id
 ffacd0b85a97d-47fd72db353mr30198006f8f.21.1785840403891; 
 Tue, 04 Aug 2026 03:46:43 -0700 (PDT)
X-Received: by 2002:a05:6000:c90:b0:47f:d0fb:ea40 with SMTP id
 ffacd0b85a97d-47fd72db353mr30197933f8f.21.1785840403435; 
 Tue, 04 Aug 2026 03:46:43 -0700 (PDT)
Received: from ?IPV6:2003:cf:d73d:54bb:1189:33b6:6950:ef97?
 (p200300cfd73d54bb118933b66950ef97.dip0.t-ipconnect.de.
 [2003:cf:d73d:54bb:1189:33b6:6950:ef97])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fd4562667sm44648120f8f.24.2026.08.04.03.46.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Aug 2026 03:46:42 -0700 (PDT)
Message-ID: <95fe9d1a-dab1-477f-948f-4a42a1e3f09e@redhat.com>
Date: Tue, 4 Aug 2026 12:46:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 02/15] vhost-user: Add memory-isolation qdev property
 to vhost-user devices
To: Connor Kite <connorkite@gmail.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Raphael Norwitz <rnorwitz@nvidia.com>, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Stefan Hajnoczi <stefanha@redhat.com>, Milan Zamazal <mzamazal@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, qemu-block@nongnu.org,
 virtio-fs@lists.linux.dev, "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 zhenwei pi <zhenwei.pi@linux.dev>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Jason Wang <jasowangio@gmail.com>,
 Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Alyssa Ross <hi@alyssa.is>,
 Demi Marie Obenour <demiobenour@gmail.com>
References: <20260723-vhost-user-isolated-memory-v1-0-6b97c439eb28@gmail.com>
 <20260723-vhost-user-isolated-memory-v1-2-6b97c439eb28@gmail.com>
 <eb1d8424-206a-47f5-9ad5-a833a56bb3f3@redhat.com>
 <CA+spn3pLkHn_Wk+-xa-k2PKXdDSa-S9c1Dd94t=Kj5tajPyzSA@mail.gmail.com>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <CA+spn3pLkHn_Wk+-xa-k2PKXdDSa-S9c1Dd94t=Kj5tajPyzSA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.811,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
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

On 03.08.26 22:32, Connor Kite wrote:
> On Mon, Aug 3, 2026 at 5:21 AM Hanna Czenczek <hreitz@redhat.com> wrote:
>> Should `vhost_user_vga_inst_initfn()` set up an alias for
>> "memory-isolation", like it does for "chardev" now?
>>
> I am not 100% sure but I can test to see.  If an alias is needed, I suspect
> that would also apply to vhost-user-gpu-pci, right?

Right, that makes sense. (If your testing confirms that it’s needed.)

Hanna

>> There are four lines in here that the checkpatch script notes to be over
>> 80 characters in length, so they should be broken up.
>>
> Got it.  This will be fixed for the next rev.
>
>> [...]
>>
>>> diff --git a/hw/virtio/vhost-user-base.c b/hw/virtio/vhost-user-base.c
>>> index 90bd2903db..d2a74a2860 100644
>>> --- a/hw/virtio/vhost-user-base.c
>>> +++ b/hw/virtio/vhost-user-base.c
>>> @@ -409,7 +409,8 @@ static void vub_device_unrealize(DeviceState *dev)
>>>
>>>    /*Define common qdev properties.  Inherited by all children*/
>>>    static const Property vub_properties[] = {
>>> -    DEFINE_PROP_CHR("chardev", VHostUserBase, chardev)
>>> +    DEFINE_PROP_CHR("chardev", VHostUserBase, chardev),
>>> +    DEFINE_PROP_BOOL("memory-isolation", VHostUserBase, memory_isolation, false)
>> Nitpick: I would add a comma here. (This hunk shows specifically why
>> it’s a good idea: So that future additions don’t have to change the line
>> to add the comma.)
>>
> Ah, I was wondering why I was seeing so many hanging commas .  That makes sense.
> I will add the comma in.
>


