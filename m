Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9840BCD13CF
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2024 06:23:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sl0SW-0006nI-VZ; Mon, 02 Sep 2024 02:22:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1sl0SV-0006m4-Bq
 for qemu-devel@nongnu.org; Mon, 02 Sep 2024 02:22:39 -0400
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1sl0ST-00070M-Dk
 for qemu-devel@nongnu.org; Mon, 02 Sep 2024 02:22:39 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1725258139; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=TePEa0P7G2pjWdPt0NMz2Uee9esm1MFKD/UIoO2QlKNS0uAs/bON0QEeF9aD7FVYtCYX0jfefAvF8OXkcoST6G5MOSYgtBIkDHfzEf216cfD2Co4dPvc4Fxtjq2BFtVZjtNtheWXKffqHl1sbi+PqlVNrIS0UBjSyFh2RuulYdg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1725258139;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=joYRKdS54q0QEN7+3BvYq4JVGUGBeLL0HCoUP7fAlTY=; 
 b=BYilVkg6v6kttZYd93S50wEuBzHeeCSWKBUbv+Yb7BHIxpyvV4qyLEmhlEbjaK+M35YFa0FN/1ri4kCwDqC4jOjJQHCoa/LQqlOwpwdrjreb6Gqf+t0NbwMjvPN4YGjygH2yQqbyP7bv/0JM6Pz7mi6k+m5F18i9Cx32H8u1BZE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1725258139; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=joYRKdS54q0QEN7+3BvYq4JVGUGBeLL0HCoUP7fAlTY=;
 b=XT6yGloyPPcDxp4J84/+93kJniV5c/uWilsBgARKss/3XYh7Jqdu+s7q9nnKimab
 t/C7oelwjDplEtEqVSfSZR1mD48hx/HVzfCmx9MkqF+A3oZT+GsQFptCSGxphQUxOsD
 TaNv+fd81akAd8zFl1VuPwO4p/Qyx1ntk1FxSSaU=
Received: by mx.zohomail.com with SMTPS id 172525813733165.78968888287909;
 Sun, 1 Sep 2024 23:22:17 -0700 (PDT)
Message-ID: <a7298ca2-b86b-4d27-a86f-37262fca855a@collabora.com>
Date: Mon, 2 Sep 2024 09:22:10 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 00/13] Support blob memory and venus on qemu
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>, Huang Rui <ray.huang@amd.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Antonio Caggiano <quic_acaggian@quicinc.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Robert Beckett <bob.beckett@collabora.com>,
 Gert Wollny <gert.wollny@collabora.com>, qemu-devel@nongnu.org,
 Gurchetan Singh <gurchetansingh@chromium.org>, ernunes@redhat.com,
 Alyssa Ross <hi@alyssa.is>, =?UTF-8?Q?Roger_Pau_Monn=C3=A9?=
 <roger.pau@citrix.com>, Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Julia Zhang <julia.zhang@amd.com>,
 Chen Jiqian <Jiqian.Chen@amd.com>, Yiwei Zhang <zzyiwei@chromium.org>
References: <20240822185110.1757429-1-dmitry.osipenko@collabora.com>
 <87ttf6cmq2.fsf@draig.linaro.org>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <87ttf6cmq2.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.112;
 envelope-from=dmitry.osipenko@collabora.com; helo=sender4-pp-f112.zoho.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 8/27/24 12:57, Alex Bennée wrote:
> Dmitry Osipenko <dmitry.osipenko@collabora.com> writes:
> 
>> Hello,
>>
>> This series enables Vulkan Venus context support on virtio-gpu.
>>
>> All virglrender and almost all Linux kernel prerequisite changes
>> needed by Venus are already in upstream. For kernel there is a pending
>> KVM patchset that fixes mapping of compound pages needed for DRM drivers
>> using TTM or huge pages [1], othewrwise hostmem blob mapping will fail
>> with a KVM error from Qemu.
>>
>> [1] https://lore.kernel.org/all/20240726235234.228822-1-seanjc@google.com/
>>
>> On guest you'll need to use recent Mesa 24.2+ version containing patch
>> that removes dependency on cross-device feature from Venus that isn't
>> supported by Qemu [2].
>>
>> [2]
>> https://gitlab.freedesktop.org/mesa/mesa/-/commit/087e9a96d13155e26987befae78b6ccbb7ae242b
> 
> I've expanded the set of working tests so:
> 
> x86 host, Intel GPU
> 
>  x86/kvm Trixie guest + latest mesa - works
>  aarch64/tcg buildroot guest - works
> 
> Aarch64 host, AMD GPU
> 
>  x86/tcg Trixies guest + latest mesa - works
>  aarch64/kvm buildroot guest - works
> 
> As the Aarch64 HW I'm testing on (AVA Devbox) needs additional patches
> on top of Sean's series to deal with the busted Altra PCI which I
> provide here:
> 
>  https://git.linaro.org/people/alex.bennee/linux.git/log/?h=review/pfn-references-v12-with-altra-tweaks
> 
> Anyway I'll re-state:
> 
>   Tested-by: Alex Bennée <alex.bennee@linaro.org>
> 
> And I think this series is ready to merge once the tree re-opens.

Thanks for the update, nice to see that you nailed the ARM problem

-- 
Best regards,
Dmitry


